package com.ese.controller.manage.scheduling;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ese.mappers.manage.pay.DayResultMapper;
import com.ese.vo.pay.BalanceAccount;
import com.ese.vo.pay.PayChange;
@Component("DayResult")
public class DayResult {
	
	@Autowired
	private DayResultMapper dayResultMapper;
	
	public void dayResultBatch () {
		
		List<PayChange> changes = dayResultMapper.getPayChangesResult();
		BalanceAccount account = dayResultMapper.dayResultOne();
		
		List<BalanceAccount> accounts = dayResultMapper.dayResultToday();
		if (!accounts.isEmpty()) {
			return;
		}
		
		long income = 0;
		long payed = 0;
		
		for(PayChange change : changes) {
			if(change.getType().equals("수입")) {
				income += change.getMoney();
			} else {
				payed += change.getMoney();
			}
		}
		
		System.out.println(account);
		
		BalanceAccount result = new BalanceAccount();
		result.setYesterdayAssets(account.getAssets());
		result.setAssets((income + result.getYesterdayAssets()) - payed);
		
		System.out.println("배치프로그램 시작됨");
		
		dayResultMapper.dayResult(result);
	}
}
