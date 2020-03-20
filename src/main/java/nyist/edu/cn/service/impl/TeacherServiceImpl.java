package nyist.edu.cn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Teacher;
import nyist.edu.cn.mapper.TeacherMapper;
import nyist.edu.cn.service.TeacherService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service
@Transactional
public class TeacherServiceImpl extends BaseServiceImpl<Teacher> implements TeacherService{

	@Autowired
	private TeacherMapper teacherMapper;
	
	public ResultPage<Teacher> findTeacherByParam(ResultPage<Teacher> result, Teacher teacher){
		PageHelper.startPage(result.getPage(), result.getLimit());
		Example example=new Example(Teacher.class);
		if(teacher != null) {
			Criteria criteria = example.createCriteria();
			if(!StringUtils.isEmpty(teacher.getName())) {
				criteria.andLike("name", "%"+teacher.getName()+"%");
			}
		}
		List<Teacher> list = teacherMapper.selectByExample(example);
		PageInfo<Teacher> pageInfo = new PageInfo<>(list);
		result.setData(list);
		result.setCount(pageInfo.getTotal());   //总记录数
		result.setTotalPage(pageInfo.getPages());  //总页数
		return result;
	}
	
}
