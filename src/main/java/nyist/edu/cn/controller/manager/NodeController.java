package nyist.edu.cn.controller.manager;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.entity.Role;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.NodeService;
import nyist.edu.cn.vo.ResultPage;

@Controller
@RequestMapping("/manageros/node")
public class NodeController {

	@Autowired
	private NodeService nodeService;
	
	@RequestMapping("/toAdd")
	public String toAdd(){
		return "/admin/xtgl/node_add";
	}
	
	//查询所有   page当前页，rows每页显示记录数
	@RequestMapping("/findAllNode")  
	public String findAllNode(HttpServletRequest request,ResultPage<Node> resultPage){
		ResultPage<Node> result = nodeService.findAllNode(resultPage);
		request.setAttribute("result", result);
		return "/admin/xtgl/node_list";
	}
	//编辑前页面回显数据
	@RequestMapping("/updateNodeUI")
	public String updateNodeUI(Integer id,HttpServletRequest request){
		Node node = nodeService.findById(id);
		request.setAttribute("node", node);
		return "/admin/xtgl/node_edit";
	}
	//修改
	@RequestMapping("/modifyNode")
	@ResponseBody
	public String modifyNode(Node node){
		int i = nodeService.modifyNode(node);
		if(i>0){
			return "1";
		}else{
			return "0";
		}
	}
	//添加
	@RequestMapping(value="/addNode",method=RequestMethod.POST)
	@ResponseBody
	public int addNode(Node node){
		int i = nodeService.addNode(node);
		if(i>0){
			return 1;
		}else{
			return 0;
		}
	}
	//删除
	@RequestMapping("/delNode/{id}")
	@ResponseBody
	public String delNode(@PathVariable Integer id,HttpServletRequest request){
		int i = nodeService.delNode(id);
		if(i > 0){
			return "1";
		}else{
			return "0";
		}
	}
	/**
	 * 角色授权   查询 对应node
	 */
	@RequestMapping("/grantUI/{rId}")
	public String grantUI(@PathVariable String rId,HttpServletRequest request){
		List<Node> nodelist = nodeService.findAllNode();
		List<Node> list = nodeService.findNodeByRoleId(rId);
		String nodes = "";
		if(list!=null){
			for (Node node : list) {
				if(node != null){
					nodes = nodes + node.getId()+",";
				}
			}
		}
		if(!"".equals(nodes)){
			nodes = nodes.substring(0,nodes.length()-1);
		}
		request.setAttribute("param_nodes", nodes);
		request.setAttribute("rId", rId);
		request.setAttribute("nodelist", nodelist);
		
		return "/admin/xtgl/role_grant";
	}
	/**
	 * <p>功能描述：前台获取 菜单树 json数组</p>
	 * <p>方法名：findNodeAjax</p>
	 * <p>@param request
	 * <p>@return</p>
	 * <p>返回类型：List<Node></p>
	 * <p>创建日期：2019-6-6 上午9:42:49</p>  
	 * <p>@author：mmy</p>
	 */
	@RequestMapping("/findNodeAjax")
	@ResponseBody
	public List<Node> findNodeAjax(HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		List<Role> roleList = user.getRoleList();
		List<String> rIds = new ArrayList<String>();
		for (Role role : roleList) {
			rIds.add(role.getId());
		}
		//调用方法
		List<Node> nodeList = nodeService.findNodeAjax(rIds);
		return  nodeList;
	}
	
	
}
