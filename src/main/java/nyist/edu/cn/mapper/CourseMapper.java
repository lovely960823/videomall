package nyist.edu.cn.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.Course;
import tk.mybatis.mapper.common.Mapper;

public interface CourseMapper  extends Mapper<Course>{

	Integer selectMaxIdByPraentId(@Param("parentId") Integer parentId);

	List<Map<String, Object>> findCourseDataByParam(@Param("course") Course course);

	@Select(" select * from course where parent_id !='0' limit 10 ")
	List<Course> findEight();

	Course findTeacherById(@Param("id")Integer id);

	@Select(" select * from course where parent_id='1' and parent_id !='0' and difficulty like #{select} limit 4 ")
	List<Course> findByLxJava(String select);

	@Select(" select * from course where parent_id='5' and parent_id !='0' and difficulty like #{select} limit 4 ")
	List<Course> findByLxAi(String select);

	@Select(" select * from course where parent_id='3' and parent_id !='0' and difficulty like #{select} limit 5 ")
	List<Course> findByLxPython(String select);

	@Select(" select * from course where parent_id='2' and parent_id !='0' and difficulty like #{select} limit 5 ")
	List<Course> findByLxProtal(String select);

	@Select(" select * from course where parent_id !='0' ")
	List<Course> findAllCourse();

	@Select(" select * from course where parent_id=#{lx} and parent_id !='0' ")
	List<Course> findAllCourseByLx(String lx);

	@Select(" select * from course where id =#{cid}  ")
	Course findById(String cid);

	@Select(" select * from course where parent_id ='0' ")
	List<Course> findAllXk();
	
	
}