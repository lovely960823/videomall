package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.User;
import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User> {
	
	/**
     * <p>功能描述：根据用户ID查询角色信息</p>
     * <p>方法名：findNodeByUserId</p>
     * <p>@param id
     * <p>@return</p>
     * <p>创建日期：2018-6-21 下午3:48:53</p>  
     * <p>@author：mmy</p>
     */
	User findRoleByUserId(Integer id);
	/**
	 * 查询用户和角色
	 * @return
	 */
	List<User> findUserAndRole(@Param("user")User user);
	
	User selectOneByUname(String username);
	
	/**
	 * 登录
	 * @param name
	 * @param pwd
	 * @return
	 */
	@Select(" select * from user where tel=#{name} and password=#{pwd} ")
	User findByTelAndPwd(String name, String pwd);
	
	@Select(" select * from user where tel=#{phoneNum} ")
	User findByTel(String phoneNum);
	
	@Select(" select * from user where openid=#{openid} ")
	User findUserByOpenId(String openid);
	
}