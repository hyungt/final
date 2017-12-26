package com.ese.service.servicecenter;

import java.util.List;

import com.ese.vo.afterservice.City;
import com.ese.vo.afterservice.Locale;

public interface LocaleService {

	List<Locale> getAllLocale();
	List<City> getCitysByLocaleId(String id);
	
}
