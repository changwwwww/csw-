package com.fh.api.commons;

import javax.servlet.http.HttpServletRequest;

public class WebContext {
    private static final ThreadLocal<HttpServletRequest> requsetThreadLocal=new ThreadLocal<>();

    public static void setRequest(HttpServletRequest request){

        requsetThreadLocal.set(request);
    }

    public static HttpServletRequest getRequest(){

    return     requsetThreadLocal.get();
    }

     public static  void remove(){
         requsetThreadLocal.remove();
     }
}
