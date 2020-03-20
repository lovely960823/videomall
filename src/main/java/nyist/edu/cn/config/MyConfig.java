package nyist.edu.cn.config;


import java.nio.charset.Charset;

import org.springframework.boot.web.server.ConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import nyist.edu.cn.interceptor.LoginInterceptor;


@Configuration
public class MyConfig  implements WebMvcConfigurer {
	//WebMvcConfigurerAdapter 1.0  WebMvcConfigurer-->2.0
	
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String path = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\upload\\";
		System.out.println(path);
		registry.addResourceHandler("/static/upload/**").addResourceLocations("file:"+path);
	}
	
	//拦截器的配置
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//registry.addInterceptor(new LoginInterceptor())
		//springboot 2.0 会拦截静态资源，（放行）
		registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**").excludePathPatterns("/toLogin","/logout","/static/**");
	}

	/**
	 * 配置全局错误页面
	 * @return
	 */
	@Bean
    public WebServerFactoryCustomizer<ConfigurableWebServerFactory> webServerFactoryCustomizer() {
        return new WebServerFactoryCustomizer<ConfigurableWebServerFactory>() {
            @Override
            public void customize(ConfigurableWebServerFactory factory) {
                ErrorPage errorPage400 = new ErrorPage(HttpStatus.BAD_REQUEST,
                        "/error/error-400");
                ErrorPage errorPage404 = new ErrorPage(HttpStatus.NOT_FOUND,
                        "/error/error-404");
                ErrorPage errorPage500 = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR,
                        "/error/error-500");
                factory.addErrorPages(errorPage400, errorPage404,
                        errorPage500);
            }
        };
    }
		
	/**
	 * 微信的消息配置编码格式
	 * @return
	 */
	@Bean    
	public RestTemplate getRestTemplate(){        
		RestTemplate restTemplate = new RestTemplate();        //将默认的编码格式指定成utf-8        
		StringHttpMessageConverter converter = new StringHttpMessageConverter();        
		converter.setDefaultCharset(Charset.forName("utf-8"));//处理乱码        
		restTemplate.getMessageConverters().set(1,converter);        
		return restTemplate;    
		}
}
