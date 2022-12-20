<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function validateForm() {
     var radios = document.getElementsByName("rtype");
    var formValid = false;
    var i = 0;
    while (!formValid && i < radios.length) {
        if (radios[i].checked) formValid = true;
        i++;        
    }
    if (!formValid) alert("Must check some option!");
    return formValid;   
}
function fnSave(){
	 if (document.forms[0].indTapLocation.value == "") {
			alert("Please Enter Tap Conn Location");
			return false;
		}
	 else{
		 document.forms[0].action = "switch.do?prefix=/works&page=/WorkStatus.do?mode=saveIndTap";
		document.forms[0].submit();
	 }
}


</script>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Watersoft</title>
</head>
<body>
<%-- <html:javascript formName="contractorForm" /> --%>
<form method="post">
<%-- <html:form  action="switch.do?prefix=/works&page=/IndTap.do" method="post"> --%>
<table width="80%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>

</td></tr>
</table>
<table border = "1px;" bordercolor="#8A9FCD" cellspacing="0px;" cellpadding = "5px;" width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center"  bgcolor="#8A9FCD" style="text-align: center;"><td style="padding: 13px;"><b>Enter Details Of Individual Tap Connection (If Any)</b></td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center" >
		<td align="center" colspan=5 class=btext style="padding: 10px; ">
        <%-- <html:radio property="" value="" ></html:radio> --%> <input type="radio" value="1" name="indTapType"  checked >GP/Panchayat Building
        <input type="radio" value="2" name="indTapType" >Health Centre
        <input type="radio" value="3" name="indTapType" >Community Centre 
        <input type="radio" value="4" name="indTapType" >Other Govt. Office 
        <input type="radio" value="5" name="indTapType" ">Other 
			<!--  <input type="radio" name="reptype" id="con" value="con" onclick="checkFirstRadiobuttonSatus();"/>Only 
            <input type="radio" name="reptype" id="det" value="det" onclick="checkSecondRadiobuttonSatus();"/>All-->
		</td>
	</tr>
	<tr>
	<html:hidden property="habCode" styleClass="mytext" value='<%=request.getParameter("habCode") %>' />
	<html:hidden property="workId" styleClass="mytext" value='<%=request.getParameter("workId") %>' />
	<html:hidden property="workName" styleClass="mytext" value='<%=request.getParameter("scheme") %>' />
	
	<td style="font-size: 13px; text-align: center; margin-bottom: 5px;" align="left">Tap Connection Location  <html:text property="indTapLocation" style="width:60%; "  maxlength="50"  value="" /> </td>
	</tr>
	<tr>
	<td>
		<table width="100%">
		<tr>
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<td class="textborder" align=center>
		  <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="fnSave()" />
		</table>
	</td>
	</tr>
	</table>
		<%-- </html:form> --%>
		</form>
		
	
		<table width="45%" border=1 style="border-collapse:collapse; margin-top: 40px;"  ALIGN=CENTER>
		<tr  style="color: red; font-size: 13px;"> Already Entered Individual Tap Connections</tr>
		<tr  align=center>
		<td class=gridhdbg rowspan=1>Sl.No</td>
		<td class=gridhdbg rowspan=1>Location</td>
		<td class=gridhdbg rowspan=1>Category</td>
		</tr>
		
		<%
		int slno = 0;
		Statement stmt1=null;
		ResultSet rst=null;
		String qry = "select a.TAP_LOCATION,a.HAB_CODE,b.tap_conn_name from RWS_INDIVIDUAL_TAP_CONN a,RWS_INDIVIDUAL_TAP_CONN_MAST b where HAB_CODE='"+request.getParameter("habCode") +"' and a.TAP_CONN_CODE = b.TAP_CONN_CODE ";
		stmt1=conn.createStatement();
		rst = stmt1.executeQuery(qry); 
		while(rst.next())
		{
			%>
			<tr>
    	              <td class="gridbg1"style="text-align: center;"><%=++slno%></td>
    	              <td class="gridbg1"style="text-align: center;"><%= rst.getString(1) %></td>
    	              <td class="gridbg1"style="text-align: center;"><%=rst.getString(3)%></td>
    	              
    	              </tr>
    	              
    	              <% 
		}
		%>
		</table>
</body>
</html>