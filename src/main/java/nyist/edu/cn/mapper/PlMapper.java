package nyist.edu.cn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import nyist.edu.cn.entity.Pl;
import tk.mybatis.mapper.common.Mapper;

public interface PlMapper extends Mapper<Pl> {

	List<Pl> selectPlAndUser(@Param("cid")Integer cid);

	List<Pl> findFivePl(@Param("cid")Integer cid);

}
