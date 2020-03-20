package nyist.edu.cn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.mapper.CourseDetailMapper;
import nyist.edu.cn.mapper.CourseMapper;
import nyist.edu.cn.service.CourseDetailService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
@Service
@Transactional
public class CourseDetailServiceImpl extends BaseServiceImpl<CourseDetail> implements CourseDetailService{

	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private CourseDetailMapper courseDetailMapper;

	@Override
	public List<CourseDetail> findAllByCid(Integer id) {
		List<CourseDetail> list = courseDetailMapper.findAllByCid(id);
		return list;
	}
}
