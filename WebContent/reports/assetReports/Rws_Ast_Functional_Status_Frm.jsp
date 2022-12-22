<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
   String ccode="";
   String divcode=""; 
   if(!loggedUser.equals(Constants.ADMIN) && !loggedUser.equals(Constants.LAKH_USER) && !loggedUser.equals(Constants.MINISTER) && !loggedUser.equals(Constants.SEC_USER) && !loggedUser.substring(0,2).equals("ce")  && !loggedUser.equals(Constants.ENC)){
 
   ccode=loggedUser.substring(1,3);
    divcode=loggedUser.substring(3,4);
} 

 
%>
<html>
<head>  
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<script language="JavaScript">
function unview()
{
    var a=document.getElementById('combo').value;

	if(a=="-1")
	{
       document.getElementById('vbutton').disabled=true;
	}

}
	function fnSubmit()
	{
			 if(document.f1.finyear.value=='0' && (document.f1.fromDate.value=='' && document.f1.toDate.value==''))
			{
				alert("Please Select Financial Year (OR) From Date and To Date");
				return false;
			}
			 else if(document.f1.finyear.value!='0' && (document.f1.fromDate.value!='' && document.f1.toDate.value!=''))
				{
					alert("Please Select Only One Thing Either Financial Year (OR) From Date and To Date");
					return false;
				}		
			else
		{
			document.f1.action="./Rws_Ast_Functional_Status_Rpt.jsp";
			document.f1.submit();
		}		
	}


</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width="20%">
		<caption>              
			<table  border=0 rules=none style="border-collapse:collapse" width="200" align="right" >			
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Assets Functional Status</td>
	</tr>
<tr>
<td class=rptLabel>Financial Year</td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>
		<%
					try {
						Date sysdate = new Date();
						SimpleDateFormat format = new SimpleDateFormat("yyyy");
						SimpleDateFormat format1 = new SimpleDateFormat("M");
						String Year = format.format(sysdate);
						String month = format1.format(sysdate);
						
						int cy = 0, cy1 = 0;
						if (Integer.parseInt(month) >= 04) {
							cy = Integer.parseInt(Year);
							cy1 = cy + 1;
							while (cy >= 2011) {								
						%>
						<option value="<%=cy + "-" + cy1%>" ><%=cy + "-" + cy1%></option>
						<%
							cy = cy - 1;
							cy1 = cy + 1;
									}
							} else if (Integer.parseInt(month) < 4) {
								cy = Integer.parseInt(Year) - 1;
								cy1 = cy + 1;
								while (cy >= 2011) {										
						%>
						<option value="<%=cy + "-" + cy1%>" selected><%=cy + "-" + cy1%></option>
						<%
									cy = cy - 1;
									cy1 = cy + 1;
								}
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
				%>
		</SELECT></td>
</tr>
<tr>
	<td class=rptLabel>Month</td>
		<td class=btext>
		<SELECT name="month" id="combo1" class="mycombo" style="width:150px">
		<option value="">Select</option>
		<option value="JAN">JAN</option>
		<option value="FEB">FEB</option>
		<option value="MAR">MAR</option>
		<option value="APR">APR</option>
		<option value="MAY">MAY</option>
		<option value="JUN">JUN</option>
		<option value="JUL">JUL</option>
		<option value="AUG">AUG</option>
		<option value="SEP">SEP</option>
		<option value="OCT">OCT</option>
		<option value="NOV">NOV</option>
		<option value="DEC">DEC</option>
		</SELECT></td>
	</tr>
	<tr>
	<td class=rptLabel colspan="2" align="center">(OR)</td>
	
	</tr>
<tr>
	<td class=rptLabel>From Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" />
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=rptLabel>To Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>

<INPUT type="hidden" name="dcode" value='<%=ccode %>'>
<INPUT type="hidden" name="divCode" value='<%=divcode %>'>
</form>
</body>
</html>

