<%		
try{
	if(stmt != null)stmt.close();
	if(ps != null)ps.close();
	if(rs != null)rs.close();
	if(conn!=null)conn.close();
}
catch(Exception e)
{
	//System.out.println("CLOSING IN CONN3.JSP"+e.getMessage());
	
}
%>