package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.CourseDetail;
import tk.mybatis.mapper.common.Mapper;

public interface CourseDetailMapper extends Mapper<CourseDetail>{

	@Select(" select * from course_detail where cid=#{id} order by id ")
	List<CourseDetail> findAllByCid(Integer id);
	
}