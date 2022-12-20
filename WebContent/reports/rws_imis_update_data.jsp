
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Statement statement=null,stmt1=null;
ResultSet resultSet=null;
String olddata="";
String query1="";
int n=0;
try{
	String query="select habcode from IMISMASTERDATA1";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(query);
	while(rs.next()){		
		 olddata="select habcode from IMISMASTERDATA1211017 where habcode='"+rs.getString("habcode")+"'";
		statement=conn.createStatement();
		resultSet=statement.executeQuery(olddata);
		// System.out.println("@@@@"+resultSet);
		if(resultSet.next()){
		 /* for (;;) { */
           // while(resultSet.next()) {
            	 query1="update IMISMASTERDATA1211017 set (STATEID,STATENAME,DISTRICTID,DISTRICTNAME,BLOCKNAME,PANCHAYATNAME,VILLAGENAME,HABITATIONID,HABITATIONNAME,HABCODE,SCCURRENTPOP,STCURRENTPOP,GENCURRENTPOP,CAL_POP,LPCD,STATUS)=(select STATEID,STATENAME,DISTRICTID,DISTRICTNAME,BLOCKNAME,PANCHAYATNAME,VILLAGENAME,HABITATIONID,HABITATIONNAME,HABCODE,SCCURRENTPOP,STCURRENTPOP,GENCURRENTPOP,CAL_POP,LPCD,STATUS from IMISMASTERDATA1 where habcode='"+resultSet.getString("habcode")+"') where habcode='"+resultSet.getString("habcode")+"'";
            	
            // }
             
             /* if ((statement.getMoreResults() == false) && (statement.getUpdateCount() == -1)) {
                 break;
             }
         } */}else{
  			query1="insert into IMISMASTERDATA1211017 (STATEID,STATENAME,DISTRICTID,DISTRICTNAME,BLOCKNAME,PANCHAYATNAME,VILLAGENAME,HABITATIONID,HABITATIONNAME,HABCODE,SCCURRENTPOP,STCURRENTPOP,GENCURRENTPOP,CAL_POP,LPCD,STATUS)  (select STATEID,STATENAME,DISTRICTID,DISTRICTNAME,BLOCKNAME,PANCHAYATNAME,VILLAGENAME,HABITATIONID,HABITATIONNAME,HABCODE,SCCURRENTPOP,STCURRENTPOP,GENCURRENTPOP,CAL_POP,LPCD,STATUS from IMISMASTERDATA1 where habcode='"+rs.getString("habcode")+"')";
  			//System.out.println(query1+"@@@@"+n++);
  			//System.out.println(query1);
  			/* stmt1=conn.createStatement();
  			stmt1.executeUpdate(query1);
  			stmt1.close(); */
  			
  		}
		// System.out.println(query1);
			stmt1=conn.createStatement();
			stmt1.executeUpdate(query1);
			stmt1.close();
		
		statement.close();
		resultSet.close();
		
	}
	rs.close();
	stmt.close();
	out.println("Data updated sucessfully");
}
catch(Exception e){
	e.printStackTrace();
}finally{
	if(conn!=null)
		conn.close();
}
%>
</body>
</html>