<%@ include file="/commons/rws_SpecialHeader.jsp" %>

<head>
<script language="javascript">
function fnSave() 
{
	
	if(checkTheBox())
{
		if(checkValCondition()){
			document.forms[0].action="/pred/works/WorkStatus.do?mode=saveHabFHTC&workId="+document.forms[0].workId.value;
			document.forms[0].submit();
			document.forms[0].save.disabled=true;
		}else return false;
		
		
		}
	else{
		 return false;
		}
}

function checkTheBox() 
{
	  
    var boxes=document.getElementsByName("remove");
   // var e = document.getElementById("vol");
   // var strUser = e.options[e.selectedIndex].value;
    
	var flag = 0;
	$.each(boxes, function(key, obj ) {
		
			if(boxes[key].checked){ 
				
				flag ++;
			} 	
	 });
	 if (flag == 0) {
	      alert ("Please check atleast one habitation...!");
	      return false;
	    }else{
			return true;
	    } 
	

  }
function checkValCondition() 
{
	  
    var boxes=document.getElementsByName("remove");
   // var e = document.getElementById("vol");
   // var strUser = e.options[e.selectedIndex].value;
    
	var flag = 0;
	$.each(boxes, function(key, obj ) {
		
			if(boxes[key].checked){ 
				//balHouseConn,pendingFHTC
				var balHC=document.forms[0].elements["SELECTED_HABS_LIST["+key+"].balHouseConn"].value;
				var pendingHC=document.forms[0].elements["SELECTED_HABS_LIST["+key+"].pendingFHTC"].value;
				if(balHC < pendingHC){
					flag ++;
				}
				//alert("inside check Val Condition :"+bslno);
				
				
				
			} 	
	 });
	
	 if (flag > 0) {
	      alert ("FHTC Provided should not be greater than the balance House Connections!");
	      return false;
	    }else{
			return true;
	    } 

  }

</script>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<html:form  action="WorkStatus.do?mode=saveHabFHTC" method="post"   >
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<%
int cyear = Calendar.getInstance().get(Calendar.YEAR);%>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
        <th rowspan="2"></th>
	<th rowspan="2"><bean:message key="app.habitationCode" /></th>
	<th rowspan="2"><bean:message key="app.habitationName" /></th>
	<th rowspan="2"><bean:message key="app.population" /></th>
	<th rowspan="2"><bean:message key="app.status" /></th>
	<th rowspan="1" >Total House Holds as on 01-04-<%=cyear %></th>
	<th rowspan="1">House Connections Provided as on 01-04-<%=cyear %></th>
	<th rowspan="1">Balance House Connections to be as on 01-04-<%=cyear %></th>
	<th rowspan="1">FHTC's Provided</th>
	
</tr>
</thead>
<tbody class="gridText">
	<%-- <c:forEach items="${requestScope.selectedHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
	
	   <td class="textborder" ><input type="checkbox" name="mycheck"    id="mycheckbox" ></td>
		<td align="center"><c:out value='${item.habCode}'/></td>
		<td><c:out value='${item.habName}'/></td>
		<td align="right"><c:out value='${item.population}'/></td>
		<td><c:out value='${item.status}'/></td>
		<td><c:out value='${item.houseHolds}'/></td>
		<td><c:out value='${item.houseCons}'/></td>
		<td><c:out value='${item.balHouseConn}'/></td>
		 <td><input type="text" name="pendingFHTC"   style="width:50px"   maxlength="100"  /></td> 
	</tr>
	</c:forEach>  --%>
	<logic:present name="selectedHabs">
		<nested:iterate id="SELECTED_HABS_LIST" name="selectedHabs" indexId="ndx">
		<bean:define id="billSlNo" scope="request">   
               <nested:write name="SELECTED_HABS_LIST" property="habCode"/>  
		 </bean:define> 
		 <tr>
		 <td onmouseover="Tip('<b>This Bill can be EDITED/DELETED</b>',TITLE,'')" onmouseout="UnTip()">
			<input type="checkbox" name="remove" value="<%= billSlNo%>"></td>
			<td ><nested:text name="SELECTED_HABS_LIST" property="habName" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="habCode" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="population" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="status" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="houseHolds" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="houseCons" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
			<td><nested:text name="SELECTED_HABS_LIST" property="balHouseConn" indexed="true"  style="width: 90px" styleClass="noborder-text-box"  readonly="true"  /></td>
		<td><nested:text name="SELECTED_HABS_LIST" property="pendingFHTC" indexed="true" maxlength="5" style="width: 90px" styleClass="noborder-text-box"   /></td>
		 </tr>
		 </nested:iterate>
		 </logic:present>
	
	
	
	
	
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of Selected Habitations:&nbsp;<c:out value="${index+1}" />
	</th>
	<input type=hidden name=workId value=<%=request.getParameter("workId")%>>
</tr>
</tfoot>
</table><br>
<center>
<html:button property="mode" styleClass="btext" onclick="return fnSave()">
		<bean:message key="button.save" />
	</html:button>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</html:form>
<%@ include file = "/commons/rws_alert.jsp" %>
<%
if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
	 if(message.contains("Saved Successfully")){
		 
	 
	 %>
	<script language=JavaScript>
	window.close();
	window.opener.location.href = window.opener.location.href; 
	if (window.opener && !window.opener.closed) {
		window.opener.location.reload();
	} 		
	</script>
	<%
 }
	 }
%>

</body>
</html>
