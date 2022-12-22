
package nic.watersoft.admin;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;
/**
 * @author Sharma
 *
 * This is an authentication filter
 */
public class AuthenticationFilter implements Filter
{
	FilterConfig config;
	public void init(FilterConfig config) throws ServletException
	{
		this.config = config;
	}
	
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
	throws ServletException, IOException
	{
		//System.out.println("in Authentication filter");
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		HttpSession session = request.getSession(true);
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if(! (user != null && user.isAuthenticated()) )
		{	
			//System.out.println("AuthenticationFilter Called.");
			//System.out.println("Login Required");
		}
		
		chain.doFilter(req, res);
	}
	
	public void destroy()
	{
	}
}
