<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%

int count = 1;
int sno = 1;
	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String ad=(String)session.getAttribute("userId");
%>
<head>
<style type="text/css"> 
<!--
.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
-->
</style>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.js"></script>
<script>
function fnSave(thisform){

	
var selectedMilestones='';

 var len=document.forms[0].resultCount.value;
	len = len-1;
    var yes=0; 
       
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("milestones["+i+"].checks").checked==true && document.getElementById("milestones["+i+"].status").value=='minor')
			{
				/*if(document.getElementById("milestones["+i+"].stagePer").value==''){
					alert("Please Enter Percentage");
					document.getElementById("milestones["+i+"].stagePer").focus();
					return false;
				}*/
				selectedMilestones=selectedMilestones+","+document.getElementById("milestones["+i+"].mileStoneCode").value;
				selectedMilestones=selectedMilestones+"@"+document.getElementById("milestones["+i+"].mileStoneStageCode").value;
				
			}
		   
	}

	  if(selectedMilestones=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	
		  if(confirm("Are You Sure To Save The Checked Work(s)")) {
	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=milestonesSave";
         document.forms[0].submit();
			}
	  }
}
function checkAll(ele) {
     var checkboxes = document.getElementsByTagName('input');
    if (ele.checked) {
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].type == 'checkbox') {
                checkboxes[i].checked = true;
            }
        }
    } else {
        for (var i = 0; i < checkboxes.length; i++) {
           
            if (checkboxes[i].type == 'checkbox') {
                checkboxes[i].checked = false;
            }
        }
    } 
}

function checkSubMilestones(milestonecode) {
	
	var n=document.forms[0].elements["milestones["+milestonecode+"].mileStoneCode"].value;
	var status=document.forms[0].elements["milestones["+milestonecode+"].checks"].checked;
	var len=document.forms[0].resultCount.value;
	len = len-1;
    var yes=0; 
       
	for( var i=1 ;i<len; i++)
	{   
		//alert(document.forms[0].elements["milestones["+i+"].mileStoneCode"].value);
		if(document.forms[0].elements["milestones["+i+"].mileStoneCode"].value==n){
			if(status==true){
				document.forms[0].elements["milestones["+i+"].checks"].checked=false;
			}
			else{ 
				document.forms[0].elements["milestones["+i+"].checks"].checked=true;
			}
			
		}
	}
}
</script>
</head>


<body>

<html:form action="aap1.do" method="post" enctype="multipart/form-data">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table width="100%">
<tr>
<td align=center><b><a href="#" onClick="window.close();">Close</a></b></td>
</tr>
</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp"> 
	<jsp:param name="TableName" value="Physical Progress Indicator" />
	<jsp:param name="TWidth" value="94%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="72%" border=1 style="border-collapse:collapse;" >
	
		<tr>
		

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="72%" border=1 style="border-collapse:collapse" >
<tr >
	<td class="clrborder" align="center" >S.No.</td>
	<td class="clrborder" align="center" >Milestone/Milestone Stage</td>
	<td class="clrborder" align="center" >Percentage </td>
	<td class="clrborder" align="center" >Check</td>
	<td class="clrborder" align="center" >Applicable/Not&nbsp;Applicable</td>
	</tr>
	<html:hidden property="workId" />
	<tr>
	<td class="bwborder" colspan="6">
	1. % of Scheme Completed ( Physically ) Up to Previous Month:<bean:write name="PSWorkProbabledtForm" property="previousMonthPer"/><%-- <html:text property="previousMonthPer" size="4" readonly="true" styleClass="noborder-text-box "/>--%> 
	</td>
	</tr>
	<tr>
	<td class="bwborder" colspan="6">
	2. % of Scheme Completed ( Physically ) Up to This Month: <bean:write name="PSWorkProbabledtForm" property="currentMonthPer"/><%-- <html:text property="currentMonthPer" size="4" readonly="true" styleClass="noborder-text-box"/> --%>
	</td>
	</tr>
	<logic:notEmpty name="PSWorkProbabledtForm" property="milestones">
	<logic:iterate  id="milestones" name="PSWorkProbabledtForm" property="milestones" indexId="ndx">
	<%count++; %> 
	<logic:equal value="major1" property="status" name="milestones">
	<html:hidden property="status" name="milestones" indexed="true"/>
	<tr align="left"  onclick="toggleRowColor(this)">
		<td  class="bwborder" colspan="5">&nbsp;&nbsp;<font size="2" color="green"><b><bean:write name="milestones" property="compName"/></b></font></td>
	</tr>
	<tr>
	<td  class="bwborder" align="right" colspan="5">&nbsp;Check&nbsp;ALL&nbsp;<html:checkbox property="checks" name="milestones" indexed="true" onclick="checkAll(this);" /></td>
	</tr>
	</logic:equal>
	<logic:equal value="major" property="status" name="milestones">
	<html:hidden property="status" name="milestones" indexed="true"/>
					<%
					  String checkFun = "checkSubMilestones("+count+");";
					%>
	<tr align="left"  onclick="toggleRowColor(this)">
		<td class="bwborder" align="right"><%=sno++%></td>
		<td  class="bwborder" >&nbsp;&nbsp;<font size="1"><b><bean:write name="milestones" property="mileStoneName"/></b></font></td>
		<td  class="bwborder" align="left"><font size="1"><b><bean:write name="milestones" property="milestonePercentage"/></b></font><html:hidden property="milestonePercentage" name="milestones"/></td>
		<td  class="bwborder" align="center" colspan="3" ><html:checkbox property="checks" name="milestones" indexed="true" onclick="<%=checkFun %>" /><html:hidden property="mileStoneCode" name="milestones" indexed="true"/></td>
	</tr>
	</logic:equal>
	<logic:equal value="minor" property="status" name="milestones">
	<tr align="left"  onclick="toggleRowColor(this)">
	<html:hidden property="status" name="milestones" indexed="true"/>
		<html:hidden property="compCode" name="milestones" indexed="true"/>
		<html:hidden property="mileStoneCode" name="milestones" indexed="true"/>
		<html:hidden property="mileStoneStageCode" name="milestones" indexed="true"/>
		<html:hidden property="sourceType" name="milestones" indexed="true"/>
		<html:hidden property="subSourceType" name="milestones" indexed="true"/>
		<td></td>
		<td class="bwborder" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="1"><bean:write name="milestones" property="mileStoneStageName"/></font></td>
		<td class="bwborder" align="center"><html:text property="milestoneStagePercentage" name="milestones" indexed="true" size="4" readonly="true" styleClass="noborder-text-box"/></td>
		<td class="bwborder" align=center>	<html:checkbox name="milestones" property="checks"  indexed="true"/></td>
		<td class="bwborder"><html:radio name="milestones" property="type" value="Y" indexed="true"/>Applicable&nbsp;&nbsp;<html:radio name="milestones" property="type" value="N" indexed="true"/>Not&nbsp;Applicable</td>
	</tr>
	</logic:equal>
	</logic:iterate>
	</logic:notEmpty>
<%if(count==1){ %><tr><td colspan="18" align="center" class="btext">No Records</td></tr><%}
else{%><tr><td colspan="18" align="center"><input type=button value=Save onClick="fnSave(this);" class="btext"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">

</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="94%"/>
</jsp:include>
</tr>
</table>
</html:form>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>