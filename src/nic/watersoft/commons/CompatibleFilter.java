package nic.watersoft.commons;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*public class CompatibleFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        resp.setHeader("Cache-Control", "public");
        resp.setHeader("Pragma", "no-cache");
        //resp.addHeader("X-UA-Compatible", "IE=EmulateIE7");
        resp.addHeader("X-UA-Compatible", "IE=EmulateIE11");
        resp.addHeader("X-UA-Compatible", "IE=EmulateIE7");
        chain.doFilter(request, response);
    }*/

	public class CompatibleFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse resp = (HttpServletResponse) response;
        resp.setHeader("Cache-Control", "private, max-age=0, no-store");  // HTTP 1.1
        resp.setHeader("Pragma","no-cache");  // HTTP 1.1
        resp.addHeader("X-UA-Compatible", "IE=EmulateIE7");
        chain.doFilter(request, response);
    }

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}