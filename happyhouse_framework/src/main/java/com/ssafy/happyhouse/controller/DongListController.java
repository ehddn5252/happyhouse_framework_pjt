package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseMapService;








// CrossOrigin("localhost:8080") 은 해당 사용자만 사용할 수 있게 한다.
@RestController
@RequestMapping("/apart/map/apt")
@CrossOrigin("*")
public class DongListController {

	private final Logger logger = LoggerFactory.getLogger(DongListController.class);

	@Autowired
	private HouseMapService haHouseMapService;

	@GetMapping("/avg")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception {
		List<HouseInfoDto> ddata = haHouseMapService.getDongList(gugun);
		System.out.println("***********   " + ddata);
		HashMap<String, Integer> dongL = new HashMap<String, Integer>();
		HashMap<String, Integer> num = new HashMap<String, Integer>();
		String lat = "";
		String lng=  "";
		
		
		List<HouseInfoDto> list = new ArrayList<HouseInfoDto>();

		for (HouseInfoDto ddong : ddata) {
			
			if(ddong.getRecentPrice()==null) continue;
			
			String name = ddong.getDongName();
			Integer price = Integer.parseInt(ddong.getRecentPrice().replaceAll("[^0-9]", ""));
			
			if (dongL.get(name) != null) {

				dongL.put(name, dongL.get(name) + price);
				num.put(name, num.get(name) + 1);
				
				
			} else {
				dongL.put(name, price);
				num.put(name, 1);
				
			
			}
		}
		
			
		
		
		for (Entry<String, Integer> entrySet : dongL.entrySet()) {
			System.out.println("$$$$$$$ "+ entrySet.getKey());
			List<HouseInfoDto> lnglat = haHouseMapService.getLngLat(entrySet.getKey());
			
			for (HouseInfoDto ll : lnglat){
				lat = ll.getLat();
				lng = ll.getLng();
				
			}
			
			
			
//			System.out.println("$$$$$$ "+ lnglat);
			
			HouseInfoDto info = new HouseInfoDto();
			info.setRecentPrice(String.valueOf(entrySet.getValue() / num.get(entrySet.getKey())));
			info.setDongName(entrySet.getKey());
			info.setLat(lat);
			info.setLng(lng);
			
			list.add(info);

			

		}

		return new ResponseEntity<List<HouseInfoDto>>(list, HttpStatus.OK);

	}

}
