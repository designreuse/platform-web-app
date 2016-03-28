package com.aladdin.platform.listener;

import com.aladdin.core.bo.UserBo;
import com.aladdin.core.dao.IAldUserCoreDao;
import com.aladdin.core.service.IUserCoreService;
import com.aladdin.platform.utils.DateUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by wangtaotao on 2015/12/31.
 */
@Service
public class SendMessageJob {

    @Resource(name = "aldUserCoreDao")
    private IAldUserCoreDao aldUserCoreDao;
    @Resource(name="userCoreService")
    private IUserCoreService userCoreService;


    public void doJob(){
        String message = "你好，这里是神灯路对俄贸易平台。您已3个月未登录平台账户。请您经常登陆平台留意订单变化，如有疑问请致电+86-4006-0470-86。或登陆http://www.51aladdin.com 在线咨询。";
        List<UserBo> userBoList = aldUserCoreDao.findUserByLoginTime(DateUtil.getBeforeDate(new Date(),3,DateUtil.DateNumberType.MONTH));
        for(UserBo bo:userBoList){
            userCoreService.seedCaptchaSms(bo.getMobile(),message);
        }
    }


}
