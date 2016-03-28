package com.aladdin.platform.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/8/18.
 */
@Controller
@RequestMapping("/uc")
public class UcController {
    @RequestMapping("/linkage")
    public String viewCatalogProduct(Model mode){

        mode.addAttribute("data","A123");

        return "uc/linkage_catalog_product";
    }
}
