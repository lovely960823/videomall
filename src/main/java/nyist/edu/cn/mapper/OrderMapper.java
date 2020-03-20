package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.Order;
import tk.mybatis.mapper.common.Mapper;

public interface OrderMapper extends Mapper<Order> {

	@Select(" select * from shop_order where cid=#{cid} and uid=#{uid} ")
	List<Order> findByCidAndUid(Integer cid, Integer uid);

	@Select(" select * from shop_order where uid=#{uid} ")
	List<Order> findByUid(Integer uid);

}
