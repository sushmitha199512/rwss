<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=get2";
	document.forms[0].submit();
}
function getFromDates()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=dates";
document.forms[0].submit();
}
function getFromDate1()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=display";
document.forms[0].submit();

}

function getData3()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=get3";
	document.forms[0].submit();
}

function getData4()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=get4";
	document.forms[0].submit();
}

function getData5()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=get5";
	document.forms[0].submit();
}
function getData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintstatus.do?mode=view";
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

<body  onload="javascript:init();">
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Complaintstatus.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Grievance Status ( for Existing Assets ) " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="100%" >
<tr>
<td>
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		</td>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
			</html:select>
	</td>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	<td class="textborder" width="100">
	<bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
		</tr>
		<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData1()">
		<html:option value="">SELECT...</html:option>
  	<html:options collection="habitations" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
	</tr>
		</table>
		</label>
	</fieldset>
		   
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Grievance  To be Attended </font>	

	</td>
	</tr>
	<tr><td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center>Sl.No</td>
					<td class=clrborder align=center>Source Name</td>
				<!--	<td class=clrborder align=center>SourceCode</td>-->
                    <td class=clrborder align=center>Complaint Given By</td>
                    <td class=clrborder align=center>Name</td>
                    <td class=clrborder align=center>Address</td>
					<td class=clrborder align=center>Complaint Number</td>
					<td class=clrborder align=center>Complaint Date</td>
					<td class=clrborder align=center>Nature of Problem</td>
					<td class=clrborder align=center style="width:300px">Problem Description</td>
				<!--	<td class=clrborder align=center>Asset Code</td>-->
				</tr>
				<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("reccomplaints"); 

	if( a != null && a.size() > 0)
	{
	%>
	<% int resultCount = 0;%>
	<%int count=0; %>
	<nested:iterate id="COMPLIST" property="reccomplaints" indexId="ndx">
	<% resultCount++; %>
	<tr>
		<tr bgcolor="#ffffff">
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		<td class="bwborder"><%=count %></td>
		<td class=bwborder align=left nowrap><nested:write name="COMPLIST"
		property="assetName" /></td>
		<nested:hidden name="COMPLIST"
		property="sourceCode" indexed="true" />
		<!--<nested:write
		name="COMPLIST" property="sourceCode" />-->
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="repName" indexed="true" /> <nested:write
		name="COMPLIST" property="repName" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="name" indexed="true" /> <nested:write
		name="COMPLIST" property="name" /></td>  
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="address" indexed="true" /> <nested:write
		name="COMPLIST" property="address" /></td>
		<td class=bwborder align=center><nested:write name="COMPLIST"
		property="complntno" /></td>
		<td class=bwborder align=center nowrap><nested:write name="COMPLIST"
		property="complntdt" /></td>
		<td class=bwborder align=left nowrap><nested:write name="COMPLIST"
		property="categoryName" /></td>
		<td class=bwborder align=left style="width:300px" nowrap>
		<nested:write name="COMPLIST" property="complntdesc"/></td>
		<nested:hidden name="COMPLIST"
		property="assetCode" indexed="true" />
		<!--<nested:write
		name="COMPLIST" property="assetCode" />-->
		</tr>
				</nested:iterate>
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=11 align=center>No Records</td>
	</tr>
	<%
	}
}catch(Exception p)
{
System.out.println("Exception in compaints status jsp:"+p);
}
%>
	</table>
	</td>
	</tr>
	<tr>
	<td>
	<fieldset>
	<label>
	<table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
	<tr>
   <td class="textborder">
   From Date<font color="#FF6666">*</font></td>
	<td class="textborder"><html:select property="fromDate" styleClass="mycombo" style="width:150px"  onchange="javascript:getFromDates()">
		<html:option value="">SELECT...</html:option>
		<logic:present name="fromdates">
		<html:options collection="fromdates"  name="labelValueBean"  property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	</td>
		<td class="textborder">
	To Date<font color="#FF6666">*</font></td>
		<td class="textborder"><html:select property="toDate" styleClass="mycombo" style="width:150px" onchange="javascript:getFromDate1()" >
		<html:option value="">SELECT...</html:option>
		<logic:present name="todates">
		<html:options collection="todates"  name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	</td>
	   		</tr>
   		</table>
   		</fieldset>
   		</td>
   		</tr>
    <tr>
    <td  bgcolor="#8A9FCD">
		<font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Grievance  Attended Between Dates</font>	
	</td>
	</tr>
	<tr><td>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
			 				<tr>
			    <td class=clrborder align=center>Sl.No</td> 
			    <td class=clrborder align=center>Source Name</td>
			    <!--<td class=clrborder align=center>SourceCode</td>-->
                <td class=clrborder align=center>Complaint Given By</td>
                <td class=clrborder align=center>Name</td>
                <td class=clrborder align=center>Address</td>
			    <td class=clrborder align=center>Complaint Number</td>
			    <td class=clrborder align=center>Complaint Date</td>
			    <td class=clrborder align=center>Nature of Problem</td>
			    <td class=clrborder align=center>Problem Description</td>
				<td class=clrborder align=center>Complaint Attended Date</td>
				<td class=clrborder align=center>Complaint Attended By</td>
				<td class=clrborder align=center>Complaint Status</td>
				<td class=clrborder align=center>Remarks</td>
			</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("attendedcomplaints"); 
//System.out.println("A Size::"+a);
if( a != null && a.size() > 0)
{
%>
<%//System.out.println("Complaints"); %>
<% int resultCount = 0;%>
<%int count=0; %>
<nested:iterate id="COMDPLIST" property="attendedcomplaints"  >
<% resultCount++; %>
	<tr>
	</tr>
	<tr bgcolor="#ffffff">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
	<td  class="bwborder" ><%=count %></td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="assetName" /> 
	</td>
	<!-- <nested:write  name="COMDPLIST" property="sourceCode" /> -->
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="repName" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="name" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="address" /> 
	</td><td  class=bwborder align=center>
	<nested:write  name="COMDPLIST" property="complntno" /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write  name="COMDPLIST" property="complntdt" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="categoryName" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="complntdesc" /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write  name="COMDPLIST" property="attendt" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="attenby" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="status" /> 
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMDPLIST" property="remarksby" /> 
	</td></tr>
	</nested:iterate>
<%
}
else 
{
%>
<tr>
<td colspan=11 align=center>No Records</td>
</tr>
<%
}
}catch(Exception e)
{
System.out.println("Exception in dshfdhfgbhfdg hgfhgf "+e);
}
%>
    </table>
	</td>
	</tr>
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
</html:html>
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


