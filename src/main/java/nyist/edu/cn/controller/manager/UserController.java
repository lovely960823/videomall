package nyist.edu.cn.controller.manager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.entity.Role;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.service.RoleService;
import nyist.edu.cn.service.UserService;
import nyist.edu.cn.vo.ResultPage;

@Controller
@RequestMapping("/manageros/user")
public class UserController {
	
	/*@RequestMapping("/toLogin")
	public String toLogin(){
		return "login";
	}*/
	
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;

	@RequestMapping("/findById/{id}")
	@ResponseBody
	public User findById(@PathVariable String id){
		User user = userService.findById(id);
		return user;
	}
	
	@RequestMapping("/findAll")
	public String findAll(){
		
		return "admin/xtgl/user_list";
	}	
	
	@RequestMapping("findUserAjax")
	@ResponseBody
	public ResultPage<User> findUserAjax(ResultPage<User> resultPage,HttpServletRequest request,User user){
		ResultPage<User> result = userService.findAll(resultPage,user);
		return result;
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request){
		
		return "/admin/main";
	}
	
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request){
		User loginUser = userService.login(user);
		if(loginUser != null){
			//将用户信息存入session
			HttpSession session = request.getSession();
			session.removeAttribute("loginUser");
			loginUser = userService.findRoleByUserId(loginUser.getId());
			session.setAttribute("loginUser", loginUser);
			return "redirect:/manageros/user/index";
		}else{
			request.setAttribute("msg4", 1);
			return "login";
		}
		
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();//销毁session
		return "login";
	}
	/**
	 * 根据用户id查询对应的资源信息
	 */
	@RequestMapping("/loginUserNode")
	public String loginUserNode(Integer id,HttpServletRequest request){
		List<Node> nodelist = userService.loginUserNode(id);
		request.setAttribute("nodelist", nodelist);
		return "/admin/include/behind_left";
	}
	
	/**
	 * 跳转到添加用户页面
	 */
	@RequestMapping("/toAddUser")
	public String toAddUser(HttpServletRequest request){
		List<Role> roles = roleService.findRoles();
		request.setAttribute("roles", roles);
		return "admin/xtgl/user_add";
		
	}
	/**
	 * 添加用户
	 */
	@RequestMapping("/addUser")
	@ResponseBody
	public String addUser(User user,String r_id){
		userService.addUser(user, r_id);
		return "1";
	}
	/**
	 * 跳转到编辑页面
	 * 
	 */
	@RequestMapping("/toEditUser")
	public String toEditUser(Integer id,HttpServletRequest request){
		User user = userService.findRoleByUserId(id);
		List<Role> roles = roleService.findRoles();
		request.setAttribute("user", user);
		request.setAttribute("roles", roles);
		return "admin/xtgl/user_edit";
	}
	/**
	 * 修改用户
	 * @param user
	 * @param r_id
	 * @return
	 */
	@RequestMapping("/editUser")
	@ResponseBody
	public String editUser(User user,String r_id){
		userService.updateUser(user, r_id);
		return "1";
	}
	
	@RequestMapping("/delUser")
	@ResponseBody
	public int delUser(String id){
		int i = userService.delUser(id);
		return i;
	}
	
	/**
	 * 判定用户名是否存在
	 */
	@RequestMapping("/selectUserByUname")
	@ResponseBody
	public int selectUserByUname(String username){
		int i = userService.selectUserByUname(username);
		return i;
	}
	/**
	 * 跳转修改密码页面
	 */
	@RequestMapping("/toEditPwd")
	public String toEditPwd(){
		return "admin/xtgl/pwd_edit";
	}
	/**
	 *修改密码 
	 *
	 */
	@RequestMapping("/editPwd")
	@ResponseBody
	public int editPwd(User user,String newPwd){
		int i = userService.editPwd(user, newPwd);
		return i;
	}
	
}
