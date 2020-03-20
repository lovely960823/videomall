package nyist.edu.cn.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nyist.edu.cn.entity.Lunbo;
import nyist.edu.cn.service.LunboService;
import nyist.edu.cn.service.base.impl.BaseServiceImpl;

@Service
@Transactional
public class LunboServiceImpl extends BaseServiceImpl<Lunbo> implements LunboService {

}
