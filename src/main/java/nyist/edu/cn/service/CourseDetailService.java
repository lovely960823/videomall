package nyist.edu.cn.service;

import java.util.List;

import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.service.base.BaseService;

public interface CourseDetailService extends BaseService<CourseDetail>{

	List<CourseDetail> findAllByCid(Integer id);


}
