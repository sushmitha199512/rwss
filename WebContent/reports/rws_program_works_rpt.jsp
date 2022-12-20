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
		programe=request.getParameter("program");
		System.out.println("My Program code"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}

%>
<script>
function fnView()
{
	//alert(document.forms[0].finyear.value);
	//alert(document.forms[0].district.value);
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

		//document.forms[0].dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		//alert(document.forms[0].dname.value);
		document.forms[0].mode.value = "report";
		document.forms[0].action= "rws_program_works_view_rpt.jsp";
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

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Sustainbilty Works-Releases Report </font></td>		
		</tr>
		
		
		<%
try{
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
	
	
	<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"   size="10" class="hightlongcombo" onclick=this.form.submit()>
			<option value="">-select-</option>
			
<%
			rs.close();
			stmt.close();
			stmt = conn.createStatement();
			query="select * from  rws_programme_tbl  order by 1";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
			    if(programe!=null && programe.equals(rs.getString(1)))
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
			</td></tr>
			
			<tr><td class=rptLabel>Sub Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="subprogram" id="combo"  style="width:150px"    class="hightlongcombo">
			<option value="">-select-</option>
			
<%




			stmt = conn.createStatement();
			String ss="select * from  rws_subprogramme_tbl  where programme_code='"+programe+"'";
			rs = stmt.executeQuery(ss);
			System.out.println("Sub Q:"+ss);
			while(rs.next())
			{
			
			%>
			  <option value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option> 
			<%
			
			}
			rs.close();			
			stmt.close();
			%></select>
			</td></tr>


	<tr><%@ include file="financialYear.jsp" %></tr>

		<tr align="center">
			<td colspan=2 align=center>
				<input type=button value="View Report" class = btext onclick="fnView()"></td></tr><tr>
		</tr>
		</table>
		
	<input type="hidden" name="mode">
		<input type="hidden" name="dname">
	</form>
	</body>
	<br>

<% }catch(Exception e){e.printStackTrace();} %>

	<%@ include file="/commons/rws_footer.jsp"%>
	</html>