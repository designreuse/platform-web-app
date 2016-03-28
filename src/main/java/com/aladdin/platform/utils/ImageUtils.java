package com.aladdin.platform.utils;


import com.wl.framework.resource.bo.ImageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * The type Image utils.
 */
public class ImageUtils {

    private final static Logger LOGGER = LoggerFactory.getLogger(ImageUtils.class);

    /**
     * Gets image.
     * 从文件中获取图形
     *
     * @param file the file
     * @return the image
     * @throws java.io.IOException the iO exception
     */
    public static BufferedImage getImage(File file) throws IOException {
        return ImageIO.read(file);
    }

    /**
     * Gets image.
     * 从输入流中获取图形
     *
     * @param inputStream the input stream
     * @return the image
     * @throws java.io.IOException the iO exception
     */
    public static BufferedImage getImage(InputStream inputStream) throws IOException {
        return ImageIO.read(inputStream);
    }

    /**
     * Resize img.
     * 调整图片大尺寸
     *
     * @param file      the file
     * @param maxHeight the max height
     * @param maxWidth  the max width
     * @return the buffered image
     * @throws java.io.IOException the iO exception
     */
    public static BufferedImage resizeImg(InputStream file, Integer maxHeight, Integer maxWidth) throws IOException {
        BufferedImage image = ImageIO.read(file);
        return resizeImg(image, maxHeight, maxWidth);
    }

    /**
     * Resize img.
     * 调整图片大尺寸
     *
     * @param image     the image
     * @param maxHeight the max height
     * @param maxWidth  the max width
     * @return the buffered image
     * @throws java.io.IOException the iO exception
     */
    public static BufferedImage resizeImg(BufferedImage image, Integer maxHeight, Integer maxWidth) throws IOException {
        //图片尺寸的大小处理，如果长宽都小于规定大小，则返回，如果有一个大于规定大小，则等比例缩放
        int srcH = image.getHeight(null);
        int srcW = image.getWidth(null);
        if (srcH <= maxHeight && srcW <= maxWidth) {
            return image;
        }
        int tmpH = maxWidth;
        int tmpW = maxHeight;
        //在长度和宽度都做了限制，不能超过设定值
        while (srcH > maxHeight || srcW > maxWidth) {
            if (srcW > maxWidth) {
                tmpH = srcH * maxWidth / srcW;
                srcH = tmpH;
                srcW = maxWidth;
            }
            if (srcH > maxHeight) {
                tmpW = srcW * maxHeight / srcH;
                srcW = tmpW;
                srcH = maxHeight;
            }
        }
        BufferedImage bufferedImage = new BufferedImage(srcW, srcH,
                BufferedImage.TYPE_3BYTE_BGR);
        bufferedImage.getGraphics().drawImage(
                image.getScaledInstance(srcW, srcH, Image.SCALE_DEFAULT), 0,
                0, srcW, srcH, null);

        return bufferedImage;
    }
    
    public static byte[] convertImageToBytes(BufferedImage image,String format) throws IOException {
    	ByteArrayOutputStream out = new ByteArrayOutputStream();
    	ImageIO.write(image, format, out);
    	return out.toByteArray();
    }


    /**
     * 根据宽、高获取最优的图片信息
     *
     * @param imageInfos 图片信息列表
     * @param width 图片宽度
     * @param height 图片高度
     * @return ImageInfo 图片信息
     */
    public static ImageInfo getOptimalImageInfo(java.util.List<ImageInfo> imageInfos, Integer width, Integer height) {

        ImageInfo imageInfo = null;

        if (width == null && height == null) {  // 当width,height 为null的时候显示原图

            for (ImageInfo imageInfo1 : imageInfos) {
                // 图片路径
                String url = imageInfo1.getUrl();

                if (url.indexOf("@") == -1) {   // 不带@为原图，
                    imageInfo = imageInfo1;
                    break;
                }
            }

        } else {

            // 设置第一个为最优图片信息实体
            imageInfo = imageInfos.get(0);

            // 设第一个图片信息与传入width、height的差值为最小值
            int min = Math.abs(imageInfos.get(0).getWidth() - width) + Math.abs(imageInfos.get(0).getHeight() - height);

            for (int i = 0; i < imageInfos.size(); i++) {  // 遍历计算最小值

                // 获取图片信息
                ImageInfo tempImageInfo = imageInfos.get(i);

                // 获取当前图片信息与传入width、height的差值
                Integer newValue = Math.abs(tempImageInfo.getWidth() - width) + Math.abs(tempImageInfo.getHeight() - height);

                if (newValue < min) { // 循环计算最优图片的下标
                    min = newValue;
                    imageInfo = tempImageInfo;
                }
            }

        }

        return imageInfo;   // 获取最优的图片信息
    }

    
}