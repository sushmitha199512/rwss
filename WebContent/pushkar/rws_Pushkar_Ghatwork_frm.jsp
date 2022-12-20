<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "/reports/conn.jsp" %>

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

String myid = (String)session.getAttribute("proposalId");
String pageid= request.getParameter("proposalId");
String[] habsarray=(String[])session.getAttribute("habsarray");

String noOfHabs = "0";
String HabName="",ssyr="",toolvalue="";
String srcode="",subsrcode="",stname="",sttypename="",srname="",sscode="",ssloc="",assetCode="";
if(habsarray!=null)
{

HabName=habsarray[0].substring(0,16);
toolvalue=habsarray[0];
}

int lengthHab = Integer.parseInt(noOfHabs);
String shcode=(String)session.getAttribute("sourceHabCode");
if(session.getAttribute("sourceType")!=null)
{
srcode=(String)session.getAttribute("sourceType");
}

if(session.getAttribute("subsourceType")!=null)
{
subsrcode =(String)session.getAttribute("subsourceType");
}

 
if(session.getAttribute("syr")!=null)
{
session.setAttribute("ssyr",session.getAttribute("syr"));
}

String syr=(String)request.getParameter("ssryr");
if(syr!=null)
request.setAttribute("ssryr",syr);

%>
<%@ include file = "rws_pushkar_works_js.jsp" %>
<body onload="showFields();">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:form action="PushkarWork.do" method="post" enctype="multipart/form-data">
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in <IMG SRC="<rws:context page='/images/india-rupee-symbol.png'/>" width="20" border="0" height="20" align="absmiddle" /></b>&nbsp;&nbsp;<BR>
</caption> 
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="pushkar Works Form" />
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
					<html:options collection="headOffices" name="labelValueBean" property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual> 
		</td>
         
    	 </tr>
			
 		  
 		  <tr>
          <td colspan="2" nowrap>
			
			<html:radio value="3" property="wrktype" onclick="getProgrammes();"/>          
			Pushkar
            </td>
		<tr>
		<td class="column1">
			Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
				<html:select property="programs" style="width:150px" styleClass="mycombo" onchange="javascript: fnGetSubprogrammes(this);checkLinkAug();" >
	            <html:option value=""><font class="myfontclr1">SELECT...</html:option>
	             <logic:present name="programmes1" >
	             <html:options collection="programmes1"  name="labelValueBean" property="value" labelProperty="label" />
        	     </logic:present>
	             </html:select>
		</td>
	 	<td class="column3">Sub Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
	 		<html:select property="subPrograms"  style="width:150px" onchange="javascript: fnGetSubprogrammes1(this)" styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:present name="SubPrograms1">
		 	<html:options collection="SubPrograms1" name="SubPrograms" property="value" labelProperty="label" />
			</logic:present>			  
	 		</html:select>
	 	</td>
		</tr>
		<tr>
        
	 	<td class="column1">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
			       <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
					<html:select property="circleOfficeCode" onchange="javascript:fnGetOffices(this)" styleClass="combo">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="circles1">
						<html:options collection="circles1" name="labelValueBean" property="value" labelProperty="label" />
						</logic:notEmpty>			  
					</html:select>
			        </logic:equal>
			        <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00"> 
					<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="circleOfficeCode" name="RWS_USER" />
			        </logic:notEqual>
		</td>
		<td class="column3"><bean:message key="app.division"/>
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
			    <logic:equal name="RWS_USER" property="divisionOfficeCode"  value="0" >
				<html:select property="divisionOfficeCode" onchange="javascript:fnGetOffices(this);" styleClass="combo" >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="divisions1">
				<html:options collection="divisions1" name="labelValueBean" property="value" labelProperty="label" />
				</logic:notEmpty>			  
				</html:select>
			    </logic:equal>
			    <logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0" > 
				<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
			    </logic:notEqual>
		</td>
		</TR>
		<TR>	
		<td class="column1">SubDivision<span class="mandatory">*</span></td>
		
        <td class="column2">
    		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo"  onchange="javascript:fnGetOffices(this);">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions1">
			<html:options collection="subdivisions1" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	</td>
	</tr>
	<tr>
	
	<td class="column1">Mandal<span class="mandatory">*</span></td>
        <td class="column2">
    		
			<html:select property="mandalCode" styleClass="combo"  onchange="javascript:fnGetOffices(this);">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 <logic:present name="mandals">
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
			 </logic:present >
			</html:select>
		</td>
		
