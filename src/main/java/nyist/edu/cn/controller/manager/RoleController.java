package nyist.edu.cn.controller.manager;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import nyist.edu.cn.controller.base.BaseController;
import nyist.edu.cn.entity.Role;
import nyist.edu.cn.service.RoleService;
import nyist.edu.cn.vo.ResultPage;

@Controller
@RequestMapping("/manageros/role")
public class RoleController extends BaseController{
	@Autowired
	private RoleService roleService;
	
	//添加页面
	@RequestMapping("/toAddRole")
	public String toAddRole(){
		return "/admin/xtgl/role_add";
	}
	
	
	//添加
	@RequestMapping("/addRole")
	@ResponseBody
	public String addRole(Role role){
		int i = roleService.addRole(role);
		if(i>0){
			return "1";
		}else{
			return "0";
		}
	}
	
	//修改前页面回线数据
	@RequestMapping("/updateRoleUI/{id}")
	public String updateRoleUI(@PathVariable String id,HttpServletRequest request){
		Role role = roleService.findById(id);
		request.setAttribute("role", role);
		return "/admin/xtgl/role_edit";
	}
	
	//修改功能实现
	@RequestMapping("/modifyRole")
	@ResponseBody
	public int modifyRole(Role role){
		int i = roleService.modifyRole(role);
		if(i>0){
			return 1;
		}else{
			return 0;
		}
	}
	
	//删除
	@RequestMapping("/delRole/{id}")
	@ResponseBody
	public String delRole(@PathVariable String id,HttpServletRequest request){
		int i = roleService.delRole(id);
		if(i > 0){
			return "1";
		}else{
			return "0";
		}
	}
	//查询所有
	@RequestMapping("/findRoleAjax")
	@ResponseBody
	public ResultPage<Role> findAllRole(ResultPage<Role> resultPage,Role role){
		ResultPage<Role> result = roleService.findAllRole(resultPage,role);
		return result;
	}
	//授权(添加/编辑)
	@RequestMapping("/editRoleGrant")
	@ResponseBody
	public String editRoleGrant(String rId,Integer[] nodes,HttpServletRequest request){
		int i = roleService.editRoleGrant(rId,nodes);
		if(i>0){
			return "1";
		}else{
			return "0";
		}
	}
	
	//跳转到role列表页面
	@RequestMapping("findAllRole")
	public String findAllRolePage(){
		return "/admin/xtgl/role_list";
	}
	
}
