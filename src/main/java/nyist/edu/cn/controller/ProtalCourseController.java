package nyist.edu.cn.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.CourseDetail;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.entity.Pl;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.CourseDetailService;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.OrderService;
import nyist.edu.cn.service.PlService;
import nyist.edu.cn.vo.ResultPage;

@Controller
public class ProtalCourseController extends BaseController {

	@Autowired
	private CourseService courseService;
	@Autowired
	private CourseDetailService courseDetailService;
	@Autowired
	private PlService plService;
	@Autowired
	private StringRedisTemplate redisTemplate;
	@Autowired
	private OrderService orderService;
	
	/**
	 * 点击详情页面
	 * @param id
	 * @return
	 */
	@RequestMapping("/course/courseDetail/{id}")
	public String courseDetail(@PathVariable Integer id){
		//修改浏览次数
		Course c= courseService.findById(id);
		c.setViews(c.getViews()+1);
		courseService.updateByPrimaryKeySelective(c);
		//点击 观看默认观看第一个视频
		List<CourseDetail> courseDetailList = courseDetailService.findAllByCid(c.getId());
		CourseDetail courseDetail= courseDetailList.get(0);
		this.setAttribute("courseDetail", courseDetail);
		//查询到该课程以及老师资料
		Course course = courseService.findTeacherById(id);
		this.setAttribute("course", course);
		//判断是否购买过
		int isShopped=0;//没买过
		User user = (User)this.getRequest().getSession().getAttribute("loginUser");
		if(user!=null){
			List<Order> order = orderService.findByCidAndUid(id, user.getId());
			if(!order.isEmpty()){
				isShopped=1;
			}
		}
		this.setAttribute("isShopped", isShopped);
		return "protal/memeber/learing-article";
	}
	
	/**
	 * 课程详情右边的评价取五条
	 * @param cid
	 * @return
	 */
	@RequestMapping("/course/fivePl")
	@ResponseBody
	public List<Pl> fivePl(Integer cid){
		List<Pl> fivePl= plService.findFivePl(cid);
		return fivePl;
	}
	
	/**
	 * 详情里面的目录
	 * @param id
	 * @return
	 */
	@RequestMapping("/courseDetail/muluList")
	@ResponseBody
	public List<CourseDetail> muluList(Integer id){
		List<CourseDetail> list = courseDetailService.findAllByCid(id);
		return list;
	}
	
	/**
	 * 视频播放页
	 * @param detailid coursedetail 的id
	 * @date 2020/1/26
	 * @return
	 */
	@RequestMapping("/course/courseVedio/{detailid}")
	public String vedio(@PathVariable Integer detailid){
		//保存最新的数据
		User user = (User)this.getRequest().getSession().getAttribute("loginUser");
		Long size = redisTemplate.opsForList().size("recently:"+user.getId());//集合长度
		List<String> range = redisTemplate.opsForList().range("recently:"+user.getId(), 0, -1);//集合值
		boolean contains = range.contains(detailid.toString());
		if(contains){
			if(size>=5){
				//TODO
			}
			redisTemplate.opsForList().remove("recently:"+user.getId(), 1, detailid.toString());
		}
		redisTemplate.opsForList().leftPush("recently:"+user.getId(), detailid.toString());
		System.out.println("****"+size);
		CourseDetail courseDetail = courseDetailService.findById(detailid);
		this.setAttribute("courseDetail", courseDetail);
		//上篇下篇
		List<CourseDetail> list = courseDetailService.findAllByCid(courseDetail.getCid());
		int pre=0;
		int next=0;
		for(int i=0;i<list.size();i++) {
			if(list.get(i).getId().equals(detailid)){
				if(i != 0){
					pre=list.get(i-1).getId();
					this.getRequest().setAttribute("preNews", list.get(i-1));
				}
				if(i != list.size() -1){
					next=list.get(i+1).getId();
					this.getRequest().setAttribute("nextNews", list.get(i+1));
				}
			}
		}
        this.getRequest().setAttribute("pre", pre);
        this.getRequest().setAttribute("next", next);
		return "protal/memeber/vedio";
	}
	
