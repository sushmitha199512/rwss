<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>
function isSaveAttended()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Ifsc.do&mode=view";
document.forms[0].submit();
}
function isSaveAttended1()
{
//alert("save");
if(document.forms[0].circleOffice.value == null || document.forms[0].circleOffice.value=="")
{
alert("Select Circle");
return false;
}
else if(document.forms[0].divisionOffice.value == null || document.forms[0].divisionOffice.value=="")
{
alert("Select Division");
return false;
}
else if(document.forms[0].paoCode.value == null || document.forms[0].paoCode.value=="")
{
alert("Enter PAO Code");
return false;
}
else if(document.forms[0].eeName.value == null || document.forms[0].eeName.value=="")
{
alert("Enter EE Name");
return false;
}
else if(document.forms[0].dateofPresent.value == null || document.forms[0].dateofPresent.value=="")
{
alert("Select Date of Present");
return false;
}

 					





else
{
var a=document.forms[0].paoCode.value;
 if(a.length != 7)
     {    
	     alert("Employee Code must be 7 digits");
		 return false;
  	}

if(document.forms[0].dateofPresent.value != "" && document.forms[0].dateofReleaving.value != "")
{



var	dt1=getDateObject(document.forms[0].dateofPresent.value,"/");
                    
					var	dt2=getDateObject(document.forms[0].dateofReleaving.value,"/");
                    
						if(dt2 < dt1)
						{
							alert("Alert date of Relieving\n should be greater or equal to ("+document.forms[0].dateofPresent.value+")");
                            return false;
						}
                       }

document.forms[0].action="switch.do?prefix=/masters&page=/EE.do&mode=save";
document.forms[0].submit();
}
}
function getDateObject(dateString,dateSeperator)
{
		var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);			cMonth=dateString.substring(curPos+1,endPos);
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth,cDate);	
	return dtObject;
}
function getData2()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/EE.do&mode=data";
document.forms[0].submit();

}
function init()
{
}
function isSaveAttended3()
{
document.forms[0].action="switch.do?prefix=/masters&page=/EE.do&mode=view";
document.forms[0].submit();



}


</script>
<%@ include file="/commons/rws_header2.jsp" %>
<body  onload="javascript:init();">
<table align=center border=0>
<tr>
<td><a href="rws_general_admn_loginsuccess.jsp">Back</a></td>
</tr>
</table>

<html:form action="/EE.do">


<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Executive Engineer Entry Form" />
	<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	</td>
</tr>
</thead>
<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="280" >



<tr>
<td>
   <fieldset>
   <legend>OfficeDetails</legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100">Circle<font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="circleOffice" styleClass="mycombo" style="width:180px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="circles">
		<html:options collection="circles" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
		</td>
		<td class="textborder" width="100">
	Division<font color="#FF6666">*</font>
	<td class="textborder" width="180">
		    <html:select property="divisionOffice" styleClass="mycombo" style="width:180px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="divisions">
			<html:options collection="divisions" name="rwsLocationBean" property="value" labelProperty="label" />
            </logic:present >
			</html:select>
	</td>
	</tr>
<tr>
<td class="textborder">Employee&nbsp;Code<font color=red>*</font>
		</td>
		<td class="textborder" >

		<html:text property="paoCode"  onkeypress="return numeralsOnly(event)" maxlength="7" /></td>








<td class="textborder">Executive&nbsp;Engineer&nbsp;Name<font color=red>*</font>
		</td>
		<td class="textborder" >
		<html:text property="eeName"  maxlength="50"  onkeypress="return alpha(event)"   /></td>
</tr>
<tr>
<td ><font face=verdana size=2><b>Date&nbsp;of&nbsp;Joining  </b></td>
		<td width="200"><html:text property="dateofPresent"   readonly="false"  />
		<a href="javascript: showCalendar(document.getElementById('dateofPresent'))">
         <img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
						
					</a></td>

 <td ><font face=verdana size=2><b>Date of Relieving  </b></td>
		<td width="200"><html:text property="dateofReleaving"   readonly="false"  value="<%=(String)request.getAttribute("dateofreleaving")%>" />
		<a href="javascript: showCalendar(document.getElementById('dateofReleaving'))"><img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
						
					</a></td>
</tr>


	
</table>



	<tr>
		<td class="textborder" align=center>
			 
		<html:button property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isSaveAttended1();" />
<html:button property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return isSaveAttended3();" />	

		
			


	</td>

         
	
	</tr>
	</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>

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



