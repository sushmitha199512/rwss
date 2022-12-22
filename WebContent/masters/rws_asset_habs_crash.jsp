<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">

function fnSave(){
	
	var length= document.getElementById("resultCount").value;
	//alert("length"+length);
	document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	document.forms[0].elements['sBtn'].disabled=true;
	
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{		
	if(document.forms[0].elements["habs["+k+"].checks"].checked)
	 {
		
		flag=true;
	
	
	
	var hab=document.forms[0].elements["habs["+k+"].habitation"].value;

	var assetcode=document.forms[0].elements["habs["+k+"].assetcode"].value;
	var safe = document.forms[0].elements["habs["+k+"].safelpcd"].value;
	
	
	}	//end if

	}//for loop
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
		 return;
	}else{
		
		document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=saveassethabs&hab="+hab;	
		
		document.forms[0].submit();

	}
	
}




function changeColor(o){
    o.style.backgroundColor=(o.style.backgroundColor=='e0ffff')?('e0ffff'):('transparent');
}
function validateCols(){
	//alert("loading...");
	
		
	
}


</script>




<%
Date systemdate= new java.util.Date(System.currentTimeMillis());
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
String transdate=null;
transdate=dateFormat.format(systemdate);
String sourceType=request.getParameter("sourceTypen");
//System.out.println("sourceType"+sourceType);
String assetcode=request.getParameter("assetcode");
System.out.println("assetcode LIST OF HABS"+assetcode);
%>

<body >


<html:form  action="HabiYield.do">

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Habitation Details" />
	<jsp:param name="TWidth" value="800" />	
</jsp:include>

	
		<table width="800"
		border=1 style="border-collapse: collapse;">
<tr >
	<td class="btext" align="center">S.No</td>

		<td class="btext" align="center">Asset Code</td> 
		<td class="btext" align="center">Habitation Code</td>
		<td class="btext" align="center">Habitation Name</td>
		<td class="btext" align="center">Population</td>
	<td class="btext" align="center">Supply(In LPD)</td>
	<td class="btext" align="center">Select</td>	
	</tr>
	
	
	<%
  int count=1;
	
	
%>

	
	<logic:iterate id="habs" name="habs"  indexId="index">
	
	
	     <tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		 <td class="rptValue"><%=count++%></td>
	     <td  class="rptValue" ><bean:write name="habs" property="assetcode"/></td>
	     <html:hidden name="habs" property="assetcode"  indexed="true" styleId="source" />
	      
	       <td  class="rptValue" ><bean:write name="habs" property="habitation"/></td>
	     <html:hidden name="habs" property="habitation"  indexed="true" />
	     <td  class="rptValue" ><bean:write name="habs" property="habName"/></td>
	     
	     <td  class="rptValue" ><bean:write name="habs" property="population"/></td>
	     
		<td><html:text name="habs" property="safelpcd"  indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>' maxlength="7" size="20" /></td>
		
		<td>			
		<html:checkbox name="habs" property="checks" indexed="true" onclick='<%="check(" + index + ")" %>' />
		</td>	
				
		
		
	</tr>
	
	</logic:iterate>
	<%if(count==1)
		{
		%><tr align="center"><td colspan="8" align="center" class="btext">No Records</td></tr>
		
		<%}
		else{%>
		<%-- <tr align="center"><td align="center" colspan="8"><input type=button value=Save id="sBtn" disabled="disabled" onclick="fnSave('<bean:write name="habs" property="habitation"/>')" class="btext"></td> --%>
		<tr align="center"><td align="center" colspan="8"><input type=button value=Save id="sBtn" onclick="fnSave('<bean:write name="habs" property="habitation"/>')" class="btext"></td>
		</tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	
	
	
	</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="800" />
</jsp:include>

<input type=hidden name=yields>
<input type=hidden name=repairdesc>
</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

