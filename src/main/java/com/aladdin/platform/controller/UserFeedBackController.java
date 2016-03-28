package com.aladdin.platform.controller;

import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IUserFeedbackCoreService;
import com.aladdin.core.vo.UserFeedbackQueryVo;
import com.aladdin.platform.bo.view.FeedbackListView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.DateUtil;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by xujingkai on 2015/11/25.
 */
@Controller
@RequestMapping("/userFeedback")
public class UserFeedBackController {


    @Resource(name = "userFeedbackCoreService")
    IUserFeedbackCoreService userFeedbackCoreService;

    @Resource(name = "constantsCoreService")
    IConstantsCoreService constantsCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    private static String PLAT_TYPE="plat_type";
    private static String FEEDBACK_TYPE="message_feedback_type";

    @RequestMapping("/list")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView("/user/feedback");
        List<AldConstantsBo> feedbackTypeList = constantsCoreService.findConstantsByKey(FEEDBACK_TYPE);
        List<AldConstantsBo> platTypeList = constantsCoreService.findConstantsByKey(PLAT_TYPE);
        FeedbackListView feedbackListView = new FeedbackListView();
        feedbackListView.setFeedbackTypeList(feedbackTypeList);
        feedbackListView.setPlatTypeList(platTypeList);

        modelAndView.addObject("view",feedbackListView);
        return modelAndView;
    }

    @RequestMapping("/viewList")
    @ResponseBody
    public EasyUIDataGridBo viewList(UserFeedbackQueryVo userFeedbackQueryVo,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<UserFeedbackQueryVo> queryParams=new QueryParams<UserFeedbackQueryVo>();
        Date date = userFeedbackQueryVo.getCreateTimeEnd();
        if(date!=null){
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            cal.add(Calendar.DATE, 1);
            date = cal.getTime();
            userFeedbackQueryVo.setCreateTimeEnd(date);
        }
        queryParams.setEntity(userFeedbackQueryVo);
        Integer count = userFeedbackCoreService.countUserFeedback(queryParams);
        bo.setTotal(count);
        if(count>0){
            QueryPage queryPage=new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            queryParams.setQueryPage(queryPage);
            bo.setRows(userFeedbackCoreService.findUserFeedback(queryParams));
        }
        return bo;
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 删除商品留言信息
     */
    @RequestMapping(value = "/deleteMessage")
    public @ResponseBody
    AjaxResult deleteMessage(Long id){
        Long currentUserId = sessionContext.getLoginUser().getUserId();

        userFeedbackCoreService.deleteMessage(id,currentUserId);
        return new AjaxResult(true,"删除留言成功");
    }
}
