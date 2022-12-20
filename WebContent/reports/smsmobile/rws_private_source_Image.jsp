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
String imageId=request.getParameter("imageId");
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
	 imagePath = imagePath+ File.separator+"PrivateSourceImages";
 	String spath1 = imagePath+ File.separator+imageId+".jpg";
	
	//System.out.println("clipping image :"+spath1);
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



