package com.ese.mappers.manage.part;

import java.util.List;

import com.ese.vo.product.PartUsingModel;

public interface PartUsingModelMapper {
	void addPartUsingModel(PartUsingModel partUsingModel);
	void delPartUsingModel(int partNo);
	List<PartUsingModel> getPartUsingModels(int partNo);
}
