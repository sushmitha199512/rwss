<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{		
	      //alert("heellooooooooo");	
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.fromDate.value==''){
				alert("Please Select From Date");
				return false;
			}
			else if(document.f1.toDate.value==''){
				alert("Please Select To Date");
				return false;
			}
			else if(document.f1.toDate.value==''){
				alert("Please Select To Date");
				return false;
			}
			else if(document.f1.status.value==''){
				alert("Please Select Status");
				return false;
			}
			else
			{
					document.f1.action="./rws_Generic_Complaints_View_rpt.jsp";
					document.f1.submit();
				
			}	
	}
		</script>
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

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
		<td align="center" class="rptHeading" colspan=3>Generic Complaints Report </td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
	String dname="";
	String mcode="";
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("1000DR")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
			

		<%
			stmt = conn.createStatement();
		//	query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
		query="select distinct dcode,dname from rws_district_tbl a,RWS_GENERIC_COMPLAINTS_REG_TBL b where a.dcode=substr(b.HABITATION_CODE,1,2) order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
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
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		
			<SELECT name="mandal" id="combo" class="mycombo" style="width:150px" >
			<option value="ALL" selected="selected">All</option>

		<%
			stmt = conn.createStatement();
			query="SELECT distinct mcode,mname,dname  from rws_complete_hab_view where dcode='"+dcode+"' order by mname";
			System.out.println("query"+query);
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
					dname=rs.getString(3);
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				
				rs.close();			
				stmt.close();
				
	
		
	%></tr>
	<tr>
	<td class=rptLabel>From Date&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" />
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=rptLabel>To Date&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr><td class=rptLabel>Status&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		
			<SELECT name="status" id="combo" class="mycombo" style="width:150px" >
			
				<option value="" >---Select---</option> 
				<option value="Not Attended" >Not Attended</option> 
			
				<option value="Attended">Attended</option> 
				</SELECT>
			</tr>
	<INPUT type="hidden" name="dname" value=<%=dname %>>
<%
	
	
}
	catch(Exception e)
		{
 System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>




</form>
</body>
</html>