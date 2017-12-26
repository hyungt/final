package com.ese.service.manage.part;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.part.CategoryMapper;
import com.ese.mappers.manage.part.DivisionMapper;
import com.ese.mappers.manage.part.InventoryChangeMapper;
import com.ese.mappers.manage.part.PartMapper;
import com.ese.mappers.manage.part.PartUsingModelMapper;
import com.ese.mappers.manage.part.ProductMapper;
import com.ese.mappers.manage.part.StatusMapper;
import com.ese.mappers.manage.pay.PayChangeMapper;
import com.ese.mappers.servicecenter.order.OrderMapper;
import com.ese.vo.Category;
import com.ese.vo.Division;
import com.ese.vo.common.PartCriteria;
import com.ese.vo.order.Order;
import com.ese.vo.part.InventoryChange;
import com.ese.vo.part.Part;
import com.ese.vo.part.PartStatus;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;
import com.ese.vo.product.PartUsingModel;
import com.ese.vo.product.Product;


@Service
public class PartServiceImpl implements PartService{

	@Autowired
	PartMapper partMapper;
	
	@Autowired
	CategoryMapper categoryMapper;
	
	@Autowired
	DivisionMapper divisionMapper;
	
	@Autowired
	StatusMapper statusMapper;
	
	@Autowired
	InventoryChangeMapper inventoryChangeMapper;
	
	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	PartUsingModelMapper partUsingModelMapper;
	
	@Autowired
	PayChangeMapper payChangeMapper;
	
	@Autowired
	OrderMapper orderMapper;
	
	@Override
	public List<Part> getSelectedParts(String categoryId) {
		Category category = new Category();
		Division division = new Division();
		category.setId(categoryId);
		division.setId("0");
		division.setCategory(category);
		return partMapper.getParts(division);
	}
	
	@Override
	public List<Part> getSelectedParts(String divisionId, String categoryId) {
		Category category = new Category();
		Division division = new Division();
		
		category.setId(categoryId);
		
		division.setId(divisionId);
		division.setCategory(category);
		return partMapper.getParts(division);
	}
	
	@Override
	public List<Division> getDivisions(String categoryId) {
		return divisionMapper.getDivisions(categoryId);
	}
	
	@Override
	public List<Category> getCategory() {
		return categoryMapper.getCategory();
	}
	
	@Override
	public Part getPartByNo(int partNo) {
		
		return partMapper.getPartByNo(partNo);
	}
	
	@Override
	public void updatePart(int partNo, int increasePart) {
		Part part =  partMapper.getPartByNo(partNo);
		InventoryChange change = new InventoryChange();
		PayChange payChange = new PayChange();		
		PayChangeType changeType = new PayChangeType();
		
		change.setPart(part);
		change.setQty(increasePart);
		
		int totalQty = part.getQty()+increasePart;
		long totalcost = (part.getCost() * increasePart); 
		
		changeType.setId("PC-INVEN-RECEIVE");
		
		payChange.setMoney(totalcost);
		payChange.setType("지출");
		payChange.setChangeType(changeType);
		
		part.setQty(totalQty);
		
		payChangeMapper.addPayChange(payChange);
		inventoryChangeMapper.changeInventory(change);
		partMapper.updatePart(part);
	}
	
	@Override
	public List<Part> getAllParts() {
		return partMapper.getAllParts();
	}
	
	@Override
	public void addPart(Part part) {
		PayChange payChange = new PayChange();
		PayChangeType changeType = new PayChangeType();
		long totalcost = (part.getQty() * part.getCost());
		
		changeType.setId("PC-INVEN-RECEIVE");
		
		payChange.setType("지출");
		payChange.setMoney(totalcost);
		payChange.setChangeType(changeType);
		
		payChangeMapper.addPayChange(payChange);
		partMapper.addPart(part);
	}
	
	@Override
	public int getPartSeq() {
		return partMapper.getPartSeq();
	}
	
	@Override
	public List<PartStatus> getAllStatus() {
		return statusMapper.getAllStatus();
	}
	
	@Override
	public Part modifyPartByNo(int partNo) {
		Part part = partMapper.getPartByNo(partNo);
		String divId = part.getDivision().getId();
		Division division = divisionMapper.getDivisionById(divId);
		part.setDivision(division);
		return part;
	}
	
	@Override
	public void updatePart(Part part) {
		partMapper.updatePart(part);
	}
	
	@Override
	public List<Product> getProducts(String divisionId) {
		return productMapper.getProducts(divisionId);
	}
	
	@Override
	public void addPartUsingModel(PartUsingModel partUsingModel) {
		partUsingModelMapper.addPartUsingModel(partUsingModel);
	}
	@Override
	public int getTotalRows(PartCriteria criteria) {
		return partMapper.getTotalRows(criteria);
	}
	
	@Override
	public int getExpendableRows(PartCriteria criteria) {
		return partMapper.getExpendableRows(criteria);
	}
	
	@Override
	public List<Part> getPagingParts(PartCriteria criteria) {
		return partMapper.getPagingParts(criteria);
	}
	
	@Override
	public List<Part> getExpendableParts(PartCriteria criteria) {
		return partMapper.getExpendableParts(criteria);
	}
	
	@Override
	public List<PartUsingModel> getPartUsingModels(int partNo) {
		return partUsingModelMapper.getPartUsingModels(partNo);
	}
	
	@Override
	public void delPartUsingModel(int partNo) {
		partUsingModelMapper.delPartUsingModel(partNo);	
	}
	
	@Override
	public void cancelDelivery(Order order) {
		Part part = partMapper.getPartByNo(order.getPart().getNo());

		InventoryChange inventoryChange = new InventoryChange();
		int changedQty = part.getQty()+order.getCount();
		
		int totalPrice = (int) (order.getCount() * part.getPrice());
		
		order.setPurchase(totalPrice);
		
		part.setQty(changedQty);
		
		partMapper.updatePart(part);
		
		int changeQty = order.getCount();
		
		inventoryChange.setPart(part);
		inventoryChange.setQty(changeQty);
		inventoryChangeMapper.changeInventory(inventoryChange);
		
		orderMapper.addOrder(order);
	}
}
