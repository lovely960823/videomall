package nyist.edu.cn.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Role;
import nyist.edu.cn.entity.RoleNodeKey;
import nyist.edu.cn.entity.UserRoleKey;
import nyist.edu.cn.mapper.RoleMapper;
import nyist.edu.cn.mapper.RoleNodeMapper;
import nyist.edu.cn.mapper.UserRoleMapper;
import nyist.edu.cn.service.RoleService;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;
@Service
@Transactional
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private RoleNodeMapper roleNodeMapper;
	//添加
	public int addRole(Role role) {
		role.setCreateTime(new Date());
		role.setUpdateTime(new Date());
		int i = roleMapper.insertSelective(role);
		return i;
	}
	//修改
	public int modifyRole(Role role) {
		role.setUpdateTime(new Date());
		int i = roleMapper.updateByPrimaryKeySelective(role);
		return i;
	}
	//删除
	public int delRole(String id) {
		int i = roleMapper.deleteByPrimaryKey(id);
		//删除中间表数据
		//int a = 1/0;
		Example example = new Example(UserRoleKey.class);
		Criteria criteria = example.createCriteria();
		criteria.andEqualTo("rId",id);
		int j = userRoleMapper.deleteByExample(example);
		
		Example example1 = new Example(RoleNodeKey.class);
		Criteria criteria1 = example1.createCriteria();
		criteria1.andEqualTo("rId",id);
		int i1 = roleNodeMapper.deleteByExample(example);
		
		if(i>0){
			return 1;
		}else{
			return 0;
		}
	}
	//查询所有
	public ResultPage<Role> findAllRole(ResultPage<Role> resultPage,Role role) {
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		PageHelper.orderBy("id desc");//不加报错 ，排序的字段需要和表进行对应PageHelper.orderBy("id desc");
		Example example = new Example(Role.class);
		Criteria criteria = example.createCriteria();
		if(role!=null){
			if(!StringUtils.isEmpty(role.getRoleName())){
				criteria.andLike("roleName", "%"+role.getRoleName()+"%");
			}
			if(role.getCreateTime()!=null){
				criteria.andGreaterThanOrEqualTo("createTime", role.getCreateTime());
			}
		}
		
		List<Role> list = roleMapper.selectByExample(example);
		
		PageInfo<Role> pageInfo = new PageInfo<Role>(list);
		
		resultPage.setCount(pageInfo.getTotal());  //总记录数
		resultPage.setTotalPage(pageInfo.getPages());//总页数
		resultPage.setData(list);
		resultPage.setCode(0);
		return resultPage;
	}
	//
	public List<Role> findRoles(){
		return roleMapper.selectAll();
	}
	//根据id查询
	public Role findById(String id) {
		Role role = roleMapper.selectByPrimaryKey(id);
		return role;
	}
	//授权
	public int editRoleGrant(String rId, Integer[] nodes) {
		//先删除
		Example example = new Example(RoleNodeKey.class);
		Criteria criteria = example.createCriteria();
		criteria.andEqualTo("rId",rId);
		int i = roleNodeMapper.deleteByExample(example);
		//再添加
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rId", rId);
		map.put("nodes", nodes);
		int j = roleMapper.editRoleGrant(map);
		return j;
	}

	

}
