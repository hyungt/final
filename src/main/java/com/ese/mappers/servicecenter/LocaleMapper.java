package com.ese.mappers.servicecenter;

import java.util.List;

import com.ese.vo.afterservice.City;
import com.ese.vo.afterservice.Locale;

public interface LocaleMapper {

	List<Locale> getAllLocale();
	List<City> getCitysByLocaleId(String id);
	
	Locale getLocaleById(String id);
	City getCityById(String id);
	
}
