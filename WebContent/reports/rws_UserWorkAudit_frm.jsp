<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html>
<head>

<script language="JavaScript">

function getWorksData()
{
	if(document.forms[0].fromDate.value=="")
	{
		alert("Please select From Date");
		return false;
	}
	else if(document.forms[0].toDate.value=="")
	{
		alert("Please select To Date");
		return false;
	}
	else
	{
		var toDateStr = document.forms[0].toDate.value;
		//var fromDateStr = "01"+toDateStr.substring(2,toDateStr.length);
		//alert("From Date: "+fromDateStr+",To Date: "+toDateStr);
		//document.forms[0].fromDate.value = fromDateStr;
		document.forms[0].modeGet.value = 'get';
		//alert("mode: "+document.forms[0].modeGet.value);
		document.forms[0].action='rws_UserWorkAudit_frm.jsp';
		document.forms[0].submit();
	}
}
function listWindow(URL)
{

var width = 1000;
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=no,status=yes,left=100,top=50";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',properties);
		myNewWin.focus();	
	}	
}
function userCheck(){
 var response = '';
 var path=  window.location.href;
 var arr  = path.split("pred/");
 $.ajax({ type: "POST",   
 url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
 async: false,
success : function(resp)
{         
alert(resp);
// window.location = '/../commons/UnAuthorize.jsp';
//document.location.href="/pred/commons/UnAuthorize.jsp";
	      }
	 });  	
}
</script>
</head> 
<body onload="userCheck();">

<form>

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Progress Report Accessed Logs" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>
<% 
//System.out.println("Started JSP page of"+request.getParameter("mode")+" datemode-->rws_UserAuditEntry_frm.jsp"); %>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="440" >
<tr>
<td>
	<table  border=0  width="400"  align=center  style="margin-bottom:5;margin-top:5">
	
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.from"/><bean:message key="app.date" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	 <input type="text" name="fromDate" style="width:90"/>
	 				<a href="javascript: showCalendarFuture(document.getElementById('fromDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td></tr>
	
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.to"/><bean:message key="app.date" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	
	<input type="hidden" name="modeGet">
	 <input type="text" name="toDate" style="width:90" />
					    			   <a href="javascript: showCalendarFuture(document.getElementById('toDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td></tr>	
</table>

<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return getWorksData()"/> 
	</td>
</tr>
</table> 

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400"/>
</jsp:include>

<br/>
<br/>
<br/>

<%
	//int i=1;
    //ArrayList labelcol2 = (ArrayList)request.getAttribute("workaudits");
	//int cnty=labelcol2.size();
	//System.out.println("sizeeeee is"+cnty);
%>
<%
String reqFromDate=null;
String reqToDate=null;
if(request.getParameter("modeGet")!=null)
{
	reqFromDate = request.getParameter("fromDate");
	reqToDate = request.getParameter("toDate");
}
else
{
	Calendar calNow = Calendar.getInstance();
	//DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	//System.out.println("^^^^^^^^^^^^^^^current Date check^^^^^^^^^"+dateFormat.format(calNow.getTime())+"^^^^^^^^^^^^^^^^^^^^^^^^");
	//System.out.println("^^^^^^^^^^^^^^^current month^^^^^^^^^"+calNow.get(Calendar.MONTH)+"^^^^^^^^^^^^^^^^^^^^^^^^");
	if(calNow.get(Calendar.DAY_OF_MONTH)<15)
	{
		calNow.add(Calendar.MONTH, -1);
		reqFromDate = "16/"+(calNow.get(Calendar.MONTH)+1)+"/"+calNow.get(Calendar.YEAR);//calNow.get(Calendar.YEAR),calNow.get(Calendar.MONTH)-1,16);
		int lastDay = calNow.getActualMaximum(Calendar.DAY_OF_MONTH);
		reqToDate = lastDay+"/"+(calNow.get(Calendar.MONTH)+1)+"/"+calNow.get(Calendar.YEAR);//calTo.set(calNow.get(Calendar.YEAR),calNow.get(Calendar.MONTH)-1,lastDay);
	}
	else
	{
		int currentMonth = calNow.get(Calendar.MONTH)+1;
		reqFromDate = "1/"+currentMonth+"/"+calNow.get(Calendar.YEAR);
		reqToDate = "15/"+currentMonth+"/"+calNow.get(Calendar.YEAR);
	}
	//System.out.println("^^^^^^^^^^^^^^^from to date check^^^^^^^^^"+reqFromDate+","+reqToDate+"^^^^^^^^^^^^^^^^^^^^^^^^");
}

