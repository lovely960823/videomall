package nyist.edu.cn.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.entity.Teacher;
import nyist.edu.cn.mapper.CourseDetailMapper;
import nyist.edu.cn.mapper.CourseMapper;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service
@Transactional
public class CourseServiceImpl extends BaseServiceImpl<Course> implements CourseService{
	
	@Autowired
	private CourseMapper courseMapper;
	
	@Autowired
	private CourseDetailMapper courseDetailMapper;

	public ResultPage<Course> findCourseByParam(ResultPage<Course> result, Course course) {
		PageHelper.startPage(result.getPage(), result.getLimit());
		Example example=new Example(Course.class);
		Criteria criteria = example.createCriteria();
		if(course != null) {
			if(!StringUtils.isEmpty(course.getName())) {
				criteria.andLike("name", "%"+course.getName()+"%");
			}
		}
		criteria.andEqualTo("parentId", "0");
		List<Course> list = courseMapper.selectByExample(example);
		PageInfo<Course> pageInfo = new PageInfo<>(list);
		result.setData(list);
		result.setCount(pageInfo.getTotal());   //总记录数
		result.setTotalPage(pageInfo.getPages());  //总页数
		return result;
	}

	public Integer findMaxId(Integer parentId) {
		Integer maxId = courseMapper.selectMaxIdByPraentId(parentId);
		return maxId;
	}
	
	public ResultPage<Map<String, Object>> findCourseDataByParam(ResultPage<Map<String, Object>> result, Course course){
		PageHelper.startPage(result.getPage(), result.getLimit());
		List<Map<String, Object>> list = courseMapper.findCourseDataByParam(course);
		PageInfo<Map<String, Object>> pageInfo = new PageInfo<>(list);
		result.setData(list);
		result.setCount(pageInfo.getTotal());   //总记录数
		result.setTotalPage(pageInfo.getPages());  //总页数
		return result;
	}
	
	public int addCourseAndDetail(Course course, String[] dname, String[] dcontent, MultipartFile picFile,
			MultipartFile[] videoFile) throws Exception {
		Integer maxId = courseMapper.selectMaxIdByPraentId(course.getParentId());
		if(maxId == null) {
			maxId = Integer.parseInt(course.getParentId() + "01");
		}else {
			maxId = maxId+1;
		}
		course.setId(maxId);
		String rootPath = System.getProperty("user.dir");
		rootPath =  rootPath + "/src/main/resources/";
		
		String picFilename = picFile.getOriginalFilename();
		String picname = UUID.randomUUID().toString()+picFilename.substring(picFilename.indexOf("."));
		//文件路径
		String picUrl = "static/upload/"+picname;
		String picPath = rootPath+"/"+picUrl;
		File picPathFile = new File(picPath);
		if(!picPathFile.exists()){
			picPathFile.mkdirs();
		}
		picFile.transferTo(new File(picPath));
		course.setPic(picUrl);
		course.setViews(1);
		int k = courseMapper.insert(course);
		for (int i=0; i < dname.length; i++) {
			CourseDetail cDetail = new CourseDetail();
			cDetail.setViews(0);
			cDetail.setCreateTime(new Date());
			cDetail.setUpdateTime(new Date());
			cDetail.setCid(maxId);
			cDetail.setDname(dname[i]);
			cDetail.setDcontent(dcontent[i]);
			
			String videoFilename = videoFile[i].getOriginalFilename();
			String videoname = UUID.randomUUID().toString()+videoFilename.substring(videoFilename.indexOf("."));
			//文件路径
			String videoUrl = "static/upload/"+videoname;
			String videoPath = rootPath+"/"+videoUrl;
			File videoPathFile = new File(videoPath);
			if(!videoPathFile.exists()){
				videoPathFile.mkdirs();
			}
			videoFile[i].transferTo(new File(videoPath));
			cDetail.setDvideo(videoUrl);
			
			courseDetailMapper.insert(cDetail);
		}
		
		return k;
	}

