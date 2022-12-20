<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<% DecimalFormat ndf = new DecimalFormat("####.00");
double obtot=0.0,ttot=0.0,ttot1=0.0,vtot=0.0,ttot2=0.0;
double stot=0.0,ctot=0.0,mtott=0.0,gmtott=0.0;
     nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
	String dname = request.getParameter("dname");
	if(dname!=null)
	{
		session.setAttribute("dname",dname);
	}
		//String program = request.getParameter("program");
		String finyear = request.getParameter("finyear");
		if(finyear!=null)
	{
		session.setAttribute("finyear",finyear);
	}
		//System.out.println("dcode value::"+dcode);
		//System.out.println("finyear value::"+finyear);
		String mode = request.getParameter("mode");	
		String query = null;
		int sno=1;
		String programe="",nextyr="";
		String[] program=request.getParameterValues("program");
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
//System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
//System.out.println("programe::"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}
}
%>
<script>
function fnView()
{
	//alert(document.forms[0].finyear.value);
	//alert("in fun");
	      if(document.forms[0].district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			else if(document.forms[0].finyear.value=="0" )
			{
				alert("Please Select Financial Year");
				return false;
			}
			else
	{
		document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_Exp_Rel_Pro_rpt.jsp";
		document.forms[0].submit();
}
}
</script>
<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
 <form> 
<BR>


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>

					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Programmewise Financial Achievement Report </font></td>		
		</tr>
		
		
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
           <option value="">-Select-</option> 
		  <% if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>
			<option value="All" selected>All</option>
			<%}else{%>
			<option value="All">All</option><%}
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
				%></select>
				 
			<%
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
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
	<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>
		<%
		//System.out.println("finyear:::::::"+finyear);
		if(finyear!=null && finyear.equals("2011-2012")){%>
			<option value='2011-2012' selected>2011-2012</option>
		<%}else{%>
			<option value='2011-2012'>2011-2012</option>
		<%}%>

		<%if(finyear!=null  && finyear.equals("2010-2011")){%>
			<option value='2010-2011' selected>2010-2011</option>
		<%}else{%>
			<option value='2010-2011'>2010-2011</option>
		<%}%>
		<%if(finyear!=null  && finyear.equals("2009-2010")){%>
			<option value='2009-2010' selected>2009-2010</option>
		<%}else{%>
			<option value='2009-2010'>2009-2010</option>
		<%}%>
		</SELECT>
		</td>
		<tr align="center">
			<td colspan=2 align=center>
				<input type=button value="View Report" class = btext onclick="fnView()">
		</td>
		</tr>
		</table>
		
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>