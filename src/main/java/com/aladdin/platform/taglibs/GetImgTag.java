package com.aladdin.platform.taglibs;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

/**
 * Created by liangsheng on 2015/12/28.
 */
public class GetImgTag extends RequestContextAwareTag {

    private String imgUrl;
    private String width;
    private String height;

    @Override
    protected int doStartTagInternal() throws Exception {
        String url = "";
        if(StringUtils.isEmpty(imgUrl)){
            imgUrl = "http://img.51aladdin.com/a7e1f1a6-f4b5-4a9a-9dce-1a28e32026a7.jpg@";
        }else{
            if(imgUrl.indexOf("@")>0){
                url = imgUrl + "_";
            }else {
                url = imgUrl + "@";
            }

            if(!StringUtils.isEmpty(width)){
                url += (width +"w_");
            }
            if(!StringUtils.isEmpty(height)){
                url += (height +"h_");
            }
            url += "1l";
        }
        this.pageContext.getOut().write(url);
        return SKIP_BODY;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }
}
