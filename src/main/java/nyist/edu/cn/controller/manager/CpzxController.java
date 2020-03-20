package nyist.edu.cn.controller.manager;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Cpzx;
import nyist.edu.cn.entity.CpzxJscs;
import nyist.edu.cn.entity.CpzxPic;
import nyist.edu.cn.entity.CpzxVideo;
import nyist.edu.cn.service.CpzxService;
import nyist.edu.cn.vo.ResultPage;

@Controller
@RequestMapping("/manageros/cpzx")
public class CpzxController extends BaseController{
	
	@Autowired
	private CpzxService cpzxService;
	
	/**
	 * <p>功能描述：跳转产品中心list页面</p>
	 * <p>方法名：findBbsb</p>
	 * <p>@param cpzx
	 * <p>@return</p>
	 * <p>返回类型：String</p>
	 * <p>创建日期：2019-8-9 下午5:32:25</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("/findCpzx")
	public String findBbsb(Cpzx cpzx){
		List<Cpzx> list = cpzxService.findByT(cpzx);
		this.setAttribute("list", list);
		Cpzx this_cpzx = cpzxService.findById(cpzx.getParentId());
		this.setAttribute("this_cpzx", this_cpzx);
		return "/admin/cpzx/index";
	}
	/**
	 * <p>功能描述：ajax获取 对应产品中心分类的数据</p>
	 * <p>方法名：cpzxData</p>
	 * <p>@param resultPage
	 * <p>@param cpzx
	 * <p>@return</p>
	 * <p>返回类型：ResultPage<Cpzx></p>
	 * <p>创建日期：2019-8-9 下午5:32:05</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("cpzxData")
	@ResponseBody
	public ResultPage<Cpzx> cpzxData(ResultPage<Cpzx> resultPage,Cpzx cpzx){
		ResultPage<Cpzx> result = cpzxService.findByParam(resultPage, cpzx);
		return result;
	}
	/**
	 * <p>功能描述：前往添加页面</p>
	 * <p>方法名：toAdd</p>
	 * <p>@param cpzx
	 * <p>@return</p>
	 * <p>返回类型：String</p>
	 * <p>创建日期：2019-8-9 下午5:31:54</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("toAdd")
	public String toAdd(Cpzx cpzx){
		Integer parentId = cpzx.getParentId();
		//根据传入的parentId，查询表中对应的 最大id
		Integer newId = cpzxService.findMaxId(parentId);
		if(newId != null){
			newId = newId + 1;
		}else{
			newId = Integer.parseInt(parentId + "01"); 
		}
		this.setAttribute("newId", newId);
		this.setAttribute("parentId", parentId);
		return "/admin/cpzx/cpzx_add";
	}
	/**
	 * <p>功能描述：添加实现</p>
	 * <p>方法名：add</p>
	 * <p>@param cpzx
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-9 下午6:07:54</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("add")
	@ResponseBody
	public Integer add(@RequestParam(value="ptPicFile",required=false)MultipartFile ptPicFile, @RequestParam("file")MultipartFile[] file,Cpzx cpzx,String[] pics,String[] videos,String described
			,String[] videoOldName,String[] picOldName){
		try {
			/*List<CpzxJscs> jscsList = new ArrayList<CpzxJscs>();
			if(project != null){
				for (int i = 0; i < project.length; i++) {
					if(!StringUtils.isEmpty(project[i]) || !StringUtils.isEmpty(company[i]) || !StringUtils.isEmpty(described[i])){  
						CpzxJscs jscs = new CpzxJscs();
						jscs.setCpzxId(cpzx.getId());
						jscs.setProject(project[i]);
						jscs.setCompany(company[i]);
						jscs.setDescribed(described[i]);
						jscsList.add(jscs);
					}
				}
			}*/
			CpzxJscs jscs = new CpzxJscs();
			jscs.setCpzxId(cpzx.getId());
			jscs.setDescribed(described);
			
