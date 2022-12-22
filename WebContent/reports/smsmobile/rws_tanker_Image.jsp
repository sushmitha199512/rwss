<%@page import="java.sql.ResultSet"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
String imageId = request.getParameter("imageId");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String itype = request.getParameter("type");
response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
response.setContentType("image/gif");
Connection conn = null;
PreparedStatement psmt = null;
InputStream iStream = null;
byte data[] = null;
try {
	
 	//String sapp = getServletContext().getRealPath("/")+"TankerImages"+File.separator+year+File.separator+month+File.separator+day+File.separator;		
	 //
	 String imagesPath = File.separator+"mnt"+File.separator+"DATA-NAS"+ File.separator +"TankerImages";
	   String sapp = imagesPath+ File.separator +year+ File.separator +month+ File.separator +day+File.separator ;
	   
 	String spath1 = sapp+imageId+itype;
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
} finally {
	try {
		if (conn != null) {
			conn.close();
		}
		if (psmt != null) {
			psmt.close();
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%> 



