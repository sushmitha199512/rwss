<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=get2";
	document.forms[0].submit();
}

function getParameters(that)
{

   var index=that.value;
   
    var assetcode=document.getElementById("ASSTLIST["+index+"].assetCode").value;
   
    
    
    var hpcode=document.getElementById("ASSTLIST["+index+"].hpCode").value;
    
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=save&assetCode="+assetcode+"&hpCode="+hpcode+"";
	
}
function fnSave()
{
        var index=that.value;
        
        var assetcode=document.getElementById("ASSTLIST["+index+"].assetCode").value;
        
        var hpcode=document.getElementById("ASSTLIST["+index+"].hpCode").value;
    	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=save&assetCode="+assetcode+"&hpCode="+hpcode+"";
    	document.forms[0].action.submit;
}
function fnView()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=cview";

document.forms[0].action.submit;
}



function getData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=view";
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
function show() {
alert("hai");

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
<body  onload="javascript:init();javascript:hide();">
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="Complaints.do">

<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Assets Complaint Entry Form" />
	<jsp:param name="TWidth" value="740" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="760" align="center">
<tr>
<td>
<fieldset>
		<legend>Asset Details</legend>
		<label>
	<table  border=0  width="770"  align=center  style="margin-bottom:0;margin-top:0">

	<tr>
		     <td class="textborder" width="100">Asset Type<font color="#FF6666">*</font>
			 <td>
			<html:select property="asset" styleClass="mycombo" style="width:125px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:option value="01"><font class="myfontclr1">PWS</html:option>
			<html:option value="02"><font class="myfontclr1">MPWS</html:option>
			<html:option value="04"><font class="myfontclr1">HANDPUMPS</html:option>
			<html:option value="05"><font class="myfontclr1">SHALLOWHANDPUMPS</html:option>
			<html:option value="06"><font class="myfontclr1">OPENWELLS</html:option>
			<html:option value="07"><font class="myfontclr1">PONDS</html:option>
			</html:select>
			</td>
			
</tr>
</table>
</label>
</fieldset>
<fieldset>
		<legend><bean:message key="legend.habitationDetails"/></legend>
		<label>
	<table  border=0  width="770"  align=center  style="margin-bottom:0;margin-top:0">

	<tr>
		     <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
			<td class="textborder" width="150">
			<html:select property="dist" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
			</html:select>
			</td>
	<td class="textborder" width="100"><bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
			</html:select>
		</td>
	
	<td class="textborder" width="100"><bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
	</td>
	</tr>
	<tr>
	<td class="textborder" nowrap width="100"><bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
		</html:select>
	</td>
		</tr>
		
		</table>
		</label>
		</fieldset>
		
</td></tr>
		<tr>
<td bgcolor="#8A9FCD">
   <table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
  <tbody>
  <tr>
  <td  bgcolor="#8A9FCD">
	<div onclick="return toggleItem('collapse_myTbody1')" style="cursor:hand"><img style="WIDTH: 13px; HEIGHT: 11px" src="/pred/images/expand.gif" name="oneb"><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >
					&nbsp;Asset Details</font></div>	
	</td>
	</tr>
	</tbody>
    <tbody class="collapse_obj" id="collapse_myTbody1" style="display:none">
	<tr><td>
	<% if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("04"))
	{%>
		<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>AssetName</td>
			    <td class=clrborder align=center>AssetCode</td>
				<td class=clrborder align=center>HPCode</td>
				<td class=clrborder align=center>Location</td>
				<td class=clrborder align=center>Diameter</td>
				<td class=clrborder align=center>Status</td>
				<td class=clrborder align=center>Condition</td>
				<td class=clrborder align=center>Static WaterLevel</td>
				<td class=clrborder align=center>Summer WaterLevel</td>
				<td class=clrborder align=center>DrillYear</td>
				</tr>
<%java.util.Collection a = (java.util.ArrayList)session.getAttribute("assts"); 
System.out.println("A Size::"+a.size());
if(a.size() > 0)
{
%>


<%System.out.println("Assets"); %>
<% int resultCount = 0;%>
		<%System.out.println("Assets1"); %>
		<nested:iterate id="ASSTLIST" property="assts"  indexId="ndx">
		<%System.out.println("Assets2"); %>
		<% resultCount++; %>
		
		<tr>
        <td>
        <nested:radio property="assetCd1" value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show();getParameters(this);"/>
        <%System.out.println("Assets3"); %>

               
			</td>
        	
		
         <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="assetName"  />
		 </td>
		 <td class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="assetCode"  />
		 </td>
         <td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="hpCode"indexed="true"/>
		<nested:write name="ASSTLIST" property="hpCode"  />
		 </td>
         <td  class=bwborder align=center>
			
         <nested:write  name="ASSTLIST" property="location" /> 
         </td>

         <td  class=bwborder align=center>
				
		<nested:write name="ASSTLIST" property="diameterOfBorewell" /> 
		</td>

				
        <td  class=bwborder align=center>
				
		<nested:write name="ASSTLIST" property="status"  />
		</td>
        <td  class=bwborder align=center>
				
		<nested:write name="ASSTLIST" property="cond"  />
		 </td>

         <td  class=bwborder align=center>
			
		<nested:write name="ASSTLIST" property="staticWaterLevel"  /> 
		</td>
        <td  class=bwborder align=center>
				
		<nested:write name="ASSTLIST" property="summerWaterLevel"  /> 
		</td>

        <td  class=bwborder align=center>
				
		<nested:write name="ASSTLIST" property="drillYear"/> 
		</td>
		</tr>
</nested:iterate>

<%} %>
    </table>
    <%} %>
	</td>
	</tr>
	</tbody>
	</table>

 <tr><td class="textborder">
 <div id="text" style="display:none;">
 Complaint No:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="complntno" value="<%=(String)request.getAttribute("complntno") %>" styleClass="mytext" style="width:80px"/><br>
 Complaint Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="complntdt" value="<%=(String)request.getAttribute("complntdt") %>" styleClass="mytext" style="width:100px" readonly="true"
 
  />
 <a href="javascript:showCalendar(document.CompForm.complntdt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		
 <br>
 Complaint Description:&nbsp;<html:text property="complntdesc" value="<%=(String)request.getAttribute("complntdesc") %>" styleClass="mytext" style="width:80px" maxlength="50" /><br>
 </div>
 </td></tr>
</table>
<table align=center>
<tr>
		<td align=center>
		<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Save" onclick="fnSave()"/>
	    
		<html:submit property="mode" title="View the Results" styleClass="btext" value="View" onclick="fnView()"/>
		
	</tr>
	</table>
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="740"/>
</jsp:include>


</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
</body>
<script language="javascript">
<%
if(session.getAttribute("message")!=null)
{
%>
alert('<%=session.getAttribute("message")%>');
<%}%>


</script>


