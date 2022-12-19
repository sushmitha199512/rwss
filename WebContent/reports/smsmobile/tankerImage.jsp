<%-- <%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tanker Image</title>
</head>
<body>
<%
	String imageId = request.getParameter("imageId");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String itype = request.getParameter("type");
%>
<img src="${pageContext.request.contextPath}/reports/smsmobile/rws_tanker_Image.jsp?imageId=<%=imageId%>&year=<%=year%>&month=<%=month%>&day=<%=day%>&type=<%=itype%>"
		width="500px" height="500px" border="0" id="thumbnail" />
</body>
</html> --%>
<%@page import="java.io.OutputStream"%>
<%-- <%@page import="javax.servlet.ServletOutputStream"%> --%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
String imageId = request.getParameter("imageId");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
//response.setContentType("application/pdf");
response.setContentType("image/gif");
//response.setContentType("text/html;charset=UTF-8");
/* OutputStream out1=response.getOutputStream();
byte a[]=(byte[])session.getAttribute("copyData");
out1.write(a);
out.flush();
out1.close(); */
byte data[] = null;
try {
/* 	String ctxPath = getServletContext().getRealPath("/");//+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator;		
	 if(ctxPath != null && !ctxPath.isEmpty() && ctxPath.contains(File.separator+"webapps"+File.separator)){
		 String sample[]  = ctxPath.split( File.separator+"webapps"+File.separator);
		 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 ctxPath = sample[0];
	 }else{
		 String sample[]  = ctxPath.split( "webapps");
		// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 ctxPath = sample[0];
	 }

	 String rootDir = ctxPath+ File.separator +"TankerImages"+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
	  */
	  String imagesPath = File.separator+"mnt"+File.separator+"DATA-NAS"+ File.separator +"TankerImages";
	   String sapp = imagesPath+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
	   
	 //System.out.println("image path :"+imageId);
	String spath1 = sapp+imageId;
	
	//System.out.println("clipping image :"+newsPaperImagePath);
	File f = new File(spath1);
			 if(f.getAbsoluteFile().exists()){
				 FileInputStream fin = new FileInputStream(f);
					ServletOutputStream outStream = response.getOutputStream();
					response.setContentType("image/jpeg");
					int i = 0;
					while (i != -1) {
					i = fin.read();
					outStream.write(i);
					}
					fin.close();
					outStream.close();
					
					}
					
					} catch (Exception e) {
	e.printStackTrace();
} 
%> 