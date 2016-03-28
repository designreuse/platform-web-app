package com.aladdin.platform.listener;

import com.aladdin.core.service.IUserSyncImService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by wangtaotao on 2016/1/5.
 */
@Service
public class UserSyncImJob {

    @Resource(name = "userSyncImService")
    private IUserSyncImService userSyncImService;

    public void doJob(){
        userSyncImService.userSyncJob();
    }
}
