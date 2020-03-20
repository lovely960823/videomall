package nyist.edu.cn.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.CourseDetailService;
import nyist.edu.cn.service.OrderService;
import nyist.edu.cn.service.UserService;
import nyist.edu.cn.util.HttpClientUtils;
import nyist.edu.cn.util.HttpUtils;
import nyist.edu.cn.vo.ResultPage;

/**
 * 2020/1/16
 * @author ljw
 *
 */
@Controller
public class MemeberController extends BaseController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private StringRedisTemplate redisTemplate;
	@Autowired
	private CourseDetailService courseDetailService;

	/**
	 * 注册用户去到自己后台 
	 * @return
	 */
	@RequestMapping("/back/memeber/center/{id}")
	public String memeberCenter(@PathVariable Integer id) {
		List<String> range = redisTemplate.opsForList().range("recently:"+id.toString(), 0, -1);//集合值
		List<String> idList = new ArrayList<String>();
		System.out.println("range:"+range);
		for(String str:range){
			idList.add(str);
		}
		List<CourseDetail> detailList = new ArrayList<>();
		if(!idList.isEmpty()){
			for(int i=0;i<idList.size();i++){
				CourseDetail c= courseDetailService.findById(idList.get(i));
				detailList.add(c);
			}
		}
		this.setAttribute("detailList", detailList);
		return "protal/memeber/memebercenter";
	}
	
	/**
	 * 用户退出
	 * @return
	 */
	@RequestMapping("/back/memeber/logout")
	public String logout() {
		this.getSession().invalidate();
		return "redirect:/";
	}
	
	/**
	 * QQ登录参数
	 */
	private static String appid="101826833";
	private static String secret="26333e6eaaa5f0596bdc1bf0fd452ec8";
	private static String url="http://127.0.0.1:80/qqLoginTest";
	
	@RequestMapping("/memeber/qqLogin")
	public void toqqLogin(HttpServletResponse response) {
		String baseUrl="https://graph.qq.com/oauth2.0/authorize?";
		baseUrl+="response_type=code&";
		baseUrl+="client_id="+appid;
		baseUrl+="&redirect_uri="+url;
		baseUrl+="&state=ok";
		try {
			response.sendRedirect(baseUrl);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 回调过来的
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/qqLoginTest")
	public String qqLoginTest(String code) throws Exception {
		String baseUrl="https://graph.qq.com/oauth2.0/token?";
		baseUrl+="grant_type=authorization_code&";
		baseUrl+="client_id="+appid;
		baseUrl+="&client_secret="+secret;
		baseUrl+="&code="+code;
		baseUrl+="&redirect_uri="+url;
		String token=HttpClientUtils.get(baseUrl.toString(), "UTF-8");
		System.out.println("token:"+token);//token:access_token=8302E5F1A80ED9EBD2F3581C3F0BBAA8&expires_in=7776000&refresh_token=9F9F9A2529A9B739420AC43EF5EDD2E1
		token=token.split("&")[0];
		token=token.split("=")[1];
		String openidUrl="https://graph.qq.com/oauth2.0/me?access_token="+token;
		String openid=HttpClientUtils.get(openidUrl.toString(), "UTF-8");
		System.out.println("openid:"+openid);//openid:callback( {"client_id":"101826833","openid":"81B38A3BC7F27676F86FF5B32275978A"} );
		openid=StringUtils.substringBetween(openid, "\"openid\":\"", "\"}");
		String infoUrl= "https://graph.qq.com/user/get_user_info?access_token="+token+"&oauth_consumer_key="+appid+"&openid="+openid;
		String user_info =HttpClientUtils.get(infoUrl.toString(), "UTF-8");
		System.out.println("user_info:"+user_info);
		JSONObject parseObject = JSON.parseObject(user_info);
        Map<String, Object> map= new HashMap<String, Object>();
        map=parseObject;
        System.out.println(map.get("nickname"));
      //openid作为唯一值，用来存在数据库，判别的
        if(!openid.isEmpty()) {
        	User  user = userService.findUserByOpenId(openid);//根据这个openID判断是否存在
        	if(user!=null) {
        		User sessionUser1 = user;
        		sessionUser1.setId(user.getId());
        		sessionUser1.setUsername(map.get("nickname").toString());
        		sessionUser1.setImg(map.get("figureurl").toString());
        		this.getRequest().getSession().setAttribute("loginUser", sessionUser1);
        	}else {
        		User u = new User();
        		u.setUsername("QQ用户");
        		u.setImg(map.get("figureurl").toString());//获取用户的头像
        		u.setOpenid(openid);
        		userService.sava(u);
        		User sessionUser = userService.findUserByOpenId(openid);
        		//防止用户昵称有表情图片的：既可以显示出来，又不耽误，还能及时获取用户最新信息
        		sessionUser.setUsername(map.get("nickname").toString());
        		sessionUser.setImg(map.get("figureurl").toString());
        		this.getRequest().getSession().setAttribute("loginUser", sessionUser);
        	}
        }
        return "redirect:/";
	}
	
	/**
	 * 微信登录参数
	 */
	private  static String wx_appid="wx3bdb1192c22883f3";
	//private  static String wx_appsecret="db9d6b88821df403e5ﬀ11742e799105";
	private  static String wx_redirecturl="http://note.java.itcast.cn/weixinlogin";
	
	
	@RequestMapping("/memeber/wxLogin")
	public void test(HttpServletResponse response) {
		String baseUrl="https://open.weixin.qq.com/connect/qrconnect?"
				+ "appid="+wx_appid
				+"&redirect_uri="+wx_redirecturl
				+"&response_type=code&scope=snsapi_login&state=STATE#wechat_redirect";
		try {
			response.sendRedirect(baseUrl);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 回调该域名下的url
	 * @param code
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/weixinlogin")
	public String wxcallback(String code,HttpServletResponse response) throws Exception {
		/*String baseUrl="https://api.weixin.qq.com/sns/oauth2/access_token?"
				+ "appid="+appid
				+"&secret="+appsecret
				+"&code="+code
				+"&grant_type=authorization_code";*/
		/**
		 * 暂时就这样写，目前没找到具体原因
		 */
		String baseUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?code=" + code + "&appid=wx3bdb1192c22883f3&secret=db9d6b88821df403e5ff11742e799105&grant_type=authorization_code";
		Map<String, Object> map1 = HttpUtils.sendGet(baseUrl);
        Object access_token = map1.get("access_token");
        Object openid = map1.get("openid");
        String infoUrl="https://api.weixin.qq.com/sns/userinfo?access_token="+access_token+"&openid="+openid;
        String user_info =HttpClientUtils.get(infoUrl.toString(), "UTF-8");
        JSONObject parseObject = JSON.parseObject(user_info);
        Map<String, Object> map= new HashMap<String, Object>();
        map=parseObject;
        System.out.println(map.get("nickname"));
        System.out.println(map);
        if(!openid.toString().isEmpty()) {
        	User  user = userService.findUserByOpenId(openid.toString());//根据这个openID判断是否存在
        	if(user!=null) {
        		User sessionUser1 = user;
        		sessionUser1.setId(user.getId());
        		sessionUser1.setUsername(map.get("nickname").toString());
        		sessionUser1.setImg(map.get("headimgurl").toString());
        		this.getRequest().getSession().setAttribute("loginUser", sessionUser1);
        	}else {
        		User u = new User();
        		u.setUsername("微信用户");
        		u.setImg(map.get("headimgurl").toString());//获取用户的头像
        		u.setOpenid(openid.toString());
        		userService.sava(u);
        		//防止用户昵称有表情图片的：既可以显示出来，又不耽误，还能及时获取用户最新信息
        		User sessionUser = userService.findUserByOpenId(openid.toString());
        		sessionUser.setUsername(map.get("nickname").toString());
        		sessionUser.setImg(map.get("headimgurl").toString());
        		this.getRequest().getSession().setAttribute("loginUser", sessionUser);
        	}
        }
        return "redirect:/";
	}
	
	/**
	 * 我购买的课程
	 * @param uid
	 * @param resultPage
	 * @return
	 */
	@RequestMapping("/back/memeber/mycourse/{uid}")
	public String mycourse(@PathVariable Integer uid,ResultPage<Course> resultPage){
		ResultPage<Course> result = orderService.findByUid(uid,resultPage);
		this.setAttribute("result", result);
		this.setAttribute("uid", uid);
		return "protal/memeber/mycourse";
	}
	
	/**
	 * 我的订单
	 * @param uid
	 * @param resultPage
	 * @return
	 */
	@RequestMapping("/back/memeber/myorder/{uid}")
	public String myorder(@PathVariable Integer uid,ResultPage<Order> resultPage){
		ResultPage<Order> result = orderService.findByOrderUid(uid);
		this.setAttribute("result", result);
		this.setAttribute("uid", uid);
		return "protal/memeber/myorder";
	}
}
