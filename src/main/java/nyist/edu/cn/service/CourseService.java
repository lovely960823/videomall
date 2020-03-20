package nyist.edu.cn.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import nyist.edu.cn.entity.Course;
import nyist.edu.cn.service.base.BaseService;
import nyist.edu.cn.vo.ResultPage;

public interface CourseService extends BaseService<Course>{

	ResultPage<Course> findCourseByParam(ResultPage<Course> resultPage, Course course);

	Integer findMaxId(Integer parentId);

	ResultPage<Map<String, Object>> findCourseDataByParam(ResultPage<Map<String, Object>> resultPage, Course course);

	int addCourseAndDetail(Course course, String[] dname, String[] dcontent, MultipartFile picFile,
			MultipartFile[] videoFile)  throws Exception;

	int delteCourseById(Integer id);

	int updateCourseAndDetail(Course course, String[] dname, String[] dcontent,Integer[] detailId,String[] dvideo, MultipartFile picFile,
			MultipartFile[] videoFile) throws Exception ;

	/**
	 * 精品推荐取10个
	 * @return
	 */
	List<Course> findEight();

	/**
	 * 关联查询到教师
	 * @param id
	 * @return
	 */
	Course findTeacherById(Integer id);

	List<Course> findByLxJava(String select);

	List<Course> findByLxAi(String select);

	List<Course> findByLxPython(String select);

	List<Course> findByLxProtal(String select);

	List<Course> findAllCourse();

	List<Course> findAllCourseByLx(String lx);

	List<Course> findAllXk();

	List<Course> findBySearch(Course course);

}
