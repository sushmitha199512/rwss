
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@ page import="java.io.*"%>
<html:html>
<HEAD>

<TITLE>Pred_Offline_DownLoad Page</TITLE>
</HEAD>

<BODY>
<%
   
    response.setContentType("application/zip/octet-stream");
    
    javax.servlet.ServletContext sc=getServletContext();
    
    String path=sc.getRealPath("")+"/downloads/patch/PATCH1.zip";
    
    System.out.println(path);
    
    File f=new File(path);
    
	response.setHeader("Content-Disposition","attachment;filename=PATCH1.zip"); 
    synchronized(this)
    {
		byte[] bytearray=new byte[(int) f.length()];
		
		if(f.length()<=0)
		{
		 response.setStatus(response.SC_CREATED);
		}
		 response.setContentLength(bytearray.length);
	 	try
		{
		FileInputStream is=new FileInputStream(f);
		
		is.read(bytearray);
		
		OutputStream os=response.getOutputStream();
		
		os.write(bytearray);
		
		os.flush();
		}
		catch(Exception e)
		{
		
		System.out.println(e);
	    
		}
   }
%>

</BODY>
</html:html>
