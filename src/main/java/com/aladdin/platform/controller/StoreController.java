package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.AutoCompleteBo;
import com.aladdin.core.bo.OrgBo;
import com.aladdin.core.bo.StoreBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.ICatalogCoreService;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IOrgCoreService;
import com.aladdin.core.service.IStoreCoreService;

import com.aladdin.core.vo.OrgQueryVo;
import com.aladdin.core.vo.StoreQueryVo;
import com.aladdin.core.vo.StoreSaveVo;

import com.aladdin.platform.bo.view.StockListView;
import com.aladdin.platform.bo.view.StoreEditView;
import com.aladdin.platform.bo.view.StoreListView;
import com.aladdin.platform.constans.Constants;

import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/16.
 */
@Controller
@RequestMapping("/store")
public class StoreController {
    @Resource(name = "storeCoreService")
    private IStoreCoreService storeCoreService;
    @Resource (name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;

    private static String DISABLED = "disabled";
    /**
     *进入仓库管理页面
     * @param
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView viewList(){
        ModelAndView modelAndView = new ModelAndView("store/list");

        //状态
        List<AldConstantsBo> statusList = constantsCoreService.findConstantsByKey(DISABLED);

        StoreListView storeListView = new StoreListView();
        storeListView.setStatusList(statusList);

        modelAndView.addObject("view",storeListView);
        return modelAndView;
    }
    /**
     *按照条件查询仓库信息
     * @param
     * @return
     */
    @RequestMapping("/storeList")
    @ResponseBody
    public EasyUIDataGridBo carList(StoreQueryVo storeVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<StoreQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(storeVo);
        Integer total=storeCoreService.countStore(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(storeCoreService.findStore(queryParams));
        }else{
            bo.setRows(Collections.emptyList());
        }
        return bo;
    }
    /**
     *按照仓库ID查询仓库详细信息
     * @param id
     * @return
     */
    @RequestMapping("/detail")
    public String detail(Model model,Long id){
        StoreEditView view = new StoreEditView();
        StoreBo bo =storeCoreService.getStoreById(id);
        bo.setOrgNameCn(orgCoreService.getOrgByOrgId(bo.getOrgId()).getOrgNameCn());
        view.setStoreBo(bo);
        view.setParkList(constantsCoreService.findConstantsByKey("park"));
        model.addAttribute("view", view);
        return "store/editStore";
    }
    /**
     *改变仓库状态
     * @param disabled，id
     * @return
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public AjaxResult changeStatus(boolean disabled,Long id){
        storeCoreService.changeStoreDisabled(id,!disabled,sessionContext.getLoginUser().getUserId());
        return new AjaxResult(true,"状态更改成功");
    }
    /**
     *保存仓库信息
     * @param
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult saveStore(String params){

        StoreSaveVo saveVo= JSON.parseArray(params,StoreSaveVo.class).get(0);
        if(saveVo.getId()  != null){
            saveVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        }else{
            saveVo.setCreateBy(sessionContext.getLoginUser().getUserId());
        }

        storeCoreService.saveStore(saveVo);
        return new AjaxResult(true,"状态更改成功");
    }


    /**
     *模糊查询委托方名称
     */
    @RequestMapping("/OrgName")
    @ResponseBody
    public List srvOrgName(HttpServletRequest request){
        String name=  request.getParameter("term").toString();
        List<OrgBo> orgBoList=new ArrayList<>();
        if (!StringUtils.isEmpty(name))
        {
            QueryParams<OrgQueryVo> queryParams = new QueryParams();
            OrgQueryVo vo=new OrgQueryVo();
            vo.setOrgName(name);
            queryParams.setEntity(vo);
            orgBoList=orgCoreService.findOrg(queryParams);
        }
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (orgBoList.size()>0)
        {
            for(OrgBo x : orgBoList) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getOrgNameCn());
                auto.setValue(x.getOrgNameCn());
                lstAuto.add(auto);
            }
        }
        return lstAuto;

    }
    /**
     *进入编辑页面
     * @param id
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model,Long id){
        StoreEditView view = new StoreEditView();
        view.setParkList(constantsCoreService.findConstantsByKey("park"));
        model.addAttribute("view", view);
        return "store/editStore";
    }
    /**
     *
     * @param id
     * @return
     */
    @RequestMapping("/stockList")
    public String StockList(Model model,Long id){
        model.addAttribute("warehouseId", id);
        StockListView view = new StockListView();
        view.setLevel(catalogCoreService.findCatalogByLevel(1));
        model.addAttribute("view", view);
        return "redirect:/stock/list?id="+id;
    }
}
