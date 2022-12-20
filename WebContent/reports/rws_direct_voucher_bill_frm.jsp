<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
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
		System.out.println("finyear##@#@#@"+finyear);
		if(finyear!=null)
	{
		session.setAttribute("finyear",finyear);
		
	}
		//System.out.println("dcode value::"+dcode);
		System.out.println("finyear value::"+finyear);
		String mode = request.getParameter("mode");	
		String query = null;
		int sno=1;
		String programe="",programename="",nextyr="";
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
		document.forms[0].action= "rws_direct_voucher_bill_rpt.jsp";
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

			<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Direct Voucher Bill Report </font></td>		
		</tr>
		<%
		try
{
	//String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
	//System.out.println("divcode:"+divcode);
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<%

 if(request.getParameter("district")!=null && request.getParameter("district").equals("All")){%>

<option value="All"  selected>All</option> 
<%}else{%>
<option value="All">All</option><%}






			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
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
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

		<tr>
		<%if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{%>
		<td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="">-Select-</option>
<%
			if(dcode!=null && !dcode.equals(""))
			{
				stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl d where circle_office_code='"+dcode+"' order by 3";
				rs.close();
				rs = stmt.executeQuery(query);
				
				while(rs.next())
				{
					if(rs.getString(3).equals(divcode))
					{
		%>
						 <option value="<%=rs.getString(3)%>" selected><%=rs.getString(4)%></option> 
		<%
					}
					else
					{
		%>
						 <option value="<%=rs.getString(3)%>"><%=rs.getString(4)%></option> 
		<%
					}
				}
			}
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
			%>
				</SELECT>
			<%
		}
		else
		{
						%>
			<td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
			<td>
			<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl where circle_office_code='"+dcode+"' and division_office_code='"+loggedUser.substring(3,4)+"'";
				//System.out.println("div qry:"+query);
				rs = stmt.executeQuery(query);
				
				
				
				if(rs.next())
				{
					divcode=rs.getString(3);
		%>
					<input type="text" name="divname" class="mytext" style="width:150px" value="<%=rs.getString(4)%>">
					<input type="hidden" name="division" value="<%=rs.getString(3)%>"></input>
		<%
				}
		}

%>
		</td></tr>
		
	
	
	<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"   size="1" class="hightlongcombo" >
			
			
<%
			rs.close();
			stmt.close();
			stmt = conn.createStatement();
			query="select distinct programme_code,programme_name from rws_work_direct_bill_tbl a,rws_programme_tbl where substr(work_id,1,2)=programme_code ";
			rs = stmt.executeQuery(query);
			System.out.println("query######"+query);
			while(rs.next())
			{
			    if(programe!=null && programe.equals(rs.getString(2)))
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