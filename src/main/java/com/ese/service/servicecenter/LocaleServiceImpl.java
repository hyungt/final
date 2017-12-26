package com.ese.service.servicecenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.servicecenter.LocaleMapper;
import com.ese.vo.afterservice.City;
import com.ese.vo.afterservice.Locale;

@Service
public class LocaleServiceImpl implements LocaleService {

	@Autowired
	private LocaleMapper localeMapper;
	
	@Override
	public List<Locale> getAllLocale() {
		return localeMapper.getAllLocale();
	}

	@Override
	public List<City> getCitysByLocaleId(String id) {
		return localeMapper.getCitysByLocaleId(id);
	}

}
