package com.ssafy.happyhouse.model.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.mapper.HouseMapMapper;

import com.ssafy.util.Calculate;

@Service
public class HouseMapServiceImpl implements HouseMapService {

	@Autowired
	private HouseMapMapper houseMapMapper;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return houseMapMapper.getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return houseMapMapper.getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return houseMapMapper.getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return houseMapMapper.getAptInDong(dong);
	}

	@Override
	public List<HouseInfoDto> getAptInName(String aptName, String dong) throws Exception {
		return houseMapMapper.getAptInName(aptName, dong);
	}
	
//	------민지 추가 ----------
	@Override
	public List<HouseInfoDto> getDongList(String gugun) throws SQLException {
		
		return houseMapMapper.getDongList(gugun);
	}

	@Override
	public List<HouseInfoDto> getLngLat(String dongName) throws SQLException {
		// TODO Auto-generated method stub
		return houseMapMapper.getLngLat(dongName);
	}
	
//	------------------------
	
	

	
	@Override
	public List<HouseInfoDto> getRecommendList(String dong, String price_, String buildYear_) throws Exception {
		List<HouseInfoDto> h = houseMapMapper.getAptInDong(dong);
		List<HouseInfoDto> h2 = new ArrayList<HouseInfoDto>();
		int sumPrice=0; 
		int sumBuildYear = 0;
		ArrayList<Float> uList = new ArrayList<Float>();
		String inputPrice = price_.replace(",", "");
		uList.add(Float.parseFloat(buildYear_)*10000);
		uList.add(Float.parseFloat(inputPrice));
		
		
		// 데이터 일반화를 위해 price와 buildyear 최대 최소 구하기
		
		for(int i=0;i<h.size();++i) {
			int buildYear = h.get(i).getBuildYear(); 
			int recentPrice = Integer.parseInt(h.get(i).getRecentPrice().replace(",","").replace(" ", ""));

			sumPrice+=recentPrice;
			sumBuildYear+=buildYear; 
		}
		float avgPrice = sumPrice / h.size();
		float avgBuildYear = sumBuildYear / h.size();
		
		ArrayList<Float> rAvgList = new ArrayList<Float>();
		rAvgList .add(avgPrice);
		rAvgList .add(avgBuildYear);

		ArrayList<Float> uAvgList = new ArrayList<Float>();
		uAvgList .add(avgPrice);
		uAvgList .add(avgBuildYear);

		// setting
		List<TmpDto> tmp_t_l = new ArrayList<TmpDto>();
		for(int i=0;i<h.size();++i) {
			TmpDto tmp_dto = new TmpDto();
			tmp_dto.aptCode= h.get(i).getAptCode(); 
			tmp_dto.aptName = h.get(i).getAptName();
			tmp_dto.buildYear = h.get(i).getBuildYear(); 
			tmp_dto.recentPrice = h.get(i).getRecentPrice(); 
			tmp_dto.sidoName= h.get(i).getSidoName();
			tmp_dto.dongName = h.get(i).getDongName();
			tmp_dto.gugunName = h.get(i).getGugunName();
			tmp_dto.jibun = h.get(i).getJibun();
			tmp_dto.lat = h.get(i).getLat();
			tmp_dto.lng = h.get(i).getLng();
			ArrayList<Float> rList = new ArrayList<Float>();
			rList.add((float)h.get(i).getBuildYear()*10000);
			rList.add(Float.parseFloat(h.get(i).getRecentPrice().replace(",", "")));

//			tmp_dto.pearson_similarity = Calculate.personCorrelation(rList, rAvgList, uList, uAvgList);
			tmp_dto.euclideanDistance = Calculate.euclideanDistance(rList, uList);
			
			tmp_t_l.add(tmp_dto);
//			float generalizedPrice = Calculate.generalization(recentPrice, maxPrice, minPrice);
//			float generalizedBuildYear = Calculate.generalization(buildYear, maxBuildYear, minBuildYear);			
			}
		Collections.sort(tmp_t_l);
		
		// top 5까지 가져온다.
		int size = 0;
		if (tmp_t_l.size() > 5) size = 5;
		else size = tmp_t_l.size();
		for (int i = 0; i < size; ++i) h2.add(tmp_t_l.get(i).convertTypeToHouseInfo());
		/*
		 * 1. 가격과 구축년도 데이터를 일단 숫자로 바꾼다음 max값을 가져온다. 2. max 값에서
		 */
		return h2;
	}

	static class TmpDto implements Comparable<TmpDto>{
		
		int aptCode;
		String aptName;
		String sidoName;
		String gugunName;
		String dongName;
		String jibun;
		String recentPrice;
		int buildYear;
		float pearson_similarity;
		float euclideanDistance;
		String lat;
		String lng;
		
		public TmpDto() {
			super();
		}

		public HouseInfoDto convertTypeToHouseInfo() {
			HouseInfoDto houseInfoDto = new HouseInfoDto();
			houseInfoDto.setAptCode(aptCode);
			houseInfoDto.setAptName(aptName);
			houseInfoDto.setSidoName(sidoName);
			houseInfoDto.setGugunName(gugunName);
			houseInfoDto.setDongName(dongName);
			houseInfoDto.setJibun(jibun);
			houseInfoDto.setRecentPrice(recentPrice);
			houseInfoDto.setBuildYear(buildYear);
			houseInfoDto.setLat(lat);
			houseInfoDto.setLng(lng);
			
			return houseInfoDto;
		}
		
		@Override
		public int compareTo(TmpDto o) {
			
			if(o.pearson_similarity==0 && pearson_similarity==0) {
				// 유클리디안 거리는 작을수록 가까움
				if(euclideanDistance<o.euclideanDistance) {
					return -1;
				}
				else if(euclideanDistance>o.euclideanDistance) {
					return 1;
				}
				else {
					return 0;
				}
			}
			
			else {
				// TODO Auto-generated method stub
				if(pearson_similarity<o.pearson_similarity) {
					return 1;
				}
				else if(pearson_similarity==o.pearson_similarity) {
					return 0;
				}
				else {
					return -1;
				}
			}
		}
	}
}
