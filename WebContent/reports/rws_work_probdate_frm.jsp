<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	Statement stmt1=null;
	ResultSet rs1=null;
%>
<html>
<head>

<script language="JavaScript">
function fnSubmit()
{
	var loggedUser = '<%=loggedUser%>';
	if(document.f1.district.value=='')
	{
		alert("Please Select District");
		return false;
	}	
	if(document.f1.year.value=='')
	{
		alert("Please Select Year");
		return false;
	}
	else
	{
		if(loggedUser=="admin"||loggedUser=="100000")
		{
			document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
		}
		else
		{
			document.f1.dname.value = document.f1.district.value;
		}
		document.f1.action="rws_work_probdate_rpt.jsp";
		document.f1.submit();
	}
}
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Works Probable Date Details Report</td>	
	</tr>	
<%
try
{
	String dcode = request.getParameter("district");
	String fyear=request.getParameter("year");
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
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
	<tr><td class=rptLabel>AdminSanction Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			 stmt1 = conn.createStatement();
			
			query="select distinct to_char(admin_date,'dd/mm/yyyy'),admin_date  from rws_work_admn_tbl  where  admin_date is not null and substr(office_code,2,2)='"+dcode+"' ";
			//System.out.println("date of query:"+query);
		 rs1 = stmt1.executeQuery(query);
		ArrayList aa = new ArrayList();	
		String finalSancYear="";
		while(rs1.next())
		{
			String dates = rs1.getString(1);
			
			int da = Integer.parseInt(dates.substring(3,5));
			int ye = Integer.parseInt(dates.substring(6,10));
			if(da<=03)finalSancYear = ye-1+"-"+ye;
			else finalSancYear = ye+"-"+(ye+1);
			aa.add(finalSancYear);
		}
			HashSet h = new HashSet(aa);
        	ArrayList bb =new ArrayList(h);
			Collections.sort(bb,Collections.reverseOrder()); 
            for(int i = 0;i<bb.size();i++)
			{
				finalSancYear = (String)bb.get(i);
				if(fyear!=null &&  !fyear.equals("") && finalSancYear.equals(fyear))
				{
	 %>
				<option value="<%=finalSancYear%>" selected><%=finalSancYear%></option> 
			<%}else {%>
				<option value="<%=finalSancYear%>" ><%=finalSancYear%></option> 
	 		<%}
			}
			if(rs1!=null)rs1.close();
			if(stmt1!=null)stmt1.close();
		%>
</td></tr>

	<%	
}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">			
		</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
</form>
</body>
</html>