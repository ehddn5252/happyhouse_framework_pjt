package com.ssafy.happyhouse.model;


public class StoreParamDto {
	
	private String regionCode;
	private String[] codeList;
	
	public StoreParamDto(String regionCode) {
		this(regionCode, null);
	}

	public StoreParamDto(String regionCode, String[] codeList) {
		super();
		this.regionCode = regionCode;
		this.codeList = codeList;
	}
	
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String[] getCodeList() {
		return codeList;
	}
	public void setCodeList(String[] codeList) {
		this.codeList = codeList;
	}
	
	
}
