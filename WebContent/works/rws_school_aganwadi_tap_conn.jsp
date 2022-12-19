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
			 document.forms[0].action = "switch.do?prefix=/works&page=/WorkStatus.do?mode=saveSchoolTapsList";
		document.forms[0].submit();
	 
}


</script>
<%
String habCode=request.getParameter("habCode");
String mName=request.getParameter("mname");
String panchayat=request.getParameter("pname");
String village=request.getParameter("vname");
String habName=request.getParameter("hname");
%>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Watersoft</title>
</head>
<body>
 <html:form  action="WorkStatus.do" > 
<table width="80%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>

</td></tr>
</table>
<table border = "1px;" bordercolor="#8A9FCD" cellspacing="0px;" cellpadding = "5px;" width="50%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center"   style="text-align: center;">
<p align="left"><b>
<font face=verdana size=2> Mandal:</font><font face=verdana size=2 color=blue> <%=mName%></font>&nbsp;&nbsp;
<font face=verdana size=2> Panchayat:</font><font face=verdana size=2 color=blue> <%=panchayat%></font>&nbsp;&nbsp;
<font face=verdana size=2> Village:</font> <font face=verdana size=2 color=blue><%=village%></font>&nbsp;&nbsp;
<font face=verdana size=2> Habitation:</font> <font face=verdana size=2 color=blue><%=habName%>(<%=habCode%>)</font></b></p>

</tr>
	<tr  align=center>
		<td class=gridhdbg rowspan=1>Sl.No</td>
		<td class=gridhdbg rowspan=1>Name(School/Aganwadi)</td>
		<td class=gridhdbg rowspan=1>Category Of School</td>
		<td class=gridhdbg rowspan=1>Classification Of School</td>
		<td class=gridhdbg rowspan=1>Please Check If Functional Tap Connection Has Been Provided</td>
		</tr>
		<% String s=""; 
		int slno = 0;%>
		
		<%--  <logic:notEmpty name="WorkForm" property="schoolTapDetailsList"> 
		<logic:iterate id="schoolTaps" name="WorkForm" property="schoolTapDetailsList" indexId="index">  --%>
		  <c:forEach items="${schoolTaps}" var="item" varStatus="status">  
		<tr>
		<td class="gridbg1"style="text-align: center;"><%=++slno%></td>
		
		<%-- <td class="gridbg1"style="text-align: center;"><html:text  name="schoolTaps" property="schoolDetails" indexed="true" /></td>
		<td class="gridbg1"style="text-align: center;"><html:text  name="schoolTaps" property="schoolCategory" indexed="true" /></td>
		<td class="gridbg1"style="text-align: center;"><html:text  name="schoolTaps" property="schoolClassification" indexed="true" /></td>
		<td><html:checkbox name="schoolTaps" property="isSchoolHavingTap" indexed="true" ></html:checkbox></td>
		 --%>
		  <td class="gridbg1"style="text-align: center;"><input type="text" name="schoolDetails<%=slno%>" value="<c:out value='${item.schoolDetails}'/>" readonly="true"></td>
		<td class="gridbg1"style="text-align: center;"><input type="text" name="schoolCategory<%=slno%>" value="<c:out value='${item.schoolCategory}'/>" readonly="true"></td>
		<td class="gridbg1"style="text-align: center;"><input type="text" name="schoolClassification<%=slno%>" value="<c:out value='${item.schoolClassification}'/>" readonly="true"></td>
		
		<c:set var="ab" value="${item.isSchoolHavingTap}" scope="request"/>
		<% s = (String)request.getAttribute("ab");
		if(s.equals("Yes")){%>
		<td>
		<input type=checkbox name="isSchoolHavingTap<%=slno%>"  checked></td>
		<%}else{ %>
		<td>
		<input type=checkbox name="isSchoolHavingTap<%=slno%>"  ></td>
		<%} %> 
		<input type="hidden" name="schoolCode<%=slno%>" value="<c:out value='${item.schoolCode}'/>"> 
		<input type="hidden" name="habCode<%=slno%>" value="<c:out value='${item.habCode}'/>"> 
		<input type="hidden" name="schoolCategoryCode<%=slno%>" value="<c:out value='${item.schoolCategoryCode}'/>"> 
		</tr>
		<%-- </logic:iterate>
</logic:notEmpty>  --%>
		  </c:forEach>  
		 <input type="hidden" name="resultCount" value="<%=slno%>"> 
		 <html:hidden  property="workId"  />
		 <html:hidden  property="workName"  />
		 
	<%-- 	 <input type="hidden" name="resultCount" value="<%=slno%>">   --%>
		
	
	</table>
	<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			
		  <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="fnSave()" />
</html:form>
		
</body>
</html>