package nyist.edu.cn.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import nyist.edu.cn.entity.Pl;
import nyist.edu.cn.mapper.PlMapper;
import nyist.edu.cn.service.PlService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;
import nyist.edu.cn.vo.ResultPage;

@Service
@Transactional
public class PlServiceImpl extends BaseServiceImpl<Pl> implements PlService {

	@Autowired
	private PlMapper plMapper;
	
	@Override
	public ResultPage<Pl> findAllAjax(ResultPage<Pl> resultPage, Pl pl) {
		PageHelper.startPage(resultPage.getPage(),resultPage.getLimit());
		PageHelper.orderBy("create_time desc");
		List<Pl> list = plMapper.selectPlAndUser(pl.getCid());
		PageInfo<Pl> pageInfo = new PageInfo<Pl>(list);
		resultPage.setData(list);
		resultPage.setCount(pageInfo.getTotal());
		resultPage.setTotalPage(pageInfo.getPages());
		return resultPage;
	}

	@Override
	public List<Pl> findFivePl(Integer cid) {
		List<Pl> list = plMapper.findFivePl(cid);
		return list;
	}
}
