<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%

StringBuffer query=new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser %>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.fromDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			else if(document.f1.toDate.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			
					
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" ||loggedUser=="1000DR")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
				
				}
				//alert(document.f1.dname.value);
				document.f1.action="./rws_droughtcount_rpt.jsp";
				document.f1.submit();
			}	
		}
		</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Drought Habitations Abstract Report</td>	
	</tr>
	<%
	StringBuffer dcode = new StringBuffer();
try
{
	//String dcode = request.getParameter("district");

	dcode.append(request.getParameter("district"));
	
	
	
	if(loggedUser.toString().substring(0,3).equals("col")){
		
		//dcode=(String)session.getAttribute("district");  
			dcode=new StringBuffer(String.valueOf(session.getAttribute("district")));
	   }	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)||loggedUser.toString().equals("minrwss")||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="51">-ALL-</option>
		<%
			stmt = conn.createStatement();
		query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
			rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode.toString()))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			//// ////System.out.println("in selected dist:");
			stmt = conn.createStatement();
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
				//dcode=rs.getString(1);
				dcode.append(rs.getString(1));
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
			
				<tr align=center>
<td align="left" class=rptvalue>From Date:&nbsp;<font color="red">*</font></td>
<td  class=btext align="left"><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<td  align="left" class=rptvalue>To Date:&nbsp;<font color="red">*</font></td>
<td  class=btext align="left"><input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendarFuture(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
</tr>
	
<%

}
	catch(Exception e)
		{
// ////System.out.println("Exception in bill Report frm jsp:"+e);
        }
	finally
	{
		dcode=null;
		query=null;
		loggedUser=null;
	}
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
</form>
</body>
</html>