package com.aladdin.platform.result;

/**
 * 封装了ajax的返回属性
 *
 */
public class AjaxResult {

    private Boolean result;

    private Object data;

    private String msg;

    public AjaxResult(Boolean result, Object data, String msg) {
        this.result = result;
        this.data = data;
        this.msg = msg;
    }

    public AjaxResult(Boolean result, String msg){
        this.result = result;
        this.msg = msg;
    }

    public AjaxResult(Object data) {
        this.result = true;
        this.data = data;
    }
    public AjaxResult() {
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
