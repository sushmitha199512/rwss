<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<script language="JavaScript">

function getHabDirData1()
{
	document.forms[0].action="switch.do?prefix=/contractor&page=/ContractorChange.do&mode=get2";
	document.forms[0].submit();
}

function getComplaintNot(that)
	{
		var index=that.value;
		var workid=document.getElementById("COMPNLIST["+index+"].workId").value;
		
	url = "switch.do?prefix=/contractor&page=/ContractorChange.do&mode=data&workId="+workid;
		window.open(url,"","width=950,height=500,left=100,top=150,scrollbars=1,resizable=1");
		}

</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="ContractorChange.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Contractor Change Form " />
	 	
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
	   style="border-collapse:collapse;" width="100%"  >
	   <tr align="center">
		<td class="textborder">Circle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span class="mandatory">*</span>
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"  style="width:140px" onchange="javascript: getHabDirData1(this)" 
							 styleClass="mycombo"> 
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:present>			  
				</html:select>
			</logic:equal>
<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
			
		
	</tr>
    <tr align="center">
		<td class="textborder">Divisions
		<span class="mandatory">*</span>
			
				<html:select property="divisionOfficeCode"  style="width:140px"  onchange="javascript: getHabDirData1(this)"
							 styleClass="mycombo"> 
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="divisions">
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:present>			  
				</html:select>
			
			
		</td>
	</tr>
	</table>
	
	
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Works details</font>	
	</td>
	</tr>
<tr>
<td>
  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="100%" align=center >
			 	
			<tr>
			    <td class=clrborder align=center >Select</td>
			    
			    <td class=clrborder align=center >Work Id</td> 
                <td class=clrborder align=center>Work Name</td>
				<td class=clrborder align=center>Office</td>
                <td class=clrborder align=center>Contractor Code</td>
				<td class=clrborder align=center>Contractor Name</td>

                				</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("workscircles"); 
//System.out.println("A Size::"+a.size());

if(a != null && a.size() > 0)
{
%>
<% %>
<% int resultCount = 0;%>


<nested:iterate id="COMPNLIST" property="workscircles" indexId="ndx" >


<% resultCount++; %>
	
	<tr>	<td  class=bwborder align=center>
	    <input type=radio name="assetCd1" title="Select any Work"  value="<%=String.valueOf(ndx)%>"   onclick="getComplaintNot(this);" />
	</td>
       	<td  class=bwborder align=left>
        <nested:write  name="COMPNLIST" property="workId" /> 
        <nested:hidden name="COMPNLIST" property="workId" indexed="true"/>
        </td>
		        <td  class=bwborder align=left>
       		<nested:write name="COMPNLIST" property="workName"  />
		<nested:hidden name="COMPNLIST" property="workName" indexed="true"/>
		</td>
		    <td  class=bwborder align=left>
		<nested:write name="COMPNLIST" property="officeEntered"  />
		<nested:hidden name="COMPNLIST" property="officeEntered" indexed="true"/>
		</td>
		<td  class=bwborder align=center>
		<nested:write name="COMPNLIST" property="contractorCode"  />
		<nested:hidden name="COMPNLIST" property="contractorCode" indexed="true"/>
		</td>
		<td  class=bwborder align=left>
		<nested:write name="COMPNLIST" property="contractorName"  />
		<nested:hidden name="COMPNLIST" property="contractorName" indexed="true"/>
		</td>

		
		
        	</tr>
</nested:iterate>
<%
}
else 
{
%>
<tr>
<td colspan=7 align=center>No Records</td>
</tr>
<%
}
}catch(Exception e)
{
System.out.println("Exception"+e);
}
%>
  </table>
</td>
</tr>


	
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<%@ include file="/commons/rws_alert.jsp"%>

