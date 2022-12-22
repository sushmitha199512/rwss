
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<html:html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<TITLE></TITLE>
</HEAD>

<BODY>
<P>Place content here.</P>
</BODY>
</html:html> 
    
-->
   <%@ include file="/commons/rws_header1.jsp" %>
   
  
	 <html:javascript formName="assetForm" />
	 <script language="javaScript">
	 </script>	
	

	<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" >	
	<table  bordercolor= "#8A9FCD"  border="0" rules="none" style="border-collapse:collapse;" width="100%"  >
	<thead class="gridLabel">
    <tr bgcolor="#8A9FCD">
    <td colspan=2 align=left><b>Asset SubComponent Parameter Details </b>
    </td>
    </tr>
 	</thead>
	
	<tr>
	<td colspan="3">
	<table  class="row" bordercolor= "#8A9FCD"  border="1"  rules="none" style="border-collapse:collapse;" width="100%" >
	</table>

     <c:if test="${sessionScope.assetsubCompParams=='CpwsPumpingMain'}">
     <table>
     <tr bgcolor="#8A9FCD" class="gridLabel" >
        <td colspan=4 align=left ><b>Component Name:&nbsp;CPWS-PIPELINE-PUMPING MAIN</b>
        </td>
        </tr>
        <html:form action="Asset.do?mode=Submit">
	 <nested:iterate id="ASSETSUBCOMPONENTS_PIPELINE" property="assetPipeLine" indexId="ndx">
	 <tr>
	       <td align=left class="textborder"><bean:message key="app.length"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="length"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.metType"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:select name="ASSETSUBCOMPONENTS_PIPELINE" property="metType"   styleClass="mytext" style="width:120px">
	         <html:option value="">SELECT...</html:option>
	         <html:option value="">AC</html:option>
	         <html:option value="">PVC</html:option>
	         <html:option value="">HDPE</html:option>
	         <html:option value="">DI</html:option>
	         <html:option value="">CI</html:option>
	         
	         
	         </html:select>
		   </td>
	</tr>
	 <tr>
	       <td align=left class="textborder"><bean:message key="app.failFreq"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:select name="ASSETSUBCOMPONENTS_PIPELINE" property="failFreq"   styleClass="mytext" style="width:120px">
	         <html:option value="">SELECT...</html:option>
	        
	         <html:option value="">ONCE</html:option>
	        <html:option value="">TWICE</html:option>
	        <html:option value="">MORE</html:option> 
	         </html:select>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.failType"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:select name="ASSETSUBCOMPONENTS_PIPELINE" property="failType"   styleClass="mytext" style="width:120px">
	           <html:option value="">SELECT...</html:option>
	          <html:option value="">TRANSEVERSE</html:option>
	        <html:option value="">LONGITUDINAL</html:option>
	        
	         </html:select>
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.failReason"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:select name="ASSETSUBCOMPONENTS_PIPELINE" property="failReason"   styleClass="mytext" style="width:120px">
	            <html:option value="">SELECT...</html:option>
	         <html:option value="">AtSameLocation</html:option>
	          <html:option value="">AtDiffLocation</html:option>
	         </html:select>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.airValveNo"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="airValveNo"   styleClass="mytext" style="width:120px"/>
	         
	         
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.airValvePitNo"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="airValvePitNo"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.airValvePitCondGood"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="airValvePitCondGood"   styleClass="mytext" style="width:120px"/>
	        
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.airValvePitCondBad"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="airValvePitCondBad"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.scourevalve"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="scourevalve"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	
	<tr>
	       <td align=left class="textborder"><bean:message key="app.srValvePitNo"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="srValvePitNo"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.srValvePitCondGood"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="srValvePitCondGood"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.srValvePitCondBad"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="srValvePitCondBad"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.reflexValve"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="reflexValve"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.rValvePitNo"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="rfValvePitNo"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.rValvePitCondGood"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="rfValvePitCondGood"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.rValvePitCondBad"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="rfValvePitCondBad"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.sluiceValve"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="sluiceValve"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.slValvePitNo"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="slValvePitNo"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   <td align=left class="textborder"><bean:message key="app.slValvePitCondGood"/>&nbsp;&nbsp;
			</td>
			 <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="slValvePitCondGood"   styleClass="mytext" style="width:120px"/>
	         
		   </td>
	</tr>
	<tr>
	       <td align=left class="textborder"><bean:message key="app.slValvePitCondBad"/>&nbsp;&nbsp;
			</td>
		    <td  class="textborder" align=left >
	         <html:text name="ASSETSUBCOMPONENTS_PIPELINE" property="slValvePitCondBad"  maxlength="20" styleClass="mytext" style="width:120px"/>
		   </td>
		   </tr>
</nested:iterate>
        </table>
	     <tr>
		
			<td  align="left" colspan="1">
				<html:button property="mode" title="First Asset" styleClass="btext" value="First" onclick="firstfunc()"/>		
				<html:button property="mode" title="Previous Asset" styleClass="btext" indexed="false" value="Prev"onclick="previousfunc()">
				<id="p1"/>
				</html:button>
		        <html:button property="mode" title="Next Asset" styleClass="btext"value="Next" onclick="nextfunc()"/>
				<html:button property="mode" title="Last Asset" styleClass="btext" value="Last"onclick="lastfunc() "/>
			</td>
			<td  align="right" colspan="1">
			    <html:button property="mode" title="Remove" styleClass="btext" value="Remove" onclick="removefunc()"/>
			    <html:button property="mode" title="Add new the Fields" styleClass="btext" value="AddNew" onclick="addnew()"/>
			   
			    <html:button property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="savefunc()"/>
	    		<html:reset  title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>
	    	</td>
	   </tr>
	   
	   </table>
	   
         </html:form>
        
	</c:if>

	</body>
	

   
  
    

