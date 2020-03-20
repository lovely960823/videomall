package nyist.edu.cn.service;

import nyist.edu.cn.entity.Teacher;
import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;

public interface TeacherService extends BaseService<Teacher>{

	ResultPage<Teacher> findTeacherByParam(ResultPage<Teacher> resultPage, Teacher teacher);

}
