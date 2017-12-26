package com.ese.service.engineer.inventory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.part.CategoryMapper;
import com.ese.mappers.manage.part.DivisionMapper;
import com.ese.mappers.manage.part.PartMapper;
import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.part.Part;

@Service
public class InventoryServiceImpl implements InventoryService {

	@Autowired
	CategoryMapper categoryMapper;
	@Autowired
	DivisionMapper divisionMapper;
	@Autowired
	PartMapper partMapper;
	
	@Override
	public List<Category> getCategoryList() {
		return categoryMapper.getCategory();
	}

	@Override
	public List<Division> getDivisionList(String categoryId) {
		return divisionMapper.getDivisions(categoryId);
	}
	
	@Override
	public Part getPartDetail(Integer partNo) {
		return partMapper.getPartByNo(partNo);
	}

}
