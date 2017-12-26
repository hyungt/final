package com.ese.mappers.servicecenter;

import java.util.List;

import com.ese.vo.afterservice.Center;

public interface CenterMapper {

	List<Center> getCenterList();
	Center getCenter(String id);
	List<Center> getCenterByLocale(String localeCity);
	
}