	public int updateCourseAndDetail(Course course, String[] dname, String[] dcontent,Integer[] detailId,String[] dvideo,
			MultipartFile picFile,MultipartFile[] videoFile) throws Exception  {
		String rootPath = System.getProperty("user.dir");
		rootPath =  rootPath + "/src/main/resources/";
		if(picFile != null){
			String filename = picFile.getOriginalFilename();
			if(!StringUtils.isEmpty(filename)){
				File file = new File(rootPath + course.getPic());
				if(file.exists()) {
					file.delete();
				}
				String picFilename = picFile.getOriginalFilename();
				String picname = UUID.randomUUID().toString()+picFilename.substring(picFilename.indexOf("."));
				//文件路径
				String picUrl = "static/upload/"+picname;
				String picPath = rootPath+"/"+picUrl;
				File picPathFile = new File(picPath);
				if(!picPathFile.exists()){
					picPathFile.mkdirs();
				}
				picFile.transferTo(new File(picPath));
				course.setPic(picUrl);
			}
		}
		int k = courseMapper.updateByPrimaryKeySelective(course);
		//处理course_detail表
		CourseDetail cDetail = new CourseDetail();
		cDetail.setCid(course.getId());
		List<CourseDetail> list = courseDetailMapper.select(cDetail);
		List<Integer> idList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			Integer id = list.get(i).getId();
			idList.add(id);
		}
		List<Integer> asList = Arrays.asList(detailId);
		for (Integer id : idList) {
			for (int i = 0; i < detailId.length; i++) {	//处理原有数据
				if(id.equals(detailId[i])) { //如果包含id，则为更新操作
					CourseDetail courseDetail = new CourseDetail();
					courseDetail.setId(detailId[i]);
					courseDetail.setDname(dname[i]);
					courseDetail.setDcontent(dcontent[i]);
					//判断是否上传了文件
					String videoFilename = videoFile[i].getOriginalFilename();
					if(!StringUtils.isEmpty(videoFilename)) {
						//先删除旧文件，再插入新文件
						File old_videoFile = new File(rootPath+dvideo[i]);
						if(old_videoFile.exists()) {
							old_videoFile.delete();
						}
						String videoname = UUID.randomUUID().toString()+videoFilename.substring(videoFilename.indexOf("."));
						//文件路径
						String videoUrl = "static/upload/"+videoname;
						String videoPath = rootPath+"/"+videoUrl;
						File videoPathFile = new File(videoPath);
						if(!videoPathFile.exists()){
							videoPathFile.mkdirs();
						}
						videoFile[i].transferTo(new File(videoPath));
						courseDetail.setDvideo(videoUrl);
					}
					courseDetailMapper.updateByPrimaryKeySelective(courseDetail);
				}else {	//不含包，则为删除操作
					if(!asList.contains(id)) {
						CourseDetail detail = courseDetailMapper.selectByPrimaryKey(id);
						if(detail != null) {
							String dvideo2 = detail.getDvideo();
							File old_videoFile = new File(rootPath+dvideo2);
							if(old_videoFile.exists()) {
								old_videoFile.delete();
							}
							courseDetailMapper.deleteByPrimaryKey(id);
						}
					}
				}
				
			}
		}
		
		//处理新数据
		for (int i = detailId.length; i < dname.length; i++) {
			CourseDetail cDetail_new = new CourseDetail();
			cDetail_new.setViews(0);
			cDetail_new.setCreateTime(new Date());
			cDetail_new.setUpdateTime(new Date());
			cDetail_new.setCid(course.getId());
			cDetail_new.setDname(dname[i]);
			cDetail_new.setDcontent(dcontent[i]);
			
			String videoFilename = videoFile[i].getOriginalFilename();
			String videoname = UUID.randomUUID().toString()+videoFilename.substring(videoFilename.indexOf("."));
			//文件路径
			String videoUrl = "static/upload/"+videoname;
			String videoPath = rootPath+"/"+videoUrl;
			File videoPathFile = new File(videoPath);
			if(!videoPathFile.exists()){
				videoPathFile.mkdirs();
			}
			videoFile[i].transferTo(new File(videoPath));
			cDetail_new.setDvideo(videoUrl);
			
			courseDetailMapper.insert(cDetail_new);
		}
		
		return k;
		
	}
	
	
	public int delteCourseById(Integer id) {
		Course course = courseMapper.selectByPrimaryKey(id);
		String pic = course.getPic();
		String rootPath = System.getProperty("user.dir");
		rootPath =  rootPath + "/src/main/resources/";
		if(!StringUtils.isEmpty(pic)) {
			File file = new File(rootPath+pic);
			if(file.exists()) {
				file.delete();
			}
		}
		int i = courseMapper.deleteByPrimaryKey(id);
		CourseDetail cDetail = new CourseDetail();
		cDetail.setCid(id);
		List<CourseDetail> list = courseDetailMapper.select(cDetail);
		for (CourseDetail courseDetail : list) {
			String video = courseDetail.getDvideo();
			if(!StringUtils.isEmpty(video)) {
				File videoFile = new File(rootPath+video);
				if(videoFile.exists()) {
					videoFile.delete();
				}
			}
		}
		courseDetailMapper.delete(cDetail);
		return i;
	}

	@Override
	public List<Course> findEight() {
		List<Course> list = courseMapper.findEight();
		return list;
	}

	@Override
	public Course findTeacherById(Integer id) {
		Course course = courseMapper.findTeacherById(id);
		return course;
	}

	@Override
	public List<Course> findByLxJava(String select) {
		List<Course> list = courseMapper.findByLxJava(select);
		return list;
	}

	@Override
	public List<Course> findByLxAi(String select) {
		List<Course> list = courseMapper.findByLxAi(select);
		return list;
	}

	@Override
	public List<Course> findByLxPython(String select) {
		List<Course> list = courseMapper.findByLxPython(select);
		return list;
	}

	@Override
	public List<Course> findByLxProtal(String select) {
		List<Course> list = courseMapper.findByLxProtal(select);
		return list;
	}

	@Override
	public List<Course> findAllCourse() {
		List<Course> list = courseMapper.findAllCourse();
		return list;
	}

	@Override
	public List<Course> findAllCourseByLx(String lx) {
		List<Course> list = courseMapper.findAllCourseByLx(lx);
		return list;
	}

	@Override
	public List<Course> findAllXk() {
		List<Course> list= courseMapper.findAllXk();
		return list;
	}

	@Override
	public List<Course> findBySearch(Course course) {
		Example example=new Example(Course.class);
		Criteria criteria = example.createCriteria();
		if (!StringUtils.isEmpty(course.getName())) {
			criteria.andLike("name", "%"+course.getName()+"%").orLike("content", "%"+course.getName()+"%");
		}
		criteria.andNotEqualTo("parentId", "0");
		List<Course> list= courseMapper.selectByExample(example);
		return list;
	}
	
}
