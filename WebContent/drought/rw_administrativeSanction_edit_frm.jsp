<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%@page import="nic.watersoft.drought.DroughtWorksEditFrm" %>
<%@page import="nic.watersoft.drought.DroughtDAO" %>

<% request.getSession(true);%>



<style type="text/css">
<!--
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;


}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}
div#tbl-container22 {
width: 1000px;
height: 200px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
font-size: 11px;
height: 28px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;

font-size: 8px;.
height: 21px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table th {
height: 40px;


}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #DEE3E0;
color: black;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 10;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;

}
-->
</style>
<% int workCount = 0; int count=0,index=1;%>
<%
DroughtWorksEditFrm proposalHolder= new DroughtWorksEditFrm();
String aa = (String)session.getAttribute("leadvalue");
String myid = (String)session.getAttribute("proposalId");
session.setAttribute("leadvalue",aa);
String scheme= request.getParameter("typeOfAsset");
String pageid= request.getParameter("proposalId");
String[] habsarray=null;
if(session.getAttribute("habsarray")!=null)
{
habsarray=(String[])session.getAttribute("habsarray");
}
String noOfHabs = "0";
String HabName="",new_ext="";
String srcode="",subsrcode="",stname="",sttypename="",srname="",sscode="",ssloc="",assetCode="";
if(habsarray!=null)
{
noOfHabs = ""+habsarray.length;
HabName=habsarray[0].substring(0,16);
}
int lengthHab = Integer.parseInt(noOfHabs)+1;
String shcode=(String)session.getAttribute("sourceHabCode");
if(session.getAttribute("sourceType")!=null)
{
srcode=(String)session.getAttribute("sourceType");
}

if(session.getAttribute("subsourceType")!=null)
{
subsrcode =(String)session.getAttribute("subsourceType");
}


 if(session.getAttribute("newext") != null)
		 	{
				new_ext=(String)session.getAttribute("newext");
			}

String myhab="",myhab1="";

if(session.getAttribute("testproposals")!=null)
{
ArrayList myList=(ArrayList)session.getAttribute("testproposals");
int s=myList.size();

proposalHolder=(DroughtWorksEditFrm)myList.get(0);

myhab1=proposalHolder.getNoOfHabs();


}



%>
<%@ include file = "rws_drought_editworks_js.jsp" %>

<body onload="showFields();">
<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />
<html:form action="AdminstrativeSanctionSaveForm">
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in <IMG SRC="<rws:context page='/images/india-rupee-symbol.png'/>" width="20" border="0" height="20" align="absmiddle" /></b>&nbsp;&nbsp;<BR>
</caption> 
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Drought Works Edit Form" />
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
		   style="border-collapse:collapse">
<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table>
		<tbody class="formTBody">
		<tr>
		<td class="column1"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		<input type="hidden" name="count" value="1">
		<%
		String plan="";
		if(request.getParameter("plan") != null)
		{plan=request.getParameter("plan");}
		if(request.getAttribute("plan")!=null)
		{plan=""+request.getAttribute("plan");}
		
		if(plan.equals("PLAN"))
		{
			%>
		<td class="column3"><input type="radio" name="plan" value="1" checked onclick="JavaScript:showDivs()" disabled>Plan</td>
		<td class="column3"><input type="radio" name="plan" value="2" onclick="JavaScript:showDivs()" disabled>Non-Plan</td>
		<%} else {%>
		<td class="column3"><input type="radio" name="plan" value="1" onclick="JavaScript:showDivs()" disabled>Plan</td>
		<td class="column3"><input type="radio" name="plan" value="2" checked onclick="JavaScript:showDivs()" disabled>Non-Plan</td>
		<%}%>

		</tr>
		<tr>
		<td class="column1">Work Category<span class="mandatory">*</span></td>
		<td class="column2"><html:text property="workCat" readonly="true"/></td>
			
		<td class="column3">
		Scheme
		<span class="mandatory">*</span></td>
		<td class="column4"><html:text  property="typeOfAsset" readonly="true"/></td>
		</tr>
