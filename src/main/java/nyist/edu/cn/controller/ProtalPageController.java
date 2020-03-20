package nyist.edu.cn.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.God;
import nyist.edu.cn.entity.Lunbo;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.GodService;
import nyist.edu.cn.service.LunboService;
import nyist.edu.cn.service.UserService;

@Controller
public class ProtalPageController extends BaseController{
	
	@Autowired
	private UserService userService;
	@Autowired
	private Environment env;
	@Autowired
	private GodService godService;
	@Autowired
	private LunboService lunboService;
	@Autowired
	private CourseService courseService;

	@RequestMapping("/toLogin")
	public String toLogin(){
		return "/login";
	}
	@RequestMapping("/manageros/welcome")
	public String welcome(){
		return "/admin/welcome";
	}
	
	@RequestMapping("/")
	public String toIndex(HttpServletRequest request){
		//前台牛人展示
		List<God> godList = godService.getGod();
		this.setAttribute("godList", godList);
		//轮播图
		List<Lunbo> lunboList = lunboService.findByT(null);
		this.setAttribute("lunboList", lunboList);
		//横向的精品推荐
		List<Course> hxList = courseService.findAllXk();
		this.setAttribute("hxList", hxList);
		return "/protal/index";
	}
	
	@RequestMapping("/toRegister")
	public String toTrgister() {
		return "/register";
	}
	
	
	/**
	 * 2020/1/13
	 * 短信验证码
	 * @param phoneNumber
	 * @param randomCode
	 * @return
	 */
	@RequestMapping("/receiveCodeToMyPhone")
	@ResponseBody
	public String sendCode(String phoneNumber,String randomCode) {
		String key=env.getProperty("phonekey");
		String assect=env.getProperty("phoneassect");
		DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", key, assect);
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", phoneNumber);
        request.putQueryParameter("SignName", "温暖阳光");
        request.putQueryParameter("TemplateCode", "SMS_179601653");
        String val="{\"code\":";
        val=val+randomCode+"}";
        request.putQueryParameter("TemplateParam", val);
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
            return "1";
        } catch (ServerException e) {
            e.printStackTrace();
            return "ServerException";
        } catch (ClientException e) {
            e.printStackTrace();
            return "ClientException";
        }
	}
	
	/**
	 * 注册实现
	 * @param user
	 * @return
	 */
	@RequestMapping("/doRegister")
	@ResponseBody
	public int doRegister(User user) {
		user.setCreateTime(new Date());
		user.setImg("http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLNRjB8ZwrDr0LDrBcd2CfVINmaqibw1auOfblNAaq44tGRJlJRJaUat8qckO1abIcmvucK8HuwuOQ/132");
		int i = userService.sava(user);
		if(i>0) {
			return 1;
		}else {
			return 0;
		}
	}
	
	/**
	 * 用户登录
	 * @param name
	 * @param pwd
	 * @return
	 */
	@RequestMapping("/doLogin")
	@ResponseBody
	public int doLogin(String name,String pwd) {
		User user = userService.findByTelAndPwd(name,pwd);
		if(user!=null) {
			this.getSession().setAttribute("loginUser", user);
			return 1;
		}else {
			return 0;
		}
	}
	
	/**
	 * 根据手机号查重
	 * @param phoneNum
	 * @return
	 */
	@RequestMapping("/checkTelNumber")
	@ResponseBody
	public int checkTelNumber(String phoneNum) {
		
		User user = userService.findByTel(phoneNum);
		if(user!=null) {
			return 1;
		}else {
			return 0;
		}
	}
	
	/**
	 * 精品推荐取十条
	 * @return
	 */
	@RequestMapping("jingpinList")
	@ResponseBody
	public List<Course> list(){
		List<Course> list = courseService.findEight();//精品推荐，获取八条
		return list;
	}
	
}
