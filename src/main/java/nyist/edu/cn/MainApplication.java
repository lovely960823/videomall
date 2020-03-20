package nyist.edu.cn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;
import tk.mybatis.spring.annotation.MapperScan;

/**
 * 2020/1/12
 * @author ljw
 *
 */
@SpringBootApplication//约定配置
//@EnableScheduling//定时器
@MapperScan(basePackages="nyist.edu.cn.mapper")//扫包
public class MainApplication extends SpringBootServletInitializer{

	
	public static void main(String[] args) {
		SpringApplication.run(MainApplication.class, args);
	}
	/**
	 * war包启动方式
	 */
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(MainApplication.class);
    }
}
