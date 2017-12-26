package com.ese.mappers.manage.part;

import java.util.List;

import com.ese.vo.Division;

public interface DivisionMapper {

	List<Division> getDivisions(String categoryId);
	Division getDivisionById(String divisionId);
}
