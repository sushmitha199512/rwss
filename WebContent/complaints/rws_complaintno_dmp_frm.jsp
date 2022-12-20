<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<script language="JavaScript">
function getComplaintNot(that)
	{
	
		var index=that.value;
		
		
		
		var complaintdate=document.getElementById("COMPNLIST["+index+"].complntdt").value;
		
		
		
		var complaintno=document.getElementById("COMPNLIST["+index+"].complntno").value;
        //alert(complaintno);
		
		
		
		
		
		
		url = "switch.do?prefix=/complaints&page=/ComplaintNo.do&mode=get4&complntno="+complaintno;
		
opener.document.forms[0].complntno.value =  complaintno;
self.close();

//	opener.document.forms[0].action=url;
	//opener.document.forms[0].submit();
	

	}
</script>



 

<script language="JavaScript">
function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/ComplaintNo.do?mode=get3";
	document.forms[0].submit();
}
function fnSea()
{
if(document.forms[0].dist.value== "0" || document.forms[0].dist.value==null)
    {
    alert("Select District");
    return false;
    }
   else if(document.forms[0].mand.value== "0" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "0" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
  
   else
   {
		document.forms[0].action="switch.do?prefix=/complaints&page=/ComplaintNo.do?mode=get3";
		document.forms[0].submit;
   }
}

function init()
{
document.forms[0].dist.value="0";
document.forms[0].mand.value="0";
document.forms[0].panch.value="0";

}








</script>

<body >
<%@ include file="/commons/rws_header4.jsp" %>



<html:form action="ComplaintNo.do">

<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Grievance Status  " />
	<jsp:param name="TWidth" value="450" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="480" align="center">
<tr >
<td>
 
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="425"  align=center  style="margin-bottom:0;margin-top:0"> 
   <tr>
   <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
		
		<logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()">
			<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="mandals">
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			
			</html:select>
			
	</td>
	</tr>
	<tr>
	
	   <td class="textborder" width="100">
	   <bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	   <td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  >
		<html:option value="0">SELECT...</html:option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>
		</tr>
				
		
	
	
		
	</table>
	</label>
	</fieldset>
	
   </td>
  </tr>
  
    <tr>
	<td align=center>
	<html:submit property="mode" title="Click"  styleClass="btext" value="Click" onclick="fnSea();"/>
	
  </tr>



<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;List Of Complaints</font>	

	</td>
	</tr>

<tr>
<td>
  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="440" align=center >			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			   
			   
			    <td class=clrborder align=center>Complaint No.</td>
                <td class=clrborder align=center>Source Name</td>
                <td class=clrborder align=center>Complaint Given By</td>  
				<td class=clrborder align=center>Complaint Date</td>
				<td class=clrborder align=center>Nature of Problem</td>
                <td class=clrborder align=center>Problem Description</td>
                
				
				
			</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)session.getAttribute("cno"); 
System.out.println("A Size***::"+a.size());

if(a.size() > 0)
{
%>
<%System.out.println("Complaints"); %>
<% int resultCount = 0;%>
<%System.out.println("Resultcount"+resultCount); %>
<%System.out.println("Complaints1"); %>

<nested:iterate id="COMPNLIST" property="cno" indexId="ndx" >

<%System.out.println("Complaints2"); %>
<% resultCount++; %>
	
	<tr>
	<td  class=bwborder align=center>
	    <input type=radio name="assetCd1" title="Select any Complaint No"  value="<%=String.valueOf(ndx)%>"   onclick="getComplaintNot(this);" />
	</td>
       
        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="complntno" /> 
        <nested:hidden name="COMPNLIST" property="complntno" indexed="true"/>
        </td>
        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="assetName" /> 
        <nested:hidden name="COMPNLIST" property="assetName" indexed="true"/>
        </td>

        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="repName" /> 
        <nested:hidden name="COMPNLIST" property="repName" indexed="true"/>
        </td>
       
        
        
		<td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="complntdt" /> 
        <nested:hidden name="COMPNLIST" property="complntdt" indexed="true"/>
        </td>
		<td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="category" /> 
        <nested:hidden name="COMPNLIST" property="category" indexed="true"/>
        </td>
        
        
        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="complntdesc" /> 
        <nested:hidden name="COMPNLIST" property="complntdesc" indexed="true"/>
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

	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="450





"/>
</jsp:include>
</table>

</html:form>
</html:html>

<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</body>
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




