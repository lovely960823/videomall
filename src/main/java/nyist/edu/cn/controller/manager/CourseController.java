package nyist.edu.cn.controller.manager;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.entity.Teacher;
import nyist.edu.cn.service.CourseDetailService;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.TeacherService;
import nyist.edu.cn.vo.ResultPage;

@RequestMapping("/manageros/course")
@Controller
public class CourseController extends BaseController{

	
	@Autowired
	private CourseService courseService;
	@Autowired
	private CourseDetailService courseDetailService;
	@Autowired
	private TeacherService teacherService;
	
	@RequestMapping("/findXk")
	public String findXk() {
		return "/admin/course/xk_list";
	}
	
	@RequestMapping("XkData")
	@ResponseBody
	public ResultPage<Course> cpzxData(ResultPage<Course> resultPage,Course course){
		ResultPage<Course> result = courseService.findCourseByParam(resultPage, course);
		return result;
	}
	
	@RequestMapping("/toAddXk")
	public String toAddXk() {
		return "/admin/course/xk_add";
	}
	
	@RequestMapping("addXk")
	@ResponseBody
	public int addXk(Course course) {
		try {
			Integer maxId = courseService.findMaxId(0);
			if(maxId == null) {
				course.setId(1);
			}else {
				course.setId(maxId + 1);
			}
			course.setParentId(0);
			course.setCreateTime(new Date());
			course.setUpdateTime(new Date());
			int i = courseService.save(course);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
	@RequestMapping("/toUpdateXk/{id}")
	public String toUpdateXk(@PathVariable Integer id) {
		Course course = courseService.findById(id);
		this.setAttribute("course", course);
		return "/admin/course/xk_update";
	}
	
	@RequestMapping("updateXk")
	@ResponseBody
	public int updateXk(Course course) {
		try {
			course.setUpdateTime(new Date());
			int i = courseService.updateByPrimaryKeySelective(course);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
	@RequestMapping("delXk")
	@ResponseBody
	public int delXk(Integer id) {
		try {
			int i = courseService.deleteByPrimaryKey(id);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
	
	//-----------------------------------------------------------
	
	@RequestMapping("/findAll")
	public String findAll() {
		return "/admin/course/course_list";
	}
	
	@RequestMapping("courseData")
	@ResponseBody
	public ResultPage<Map<String, Object>> courseData(ResultPage<Map<String, Object>> resultPage,Course course){
		ResultPage<Map<String, Object>> result = courseService.findCourseDataByParam(resultPage, course);
		return result;
	}
	
	@RequestMapping("/toAdd")
	public String toAdd() {
		Course course = new Course();
		course.setParentId(0);
		List<Course> list = courseService.findByT(course);
		List<Teacher> teacherList = teacherService.findByT(null);
		this.setAttribute("xkList", list);
		this.setAttribute("teacherList", teacherList);
		return "/admin/course/course_add";
	}
	
	@RequestMapping("add")
	@ResponseBody
	public int add(Course course,String[] dname,String[] dcontent,
			@RequestParam(value="imageFile",required=false)MultipartFile picFile,
			@RequestParam(value="videoFile",required=false)MultipartFile[] videoFile) {
		try {
			course.setCreateTime(new Date());
			course.setUpdateTime(new Date());
			int i = courseService.addCourseAndDetail(course,dname,dcontent,picFile,videoFile);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
	@RequestMapping("/toUpdate/{id}")
	public String toUpdate(@PathVariable Integer id) {
		Course courseP = new Course();
		courseP.setParentId(0);
		List<Course> list = courseService.findByT(courseP);
		List<Teacher> teacherList = teacherService.findByT(null);
		this.setAttribute("xkList", list);
		this.setAttribute("teacherList", teacherList);
		
		Course course = courseService.findById(id);
		this.setAttribute("course", course);
		CourseDetail cDetail = new CourseDetail();
		cDetail.setCid(id);
		List<CourseDetail> courseDetailList = courseDetailService.findByT(cDetail);
		this.setAttribute("courseDetailList", courseDetailList);
		
		return "/admin/course/course_update";
	}
	@RequestMapping("update")
	@ResponseBody
	public int update(Course course,String[] dname,String[] dcontent,Integer[] detailId,String[] dvideo,
			@RequestParam(value="imageFile",required=false)MultipartFile picFile,
			@RequestParam(value="videoFile",required=false)MultipartFile[] videoFile) {
		try {
			course.setUpdateTime(new Date());
			int i = courseService.updateCourseAndDetail(course,dname,dcontent,detailId,dvideo,picFile,videoFile);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
	
	@RequestMapping("del")
	@ResponseBody
	public int del(Integer id) {
		try {
			int i =  courseService.delteCourseById(id);
			if(i>0){
				return 1;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;                                                                                                                                                                                                                                                                                                                              
		}
	}
	
}
