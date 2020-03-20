package nyist.edu.cn.controller.manager;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Teacher;
import nyist.edu.cn.service.TeacherService;
import nyist.edu.cn.vo.ResultPage;

@RequestMapping("/manageros/teacher")
@Controller
public class TeacherController extends BaseController{

	@Autowired
	private TeacherService teacherService;
	
	
	@RequestMapping("/findAll")
	public String findAll() {
		return "/admin/teacher/teacher_list";
	}
	
	@RequestMapping("teacherData")
	@ResponseBody
	public ResultPage<Teacher> cpzxData(ResultPage<Teacher> resultPage,Teacher teacher){
		ResultPage<Teacher> result = teacherService.findTeacherByParam(resultPage, teacher);
		return result;
	}
	
	@RequestMapping("toAdd")
	public String toAdd() {
		return "/admin/teacher/teacher_add";
	}
	
	@RequestMapping("add")
	@ResponseBody
	public int add(@RequestParam(value="imageFile",required=false)MultipartFile picFile,Teacher teacher) {
		try {
			String rootPath = System.getProperty("user.dir");
			String filename = picFile.getOriginalFilename();
			String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
			//文件路径
			rootPath =  rootPath + "/src/main/resources/";
			String url = "static/upload/"+name;
			String path = rootPath+"/"+url;
			File pathFile = new File(path);
			if(!pathFile.exists()){
				pathFile.mkdirs();
			}
			picFile.transferTo(new File(path));
			teacher.settPic(url);
			int i = teacherService.save(teacher);
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
	
	@RequestMapping("toUpdate/{id}")
	public String toUpdate(@PathVariable Integer id) {
		Teacher teacher = teacherService.findById(id);
		this.setAttribute("teacher", teacher);
		return "/admin/teacher/teacher_update";
	}
	
	@RequestMapping("update")
	@ResponseBody
	public int update(@RequestParam(value="imageFile",required=false)MultipartFile picFile,Teacher teacher) {
		try {
			if(picFile != null){
				String rootPath = System.getProperty("user.dir");
				rootPath =  rootPath + "/src/main/resources/";
				String filename = picFile.getOriginalFilename();
				if(!StringUtils.isEmpty(filename)){
					Teacher oldTeacher = teacherService.findById(teacher.getId());
					if(oldTeacher != null && !StringUtils.isEmpty(oldTeacher.gettPic())) {
						File file = new File(rootPath + oldTeacher.gettPic());
						if(file.exists()) {
							file.delete();
						}
					}
					
					String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
					String url = "static/upload/"+name;
					String path = rootPath+"/"+url;
					File pathFile = new File(path);
					if(!pathFile.exists()){
						pathFile.mkdirs();
					}
					picFile.transferTo(new File(path));
					teacher.settPic(url);
				}
			}
			
			int i = teacherService.updateByPrimaryKeySelective(teacher);
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
			Teacher teacher = teacherService.findById(id);
			String rootPath = System.getProperty("user.dir");
			rootPath =  rootPath + "/src/main/resources/";
			if(!StringUtils.isEmpty(teacher.gettPic())) {
				File file = new File(rootPath+teacher.gettPic());
				if(file.exists()) {
					file.delete();
				}
			}
			int i = teacherService.deleteByPrimaryKey(id);
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
