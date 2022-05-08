package com.ssafy.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Calculate {
	
	/**
	 *  피어슨 유사도를 측정한다.
	 *  먼저 데이터셋의 형태는 map의 String에 ArrayList가 있고 ArrayList에는 column들이 있고 column 안에는 숫자가 있다.
	 * @param dataset
	 * @param person1
	 * @param person2
	 * @return
	 */
	
	static public float personCorrelation(ArrayList<Float> rList, ArrayList<Float> rAvgList, ArrayList<Float> uList, ArrayList<Float> uAvgList) {
		float ret = 0;
		float numerator1=0;
		float numerator2=0;
		float denominator1=0;
		float denominator2=0;
		for(int i=0;i<rList.size();++i) {
			numerator1+=(rList.get(i)-rAvgList.get(i))*(uList.get(i)-uAvgList.get(i));
			denominator1 += Math.pow(rList.get(i)-rAvgList.get(i), 2);
			denominator2 += Math.pow(uList.get(i)-uAvgList.get(i), 2);
		}
		if(denominator1+denominator2!=0) ret = (float) (numerator1/Math.sqrt(denominator1+denominator2));
		else ret=1;
		return ret;
	}

	static public float euclideanDistance(ArrayList<Float> rList, ArrayList<Float> uList) {
		float ret=0;
		for(int i=0;i<rList.size();++i){
			ret+=Math.pow(rList.get(i)-uList.get(i), 2);
		}
		return (float)Math.sqrt(ret);
			
	}
	
	static public float generalization(float x,float xMax,float xMin) {
		return (x-xMin)/(xMax-xMin);
	}

}
