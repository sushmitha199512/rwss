<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("loggedUser"+loggedUser);
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var user = '<%=loggedUser%>';
		
			if(document.f1.district.value=='-1')
			{
				//alert('aaaaaa');
				alert("Please Select District");
				return false;
			}
			else if(document.f1.mandal.value=='-1')
			{
				//alert('bbbbbb');
				alert("Please Select Program");
				return false;
			} 
			else if(document.f1.fromDate.value=='')
			{
				//alert('bbbbbb');
				alert("Please Select From Date");
				return false;
			} 
			else if(document.f1.toDate.value=='')
			{
				//alert('bbbbbb');
				alert("Please Select To Date");
				return false;
			} 
			
			else
			{
				
				
				var frmdate=document.getElementById("fromDate").value;
				var todate=document.getElementById("toDate").value;
				document.forms[0].fromDate.value=frmdate;
				document.forms[0].toDate.value=todate;
				//alert(document.forms[0].toDate.value);
			//	document.f1.fd.value=document.f1.fromDate.value;
				//document.f1.td.value=document.f1.toDate.value;
				//document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.forms[0].action="./rws_quality_control_min_circle_div_rpt.jsp?mode=circles&fromDate="+frmdate+"&toDate="+todate+""

					document.forms[0].submit();
			}	
		}
		
	/* var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	document.forms[0].fromDate.value=frmdate;
	document.forms[0].toDate.value=todate;
	document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=initial";
	document.forms[0].submit(); */
	
	

</script>

</head>
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

<body bgcolor="#edf2f8">

<%-- <form name=f1  action="<%= request.getRequestURI()%>" method="post">
 --%>
<form name=f1   method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Quality Control Report</td>	
	</tr>
	
<%
String rDist = null;
String rMand = null;
String fromdate="";
String todate=""; 

session.setAttribute("fromdate", fromdate);
session.setAttribute("todate", todate);
try
{
%>
<% rDist = request.getParameter("district");


	if(rDist == null || rDist.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("dCode", null);
				session.setAttribute("dName", rDist);
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("dCode",null);
				session.setAttribute("dName",null);

		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("dCode", rDist);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) order by  d.dname");
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						session.setAttribute("dName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();

%>
			</select>
		</td>
	</tr>

<%
	
	   rMand = request.getParameter("mandal");
		if(rDist == null || rDist.equals("-1")  || rMand == null)
		{	
			//System.out.println(rDist+"IN CONSTITUENCY STARTING..."+rMand);
%>

	<tr>
		<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mCode", null);
				session.setAttribute("mName", rMand);
		}
		
		else if(rDist.equals("00"))
		{
			%>
					<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
					stmt = conn.createStatement();
//System.out.println("()"+rDist);
//rDist="05";

	rs = stmt.executeQuery("select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_milestone_target_ach_tbl bill,rws_work_admn_prog_lnk_tbl pr where pr.work_id (+)=a.work_id and a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code   order by 2");

	//			query="select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_milestone_target_ach_tbl bill,rws_work_admn_prog_lnk_tbl pr where pr.work_id (+)=a.work_id and a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code and substr(a.work_id,5,2)='"+rDist+"'  order by 2";

					
					while(rs.next())
					{
						if(rMand != null && rMand.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mName",rs.getString(2));
						session.setAttribute("mCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mCode",rMand);
					rs.close();
					stmt.close();
					


%>
			
			
			
			<%
			
		}
		
		else
			if(rDist != null || !rDist.equals("-1") || !rDist.equals("00") || rMand != null)
			{
				//System.out.println("IN CONSTITUENCY ALL...");
%>			
		<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
					stmt = conn.createStatement();
	//rs = stmt.executeQuery("SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '"+rDist+"'  AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE order by M.Mname");
	rs = stmt.executeQuery("select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_milestone_target_ach_tbl bill,rws_work_admn_prog_lnk_tbl pr where pr.work_id (+)=a.work_id and a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code and substr(a.work_id,5,2)='"+rDist+"'  order by 2");

	

					while(rs.next())
					{
						if(rMand != null && rMand.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mName",rs.getString(2));
						session.setAttribute("mCode",rMand);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mCode",rMand);
					rs.close();
					stmt.close();
			}			


%>
			</select>
		</td>
	</tr>













<%-- 		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
     //  System.out.println("::::::dcode"+dcode);
			Statement stmt1 = conn.createStatement();
			if(rDist.equalsIgnoreCase("00"))
			{
				query="select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_milestone_target_ach_tbl bill,rws_work_admn_prog_lnk_tbl pr where pr.work_id (+)=a.work_id and a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code   order by 2";

			}else{
			query="select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_milestone_target_ach_tbl bill,rws_work_admn_prog_lnk_tbl pr where pr.work_id (+)=a.work_id and a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code and substr(a.work_id,5,2)='"+rDist+"'  order by 2";
			}
			
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				System.out.println(pCode+":yyyyyyyyyyyyyyyy");
				if(pCode != null && pCode.equals(rs1.getString(1)))
				{	
					System.out.println(pCode+":zzzzzzzzz");
%>
			<option value="<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
					session.setAttribute("pCode", rs1.getString(1));
					session.setAttribute("pName", rs1.getString(2));
					//System.out.println(">>>>>>>>>>>"+rs1.getString(1));
				}
				else
					{	
					System.out.println(pCode+":xxxxxxxxxxx");
%>
			<option value=<%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
					session.setAttribute("pCode", pCode);
					}
			}			
				rs1.close();			
				stmt1.close();

%>
</td></tr> --%>





<%-- <tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" <%if(request.getParameter("fromDate")!= null) {%>
		value='<%=request.getParameter("fromDate") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate")!= null) {%>
		value='<%=request.getParameter("toDate") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr> --%>
	
		<tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" 
		<%if(request.getParameter("fromDate")!= null) {
		
		session.setAttribute("fromdate", request.getParameter("fromDate"));
	      // session.setAttribute("todate", todate);
		%>
		value='<%=request.getParameter("fromDate") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
	
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate")!= null) {
			
			session.setAttribute("todate", request.getParameter("toDate"));
		%>
		value='<%=request.getParameter("toDate") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	
	
	


<%	
}catch(Exception e){}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
		</td>
	</tr>
<%
	//}
%>
</table>
<!-- <p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****: <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. You can enter the Bills for the Works which are having Mile Stones Information
</p> -->
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="mode">
<INPUT type="hidden" name="fd">
<INPUT type="hidden" name="td">
<!-- <INPUT type="hidden" name="divname"> -->
</form>
</body>
</html>