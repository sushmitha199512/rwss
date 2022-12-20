<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Asset Image Capturing Data</title>
	<style type="text/css">
	 .gridhdbg{
	 	padding:5px 5px;
	 }
	</style>
	<script type="text/javascript">
		function fnSubmit1(){
			if(document.f1.finYear.value==''){
				alert("Please Select Financial Year.");
				return false;
			}else{
				document.f1.action="./rws_asset_image_capturing_rpt.jsp";
				document.f1.submit();
			}	
		}
	</script>	
</head>
<body>
	<form name="f1"  action="<%= request.getRequestURI()%>" method="post">
	<table border="0" cellspacing="0" cellpadding="0" width="30%" style="border-collapse:collapse" align="center">
		<thead>
			<tr align="right" bgcolor="#edf2f8">	
				<th colspan="5"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></th>
			</tr>  
			<tr bgcolor="#8A9FCD">
				<th align="center" class="gridhdbg rptHeading" colspan="5">Format F21 - Month Wise Progress Report of Approved Geotagged Photographs</th>
			</tr>
		</thead>
		<tbody align="center">
			<tr class="gridhdbg12">
				<td class="rptLabel">Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
				<td class="btext">
					<select name="finYear" id="combo" class="mycombo" style="width:150px">
						<option value="">-Select-</option>
					<%
						Date now = new Date(); 
						Calendar calendar = new GregorianCalendar();
						calendar.setTime(now);
						int year = calendar.get(Calendar.YEAR);
						String StaticDate = "31-03-"+Integer.toString(year);
						String CurrentDate= new SimpleDateFormat("dd-MM-yyyy").format(now);
						Date date1=new SimpleDateFormat("dd-MM-yyyy").parse(StaticDate);
						Date date2=new SimpleDateFormat("dd-MM-yyyy").parse(CurrentDate);
						//System.out.println(date1 +"   "+ date2);
						if(date1.compareTo(date2) > 0){
							year = year-1;
						}
					%>
						<option value="<%=year %>-<%=year+1 %>" ><%=year %>-<%=year+1 %></option> 
						<option value="<%=year-1 %>-<%=year %>" ><%=year-1 %>-<%=year %></option> 
						<option value="<%=year-2 %>-<%=year-1 %>" ><%=year-2 %>-<%=year-1 %></option> 
						<option value="<%=year-3 %>-<%=year-2 %>" ><%=year-3 %>-<%=year-2 %></option> 
						<option value="<%=year-4 %>-<%=year-3 %>" ><%=year-4 %>-<%=year-3 %></option> 
						<option value="<%=year-5 %>-<%=year-4 %>" ><%=year-5 %>-<%=year-4 %></option> 
						<option value="<%=year-6 %>-<%=year-5 %>" ><%=year-6 %>-<%=year-5 %></option> 
						<option value="<%=year-7 %>-<%=year-6 %>" ><%=year-7 %>-<%=year-6 %></option> 
						<option value="<%=year-8 %>-<%=year-7 %>" ><%=year-8 %>-<%=year-7 %></option> 
						<option value="<%=year-9 %>-<%=year-8 %>" ><%=year-9 %>-<%=year-8 %></option> 
						<option value="<%=year-10 %>-<%=year-9 %>" ><%=year-10 %>-<%=year-9 %></option> 
						<option value="<%=year-11 %>-<%=year-10 %>" ><%=year-11 %>-<%=year-10 %></option> 
						<option value="<%=year-12 %>-<%=year-11 %>" ><%=year-12 %>-<%=year-11 %></option> 
						<option value="<%=year-13 %>-<%=year-12 %>" ><%=year-13 %>-<%=year-12 %></option> 
						<option value="<%=year-14 %>-<%=year-13 %>" ><%=year-14 %>-<%=year-13 %></option> 
						<option value="<%=year-15 %>-<%=year-14 %>" ><%=year-15 %>-<%=year-14 %></option> 
						<option value="<%=year-16 %>-<%=year-15 %>" ><%=year-16 %>-<%=year-15 %></option> 
						<option value="<%=year-17 %>-<%=year-16 %>" ><%=year-17 %>-<%=year-16 %></option>
						<option value="<%=year-18 %>-<%=year-17 %>" ><%=year-18 %>-<%=year-17 %></option>
						<option value="<%=year-19 %>-<%=year-18 %>" ><%=year-19 %>-<%=year-18 %></option>
						<option value="<%=year-20 %>-<%=year-19 %>" ><%=year-20 %>-<%=year-19 %></option>
					</select>
				</td>
			</tr>			
		</tbody>
		<tfoot>
			<tr bgcolor="#8A9FCD" align="center">
				<td colspan="5"  align="center">
					<input type="button" id="vbutton" onclick="fnSubmit1()" class="btext" value="View Report">	
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
</body>
</html>