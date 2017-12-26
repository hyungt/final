package com.ese.service.manage.result;

import java.util.List;

import com.ese.vo.common.DayResultCriteria;
import com.ese.vo.pay.BalanceAccount;

public interface DayResultService {
	
	
	List<BalanceAccount> ForweekResult(DayResultCriteria dayResultCriteria);
}
