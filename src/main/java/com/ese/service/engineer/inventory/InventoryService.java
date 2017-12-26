package com.ese.service.engineer.inventory;

import java.util.List;

import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.part.Part;

public interface InventoryService {

	List<Category> getCategoryList();
	List<Division> getDivisionList(String categoryId);
	Part getPartDetail(Integer partNo);
}