//System.out.println("^^^^^^^^^^^^^after selection from to^^^^^^^^^^^"+reqFromDate+","+reqToDate+"^^^^^^^^^^^^^^^^^^^^^^^^");

	
	//if(modeValue.equals("get"))
	//{
		//String reqFromDate = request.getParameter("fromDate");
		//String reqToDate = request.getParameter("toDate");
	%>
	<table cellpadding="5px" bgcolor="#FFFFFF" id="viewTable" name="viewTable" bordercolor= "#8A9FCD"  width=800 border=1 style="border-collapse:collapse;" >
	<tr>
		<td colspan="5" class="gridhdbg" align="center">Progress Report Accessed Logs from <%=reqFromDate %> To <%=reqToDate %></td>
	</tr>
	<tr>
		<td class=gridhdbg align=center><b>District</b></td>
		<td class=gridhdbg align=center><b>Office</b></td>
		<td class=gridhdbg align=center><b>Office Level</b></td>
		<td class=gridhdbg align=center><b>No. of Users Accessed</b></td>
		<td class=gridhdbg align=center><b>No. of Works Updated</b></td>
	</tr>
	<%
		Connection conn2 = null;
		try
		{
			conn2 = RwsOffices.getConn();
			String headCode = "1";
		
			String query1 = "select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME from RWS_CIRCLE_OFFICE_TBL";
			Statement stmt1 = conn2.createStatement();
			ResultSet rs1 = stmt1.executeQuery(query1);
			while(rs1.next())
			{
				String circleCode = rs1.getString("CIRCLE_OFFICE_CODE");
				String circleName = rs1.getString("CIRCLE_OFFICE_NAME");
				String circleInputCode = headCode+""+circleCode+"000";
				%>
				<tr bgcolor="pink">
					<td style="font-size: 12px;padding-left: 15px;"><b><%=circleName %></b></td>
					
					<td style="font-size: 12px;padding-left: 15px;"><b><%=circleName %></b></td>
					<td style="font-size: 12px;padding-left: 15px;"><b>Circle Office</b></td>
				<%
					String query11 = "";
					String query14 = "";
					if(reqFromDate.equals(reqToDate))
					{
						query11 = "select count(distinct a.user_id) as users_count "
							+"from rws_log_tbl a,rws_password_tbl b "
							+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+circleInputCode+"'";
						query14 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
							+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+0+"' and ms.SUBDIVISION_OFFICE_CODE='"+00+"' "
							+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
					}
					else
					{
						query11 = "select count(distinct a.user_id) as users_count "
							+"from rws_log_tbl a,rws_password_tbl b "
							+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
							+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+circleInputCode+"'";
						query14 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
							+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
							+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+0+"' and ms.SUBDIVISION_OFFICE_CODE='"+00+"' "
							+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
					}
					Statement stmt11 = conn2.createStatement();
					ResultSet rs11 = stmt11.executeQuery(query11);
					while(rs11.next())
					{
						String users_count = "";
						if(rs11.getString("users_count").equals("0"))
						{
							users_count = " - ";
						}
						else
						{
							users_count = rs11.getString("users_count");
						}
						%>
							<td class=mycborder align=center>
								<FONT class=myfontclr><font color="#993366">
								<a href="#" onclick="listWindow('./rws_UserWorksAuditList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=circleInputCode%>&reqLevel=circle')"><%=users_count%></a>
								</font></FONT>
							</td>
						<%
					}
					rs11.close();
					stmt11.close();
					
					Statement stmt14 = conn2.createStatement();
					ResultSet rs14 = stmt14.executeQuery(query14);
					while(rs14.next())
					{
						String works_count = "";
						if(rs14.getString("works_count").equals("0"))
						{
							works_count = " - ";
						}
						else
						{
							works_count = rs14.getString("works_count");
						}
						%>
							<td class=mycborder align=center>
								<FONT class=myfontclr><font color="#993366">
								<a href="#" onclick="listWindow('./rws_UserWorksUpdateList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=circleInputCode%>&reqLevel=circle')"><%=works_count%></a>
								</font></FONT>
							</td>
						<%
					}
					rs14.close();
					stmt14.close();
					
					%>
					</tr>
					<%
				String query2 = "select DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME from RWS_DIVISION_OFFICE_TBL where CIRCLE_OFFICE_CODE='"+circleCode+"' and STATUS<>'UI'";
				Statement stmt2 = conn2.createStatement();
				ResultSet rs2 = stmt2.executeQuery(query2);
				while(rs2.next())
				{
					String divCode = rs2.getString("DIVISION_OFFICE_CODE");
					String divName = rs2.getString("DIVISION_OFFICE_NAME");
					String divInputCode = headCode+""+circleCode+""+divCode+"00";
					%>
					<tr bgcolor="aqua">
						<td/>
						<td style="font-size: 12px;padding-left: 15px;"><b><%=divName %></b></td>
						<td style="font-size: 12px;padding-left: 15px;"><b>Division Office</b></td>
						
						
					<%
					String query22 = "";
					String query24 = "";
					if(reqFromDate.equals(reqToDate))
					{
						query22 = "select count(distinct a.user_id) as users_count "
							+"from rws_log_tbl a,rws_password_tbl b "
							+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+divInputCode+"'";
						query24 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
							+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+divCode+"' and ms.SUBDIVISION_OFFICE_CODE='"+00+"' "
							+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
					}
					else
					{
						query22 = "select count(distinct a.user_id) as users_count "
							+"from rws_log_tbl a,rws_password_tbl b "
							+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
							+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+divInputCode+"'";
						query24 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
							+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
							+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
							+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+divCode+"' and ms.SUBDIVISION_OFFICE_CODE='"+00+"' "
							+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
					}
					Statement stmt22 = conn2.createStatement();
					ResultSet rs22 = stmt22.executeQuery(query22);
					while(rs22.next())
					{
						String users_count = "";
						if(rs22.getString("users_count").equals("0"))
						{
							users_count = " - ";
						}
						else
						{
							users_count = rs22.getString("users_count");
						}
						%>
							<td class=mycborder align=center>
								<FONT class=myfontclr><font color="#993366">
								<a href="#" onclick="listWindow('./rws_UserWorksAuditList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=divInputCode%>&reqLevel=div')"><%=users_count%></a>
								</font></FONT>
							</td>
						<%
					}
					rs22.close();
					stmt22.close();
					
					Statement stmt24 = conn2.createStatement();
					ResultSet rs24 = stmt24.executeQuery(query24);
					while(rs24.next())
					{
						String works_count = "";
						if(rs24.getString("works_count").equals("0"))
						{
							works_count = " - ";
						}
						else
						{
							works_count = rs24.getString("works_count");
						}
						%>
							<td class=mycborder align=center>
								<FONT class=myfontclr><font color="#993366">
								<a href="#" onclick="listWindow('./rws_UserWorksUpdateList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=divInputCode%>&reqLevel=div')"><%=works_count%></a>
								</font></FONT>
							</td>
						<%
					}
					rs24.close();
					stmt24.close();
					
					%>
					</tr>
					<%
					
					String query3 = "select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME from RWS_SUBDIVISION_OFFICE_TBL where DIVISION_OFFICE_CODE='"+divCode+"' and CIRCLE_OFFICE_CODE='"+circleCode+"'";
					Statement stmt3 = conn2.createStatement();
					ResultSet rs3 = stmt3.executeQuery(query3);
					while(rs3.next())
					{
						String subDivCode = rs3.getString("SUBDIVISION_OFFICE_CODE");
						String subDivName = rs3.getString("SUBDIVISION_OFFICE_NAME");
						String subDivInputCode = headCode+""+circleCode+""+divCode+""+subDivCode;
						%>
						<tr>
							<td/>
							<td style="font-size: 12px;padding-left: 15px;"><b><%=subDivName %></b></td>
							<td style="font-size: 12px;padding-left: 15px;"><b>SubDivision Office</b></td>
						<%
						
						String query33 = "";
						String query34 = "";
						if(reqFromDate.equals(reqToDate))
						{
							query33 = "select count(distinct a.user_id) as users_count "
								+"from rws_log_tbl a,rws_password_tbl b "
								+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')= to_date('"+reqFromDate+"','dd/mm/yyyy') "
								+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+subDivInputCode+"'";
								
							query34 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
								+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
								+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+divCode+"' and ms.SUBDIVISION_OFFICE_CODE='"+subDivCode+"' "
								+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
							
						}
						else
						{
							query33 = "select count(distinct a.user_id) as users_count "
								+"from rws_log_tbl a,rws_password_tbl b "
								+"where to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')>= to_date('"+reqFromDate+"','dd/mm/yyyy') "
								+"and to_date(to_char(a.access_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
								+"and page='/works/aap1.do' and a.user_id = b.user_id and b.office_code = '"+subDivInputCode+"'";
								
							query34 = "select count(distinct wi.work_id) as works_count from rws_work_image_tbl wi, rws_work_admn_tbl wa, rws_mandal_subdivision_tbl ms "
								+"where to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('"+reqFromDate+"','dd/mm/yyyy') "
								+"and to_date(to_char(wi.update_date,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('"+reqToDate+"','dd/mm/yyyy') "
								+"and wa.work_id=wi.work_id and ms.CIRCLE_OFFICE_CODE='"+circleCode+"' and ms.DIVISION_OFFICE_CODE='"+divCode+"' and ms.SUBDIVISION_OFFICE_CODE='"+subDivCode+"' "
								+"and SUBSTR(wa.LEAD_HABITATION,1,2)=ms.dcode and SUBSTR(wa.LEAD_HABITATION,6,2)=ms.mcode";
						}
						Statement stmt33 = conn2.createStatement();
						ResultSet rs33 = stmt33.executeQuery(query33);
						while(rs33.next())
						{
							String users_count = "";
							if(rs33.getString("users_count").equals("0"))
							{
								users_count = " - ";
							}
							else
							{
								users_count = rs33.getString("users_count");
							}
							%>
								<td class=mycborder align=center>
									<FONT class=myfontclr><font color="#993366">
									<a href="#" onclick="listWindow('./rws_UserWorksAuditList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=subDivInputCode%>&reqLevel=subdiv')"><%=users_count%></a>
									</font></FONT>
								</td>
							<%
						}
						rs33.close();
						stmt33.close();
						Statement stmt34 = conn2.createStatement();
						ResultSet rs34 = stmt34.executeQuery(query34);
						while(rs34.next())
						{
							String works_count = "";
							if(rs34.getString("works_count").equals("0"))
							{
								works_count = " - ";
							}
							else
							{
								works_count = rs34.getString("works_count");
							}
							%>
								<td class=mycborder align=center>
									<FONT class=myfontclr><font color="#993366">
									<a href="#" onclick="listWindow('./rws_UserWorksUpdateList.jsp?reqFromDate=<%=reqFromDate%>&reqToDate=<%=reqToDate%>&reqOfcCode=<%=subDivInputCode%>&reqLevel=subdiv')"><%=works_count%></a>
									</font></FONT>
								</td>
							<%
						}
						rs34.close();
						stmt34.close();
						%>
						
					</tr>
					<%
						
					}
					rs3.close();
					stmt3.close();
				}
				rs2.close();
				stmt2.close();
			}
			rs1.close();
			stmt1.close();
		%>
		
		</table>
		<%
		}
		catch(Exception e)
		{
			conn2.close();
		}
	//}
%>

</form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html> 
