<%@ page import="java.util.*"%>

<script language="JavaScript">

	function fnSubmit()
	{

		document.f1.action="rws_asset_rpt.jsp";
		document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("Please SELECT Asset Type");
	}

</script>
<%@ include file = "header_rpt.jsp" %>
<form name=f1 action="rws_asset_rpt.jsp">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=40%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td  align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
			<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td algin="center" class="textborder" colspan="4"><font color="#FFFFFF">Assets Form</font></td>	
		</tr>
		<TR>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="01">PWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="02">MPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="03">CPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS</TD>
		</TR>
		<tr bgcolor="#8A9FCD">
			<td class="textborder" align=center nowrap colspan=4><font color="#FFFFFF">ASSET DETAILS</font></td>
		</tr>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="ASSET_NAME,Asset Name" disabled checked>
			</td>
			<td class="textborder" colspan="3">Asset Name</td>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch"  id="ck" value="PANCH_NAME,Habitation" disabled checked>
			</td>
			<td class="textborder" colspan="3">Habitation</td>
		</tr>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(LOCATION,'--'),Location">
			</td>
			<td class="textborder" colspan="3">Location</td>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(to_char(DATE_CREATION,'dd/mm/yyyy'),'--'),Date Of Creation">
			</td>
			<td class="textborder" colspan="3">Date Of Creation</td>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(ASSET_COST,'0'),Asset Cost (RS. in lakhs)">
			</td>
			<td class="textborder" colspan="3">Asset Cost</td>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(START_YEAR,'--'),Start Year">
			</td>
			<td class="textborder" colspan="3">Start Year</td>
		<tr>
			<td class="textborder">
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(END_YEAR,'--'),End Year">
			</td>
			<td class="textborder" colspan="3">End Year</td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="textborder">
				<A HREF="javascript:checkAll('ch','ck')">checkAll</A>
			</td>
			<td colspan="2" align="center" class="textborder">
				<A HREF="javascript:clearAll('ch','ck')">clearAll</A>
			</td>
		</tr>	
	
		<tr>
			<td colspan=4 align=center>
			<input type=button onclick="fnSubmit()" value=Submit class = btext></font>
			</td>
		</tr>
	</table>
</form>
<%@ include file = "footer.jsp" %>