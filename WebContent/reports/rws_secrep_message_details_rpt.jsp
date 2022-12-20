<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<script> //  alert("i am in msg details");</script>
<body>
<%
  try
     { 
	  String userid=(String)session.getAttribute("userId");
	  if(userid!=null || !userid.equals("")){
      %>
<table width="90%">
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="3">Messages Details</td>
</tr>
</table>
<table>
       <%
       int msid=Integer.parseInt(request.getParameter("msid"));       
       //System.out.println("index value"+msid);  
       int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="",mbgcolor="",mstatus="";
       stmt1=conn.createStatement();
       stmt2=conn.createStatement();
       int p=0;
       		System.out.println("userid :"+userid);
           
           qry="select MESSAGE_DETAILS from rws_secretary_message_tbl where MESG_ID ="+msid+" ";
	       //System.out.println("qry***********"+qry);
	       rs1=stmt1.executeQuery(qry);
	            while(rs1.next())
             {      
    
             %>   
		        <tr> 
                <td><textarea rows="3" cols="40"><%=rs1.getString(1)%>
                </textarea></td>
               	</tr>
		   <%
              
              }
           qry1="update rws_secretary_message_tbl set READ_STATUS='R' where MESG_ID ="+msid+" ";
	       //System.out.println("qry1***********"+qry1);
	       stmt2.executeUpdate(qry1);
	       conn.commit();   
           
%>
<tr>
<td align="center" class="bwborder"><a href="#" onclick="window.close();">Close&nbsp;</td> 
</tr>
</table>
<%
	  }
   }
   catch(Exception e)
     {
     e.printStackTrace();
     } 
%>
</body>