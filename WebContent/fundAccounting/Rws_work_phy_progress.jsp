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

.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
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
			if(document.getElementById("milestones["+i+"].checks").checked==true)
			{
				if(document.getElementById("milestones["+i+"].stagePer").value==''){
					alert("Please Enter Percentage");
					document.getElementById("milestones["+i+"].stagePer").focus();
					return false;
				}
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
</script>
</head>


<body>

<html:form action="BANKBillAction.do" method="post" enctype="multipart/form-data">
<table width="100%">
<tr><%-- <td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<!-- <a href="#" onclick="viewExcel();">Excel&nbsp;</a> -->
<a href="#" onclick="viewExcel();">Excel&nbsp;</a>
</td> --%>
<td align=center><b><a href="#" onClick="window.close();">Close</a></b></td>
</tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Physical Progress Indicator" />
	<jsp:param name="TWidth" value="90%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="43%" border=1 style="border-collapse:collapse;" >
	
		<tr>
		<!-- <td class="bwborder" >
	
</td> -->

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="43%" border=1 style="border-collapse:collapse" >
<!-- <tr bgcolor="#8A9FCD"><td class="bwborder" colspan="3"><B><font color="#FFFFFF">Physical  </B></td>
<td align="center">
</td>
</tr> -->
<tr >
	<td class="clrborder" align="center" >S.No.</td>
	<td class="clrborder" align="center" >Milestone/Milestone Stage</td>
	<td class="clrborder" align="center" >Stage Percentage </td>
	<td class="clrborder" align="center" >Check</td>
	</tr>
	<%-- <html:hidden property="workId" /> --%>
	<logic:notEmpty name="RwsBankBillActionForm" property="milestones">
	<logic:iterate  id="milestones" name="RwsBankBillActionForm" property="milestones" indexId="ndx">
	<%count++; %> 
	<logic:equal value="major1" property="status" name="milestones">
	<tr align="left"  onclick="toggleRowColor(this)">
		
		<td  class="bwborder" colspan="4">&nbsp;&nbsp;<font size="2" color="green"><b><bean:write name="milestones" property="compName"/></b></font></td>
		
		<html:hidden property="checks" name="milestones" indexed="true"/>
	</tr>
	</logic:equal>
	<logic:equal value="major" property="status" name="milestones">
	<tr align="left"  onclick="toggleRowColor(this)">
		<td class="bwborder" align="right"><%=sno++%></td>
		<td  class="bwborder" colspan="3">&nbsp;&nbsp;<font size="1"><b><bean:write name="milestones" property="mileStoneName"/></b></font></td>
		
		<html:hidden property="checks" name="milestones" indexed="true"/>
	</tr>
	</logic:equal>
	<logic:equal value="minor" property="status" name="milestones">
	<tr align="left"  onclick="toggleRowColor(this)">
		<html:hidden property="compCode" name="milestones" indexed="true"/>
		<html:hidden property="mileStoneCode" name="milestones" indexed="true"/>
		<html:hidden property="mileStoneStageCode" name="milestones" indexed="true"/>
		<html:hidden property="sourceType" name="milestones" indexed="true"/>
		<html:hidden property="subSourceType" name="milestones" indexed="true"/>
		<td></td>
		<td  class="bwborder" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="1"><bean:write name="milestones" property="mileStoneStageName"/></font></td>
		<td  class="bwborder" align="center"><html:text property="stagePer" name="milestones" indexed="true" size="4"/></td>
		<td class="bwborder" align=center>
			<html:checkbox name="milestones" property="checks"  indexed="true"/>
		</td>
	</tr>
	</logic:equal>
	</logic:iterate>
	</logic:notEmpty>
<%if(count==1){ %><tr><td colspan="18" align="center" class="btext">No Records</td></tr><%}
else{%><!-- <tr><td colspan="18" align="center"><input type=button value=Save onClick="fnSave(this);" class="btext"></td></tr> --><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">

</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="90%"/>
</jsp:include>
</tr>
</table>
</html:form>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>