
<%@page import="java.sql.ResultSet"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
String sourceCode=request.getParameter("sourceCode");
response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);   

response.setContentType("image/gif");

Connection conn = null;
PreparedStatement psmt = null;
InputStream iStream = null;
byte data[] = null;


try {

	conn = RwsOffices.getConn();
	String getQuery = "select component_image from rws_asset_comp_image_tbl where COMPONENT_CODE=?";
	System.out.println("GetQuery:" + getQuery);
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, sourceCode);
	
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

%> 