<td class="column1">Panchayat<span class="mandatory">*</span></td>
        <td class="column2">
    		
			<html:select property="panchayatCode" styleClass="combo"  onchange="javascript:fnGetOffices(this);">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 <logic:present name="panchayats">
			<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
			 </logic:present >
			</html:select>
		</td>		
		
		
		</tr>
		<tr>
		
	</td>
	
		 <td class="column1">
			Ghat Type 
		<span class="mandatory">*</span></td>
         <td class="class2">
         <html:select property="ghatType" styleClass="combo">
    		<html:option value="">SELECT...</html:option>
    		<html:option value="A">A</html:option>
    		<html:option value="B">B</html:option>
    		<html:option value="C">C</html:option>
    		<html:option value="A+">A+</html:option>
			<html:option value="LG">Local Ghat</html:option>
			<html:option value="PN">Pushkar Nagar</html:option>
    	
    	</html:select>
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

			
			<tr class="normalRow">
				<th class="locked" rowspan=2 nowrap width="30">S. No.</th>
				<th class="locked" rowspan=2 width="50"><bean:message key="app.select" /></th>
				<th class="locked"  rowspan=2 width="100">Work Id<font face="verdana" size="2" color="red">*</font></th>
				
				<th class="locked" rowspan=2 width="150">Select Hab<font face="verdana" size="2" color="red">*</font></th> 
				
				<th  rowspan=2 width="150" class="locked"><bean:message key="app.workName" /><font face="verdana" size="2" color="red">*</font></th>
			  	<th  rowspan=2 width="155">Work Type<font face="verdana" size="2" color="red">*</font></th>
			    <th  rowspan=2 width="70">Pushkar Code<font face="verdana" size="2" color="red">*</font></th>
                <th  rowspan=2 width="70">Sanctioned Amount<br>(in Rs.)<font face="verdana" size="2" color="red">*</font></th>
			 	<th  colspan=2 width="200">Adminstrative Sanction<font face="verdana" size="2" color="red">*</font> </th>
                <th  colspan=4 width="485">Tender Details</th>
                <th  colspan=2 width="300">Agrrement Details</th>
             
                <th rowspan=2 width="150">Grounding DATE </th>
                <th rowspan=2 width="150">EXPENDITURE<br>(in Rs.)</th>
				<th rowspan=2 width="100">Value For Work Done As on Date</th>
				   <th  rowspan=2 width="150">Physical Details</th>
				<th rowspan=2 width="100">% of Work Done</th>
                <th rowspan=2 width="150">PROBABLE DATE_OF_COMPLETION</th>
                <th rowspan=2 width="150">Date of WORK COMPLETION</th>
                 <th rowspan=2 width="150">WORK IMAGE</th>
              	
				<th rowspan=2 width="100"><bean:message key="app.remarks" /></th>
    		</tr>
			<tr>
			<th width="100">Number</th>
			<th width="100">Date</th>
            <th width="85">Tender Invited</th>
			<th width="85">Tender Amount</th>
			<th width="85">Tender Aprooved</th>
			<th width="85">Tender Aprooved Amount</th>
            <th width="85">Agrement Concluded</th>
            <th width="85">Agrement Concluded Amount</th>

			</tr>
			</thead>
			<tbody>
		<%    String[] habs=new String[100];
               ArrayList toolList=null;
              if(session.getAttribute("proposalsList")!=null)
             {
              toolList=(ArrayList)session.getAttribute("proposalsList");
             }
             else
			{
                toolList=null;    
			}
              if(toolList!=null)
               {
                 habs=new String[toolList.size()];               
                for (int k=0;k<toolList.size();k++ )
               {
				    
						nic.watersoft.pushkar.PushkarHolder d=(nic.watersoft.pushkar.PushkarHolder)toolList.get(k);
						if(d!=null){
                         
                          habs[k]=d.getHabDetails();
                         					
					}                 

				}
			  }
