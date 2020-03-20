package nyist.edu.cn.service;

import java.util.List;

import nyist.edu.cn.entity.Node;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.vo.ResultPage;

public interface UserService {
	User findById(String id);
	/**
	 * <p>功能描述：处理登录</p>
	 * <p>方法名：login</p>
	 * <p>@param user
	 * <p>@return</p>
	 * <p>创建日期：2018-6-21 下午2:52:03</p>  
	 * <p>@author：mmy</p>
	 */
	User login(User user);
	/**
	 * <p>功能描述：根据用户ID查询对应的资源信息</p>
	 * <p>方法名：loginUserNode</p>
	 * <p>@param id
	 * <p>@return</p>
	 * <p>创建日期：2018-6-21 下午3:47:04</p>  
	 * <p>@author：mmy</p>
	 */
	List<Node> loginUserNode(Integer id);
	
	User findRoleByUserId(Integer id);
	/**
	 * <p>功能描述：分页查询all</p>
	 * <p>方法名：findAll</p>
	 * <p>@param page
	 * <p>@param pagesize
	 * <p>@return</p>
	 * <p>创建日期：2018-7-10 上午9:14:10</p>  
	 * <p>@author：mmy</p>
	 */
	ResultPage<User> findAll(ResultPage<User> resultPage,User user);
	/**
	 * 查询所有
	 * @return
	 */
	List<User> findAll();
	
	int addUser(User user,String r_id);
	
	int updateUser(User user,String r_id);
	
	int delUser(String uId);
	/**
	 * 判定用户名是否存在
	 * @param username
	 * @return
	 */
	int selectUserByUname(String username);
	/**
	 * 修改密码
	 */
	int editPwd(User user,String newPwd);
	
	/**
	 * 保存用户
	 * @param user
	 * @return
	 */
	int sava(User user);
	
	/**
	 * 用户登录
	 * @param name
	 * @param pwd
	 * @return
	 */
	User findByTelAndPwd(String name, String pwd);
	
	/**
	 * 根据手机号查重
	 * @param phoneNum
	 * @return
	 */
	User findByTel(String phoneNum);
	
	User findUserByOpenId(String openid);
}
