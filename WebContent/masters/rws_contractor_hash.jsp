<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
<LINK rel=stylesheet type=text/css href="/pred/resources/style/tablecss.css">
<style type="text/css"> 
<!--
.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
-->
</style>

<style type="text/css">
  .checkboxWrapper {
    position: relative;
  }
  .checkboxOverlay {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
  }
</style>
<script>

function getTokenCertValue()
{
	
	//alert(document.forms[0].elements["circleOffice"].value);
	if(document.forms[0].elements["circleOffice"].value==""){
		alert("You have not yet registered........");
		return;
	}
	
	document.getElementById('content').style.display='block';
		
var signdatabase64 = document.SmartCardReaderApplet.readCertificate();
		//var certificate =signdatabase64.trim();
		//alert(signdatabase64);
		if(signdatabase64.length>100){
			
			document.forms[0].elements["certificate"].value=signdatabase64;
		document.getElementById('content').style.display='none';
			document.forms[0].action="switch.do?prefix=/masters&page=/eeDSRegForm.do&mode=processCertificate";
		document.forms[0].submit();
		}else{
			document.getElementById('content').style.display='none';
			alert("Token Not Inserted or Reading Failed");
		}
		
	
}


function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}



</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
</head>
<input type="hidden" id="cids"></input>
<html:form action="/contractorHash.do">
<body >

<div id="content" style="display:none" ><img src="images/processing.gif" alt="Loading Wait..." title="Loading Wait..."></div>
<html:hidden property="certificate"></html:hidden>
<table     id="rounded-corner">
<thead>
<tr >
	<th  scope="col" class="rounded-company"  align="center" >S.No.</th>
	<th class="rounded-foot-left"  >WorkId/WorkName</th>
	<th class="rounded-foot-left"  >Contractor Code</th>
	<th class="rounded-foot-left"  >Contractor Name</th>	  
	
	<th class="rounded-foot-left" >Bank Name</th>
	<th class="rounded-foot-left"  >IFSC Code</th>
	<th class="rounded-foot-left" >Account Number</th>
		<th   scope="col" class="rounded-q4" >Approve</th>
		
	</tr>
	</thead>
	
	 <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em><font color="red"><b>Note:</b></font>.</em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
 <tbody>
	<nested:iterate id="cList" name="contractorHash" property="cList"  indexId="ndx">
	<logic:equal property="recordCorrupted"  name="cList" value="yes">
	<tr align="left" id='tr<%=count%>' bgcolor="red"   >
	</logic:equal>
	<logic:equal property="recordCorrupted"  name="cList" value="no">
	<tr align="left" id='tr<%=count%>' bgcolor="red"   >
	</logic:equal>
		<td class="rounded-error"><%=count++%></td>
		<td ><b><bean:write name="cList" property="workId" /></b><br></br><bean:write name="cList" property="workName" /></td>
		<td ><bean:write name="cList" property="contractorCode" /></td>
		<td ><bean:write name="cList" property="contractorName" /></td>
		<nested:hidden name="cList" property="contractorCode"  indexed="true"/>
		<td ><bean:write name="cList" property="bankName" /></td>
		<td ><bean:write name="cList" property="ifscCode" /></td>
		<td ><bean:write name="cList" property="accountNo" /></td>
		
		<td ><bean:write name="cList" property="approvedOn" /> <html:checkbox name="cList" property="checks"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
		</td>
	</tr>
	
</nested:iterate>
<%if(count==1)
{
%><tr><td colspan="13" align="center"class="rounded-foot-left">No Records</td></tr><%}
else{%><tr><td colspan="14" align="center"><input type=button value=Save onClick="fnSave();"class="rounded-foot-left"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">
</tbody>
</table>
</body>

<script>
function fnSave(){
var selectedContractors='';
    var len=<%= count %>
	len = len-1;
	//alert(len);
    var yes=0;    
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("cList["+i+"].checks").checked==true)
			 {
				selectedContractors=selectedContractors+","+document.getElementById("cList["+i+"].contractorCode").value;
		     }
	}
	 // alert("selected Contractors's:"+selectedContractors);
	  if(selectedContractors=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	
		  if(confirm("Are You Sure To Authendicate The Selected Contractors for Payment")) {
			 // document.forms[0].resultCount.value = selectedContractors;
              document.forms[0].action="switch.do?prefix=/masters&page=/contractorHash.do&mode=save";
              document.forms[0].submit();
			}
	  }
}
</script>




<div >
<APPLET  code="nic.rws.verify.SmartCardReaderApplet.class"  NAME="SmartCardReaderApplet" archive="applet/SmartCardReaderApplet.jar" width=500 height=500 MAYSCRIPT>  
  </APPLET>  
  </div>

<input type=hidden name=eeids>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</html:form>

<br>


