package nyist.edu.cn.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nyist.edu.cn.entity.Cpzx;
import nyist.edu.cn.entity.CpzxJscs;
import nyist.edu.cn.entity.CpzxPic;
import nyist.edu.cn.entity.CpzxVideo;
import nyist.edu.cn.mapper.CpzxJscsMapper;
import nyist.edu.cn.mapper.CpzxMapper;
import nyist.edu.cn.mapper.CpzxPicMapper;
import nyist.edu.cn.mapper.CpzxVideoMapper;
import nyist.edu.cn.service.CpzxService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;
/**
 * <p>类功能描述: 产品中心 业务实现类</p>
 * <p>类名：CpzxServiceImpl </p>
 * <p>创建时间：2019-8-9 下午4:16:44 </p>
 * <p>@author：mmy</p>
 */
@Service
@Transactional
public class CpzxServiceImpl extends BaseServiceImpl<Cpzx> implements CpzxService {

	@Autowired
	private CpzxMapper cpzxMapper;
	
	@Autowired
	private CpzxJscsMapper jscsMapper;
	
	@Autowired
	private CpzxPicMapper picMapper;
	
	@Autowired
	private CpzxVideoMapper videoMapper;
	
	/**
	 * 根据parentid查询最大的id
	 */
	public Integer findMaxId(Integer parentId) {
		return cpzxMapper.findMaxId(parentId);
	}
	
	/**
	 * 产品中心 ，产品添加实现
	 */
	public Integer add(Cpzx cpzx, String[] pics, String[] videos, CpzxJscs jscs,String[] videoOldName,String[] picOldName) {
		int i = cpzxMapper.insert(cpzx);
		//下边需要 插入 产品对应的附表信息;  技术参数、产品图片、作业视频等
		jscsMapper.insert(jscs);
		
		if(pics != null){
			for (int j = 0; j < pics.length; j++) {
				CpzxPic cpzxPic = new CpzxPic();
				cpzxPic.setCpzxId(cpzx.getId());
				cpzxPic.setPic(pics[j]);
				cpzxPic.setPicOldName(picOldName[j]);
				picMapper.insert(cpzxPic);
			}
		}
		
		if(videos != null){
			for (int j = 0; j < videos.length; j++) {
				CpzxVideo cpzxVideo = new CpzxVideo();
				cpzxVideo.setCpzxId(cpzx.getId());
				cpzxVideo.setVideo(videos[j]);
				cpzxVideo.setVideoOldName(videoOldName[j]);
				videoMapper.insert(cpzxVideo);
			}
		}
		
		return i;
	}
	
	/**
	 * <p>功能描述：产品中心 ，产品删除实现</p>
	 * <p>方法名：del</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-10 上午10:38:31</p>  
	 * <p>@author：mmy</p>
	 */
	public Integer del(Integer id, String rootPath){
		Cpzx cpzx = cpzxMapper.selectByPrimaryKey(id);
		String cpzxPath = rootPath + "/" + cpzx.getCpPic();
		File file = new File(cpzxPath);
		if(file.exists()){
			file.delete();
		}
		int i = cpzxMapper.deleteByPrimaryKey(id);
		
		Example example = new Example(CpzxJscs.class);
		Criteria criteria = example.createCriteria();
		criteria.andEqualTo("cpzxId", id);
		jscsMapper.deleteByExample(example);
		
		Example examplePic = new Example(CpzxPic.class);
		Criteria criteriaPic = examplePic.createCriteria();
		criteriaPic.andEqualTo("cpzxId", id);
		List<CpzxPic> picList = picMapper.selectByExample(examplePic);
		if(picList != null && picList.size() > 0){
			for (CpzxPic cpzxPic : picList) {
				String picPath = rootPath + "/" + cpzxPic.getPic();
				file  = new File(picPath);
				if(file.exists()){
					file.delete();
				}
			}
		}
		picMapper.deleteByExample(examplePic);
		
		Example exampleVideo = new Example(CpzxVideo.class);
		Criteria criteriaVideo = exampleVideo.createCriteria();
		criteriaVideo.andEqualTo("cpzxId", id);
		List<CpzxVideo> videoList = videoMapper.selectByExample(exampleVideo);
		if(videoList != null && videoList.size() > 0){
			for (CpzxVideo cpzxVideo : videoList) {
				String videoPath = rootPath + "/" + cpzxVideo.getVideo();
				file  = new File(videoPath);
				if(file.exists()){
					file.delete();
				}
			}
		}
		videoMapper.deleteByExample(exampleVideo);
		
		return i;
	}
	/**
	 * 跳转修改页面，查询数据
	 */
	public Map<String, Object> toUpdate(Integer id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Cpzx cpzx = cpzxMapper.selectByPrimaryKey(id);
		map.put("cpzx", cpzx);
		//技术参数
		CpzxJscs jscs = new CpzxJscs();
		jscs.setCpzxId(id);
		List<CpzxJscs> jscsList = jscsMapper.select(jscs);
		/*map.put("jscsList", jscsList);
		map.put("jscsId","");*/
		if(jscsList != null && jscsList.size() > 0){
			map.put("jscsId", jscsList.get(0).getJscsId());
			map.put("jscs", jscsList.get(0));
		}
		//产品图片
		CpzxPic pic = new CpzxPic();
		pic.setCpzxId(id);
		List<CpzxPic> picList = picMapper.select(pic);
		map.put("picList", picList);
		map.put("picId","");
		if(picList != null && picList.size() > 0){
			map.put("picId", picList.get(0).getPicId());
		}
		//产品视频
		CpzxVideo video = new CpzxVideo();
		video.setCpzxId(id);
		List<CpzxVideo> videoList = videoMapper.select(video);
		map.put("videoList", videoList);
		map.put("videoId","");
		if(videoList != null && videoList.size() > 0){
			map.put("videoId", videoList.get(0).getVideoId());
		}
		
		return map;
	}
	/**
	 * <p>功能描述：产品中心，修改功能实现</p>
	 * <p>方法名：update</p>
	 * <p>@param cpzx
	 * <p>@param jscsList
	 * <p>@param picList
	 * <p>@param videoList
	 * <p>@param jscsId
	 * <p>@param picId
	 * <p>@param videoId
	 * <p>@return</p>
	 * <p>返回类型：int</p>
	 * <p>创建日期：2019-8-13 下午3:31:11</p>  
	 * <p>@author：mmy</p>
	 */
	public int update(Cpzx cpzx, CpzxJscs jscs, List<CpzxPic> picList,
			List<CpzxVideo> videoList){
		//先删除 三张附表信息  
		//删除技术参数
		/*CpzxJscs cpzxjscs = new CpzxJscs();
		cpzxjscs.setCpzxId(cpzx.getId());
		jscsMapper.delete(cpzxjscs);*/
		jscsMapper.updateByPrimaryKeySelective(jscs);
		
		//删除 产品图片
		CpzxPic cpzxPic = new CpzxPic();
		cpzxPic.setCpzxId(cpzx.getId());
		picMapper.delete(cpzxPic);
		//删除 作业视频
		CpzxVideo cpzxVideo = new CpzxVideo();
		cpzxVideo.setCpzxId(cpzx.getId());
		videoMapper.delete(cpzxVideo);
		
		//修改 产品信息主表
		int i = cpzxMapper.updateByPrimaryKeySelective(cpzx);
		
		//插入三张附表信息
		/*for (CpzxJscs jscs : jscsList) {
			jscsMapper.insert(jscs);
		}*/
		for (CpzxPic pic : picList) {
			picMapper.insert(pic);
		}
		for (CpzxVideo video : videoList) {
			videoMapper.insert(video);
		}
		
		return i;
	}

