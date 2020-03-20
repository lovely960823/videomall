package nyist.edu.cn.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import nyist.edu.cn.entity.User;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String url=request.getRequestURI();
		HttpSession session = request.getSession();  
		User user = (User)session.getAttribute("loginUser");
		//拦截器放�?  
		if(user==null) {
			if(url.indexOf("toLogin")>0||url.indexOf("toRegister")>0) {
				return true;
			}
        	if(url.indexOf("back")>0) {
        		response.setCharacterEncoding("UTF-8");
    	        response.getWriter().print("<html><head><meta charset='UTF-8'>" +
    	        		"<link rel='stylesheet' href='https://www.layuicdn.com/layui-v2.5.4/css/layui.css'>" +
    	        		"<script src='https://www.layuicdn.com/layui-v2.5.4/layui.js' charset='utf-8'></script>" +
    	        		"</head><script>" +
    	        		"layui.use('layer', function(){" +
    	        			"var $ = layui.jquery, layer = layui.layer;"+
    		        		"layer.alert('登录过期，请重新登录！！', { icon: 0, closeBtn: 0 }, function (index) { "+
    						"    window.location.href='/toRegister'   "+
    						"});" +
    					"});"+
    	        		"</script>");
    	        return false;
	        }
		}
		 
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