<c:set var="sName" value="${AdminstrativeSanctionForm.typeOfAsset}" scope="request"/>
			<%String statss = (String)request.getAttribute("sName");
		
			%>
		<tr>
		<td colspan="2" nowrap>
		<%
		  String aug="";
		  if(request.getParameter("wrkType") != null)
		  {aug=request.getParameter("wrkType");}
		  else if(request.getAttribute("wrkType") != null)
		  {aug=""+request.getAttribute("wrkType");}

		 
		  if(aug.equalsIgnoreCase("MAIN SCHEME") || aug.equalsIgnoreCase("AUGUMENTATION")){
            
            if(aug.equals("MAIN SCHEME") || aug.equals("MAIN SCHEME")){
            		             %>
            <input type="radio" value="1" name="wrktype" checked disabled>MainScheme
           	<input type="radio" value="2" name="wrktype" disabled>Augmentation
           	<input type="radio" value="3" name="wrktype" disabled>Drought	
			<%} else { %>
     	    <input type="radio" value="1" name="wrktype" disabled>MainScheme
           	<input type="radio" value="2" name="wrktype" checked disabled>Augmentation
           	<input type="radio" value="3" name="wrktype" disabled>Drought
			<%}}
		else if(aug.equalsIgnoreCase("MAINTENANCE")){%>
            <input type="radio" value="1" name="wrktype" disabled>MainScheme
            <input type="radio" value="2" name="wrktype" disabled>Augmentation
     		<input type="radio" value="3" name="wrktype" checked disabled>Drought    		
        <%}
        %>
		</td>
		<td colspan="2">
<%		   if(aug.equalsIgnoreCase("AUGUMENTATION")){%>
			Augmentation Link<span class="mandatory">*</span>&nbsp;

				<html:text  property="augsch" readonly="true" />
				<html:button property="mode" value="..." style="width:25px" styleClass="btext" title="Click Here"
								 onclick='<%= "javascript: showWorks()"%>' /></td>
							<%}%> 
		</td>
		</tr>
		<tr>
 		<td class="column1">Programme
		<span class="mandatory">*</span>
		</td>
		<td class="column2"><html:text  property="programs" readonly="true" /></td>
		
		<td class="column3">Sub Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		    <html:text  property="subPrograms" readonly="true" />
		</td>
		
		</tr>
		<tr>
	    <td class="column1">
			Circle
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		     <html:text  property="circleOfficeName" readonly="true" />
              <html:hidden  property="circleOfficeCode"  /> 
	 	</td>
	 
		<td class="column3">Division
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		    <html:text  property="divisionOfficeName" readonly="true" />
		    <html:hidden  property="divisionOfficeCode"  /> 
	 	</td>
	 	</tr>
	 	<tr>
	 	<td class="column1">SubDivision
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		    <html:text  property="subdivisionOfficeName" readonly="true" />
		    <html:hidden  property="subdivisionOfficeCode"  /> 
	 	</td>
	 	<td class="column3">Approved Under<span class="mandatory">*</span></td>
        <td class="column4">
	
	    <html:text  property="prooved" readonly="true" />
		 </td>
		
	</tr>
	
	</tbody>
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
    

<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.workDetails" /></legend>
		<div id="tbl-container22">

<table id="tbl" border = 1   style="border-collapse:collapse"  >
	
