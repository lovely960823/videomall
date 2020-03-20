package nyist.edu.cn.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.entity.Role;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.entity.UserRoleKey;
import nyist.edu.cn.mapper.NodeMapper;
import nyist.edu.cn.mapper.UserMapper;
import nyist.edu.cn.mapper.UserRoleMapper;
import nyist.edu.cn.service.UserService;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private NodeMapper nodeMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	/**
	 * 根据id查询用户
	 */
	public User findById(String id) {
		User user = userMapper.selectByPrimaryKey(id);
		return user;
	}
	/**
	 * 处理登录
	 */
	public User login(User user) {
		String username = user.getUsername();
		String password = user.getPassword();
		password = DigestUtils.md5DigestAsHex(password.getBytes());
		Example example = new Example(User.class);
		Criteria criteria = example.createCriteria();
		criteria.andEqualTo("username",username);
		criteria.andEqualTo("password",password);
		List<User> list = userMapper.selectByExample(example);
		if(list!=null && list.size()>0){
			return list.get(0);
		}
		return null;
	}
	/**
	 * 根据用户ID查询对应的角色信息
	 */
	public List<Node> loginUserNode(Integer id) {
		//查询对应的角色信息
		User user = userMapper.findRoleByUserId(id);
		List<Role> roleList = user.getRoleList();
		List<String> rIds = new ArrayList<String>();
		for (Role role : roleList) {
			rIds.add(role.getId());
		}
		//根据角色信息查询对应的权限
		List<Node> nodeList = nodeMapper.findNodeByRole(rIds);
		return nodeList;
	}
	/**
	 * 根据用户id查询对应的角色 
	 */
	public User findRoleByUserId(Integer id) {
		User user = userMapper.findRoleByUserId(id);
		return user;
	}
	/**
	 * 分页查询all
	 */
	public ResultPage<User> findAll(ResultPage<User> resultPage,User user) {
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		PageHelper.orderBy("a.id");   //不加报错 ，排序的字段需要和表进行对应PageHelper.orderBy("id desc");
		Example example = new Example(User.class);
		//Criteria criteria = example.createCriteria();
		//criteria.andLike("nickname", "c%");
		
		//List<User> list = userMapper.selectByExample(example);
		List<User> list = userMapper.findUserAndRole(user);
		PageInfo<User> pageInfo = new PageInfo<User>(list);
		resultPage.setData(list);
		resultPage.setCount(pageInfo.getTotal());//总记录数
		resultPage.setTotalPage(pageInfo.getPages());//总页数
		resultPage.setCode(0);
		return resultPage;
	}
	
	 public int addUser(User user,String r_id){
		 user.setCreateTime(new Date());
		 user.setUpdateTime(new Date());
		 user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
		 userMapper.insertSelective(user);
		 List<User> user1 = userMapper.select(user);
		 Integer u_id = user1.get(0).getId();
		 String[] rids = r_id.split(",");
		 int i = 0;
		 for (String rid : rids) {
			 UserRoleKey urk = new UserRoleKey();
			 urk.setrId(rid);
			 urk.setuId(u_id);
			 i = userRoleMapper.insert(urk);
		}
		 return i;
	}
	public int updateUser(User user, String r_id){
		//获取旧密码
		String oldPassword = userMapper.selectByPrimaryKey(user.getId()).getPassword();
		String newPassword = user.getPassword();
		//修改密码
		if(oldPassword.equals(newPassword)){
			user.setPassword(null);
		}else{
			user.setPassword(DigestUtils.md5DigestAsHex(newPassword.getBytes()));
		}
		//更新时间
		user.setUpdateTime(new Date());
		userMapper.updateByPrimaryKeySelective(user);
		Example example = new Example(UserRoleKey.class);
		example.createCriteria().andEqualTo("uId",user.getId());
		userRoleMapper.deleteByExample(example);
		 String[] rids = r_id.split(",");
		 for (String rid : rids) {
		 	UserRoleKey urk = new UserRoleKey();
			urk.setrId(rid);
			urk.setuId(user.getId());
			userRoleMapper.insert(urk);
		 }
		
		return 0;
	}
	/**
	 * 删除用户
	 */
	public int delUser(String uId) {
		Example example = new Example(UserRoleKey.class);
		example.createCriteria().andEqualTo("uId",uId);
		int i = userMapper.deleteByPrimaryKey(uId);
		userRoleMapper.deleteByExample(example);
		return i;
	}
	/**
	 * 判定登录名重复
	 */
	public int selectUserByUname(String username) {
		User user = userMapper.selectOneByUname(username);
		if(user!=null){
			return 1;
		}
		return 0;
	}
	/**
	 * 修改密码
	 */
	public int editPwd(User user,String newPwd){
		String oldPwd = userMapper.selectByPrimaryKey(user.getId()).getPassword();
		String pwd = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
		//确认旧密码
		if(!oldPwd.equals(pwd)){
			return -1;
		}
		//新密码加密
		newPwd = DigestUtils.md5DigestAsHex(newPwd.getBytes());
		user.setPassword(newPwd);
		//修改时间
		user.setUpdateTime(new Date());
		//修改
		int i = userMapper.updateByPrimaryKeySelective(user);
		return i;
	}
	public List<User> findAll() {
		List<User> list = userMapper.selectAll();
		return list;
	}
	@Override
	public int sava(User user) {
		int i = userMapper.insert(user);
		//userMapper.insertSelective(record)
		return i;
	}
	@Override
	public User findByTelAndPwd(String name, String pwd) {
		User user = userMapper.findByTelAndPwd(name,pwd);
		return user;
	}
	@Override
	public User findByTel(String phoneNum) {
		User user = userMapper.findByTel(phoneNum);
		return user;
	}
	@Override
	public User findUserByOpenId(String openid) {
		User user =  userMapper.findUserByOpenId(openid);
		return user;
	}
	
}
