package com.ese.vo.pay;

import java.util.Date;

public class BalanceAccount {
	
	private Date dates;
	private Long yesterdayAssets;
	private Long Assets;
	
	public Date getDates() {
		return dates;
	}
	public void setDates(Date dates) {
		this.dates = dates;
	}
	public Long getYesterdayAssets() {
		return yesterdayAssets;
	}
	public void setYesterdayAssets(Long yesterdayAssets) {
		this.yesterdayAssets = yesterdayAssets;
	}
	public Long getAssets() {
		return Assets;
	}
	public void setAssets(Long assets) {
		Assets = assets;
	}
	@Override
	public String toString() {
		return "BalanceAccount [dates=" + dates + ", yesterdayAssets=" + yesterdayAssets + ", Assets=" + Assets + "]";
	}
	
}
