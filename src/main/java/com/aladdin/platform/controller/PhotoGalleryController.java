package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.PhotoGalleryBo;
import com.aladdin.core.service.IPhotoGalleryService;
import com.aladdin.core.vo.PhotoGalleryVo;
import com.aladdin.platform.bo.view.PhotoGalleryListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.resource.bo.ImageInfo;
import com.wl.framework.resource.exception.IllegalImageException;
import com.wl.framework.session.domain.LoginUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/23.
 */
@Controller
@RequestMapping("/photoGallery")
public class PhotoGalleryController {

    @Resource(name = "photoGalleryService")
    private IPhotoGalleryService photoGalleryService;

    private static Integer PAGE_SIZE=12;

    @RequestMapping("/list")
    public ModelAndView list(PhotoGalleryVo photoGalleryVo,PhotoGalleryListView photoGalleryListView) {
        QueryPage queryPage = new QueryPage();
        if(photoGalleryVo.getPageIndex()==null){
            queryPage.setPageSize(PAGE_SIZE);
            photoGalleryVo.setPageSize(PAGE_SIZE);
            photoGalleryVo.setPageIndex(queryPage.getPageIndex());
        }else{
            queryPage.setPageIndex(photoGalleryVo.getPageIndex());
            queryPage.setPageSize(photoGalleryVo.getPageSize());
        }
        QueryParams<PhotoGalleryVo> queryParams  = new QueryParams<PhotoGalleryVo>(photoGalleryVo,queryPage);
        queryParams.setEntity(photoGalleryVo);
        Integer count = photoGalleryService.countPhotoGalleries(queryParams);
        List<PhotoGalleryBo> photoGalleries = new ArrayList<>();
        if(count>0){
            photoGalleries = photoGalleryService.findPhotoGalleries(queryParams);
        }
        photoGalleryListView.setPhotoGalleryBoList(photoGalleries);
        photoGalleryListView.setPhotoGalleryVo(photoGalleryVo);
        photoGalleryListView.setRowCount(count);
        photoGalleryListView.setPageIndex(photoGalleryVo.getPageIndex());
        photoGalleryListView.setPageSize(photoGalleryVo.getPageSize());
        return new ModelAndView("photoGallery/list","view",photoGalleryListView) ;
    }


    @RequestMapping("/photoList")
    @ResponseBody
    public AjaxResult photoList(String name, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageIndex,
                                @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryPage queryPage = new QueryPage();
        PhotoGalleryVo photoGalleryVo = new PhotoGalleryVo();
        photoGalleryVo.setName(name);
        queryPage.setPageIndex(pageIndex);
        queryPage.setPageSize(pageSize);

        PhotoGalleryListView photoGalleryListView = new PhotoGalleryListView();
        QueryParams<PhotoGalleryVo> queryParams  = new QueryParams<PhotoGalleryVo>(photoGalleryVo,queryPage);
        queryParams.setEntity(photoGalleryVo);
        Integer count = photoGalleryService.countPhotoGalleries(queryParams);
        List<PhotoGalleryBo> photoGalleries = new ArrayList<>();
        if(count>0){
            photoGalleries = photoGalleryService.findPhotoGalleries(queryParams);
        }
        photoGalleryListView.setPhotoGalleryBoList(photoGalleries);
        photoGalleryListView.setPhotoGalleryVo(photoGalleryVo);
        photoGalleryListView.setRowCount(count);
        photoGalleryListView.setPageIndex(pageIndex);
        photoGalleryListView.setPageSize(pageSize);
        return new AjaxResult(photoGalleryListView) ;
    }

    @RequestMapping("/savePhotoName")
    @ResponseBody
    public AjaxResult savePhotoName(PhotoGalleryVo photoGalleryVo){
        photoGalleryService.savePhotoGalleries(photoGalleryVo);
        return new AjaxResult(true);
    }
}
