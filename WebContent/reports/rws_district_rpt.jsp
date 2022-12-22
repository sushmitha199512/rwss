<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%
/*PreparedStatement ps1=null;
ResultSet rs1=null;
String sqlquery=null,sqlquery1=null,dcode=null,mcode=null,pcode=null,vcode=null,prcode=null,distcode=null,bvalue=null,cvalue=null,svalue=null,nvalue=null,dvalue=null,wvalue=null,value=null;
    int srlno=0,total=0,wtotal=0,ntotal=0,stotal=0,dtotal=0,ctotal=0,qaffected=0,tflouride=0,tbrakish=0,
    tiron=0;*/
 try
 {
	 String sqlquery=null; 
	 int srlno=0;
	/*sqlquery ="select d.dname,d.dcode,count(h.hp_code),count(h.quality_affected),count(h.flouride),count(h.brakish),count(h.iron) from rws_hp_subcomp_param_tbl h,rws_district_tbl d where substr(h.hp_code,1,2)=d.dcode group by d.dcode,d.dname";*/
	sqlquery ="SELECT DISTINCT d.Dname,d.Dcode,count(h.hp_code),SUM(Case When h.status='W' then 1 Else 0 End) as W, SUM(Case When h.status='N' then 1 Else 0 End) as N,SUM(Case When status='D' then 1 Else 0 End) as D,SUM(Case When h.status='S' then 1 Else 0 End) AS S,SUM(Case When h.status='C' then 1 Else 0 End) AS C,count(h.quality_affected),count(h.flouride),count(h.brakish),count(h.iron) from rws_hp_subcomp_param_tbl h,rws_district_tbl d where substr(h.hp_code,1,2)=d.dcode group by d.dcode,d.dname";


	ps=conn.prepareStatement(sqlquery);
	rs = ps.executeQuery();  

%>
   <html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=12>District-Borewell-Status-Report</td>	
		</tr>
		 <tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District Name</td>
			<td class=btext rowspan=2>No Of Borewells</td>
			<td class=btext colspan=5 align=center>Status</td>
			<td class=btext colspan=4 align=center>Quality</td>
		</tr>
				<tr align="center">
					<td class=btext>Working</td>
					<td class=btext>Not Working</td>
					<td class=btext>Dried</td>
					<td class=btext>Seasonal</td>
					<td class=btext>Condemned</td>
					<td class=btext>Quality<br>Affected</td>
					<td class=btext>Flouride</td>
					<td class=btext>Brakish</td>
					<td class=btext>Iron</td>
				</tr>
<% 
int Total=0,wTotal=0,cTotal=0,sTotal=0,dTotal=0,nTotal=0,qTotal=0,fTotal=0,bTotal=0,iTotal=0;
	while(rs.next())
	{
	%>
	<tr>
		<td class=rptValue><%=++srlno%></td>
        <td><a href="rws_mandal_rpt.jsp?dcode=<%=rs.getString(2)%>"><%=rs.getString(1)%></a></td>
	    <td><a href="rws_borewelldetails_rpt.jsp?dcode=<%=rs.getString(2)%>"><%=rs.getInt(3)%></a></td>
		<% Total+=rs.getInt(3);%>
        <td class=rptValue><%=rs.getInt(4)%></td>
		<% wTotal+=rs.getInt(4);%>
		<td class=rptValue><%=rs.getInt(5)%></td>
        <% nTotal+=rs.getInt(5); %>
		<td class=rptValue><%=rs.getInt(6)%></td>
		<% dTotal+=rs.getInt(6); %>
		<td class=rptValue><%=rs.getInt(7)%></td>
		<% sTotal+=rs.getInt(7); %>
		<td class=rptValue><%=rs.getInt(8)%></td>
		<% cTotal+=rs.getInt(8); %>
		<td class=rptValue><%=rs.getInt(9)%></td>
		<% qTotal+=rs.getInt(9); %>
		<td class=rptValue><%=rs.getInt(10)%></td>
		<% fTotal+=rs.getInt(10); %>
		<td class=rptValue><%=rs.getInt(11)%></td>
		<% bTotal+=rs.getInt(11); %>
		<td class=rptValue><%=rs.getInt(12)%></td>
		<% iTotal+=rs.getInt(12); %>
			</tr>
<%
			}//end of while
			rs.close();
			%>
		<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext><%=Total%></td>
		<td class=btext><%=wTotal%></td>
		<td class=btext><%=nTotal%></td>
		<td class=btext><%=dTotal%></td>
		<td class=btext><%=sTotal%></td>
		<td class=btext><%=cTotal%></td>
		<td class=btext><%=qTotal%></td>
		<td class=btext><%=fTotal%></td>
		<td class=btext><%=bTotal%></td>
		<td class=btext><%=iTotal%></td>
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
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
