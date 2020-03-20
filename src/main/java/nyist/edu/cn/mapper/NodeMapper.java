package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import nyist.edu.cn.entity.Node;
import tk.mybatis.mapper.common.Mapper;

public interface NodeMapper extends Mapper<Node>{
    /**
     * <p>功能描述：根据角色id查询对应的资源信息</p>
     * <p>方法名：findNodeByRole</p>
     * <p>@param rIds
     * <p>@return</p>
     * <p>创建日期：2018-6-21 下午4:37:28</p>  
     * <p>@author：mmy</p>
     */
	List<Node> findNodeByRole(@Param("rIds") List<String> rIds);

}