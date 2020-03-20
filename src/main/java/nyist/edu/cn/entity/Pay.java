package nyist.edu.cn.entity;

import java.io.Serializable;
import java.util.List;

/**
 * 2020/1/25
 * @author ljw
 *
 */
public class Pay implements Serializable {

	/**
	 * 生成订单时候生成的订单参数
	 */
	private static final long serialVersionUID = 1L;
	
	private String orderNum;
	private List<String> ids;
	private List<String> prices;
	public String getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	public List<String> getIds() {
		return ids;
	}
	public void setIds(List<String> ids) {
		this.ids = ids;
	}
	public List<String> getPrices() {
		return prices;
	}
	public void setPrices(List<String> prices) {
		this.prices = prices;
	}
	/*@Override
	public String toString() {
		return "Pay {orderNum=" + orderNum + ", ids=" + ids + ", prices=" + prices + "}";
	}*/
	/**
	 * 重写自己的toString方法，用于取值
	 */
	@Override
	public String toString() {
		return "{\"orderNum\":\"" + orderNum + "\", \"ids\":\"" + ids + "\", \"prices\":\"" + prices + "\"}";
	}
	
}
