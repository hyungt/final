package com.ese.mappers.manage.pay;

import java.util.List;

import com.ese.vo.common.DayResultCriteria;
import com.ese.vo.pay.BalanceAccount;
import com.ese.vo.pay.PayChange;

public interface DayResultMapper {
	
	void dayResult(BalanceAccount account);
	BalanceAccount dayResultOne();
	List<PayChange> getPayChangesResult();
	List<BalanceAccount> weekResult(DayResultCriteria dayResultCriteria);
	List<BalanceAccount> dayResultToday();
}
