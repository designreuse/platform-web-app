package com.aladdin.platform.bo.view;

import cb.base.bo.page.PageBo;
import com.aladdin.core.bo.PhotoGalleryBo;
import com.aladdin.core.vo.PhotoGalleryVo;

import java.util.List;

/**
 * Created by Administrator on 2016/3/23.
 */
public class PhotoGalleryListView extends PageBo {

    private List<PhotoGalleryBo> photoGalleryBoList;

    private PhotoGalleryVo photoGalleryVo;

    public List<PhotoGalleryBo> getPhotoGalleryBoList() {
        return photoGalleryBoList;
    }

    public void setPhotoGalleryBoList(List<PhotoGalleryBo> photoGalleryBoList) {
        this.photoGalleryBoList = photoGalleryBoList;
    }

    public PhotoGalleryVo getPhotoGalleryVo() {
        return photoGalleryVo;
    }

    public void setPhotoGalleryVo(PhotoGalleryVo photoGalleryVo) {
        this.photoGalleryVo = photoGalleryVo;
    }
}
