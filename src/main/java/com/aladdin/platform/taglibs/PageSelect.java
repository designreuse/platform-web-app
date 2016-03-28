package com.aladdin.platform.taglibs;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

import java.util.Map;
import java.util.Set;

public class PageSelect extends RequestContextAwareTag {

	private static final long serialVersionUID = 1L;
	private String address;
	private Map<String,String> params;
	

	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


   


	public Map<String, String> getParams() {
		return params;
	}


	public void setParams(Map<String, String> params) {
		this.params = params;
	}


	@Override
	protected int doStartTagInternal() throws Exception {
	
		if(params!=null){
			  Set<String> keys = params.keySet();
			    //首页start
			    String strHomePage="";
			    if(Integer.valueOf(params.get("curPage"))==1){
			    	strHomePage="<li class=\"active\"><a data-page=1 href='";
			    }else{
			    	 strHomePage="<li><a data-page=1 href='";
			    }
			    strHomePage=strHomePage+address;
			    strHomePage=strHomePage+"curPage=1";
			    for (String string : keys) {
					String value = params.get(string);
					if((!"curPage".equals(string)&&!"pageCount".equals(string))){
						strHomePage=strHomePage+"&"+string+"="+value;
					}
				}
			    strHomePage=strHomePage+"'>首页</a></li>";
			   //首页end
			    //上一页开始
			    String strPrePage = "";
				if(Integer.valueOf(params.get("curPage"))-1>=1){
					strPrePage="<li><a data-page='"+(Integer.valueOf(params.get("curPage"))-1)+"' href='";
					strPrePage=strPrePage+address;
					strPrePage=strPrePage+"curPage="+(Integer.valueOf(params.get("curPage"))-1);
					for (String string : keys) {
							String value = params.get(string);
							if((!"curPage".equals(string)&&!"pageCount".equals(string))){
								strPrePage=strPrePage+"&"+string+"="+value;
							}
						}
					strPrePage=strPrePage+"'>上一页</a></li>";
				}
				
				//上一页结束
				//前两页开始
				  String strBefSecondPage = "";
				  Integer befSecondPage=Integer.valueOf(params.get("curPage"))-2;
				  if(befSecondPage>=1){
					  strBefSecondPage="<li><a data-page='"+befSecondPage+"' href='";
					  strBefSecondPage=strBefSecondPage+address;
					  strBefSecondPage=strBefSecondPage+"curPage="+befSecondPage;
						for (String string : keys) {
								String value = params.get(string);
								if((!"curPage".equals(string)&&!"pageCount".equals(string))){
									strBefSecondPage=strBefSecondPage+"&"+string+"="+value;
								}
							}
						strBefSecondPage=strBefSecondPage+"'>"+befSecondPage+"</a></li>";
					}
				  
				//前两页结束
				 //前一页开始
				  String strBefFirstPage="";
				  Integer befFristPage=Integer.valueOf(params.get("curPage"))-1;
				  if(befFristPage>=1){
					  strBefFirstPage="<li><a data-page='"+befFristPage+"' href='";
					  strBefFirstPage=strBefFirstPage+address;
					  strBefFirstPage=strBefFirstPage+"curPage="+befFristPage;
						for (String string : keys) {
								String value = params.get(string);
								if((!"curPage".equals(string)&&!"pageCount".equals(string))){
									strBefFirstPage=strBefFirstPage+"&"+string+"="+value;
								}
							}
						 strBefFirstPage=strBefFirstPage+"'>"+befFristPage+"</a></li>";
					}
				 
				 //前一页结束
				  //当前页开始
				  String strCurPage="";
				  Integer curPage=Integer.valueOf(params.get("curPage"));
				  strCurPage="<li class=\"active\"><a data-page='"+curPage +"' href='#";
				 /* strCurPage=strCurPage+address;
				  strCurPage=strCurPage+"curPage="+curPage;
				  for (String string : keys) {
						String value = params.get(string);
						if((!"curPage".equals(string)&&!"pageCount".equals(string))){
							strCurPage=strCurPage+"&"+string+"="+value;
						}
						 
					}
				  strCurPage=strCurPage+"'>"+curPage+"</a></li>";*/
				  strCurPage=strCurPage+"'>"+curPage+"</a></li>";
				  //当前页结束
				  //后一页开始
				  String strAftFirstPage="";
				  Integer aftFirstPage=Integer.valueOf(params.get("curPage"))+1;
				  Integer pageCount=Integer.valueOf(params.get("pageCount"));
				  if(aftFirstPage<=pageCount){
					  strAftFirstPage="<li><a data-page='"+aftFirstPage+"' href='";
					  strAftFirstPage=strAftFirstPage+address;
					  strAftFirstPage=strAftFirstPage+"curPage="+aftFirstPage;
						for (String string : keys) {
								String value = params.get(string);
								if((!"curPage".equals(string)&&!"pageCount".equals(string))){
									strAftFirstPage=strAftFirstPage+"&"+string+"="+value;
								}
							}
						  strAftFirstPage=strAftFirstPage+"'>"+aftFirstPage+"</a></li>";
				  }
				
				  //后一页结束
				  //后两页开始
				  String strAftSecPage="";
				  Integer aftSecPage=Integer.valueOf(params.get("curPage"))+2;
				  
				  if(aftSecPage<=pageCount){
					  strAftSecPage="<li><a data-page='"+aftSecPage+"' href='";
					  strAftSecPage=strAftSecPage+address;
					  strAftSecPage=strAftSecPage+"curPage="+aftSecPage;
						for (String string : keys) {
								String value = params.get(string);
								if((!"curPage".equals(string)&&!"pageCount".equals(string))){
									strAftSecPage=strAftSecPage+"&"+string+"="+value;
								}
							}
						  strAftSecPage=strAftSecPage+"'>"+aftSecPage+"</a></li>";
				  }
				
				  //后两页结束
				  //下一页开始
				   String strNextPage = "";
				   Integer nextPage=Integer.valueOf(params.get("curPage"))+1;
					if(nextPage<=pageCount){
						strNextPage="<li><a data-page='"+nextPage+"' href='";
						strNextPage=strNextPage+address;
						strNextPage=strNextPage+"curPage="+nextPage;
						for (String string : keys) {
								String value = params.get(string);
								if((!"curPage".equals(string)&&!"pageCount".equals(string))){
									strNextPage=strNextPage+"&"+string+"="+value;
								}
							}
						strNextPage=strNextPage+"'>下一页</a></li>";
					}
					
				  //下一页结束
				  //尾页开始
					 String strEndPage="";
					 if(pageCount==0){
						 pageCount=1;
					 }
					 if(Integer.valueOf(params.get("curPage"))==pageCount){
						 strEndPage= "<li class=\"active\"><a data-page='"+pageCount+"' href='";
					 }else{
						 strEndPage="<li><a data-page='"+pageCount+"' href='";
					 }
					
					 strEndPage=strEndPage+address;
					 strEndPage=strEndPage+"curPage="+pageCount;
					    for (String string : keys) {
							String value = params.get(string);
							if((!"curPage".equals(string)&&!"pageCount".equals(string))){
								strEndPage=strEndPage+"&"+string+"="+value;
							}
						}
					    strEndPage=strEndPage+"'>尾页</a></li>";
				  //尾页结束
			      pageContext.getOut().print("<ul>"+strHomePage+strPrePage+strBefSecondPage+strBefFirstPage+strCurPage+strAftFirstPage+strAftSecPage+strNextPage+strEndPage+"</ul>");
		}
	  
		return SKIP_BODY;
	}

}

