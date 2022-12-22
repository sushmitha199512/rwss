<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname=(String)session.getAttribute("dname");
	String dcode=(String)session.getAttribute("dcode");
	int sno=1;
	String qry="";
	String h1="",h2="",h3="",h4="";
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<tr  align="center" colspan="6">
	<td align="center" class="rptHeading"  colspan="6">Mandal Information  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>
	 </td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="65%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr align=center>
	<td class=btext>Sl.No</td>
	<td class=btext  >Mandal</td>
	<td class=btext >GPS Code</td>
	<td class=btext  nowrap>Latitude</td>
	<td class=btext nowrap>Longitude</td>
	<td class=btext  nowrap>Elevation</td>
	</tr>
	<%
try
{
	String gqry="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
	Statement	stmt8=conn.createStatement();
    System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	while (rs8.next())
	{
	    %>
	<tr>
	<td class="rptValue"><%=sno++%></td>
	<td class="rptValue"><%=rs8.getString("mname")%></td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<%}
	}catch(Exception e)
	{System.out.println("error::"+e);
	}%>
	
</table>
  
