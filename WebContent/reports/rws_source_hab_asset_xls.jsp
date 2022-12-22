<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %> 
<%@ include file="conn.jsp" %>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%
String dcode=(String)session.getAttribute("dcode");
String mandal=(String)session.getAttribute("mandal");
String source=(String)session.getAttribute("source");
String dname=(String)session.getAttribute("dname");
String mname=(String)session.getAttribute("mname");
String cname="";
if(source.equals("1"))
{
	cname="Sub Surface Source";
}
else if(source.equals("2"))
{
	cname="Surface Source";
}

String yr="";
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null;
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null;

%>
<html>
<body>
<form>
<p align=center>
<table>
	<tr class=btext align="center">
		<font color="navy">District: &nbsp;<%=dname%></font>&nbsp;&nbsp;<font color="navy">Mandal: &nbsp;<%=mname%></font>&nbsp;&nbsp;<font color="navy">Source Type: &nbsp;<%=cname%></font>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Source - Asset Coverage Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
               <td class=btext >Sl.No</td>
               <td class=btext >Panchayat</td>
               <td class=btext >Village</td>
               <td class=btext >Habitation</td>
             
               <td class=btext  >SourceName</td>
			     <td class=btext  >AssetCode</td>
				  <td class=btext  >Asset Name</td>
				   <td class=btext  >Location</td>
				    <td class=btext  >Date of Creation</td>
					 <td class=btext  >Asset Cost(In Lakhs.)</td>
					 <td class=btext  >Asset Status</td>
			   
               </tr>
<%int sno=1,sn=0;

try
{
	String qry="select c.pname,c.vname,c.panch_name,e.SUBSOURCE_TYPE_NAME,b.asset_code,b.asset_name,nvl(b.location,'-'),to_char(DATE_CREATION,'dd/mm/yyyy') ,ASSET_COST,decode(ASSET_STATUS,'1','Working','2','Defunct') ASSET_STATUS  from rws_source_tbl a,rws_asset_mast_tbl b,rws_complete_hab_view c ,rws_source_habitation_tbl d,rws_subsource_type_tbl e where substr(a.source_code,1,2)='"+dcode+"' and substr(a.source_code,6,2)='"+mandal+"' and a.source_type_code='"+source+"' and b.asset_code=a.asset_code and substr(a.source_code,1,16)=c.panch_code and b.hab_code=c.panch_code and a.source_code=d.source_code and a.source_type_code=e.source_type_code";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	System.out.println("Qry*******"+qry);
	while(rs.next())
	{
		
      sn++;
  		%>
		<tr>
		<td class="rptvalue"><%=sno++%></td>
		
		<td class="rptvalue"><%=rs.getString(1)%></td>
		<td class="rptvalue"><%=rs.getString(2)%></td>
		<td class="rptvalue"><%=rs.getString(3)%></td>
		<td class="rptvalue"><%=rs.getString(4)%></td>
		<td class="rptvalue"><%=rs.getString(5)%></td>
		<td class="rptvalue"><%=rs.getString(6)%></td>
		<td class="rptvalue"><%=rs.getString(7)%></td>
		<td class="rptvalue"><%=rs.getString(8)%></td>
		<td class="rptvalue"><%=rs.getString(9)%></td>
		<td class="rptvalue"><%=rs.getString(10)%></td>

		
		</tr>
		<%
	
	
		}
    if(sn==0)
	{
	%>
	<tr align="center">
	<td class="rptvalue" colspan="14" ><b>No Records</b></td>
	</tr>
	<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
</form>
</table>

<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

</html>

