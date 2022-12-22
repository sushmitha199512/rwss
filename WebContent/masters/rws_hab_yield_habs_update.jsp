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
	//alert(1);
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

	var source=document.forms[0].elements["habs["+k+"].sourceCode"].value;
	var safe = document.forms[0].elements["habs["+k+"].safelpcd"].value;
	
	//alert("safe"+safe);
	//alert("source"+source);
	//alert("hab"+hab);
	}	//end if

	}//for loop
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
		 return;
	}else{
		//alert(111);
		document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=saveHabs&hab="+hab;	
		alert("document.forms[0].action"+document.forms[0].action);
		document.forms[0].submit();

	}
	
}


function fnMandals()
{
	//alert(11);
	
	var source=document.getElementById("source").value;

	//alert("11 vc"+source);
	var url = "switch.do?prefix=/masters&page=/HabiYield.do&mode=pickmandals&source="+source;
	alert("url"+url);
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}




function fnMandals1()
{
	//alert(11);
	var url = "switch.do?prefix=/masters&page=/HabiYield.do&mode=pickmandals";
	
	//alert("url"+url);
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
	
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
String sourcecode=(String)session.getAttribute("sourcecode");
System.out.println("sourcecode in habyieldshabs"+sourcecode);
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

		<td class="btext" align="center">Source Code</td> 
		<td class="btext" align="center">Habitation Code</td>
		<td class="btext" align="center">Habitation Name</td>
		<td class="btext" align="center">Population</td>
	<td class="btext" align="center">Yield(In LPD)</td>
	
	<td class="btext" align="center">Select</td>	
	</tr>
	
	
	<%
  int count=1;
	
	
%>

	
	<logic:iterate id="habs" name="habs"  indexId="index">
	
	
 
	
	
	     <tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		 <td class="rptValue"><%=count++%></td>
	     <td  class="rptValue" ><bean:write name="habs" property="sourceCode"/></td>
	     <html:hidden name="habs" property="sourceCode"  indexed="true" styleId="source" />
	      
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
		else{%><tr align="center"><td align="center" colspan="8"><input type=button value=Save id="sBtn" onClick="fnSave('<bean:write name="habs" property="sourceCode" />')" class="btext"></td>
		</tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	
	
	<tr align="center">
	<td align="center" colspan="8"><html:button property="hBtn"  value="Add&nbsp;Habs" onclick="fnMandals1()" styleClass="btext"></html:button></td>
	</tr>
	
	
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

