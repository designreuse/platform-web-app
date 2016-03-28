package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import com.aladdin.core.service.IPhotoGalleryService;
import com.aladdin.core.vo.ImageDateSaveVo;
import com.aladdin.core.vo.PhotoGalleryVo;
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
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yinZheng on 16-3-2.
 */
@Controller
@RequestMapping("/aldUploadNew")
public class FileUploadNewController {

    private final static Integer ING_MAX = 5242880;

    @Resource(name = "fwImageResourceService")
    private IImageResourceService imageResourceService;

    @Resource(name = "photoGalleryService")
    private IPhotoGalleryService photoGalleryService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    /**
     * 上传图片 无裁剪
     * @param file
     */
    @RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
    @ResponseBody
    public  AjaxResult uploadImg(MultipartFile file) throws IOException {
        AjaxResult ajaxResult=this.ImageUploadDeal(file);
        return ajaxResult;
    }

    /**
     * 素材库 上传图片
     * @param file
     */
    @RequestMapping(value = "/uploadGalleryImg", method = RequestMethod.POST)
    @ResponseBody
    public  AjaxResult uploadMoreImg(MultipartFile file) throws IOException {
        Long userId = sessionContext.getLoginUser().getUserId();
        AjaxResult ajaxResult=this.ImageUploadDeal(file);
        Object resultData = ajaxResult.getResultData();
        Map<String, Object> data = (Map<String, Object>)resultData;
        PhotoGalleryVo vo = new PhotoGalleryVo();
        vo.setName(data.get("fileName").toString());
        vo.setUrl(data.get("urlPath").toString());
        vo.setCreateBy(userId);
        vo.setModifyBy(userId);
        photoGalleryService.savePhotoGalleries(vo);
        return ajaxResult;
    }

    /**
     * 上传图片 有裁剪 高级
     * @param file
     */
    @RequestMapping(value = "/uploadImgExpert", method = RequestMethod.POST)
    @ResponseBody
    public  AjaxResult uploadImgExpert(MultipartFile file,ImageDateSaveVo imageDateSaveVo) throws IOException {
        AjaxResult ajaxResult=this.ImageUploadDeal(file);
       /* Map<String, String[]> parameterMap = request.getParameterMap();
        Set<String> keySet = parameterMap.keySet();
        for(String key : keySet){
            System.out.println("KEY:" + key);
            System.out.println("VALUE:" + parameterMap.get(key));
        }*/

        Map<String, Object> data =  (Map<String, Object>)ajaxResult.getResultData();
        if(imageDateSaveVo.getxPoint()!=null && imageDateSaveVo.getyPoint()!=null && imageDateSaveVo.getWidth()!=null&& imageDateSaveVo.getHeight()!=null){
            int xPoint=imageDateSaveVo.getxPoint().intValue()<0?0:imageDateSaveVo.getxPoint();
            int yPoint=imageDateSaveVo.getyPoint().intValue()<0?0:imageDateSaveVo.getyPoint();
            imageDateSaveVo.setxPoint(xPoint);
            imageDateSaveVo.setyPoint(yPoint);
            data.put("urlPath",data.get("urlPath")+"@"+imageDateSaveVo.getxPoint()+"-"+imageDateSaveVo.getyPoint()+"-"+imageDateSaveVo.getWidth()+"-"+imageDateSaveVo.getHeight()+"a_"+imageDateSaveVo.getrPorint()+"r");
        }else {
            data.put("urlPath",data.get("urlPath"));
        }
       // data.put("urlPath",data.get("urlPath")+"@"+imageDateSaveVo.getxPoint()+"-"+imageDateSaveVo.getyPoint()+"-"+imageDateSaveVo.getWidth()+"-"+imageDateSaveVo.getHeight()+"a_"+imageDateSaveVo.getrPorint()+"r");
        ajaxResult.setResultData(data);
        return ajaxResult;
    }

    /**
     * 上传图片
     * @param file
     */
    private AjaxResult ImageUploadDeal(MultipartFile file)throws IOException{
        AjaxResult ajaxResult = new AjaxResult();
        if (null == file || (file != null && file.getSize() > ING_MAX)) {
            ajaxResult.setIsSuccess(false);
            ajaxResult.setResultMsg("图像最大不要超过5Mb或5120Kb!");
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

            /*// 对原图进行缩放
            if(null!=widths && null!=heights){
                imageResourceService.resize(resourceCode, widths, heights, currentUserId);
            }*/

            if (org.apache.commons.lang.StringUtils.isEmpty(resourceCode)) {
                ajaxResult.setIsSuccess(false);
                ajaxResult.setResultMsg("请求资源服务器获取文件编号为空!");
            }else{
                // 读取图片信息
                List<ImageInfo> imageInfoList = imageResourceService.getImageList(resourceCode, currentUserId);

                ImageInfo imageInfo = new ImageInfo();
               /* if(null !=width && null!=height){
                    imageInfo = ImageUtils.getOptimalImageInfo(imageInfoList, width, height);
                }else{*/
                imageInfo = imageInfoList.get(0);
                /*}*/
                // 根据宽、高获取最优的图片信息
                Map<String, Object> data = new HashMap<String, Object>();
                data.put("resourceCode", resourceCode);
                String urlPath =  imageInfo.getUrl();
                if (urlPath != null){
                    urlPath = urlPath.replaceAll("@.jpg","");
                }
                data.put("urlPath",urlPath);
                data.put("fileName",file.getOriginalFilename());
                ajaxResult.setIsSuccess(true);
                ajaxResult.setResultData(data);
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
}
