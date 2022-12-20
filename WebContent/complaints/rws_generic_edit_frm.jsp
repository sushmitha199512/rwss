<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=get2";
	document.forms[0].submit();
}
function fnSave()
{
      if(document.forms[0].repCode.value== "0" || document.forms[0].repCode.value==null)
     {
     alert("Select Complaint Given By");
     return false;
     }
     else if(document.forms[0].name.value == "" || document.forms[0].name.value==null)
     {
     alert("Enter Name");
     return false;
     }
     else if(document.forms[0].address.value == "" || document.forms[0].address.value==null)
     {
     alert("Enter Address");
     return false;
     }
	 else if(document.forms[0].phoneNo.value == "" || document.forms[0].phoneNo.value==null)
     {
     alert("Enter Phone No");
     return false;
     }
 
        else
{
    
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=edit";
	document.forms[0].action.submit;
}
}

function fnView()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=cview";
	document.forms[0].action.submit;
}

function getData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=view";
	document.forms[0].submit();
}

function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');
}

function hide()
{
	document.getElementById('text').style.display ="none";
}
function show()
{
	
	document.getElementById('text').style.display = "block";
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
</script>
<body  onload="">
<html:form action="Complaintsoutgeneric.do?mode=get">
<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Generic  Grievance Edit Entry " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" align="center">
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>

    <table  border=0  width="920"  align=center  style="margin-bottom:0;margin-top:0"> 
      <tr>
	  <td class="textborder" width="100">
	District<font color="#FF6666">*</font> </td><td><html:text property="districtName" maxlength="13"  size="13"  readonly="true" /></td>
	<td class="textborder" width="100">
	Mandal<font color="#FF6666">*</font> </td><td><html:text property="mandalName" maxlength="25"  size="25" readonly="true"  /></td>
	<html:hidden property="mandalCode" />
	<td class="textborder" width="100">
	Panchayat<font color="#FF6666">*</font> <td><html:text property="panchayatName" maxlength="25"  size="25"  readonly="true" /></td>
	<html:hidden property="panchayatCode" />
	</tr>
	<tr>
	  <td class="textborder" width="100">
	Habitation <font color="#FF6666">*</font></td><td><html:text property="habName" maxlength="40"  size="40" readonly="true"  /></td>
	<html:hidden property="habCode" />
	</tr>
  			</table>
	</label>
	</fieldset>
	   </td>
  </tr>
       <tr>
<td>
 <fieldset>
	<legend>Complaintssssss Details</legend>
	<label>
	<table  border=0  width="920"  align=center  style="margin-bottom:0;margin-top:0">

	<tr>
	<td class="textborder" >
	Complaint No:</td><td><html:text property="complntno"  styleClass="mytext"  readonly="true"  maxlength="14" size="14" style="width:100px"  />
	</td>
	
	<td class="textborder" >
	Complaint Date:</td><td><html:text property="complntdt"  styleClass="mytext" style="width:100px" readonly="true" />
	<a href="javascript:showCalendar(document.CompForm.complntdt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
	
	<td class="textborder" >
	 Problem Description </td><td><html:textarea property="complntdesc" rows="3" cols="15"  /></td>
</tr>
<tr>
		<td class="textborder">
					Complaint Given By  <span class="mandatory">*</span>
				</td>
				<td class="column2">
					
						<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="representatives">
							<html:options collection="representatives" name="labelValueBean" property="value" labelProperty="label" />
							</logic:present>
						</html:select>
				</td>

	

	
	
	

	
	<td class="textborder" >
	Name:<font color="#FF6666">*</font></td><td><html:text property="name"  styleClass="mytext" style="width:125px"  size="25" maxlength="25" onkeypress="return alpha(event)"  />
	</td>
</tr>

<tr>
	<td class="textborder" >
	Address:<font color="#FF6666">*</font></td><td><html:textarea property="address" rows="3" cols="12"   onkeypress="upperOnly()"  /></td>
	<td class="textborder" >
	Phone No </td><td><html:text property="phoneNo" maxlength="10"   onkeypress="numeralsOnly(event)"/></td>

	</tr>
   </table>
	</tr>
	</td>
	</fieldset>
	</legend>
	</label>

	</td>
	</tr>
<table border=0 align=center>
<tr >
	<td >
	<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Save" onclick="fnSave()"/>
	<!--<html:submit property="mode" title="View the Fields"  styleClass="btext" value="View" onclick="fnView()"/>-->
    </td>
	</tr>
</table>
	

	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
	
	</table>

</html:form>
</body>
</html:html>
	
	

<p align=center>
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


