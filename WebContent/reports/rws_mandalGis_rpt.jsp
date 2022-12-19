<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname=request.getParameter("dname1");
	session.setAttribute("dname",dname);
	String dcode=request.getParameter("district1");
	session.setAttribute("dcode",dcode);
	
		int sno=1;
	String qry="";
	String h1="",h2="",h3="",h4="";
	%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a><a href="./rws_mandalGis_xls.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" >Mandal Information  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>
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
    //System.out.println("gqrymmmmmmmmm:"+gqry);
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
		{
		System.out.println("error::"+e);
		}%>
	
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>
</p>

  
