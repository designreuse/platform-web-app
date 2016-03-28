package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AdLocationBo;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.BannerBo;
import com.aladdin.core.bo.SpecialAdBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IAdCoreService;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.vo.*;
import com.aladdin.inf.vo.InfBannerVo;
import com.aladdin.platform.bo.view.BannerAddView;
import com.aladdin.platform.bo.view.BannerListView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.utils.JsonUtils;
import com.alibaba.fastjson.JSONArray;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
@RequestMapping("/banner")
public class BannerController {

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "adCoreService")
    private IAdCoreService adCoreService;

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    /**
     * 跳转到广告列表页面
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView viewBannerlist(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.PLAT_TYPE);
        for (int i=0 ;i< platTypes.size();i++){
            if(platTypes.get(i).getConstValue().equals(Constant.newsColumns.plat.PLAT_FORM_CODE.toString())){
                platTypes.remove(i);
                break;
            }
        }
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AdLocationBo> adLocations = adCoreService.findAdLocation(new QueryParams<AdLocationVo>());
        BannerListView bannerListView = new BannerListView();
        bannerListView.setPlatTypes(platTypes);
        bannerListView.setDisableds(disableds);
        bannerListView.setAdLocations(adLocations);
        return new ModelAndView("banner/new_list","banner",bannerListView);
    }

    /**
     * 根据平台动态获取广告位
     * @param appId
     * @return
     */
    @RequestMapping("/ajaxGetadLocation")
    @ResponseBody
    public AjaxResult ajaxGetadLocation(@RequestBody Long appId){
        QueryParams<AdLocationVo> params = new QueryParams<>();
        AdLocationVo adLocationVo = new AdLocationVo();
        if (appId != null){
            adLocationVo.setAppId(appId);
        }
        params.setEntity(adLocationVo);
        List<AdLocationBo> adLocations = adCoreService.findAdLocation(params);
        return new AjaxResult(adLocations);
    }

    /**
     *  easyUI获取活动列表页表格数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/bannerList")
    @ResponseBody
    public EasyUIDataGridBo viewList(BannerQueryVo vo,
                                                                  @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                                                  @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo bo = new com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo();

        QueryParams<BannerQueryVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        Integer total = adCoreService.countAd(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPage(new QueryPage(pageNumber,pageSize));
            List<BannerBo> bannerBos = adCoreService.findAd(queryParams);
            bo.setRows(bannerBos);
        }
        return bo;
    }

    /**
     * 跳转到新增页面
     * @return
     */
    @RequestMapping("/add")
    public ModelAndView add(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.PLAT_TYPE);
        for (int i=0 ;i< platTypes.size();i++){
            if(platTypes.get(i).getConstValue().equals(Constant.newsColumns.plat.PLAT_FORM_CODE.toString())){
                platTypes.remove(i);
            }
        }
        List<AdLocationBo> adLocations = adCoreService.findAdLocation(new QueryParams<AdLocationVo>());
        BannerAddView bannerAddView = new BannerAddView();
        bannerAddView.setPlatTypes(platTypes);
        bannerAddView.setAdLocations(adLocations);
        return new ModelAndView("banner/new_add","banner",bannerAddView);
    }

    /**
     * 保存广告
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult save(BannerSaveVo vo){
        if(vo.getBannerLogo() != null && vo.getBannerLogo().lastIndexOf("@") != -1){
            vo.setBannerLogo(vo.getBannerLogo().substring(0,vo.getBannerLogo().lastIndexOf("@")));
        }
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        adCoreService.saveAd(vo);
        return new AjaxResult();
    }


    /**
     * 跳转到修改页面
     * @param id
     * @return
     */
    @RequestMapping("/{id}/edit")
    public ModelAndView viewEdit(@PathVariable(value = "id") Long id){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.PLAT_TYPE);
        for (int i=0 ;i< platTypes.size();i++){
            if(platTypes.get(i).getConstValue().equals(Constant.newsColumns.plat.PLAT_FORM_CODE.toString())){
                platTypes.remove(i);
            }
        }
        List<AdLocationBo> adLocations = adCoreService.findAdLocation(new QueryParams<AdLocationVo>());
        BannerBo bannerBo = adCoreService.getAdById(id);
        BannerAddView bannerAddView = new BannerAddView();
        bannerAddView.setPlatTypes(platTypes);
        bannerAddView.setAdLocations(adLocations);
        bannerAddView.setBannerBo(bannerBo);
        return new ModelAndView("banner/new_add","banner",bannerAddView);
    }

    /**
     * 根据广告位id获取广告位信息
     * @param adLocationId
     * @return
     */
    @RequestMapping("/ajaxGetAdLocationById")
    @ResponseBody
    public  AjaxResult adLocationId(@RequestBody Long adLocationId){
        AdLocationBo adLocationBo = adCoreService.getAdLocationById(adLocationId);
        return new AjaxResult(adLocationBo);
    }

    /**
     * 改变广告状态
     * @param bannerId
     * @param disabled
     * @return
     */
    @RequestMapping(value = "/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long bannerId,Boolean disabled){
        adCoreService.changeAdDisabled(bannerId,!disabled,sessionContext.getLoginUser().getUserId());
        BannerBo bannerBo = adCoreService.getAdById(bannerId);
        return new AjaxResult(bannerBo);
    }


    @RequestMapping(value = "/ajaxChangeDeleted")
    @ResponseBody
    public AjaxResult ajaxChangeDeleted(Long bannerId){
        adCoreService.changeAdDeleted(bannerId,sessionContext.getLoginUser().getUserId());
        BannerBo bannerBo = adCoreService.getAdById(bannerId);
        return new AjaxResult(bannerBo);
    }

    /**
     * 判断时间是否冲突
     * @param vo
     * @return
     */
    @RequestMapping("/ajaxDateIsConflict")
    @ResponseBody
    public AjaxResult ajaxDateIsConflict(BannerQueryVo vo){
        Boolean isConflict = null;
        if (vo != null) {
//            //在当前广告时间段内不冲突,不在需要重新判断
//            if (vo.getBannerId() != null) {
//
//                BannerBo bannerBo = adCoreService.getAdById(vo.getBannerId());
//                if (compareDate(vo.getStartTime(), bannerBo.getStartTime(), bannerBo.getEndTime())
//                    &&  compareDate(vo.getEndTime(), bannerBo.getStartTime(), bannerBo.getEndTime())) {
//                    isConflict = false;
//                }
//            }
            if (isConflict == null && vo.getStartTime() != null && vo.getEndTime() != null) {
                if (vo.getEndTime().before(vo.getStartTime())) {
                    isConflict = true;
                } else {
                    isConflict = adCoreService.dateIsConflict(vo.getAdLocationId(), vo.getStartTime(),vo.getEndTime());
                }
            }
        }else{
            isConflict = true;
        }
        return new AjaxResult(isConflict);
        //return adCoreService.dateIsConflict(key, date);
    }

    /**
     * 跳转到特殊广告页面
     * @return
     */
    @RequestMapping("/specialAd")
    public ModelAndView specialAdView(){
        QueryParams<SpecialAdQueryVo> params = new QueryParams<>();
        SpecialAdQueryVo vo = new SpecialAdQueryVo();
        vo.setAppId(Constant.newsColumns.plat.CHINESE_SITE_CODE);
        params.setEntity(vo);
        List<SpecialAdBo> specialAdCn = adCoreService.findSpecialAd(params);
        vo.setAppId(Constant.newsColumns.plat.RUSSIA_SITE_CODE);
        params.setEntity(vo);
        List<SpecialAdBo> specialAdRu = adCoreService.findSpecialAd(params);
        BannerListView bannerListView = new BannerListView();
        bannerListView.setSpecialAdCn(specialAdCn);
        bannerListView.setSpecialAdRu(specialAdRu);
        return new ModelAndView("banner/special_ad","banner",bannerListView);
    }

    @RequestMapping("/updateSpecialAd")
    @ResponseBody
    public AjaxResult updateSpecialAd(String ids){
        if(!"[]".equals(ids)){
            List<SpecialAdVo> specialAdVos = new ArrayList<>();
            JSONArray jsonArray = JSONArray.parseArray(ids);
            for (int i = 0; i<jsonArray.size() ; i++){
                String s = jsonArray.getString(i);
                specialAdVos.add(JsonUtils.fromJson(s, SpecialAdVo.class));
            }
            adCoreService.changeSpecialAdDisabled(specialAdVos,true,Constant.newsColumns.plat.CHINESE_SITE_CODE,sessionContext.getLoginUser().getUserId());
            return new AjaxResult(true);
        }else{
            return new AjaxResult(false);
        }
    }

    @RequestMapping("/updateRuSpecialAd")
    @ResponseBody
    public AjaxResult updateRuSpecialAd(String ids){
        if(!"[]".equals(ids)){
            List<SpecialAdVo> specialAdVos = new ArrayList<>();
            JSONArray jsonArray = JSONArray.parseArray(ids);
            for (int i = 0; i<jsonArray.size() ; i++){
                String s = jsonArray.getString(i);
                specialAdVos.add(JsonUtils.fromJson(s, SpecialAdVo.class));
            }
            adCoreService.changeSpecialAdDisabled(specialAdVos,true,Constant.newsColumns.plat.RUSSIA_SITE_CODE,sessionContext.getLoginUser().getUserId());
            return new AjaxResult(true);
        }else {
            return new AjaxResult(false);
        }
    }



    @RequestMapping("/viewList")
    @ResponseBody
    public EasyUIDataGridBo viewList(InfBannerVo infBannerVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){

//        List<AldBannerBo> aldBannerBoList = bannerService.select(infBannerVo);
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

       /* QueryParams<InfBannerVo> queryParams = new QueryParams();
        queryParams.setEntity(infBannerVo);
        Integer total = bannerService.getCount(infBannerVo);
        bo.setTotal(total);
        if(total>0){
            queryParams.setPageSize(pageSize);
            queryParams.setTargetPage(pageNumber);
            bo.setRows(bannerService.selectList(queryParams));
        }*/
        return bo;
    }


}
