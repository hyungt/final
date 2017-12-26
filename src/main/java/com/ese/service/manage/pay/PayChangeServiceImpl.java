package com.ese.service.manage.pay;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ese.mappers.manage.pay.MonthlyPayMapper;
import com.ese.mappers.manage.pay.OtherPayMapper;
import com.ese.mappers.manage.pay.PayChangeMapper;
import com.ese.vo.common.DayResultCriteria;
import com.ese.vo.common.PayChangeChartResult;
import com.ese.vo.common.PayChangeCriteria;
import com.ese.vo.pay.BalanceAccount;
import com.ese.vo.pay.MonthlyPay;
import com.ese.vo.pay.OtherPay;
import com.ese.vo.pay.PayChange;
import com.ese.vo.pay.PayChangeType;

@Service
public class PayChangeServiceImpl implements PayChangeService {

	@Autowired PayChangeMapper changeMapper;
	@Autowired MonthlyPayMapper monthlyPayMapper;
	@Autowired OtherPayMapper otherMapper;
	
	@Override
	public void addPayChange(PayChange pay) {
		changeMapper.addPayChange(pay);
	}

	@Override
	public List<PayChange> getChangeByType(PayChangeType type) {
		return changeMapper.getPayChanges(type);
	}

	@Override
	public List<PayChangeType> getAllPayChangeType() {
		return changeMapper.getAllPayChangeType();
	}

	@Override
	public List<PayChange> getChangeByCriteria(PayChangeCriteria criteria) {
		return changeMapper.getChangeByCriteria(criteria);
	}
	
	@Override
	public MonthlyPay getMonthlyPayByCriteria(PayChangeCriteria criteria) {
		return monthlyPayMapper.getMonthlyPayByCriteria(criteria);
	}

	@Override
	public List<MonthlyPay> getMonthlyPayByMonth(String month) {
		return monthlyPayMapper.getMonthlyPayByMonth(month);
	}

	@Override
	public void addMonthlyPay(MonthlyPay pay) {
		monthlyPayMapper.addMonthlyPay(pay);
	}

	@Override
	public void addOtherPay(OtherPay other) {
		otherMapper.addOtherPay(other);
	}

	@Override
	public List<PayChangeChartResult> getDayChart(Map<String, Object> criteria) {
		return changeMapper.getDayChartData(criteria);
	}

	@Override
	public List<PayChangeChartResult> getTypeChartData(Map<String, Object> criteria) {
		return changeMapper.getTypeChartData(criteria);
	}
}
