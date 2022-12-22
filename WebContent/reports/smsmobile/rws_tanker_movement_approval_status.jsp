<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
 <script language="JavaScript">
 function init()
 {
	 window.opener.location.reload();
	 window.close();
	 
	 }
</script> 
 <head>
<style>
        .thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
z-index: 50;
cursor:pointer;
}

.thumbnail span{ /*CSS for enlarged image*/
position:absolute;
left: -9999px;
background-color:#eae9d4;
padding: 10px;
font-family: 'Droid Sans', sans-serif;
font-size:.9em;
text-align: center; 
color: #495a62; 
-webkit-box-shadow: 0 0 20px rgba(0,0,0, .75));
-moz-box-shadow: 0 0 20px rgba(0,0,0, .75);
box-shadow: 0 0 20px rgba(0,0,0, .75);
-webkit-border-radius: 8px; 
-moz-border-radius: 8px; 
border-radius:8px;
}

.thumbnail span img{ 
padding:2px;
background:#ccc;
}

.thumbnail:hover span{ 
top: -280px; 
left: -250px;
width:50px;
height:50px;
}
</style> 
</head>
<!-- <form> -->
<form  name=f1  method="post">
<%
 


    Statement stmt1=null;
	ResultSet rs1=null;
	int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
   
    String status=request.getParameter("status");
    //System.out.println("Status#####"+status);
    
    String tripId=request.getParameter("tripId");
   // System.out.println("tripId#####"+tripId);
    Date   date1=null;
	 Date   date2=null;
	   String str3;
			PreparedStatement ps3;
			ResultSet rs3;
			int rcount = 0;
   
			nic.watersoft.commons.RwsUser user=null;
			user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
			String loggedUser = user.getUserId();
   	%>
   	
   	
   	
   	   	<% if(status.equals("approval")){
		  //String tripId=request.getParameter("tripId"); 
		 // System.out.println("tripId"+tripId);
				
		 %>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
	
		
		
		</tr></table>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<!-- <td ><a href="#" onClick="window.close();">Close</a>  </td> -->

	 
	</tr> 
	<%
	%>
	
	
	 
	</table>
	</caption>
	
	
	</table>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<!-- <tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr> 
				<tr bgcolor="#8A9FCD" align="center">-->
	<tr bgcolor="#ffffff" align="center">
		  
	 	<% 
		 try
		{
			 
			 
			 str="update RWS_TANKER_MOVEMENT_TBL set APPROVED_BY=? where trip_id=?";
		      ps3=conn.prepareStatement(str);
			   ps3.setString(1, loggedUser);
			   ps3.setString(2, tripId);   
		      ps3.executeUpdate();
			 
			 String APPROVEL_STATUS="Y";
      str="update RWS_TANKER_MOVEMENT_TBL set APPROVEL_STATUS=? where trip_id=?";
      ps3=conn.prepareStatement(str);
	   ps3.setString(1, APPROVEL_STATUS);
	   ps3.setString(2, tripId);   
      int rcount1=ps3.executeUpdate();
  	
      if (rcount1 > 0)
      {
    	  
    	  %>
    	  
    	  <td align="center" class="rptHeading" colspan=3> You are Approved the Trip <font color="green"><%=tripId%></font></td>
    	  
    	  <tr></tr>
    	  <tr></tr>
    	  <tr></tr>
    	  
    	  
    	  <tr bgcolor="#ffffff" align="center" >
		<td colspan=3  align="center">
			<input type=button id="close"  onclick="init()"  class=btext value="Close">
			<!-- <input type=button id="circ" onclick="fnSubmit()" value="Get Data" class = btext> -->
			<%-- <input type=button id="disapprove"  onclick="fnSubmit1('<%= tripId %>')"  class=btext value="Dis Approve"> --%>
		
			
		</td>
	</tr>
    	  	
    	  <% 
    	  
    	  
      }else{
    	  %>
    	  <td align="center" class="rptHeading" colspan=3> Please try again.............</td>
    	  <% 
      }
		 %>
		 <%   
	   } catch(Exception e)
	   {
	   e.printStackTrace();
	   //System.out.println(".........");
	   }
	   finally{
		  
	   conn.close();
	   }
		
	   %> 
		 
	
		
	</tr>
	</table>
	
	
	<%} %>
   	
   	
   	
   	
   	   	
   	   	<% if(status.equals("disapproval")){
		  //String tripId=request.getParameter("tripId"); 
		 // System.out.println("tripId"+tripId);
				
		 %>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
	
		
		
		</tr></table>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
<!-- 	<td ><a href="#" onClick="window.close();">Close</a>  </td> -->

	 
	</tr> 
	<%
	%>
	
	
	 
	</table>
	</caption>
	
	
	</table>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<!-- <tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr> -->
	<tr bgcolor="#8A9FCD" align="center">
		  
	 	<% 
		 try
		{
			 str="update RWS_TANKER_MOVEMENT_TBL set APPROVED_BY=? where trip_id=?";
		      ps3=conn.prepareStatement(str);
			   ps3.setString(1, loggedUser);
			   ps3.setString(2, tripId);   
		      ps3.executeUpdate();
			 
			 String APPROVEL_STATUS="N";
			 str="update RWS_TANKER_MOVEMENT_TBL set APPROVEL_STATUS=? where trip_id=?";
		      ps3=conn.prepareStatement(str);
			   ps3.setString(1, APPROVEL_STATUS);
			   ps3.setString(2, tripId);   
		      int rcount1=ps3.executeUpdate();
    
      if (rcount1 > 0)
      {
    	  
    	  %>
    	  
    	  <%-- <td align="center" class="rptHeading" colspan=3> You are dis approved trip id <%=tripId%></td>	 --%>
    	  <td align="center" class="rptHeading" colspan=3> You are Disapproved the Trip <font color="red"><%=tripId%></font></td>
    	    <tr bgcolor="#ffffff" align="center" >
		<td colspan=3  align="center">
			<input type=button id="close"  onclick="init()"  class=btext value="Close">
			<!-- <input type=button id="circ" onclick="fnSubmit()" value="Get Data" class = btext> -->
			<%-- <input type=button id="disapprove"  onclick="fnSubmit1('<%= tripId %>')"  class=btext value="Dis Approve"> --%>
		
			
		</td>
	</tr>
    	  <% 
    	  
    	  
      }else{
    	  %>
    	  <td align="center" class="rptHeading" colspan=3> Please try again.............</td>
    	  <% 
      }
		 %>
		 <%   
	   } catch(Exception e)
	   {
	   e.printStackTrace();
	   //System.out.println(".........");
	   }
	   finally{
		  
	   conn.close();
	   }
		
	   %> 
		 
	
		
	</tr>
	</table>
	
	
	<%} %>
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
   	
</form>

</body>
</html>