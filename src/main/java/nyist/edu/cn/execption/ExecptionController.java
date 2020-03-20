package nyist.edu.cn.execption;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import nyist.edu.cn.controller.base.BaseController;

/**
 * 2020/1/15
 * @author ljw
 *
 */
@Controller
@RequestMapping("/error")
public class ExecptionController extends BaseController {

	/**
	 * 常见几个错误页面的配置
	 * @return
	 */
	@RequestMapping("/error-404")
    public String toPage404(){
        return "execption/error_404";
    }
    @RequestMapping("/error-400")
    public String toPage400(){
        return "execption/error_400";
    }
    @RequestMapping("/error-500")
    public String toPage500(){
        return "execption/error_500";
    }

}
