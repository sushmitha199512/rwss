<%@ include file ="conn.jsp"%>

<%
Statement stmt1=null;
String query="",message="";
try{
query="select count(*) from  RWS_WQ_TEST_RESULTS_LNK_TBL where TESTING_PARAMETER_VALUE is not null and my_to_number(TESTING_PARAMETER_VALUE) is null";
//System.out.println(query);
stmt=conn.createStatement();
rs=stmt.executeQuery(query);
if(rs.next()){
	int count=rs.getInt(1);
	//System.out.println("count"+count);
	if(count>0){
		
		String updateQuery="update RWS_WQ_TEST_RESULTS_LNK_TBL set TESTING_PARAMETER_VALUE=0 where TESTING_PARAMETER_VALUE is not null and my_to_number(TESTING_PARAMETER_VALUE) is null";
		//System.out.println(updateQuery);
		stmt1=conn.createStatement();
		int res=stmt1.executeUpdate(updateQuery);
		if(res>0){
			message="Now You May Continue to to View Report";
			
		}
		else{
			message="Now You May Continue to to View Report";
		}
	}
	else{
		message="Now You May Continue to to View Report";
	}
}
}
catch(Exception e){
	message="Failed to refresh Data";
	e.printStackTrace();
}
%>
<%=message.trim()%>