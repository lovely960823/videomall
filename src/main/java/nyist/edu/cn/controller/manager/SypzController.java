package nyist.edu.cn.controller.manager;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.util.StringUtils;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.God;
import nyist.edu.cn.entity.Lunbo;
import nyist.edu.cn.service.GodService;
import nyist.edu.cn.service.LunboService;
import nyist.edu.cn.vo.ResultPage;

/**
 * 首页配置
 * @author ljw 
 * 2020/1/14
 *
 */
@Controller
public class SypzController extends BaseController {

	
	@Autowired
	private GodService godService;//牛人推荐
	@Autowired
	private LunboService lunboService;//轮播图
	
	
	/**
	 * 到列表页面
	 * @return
	 */
	@RequestMapping("/manageros/god/toGodList")
	public String toGodList() {
		return "admin/sypz/god_list";
	}
	
	/**
	 * 加载数据
	 * @param resultPage
	 * @param god
	 * @return
	 */
	@RequestMapping("/manageros/god/godList")
	@ResponseBody
	public ResultPage<God> getAllGod(ResultPage<God> resultPage,God god){
		ResultPage<God> result = godService.findByName(resultPage, god);
		return result;
	}
	
	/**
	 * 添加页面
	 * @return
	 */
	@RequestMapping("/manageros/god/toAdd")
	public String toAddGod() {
		return "admin/sypz/god_add";
	}
	
	/**
	 * 添加操作
	 * @param god
	 * @param file
	 * @return
	 */
	@RequestMapping("/manageros/god/add")
	@ResponseBody
	public int addGod(God god,@RequestParam(value="imageFile",required=false) MultipartFile file) {
		String rootPath = System.getProperty("user.dir");
		String filename = file.getOriginalFilename();
     	String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
     	rootPath =  rootPath + "/src/main/resources/";
     	String url = "static/upload/"+name;
     	String path = rootPath+"/"+url;
     	File pathFile = new File(path);
     	if(!pathFile.exists()){
     		pathFile.mkdirs();
     	}
     	try {
			file.transferTo(new File(path));
			god.setImg(url);
			int i = godService.save(god);
			if(i>0) {
				return 1;
			}else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} 
	}
	
	/**
	 * 删除实现
	 * @param id
	 * @return
	 */
	@RequestMapping("/manageros/god/godDel")
	@ResponseBody
	public int godDel(Integer id) {
		God g = godService.findById(id);
		int i = godService.deleteByPrimaryKey(id);
		if(i>0) {
			String rootPath = System.getProperty("user.dir");
			rootPath =  rootPath + "/src/main/resources/";
			File f= new File(rootPath+g.getImg());
			f.delete();
			return 1;
		}else {
			return 0;
		}
		
	}
	
	/**
	 * 去修改页面
	 * @param id
	 * @return
	 */
	@RequestMapping("/manageros/god/toUpdate")
	public String toUpdate(Integer id) {
		God god = godService.findById(id);
		this.setAttribute("god", god);
		return "admin/sypz/god_update";
	}
	
