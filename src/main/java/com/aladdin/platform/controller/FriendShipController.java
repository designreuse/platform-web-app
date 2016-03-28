package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.FriendshipLinkBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IFriendshipLinkCoreService;
import com.aladdin.core.service.impl.FriendshipLinkCoreServiceImpl;
import com.aladdin.core.vo.FriendshipLinkQueryVo;
import com.aladdin.core.vo.FriendshipLinkSaveVo;
import com.aladdin.core.vo.UserAgreementQueryVo;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by Administrator on 2016/2/19.
 */
@Controller
@RequestMapping("/friendShip")
public class FriendShipController {

    @Resource(name="friendshipLinkCoreService")
    private IFriendshipLinkCoreService friendshipLinkCoreService;
    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public String viewList(Model model){
        model.addAttribute("disabled",constantsCoreService.findConstantsByKey("disabled"));
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        return "friendShip/list";
    }

    @RequestMapping("/friendShipList")
    @ResponseBody
    public EasyUIDataGridBo viewList(FriendshipLinkQueryVo friendshipLinkQueryVo,
            @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
            @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<FriendshipLinkQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(friendshipLinkQueryVo);
        Integer total = friendshipLinkCoreService.countFriendshipLinks(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(friendshipLinkCoreService.findFriendshipLinks(queryParams));
        }
        return bo;
    }


    @RequestMapping("/add")
    public String addView(Model model){
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        return "friendShip/edit";
    }

    @RequestMapping("/{id}/edit")
    public String addView(Model model,@PathVariable(value = "id") Long id){
        FriendshipLinkBo friendshipLinkBo = friendshipLinkCoreService.getFriendshipLinkById(id);
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        model.addAttribute("friendshipLinkBo", friendshipLinkBo);
        return "friendShip/edit";
    }

    @RequestMapping("/changeDisabled")
    @ResponseBody
    public AjaxResult changeStatus(FriendshipLinkSaveVo friendshipLinkSaveVo){
        friendshipLinkSaveVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        friendshipLinkSaveVo.setModifyTime(new Date());
        friendshipLinkCoreService.saveFriendshipLink(friendshipLinkSaveVo);
        return new AjaxResult();
    }

    @RequestMapping("/edit")
    @ResponseBody
    public AjaxResult save(FriendshipLinkSaveVo friendshipLinkSaveVo){
        Long userId = sessionContext.getLoginUser().getUserId();
        friendshipLinkSaveVo.setAppId(Constant.newsColumns.plat.CHINESE_SITE_CODE);
        if(friendshipLinkSaveVo.getId() == null){
            friendshipLinkSaveVo.setCreateBy(userId);
            friendshipLinkSaveVo.setCreateTime(new Date());
        }
        friendshipLinkSaveVo.setModifyTime(new Date());
        friendshipLinkSaveVo.setModifyBy(userId);
        friendshipLinkCoreService.saveFriendshipLink(friendshipLinkSaveVo);
        return new AjaxResult("保存成功");
    }
}
