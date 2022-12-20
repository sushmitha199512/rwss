<%@page import="nic.watersoft.masters.RwsMasterData"%>
<%@page import="java.io.OutputStream"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	//System.out.println("IN IMAGE ");
	String id = request.getParameter("imgID");
	try {
		//System.out.println("id"+id +"ImageType");
		RwsMasterData masterData = new RwsMasterData();
		byte[] imgData = masterData.getAssetImage(conn, id);		
		response.setContentType("image/gif");
		OutputStream o = response.getOutputStream();
		o.write(imgData);
		out.flush();
		o.close();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		conn.close();
	}
%>