<thead class="fixedHeader">

			<!-- <table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"  style="border-collapse: collapse">
			<thead class="gridHeader">-->
			<tr class="normalRow">
				<th class="locked" rowspan=2 nowrap width="30">S. No.</th>
				<th class="locked" rowspan=2 width="50"><bean:message key="app.select" /></th>
				<th class="locked"  rowspan=2 width="100" >Work Id</th>
				<%if(request.getParameter("typeOfAsset")!=null && !((request.getParameter("typeOfAsset").equals("11") ||request.getParameter("typeOfAsset").equals("12"))))
				{%>
				<th class="locked" rowspan=2 width="150" >Select Habs</th>
				<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11"))
				{%>
				<th class="locked" rowspan=2 width="150">Select Schools</th>
				<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12"))
				{%>
				<th class="locked" rowspan=2 width="150">Select Labs</th> 
			   <%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("13"))
				{%>
				<th class="locked" rowspan=2 width="150">Select Offices</th> 
				<%}
				else{%>
				<th class="locked" rowspan=2 width="150">Select</th> 
				<%}%>
				<th  rowspan=2 width="150" class="locked"><bean:message key="app.workName" /></th>
                <th  rowspan=2 width="155" >Work Type</th>
			  	<th  rowspan=2 width="70">Sanctioned Amount(Rs. in Lakhs)</th>
			 	<th  colspan=2 width="200">Adminstrative Sanction </th>
                <th  colspan=4 width="485" >Technical Sanction </th>
                <th colspan=7 width="1000">Source Details </th>
                <th rowspan=2 width="100">Existing Asset</th>
                <th rowspan=2 width="120" align="center">Asset Code</th>
                <th rowspan=2 width="150">SITE_HAND_OVER DATE </th>
                <th rowspan=2 width="150">Grounding DATE </th>
                <th rowspan=2 width="150">EXPENDITURE_UPTO</th>
				<th rowspan=2 width="150">EXPENDITURE_UPTO Date</th>
        		<th rowspan=2 width="100">VALUE_OF_WORK_NOT_PAID</th>
                <th rowspan=2 width="150">DATE_OF_COMPLETION</th>
                <th rowspan=2 width="150">DT_FIN_COMPLETION</th>
              	<th rowspan=2 width="150">DATE_OF_COMM</th>
				<th rowspan=2 width="100"><bean:message key="app.remarks" /></th>
    		</tr>
			<tr>
			<th width="100">Number</th>
			<th width="100">Date</th>
            <th width="85">TS Number</th>
			<th width="115">TS Date</th>
            <th width="85">TS Amount</th>
			<th width="200">SSR_YEAR </th>
            <th width="100" align="center">Select Source</th> 
			<th width="140">SOURCE_HAB_CODE</th>    
			<th width="140">SOURCE_TYPE_CODE </th>      
			<th width="150">SUBSOURCE_TYPE_CODE  </th>
			<th width="140">SOURCE_CODE </th>   
			<th width="140">SOURCE_NAME </th>    
			<th width="140">SOURCE_LOCATION</th>
			</tr>
			</thead>
			<tbody>
		
			<nested:iterate id="WORK" property="proposals1" indexId="ndx">
			<% workCount++; count++;
              
             %>
			<tr bgcolor="#ffffff">
				<td class="locked" align="center" width="30"><font face="verdana" size="2"><%=index++%></font>
				</td>
				<td class="locked" align="center" width="50"><input type="checkbox" name="remove" value="<%=ndx%>"/>
				</td>
				<td class="locked" width="100">
					<nested:text name="WORK" property="proposalId" indexed="true" readonly="true"  style="width: 100px;text-align: center" styleClass="noborder-text-box"/>
				</td>
				<td nowrap class="locked" width="180" align="center">
					<nested:text name="WORK" property="noOfHabs" indexed="true"  readonly="true" styleClass="noborder-text-box" style="width: 110px" />
					<html:button property="addHab" value="..." styleClass="btext" onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
				</td>
				<td width="150" class="locked">
					<nested:text name="WORK" property="proposalName" indexed="true" maxlength="100" style="width: 120px" styleClass="noborder-text-box" onkeypress="return textOnly()" />
				</td>
                <td width="155" >
                <html:select name="WORK"  property="workType" style="width: 120px;" indexed="true" styleClass="mycombo">
          	    <html:option value="<%=proposalHolder.getWorkType()%>"><%=proposalHolder.getWorkType()%></html:option> 
	            </html:select>
                </td>
				<td width="70">
					<nested:text name="WORK" property="sanctionAmout" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
				<td width="100"> 
					<nested:text name="WORK" property="adminiStrativeNum" indexed="true" maxlength="50" style="width: 100px;text-align: left" styleClass="noborder-text-box"/>
				</td>
			  <td NOWRAP width="100">
					<nested:text name="WORK" property="adminiStrativeDate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].adminiStrativeDate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				<td width="75">
					<nested:text name="WORK" property="tsno" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
               <td NOWRAP width="115">
					<nested:text name="WORK" property="tsdate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].tsdate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
                <td width="75">
					<nested:text name="WORK" property="tsamt" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
 				<td width="165"><html:select name="WORK"  property="ssryr" style="width: 120px;" indexed="true" styleClass="mycombo">
          	    <option value="<%=proposalHolder.getSsryr()%>"><%=proposalHolder.getSsryr()%></option> 
	            </html:select>
                </td>
                <td nowrap width="100" align="center">
			    <nested:text name="WORK" property="noOfSources" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 25px"/>
				<html:button property="addSource" value="..." styleClass="btext" onclick='<%= "javascript: fnPickSources(\" + ndx +\")"%>' />
			    </td>
 				<td width="140">
					<nested:text name="WORK" property="srhabcode" indexed="true"  styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
 				<td width="140">
					<nested:text name="WORK" property="srtypecode" indexed="true" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
                <td width="150">
					<nested:text name="WORK" property="subsrtypecode" indexed="true" style="width: 80px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
               <td width="140">
					<nested:text name="WORK" property="scrcode" indexed="true"  style="width: 150px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
                 
 				<td width="140"> 
					<nested:text name="WORK" property="srname" indexed="true"  styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
               
 				<td width="140">
					<nested:text name="WORK" property="srloc" indexed="true" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
                <td width="100">
                
					<html:checkbox  name="WORK" property="newext"  indexed="true" style="width: 60px;" styleClass="noborder-text-box"/>
                    <html:text name="WORK" property="asttype" indexed="true" style="width: 0px;" />
              
				</td> 
               <td nowrap width="120" align="center">
					<nested:text name="WORK" property="astcode" indexed="true" readonly="true" styleClass="noborder-text-box" />
					<html:button property="addAsset" value="..." styleClass="btext" onclick='<%= "javascript: showAssets(\" + ndx +\")"%>' />
				</td>
 				<!--<td>
					<nested:text name="WORK" property="astcode" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
                 <td>
					<nested:text name="WORK" property="newext" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td> -->
                <td NOWRAP width="150">
					<nested:text name="WORK" property="sitedate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].sitedate'));">
		            <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
                <td NOWRAP width="150">
					<nested:text name="WORK" property="grounddate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].grounddate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
				<td width="150">
					<nested:text name="WORK" property="expupto" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
 				<td NOWRAP width="150">
					<nested:text name="WORK" property="expuptodate" indexed="true" readonly="true" maxlength="15" style="width: 90px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].expuptodate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
				<td width="100">
					<nested:text name="WORK" property="notpaidvalue" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
 				<td NOWRAP width="150">
					<nested:text name="WORK" property="compdate" indexed="true" readonly="true" maxlength="15" style="width: 90px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].compdate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
				<td NOWRAP width="150">
					<nested:text name="WORK" property="fincompdate" indexed="true" readonly="true" maxlength="15" style="width: 90px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].fincompdate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				<td NOWRAP width="150">
					<nested:text name="WORK" property="commdate" indexed="true" readonly="true" maxlength="15" style="width: 90px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].commdate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
				<td width="100">
					<nested:text name="WORK" property="remarks" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>

			</tr>
           </nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
            
			</tbody>
			</table>


			<table width="100%">
			<tr>
			<td align="left">
			<!-- <a href="#1" onclick="chkAll(<%=workCount%>)">Check All</a>&nbsp;&nbsp;
			<a href="#2" onclick="clrAll(<%=workCount%>)">Clear All</a>-->
			</td>
		
			</td>
			</tr>
			</table>





</div>

		</fieldset>
	</tr>


	<tr>
	<td>
		 <table width="100%">
		    <tr>
			<td align="center">
		    <input type="button" value="Update" name="update" class="btext" onclick="fnUpdate();">          
                     
			</td>
		    </tr>
		</table>
	</td>
	</tr>

	</table>
</td>
</tr>
</tbody>
</table>
<html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER" />
<html:hidden property="officeCode" name="RWS_USER" />
<input type="hidden" name="special" value="">
<html:hidden property="sourcecode" />
<html:hidden property="subsourcecode"  />
<input type="text" name="prevhabId" style="width: 0px" value="">
			
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>

<script language="javascript">
<%
 if(session.getAttribute("GlobalConstants.Message")!=null)
 {
		
%>
 alert('<%=session.getAttribute("GlobalConstants.Message")%>');
<%
session.removeAttribute("GlobalConstants.Message");

%>
window.close();


<%}%>
</script>
<script language="javascript">
var workCount = document.getElementById("workCount").value;
var HabName='<%=HabName%>';
for(var i=0; i<workCount; i++)
{
var spid='<%=myid%>';
var HabName='<%=HabName%>';
var shcode='<%=shcode%>';
var stname='<%=stname%>';
var sttypename='<%=sttypename%>';
var ppid=document.getElementById("WORK["+i+"].proposalId").value;
// alert("spid..."+spid);
// alert("ppid..."+ppid);
 // alert("HabName..."+HabName+stname+sttypename);
if(spid==ppid)
{
document.getElementById("WORK["+i+"].noOfHabs").value='<%=HabName%>';

}

}
</script>


