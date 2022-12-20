
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
  String Dcode=(String)request.getAttribute("DistrictCode"); 
  
  if(!(Dcode.equals("16")))
    {
    
    response.setContentType("application/zip/octet-stream");
    
    javax.servlet.ServletContext sc=getServletContext();
    //for windows os
    String path=sc.getRealPath("downloads")+"/"+request.getAttribute("DistrictCode")+"/PREDOFFLINE.zip";
    //System.out.println(path);
    
    File f=new File(path);
	response.setHeader("Content-Disposition","attachment;filename=PREDOFFLINE"+request.getAttribute("DistrictCode")+".zip"); 
	
	byte[] bytearray=new byte[(int) f.length()];
	
	if(f.length()<=0)
	{
	 response.setStatus(response.SC_CREATED);
	 //response.sendRedirect("./ErrorPage.jsp");
	
	//response.setStatus(response.SC_NO_CONTENT);
	
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
	
	System.out.println("error in "+e);
    
	}
    }
else
{
out.println("<h1>");
out.println("File Not available");
out.println("<A href="+"/pred/home.jsp"+">Click Me</A>");
out.println("to go to home page.");
out.println("</h1>");
} 
%>

</BODY>
</html:html>
