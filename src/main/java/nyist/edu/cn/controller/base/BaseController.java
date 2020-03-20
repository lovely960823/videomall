package nyist.edu.cn.controller.base;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * <p>类功能描述: 通用controller，获取request,response,session等</p>
 * <p>类名：BaseController </p>
 * <p>创建时间：2019-3-25 下午4:27:24 </p>
 * <p>@author：mmy</p>
 * @param <T>
 */
public abstract  class BaseController {
	
	/**
	 * <p>功能描述：格式化日期</p>
	 * <p>方法名：initBinder</p>
	 * <p>@param request
	 * <p>@param binder
	 * <p>@throws Exception</p>
	 * <p>返回类型：void</p>
	 * <p>创建日期：2019-3-25 下午4:07:44</p>  
	 * <p>@author：mmy</p>
	 */
    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        CustomDateEditor dateEditor = new CustomDateEditor(format, true);
        binder.registerCustomEditor(Date.class, dateEditor);
        
    }
    /**
     * <p>功能描述：request.getAttribute</p>
     * <p>方法名：getAttribute</p>
     * <p>@param attributeName
     * <p>@return</p>
     * <p>返回类型：Object</p>
     * <p>创建日期：2019-3-25 下午4:08:16</p>  
     * <p>@author：mmy</p>
     */
    public Object getAttribute(String attributeName) {
        return this.getRequest().getAttribute(attributeName);
    }
    /**
     * <p>功能描述：request.setAttribute</p>
     * <p>方法名：getAttribute</p>
     * <p>@param attributeName
     * <p>@return</p>
     * <p>返回类型：Object</p>
     * <p>创建日期：2019-3-25 下午4:08:16</p>  
     * <p>@author：mmy</p>
     */
    public void setAttribute(String attributeName, Object object) {
        this.getRequest().setAttribute(attributeName, object);
    }
    /**
     * <p>功能描述：request.getSession</p>
     * <p>方法名：getAttribute</p>
     * <p>@param attributeName
     * <p>@return</p>
     * <p>返回类型：Object</p>
     * <p>创建日期：2019-3-25 下午4:08:16</p>  
     * <p>@author：mmy</p>
     */
    public Object getSession(String attributeName) {
        return this.getRequest().getSession(true).getAttribute(attributeName);
    }
    /**
     * <p>功能描述：request.setSession</p>
     * <p>方法名：getAttribute</p>
     * <p>@param attributeName
     * <p>@return</p>
     * <p>返回类型：Object</p>
     * <p>创建日期：2019-3-25 下午4:08:16</p>  
     * <p>@author：mmy</p>
     */
    public void setSession(String attributeName, Object object) {
        this.getRequest().getSession(true).setAttribute(attributeName, object);
    }
    /**
     * <p>功能描述：获取request</p>
     * <p>方法名：getAttribute</p>
     * <p>@param attributeName
     * <p>@return</p>
     * <p>返回类型：Object</p>
     * <p>创建日期：2019-3-25 下午4:08:16</p>  
     * <p>@author：mmy</p>
     */
    public HttpServletRequest getRequest() {
        return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
    }
    /**
     * <p>功能描述：获取response对象</p>
     * <p>方法名：getResponse</p>
     * <p>@return</p>
     * <p>返回类型：HttpServletResponse</p>
     * <p>创建日期：2019-3-25 下午4:14:52</p>  
     * <p>@author：mmy</p>
     */
    public HttpServletResponse getResponse(){
        return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();
    }
    /**
     * <p>功能描述：得到session对象</p>
     * <p>方法名：getSession</p>
     * <p>@return</p>
     * <p>返回类型：HttpSession</p>
     * <p>创建日期：2019-3-25 下午4:12:06</p>  
     * <p>@author：mmy</p>
     */
    public HttpSession getSession() {
        return this.getRequest().getSession(true);
    }
    /**
     * <p>功能描述：获取表单参数</p>
     * <p>方法名：getParameter</p>
     * <p>@param paraName
     * <p>@return</p>
     * <p>返回类型：String</p>
     * <p>创建日期：2019-3-25 下午4:12:26</p>  
     * <p>@author：mmy</p>
     */
    public String getParameter(String paraName) {
        return this.getRequest().getParameter(paraName);
    }
    
    /**
     * 获取表单格式数据(或url拼接参数)
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Map getParameterMap(){
        return this.getRequest().getParameterMap();
    }
    
    public String getHeader(String headerName) {
        return this.getRequest().getHeader(headerName);
    }

    /**
     * <p>功能描述：获取ip地址</p>
     * <p>方法名：getIpAddress</p>
     * <p>@return</p>
     * <p>返回类型：String</p>
     * <p>创建日期：2019-3-25 下午4:13:18</p>  
     * <p>@author：mmy</p>
     */
    public String getIpAddress(){
        String ip =  this.getRequest().getRemoteAddr();
        return ip.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":ip;
    }
    
    /**
     * 获取服务器ip地址
     * @return
     */
    public String getServerIpAddress(){
        InetAddress address;
        String serverIpAddress = null;
        try {
            address = InetAddress.getLocalHost(); //获取的是本地的IP地址 //PC-20140317PXKX/192.168.0.121
            serverIpAddress = address.getHostAddress();//192.168.0.121
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return serverIpAddress;
    }
    
    
}
