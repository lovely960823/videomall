package nyist.edu.cn.mapper;

import java.util.Map;

import nyist.edu.cn.entity.Role;
import tk.mybatis.mapper.common.Mapper;

public interface RoleMapper extends Mapper<Role>{
    /**
     * <p>功能描述：给角色授权,向中间表插入数据</p>
     * <p>方法名：editRoleGrant</p>
     * <p>@param map
     * <p>@return</p>
     * <p>创建日期：2018-6-23 下午5:17:16</p>  
     * <p>@author：mmy</p>
     */
	int editRoleGrant(Map<String, Object> map);
}