	/**
	 * java列表
	 * @param lx
	 * @return
	 */
	@RequestMapping("/course/javaList")
	@ResponseBody
	public List<Course> javalist(Integer lx){
		String select="初%";
		if(lx==1){
			select="初%";
		}
		if(lx==2){
			select="中%";
		}
		if(lx==3){
			select="高%";
		}
		List<Course> javaList= courseService.findByLxJava(select);
		return javaList;
	}
	
	/**
	 * 人工智能
	 * @param lx
	 * @return
	 */
	@RequestMapping("/course/aiList")
	@ResponseBody
	public List<Course> ailist(Integer lx){
		String select="初%";
		if(lx==1){
			select="初%";
		}
		if(lx==2){
			select="中%";
		}
		if(lx==3){
			select="高%";
		}
		List<Course> aiList= courseService.findByLxAi(select);
		return aiList;
	}
	
	/**
	 * python
	 * @param lx
	 * @return
	 */
	@RequestMapping("/course/pythonList")
	@ResponseBody
	public List<Course> pythonList(Integer lx){
		String select="初%";
		if(lx==1){
			select="初%";
		}
		if(lx==2){
			select="中%";
		}
		if(lx==3){
			select="高%";
		}
		List<Course> aiList= courseService.findByLxPython(select);
		return aiList;
	}
	
	/**
	 * 前端
	 * @param lx
	 * @return
	 */
	@RequestMapping("/course/protalList")
	@ResponseBody
	public List<Course> protalList(Integer lx){
		String select="初%";
		if(lx==1){
			select="初%";
		}
		if(lx==2){
			select="中%";
		}
		if(lx==3){
			select="高%";
		}
		List<Course> aiList= courseService.findByLxProtal(select);
		return aiList;
	}
	
	/**
	 * 查看全部页面
	 * @param lx
	 * @return
	 */
	@RequestMapping("/course/allCourse/{lx}")
	public String getAllCourse(@PathVariable String lx){
		List<Course> list= new ArrayList<>();
		if(lx.equals("0")){//查询所有
			list = courseService.findAllCourse();
		}else{//根据类型查所有
			list = courseService.findAllCourseByLx(lx);
		}
		this.setAttribute("list", list);
		return "protal/memeber/learing-list";
	}
	
	/**
	 * 收藏和取消收藏
	 * @param cid
	 * @param uid
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/course/shoucang")
	public Boolean shoucang(Integer cid,Integer uid){
		Boolean member = redisTemplate.opsForSet().isMember("shoucang:"+uid, cid.toString());
		if(member){
			redisTemplate.opsForSet().remove("shoucang:"+uid, cid.toString());
		}else{
			redisTemplate.opsForSet().add("shoucang:"+uid, cid.toString());
		}
		return member;
	}
	
	/**
	 * 我的收藏
	 * @param uid
	 * @param resultPage
	 * @return
	 */
	@RequestMapping("/back/memeber/myliked/{uid}")
	public String myliked(@PathVariable Integer uid,ResultPage<Course> resultPage){
		//收藏的课程id,暂时先不分页，以后再说
		Set<String> members = redisTemplate.opsForSet().members("shoucang:"+uid);
		List<Course> list = new ArrayList<Course>();
		for(String id:members){
			Course course = courseService.findById(id);
			list.add(course);
		}
		this.setAttribute("list", list);
		return "protal/memeber/myliked";
	}
	/**
	 * 判断是否购买过，决定是否能否观看
	 * @param cid
	 * @param uid
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/back/isview")
	public int isView(Integer cid,Integer uid){
		List<Order> orderList = orderService.findByCidAndUid(cid,uid);
		System.out.println("这是长度啊"+orderList.size());
		if(orderList.size()>0){
			return 0;//买过
		}else{
			return 1;
		}
	}
	
	/**
	 * 顶部的搜索，模糊搜索
	 * name或者content 的like比较
	 * @param course
	 * @return
	 */
	@RequestMapping("/searchList")
	public String searchList(Course course){
		List<Course> list = courseService.findBySearch(course);
		this.setAttribute("list", list);
		return "protal/memeber/searchList";
	}
}
