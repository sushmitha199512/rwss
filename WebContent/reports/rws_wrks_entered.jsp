<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	String query = null;
%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_works_frm.jsp">Back|</a>
				<a href="../home.jsp">Home|</a>
				
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">Works Report </font></td>
	</tr>
<tr><td valign=top>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
	
		
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Circle</td> 
		<td class="btext" rowspan=2>No Of Habs<br>Benefitted</td> 
		<td class="btext" rowspan=2>No Of Works</td> 
		<td align="center" class="btext" colspan=8>Asset Types</td> 
<tr>
		<td class="btext">Pws </td>
		<td class="btext">Mpws</td>
		<td class="btext">Cpws</td>
		<td class="btext">Handpumps</td>
		<td class="btext">Shallow<br>Handpumps</td>
		<td class="btext">Openwells</td>
		<td class="btext">Ponds</td>
		<td class="btext">Others</td>
		</tr>
		

<%
try{

query="SELECT DISTINCT d.circle_office_code,d.circle_office_name,SUM(Case When substr(HD.work_id,7,2)='01' then 1 Else 0 End) as PWS,SUM(Case When substr(HD.work_id,7,2)='02' then 1 Else 0 End) AS MPWS,SUM(Case When substr(HD.work_id,7,2)='03'  then 1 Else 0 End) AS CPWS,SUM(Case When substr(HD.work_id,7,2)='04'  then 1 Else 0 End) AS HP,SUM(Case When substr(HD.work_id,7,2)='05' then 1 Else 0 End) AS SHP,SUM(Case When substr(HD.work_id,7,2)='06' then 1 Else 0 End) AS OW,SUM(Case When substr(HD.work_id,7,2)='07' then 1 Else 0 End) AS PONDS,SUM(Case When substr(HD.work_id,7,2)='08' then 1 Else 0 End) AS OTH,count(hd.WORK_ID) from rws_circle_office_tbl d,rws_work_admn_tbl HD  where d.circle_office_code=substr(hd.work_id,5,2) and work_id is not null  and work_cancel_dt is null group by d.circle_office_code,d.circle_office_name"; 

 
  
   stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

	rs=stmt.executeQuery(query);	
	int fcTotal=0,ncTotal=0,nssTotal=0,pcTotal=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0,tot=0;
	 while(rs.next())
		{
		
		%>
		<td class=rptValue><%=++slno%></td>
		<td class="rptValue"><%=rs.getString(2)%></td>
		<% 
		String qury=null;
		   Statement st1=null;
		   ResultSet rs1=null;
		  
		qury="SELECT DISTINCT count(W.HAB_CODE) from rws_circle_office_tbl d, RWS_EST_NEW_HAB_LNK_TBL W ,rws_work_admn_tbl hd where d.circle_office_code=substr(w.hab_code,1,2) and W.work_id is not null and w.work_id=hd.work_id and substr(w.hab_code,1,2)='"+rs.getString(1)+"' and  work_cancel_dt is null and w.work_id in (select work_id from rws_work_completion_tbl)";
		 
		 st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
         rs1=st1.executeQuery(qury);
		 rs1.next();
		 tot=tot+rs1.getInt(1);
		 %>
		  <td class=btext align="right"><%=rs1.getInt(1)%></td>
           
          <td class=btext align="right"><%=rs.getInt(11)%></td>
		 	<% total+=rs.getInt(11);%>
		   <td class=rptValue align="right"><%=rs.getInt(3)%></td> 
			<% fcTotal+=rs.getInt(3);%>
			<td class=rptValue align="right"><%=rs.getInt(4)%></td>
			<% ncTotal+=rs.getInt(4);%>
            <td class=rptValue align="right"><%=rs.getInt(5)%></td>
			<% nssTotal+=rs.getInt(5); %>
			<td class=rptValue align="right"><%=rs.getInt(6)%></td>
			<% pcTotal+=rs.getInt(6); %>
			<td class=rptValue align="right"><%=rs.getInt(7)%></td>
			<% pc4Total+=rs.getInt(7); %>
			<td class=rptValue align="right"><%=rs.getInt(8)%></td>
			<% pc3Total+=rs.getInt(8);%>
            <td class=rptValue align="right"><%=rs.getInt(9)%></td>
			<% pc2Total+=rs.getInt(9); %>
			<td class=rptValue align="right"><%=rs.getInt(10)%></td>
			<% uiTotal+=rs.getInt(10); %>
			
			</tr>
<%          
		    if(rs1!=null)
			rs1.close();
			if(st1!=null)
			st1.close();
		   
			}
			if(rs!=null)
			rs.close();
			if(stmt!=null)
			stmt.close();
			

int grandtotal=0;
grandtotal=fcTotal+ncTotal+nssTotal+pcTotal+pc4Total+pc3Total+pc2Total+uiTotal;

%>
</tr>
  
	<tr>
		<td class=btext colspan=2 align="right">Grand Total</td>
		<td class=btext align="right"><font color="blue" align="right"><%=tot%></font></td>
		<td class=btext align="right"><font color="blue" align="right"><%=total%></font></td>
		<td class=btext align="right"><%=fcTotal%></td>
		<td class=btext align="right"><%=ncTotal%></td>
		<td class=btext align="right"><%=nssTotal%></td>
		<td class=btext align="right"><%=pcTotal%></td>
		<td class=btext align="right"><%=pc4Total%></td>
		<td class=btext align="right"><%=pc3Total%></td>
		<td class=btext align="right"><%=pc2Total%></td>
		<td class=btext align="right"><%=uiTotal%></td>
	</tr>
</table>
<%
	
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
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
