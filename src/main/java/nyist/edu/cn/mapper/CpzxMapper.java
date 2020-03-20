package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import nyist.edu.cn.entity.Cpzx;
import tk.mybatis.mapper.common.Mapper;
/**
 * <p>类功能描述:产品中心 mapper </p>
 * <p>类名：CpzxMapper </p>
 * <p>创建时间：2019-8-9 下午4:17:21 </p>
 * <p>@author：mmy</p>
 */
public interface CpzxMapper extends Mapper<Cpzx>{
	/**
	 * <p>功能描述：根据parentid查询最大的id</p>
	 * <p>方法名：findMaxId</p>
	 * <p>@param parentId
	 * <p>@return</p>
	 * <p>返回类型：Integer</p>
	 * <p>创建日期：2019-8-9 下午5:41:13</p>  
	 * <p>@author：mmy</p>
	 */
	Integer findMaxId(@Param("parentId") Integer parentId);
	/**
	 * <p>功能描述：查询当前 选中id 下所有的所有产品信息</p>
	 * <p>方法名：findLb</p>
	 * <p>@param id
	 * <p>@param idLength
	 * <p>@return</p>
	 * <p>返回类型：List<Cpzx></p>
	 * <p>创建日期：2019-8-22 上午10:27:52</p>  
	 * <p>@author：mmy</p>
	 */
	List<Cpzx> findLb(@Param("id")Integer id, @Param("idLength")int idLength);

}
