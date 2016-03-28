package com.aladdin.platform.controller;

import com.aladdin.core.bo.ProductPropertyBo;
import com.aladdin.core.service.IProductCoreService;
import com.aladdin.inf.po.*;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Administrator on 15-7-29.
 */
@RequestMapping("/ShopsSku")
@Controller
public class ShopsSkuController {

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "productCoreService")
    private IProductCoreService productCoreService;

    @RequestMapping(value = "/getProperty")
    public @ResponseBody Map getProperty(Long productId){
        Map map = new HashMap();
        AldProductPropertyEntity entity = new AldProductPropertyEntity();
        entity.setProductId(productId);
//        List<AldProductPropertyBo> propertyList = productPropertyService.select(entity);
        ProductPropertyBo productPropertyBo = productCoreService.getProductPropertyByProductId(productId);
        map.put("productPropertyBo",productPropertyBo);
        return map;
    }

}
