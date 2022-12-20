<%@ include file = "/reports/conn.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE></TITLE>
</HEAD>
<%
  try{
    Statement stmt=conn.createStatement();
    Statement stmt1=conn.createStatement();
    Statement stmt2=conn.createStatement();

   String q1="select work_id  from temp1";
   ResultSet rss=stmt.executeQuery(q1);
      while(rss.next()){
             String oldWorkId=rss.getString(1);
              System.out.println("oldWorkId:"+oldWorkId );
		     String q2="delete from rws_drought_works_tbl where work_id='"+oldWorkId+"'";
    		int reccount=stmt1.executeUpdate(q2);
           System.out.println("Delete Count:"+oldWorkId+"---"+reccount); 
    }


          
      
 
 }catch(Exception e){
		e.printStackTrace();
}

   


 %>



<BODY>
<P>Place content here.</P>
</BODY>
</html:html>
