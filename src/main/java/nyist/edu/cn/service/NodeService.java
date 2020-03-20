package nyist.edu.cn.service;


import java.util.List;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.vo.ResultPage;

public interface NodeService {
	/**
	 * <p>功能描述：查询所有节点信息</p>
	 * <p>方法名：findAllNode</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-22 上午9:36:37</p>  
	 * <p>@author：mmy</p>
	 */
	ResultPage<Node> findAllNode(ResultPage<Node> resultPage);
	/**
	 * <p>功能描述：根据id查询</p>
	 * <p>方法名：findById</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>创建日期：2018-6-22 下午3:33:52</p>  
	 * <p>@author：mmy</p>
	 */
	Node findById(Integer id);
	/**
	 * <p>功能描述：修改node</p>
	 * <p>方法名：modifyNode</p>
	 * <p>@param node</p>
	 * <p>创建日期：2018-6-22 下午3:59:49</p>  
	 * <p>@author：mmy</p>
	 */
	int modifyNode(Node node);
	/**
	 * <p>功能描述：添加node</p>
	 * <p>方法名：addNode</p>
	 * <p>@param node
	 * <p>@return</p>
	 * <p>创建日期：2018-6-22 下午4:20:06</p>  
	 * <p>@author：mmy</p>
	 */
	int addNode(Node node);
	/**
	 * <p>功能描述：通过id删除</p>
	 * <p>方法名：delNode</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>创建日期：2018-6-22 下午4:22:02</p>  
	 * <p>@author：mmy</p>
	 */
	int delNode(Integer id);
	/**
	 * <p>功能描述：根据角色id查询node信息</p>
	 * <p>方法名：findNodeByRoleId</p>
	 * <p>@param rId
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 上午11:14:39</p>  
	 * <p>@author：mmy</p>
	 */
	List<Node> findNodeByRoleId(String rId);
	/**
	 * <p>功能描述：查询所有node 不分页</p>
	 * <p>方法名：findAllNode</p>
	 * <p>@return</p>
	 * <p>创建日期：2018-6-23 下午4:30:28</p>  
	 * <p>@author：mmy</p>
	 */
	List<Node> findAllNode();
	/**
	 * <p>功能描述：前台ajax，根据用角色信息查询对应的node,返回对应的json，供前台展开菜单树</p>
	 * <p>方法名：findNodeAjax</p>
	 * <p>@param rIds
	 * <p>@return</p>
	 * <p>返回类型：List<Node></p>
	 * <p>创建日期：2019-6-6 上午9:09:08</p>  
	 * <p>@author：mmy</p>
	 */
	List<Node> findNodeAjax(List<String> rIds);
}
