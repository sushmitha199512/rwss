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
String work_id=(String)session.getAttribute("work_id");
String bill_date=(String)session.getAttribute("bill_date");
String bill_sl_no=(String)session.getAttribute("bill_sl_no");
//String newsPaperImagePath = request.getParameter("spath");
//String newsPaperImagePath = "";//request.getContextPath();
//String mode=request.getParameter("mode");
response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
response.setContentType("image/gif");
Connection conn = null;
PreparedStatement psmt = null;
InputStream iStream = null;
byte data[] = null;
//if(mode.equals("clipImage")){
try {
	//String paperDateTemp = newsDate.replace("/", "-");
	//newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+newsId+".jpg";
	String imagePath=getServletContext().getRealPath("/") ;
	 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
		 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
		 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 imagePath = sample[0];
		 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
	 }else{
		 String sample[]  = imagePath.split( "webapps");
		// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 imagePath = sample[0];
		//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
	 }
	 imagePath = imagePath+ File.separator+"PassorderScanCopys";
 	String spath1 = imagePath+ File.separator+work_id+"_"+bill_date+"_"+bill_sl_no+".jpg";
	
	//System.out.println("bill image :"+spath1);
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
//}
%> 
<%-- 
<%@page import="java.io.OutputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
//response.setContentType("application/pdf");
response.setContentType("image/gif");
//response.setContentType("text/html;charset=UTF-8");
OutputStream out1=response.getOutputStream();
byte a[]=(byte[])session.getAttribute("copyData");
out1.write(a);
out.flush();
out1.close();

%> --%>


