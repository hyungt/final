package com.ese.mappers.manage.part;

import java.util.List;

import com.ese.vo.Division;
import com.ese.vo.common.ServiceCriteria;
import com.ese.vo.common.PartCriteria;
import com.ese.vo.part.Part;



public interface PartMapper {

	List<Part> getParts(Division division);
	List<Part> getPartsByCriteria(ServiceCriteria criteria);
	Part getPartByNo(int partNo);
	void updatePart(Part part);
	List<Part> getAllParts();
	void addPart(Part part);
	int getPartSeq();
	int getTotalRowsByDivisionId(String divisionId);
	List<Part> getBupumList();
	int getTotalRows(PartCriteria criteria);
	int getExpendableRows(PartCriteria criteria);
	List<Part> getPagingParts(PartCriteria criteria);
	List<Part> getExpendableParts(PartCriteria criteria);
}
