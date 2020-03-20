package nyist.edu.cn.entity;

import java.io.Serializable;

public class NeedPay implements Serializable{

	/**
	 * 支付的时候带的参数
	 */
	private static final long serialVersionUID = 1L;
	
	private String ids;
	private String prices;
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getPrices() {
		return prices;
	}
	public void setPrices(String prices) {
		this.prices = prices;
	}
	@Override
	public String toString() {
		return "NeedPay [ids=" + ids + ", prices=" + prices + "]";
	}
}
