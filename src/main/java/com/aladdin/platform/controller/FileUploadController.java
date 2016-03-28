package com.aladdin.platform.controller;

import com.aladdin.core.dao.IAldProductCoreDao;
import com.aladdin.core.po.AldProductEntity;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.ImageUtils;
import com.aladdin.platform.utils.UmEditorUploader;
import com.wl.framework.resource.bo.ImageInfo;
import com.wl.framework.resource.exception.IllegalImageException;
import com.wl.framework.resource.service.IImageResourceService;
import com.wl.framework.session.context.SessionContext;
import com.wl.framework.session.domain.LoginUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/24.
 */
@Controller
@RequestMapping("/aldUpload")
public class FileUploadController {

    private final static Integer ING_MAX = 5242880;

    @Resource(name = "fwImageResourceService")
    private IImageResourceService imageResourceService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name="aldProductCoreDao")
    private IAldProductCoreDao aldProductCoreDao;

    /**
     * 上传图片(By Kimi-Hua Test 2015-12-30)
     * @param file
     */
    @RequestMapping(value = "/testUploadImg", method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult testUploadImg(MultipartFile file) throws IOException {
        AjaxResult ajaxResult = new AjaxResult();
        if (null == file || (file != null && file.getSize() > ING_MAX)) {
            ajaxResult.setResult(false);
            ajaxResult.setMsg("图像最大不要超过5Mb或5120Kb!");
            return ajaxResult;
        }

        // 获取当前登录用户id
        LoginUser loginUser = sessionContext.getLoginUser();

        Long currentUserId = loginUser.getUserId();

        InputStream inputStream = null;

        try {
            // 上传原图
            inputStream = file.getInputStream();
            // 当前图片是否需要权限控制
            boolean isPermission = false;
            // 调用framework图片资源服务上传图片
            String resourceCode = imageResourceService.upload(file.getOriginalFilename(), inputStream, isPermission, currentUserId);

            if (org.apache.commons.lang.StringUtils.isEmpty(resourceCode)) {
                ajaxResult.setResult(false);
                ajaxResult.setMsg("请求资源服务器获取文件编号为空!");
            }else{
                // 读取图片信息
                List<ImageInfo> imageInfoList = imageResourceService.getImageList(resourceCode, currentUserId);
                ImageInfo imageInfo = new ImageInfo();
                imageInfo = imageInfoList.get(0);
                // 根据宽、高获取最优的图片信息
                Map<String, Object> data = new HashMap<String, Object>();
                data.put("resourceCode", resourceCode);
                data.put("urlPath",imageInfo.getUrl());
                ajaxResult.setResult(true);
                ajaxResult.setData(data);
            }
        } catch (IllegalImageException e) {
            // 处理用户上传非图片类型的异常
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }

        return ajaxResult;
    }


    /**
     * 百度编辑器上传图片
     */
    @RequestMapping("/umEditorUpload")
    public void imgUpload(MultipartFile upfile,String callback,HttpServletResponse response) {
// 获取当前登录用户id
        Long currentUserId = sessionContext.getLoginUser().getUserId();
        String fileName = null;
        String originalFilename = null;
        Long size = null;
        String state = "SIZE";
        String type = null;
        String url = null;
        try {
            if(upfile != null && upfile.getSize() < ING_MAX){
                fileName = upfile.getOriginalFilename();
                originalFilename = upfile.getOriginalFilename();
                size = upfile.getSize();
                type = upfile.getContentType();

                String resourceCode = imageResourceService.upload(originalFilename, upfile.getInputStream(), false, currentUserId);
                List<ImageInfo> imageInfoList = imageResourceService.getImageList(resourceCode, currentUserId);

                url = imageInfoList.get(0).getUrl();
                state = "SUCCESS";
            }
            response.setCharacterEncoding("utf-8");
            String result = "{\"name\":\"" + fileName + "\", \"originalName\": \"" + originalFilename
                    + "\", \"size\": " + size + ", \"state\": \"" + state + "\", \"type\": \""
                    + type + "\", \"url\": \"" + url + "\"}";

            result = result.replaceAll("\\\\", "\\\\");

            if (callback == null) {
                response.getWriter().print(result);
            } else {
                response.getWriter().print("<script>" + callback + "(" + result + ")</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 上传图片
     * @param file
     */
    @RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult uploadImg(MultipartFile file) throws IOException {
        AjaxResult ajaxResult = new AjaxResult();
        if (null == file || (file != null && file.getSize() > ING_MAX)) {
            ajaxResult.setResult(false);
            ajaxResult.setMsg("图像最大不要超过5Mb或5120Kb!");
            return ajaxResult;
        }

        // 获取当前登录用户id
        LoginUser loginUser = sessionContext.getLoginUser();

        Long currentUserId = loginUser.getUserId();

        InputStream inputStream = null;

        try {
            // 上传原图
            inputStream = file.getInputStream();
            // 当前图片是否需要权限控制
            boolean isPermission = false;
            // 调用framework图片资源服务上传图片
            String resourceCode = imageResourceService.upload(file.getOriginalFilename(), inputStream, isPermission, currentUserId);

            if (org.apache.commons.lang.StringUtils.isEmpty(resourceCode)) {
                ajaxResult.setResult(false);
                ajaxResult.setMsg("请求资源服务器获取文件编号为空!");
            }else{
                // 读取图片信息
                List<ImageInfo> imageInfoList = imageResourceService.getImageList(resourceCode, currentUserId);
                ImageInfo imageInfo = new ImageInfo();
                imageInfo = imageInfoList.get(0);
                // 根据宽、高获取最优的图片信息
                Map<String, Object> data = new HashMap<String, Object>();
                data.put("resourceCode", resourceCode);
                data.put("urlPath",imageInfo.getUrl().replace("@.jpg",""));
                ajaxResult.setResult(true);
                ajaxResult.setData(data);
            }
        } catch (IllegalImageException e) {
            // 处理用户上传非图片类型的异常
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
        }

        return ajaxResult;
    }

//    @RequestMapping("/productLogoSync")
//    public void updateTest(){
//        String filePath = "d:\\product";
//        InputStream inputStream = null;
//        // 获取当前登录用户id
//        LoginUser loginUser = sessionContext.getLoginUser();
//        Long currentUserId = loginUser.getUserId();
//
//        try {
//            File file = new File(filePath);
//            if (!file.isDirectory()) {
//                System.out.println("文件");
//                System.out.println("path=" + file.getPath());
//                System.out.println("absolutepath=" + file.getAbsolutePath());
//                System.out.println("name=" + file.getName());
//
//            } else if (file.isDirectory()) {
//                System.out.println("文件夹");
//                String[] filelist = file.list();
//                for (int i = 0; i < filelist.length; i++) {
//                    File readFile = new File(filePath + "\\" + filelist[i]);
////                File readFile = new File(filePath + "\\" + "2350.jpg");
//
//                    if (!readFile.isDirectory()) {
//                        String name = readFile.getName();
//                        String[] split = name.split("\\.");
//                        Long productId = Long.valueOf(split[0])/10;
//                        System.out.println("productId: "+productId);
//
//                        try {
//                            // 上传原图
//                            inputStream =  new FileInputStream(readFile);
//
//                            // 当前图片是否需要权限控制
//                            boolean isPermission = false;
//                            // 调用framework图片资源服务上传图片
//                            String resourceCode = imageResourceService.upload(name, inputStream, isPermission, currentUserId);
//
//                            // 对原图进行缩放
//                            if (!org.apache.commons.lang.StringUtils.isEmpty(resourceCode)) {
//                                // 读取图片信息
//                                List<ImageInfo> imageInfoList = imageResourceService.getImageList(resourceCode, currentUserId);
//
//                                ImageInfo imageInfo = imageInfoList.get(0);
//                                String logoUrl = imageInfo.getUrl();
//                                System.out.println("logoUrl: "+logoUrl);
//                                AldProductEntity entity = new AldProductEntity();
//                                entity.setProductId(productId);
//                                entity.setLogoUrl(logoUrl);
//                                entity.setModifyTime(new Date());
//                                entity.setResourceCode(resourceCode);
//                                aldProductCoreDao.update(entity);
//                            }
//                        } catch (IllegalImageException e) {
//                            // 处理用户上传非图片类型的异常
//                        } finally {
//                            if (inputStream != null) {
//                                inputStream.close();
//                            }
//                        }
//
//                    }
//                }
//            }
//        } catch (Exception e) {
//            System.out.println("readfile()   Exception:" + e.getMessage());
//        }
//
//    }
}