			String rootPath = this.getSession().getServletContext().getRealPath("/");
	     	String filename = ptPicFile.getOriginalFilename();
	     	String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
	     	//文件路径
	     	String url = "upload/cpzx/"+name;
	     	String path = rootPath+"/"+url;
	     	Map<String, Object> map = new HashMap<String, Object>();
	     	File pathFile = new File(path);
	     	if(!pathFile.exists()){
	     		pathFile.mkdirs();
	     	}
	     	ptPicFile.transferTo(pathFile);
	     	cpzx.setCpPic(url);
			Integer i = cpzxService.add(cpzx,pics,videos,jscs,videoOldName,picOldName);
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
	/**
	 * <p>功能描述：删除实现</p>
	 * <p>方法名：del</p>
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-10 上午10:37:26</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("del")
	@ResponseBody
	public Integer del(Integer id){
		try {
			String rootPath = this.getSession().getServletContext().getRealPath("/");
			Integer i = cpzxService.del(id,rootPath);
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
	/**
	 * <p>功能描述：图片上传</p>
	 * <p>方法名：uploadImg</p>
	 * <p>@return</p>
	 * <p>返回类型：String</p>
	 * <p>创建日期：2019-8-10 上午11:58:03</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping(value="/uploadImg",produces="application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> uploadImg(MultipartFile file){
		//String rootPath = this.getSession().getServletContext().getRealPath("/");
		String rootPath = System.getProperty("user.dir");
     	String filename = file.getOriginalFilename();
     	String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
     	//文件路径
     	rootPath =  rootPath + "/src/main/resources/";
     	String url = "static/upload/"+name;
     	String path = rootPath+"/"+url;
     	Map<String, Object> map = new HashMap<String, Object>();
     	File pathFile = new File(path);
     	if(!pathFile.exists()){
     		pathFile.mkdirs();
     	}
     	try {
     		file.transferTo(new File(path));
     		map.put("code", "0");
     		map.put("msg", "success");
     		map.put("data", url);
     		map.put("filename", filename);
		}  catch (IOException e) { 
			e.printStackTrace();
			map.put("code", "-1");
			map.put("msg", "上传失败");
			map.put("data", "err");
			map.put("filename", "err");
		}
		
		
		return map;
	}
	/**
	 * <p>功能描述：图片预览界面跳转</p>
	 * <p>方法名：toyl</p>
	 * <p>@return</p>
	 * <p>返回类型：String</p>
	 * <p>创建日期：2019-8-10 下午3:54:35</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("/toyl")
	public String toyl(String path,String flag){
		this.setAttribute("path", path);
		if("1".equals(flag)){
			return "/admin/cpzx/pic_view";
		}else{
			return "/admin/cpzx/video_view";
		}
	}
	/**
	 * <p>功能描述：文件删除</p>
	 * <p>方法名：delFile</p>
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-10 下午3:43:43</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping(value="/delFile",produces="application/json;charset=utf-8")
	@ResponseBody
	public Integer delFile(String path){
		try {
			//String rootPath = this.getSession().getServletContext().getRealPath("/");
			String rootPath = System.getProperty("user.dir") + "/src/main/resources/";
			if(!StringUtils.isEmpty(path)){
				path = rootPath + path;
				File file = new File(path);
				if(file.exists()){
					file.delete();
				}
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	/**
	 * <p>功能描述：跳转修改页面</p>
	 * <p>方法名：toUpdate</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：String</p>
	 * <p>创建日期：2019-8-12 下午4:16:30</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("toUpdate")
	public String toUpdate(Integer id){
		Map<String, Object> map = cpzxService.toUpdate(id);
		this.setAttribute("map", map);
		return "/admin/cpzx/cpzx_edit";
	}
	/**
	 * <p>功能描述：修改实现</p>
	 * <p>方法名：update</p>
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-13 下午3:08:34</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("/update")
	@ResponseBody
	public Integer update(@RequestParam(value="ptPicFile",required=false)MultipartFile ptPicFile, @RequestParam("file")MultipartFile[] file,Cpzx cpzx,String[] pics,String[] videos
			,String described,String[] videoOldName,String[] picOldName,
			Integer id,Integer jscsId){
		
		try {
			if(ptPicFile != null){
				String rootPath = this.getSession().getServletContext().getRealPath("/");
			 	String filename = ptPicFile.getOriginalFilename();
			 	if(!StringUtils.isEmpty(filename)){
			 		Cpzx oldCpzx = cpzxService.findById(id);    //获取旧文件
			 		if(oldCpzx != null){
			 			File oldFile = new File(rootPath+"/"+oldCpzx.getCpPic());
			 			if(oldFile.exists()){
			 				oldFile.delete();     //删除旧文件
			 			}
			 		}
			 		String name = UUID.randomUUID().toString()+filename.substring(filename.indexOf("."));
			     	//文件路径
			     	String url = "upload/cpzx/"+name;
			     	String path = rootPath+"/"+url;
			     	File pathFile = new File(path);
			     	if(!pathFile.exists()){
			     		pathFile.mkdirs();
			     	}
			     	ptPicFile.transferTo(pathFile);   //上传新文件
			     	cpzx.setCpPic(url);
			 	}
			}
			/*List<CpzxJscs> jscsList = new ArrayList<CpzxJscs>();
			if(project != null){
				for (int i = 0; i < project.length; i++) {
					if(!StringUtils.isEmpty(project[i]) || !StringUtils.isEmpty(company[i]) || !StringUtils.isEmpty(described[i])){  
						CpzxJscs jscs = new CpzxJscs();
						jscs.setCpzxId(cpzx.getId());
						jscs.setProject(project[i]);
						jscs.setCompany(company[i]);
						jscs.setDescribed(described[i]);
						jscsList.add(jscs);
					}
				}
			}*/
			CpzxJscs jscs = new CpzxJscs();
			jscs.setCpzxId(cpzx.getId());
			jscs.setDescribed(described);
			jscs.setJscsId(jscsId);
			
			
			List<CpzxPic> picList = new ArrayList<CpzxPic>();
			if(pics != null){
				for (int j = 0; j < pics.length; j++) {
					CpzxPic cpzxPic = new CpzxPic();
					cpzxPic.setCpzxId(cpzx.getId());
					cpzxPic.setPic(pics[j]);
					cpzxPic.setPicOldName(picOldName[j]);
					picList.add(cpzxPic);
				}
			}
			List<CpzxVideo> videoList = new ArrayList<CpzxVideo>();
			if(videos != null){
				for (int j = 0; j < videos.length; j++) {
					CpzxVideo cpzxVideo = new CpzxVideo();
					cpzxVideo.setCpzxId(cpzx.getId());
					cpzxVideo.setVideo(videos[j]);
					cpzxVideo.setVideoOldName(videoOldName[j]);
					videoList.add(cpzxVideo);
				}
			}
			
			int i = cpzxService.update(cpzx,jscs,picList,videoList);
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
