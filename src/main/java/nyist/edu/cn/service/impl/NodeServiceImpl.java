package nyist.edu.cn.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.entity.RoleNodeKey;
import nyist.edu.cn.mapper.NodeMapper;
import nyist.edu.cn.mapper.RoleNodeMapper;
import nyist.edu.cn.service.NodeService;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;
@Service
@Transactional
public class NodeServiceImpl implements NodeService {
	
	@Autowired
	private NodeMapper nodeMapper;
	@Autowired
	private RoleNodeMapper roleNodeMapper;

	/**
	 * 查询所有节点
	 */
	public ResultPage<Node> findAllNode(ResultPage<Node> resultPage) {
		
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		PageHelper.orderBy("id");//不加报错 ，排序的字段需要和表进行对应  PageHelper.orderBy("id desc");
		Example example = new Example(Node.class);
//		Criteria criteria = example.createCriteria();
		List<Node> list = nodeMapper.selectByExample(example);	
		
		PageInfo<Node> pageInfo = new PageInfo<Node>(list);
		
		resultPage.setCount(pageInfo.getTotal());   //总记录数
		resultPage.setTotalPage(pageInfo.getPages());  //总页数
		resultPage.setData(list);
		
		return resultPage;
	}
	/**
	 * 根据id查询
	 */
	public Node findById(Integer id) {
		Node node = nodeMapper.selectByPrimaryKey(id);
		return node;
	}
	/**
	 * 修改
	 */
	public int modifyNode(Node node) {
		node.setUpdateTime(new Date());
		int i = nodeMapper.updateByPrimaryKeySelective(node);
		return i;
	}
	/**
	 * 添加
	 */
	public int addNode(Node node) {
		node.setCreateTime(new Date());
		node.setUpdateTime(new Date());
		int i = nodeMapper.insert(node);
		return i;
	}
	/**
	 * 删除
	 */
	public int delNode(Integer id) {
		int i = nodeMapper.deleteByPrimaryKey(id);
		// 删除中间表数据
		Example example = new Example(RoleNodeKey.class);
		Criteria criteria = example.createCriteria();
		criteria.andEqualTo("nId",id);
		roleNodeMapper.deleteByExample(example);
		return i;
	}
	/**
	 * 根据角色id查询所有的node节点信息
	 */
	public List<Node> findNodeByRoleId(String rId) {
		List<String> rIds = new ArrayList<String>();
		rIds.add(rId+"");
		List<Node> list = nodeMapper.findNodeByRole(rIds);
		return list;
	}
	/**
	 * 查询所有node，不分页
	 */
	public List<Node> findAllNode() {
		Example example = new Example(Node.class);
		List<Node> list = nodeMapper.selectByExample(example);	
		return list;
	}
	/**
	 * 前台ajax，根据用角色信息查询对应的node,返回对应的json，供前台展开菜单树
	 */
	public List<Node> findNodeAjax(List<String> rIds){
		List<Node> list = nodeMapper.findNodeByRole(rIds);
		//首先需要构造顶层节点
		List<Node> nodeliList = new ArrayList<Node>();
		for (Node node : list) {
			if(node!=null && node.getParentId() == 0){
				nodeliList.add(node);
			}
		}
		//下边遍历所有的顶级节点
		for (Node node : nodeliList) {
			   //获取所有子菜单 递归
            List<Node> childrenList = getchildrenMeun(node.getId(),list);
            //这个是实体类中的子菜单集合
            node.setChildrenList(childrenList);
		}
		
		return nodeliList;
	}
	/**
	 * <p>功能描述：递归得到菜单树</p>
	 * <p>方法名：getchildrenMeun</p>
	 * <p>@param id   父节点id
	 * <p>@param list  所有的符合条件的菜单
	 * <p>@return</p>
	 * <p>返回类型：List<Node></p>
	 * <p>创建日期：2019-6-6 上午9:30:10</p>  
	 * <p>@author：mmy</p>
	 */
	public List<Node> getchildrenMeun(Integer id,List<Node> list){
		  //用于保存子菜单
        List<Node> childrenList = new ArrayList<Node>();
		for (Node node : list) {
			if(node!=null&& id.equals(node.getParentId())){  //这里使用equals比较，为了防止数字过大的问题
				childrenList.add(node);
			}
		} 
		
		//这里就是递归了，遍历所有的子菜单,
		//当childrenList没有值不能遍历的时候，就退出递归
        for (Node node : childrenList) {
			List<Node> getchildrenMeun = getchildrenMeun(node.getId(), list);
			node.setChildrenList(getchildrenMeun);
		}
		
        if(childrenList!=null && childrenList.size()==0){
            return null;
        }
        return  childrenList;
	}
	

}
