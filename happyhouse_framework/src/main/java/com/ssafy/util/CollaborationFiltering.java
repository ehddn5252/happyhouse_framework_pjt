package com.ssafy.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Iterator;

public class CollaborationFiltering {
	

	/**
	 *  피어슨 유사도를 측정한다.
	 *  먼저 데이터셋의 형태는 map의 String에 ArrayList가 있고 ArrayList에는 column들이 있고 column 안에는 숫자가 있다.
	 * @param dataset
	 * @param person1
	 * @param person2
	 * @return
	 */
	
	public float personCorrelation(Map<String, ArrayList<ArrayList<Float>>>dataset, String person1, String person2) {
		
		Map<ArrayList<Integer>,Integer> both_viewed = new HashMap<ArrayList<Integer>,Integer>();

		for(ArrayList<Float> item: dataset.get(person1)) {
			
		}
		
		return 0;
	}
	
	/**
	 * 유사도가 가장 높은 
	 * 
	 * @param dataset
	 * @param person
	 * @param numberOfUsers
	 * @return
	 */
	
	public ArrayList<Integer> mostSimilarUsers(Map<String, List>dataset, String person, int numberOfUsers){
		
		
		return null;
		
	}
	
	public ArrayList<Integer> userRecommendations(Map<String, List> dataset, String person){
		
		return null;
	}


	
}
