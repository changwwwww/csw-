package com.fh.api.commons;


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebContextFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        /*调用setRequest方法*/
        WebContext.setRequest((HttpServletRequest) request);
        try {
            /*等同于return true   继续执行*/
            chain.doFilter(request,response);
        }finally {
            /*释放资源*/
            WebContext.remove();
        }
    }

    @Override
    public void destroy() {

    }
}
