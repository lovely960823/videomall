package nyist.edu.cn.service;

import java.util.List;

import nyist.edu.cn.entity.Pl;
import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;

public interface PlService extends BaseService<Pl> {

	ResultPage<Pl> findAllAjax(ResultPage<Pl> resultPage, Pl pl);

	/**
	 * 课程详情右边评价取五条
	 * @param cid
	 * @return
	 */
	List<Pl> findFivePl(Integer cid);

}
