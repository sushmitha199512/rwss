<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="nic.watersoft.commons.*, java.util.*,javax.sql.*,javax.naming.*"%>
		
<%		Context ctx = new InitialContext();
      	DataSource dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/pred");
		RwsOffices rwsOffices = new RwsOffices(dataSource);%>


<script language="JavaScript">
	function fnSubmit()
	{	
	
		var i = document.f1.subdivisionoffice.selectedIndex;
		if (i != 0)
		{
		document.f1.subdivisionname.value=document.f1.subdivisionoffice.options[i].text;
		}
		if (document.f1.headoffice.value=="0")
			alert("Please Select Head Office...")
		else
		{
			document.f1.action="rws_offices_list_rpt.jsp";
			document.f1.submit();
		}
	}	
	function setHname()
	{
		var i = document.f1.head.selectedIndex;
		document.f1.hname.value=document.f1.head.options[i].text;
	}
	
</script>
<form name=f1 action="<%= request.getRequestURI()%>">
<%
	String rHead = null;
	String rCircle = null;
	String rDivision = null;
	String rSubdivision = null;
%>



<table width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
<tr>
	<td colspan=2 align=right><a href="../home.jsp">Back</a></td>
</tr>
</table>
<table bgcolor="#8A9FCD" bordercolor= "#000000" width="40%" border=1 rules="none" style="border-collapse:collapse" align=center>	
	<tr bgcolor="#8A9FCD">
		<td class=myfontclr colspan=2><B><font color="#FFFFFF">RWS Offices List</font></B></td>	
		<td align=right><IMG SRC="../images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
	</tr>
</table>
<table bgcolor="#ffffff" bordercolor= "#000000" width="40%" border=1 rules="rows" style="border-collapse:collapse" align = center>
	<tr>
		<td class = clrborder>Head Office :</td>
		<td class = bwborder>		
		<select name="headoffice" style="width:150px" class = "mycombo" onchange = "this.form.submit()">
		<option value="0">Please Select...</option>
<%
	rHead = request.getParameter("head");
	ArrayList head = rwsOffices.getHeads();
	String hHCode = null;
	String hHName = null;

	for(int i=0; i<head.size(); i++)
	{
		LabelValueBean rwsOffice = (LabelValueBean) head.get(i);
		hHCode = rwsOffice.getValue();
		hHName = rwsOffice.getLabel();

		if(rHead != null && rHead.equals(hHCode) )
		{
%>
		<option value="<%= hHCode %>" selected><%= hHName %>
<script language="JavaScript">
<!--
setHname();
//-->
</script>
<% 

		}// END OF IF
		else 
		{
%>
<option value="<%= hHCode %>" ><%= hHName %>
<%		
		} 
	}// END OF FOR
%>
		
<table bgcolor="#ffffff" bordercolor= "#000000" width="40%" border=1 rules=none style="border-collapse:collapse" align = center>
	<tr><td colspan=2 align=center>
	<input type=button onclick="fnSubmit()" value=Submit class = btext></font>
	</td></tr>
</table>

<%@ include file = "/reports/footer.jsp" %>
