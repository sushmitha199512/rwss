
<%@page import="java.sql.ResultSet"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
String workid=request.getParameter("workid");
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
;
if(mode.equals("image1")){
try {
//System.out.println("newsId----"+newsId);
	conn = RwsOffices.getConn();
	String getQuery = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID=?";
	System.out.println("GetQuery:" + getQuery);
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, workid);
	
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
else if(mode.equals("image2")){

try {
//System.out.println("newsId----"+newsId);
	conn = RwsOffices.getConn();
	String getQuery = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID=?";
	System.out.println("GetQuery:" + getQuery);
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, workid);
	
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



