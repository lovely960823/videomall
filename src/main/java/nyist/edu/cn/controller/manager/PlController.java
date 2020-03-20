package nyist.edu.cn.controller.manager;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Pl;
import nyist.edu.cn.service.PlService;
import nyist.edu.cn.vo.ResultPage;

/**
 * 2020/1/23
 * @author ljw
 *
 */
@Controller
public class PlController extends BaseController {

	@Autowired
	private PlService plService;
	
	/**
	 * 发表评论
	 * @param uid
	 * @param cid
	 * @param contents
	 * @param score
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/pl/pubPl")
	public int pubPl(Integer uid,Integer cid,String contents,String score){
		Pl pl = new Pl();
		pl.setContent(contents);
		pl.setScore(score);
		pl.setCid(cid);
		pl.setUid(uid);
		pl.setCreateTime(new Date());
		int i = plService.save(pl);
		if(i>0){
			return 1;
		}else{
			return 0;
		}
	}
	
	/**
	 * 获取评论消息和对应的人信息
	 * @param resultPage
	 * @param pl
	 * @param noteId
	 * @return
	 * @throws InterruptedException 
	 */
	@RequestMapping("/pl/plMessage")
	@ResponseBody
	public ResultPage<Pl> pldata(ResultPage<Pl> resultPage,Pl pl,Integer cid) throws InterruptedException{
		pl.setCid(cid);
		//Thread.sleep(2);
		ResultPage<Pl> result = plService.findAllAjax(resultPage,pl);
		return result;
	}
}
