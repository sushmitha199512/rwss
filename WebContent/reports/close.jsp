<%
finally{
	
	try{
	if(conn!=null){
		conn.close();
		
	}
	if(ps!=null){
		
		ps.close();
	}
	
if(rs!=null){
		
		rs.close();
	}

	if(stmt!=null){
	
	stmt.close();
	}
	}catch(Exception e){
		
		e.printStackTrace();
	}
	
}
%>