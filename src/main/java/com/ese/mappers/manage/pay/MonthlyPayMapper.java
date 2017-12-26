package com.ese.mappers.manage.pay;

import java.util.List;

import com.ese.vo.common.PayChangeCriteria;
import com.ese.vo.pay.MonthlyPay;

public interface MonthlyPayMapper {

	List<MonthlyPay> getMonthlyPayByMonth(String month);
	MonthlyPay getMonthlyPayByCriteria(PayChangeCriteria criteria);
	void addMonthlyPay(MonthlyPay pay);
}
