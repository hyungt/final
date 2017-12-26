package com.ese.mappers.servicecenter.appraisal;

import java.util.List;

import com.ese.vo.order.Apparaisal;

public interface AppraisalMapper {

	void addAppraisal(Apparaisal apparaisal);
	List<Apparaisal> getAppraisals(int partNo);
	List<Apparaisal> getAppraisalsByUserNo(int userNo);
	int getRowsByUserNo(int userNo);
}
