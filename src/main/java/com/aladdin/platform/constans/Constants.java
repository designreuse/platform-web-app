package com.aladdin.platform.constans;

public class Constants {

    public static final String MEDIUM = "medium_";
    public static final String DEFAULT_LIST_PAGE_NO = "1";
    public static final String DEFAULT_LIST_PAGE_SIZE = "10";
    /**
     * The property under which a transaction token is reported.
     */
    public static final String TOKEN_KEY = "com.wl.framework.auth.web.util.TOKEN";

    /**
     * The session attributes key under which our transaction token is stored, if it is used.
     */
    public static final String TRANSACTION_TOKEN_KEY = "com.wl.framework.auth.web.mvc.TOKEN";

    public static enum MESSAGETYPE {
        P2P(0,"P2P"),P2G(1,"P2G"),BROADCAST(2,"BROADCAST"),PULL(3,"PULL"),S2P(4,"S2P");

        private Integer value;
        private String name;
        MESSAGETYPE (Integer value,String name){
            this.value = value;
            this.name = name;
        }

        public Integer getValue(){
            return this.value;
        }

        public String getName(){
            return this.name;
        }

    }

    public static enum PRIORITY {
        NOSEND(0,"不发送"),PRIORITY1(1,"优先级1"),PRIORITY2(2,"优先级2"),PRIORITY3(3,"优先级3");

        private Integer value;
        private String name;
        PRIORITY (Integer value,String name){
            this.value = value;
            this.name = name;
        }

        public Integer getValue(){
            return this.value;
        }

        public String getName(){
            return this.name;
        }

    }



}
