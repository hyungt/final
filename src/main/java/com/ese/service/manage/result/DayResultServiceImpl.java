package com.ese.service.manage.result;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.pay.DayResultMapper;
import com.ese.vo.common.DayResultCriteria;
import com.ese.vo.pay.BalanceAccount;

@Service
public class DayResultServiceImpl implements DayResultService {

	@Autowired
	private DayResultMapper dayResultMapper;
	
	@Override
	public List<BalanceAccount> ForweekResult(DayResultCriteria dayResultCriteria) {
		return dayResultMapper.weekResult(dayResultCriteria);
	}	
}
