package com.aladdin.platform.viewexcel;

import com.aladdin.core.bo.BillBo;
import com.aladdin.core.bo.BillDetailBo;
import com.aladdin.core.bo.BillDetailCountBo;
import com.aladdin.core.util.DateFormatUtil;
import com.aladdin.platform.utils.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/4/21.
 */
public class BillViewExcel extends AbstractExcelView {

    private final static Logger LOGGER = LoggerFactory.getLogger(BillViewExcel.class);
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws IOException {
        SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMddHHmmss");
        String excelName = "bill-"+sdf.format(new Date()).toString()+".xls";
        // 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(excelName, "UTF-8"));
        BillDetailCountBo billDetailCountBo = (BillDetailCountBo) model.get("object");
        BillBo billBo = billDetailCountBo.getBillBo();
        List<BillDetailBo> dataList =  billDetailCountBo.getBillDetailBoList();
        List<String> headList =  (List<String>) model.get("headList");
        // 产生Excel表头
        String headSheet = (String)model.get("headSheet");
        HSSFSheet sheet = workbook.createSheet(headSheet);
        sheet.autoSizeColumn(1, true);
        setSheetColumnWidth(sheet);
        HSSFCellStyle style = createTitleStyle(workbook);
        HSSFRow rowAdvance = sheet.createRow(0);// 建立新行
        createCell(rowAdvance, 0, style, HSSFCell.CELL_TYPE_STRING,"服务订单编号:");
        createCell(rowAdvance, 1, style, HSSFCell.CELL_TYPE_STRING,StringUtils.stringNull(billBo.getSrvOrderCode()));
        createCell(rowAdvance, 2, style, HSSFCell.CELL_TYPE_STRING,"委托方:");
        createCell(rowAdvance, 3, style, HSSFCell.CELL_TYPE_STRING,StringUtils.stringNull(billBo.getEntrustOrgName()));
        if (dataList != null && dataList.size() > 0) {
            // 创建第一行标题
            HSSFRow headRow = sheet.createRow((short) 1);
            for(int i=0; i<headList.size(); i++){
                String headStr = headList.get(i);
                createCell(headRow, i, style, HSSFCell.CELL_TYPE_STRING, headStr);
            }
            // 给excel填充数据
            for (int i = 0; i < dataList.size(); i++) {
                // 将dataList里面的数据取出来，假设这里取出来的是Model,也就是某个javaBean的意思啦
                BillDetailBo billDetailBo = dataList.get(i);
                HSSFRow row = sheet.createRow((short) (i + 2));// 建立新行

                String settlementDateText="";
                Date settlementDate = billDetailBo.getSettlementDate();
                settlementDateText = getStringDate(settlementDate);
                createCell(row, 0, style, HSSFCell.CELL_TYPE_STRING,settlementDateText);

                String paymentStatusText="";
                int paymentStatus = billDetailBo.getPaymentStatus();
                if(paymentStatus==0||paymentStatus==1){
                    paymentStatusText="收款";
                }
                if(paymentStatus==2||paymentStatus==3){
                    paymentStatusText="付款";
                }
                createCell(row, 1, style, HSSFCell.CELL_TYPE_STRING, paymentStatusText);

                String dealingsOrgName ="";
                dealingsOrgName=billDetailBo.getDealingsOrgName();
                if(dealingsOrgName==null){
                    dealingsOrgName="";
                }

                createCell(row, 2, style, HSSFCell.CELL_TYPE_STRING, StringUtils.stringNull(billDetailBo.getDealingsOrgName()));
                createCell(row, 3, style, HSSFCell.CELL_TYPE_STRING, StringUtils.stringNull(billDetailBo.getSrvName()));
                createCell(row, 4, style, HSSFCell.CELL_TYPE_STRING, StringUtils.stringNull(billDetailBo.getFeeName()));
                createCell(row, 5, style, HSSFCell.CELL_TYPE_STRING, StringUtils.objectNull(billDetailBo.getCost()));

                String costMark= billDetailBo.getCostMark();
                if(costMark==null){
                    costMark="";
                }else{
                    if("¥".equals(costMark)){
                        costMark="人民币";
                    }
                    if("$".equals(costMark)){
                        costMark="美元";
                    }
                    if("руб".equals(costMark)){
                        costMark="卢布";
                    }
                }
                createCell(row, 6, style, HSSFCell.CELL_TYPE_STRING, StringUtils.objectNull(costMark));
                createCell(row, 7, style, HSSFCell.CELL_TYPE_STRING, StringUtils.objectNull(billDetailBo.getRate()));
                createCell(row, 8, style, HSSFCell.CELL_TYPE_STRING, StringUtils.objectNull(billDetailBo.getRmb()));
            }
        } else {
            createCell(sheet.createRow(0), 0, style,HSSFCell.CELL_TYPE_STRING, "查无资料");
        }
        OutputStream ouputStream = null;
        try {
            ouputStream = response.getOutputStream();
            workbook.write(ouputStream);
        }catch (IOException e){
            LOGGER.error("failed to ouputStream", e);
        }finally {
            ouputStream.flush();
            ouputStream.close();
        }
    }

    /*
     * 设置列宽
     * @param sheet
     */
    private  void setSheetColumnWidth(HSSFSheet sheet) {
        sheet.setColumnWidth(0, 3000);
        sheet.setColumnWidth(1, 5000);
        sheet.setColumnWidth(2, 3000);
        sheet.setColumnWidth(3, 5000);
        sheet.setColumnWidth(4, 7000);
        sheet.setColumnWidth(5, 7000);
        sheet.setColumnWidth(6, 10000);
        sheet.setColumnWidth(7, 30000);
    }

    /*
     *  设置excel的title样式
     */
    private  HSSFCellStyle createTitleStyle(HSSFWorkbook wb) {
        HSSFFont boldFont = wb.createFont();
        boldFont.setFontHeight((short) 200);
        HSSFCellStyle style = wb.createCellStyle();
        style.setFont(boldFont);
        style.setDataFormat(HSSFDataFormat.getBuiltinFormat("###,##0.00"));
        return style;
    }

    /*
     *  创建Excel单元格
      */
    private  void createCell(HSSFRow row, int column, HSSFCellStyle style, int cellType, Object value) {
        HSSFCell cell = row.createCell(column);
        if (style != null) {
            cell.setCellStyle(style);
        }
        switch (cellType) {
            case HSSFCell.CELL_TYPE_BLANK: {
            }
            break;
            case HSSFCell.CELL_TYPE_STRING: {
                cell.setCellValue(value.toString());
            }
            break;
            case HSSFCell.CELL_TYPE_NUMERIC: {
                cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
                cell.setCellValue(Double.parseDouble(value.toString()));
            }
            break;
            default:
            break;
        }
    }


    private Object isNull(Object obj){
        if(obj==null){
            return "";
        }else{
            return obj;
        }
    }

    private String getStringDate(Date date) {
        Date currentTime = date;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String dateString = formatter.format(currentTime);
        return dateString;
    }
}
