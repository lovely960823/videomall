package nyist.edu.cn.service;

import java.util.List;

import nyist.edu.cn.entity.God;
import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;

public interface GodService extends BaseService<God> {

	/**
	 * 后台根据姓名查找
	 * @param resultPage
	 * @param god
	 * @return
	 */
	ResultPage<God> findByName(ResultPage<God> resultPage, God god);

	/**
	 * 获取八条数据
	 * @return
	 */
	List<God> getGod();

}
