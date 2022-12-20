<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="javascript">
var newWindow;
function openEditWindow(workid,sno)
{
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/works/eoatFrm.do?mode=eoatEdit&orderno="+sno;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
	  
}

function fnDelete(workId,orderno)
{

	 var width = 50;
	 var height = 50;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	  var url = "/pred/works/eoatFrm.do?mode=delete&workId="+workId+"&orderno="+orderno;
	  var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
    
     
}


</script>
<html:form action="/eoatFrm.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td ><B><font color="#FFFFFF">EOAT List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<!-- table column headings -->
<tr  class="clrborder" align=center>
<td  class="clrborder" align=left>SNO</td>
<td>Eoat order No</td>
<td>Work Id</td>
<td>Work Name</td>
<td>Work Category</td>
<td>Programme</td>
<td>Value Of WorkDone</td>
<td>Cost Of Work</td>
<td>Stipulated Date Of Completion</td>
<td>EOAT Date</td>
<td>cost Esclation Sought</td>
<td>EOAT Period</td>
<td>Officer Responsible1</td>
<td>Prepared By</td>
<td>Prepared Date</td>
<td>Action</td>
</tr>

<% int count=0;%>
<logic:iterate id="eoat" name="eoatList">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class="bwborder" align=left><bean:write name="eoat" property="eoatOrderNo" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="workId" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="workName" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="sno" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="programmeName" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="valueOfWorkDone" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="costOfWork" /></td>
<!--<td  class="bwborder" align=left><bean:write name="eoat" property="valueOfWorkBeyondAgreement" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="valueOfWorkToBeDone" /></td>-->
<td  class="bwborder" align=left><bean:write name="eoat" property="dateOfCompletion" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatDate" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="costEsclationSought" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatPeriod" /></td>
<!--<td  class="bwborder" align=left><bean:write name="eoat" property="eoatOldRefNo1" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatOldRefDate1" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatOldRefNo2" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatOldRefDate2" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="fineImposed" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="fineRecovered" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="reasonsForNotRecoveringFine" /></td>-->
<td  class="bwborder" align=left><bean:write name="eoat" property="officerResponsible1" /></td>
<!--<td  class="bwborder" align=left><bean:write name="eoat" property="officerResponsible2" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="officerResponsible3" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="exemptRecommendedBySE" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="totalDaysExemptBySe" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="rateOfPenalty" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="totalPenalty" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="reasonsByContractor" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="contractorRepMadeUpd" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="agreementCopyPenaltyUpd" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="suppDocumentForExempUpd" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="aeeRecommend" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="deeRecommend" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eeRecommend" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="seRecommend" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="ceRecommend" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="eoatGrantAuthority" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="suppAgreeNo" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="suppAgreeDt" /></td>-->
<td  class="bwborder" align=left><bean:write name="eoat" property="preparedBy" /></td>
<td  class="bwborder" align=left><bean:write name="eoat" property="preparedDate" /></td>

<td  class="bwborder" nowrap align="center">
 <a href="#1" onclick="openEditWindow('<bean:write name='eoat' property='workId' />','<bean:write name='eoat' property='eoatOrderNo' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>|&nbsp;
 <a href="#1" onclick="fnDelete('<bean:write name='eoat' property='workId' />','<bean:write name='eoat' property='eoatOrderNo' />');toggleColor(this) " style="color:blue">Delete&nbsp;</a>&nbsp;
</td>
</tr>
</logic:iterate>
<%if(count==0){ %>
<tr class="bwborder" ><td colspan="25" align="center">NO Records</td></tr>
<%} %>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

