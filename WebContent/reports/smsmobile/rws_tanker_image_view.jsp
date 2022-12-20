
<%@page import="java.sql.ResultSet"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.OutputStream"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%

String mode=request.getParameter("status");
response.setHeader("Cache-Control", "no-store");  
response.setHeader("Pragma", "no-cache");  
response.setDateHeader("Expires", 0);  
response.setContentType("image/gif");

Connection conn = null;
PreparedStatement psmt = null;
InputStream iStream = null;
byte data[] = null;
;
if(mode.equals("source")){
	String tripid=request.getParameter("tripid");
try {
	conn = RwsOffices.getConn();
	String getQuery = "select TANKER_SOURCE_IMG  from RWS_TANKER_MOVEMENT_TBL where trip_id=?";
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, tripid);
	
	ResultSet rs = psmt.executeQuery();

	if (rs.next()) {
		java.sql.Blob b = rs.getBlob(1);
		iStream = b.getBinaryStream();
		data = new byte[(int) b.length()];
		long i;
		long index = 0;
		while ((i = iStream.read()) != -1) {
			data[(int) index++] = (byte) i;

		}
		OutputStream out1=response.getOutputStream();
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
else if(mode.equals("destination")){
	String tripid=request.getParameter("tripid");
	String hab=request.getParameter("hab");
try {
	conn = RwsOffices.getConn();
	String getQuery = "select DEST_IMAGE from RWS_TANKER_DEST_LOCATION_TBL where trip_id=? and HABITATION_CODE=?";/* bhagya */
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, tripid);
	psmt.setString(2,hab);
	
	ResultSet rs = psmt.executeQuery();

	if (rs.next()) {
		java.sql.Blob b = rs.getBlob(1);
		iStream = b.getBinaryStream();
		data = new byte[(int) b.length()];
		long i;
		long index = 0;
		while ((i = iStream.read()) != -1) {
			data[(int) index++] = (byte) i;

		}
		OutputStream out1=response.getOutputStream();
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
else if(mode.equals("sourceImg")){
	String sourceCode=request.getParameter("sourceCode");
try {
	conn = RwsOffices.getConn();
	String getQuery = "select SOURCE_IMG  from RWS_PVT_SOURCES_TBL where SOURCE_CODE=?";
	psmt = conn.prepareStatement(getQuery);
	psmt.setString(1, sourceCode);
	
	ResultSet rs = psmt.executeQuery();

	if (rs.next()) {
		java.sql.Blob b = rs.getBlob(1);
		iStream = b.getBinaryStream();
		data = new byte[(int) b.length()];
		long i;
		long index = 0;
		while ((i = iStream.read()) != -1) {
			data[(int) index++] = (byte) i;

		}
		OutputStream out1=response.getOutputStream();
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



