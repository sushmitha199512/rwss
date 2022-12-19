package nic.watersoft.commons;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.IOException;
import java.util.Enumeration;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class RequestLoggingFilter
 */
@WebFilter("/RequestFilter")
public class RequestFilter implements Filter {

    private ServletContext context;
    private FilterConfig fcon = null;

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        this.context = fConfig.getServletContext();

        fcon = fConfig;
        this.context.log("RequestLoggingFilter initialized");
    }

    @Override
    public void destroy() {
        //System.out.println("destroye method");
        fcon = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);
        String referrer = req.getHeader("referer");
        String host = req.getServerName();
        String name = null;
        String value = null;
        SQLInjectionBlackList sql = new SQLInjectionBlackList();
        boolean result = true;
        Enumeration<String> params = req.getParameterNames();
     
        while (params.hasMoreElements()) {
            /*if (referrer.contains(host)) {

            } else {
                session.invalidate();

                res.sendRedirect("rws_login_frm.jsp");

            }*/
             name = params.nextElement();
             value = request.getParameter(name);
           // System.out.println("req filter name :"+name);
           // System.out.println("req filter value :"+value);
           
            if (result) {
                //System.out.println("result :"+result);
                result = sql.isSecuritySensitive(value);
               

            } else {
                break;
            }

        }
      

        if (result == false) {
        	
        	//System.out.println("false req filter name :"+name);
            //System.out.println("false req filter value :"+value);
            //System.out.println("false result :"+result);

            res.sendRedirect("pred_mal_page.jsp");
            return;
        }

        chain.doFilter(request, response);

    }

}
