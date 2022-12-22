<%@ include file="/reports/conn.jsp" %>
<%

  String  ifscCode=request.getParameter("ifsc");
  String q1="select *from RWS_BANK_IFSC_CODE_TBL  where IFSC_CODE='"+ifscCode+"'";
  //System.out.println("query"+q1);
try{
   stmt=conn.createStatement();
	 rs=  stmt.executeQuery(q1);

if(rs.next()){
%>
<%=rs.getString(1) + "^" + rs.getString(2) + "^"
						+ rs.getString(3) + "^" + rs.getString(4) + "^"
						+ rs.getString(5) + "^" + rs.getString(6) + "^"+ rs.getString(7) + "^" + rs.getString(8) 
						%>

<% 
}

}catch(Exception e){
e.printStackTrace();
}
finally{
try{
if(stmt!=null){
stmt.close();
}
if(rs!=null){
rs.close();
}
}catch(Exception e){
e.printStackTrace();
}
}

%>
