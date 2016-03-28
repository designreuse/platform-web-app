package com.aladdin.platform.listener;

import com.aladdin.core.dao.IAldExchangeRateCoreDao;
import com.aladdin.core.po.AldExchangeRateEntity;
import com.aladdin.core.util.RateUtils;
import com.aladdin.core.util.WebClient;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by wangtaotao on 2015/12/31.
 */
@Service
public class ExchangeRateJob  {

    //汇率dao
    @Resource(name = "aldExchangeRateCoreDao")
    private IAldExchangeRateCoreDao aldExchangeRateCoreDao;

    //币种
    private String CNY = "CNY";
    private String RUB = "RUB";
    private String USD = "USD";
    //币种id
    private Integer CNY_TYPE = 3;
    private Integer RUB_TYPE = 2;
    private Integer USD_TYPE = 1;

    //通过Yahoo api 获取汇率并存到数据库汇率表中的作业
    public void doJob(){
        //清空汇率缓存
        RateUtils.clearInstance();
        AldExchangeRateEntity entity= new AldExchangeRateEntity();
        //人民币兑卢布
        Double rateByYahoo = getExchangeRateByYahoo(CNY, RUB);
        entity.setCurrentCurrency(CNY);
        entity.setTargetCurrency(RUB);
        entity.setCurrentType(CNY_TYPE);
        entity.setTargetType(RUB_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo);
        aldExchangeRateCoreDao.insert(entity);
        //卢布兑人民币
        rateByYahoo = getExchangeRateByYahoo(RUB, CNY);
        entity.setCurrentCurrency(RUB);
        entity.setTargetCurrency(CNY);
        entity.setCurrentType(RUB_TYPE);
        entity.setTargetType(CNY_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo1);
        aldExchangeRateCoreDao.insert(entity);
        //人民币兑美元
        rateByYahoo = getExchangeRateByYahoo(CNY, USD);
        entity.setCurrentCurrency(CNY);
        entity.setTargetCurrency(USD);
        entity.setCurrentType(CNY_TYPE);
        entity.setTargetType(USD_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo2);
        aldExchangeRateCoreDao.insert(entity);
        //美元兑人民币
        rateByYahoo = getExchangeRateByYahoo(USD, CNY);
        entity.setCurrentCurrency(USD);
        entity.setTargetCurrency(CNY);
        entity.setCurrentType(USD_TYPE);
        entity.setTargetType(CNY_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo3);
        aldExchangeRateCoreDao.insert(entity);
        //美元兑卢布
        rateByYahoo = getExchangeRateByYahoo(USD, RUB);
        entity.setCurrentCurrency(USD);
        entity.setTargetCurrency(RUB);
        entity.setCurrentType(USD_TYPE);
        entity.setTargetType(RUB_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo4);
        aldExchangeRateCoreDao.insert(entity);
        //卢布兑美元
        rateByYahoo = getExchangeRateByYahoo(RUB, USD);
        entity.setCurrentCurrency(RUB);
        entity.setTargetCurrency(USD);
        entity.setCurrentType(RUB_TYPE);
        entity.setTargetType(USD_TYPE);
        entity.setRate(rateByYahoo);
        entity.setCreateTime(new Date());
        entity.setDisabled(false);
        //System.out.println(rateByYahoo5);
        aldExchangeRateCoreDao.insert(entity);
    }

    /**
     * 通过Yahoo API 获取Yahoo汇率
     * @param strCurrency 当前币种 CNY USD RUB
     * @param strTargetCurrency 目标币种 CNY USD RUB
     * @return String 当前汇率
     */
    public  Double getExchangeRateByYahoo(String strCurrency,String strTargetCurrency) {
        WebClient wc =new WebClient();
        String strUrl="http://finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s="+strCurrency+strTargetCurrency+"=X";
        String strResult="0";
        try {
            String strContent= wc.getContent(strUrl, "UTF-8", "UTF-8");
            String[] values = strContent.split(",");
            if (values.length>2)
            {
                strResult =values[1];
            }
        } catch (Exception e) {
            //e.printStackTrace();
        }
        double dResult= 0;
        try
        {
            dResult= Double.parseDouble(strResult);
        }
        catch (Exception e)
        {

        }
        return dResult;
    }

}
