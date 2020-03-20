package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.God;
import tk.mybatis.mapper.common.Mapper;

public interface GodMapper extends Mapper<God> {

	@Select(" select * from god limit 8 ")
	List<God> getGod8();

}
