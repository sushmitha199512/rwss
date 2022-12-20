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

   String q1="select distinct substr(work_id,1,11),count(*)   from rws_drought_works_tbl group by substr(work_id,1,11) order by substr(work_id,1,11)";
   ResultSet rss=stmt.executeQuery(q1);
      while(rss.next()){
             String oldWorkId=rss.getString(1);
			int count=rss.getInt(2);
			 
          String q2="select substr(work_id,1,11),work_id from rws_drought_works_tbl where substr(work_id,1,11)='"+oldWorkId+"'";
			ResultSet rs1=stmt1.executeQuery(q2);
               String slno="";
			  int s=0;
			 while(rs1.next()){
		
					String newWorkId=rs1.getString(1);
			String w1=rs1.getString(2);		
                      s++;
                    if(s<=9){
                         slno="00"+s;
							}else if(s<=99){
                         slno="0"+s;
                           }else if(s<=999){
                         slno=""+s;
								} 
					String finalWork=newWorkId+slno;
					System.out.println("finalWork:"+finalWork);
            					
                  String updateQuery="update rws_drought_works_tbl set NEW_WORK_ID='"+finalWork+"' where work_id='"+w1+"'";

		           System.out.println("updateQuery:"+updateQuery);
					stmt2.executeUpdate(updateQuery);
                            	

                    }        //end while
  
          }


          
      
 
 }catch(Exception e){
		e.printStackTrace();
}

   


 %>



<BODY>
<P>Place content here.</P>
</BODY>
</html:html>
