package com.ese.service.manage.part;

import java.util.List;

import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.common.PartCriteria;
import com.ese.vo.order.Order;
import com.ese.vo.part.Part;
import com.ese.vo.part.PartStatus;
import com.ese.vo.product.PartUsingModel;
import com.ese.vo.product.Product;

public interface PartService {

	List<Part> getSelectedParts(String categoryId);
	List<Part> getSelectedParts(String divisionId, String categoryId);
	List<Division> getDivisions(String categoryId);
	List<Category> getCategory();
	Part getPartByNo(int partNo);
	void updatePart(int partNo, int increasePart);
	void updatePart(Part part);
	List<Part> getAllParts();
	void addPart(Part part);
	List<PartStatus> getAllStatus();
	Part modifyPartByNo(int partNo);
	List<PartUsingModel> getPartUsingModels(int partNo);
	void delPartUsingModel(int partNo);
	void cancelDelivery(Order order);
	List<Product> getProducts(String divisionId);
	void addPartUsingModel(PartUsingModel partUsingModel);
	int getPartSeq();
	int getTotalRows(PartCriteria criteria);
	int getExpendableRows(PartCriteria criteria);
	List<Part> getPagingParts(PartCriteria criteria);
	List<Part> getExpendableParts(PartCriteria criteria);
}
