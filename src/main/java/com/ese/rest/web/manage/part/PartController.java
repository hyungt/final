package com.ese.rest.web.manage.part;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ese.service.manage.part.PartService;
import com.ese.vo.Division;
import com.ese.vo.common.PartCriteria;
import com.ese.vo.part.Part;
import com.ese.vo.product.Product;



@RestController
public class PartController {

	@Autowired
	PartService partService;
	
	@GetMapping("/divs/{categoryId}")
	public List<Division> getDivisions(@PathVariable("categoryId") String categoryId){
		return partService.getDivisions(categoryId);
	}
	
	@GetMapping("/parts/{divisionId}/{categoryId}")
	public List<Part> getParts(@PathVariable("divisionId") String divisionId, @PathVariable("categoryId") String categoryId){		
		List<Part> parts = partService.getSelectedParts(divisionId, categoryId);
		
		return parts;
	}
	
	@GetMapping("/parts/{categoryId}")
	public List<Part> getCatParts(@PathVariable("categoryId") String categoryId){
		return partService.getSelectedParts(categoryId);
	}

	
	@GetMapping("/getparts")
	public Map<String, Object> getDivParts(PartCriteria criteria){
		int totalRows = partService.getTotalRows(criteria);
		criteria.setTotalRows(totalRows);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("navi", criteria);
		map.put("parts", partService.getPagingParts(criteria));
		
		return map;
	}
	
	@GetMapping("/getexpendable")
	public Map<String, Object> getExpendable(PartCriteria criteria){
		int totalRows = partService.getExpendableRows(criteria);
		criteria.setTotalRows(totalRows);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("navi", criteria);
		map.put("parts", partService.getExpendableParts(criteria));
		map.put("cat", criteria.getCategoryId());
		
		return map;
	}
	
	@GetMapping("/part/{partNo}")
	public Part getPartByNo(@PathVariable("partNo") int partNo) {
		return partService.getPartByNo(partNo);
	}
	
	@GetMapping("/product/{divId}")
	public List<Product> getProducts(@PathVariable("divId")String divId){
		return partService.getProducts(divId);
	}

	@GetMapping("/partModify/{partNo}")
	public Map<String, Object> modifyPartByNo(@PathVariable("partNo") int partNo) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("part", partService.modifyPartByNo(partNo));
		map.put("partUsingModels", partService.getPartUsingModels(partNo));
		
		return map;
		
	}
	
	@PutMapping("/modifypart/{categoryId}/{divisionId}/{partNo}/{increasePart}")
	public Map<String, Object> updatePart(@PathVariable("categoryId") String categoryId, @PathVariable("divisionId") String divisionId, @PathVariable("partNo") int partNo, @PathVariable("increasePart") int increasePart) {
		PartCriteria criteria = new PartCriteria();
		criteria.setCategoryId(categoryId);
		criteria.setDivisionId(divisionId);
		int totalRows = partService.getTotalRows(criteria);
		criteria.setTotalRows(totalRows);
		criteria.setPageNo(1);
		partService.updatePart(partNo, increasePart);
		System.out.println(criteria);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("navi", criteria);
		map.put("parts", partService.getPagingParts(criteria));
		return map;
	}
	
}
