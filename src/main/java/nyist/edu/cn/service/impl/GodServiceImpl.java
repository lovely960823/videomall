package nyist.edu.cn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.God;
import nyist.edu.cn.entity.User;
import nyist.edu.cn.mapper.GodMapper;
import nyist.edu.cn.service.GodService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import nyist.edu.cn.vo.ResultPage;
import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

@Service
@Transactional
public class GodServiceImpl extends BaseServiceImpl<God> implements GodService {

	@Autowired
	private GodMapper godMapper;
	
	
	@Override
	public ResultPage<God> findByName(ResultPage<God> resultPage, God god) {
		PageHelper.startPage(resultPage.getPage(), resultPage.getLimit());
		PageHelper.orderBy("id desc");   
		Example example = new Example(God.class);
		Criteria createCriteria = example.createCriteria();
		if(!StringUtils.isEmpty(god.getName())) {
			createCriteria.andLike("name", "%"+god.getName()+"%");
		}
		List<God> list = godMapper.selectByExample(example);
		PageInfo<God> pageInfo = new PageInfo<God>(list);
		resultPage.setData(list);
		resultPage.setCount(pageInfo.getTotal());//总记录数
		resultPage.setTotalPage(pageInfo.getPages());//总页数
		resultPage.setCode(0);
		return resultPage;
	}


	@Override
	public List<God> getGod() {
		List<God> list = godMapper.getGod8();
		return list;
	}

}
