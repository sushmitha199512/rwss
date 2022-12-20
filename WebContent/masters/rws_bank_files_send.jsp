<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count = 0;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
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
</head>

<html:form action="/bankConfirm.do">
<body >
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;</a>

</td></tr>
<tr></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Pending Files List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD">
<td align="center">
</td>
</tr>
<tr >
	<td class="btext" align="center" >S.No.</td>
	<td class="btext" align="center" >File Number</td>
	<td class="btext" align="center" >Date</td>	  
	<td class="btext" align="center" >File Name</td>
	<td class="btext" align="center" >Select</td>
	
	</tr>
	
	
	<logic:iterate id="rFileStatusRecord" name="paymentConfirm" property="filesTobeSentList"  indexId="ndx">
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
		<td class="rptValue"><%=++count%></td>
		<td  class="rptValue" ><bean:write name="rFileStatusRecord" property="fileNumber" /></td>
		<td  class="rptValue" ><bean:write name="rFileStatusRecord" property="fileDate" /></td>
		<td  class="rptValue" > <a href=/pred/masters/download.jsp?filename=<bean:write name="rFileStatusRecord" property="fileName" />> <bean:write name="rFileStatusRecord" property="fileName" /></a>
		
		</td>
		<td  class="rptValue" align="center"><html:checkbox name="rFileStatusRecord" property="checks"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
		</td>
	</tr>
</logic:iterate>
<%if(count==0)
{
%><tr><td colspan="13" align="center" class="btext">No Records</td></tr><%}
else{%><tr><td colspan="14" align="center"><input type=button value="Send Files To Bank" name="btn"  onClick="fnSend();" class="btext"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">

</table>
</body>

<script>
function fnSend(){


	var flag=false;
    var len=<%=count %>
    //alert(len);
	//len = len-1;
    var yes=0;    
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("rFileStatusRecord["+i+"].checks").checked==true)
			 {
				flag=true;
		     }
	}
	
	  if(!flag)
	   {
		 alert("Select atleast one check box to save");
       }else{
      
		  if(confirm("Are You Sure To Send Files to Bank ?")) {
			  document.getElementById("btn").value="Processing Please Wait.....";
              document.forms[0].action="switch.do?prefix=/masters&page=/bankConfirm.do&mode=sftp";
              document.forms[0].submit();
	  }
       }
}
</script>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>





<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</html:form>

<br>


