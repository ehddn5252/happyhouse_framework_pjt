package com.ssafy.happyhouse.model;

public class LatLngParamDto {
	
	private String lat;
	private String lng;
	private String distance;

	
	public LatLngParamDto() {
	}

	public LatLngParamDto(String lat, String lng) {
		super();
		this.lat = lat;
		this.lng = lng;
	}
	
	public LatLngParamDto(String lat, String lng, String distance) {
		super();
		this.lat = lat;
		this.lng = lng;
		this.distance = distance;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}

	@Override
	public String toString() {
		return "LatLngParamDto [lat=" + lat + ", lng=" + lng + ", distance=" + distance + "]";
	}
	
	
}
