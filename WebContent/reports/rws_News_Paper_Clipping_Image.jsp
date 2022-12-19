
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
String newsId=request.getParameter("newsId");
String newsDate = request.getParameter("date");
String newsPaperImagePath = "";//request.getContextPath();
String mode=request.getParameter("mode");
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
Connection conn = null;
PreparedStatement psmt = null;
InputStream iStream = null;
byte data[] = null;
if(mode.equals("clipImage")){
try {
//System.out.println("newsId----"+newsId);

/* String paperDateTemp[]=newsDate.split("/");
	String paperDatedd = paperDateTemp[0];
	String paperDatemm = paperDateTemp[1];
	String paperDateyyyy = paperDateTemp[2]; */
	
	String paperDateTemp = newsDate.replace("/", "-");
	
	//newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+newsId+".jpg";
	//System.out.println("clipping image :"+newsPaperImagePath);
	
	
	newsPaperImagePath=getServletContext().getRealPath("/") ;
	 if(newsPaperImagePath != null && !newsPaperImagePath.isEmpty() && newsPaperImagePath.contains(File.separator+"webapps"+File.separator)){
		 String sample[]  = newsPaperImagePath.split( File.separator+"webapps"+File.separator);
		 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 newsPaperImagePath = sample[0];
		 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
	 }else{
		 String sample[]  = newsPaperImagePath.split( "webapps");
		// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
		 newsPaperImagePath = sample[0];
		// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+newsPaperImagePath);
	 }
	
	// newsPaperImagePath = newsPaperImagePath+ File.separator+"NewsPaperClippingImages"+File.separator+newsId+".jpg";
	 	
	  newsPaperImagePath = newsPaperImagePath+ File.separator+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+newsId+".jpg";

	 //String spath1 = imagePath+ File.separator+imageId+".jpg";
	
	
	
	
	
	
	
	File f = new File(newsPaperImagePath);
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
			 }/* else{
				 conn = RwsOffices.getConn();
					String getQuery = "select CLIP_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";
					System.out.println("GetQuery:" + getQuery);
					psmt = conn.prepareStatement(getQuery);
					psmt.setString(1, newsId);
					
					 ResultSet rs = psmt.executeQuery();
					if (rs.next()) {
						System.out.println(rs.getBlob(1));
						java.sql.Blob b = rs.getBlob(1);
						iStream = b.getBinaryStream();
						data = new byte[(int) b.length()];
						long i;
						long index = 0;
						while ((i = iStream.read()) != -1) {
							data[(int) index++] = (byte) i;

						}
						OutputStream out1=response.getOutputStream();
						// System.out.println("Bytes available" + iStream.available());
						out1.write(data);
						out.flush();
						out1.close();
					} 
			 } */
			

	
	
	
	
	
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
}
else if(mode.equals("atrImage")){

try {
	
String paperDateTemp = newsDate.replace("/", "-");
	
	//newsPaperImagePath = getServletContext().getRealPath("/")+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
	
	
newsPaperImagePath=getServletContext().getRealPath("/") ;
if(newsPaperImagePath != null && !newsPaperImagePath.isEmpty() && newsPaperImagePath.contains(File.separator+"webapps"+File.separator)){
	 String sample[]  = newsPaperImagePath.split( File.separator+"webapps"+File.separator);
	// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
	 newsPaperImagePath = sample[0];
	 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
}else{
	 String sample[]  = newsPaperImagePath.split( "webapps");
	// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
	 newsPaperImagePath = sample[0];
	//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
}

newsPaperImagePath = newsPaperImagePath+ File.separator+"NewsPaperClippingImages"+ File.separator +paperDateTemp+File.separator+"ACT_"+newsId+".jpg";
	
//newsPaperImagePath = newsPaperImagePath+ File.separator+"NewsPaperClippingImages"+ File.separator +  paperDateTemp+File.separator+newsId+".jpg";


//String spath1 = imagePath+ File.separator+imageId+".jpg";



	
	
	
	
	
	
	
	File f = new File(newsPaperImagePath);
	//System.out.println("atr clipping image :"+newsPaperImagePath);
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
			 }/* else{
				//System.out.println("newsId----"+newsId);
					conn = RwsOffices.getConn();
					String getQuery = "select ATR_IMAGE from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where NEWS_ID=?";
					System.out.println("GetQuery:" + getQuery);
					psmt = conn.prepareStatement(getQuery);
					psmt.setString(1, newsId);
					
					ResultSet rs = psmt.executeQuery();

					if (rs.next()) {
						System.out.println(rs.getBlob(1));
						java.sql.Blob b = rs.getBlob(1);
						iStream = b.getBinaryStream();
						data = new byte[(int) b.length()];
						long i;
						long index = 0;
						while ((i = iStream.read()) != -1) {
							data[(int) index++] = (byte) i;

						}
						OutputStream out1=response.getOutputStream();
						// System.out.println("Bytes available" + iStream.available());
						out1.write(data);
						out.flush();
						out1.close();
					}
			 } */
	

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

}
%> 



