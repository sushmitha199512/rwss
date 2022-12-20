<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:4px 0;
 }
.container img {
    width:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}



.on {
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>

<%
Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">
function openEditWindow(url)
{
	alert(url);
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/drought&page=/DroughtReport.do?mode=get2";
	document.forms[0].submit();
    
     
}

function fnClick()
{
	if(document.forms[0].dist.value=="" || document.forms[0].dist.value==null)
	{
		alert("Select District");
		return false;
	}

	
	



else
	{
document.forms[0].action="switch.do?prefix=/drought&page=/DroughtReport.do&mode=getReport";
document.forms[0].submit();
}
}




function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');

 

}

function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

function toggleItem(id)
{   
	itm = getItem(id);
	if(id=="collapse_myTbody2")
	var im = "onea";
	else if(id=="collapse_myTbody3")
	var im = "onec";
	else
	var im = "oneb";
	if(!itm)
	return false;
	if(itm.style.display == 'none'){
	itm.style.display = '';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/collapse.gif";
	}
	}    
	else{
	itm.style.display = 'none';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/expand.gif";
	}
	}	      
	return false;
	}
function getData4()
{

document.getElementById('OptionsDiv111').style.display='block';
}


</script>

<body  onload="javascript:init();">
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/PowerTransport.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Drought Report by asset and work type" />
	<jsp:param name="TWidth" value="400" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="400" >
<tr>
<td>
   <fieldset>
   <legend></legend>
   <label>
   <table  border=0  width="400"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="dist" styleClass="mycombo" style="width:150px">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
        </logic:present >
		</html:select>
		</td>
		</tr>
		<tr>
	
	
		
		</table>
		</label>
	</fieldset>
	</td>
</tr>
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="View Report"  styleClass="btext" value="View Report"  onclick="fnClick();"/>
	<!--<html:button property="view" title="Click to see View  Habitations"  styleClass="btext" value="View"  onclick="fnView();"/>-->
	<!--<html:button property="save" title="Click to select Habitations"  styleClass="btext" value="Click" onclick="openEditWindow('switch.do?prefix=/drought&page=/PowerTransport.do?mode=cview')" />-->
	
    </td>
    </tr>


</table>

	   
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
Note 1:-Select District->Click submit button
</p>

<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>