package nyist.edu.cn.controller.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Course;
import nyist.edu.cn.entity.Order;
import nyist.edu.cn.service.CourseService;
import nyist.edu.cn.service.OrderService;

/**
 * 购物车一系列操作
 * @author ljw
 *
 */
@Controller
public class ShopController extends BaseController {

	@Autowired
	private StringRedisTemplate redisTemplate;
	@Autowired
	private CourseService courseService;
	@Autowired
	private OrderService orderService;
	
	/**
	 * 购物车
	 * @param cid
	 * @param uid
	 * @return
	 */
	@RequestMapping("/back/car/shopcar")
	@ResponseBody
	public int shopcar(Integer cid,Integer uid){
		
		List<Order> orderList = orderService.findByCidAndUid(cid,uid);
		if(orderList.size()>0){
			return 0;//买过
		}
		
		Boolean member = redisTemplate.opsForSet().isMember("shopcar:"+uid.toString(), cid.toString());
		if(member){//购物车已经添加的有
			return 1;
		}else{//添加购物车
			redisTemplate.opsForSet().add("shopcar:"+uid.toString(), cid.toString());
			return 2;
		}
	}
	
	/**
	 * 购物车任务列表页面
	 * @date 2020/1/31
	 * @param uid
	 * @return
	 */
	@RequestMapping("/back/memeber/myshopcar/{uid}")
	public String myshop(@PathVariable Integer uid){
		/*Long size = redisTemplate.opsForSet().size("shopcar:"+uid.toString());
		if(size>0){
			List<Integer> list = new ArrayList<>();
			Set<String> members = redisTemplate.opsForSet().members("shopcar:"+uid.toString());
			for(String x:members){
				list.add(Integer.parseInt(x));
			}
			List<Course> shopList = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				Course course = courseService.findById(list.get(i));
				shopList.add(course);
			}
			this.setAttribute("shopList", shopList);
		}*/
		return "protal/memeber/learing-shopping-order";
	}
	
	/**
	 * 购物车数据页面
	 * @date 2020/1/31
	 * @param uid
	 * @return
	 */
	@RequestMapping("/back/memeber/myshopcarList")
	@ResponseBody
	public List<Course> myshopcar(Integer uid){
		Long size = redisTemplate.opsForSet().size("shopcar:"+uid.toString());
		List<Course> shopList = new ArrayList<>();
		if(size>0){
			List<Integer> list = new ArrayList<>();
			Set<String> members = redisTemplate.opsForSet().members("shopcar:"+uid.toString());
			for(String x:members){
				list.add(Integer.parseInt(x));
			}
			for (int i = 0; i < list.size(); i++) {
				Course course = courseService.findById(list.get(i));
				shopList.add(course);
			}
		}
		return shopList;
	}
	
	/**
	 * 移除购物车
	 * @date 2020/1/31
	 * @param uid
	 * @param idArr
	 * @return
	 */
	@RequestMapping("/back/memeber/removeShopCar")
	@ResponseBody
	public int remove(Integer uid,String idArr){
		System.out.println("********"+idArr);
		String[] split = idArr.split(",");
		for(String str:split){
			redisTemplate.opsForSet().remove("shopcar:"+uid.toString(), str);
		}
		return 1;
	}
}
