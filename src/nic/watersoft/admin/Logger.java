package nic.watersoft.admin;
import java.util.*;
import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import nic.watersoft.commons.RwsUser;


public final class Logger implements Filter 
{
    private FilterConfig filterConfig = null;
	
	public void init(FilterConfig filterConfig) 
    {
         this.filterConfig = filterConfig;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException 
    {
    	
    	try
		{
    		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		if (req.getParameter("page") != null && req.getParameter("page").contains("WEB-INF")) {
			((HttpServletResponse) response).sendRedirect("rws_login_frm.jsp");
		}
    	String browser = "Not Known";
        String authType = "none";
		String module = "Not Known";
        String userId = "Not known";
        Date date1 = new Date();
        HttpSession session = ((HttpServletRequest)request).getSession();

		String requestUri = ((HttpServletRequest) request).getRequestURI();
        String resourceName = requestUri.substring(requestUri.lastIndexOf("/")+1,requestUri.length());
        boolean rejected=false;
        
        if((session.getAttribute("RWS_USER")==null && !resourceName.equalsIgnoreCase("Login.do") && !resourceName.equalsIgnoreCase(""))
        		&&(!resourceName.equals("rws_login_asset_rpt.jsp")&&!resourceName.equals("rws_login_hab_rpt11.jsp") && !resourceName.equals("switch.do") && !resourceName.equals("rws_dist_pop_rpt1.jsp") && !resourceName.equals("rws_dist_popstatus_rpt1.jsp") && !resourceName.equals("rws_dist_popcate_rpt1.jsp") && !resourceName.equals("rws_NSS_habitations_rpt.jsp") && !resourceName.equals("rws_wrk_prg1.jsp") && !resourceName.equals("rws_worksmonitoring_progstatus_select1.jsp") 
        		&& !resourceName.equals("rws_worksmonitoring_workstatus_select1.jsp") && !resourceName.equals("rws_worksmonitoring_workstatus_drill2.jsp") && !resourceName.equals("rws_spill_new.jsp") && !resourceName.equals("rws_work_normal_abstract_rpt1.jsp")&& !resourceName.equals("rws_work_general_abstract_rpt1.jsp") && !resourceName.equals("rws_work_gen1.jsp") && !resourceName.equals("rws_work_proj_abstract_rpt2.jsp") 
				&& !resourceName.equals("rws_complaints_confirm_frm.jsp") && !resourceName.equals("rws_complaints_frm.jsp") && !resourceName.equals("rws_hab_status_resource_rpt.jsp") && !resourceName.equals("/pred/admin/Captcha/Cap_Img.jsp")))
        {        	
        	rejected = true;
            RequestDispatcher dispatcher = request.getRequestDispatcher("/sessionExpired.jsp");
            dispatcher.forward(request, response);
		}
        else
        {
        	
           long start = System.currentTimeMillis();
           
           String file = ((HttpServletRequest) request).getRequestURI();
           String host = ((HttpServletRequest) request).getRemoteHost();
           
          
           LogBean logBean = new LogBean();
          
           if(((HttpServletRequest)request).getHeader
               ("User-Agent").indexOf("MSIE") >= 0){
               browser = "Internet Explorer";
           }
           if(((HttpServletRequest)request).getHeader
               ("User-Agent").indexOf("Netscape") >= 0){
               browser = "Netscape Navigator";
           }
           
           String type = ((HttpServletRequest)request).getAuthType();
   			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
   			logBean=getLogBean(request,user);
   			String logContent =  "User access at " + date1.toString() + 
			" Authentication type: " + authType +
			" User name: " + userId +
			" User IP: " + request.getRemoteAddr() +      
			" Accessing: " + file + 
			" Host: " + host +
     	   " Browser: " + browser +
     	   " Milliseconds used: " + (System.currentTimeMillis() - start) ;
   			boolean loggedSuccessfully=false;
   			//System.out.println();
   			if( !( file.indexOf(".gif")>0 || 
	               file.indexOf(".jpg")>0 ||
				   file.indexOf(".jpeg")>0 ||
				   file.indexOf(".png")>0 ||	
				   file.indexOf(".css")>0
				))
   			{
   				AdminDAO adminDAO = new AdminDAO();
   			//System.out.println("before log method");
   				loggedSuccessfully=adminDAO.log(logBean,request);
   				////System.out.println("after log method:"+loggedSuccessfully);
   				String contextPath = req.getContextPath();
   				if (null == session) {
   					resp.sendRedirect(contextPath+"/masters/sessionExpired.jsp");
   					}
   				else
   				{
   					if(loggedSuccessfully)
   	   					session.setAttribute("loggedSuccessfully","true");
   	   				else
   	   					session.setAttribute("loggedSuccessfully","false");
   				}
   				filterConfig.getServletContext().log(logContent);   				
   			}
        	chain.doFilter(request, response);
        }
		}
    	catch(Exception e){
    		System.out.println("An Exception has been caught in Logger.java "+e);
    		e.printStackTrace();
    	//  RequestDispatcher dispatcher = request.getRequestDispatcher("/sessionExpired.jsp");
		//  dispatcher.forward(request, response);
    	}
    }

    
    private void reject(ServletRequest request, ServletResponse response)
    throws IOException, ServletException {

    	request.setAttribute("errorMsg",
          "Please make sure to provide a valid value for all of the text fields.");

  Enumeration params = request.getParameterNames();
  String paramN = null;

  while (params.hasMoreElements()) {

    paramN = (String) params.nextElement();

    request.setAttribute(paramN, request.getParameter(paramN));

  }

  RequestDispatcher dispatcher = request
      .getRequestDispatcher("/sessionExpired.jsp");
  dispatcher.forward(request, response);
  

}

    public LogBean getLogBean(ServletRequest request,RwsUser user)
    {
    	String browser = "Not Known";
        String authType = "none";
		String module = "watersoft";
        String userId = "Not known";      
        
        String host = ((HttpServletRequest) request).getRemoteHost();
    	String file = ((HttpServletRequest) request).getRequestURI();
    	String address =  request.getRemoteAddr();
    	if(((HttpServletRequest)request).getAuthType()!=null)
    	authType = ((HttpServletRequest)request).getAuthType();
    	
    	int firstIndex = file.indexOf("/",1);
		int secondIndex = file.indexOf("/",firstIndex);
    	module = file.substring(firstIndex, secondIndex);
    	
    	if(user != null)
		{
			userId = user.getUserId();
		}
    	else if(((HttpServletRequest)request).getParameter("userId")!=null )
    	{
    		userId=(String)((HttpServletRequest)request).getParameter("userId");
    	}
    	
    	if(((HttpServletRequest)request).getParameter("loginMode")!=null )
    	{
    		module=(String)((HttpServletRequest)request).getParameter("loginMode");
    	}
    	else
    		module="watersoft";
    	if(((HttpServletRequest)request).getHeader
                ("User-Agent").indexOf("MSIE") >= 0){
                browser = "Internet Explorer";
            }
            if(((HttpServletRequest)request).getHeader
                ("User-Agent").indexOf("Netscape") >= 0){
                browser = "Netscape Navigator";
            }
    	 
    	LogBean logBean=new LogBean();	
	
		
		logBean.setUserId(userId);
		logBean.setAuthType(authType);
		Calendar cal = Calendar.getInstance();
	    int hour12 = cal.get(Calendar.HOUR);             
	    int hour24 = cal.get(Calendar.HOUR_OF_DAY);     
	    int min = cal.get(Calendar.MINUTE);            
	    int sec = cal.get(Calendar.SECOND);              
	    int ms = cal.get(Calendar.MILLISECOND);          
	    int ampm = cal.get(Calendar.AM_PM);
	    String time="";
	    String hour="";
	    String mins="";
	    String secs="";
	    if(hour12<10)
	    	hour="0"+hour12;
	    else
	    	hour=""+hour12;
	   	if(min<10)
	   		mins="0"+min;
	   	else
	   		mins=""+min;
	    if(sec<10)
	    	secs="0"+sec;
	    else
	    	secs=""+sec;
	    if(ampm==0)
	    	 time=time+hour+":"+mins+":"+secs+":"+ms+" AM";
	    else
	    	 time=time+hour+":"+mins+":"+secs+":"+ms+" PM";
	    
	   
        logBean.setAccessTime(time);
		logBean.setModule(module);	
		logBean.setPage(file);	
		logBean.setAddress(address);
		logBean.setHost(host);
		logBean.setBrowser(browser);	
		
		return logBean;
	
    }
    public void destroy() { }
    
}