else
{
habs[0]="";
}
         
          
         %>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; count++;%>
			<tr bgcolor="#ffffff">
				<td class="locked" align="center" width="30"><font face="verdana" size="2"><%=index++%></font>
				</td>
				<td class="locked"    align="center" width="50"><html:checkbox name="WORK" property="checks"   indexed="true" /></td>
				<!-- <td class="locked" align="center" width="50"><input type="checkbox" name="remove" property="checks"  indexed="true" value="<%=ndx%>"/>
				</td> -->
				<td class="locked" width="100">
					<nested:text name="WORK" property="proposalId" indexed="true" readonly="true"
							     style="width: 100px;text-align: center" styleClass="noborder-text-box"/>
				</td>
              
				<td class="locked">
				<html:select name="WORK"  property="habs" style="width:150px" styleClass="mycombo" indexed="true" >
	            <html:option value=""><font class="myfontclr1">SELECT...</html:option>
	             <logic:present name="habitations" >
	             <html:options collection="habitations"  name="labelValueBean" property="value" labelProperty="label" />
        	     </logic:present>
	             </html:select>
		</td>

				<td width="150" class="locked">
					<nested:text name="WORK" property="proposalName" indexed="true" maxlength="100" style="width: 120px" styleClass="noborder-text-box"  onkeypress="return textOnly()" />
				</td>
				
				<td width="155">
                 <html:select name="WORK"  property="workType" style="width: 150px;" indexed="true" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			
    		<html:option value="DW">Drinking Water</html:option>
    		<html:option value="Sanitation">Sanitation</html:option>
    		<html:option value="Dress Change Room">Dress Change Room</html:option>
    		<html:option value="Fountain Bath">Fountain Bath</html:option>
				</html:select>
                 </td>

              
				<td class="column2">
				<html:select name="WORK"  property="pushkarCode" style="width:150px" styleClass="mycombo" indexed="true" >
	            <html:option value=""><font class="myfontclr1">SELECT...</html:option>
	             <logic:present name="pushkars" >
	             <html:options collection="pushkars"  name="labelValueBean" property="value" labelProperty="labelValue" />
        	     </logic:present>
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
 				
				
					<td width="155">
                 <html:select name="WORK"  property="tenderinvited" style="width: 100px;" indexed="true" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			
    		<html:option value="Y">Yes</html:option>
    		<html:option value="N">No</html:option>
    		
				</html:select>
                 </td>
                 <td width="75">
					<nested:text name="WORK" property="tsno" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
				
				<td width="155">
                 <html:select name="WORK"  property="tenderaprvd" style="width: 100px;" indexed="true" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			
    		<html:option value="Y">Yes</html:option>
    		<html:option value="N">No</html:option>
    		
				</html:select>
                 </td>
				
				 <td width="75">
					<nested:text name="WORK" property="tenderappamount" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
				
              				<td width="155">
                 <html:select name="WORK"  property="agreeconcluded" style="width: 100px;" indexed="true" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			
    		<html:option value="Y">Yes</html:option>
    		<html:option value="N">No</html:option>
    		
				</html:select>
                 </td>
                <td width="75">
					<nested:text name="WORK" property="agreeamount" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
 				

            
            <td NOWRAP width="150">
					<nested:text name="WORK" property="grounddate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].grounddate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				<td width="140">
					<nested:text name="WORK" property="expenditure" indexed="true"  styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
					<td width="100">
					<nested:text name="WORK" property="workdonevalue" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
				
				<td width="100">
                 <html:select name="WORK"  property="physicaldetails" style="width: 100px;" indexed="true" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			
    		            <html:option value="Not Grounded">Not Grounded</html:option>
    		             <html:option value="Progress">Progress</html:option>
    		              <html:option value="Completed">Completed</html:option>
    		
				</html:select>
                 </td>
				
				
				 <td NOWRAP width="150">
					<nested:text name="WORK" property="workdonedate" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
 				</td>
 				
 				
 				
 				<td NOWRAP width="150">
					<nested:text name="WORK" property="prbleDateCompletion" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].prbleDateCompletion'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				<td NOWRAP width="150">
					<nested:text name="WORK" property="completeddate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].completeddate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				
                <td width="100">
				<html:file name="WORK"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" />
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
			
			</td>
			<td align="right">
			<%
			int sp = 0;
			if(request.getAttribute("special") != null && !request.getAttribute("special").equals(""))sp = Integer.parseInt((String)request.getAttribute("special"));
		 %>

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
		  <input type="button" value="Save" name="save" class="btext" onclick="JavaScript:fnSave(this);">          
          <html:reset property="mode" styleClass="btext" onclick="Reset();">
					<bean:message key="button.clear" />
			</html:reset>
	        <input type="button" value="View" name="mode" class="btext" onclick="JavaScript:fnView(this);">          
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
<input type="hidden" name="toolvalue" value="">
			
</html:form>
<table>
<tr><td colspan="2"><font face="verdana" size="2" color="red">Note********:</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">1. To View & Edit Work(s) Selection till Circle is required.</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">2. Selected Habitation Details can be seen by moving Cursor on to Select Hab Column.</td></tr>
</table>



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
 }
%>
</script>

<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
		
%>
 alert('<%=request.getAttribute("message")%>');
<%
request.removeAttribute("message");
 }
%>
</script>






<script>
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


