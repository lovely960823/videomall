package nyist.edu.cn.service;

import java.util.List;
import java.util.Map;

import nyist.edu.cn.entity.Cpzx;
import nyist.edu.cn.entity.CpzxJscs;
import nyist.edu.cn.entity.CpzxPic;
import nyist.edu.cn.entity.CpzxVideo;
import nyist.edu.cn.service.base.BaseService;
/**
 * <p>类功能描述:产品中心 实现类</p>
 * <p>类名：CpzxService </p>
 * <p>创建时间：2019-8-9 下午4:15:37 </p>
 * <p>@author：mmy</p>
 */
public interface CpzxService extends BaseService<Cpzx> {
	/**
	 * <p>功能描述：根据parentid查询最大的id</p>
	 * <p>方法名：findMaxId</p>
	 * <p>@param parentId
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-9 下午5:33:06</p>  
	 * <p>@author：mmy</p>
	 */
	Integer findMaxId(Integer parentId);
	/**
	 * <p>功能描述：产品中心 ，产品添加实现</p>
	 * <p>方法名：add</p>
	 * <p>@param cpzx
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-9 下午6:08:34</p>  
	 * <p>@author：mmy</p>
	 * @param jscsList 
	 * @param videos 
	 * @param pics 
	 */
	Integer add(Cpzx cpzx, String[] pics, String[] videos, CpzxJscs jscs,String[] videoOldName,String[] picOldName);
	/**
	 * <p>功能描述：产品中心 ，产品删除实现</p>
	 * <p>方法名：del</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-10 上午10:38:31</p>  
	 * <p>@author：mmy</p>
	 * @param rootPath 
	 */
	Integer del(Integer id, String rootPath);
	/**
	 * <p>功能描述：TODO</p>
	 * <p>方法名：toUpdate</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：Map<String, Object></p>
	 * <p>创建日期：2019-8-12 下午4:16:47</p>  
	 * <p>@author：mmy</p>
	 */
	Map<String, Object> toUpdate(Integer id);
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
	int update(Cpzx cpzx, CpzxJscs jscs, List<CpzxPic> picList,
			List<CpzxVideo> videoList);
	/**
	 * <p>功能描述：查询 前台导航条 下拉产品中心 类别展示</p>
	 * <p>方法名：findNavTopCp</p>
	 * <p>@return</p>
	 * <p>返回类型：List<Cpzx></p>
	 * <p>创建日期：2019-8-21 下午4:40:21</p>  
	 * <p>@author：mmy</p>
	 */
	List<Cpzx> findNavTopCp();
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
	List<Cpzx> findLb(Integer id, int idLength);
	/**
	 * <p>功能描述：技术参数 列表页面</p>
	 * <p>方法名：findJscsById</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxJscs></p>
	 * <p>创建日期：2019-8-22 下午4:29:48</p>  
	 * <p>@author：mmy</p>
	 */
	List<CpzxJscs> findJscsById(Integer id);
	/**
	 * <p>功能描述：得到 	产品图片list页面</p>
	 * <p>方法名：getPicList</p>
	 * <p>@param cpzxPic
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxPic></p>
	 * <p>创建日期：2019-8-22 下午5:38:17</p>  
	 * <p>@author：mmy</p>
	 */
	List<CpzxPic> getPicList(CpzxPic cpzxPic);
	/**
	 * <p>功能描述：得到 	产品视频list</p>
	 * <p>方法名：getVideoList</p>
	 * <p>@param video
	 * <p>@return</p>
	 * <p>返回类型：List<CpzxVideo></p>
	 * <p>创建日期：2019-8-22 下午5:41:16</p>  
	 * <p>@author：mmy</p>
	 */
	List<CpzxVideo> getVideoList(CpzxVideo video);

}