	/**
	 * 更新
	 * @param god
	 * @param file
	 * @return
	 */
	@RequestMapping("/manageros/god/update")
	@ResponseBody
	public int doUpdate(God god,@RequestParam(value="imageFile",required=false) MultipartFile file) {
		God g= godService.findById(Integer.parseInt(this.getParameter("id")));
		String rootPath = System.getProperty("user.dir");
		String filename = file.getOriginalFilename();
		//选择就换新的，没选择就用原来的
		if(StringUtils.isEmpty(filename)) {
			god.setImg(g.getImg());
		}else {
			String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
			rootPath =  rootPath + "/src/main/resources/";
			String url = "static/upload/"+name;
			String path = rootPath+"/"+url;
			File pathFile = new File(path);
			if(!pathFile.exists()){
				pathFile.mkdirs();
			}
			try {
				file.transferTo(new File(path));
				god.setImg(url);
				//删除旧的
				File f= new File(rootPath+g.getImg());
				f.delete();
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		int i = godService.updateByPrimaryKeySelective(god);
		 if(i>0) {
			 return 1;
		 }else {
			 return 0;
		 }
	}
	
	
	/**
	 * 轮播图列表
	 * @return
	 */
	@RequestMapping("/manageros/lunbo/toLunboList")
	public String toLunboList() {
		return "admin/sypz/lunbo_list";
	}
	
	@RequestMapping("/manageros/lunbo/lunboList")
	@ResponseBody
	public ResultPage<Lunbo>  lunboList(ResultPage<Lunbo> resultPage,Lunbo lunbo) {
		ResultPage<Lunbo> result = lunboService.findByParam(resultPage, lunbo);
		return result;
	}
	
	/**
	 * 添加页面
	 * @return
	 */
	@RequestMapping("/manageros/lunbo/toAdd")
	public String lunboToAdd() {
		return "admin/sypz/lunbo_add";
	}
	
	@RequestMapping("manageros/lunbo/add")
	@ResponseBody
	public int lunboadd(@RequestParam(value="imageFile",required=false) MultipartFile file) {
		Lunbo lunbo = new Lunbo();
		String rootPath = System.getProperty("user.dir");
		String filename = file.getOriginalFilename();
     	String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
     	rootPath =  rootPath + "/src/main/resources/";
     	String url = "static/upload/"+name;
     	String path = rootPath+"/"+url;
     	File pathFile = new File(path);
     	if(!pathFile.exists()){
     		pathFile.mkdirs();
     	}
     	try {
			file.transferTo(new File(path));
			System.out.println("path="+path);
			lunbo.setImg(url);
			int i = lunboService.save(lunbo);
			if(i>0) {
				return 1;
			}else {
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} 
	}
	
	/**
	 * 轮播删除
	 * @param id
	 * @return
	 */
	@RequestMapping("/manageros/lunbo/lunboDel")
	@ResponseBody
	public int lunboDel(Integer id) {
		Lunbo l = lunboService.findById(id);
		int i = lunboService.deleteByPrimaryKey(id);
		if(i>0) {
			String rootPath = System.getProperty("user.dir");
			rootPath =  rootPath + "/src/main/resources/";
			File f= new File(rootPath+l.getImg());
			f.delete();
			return  1;
		}else {
			return 0;
		}
	}
	
	/**
	 * 修改页面
	 * @param id
	 * @return
	 */
	@RequestMapping("/manageros/lunbo/toUpdate")
	public String toLunoUpdate(Integer id) {
		Lunbo l = lunboService.findById(id);
		this.setAttribute("lunbo", l);
		return "admin/sypz/lunbo_update";
	}
	
	/**
	 * 修改
	 * @param lunbo
	 * @param file
	 * @return
	 */
	@RequestMapping("/manageros/lunbo/update")
	@ResponseBody
	public int doUpdate(Lunbo lunbo,@RequestParam(value="imageFile",required=false) MultipartFile file) {
		Lunbo l= lunboService.findById(Integer.parseInt(this.getParameter("id")));
		String rootPath = System.getProperty("user.dir");
		String filename = file.getOriginalFilename();
		//选择就换新的，没选择就用原来的
		if(StringUtils.isEmpty(filename)) {
			lunbo.setImg(l.getImg());
		}else {
			String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
			rootPath =  rootPath + "/src/main/resources/";
			String url = "static/upload/"+name;
			String path = rootPath+"/"+url;
			File pathFile = new File(path);
			if(!pathFile.exists()){
				pathFile.mkdirs();
			}
			try {
				file.transferTo(new File(path));
				lunbo.setImg(url);
				//删除旧的
				File f= new File(rootPath+l.getImg());
				f.delete();
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		int i = lunboService.updateByPrimaryKeySelective(lunbo);
		 if(i>0) {
			 return 1;
		 }else {
			 return 0;
		 }
	}
}
