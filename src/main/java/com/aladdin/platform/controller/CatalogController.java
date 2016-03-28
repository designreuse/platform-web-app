package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;
import com.aladdin.core.bo.CatalogPropertyBo;
import com.aladdin.core.bo.ProductBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.dao.IAldSignDao;
import com.aladdin.core.service.ICatalogCoreService;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IProductCoreService;
import com.aladdin.core.service.ISignCoreService;
import com.aladdin.core.vo.CatalogAddVo;
import com.aladdin.core.vo.CatalogQueryVo;
import com.aladdin.core.vo.ProductQueryVo;
import com.aladdin.platform.bo.view.CatalogEditView;
import com.aladdin.platform.bo.view.CatalogListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015/10/21.
 */
@Controller
@RequestMapping("/catalog")
public class CatalogController {

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    @Resource(name="catalogCoreService")
    private ICatalogCoreService catalogCoreService;

    @Resource(name="productCoreService")
    private IProductCoreService productCoreService;

    @Resource(name = "signCoreService")
    private ISignCoreService signCoreService;


    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    public static final String CATALOG_LEVEL = "catalog_level";
    //修改
    public static final Integer IS_MODIFY = 1;

    @RequestMapping("/list")
    public ModelAndView viewCatalogList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        CatalogListView catalogListView = new CatalogListView();
        catalogListView.setDisableds(disableds);
        return new ModelAndView("catalog/new_list","catalog", catalogListView);
    }

    @RequestMapping("/catalogList")
    @ResponseBody
    public EasyUIDataGridBo categoryList(CatalogQueryVo vo,
                                         @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                         @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<CatalogQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(vo);
        Integer total = catalogCoreService.countCatalog(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<CatalogBo> catalogBos = catalogCoreService.findCatalog(queryParams);
            bo.setRows(catalogBos);
        }
        return bo;
    }


    /**
     * 新增品类
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public ModelAndView viewAdd(Model model){
        List<AldConstantsBo> levels = constantsCoreService.findConstantsByKey(CATALOG_LEVEL);
        CatalogEditView catalogEditView = new CatalogEditView();
        catalogEditView.setLevels(levels);
        return new ModelAndView("catalog/new_add","catalog",catalogEditView);
    }


    /**
     * 修改品类
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/{id}/{level}/edit")
    public ModelAndView viewEdit(Model model,@PathVariable(value = "id") Long id,@PathVariable(value = "level") Integer level){
        CatalogBo catalogBo = catalogCoreService.selectCatalogByIdAndLevel(id,level);
        List<AldConstantsBo> levels = constantsCoreService.findConstantsByKey(CATALOG_LEVEL);
        List<CatalogPropertyBo> propertyBos = catalogCoreService.findCatalogPropertyById(id);
        CatalogEditView catalogEditView = new CatalogEditView();
        catalogEditView.setCatalogBo(catalogBo);
        catalogEditView.setLevels(levels);
        catalogEditView.setPropertyBos(propertyBos);
        return new ModelAndView("catalog/new_edit","catalog",catalogEditView);
    }

    /**
     * 保存品类
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    public ModelAndView save(CatalogAddVo vo){
        Long userId = sessionContext.getLoginUser().getUserId();
        vo.setCurrentUserId(userId);
        signCoreService.saveSign(userId,IS_MODIFY,Constant.Sign.signType.SIGN_CATALOG_CHANGE);
        catalogCoreService.saveCatalog(vo);
        return new ModelAndView("redirect:/catalog/list");
    }


    @RequestMapping("/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long catalogId,Boolean disabled){
        Long userId = sessionContext.getLoginUser().getUserId();
        catalogCoreService.changeCatalogDisabled(sessionContext.getLoginUser().getUserId(),catalogId,!disabled);
        signCoreService.saveSign(userId,IS_MODIFY,Constant.Sign.signType.SIGN_CATALOG_CHANGE);
        CatalogBo catalogBo = catalogCoreService.getCatalogById(catalogId);
        return new AjaxResult(catalogBo);
    }

    /**
     * 根据级别查询分类
     * @param level
     * @return
     */
    @RequestMapping("/ajaxFindCatalogByLevel")
    @ResponseBody
    public AjaxResult findCatalogByLevel(Integer level){
        List<CatalogBo> catalogBos = catalogCoreService.findCatalogByLevel(level);
        return new AjaxResult(catalogBos);
    }

    @RequestMapping("/ajaxGetCatalogListByParent")
    @ResponseBody
    public AjaxResult ajaxGetCatalogListByParent(Long catalogId){
        List<CatalogBo> catalogBos = catalogCoreService.findCatalogSubsetById(catalogId);
        return new AjaxResult(catalogBos);
    }


    @RequestMapping(value = "/subCatalog")
    @ResponseBody
    public List<CatalogBo> findCatalogSubsetById(Long catalogId) {
        List<CatalogBo> catalogBoList = catalogCoreService.findCatalogSubsetById(catalogId);
        return catalogBoList;
    }

    /**
     * 取得产品列表
     * @param catalogId
     * @return
     */
    @RequestMapping(value = "/getProduct")
    @ResponseBody
    public List<ProductBo> findProductListByCatalogId(Long catalogId){
        QueryParams<ProductQueryVo> params = new QueryParams<>();
        ProductQueryVo productQueryVo = new ProductQueryVo();
        productQueryVo.setCatalogId(catalogId);
        params.setEntity(productQueryVo);
        List<ProductBo> list = productCoreService.findProduct(params);
        return list;
    }
}
