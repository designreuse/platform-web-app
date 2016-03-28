package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.UserAgreementBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.IUserAgreementCoreService;
import com.aladdin.core.service.impl.UserAgreementCoreServcieImpl;
import com.aladdin.core.vo.OrderQueryVo;
import com.aladdin.core.vo.UserAgreementQueryVo;
import com.aladdin.core.vo.UserAgreementSaveVo;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by Administrator on 2016/2/19.
 */
@Controller
@RequestMapping("/userAgreement")
public class UserAgreementController {

    @Resource(name="userAgreementCoreService")
    private IUserAgreementCoreService userAgreementCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public String viewList(){
        return "userAgreement/list";
    }

    @RequestMapping("/agreementList")
    @ResponseBody
    public EasyUIDataGridBo viewList(
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<UserAgreementQueryVo> queryParams = new QueryParams();
        Integer total = userAgreementCoreService.countUserAgreement(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(userAgreementCoreService.findUserAgreement(queryParams));
        }
        return bo;
    }


    @RequestMapping("/{id}/edit")
    public String edit(Model model,@PathVariable(value = "id") Long id){
        UserAgreementBo userAgreementBo = userAgreementCoreService.getUserAgreementById(id);
        model.addAttribute("userAgreement",userAgreementBo);
        return "userAgreement/edit";
    }

    @RequestMapping("/edit")
    public String edit(RedirectAttributes attributes,UserAgreementSaveVo userAgreementSaveVo){
        userAgreementSaveVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        userAgreementSaveVo.setModifyTime(new Date());
        userAgreementCoreService.saveUserAgreement(userAgreementSaveVo);
        attributes.addFlashAttribute("msg", "保存成功！");
        return "userAgreement/list";
    }
}
