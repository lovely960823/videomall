package nyist.edu.cn.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.github.wxpay.sdk.WXPayUtil;

import nyist.edu.cn.config.PayProperties;
import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.NeedPay;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.entity.Pay;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.OrderService;

/**
 * 订单类
 * @author ljw
 *
 */
@Controller
public class OrderController extends BaseController {

	@Autowired
	private RestTemplate restTemplate;
	@Autowired    
	private PayProperties payProperties;
	@Autowired
	private CourseService courseService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private StringRedisTemplate redisTemplate; 
	
	@RequestMapping("/weChatPay")
	 public String createPayUrl(HttpServletRequest request,NeedPay needPay) { 
		List<String> list1= new ArrayList<>();
		List<String> list2= new ArrayList<>();
		
		String[] idarray= needPay.getIds().split(",");
		for(int i=0;i<idarray.length;i++){
			list1.add(idarray[i].replace(" ", ""));
		}
		String[] pricearray = needPay.getPrices().split(",");
		for(int i =0;i<pricearray.length;i++){
			list2.add(pricearray[i].replace(" ", ""));
		}
		
		
		//将要支付后生成数据库的参数放入自己封装的对象里面存入Redis，一会订单的时候使用
		Pay  pay = new Pay();
		String orderId=UUID.randomUUID().toString().replace("-", "");
		pay.setOrderNum(orderId);
		pay.setIds(list1);
		pay.setPrices(list2);
		User user = (User) this.getRequest().getSession().getAttribute("loginUser");
		redisTemplate.opsForValue().set("needPay:"+user.getId(), pay.toString());
		 try {            
			 Map<String,String> paramMap = new HashMap<>();            
			 paramMap.put("appid",payProperties.getAppID());            
			 paramMap.put("mch_id",payProperties.getMchID());            
			 paramMap.put("nonce_str", WXPayUtil.generateNonceStr());//随机数           
			 paramMap.put("body","网课商城");      
			 paramMap.put("out_trade_no",orderId); //交易号            
			 paramMap.put("total_fee","1"); // 测试时 使用1分钱           
			 paramMap.put("spbill_create_ip","127.0.0.1");            
			 paramMap.put("notify_url",payProperties.getNotifyurl());          
			 paramMap.put("trade_type","NATIVE");            //将参数转xml            
			 String paramXml = WXPayUtil.generateSignedXml(paramMap, payProperties.getKey());            //2、基于httpclient工具类，调用微信支付平台，完成支付操作            
			 String resultString = restTemplate.postForObject("https://api.mch.weixin.qq.com/pay/unifiedorder", paramXml, String.class);            
			 Map<String, String> stringStringMap = WXPayUtil.xmlToMap(resultString); 
			 String code_url = stringStringMap.get("code_url");                         
			 request.setAttribute("code_url", code_url);
			 request.setAttribute("orderId", orderId);
			 return "protal/memeber/wepay";
			 } 
		 	catch (Exception e) {            
				 e.printStackTrace(); 
				 System.out.println("支付流程失败");
			}
		 	return "redirect:www.baidu.com";
	    } 
	
	/**
	 * 查询该订单状态
	 * @param orderId
	 * @return
	 */
	@RequestMapping("/pay/state/{orderId}") 
	@ResponseBody
	public int queryPayState(@PathVariable("orderId") String orderId) { 
			 try {
				// 1、组装微信查询支付状态所需要的必填参数            
				 Map<String,String> paramMap = new HashMap<>();            
				 paramMap.put("appid",payProperties.getAppID());            
				 paramMap.put("mch_id",payProperties.getMchID());            
				 paramMap.put("nonce_str", WXPayUtil.generateNonceStr());            
				 paramMap.put("out_trade_no",orderId.toString());            //将参数转xml
				 String paramXml = WXPayUtil.generateSignedXml(paramMap, payProperties.getKey());            //2、基于restTemplate工具类，调用微信支付平台，完成支付状态操作操作                        
				 String resultString = restTemplate.postForObject("https://api.mch.weixin.qq.com/pay/orderquery", paramXml, String.class);            //3、处理响应结果            
				 Map<String, String> resultMap = WXPayUtil.xmlToMap(resultString);            //支付成功，返回状态1   
				 String status = resultMap.get("trade_state");
				 if(status.equals("NOTPAY")){
					 return 0;
				 }else if(status.equals("SUCCESS")){
					 return 1;
				 }else{
					 return 2;
				 }
			} catch (Exception e) {
				e.printStackTrace();
				return 2;
			} 
	}
	
	/**
	 * 支付实现
	 * @param list1
	 * @param list2
	 * @param orderId
	 * @return
	 */
	@RequestMapping("/order/makeorder")
	@ResponseBody
	public int makeOrder(){
		User user = (User) this.getRequest().getSession().getAttribute("loginUser");
		Integer uid = user.getId();
		//从redis里面获取生成订单需要的参数
		String  p =redisTemplate.opsForValue().get("needPay:"+user.getId());
		Pay parseObject = JSONObject.parseObject(p, Pay.class);
		String orderId = parseObject.getOrderNum();//订单号
		List<String> lsit_prices = parseObject.getPrices();//价格集合
		List<String> list_ids = parseObject.getIds();//id集合
		String str_prices = lsit_prices.get(0);
		String str_ids = list_ids.get(0);
		str_prices =str_prices.substring(1,str_prices.length()-1);//价格
		str_ids =str_ids.substring(1,str_ids.length()-1);//id
		
		String[] idarr=str_ids.split(",");
		String[] pricearr = str_prices.split(",");
		
		List<String> ids= new ArrayList<>();
		List<String> prices= new ArrayList<>();
		for(int i=0;i<idarr.length;i++){
			ids.add(idarr[i]);
		}
		for(int i =0;i<pricearr.length;i++){
			prices.add(pricearr[i]);
		}
		//生成订单
		for(int i=0;i<ids.size();i++){//价格和课程id分割的时候存在空格问题，去一下空格
			Order order = new Order();
			order.setCreateTime(new Date());//订单时间
			Course course= courseService.findById(ids.get(i));
			order.setName(course.getName());//课程名
			order.setOrdernum(orderId);//生成的订单号
			order.setPrice(prices.get(i).replace(" ", ""));//当时的价格
			order.setUid(uid.toString());//用户
			order.setCid(ids.get(i).replace(" ",""));//课程id
			orderService.save(order);
			//清空购物车  待处理
			redisTemplate.opsForSet().remove("shopcar:"+uid.toString(), ids.get(i).replace(" ",""));
		}
		return 1;
	}
}
