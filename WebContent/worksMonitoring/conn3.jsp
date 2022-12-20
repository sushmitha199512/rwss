<jsp:useBean id="rwsOffices" class="nic.watersoft.commons.RwsOffices"/>
<%@	page import="java.sql.*, java.util.*" %>
<%		
	Connection conn = null, conn1 = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = null;
    PreparedStatement pstmt1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;

	

	

    conn=rwsOffices.getConn();
	conn1=rwsOffices.getConn();
	 
    		%>
   	


	





