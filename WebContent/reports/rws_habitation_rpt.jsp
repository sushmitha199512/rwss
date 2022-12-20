<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<%@ include file="/commons/rws_header1.jsp"%>
    <%@ include file="/commons/rws_header2.jsp"%>
    <%@ include file="conn.jsp"%>
    <%
  try
 {
     String sqlquery=null,distcode=null,mcode=null,pcode=null,vcode=null;
	 int srlno=0;
	   distcode=request.getParameter("dcode");
	   mcode=request.getParameter("mcode");
	   pcode=request.getParameter("pcode");
	   vcode=request.getParameter("vcode");
	   
       sqlquery ="select distinct pr.panch_name,pr.panch_code,count(h.hp_code),SUM(Case When h.status='W' then 1 Else 0 End) as W, SUM(Case When h.status='N' then 1 Else 0 End) as N,SUM(Case When status='D' then 1 Else 0 End) as D,SUM(Case When h.status='S' then 1 Else 0 End) AS S,SUM(Case When h.status='C' then 1 Else 0 End) AS C,count(h.quality_affected),count(h.flouride),count(h.brakish),count(h.iron) from rws_hp_subcomp_param_tbl h,rws_panchayat_raj_tbl pr where substr(h.hp_code,1,2)=? and substr(h.hp_code,6,2)=? and substr(h.hp_code,13,2)=? and substr(h.hp_code,8,3)=? and pr.panch_code=substr(h.hp_code,1,16) group by pr.panch_code,pr.panch_name";
         
		ps=conn.prepareStatement(sqlquery);

         ps.setString(1, distcode);
         ps.setString(2, mcode);
		 ps.setString(3, pcode);
         ps.setString(4, vcode);
		
         rs = ps.executeQuery();  
  

%>
<html>
<head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
</head>
<BODY>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="javascript:window.history.back()">Back |
					<a href="../home.jsp">Home
					</td> 
				</tr>
			</table>
		</caption>
		<tr  bgcolor="#8A9FCD"  align="center">
			<td align="center" class="rptHeading" colspan=12>Habitation-Borewell-Status-Report</td>	
		</tr>
     <tr align="center" bgcolor="#ffffff">
		<td class=btext rowspan=2>Sno</td>
		<td class=btext rowspan=2>Habitation</td>
		<td class=btext rowspan=2>No Of<br>Borewells</td>
		<td class=btext colspan=5 align=center>Status</td>
		<td class=btext colspan=4 align=center>Quality</td>
	</tr>
	<tr align="center">
		<td class=btext>Working</td>
		<td class=btext>NotWorking</td>
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
		<td class=rptValue><%=rs.getString(1)+'-'%><%=rs.getString(2)%></td>
		<td><a href="rws_borewelldetails_rpt.jsp?prcode=<%=rs.getString(2)%>&vcode=<%=vcode%>&pcode=<%=pcode%>&mcode=<%=mcode%>&dcode=<%=distcode%>"><%=rs.getInt(3)%></a></td>

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
