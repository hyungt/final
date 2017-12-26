package com.ese.mappers.manage.pay;

import java.util.List;
import java.util.Map;

import com.ese.vo.common.PayChangeChartResult;
import com.ese.vo.common.PayChangeCriteria;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;

public interface PayChangeMapper {

	void addPayChange(PayChange pay);
	List<PayChange> getPayChanges(PayChangeType type);
	List<PayChangeType> getAllPayChangeType();
	List<PayChange> getChangeByCriteria(PayChangeCriteria criteria);
	
	List<PayChangeChartResult> getDayChartData(Map<String, Object> criteria);
	List<PayChangeChartResult> getTypeChartData(Map<String, Object> criteria);
}
