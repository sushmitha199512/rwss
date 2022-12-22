<%@	page import="java.sql.*, java.util.*,nic.watersoft.commons.RwsOffices" %>
<%!
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Statement stmt = null;
	%>
<%		
	
try{
   	 conn=RwsOffices.getConn();
    }
catch(Exception e){ }
%>  

