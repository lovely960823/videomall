package nyist.edu.cn.service;


import java.util.List;

import nyist.edu.cn.entity.Role;
import nyist.edu.cn.vo.ResultPage;

public interface RoleService {

	/**
	 * <p>功能描述：添加角色</p>
	 * <p>方法名：addRole</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午9:22:46</p>  
	 * <p>@author：mmy</p>
	 */
	int addRole(Role role);
	/**
	 * <p>功能描述：修改角色</p>
	 * <p>方法名：modifyRole</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午9:23:33</p>  
	 * <p>@author：mmy</p>
	 */
	int modifyRole(Role role);
	/**
	 * <p>功能描述：删除角色</p>
	 * <p>方法名：delRole</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午9:23:44</p>  
	 * <p>@author：mmy</p>
	 */
	int delRole(String id);
	/**
	 * <p>功能描述：查询所有角色</p>
	 * <p>方法名：findAllRole</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午9:23:53</p>  
	 * <p>@author：mmy</p>
	 */
	ResultPage<Role> findAllRole(ResultPage<Role> resultPage,Role role);
	/**
	 * <p>功能描述：根据id查询</p>
	 * <p>方法名：findById</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午9:37:47</p>  
	 * <p>@author：mmy</p>
	 */
	Role findById(String id);
	/**
	 * <p>功能描述：给角色授权</p>
	 * <p>方法名：editRoleGrant</p>
	 * <p>@param rId
	 * <p>@param nodes
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 下午5:12:25</p>  
	 * <p>@author：mmy</p>
	 */
	int editRoleGrant(String rId, Integer[] nodes);
	
	
	List<Role> findRoles();
}
