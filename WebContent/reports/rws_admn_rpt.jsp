<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
Statement st1 = null;
	//Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,workid=null,wname=null;
	//String[] record = null;
		int Count=0,Cnt=0,slno=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
     workid = request.getParameter("workid");
	  wname = request.getParameter("wname");
	
	

try
{
	
	query ="select distinct pr.panch_code,pr.panch_name from RWS_WORK_ADMN_TBL w,RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_circle_office_tbl c where substr(w.office_code,2,2)=c.circle_office_code and w.work_id=ln.work_id and ln.hab_code=pr.panch_code and w.programme_code=p.programme_code  and  substr(w.office_code,2,2)='"+dCode+"'  and ln.work_id='"+workid+"' order by pr.panch_code ";
	
	
	
		
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 //st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

 rs = stmt.executeQuery(query);
 rs.setFetchSize(500);
 rs.last();
Count = rs.getRow();
// System.out.println("Total Records = "+Count);
rs.beforeFirst();%>

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="50%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_admn_status_form.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16>List Of Habitations</font></td>	
	</tr>
<% 
	
		
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=16><font color=blue size=1>WorkName:<%=wname%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" align=center>
		<td  class= "btext">S.No</td>
		<td class="btext" >HabitationCode</td>
		<td class="btext" >Habitation Name</td>
		</tr>
	
<%	
	if(Count!=0)
	{
while(rs.next())
	{
	%>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class="rptValue"><%=rs.getString(2)%></td>
	</tr>
		<% }
    
	}
else
	{%>
	 <tr bgcolor="#ffffff">
		<td class=rptValue><a href="./rws_admn_status_form.jsp">No Records</a></td>
		<% }
}
catch(Exception e)
{
	e.printStackTrace();
}
	finally
	{
	conn.close();
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> 
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
