<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname=(String)session.getAttribute("dname");
	String mname=(String)session.getAttribute("mname");
	String dcode=(String)session.getAttribute("dcode");
	String mcode=(String)session.getAttribute("mcode");
		int sno=1;
	String qry="";
	String h1="",h2="",h3="",h4="";
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	
	<tr  align="center">
	<td align="center" class="rptHeading" colspan="6" >Panchayat Information  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	<td class=btext>Sl.No</td>
	<!-- <td class=btext rowspan = 2>District</td>
	<td class=btext rowspan=2>Mandal</td>  -->
	<td class=btext  >Panchayat</td>
	<td class=btext >GPS Code</td>
	<td class=btext  nowrap>Latitude</td>
	<td class=btext nowrap>Longitude</td>
	<td class=btext  nowrap>Elevation</td>
	</tr>
	<%
try
{
	
	String gqry=" select distinct c.pname ,c.pcode    from rws_complete_hab_view c where   substr(c.panch_code,1,2)='"+dcode+"' and substr(c.panch_code,6,2)='"+mcode+"'  order by c.pname";
	Statement	stmt8=conn.createStatement();
   // System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	while (rs8.next())
	{
	    %>
	<tr>
	<td class="rptValue"><%=sno++%></td>
	<!-- td class="rptValue"><%=rs8.getString(1)%></td>
	<td class="rptValue"><%=rs8.getString(2)%></td>  -->
	<td class="rptValue"><%=rs8.getString(1)%></td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
    	<%}
}catch(Exception e)
		{
		System.out.println("error::"+e);
		}%>
	
</table>


  
