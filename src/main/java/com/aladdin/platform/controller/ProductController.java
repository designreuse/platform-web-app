package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.ICatalogCoreService;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IProductCoreService;
import com.aladdin.core.vo.ProductAddVo;
import com.aladdin.core.vo.ProductQueryVo;
import com.aladdin.core.vo.ProductVo;
import com.aladdin.platform.bo.view.ProductAddView;
import com.aladdin.platform.bo.view.ProductListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Administrator on 15-8-5.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    @Resource(name="productCoreService")
    private IProductCoreService productCoreService;
    @Resource(name="catalogCoreService")
    private ICatalogCoreService catalogCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    /**
     * 取得产品列表
     * @param catalogId
     * @return
     */
    @RequestMapping(value = "/getProduct")
    @ResponseBody
    public List<ProductBo> findProductListByCatalogId(Long catalogId){
        QueryParams<ProductVo> params = new QueryParams<ProductVo>();
        ProductVo productVo = new ProductVo();
        productVo.setCatalogId(catalogId);
        params.setEntity(productVo);
        params.setQueryPage(null);
        List<ProductBo> list = productCoreService.findProductByCatalogId(catalogId);
        return list;
    }
    /**
     * 跳转到标准商品列表
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView viewList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        ProductListView productListView = new ProductListView();
        productListView.setDisableds(disableds);
        return new ModelAndView("product/new_list","product",productListView);
    }

    /**
     * easyUI获取标准商品列表
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/productList")
    @ResponseBody
    public EasyUIDataGridBo viewList(ProductQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<ProductQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(vo);
        Integer total = productCoreService.countProduct(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<ProductBo> product = productCoreService.findProduct(queryParams);
            bo.setRows(product);
        }
        return bo;
    }

    /**
     * 跳转到新增页面
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public ModelAndView addView(Model model){
        //获取常量表中的单位和一级分类的列表
        List<AldConstantsBo> unitTypes = constantsCoreService.findConstantsByKey(Constant.Product.PRODUCT_UNIT_TYPE);
        List<CatalogBo> catalogBos = catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE);
        List<PropertyBo> propertyBos = productCoreService.findProperty();
        ProductAddView productAddView = new ProductAddView();
        productAddView.setCatalogBos(catalogBos);
        productAddView.setUnitTypes(unitTypes);
        productAddView.setPropertyBos(propertyBos);
        return new ModelAndView("product/new_add","product",productAddView);
    }

    /**
     * 跳转到编辑页面
     * @param id
     * @return
     */
    @RequestMapping("/{id}/edit")
    public ModelAndView viewList(@PathVariable(value = "id") Long id){
        //获取常量表中的单位和一级分类的列表
        List<AldConstantsBo> unitTypes = constantsCoreService.findConstantsByKey(Constant.Product.PRODUCT_UNIT_TYPE);
        List<CatalogBo> catalogBos = catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE);
        //根据商品id获取商品
        ProductBo productBo = productCoreService.getProductById(id);
        //根据商品一级分类id获取二级分类列表
        List<CatalogBo> secondCatalogList = catalogCoreService.findCatalogSubsetById(productBo.getCatalogIdFirst());
        //根据商品二级分类id获取三级分类列表
        List<CatalogBo> thirdCatalogList = catalogCoreService.findCatalogSubsetById(productBo.getCatalogIdSecond());
        //根据catalogId获取对应的商品属性列表
        List<CatalogPropertyBo> catalogPropertyBos = catalogCoreService.findCatalogPropertyById(productBo.getCatalogId());
        //查询所有的商品属性列表
        List<PropertyBo> propertyBos = productCoreService.findProperty();
        //根据商品id查询对应的商品属性
        ProductPropertyBo productProperty = productCoreService.getProductPropertyByProductId(id);
        ProductAddView productAddView = new ProductAddView();
        productAddView.setCatalogBos(catalogBos);
        productAddView.setUnitTypes(unitTypes);
        productAddView.setProductBo(productBo);
        productAddView.setSecondCatalogList(secondCatalogList);
        productAddView.setThirdCatalogList(thirdCatalogList);
        productAddView.setCatalogPropertyBos(catalogPropertyBos);
        productAddView.setPropertyBos(propertyBos);
        productAddView.setProductProperty(productProperty);
        return new ModelAndView("product/new_edit","product",productAddView);
    }

    /**
     * 商品保存
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    public ModelAndView save(ProductAddVo vo){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        productCoreService.saveProduct(vo);
        return new ModelAndView("redirect:/product/list");
    }

    /**
     * 异步获取下一级分类
     * @param catalogId
     * @return
     */
    @RequestMapping("/ajaxGetCatalogByParent")
    @ResponseBody
    public AjaxResult ajaxGetCatalogByParent(Long catalogId){
        List<CatalogBo> catalogBos = catalogCoreService.findCatalogSubsetById(catalogId);
        return new AjaxResult(catalogBos);
    }

    /**
     * 异步修改商品状态
     * @param productId
     * @param status
     * @return
     */
    @RequestMapping("/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long productId,Boolean status){
        productCoreService.changeProductDisabled(sessionContext.getLoginUser().getUserId(),productId,!status);
        ProductBo productBo = productCoreService.getProductById(productId);
        return new AjaxResult(productBo);
    }


    @RequestMapping("/property")
    @ResponseBody
    public AjaxResult propertyEdit(String propertyIdList,Long productId){
        String[] propertyLists = StringUtils.split(propertyIdList, ",");
        List<String> newPropertyList = Arrays.asList(propertyLists);
        //productPropertyService.update(productId,newPropertyList);
        return new AjaxResult(true,"保存成功");
    }

    @RequestMapping("/getPropertyList")
    public @ResponseBody
    AjaxResult getPropertyList(Long id){
        try{
            return  null;
            //return new AjaxResult(catalogPropertyService.selectByCatalogId(id));
        }catch (Exception e){
            return new AjaxResult(false,"获取属性失败");
        }
    }



}
