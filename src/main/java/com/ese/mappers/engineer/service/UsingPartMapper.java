package com.ese.mappers.engineer.service;

import java.util.List;

import com.ese.vo.afterservice.UsingPart;

public interface UsingPartMapper {

	void addUsingParts(UsingPart usingPart);
	List<UsingPart> getUsingPartsByResultNo(int resultNo);
	
}