	/**
	 * <p>功能描述：查询 前台导航条 下拉产品中心 类别展示</p>
	 * <p>方法名：findNavTopCp</p>
	 * <p>@return</p>
	 * <p>返回类型：List<Cpzx></p>
	 * <p>创建日期：2019-8-21 下午4:40:21</p>  
	 * <p>@author：mmy</p>
	 */
	public List<Cpzx> findNavTopCp(){
		Example example = new Example(Cpzx.class);
		Criteria criteria = example.createCriteria();
		criteria.andLessThan("id", 1000);
		List<Cpzx> list = cpzxMapper.selectByExample(example);
		return list;
	}
	/**
	 * <p>功能描述：查询当前 选中id 下所有的所有产品信息</p>
	 * <p>方法名：findLb</p>
	 * <p>@param id
	 * <p>@param idLength
	 * <p>@return</p>
	 * <p>返回类型：List<Cpzx></p>
	 * <p>创建日期：2019-8-22 上午10:24:59</p>  
	 * <p>@author：mmy</p>
	 */
	public List<Cpzx> findLb(Integer id, int idLength){
		List<Cpzx> list = cpzxMapper.findLb(id,idLength);
		return list;
	}
	/**
	 * <p>功能描述：技术参数 列表页面</p>
	 * <p>方法名：findJscsById</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxJscs></p>
	 * <p>创建日期：2019-8-22 下午4:29:48</p>  
	 * <p>@author：mmy</p>
	 */
	public List<CpzxJscs> findJscsById(Integer id){
		CpzxJscs cpzxjscs = new CpzxJscs();
		cpzxjscs.setCpzxId(id);
		List<CpzxJscs> jscsList = jscsMapper.select(cpzxjscs);
		return jscsList;
	}
	/**
	 * <p>功能描述：得到 	产品图片list页面</p>
	 * <p>方法名：getPicList</p>
	 * <p>@param cpzxPic
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxPic></p>
	 * <p>创建日期：2019-8-22 下午5:38:17</p>  
	 * <p>@author：mmy</p>
	 */
	public List<CpzxPic> getPicList(CpzxPic cpzxPic){
		List<CpzxPic> list = picMapper.select(cpzxPic);
		return list;
	}
	
	/**
	 * <p>功能描述：得到 	产品视频list</p>
	 * <p>方法名：getVideoList</p>
	 * <p>@param video
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxVideo></p>
	 * <p>创建日期：2019-8-22 下午5:41:16</p>  
	 * <p>@author：mmy</p>
	 */
	public List<CpzxVideo> getVideoList(CpzxVideo video){
		return videoMapper.select(video);
	}
}
