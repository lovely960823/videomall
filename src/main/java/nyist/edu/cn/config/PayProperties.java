package nyist.edu.cn.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 微信支付配置类，一会调用的
 * @author ljw
 *
 */
@Component 
@ConfigurationProperties(prefix = "ly.pay.wx") 
public class PayProperties {

	 private String appID;    
	 private String mchID;    
	 private String key;    
	 private String notifyurl;
	public String getAppID() {
		return appID;
	}
	public void setAppID(String appID) {
		this.appID = appID;
	}
	public String getMchID() {
		return mchID;
	}
	public void setMchID(String mchID) {
		this.mchID = mchID;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getNotifyurl() {
		return notifyurl;
	}
	public void setNotifyurl(String notifyurl) {
		this.notifyurl = notifyurl;
	}
}	
