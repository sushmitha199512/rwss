
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp" %>
 <html:javascript formName="WorkForm"/>
 <SCRIPT LANGUAGE="JavaScript">
 
 function submitPage()
 {
   document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do";
   document.forms[0].submit();
 }
 function getDivisions()
 {
 document.getElementById('mode').value='div';
 submitPage();
 }
 function getSubDivisions()
 {
 document.getElementById('mode').value='subdiv';
 submitPage();
 }
 function getWorks()
 {
   document.getElementById('mode').value='works';
   submitPage();
 }
 function getWorksDetails()
 {
   document.getElementById('mode').value='details';
   submitPage();
 }
 function includePage()
 {

   var workStage;
		   for(var i=0;i<document.forms[0].workStage.length;i++)
		   {
		    if(document.forms[0].workStage[i].checked)
		    {
		     workStage=document.forms[0].workStage[i].value;
		    }
		   }
		 document.getElementById('workStage').value=workStage;   
		 if(workStage=='01')
		     document.getElementById('mode').value='details';
		  else
		  document.getElementById('mode').value='';
		 if(workStage=='02')
		 {
		  document.getElementById('tsMode').value='data'
		 }
		 if(workStage=='04')
		 {
		  document.getElementById('conMode').value='data'
		 }
		  var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		   message='Circle';
		  }
		  if(document.getElementById('divCode').value=='')
		   {
		     message=message+' -division';
		   }
		   if(document.getElementById('workId').value=='')
		   {
		     message=message+' -work '
		   }
		  if(message!='')
		  {
		   alert("select "+message);
		  }
		  
		  else
		  {
		   submitPage();
		  }
		  
   }
   function includePageWm()
   {
      var chkVal;
      var workStage;
		   for(var i=0;i<document.forms[0].workStage.length;i++)
		   {
		    if(document.forms[0].workStage[i].checked)
		    {
		     workStage=document.forms[0].workStage[i].value;
		    }
		   }
        if(workStage=='03')
        {
        chkVal='sitePrep';
        }
        if(workStage=='04')
        {
        chkVal='contMgnt';
        }
        if(workStage=='05')
        {
        chkVal='wip';
        }
        if(workStage=='06')
        {
        chkVal='Wexp';
        }
        if(workStage=='07')
        {
        chkVal='workComp';
        }
         
     var div=document.getElementById('divCode').value;
     var workId=document.getElementById('workId').value;
     var cmbCircle=document.getElementById('circleCode').value;
     if(workStage=='06')
     {
      	 	document.forms[0].action="/pred/worksMonitoring/workStatus.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&mode=data";
    	 	document.forms[0].submit();
      }
     else if(workStage=='07')
     {
      	 	document.forms[0].action="switch.do?prefix=/worksMonitoring&page=/workStatus.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&mode=data";
    	 	document.forms[0].submit();
      }
      else if(workStage=='03')
     {
      	 document.forms[0].action="switch.do?prefix=/worksMonitoring&page=/workStatus.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&spradgroup=newSrc";
	     document.forms[0].submit();
      }
      else
     {
        
	     document.forms[0].action="switch.do?prefix=/worksMonitoring&page=/workStatus.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle;
	     document.forms[0].submit();
     }
   }
 function showhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=admnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
function showTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=tsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
function showRevTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=revTsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
 function showRevhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=revAdmnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
 function hideRev()
 {
	 if(document.getElementById('revAdminNo').value=='')
	 {
	  	if(document.getElementById('revAdmin'))
	  	{
	  		document.getElementById('revAdmin').style.display='none';
	  	}
	 }
  
 }
function hideRevTec()
{

}
</SCRIPT>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
 
<body  onload="hideRev();hideRevTec();">
<html:form  action="WorkStatus.do?mode=circles" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<html:hidden property="mode"/>
<html:hidden property="tsMode"/>
<html:hidden property="conMode"/>
<html:hidden property="revAdminNo"/>
<html:hidden property="revTsMode"/>
 
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Status" />
	<jsp:param name="TWidth" value="817" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Office Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="4" border="0"   
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<logic:present name="circles">
		 	<logic:notPresent name="fixCircle">
				<td class="textborder" >Circles :</td>
				<td class="textborder">
		        <html:select property="circleCode" style="width:140px" styleClass="mycombo" onchange="javascript:getDivisions()" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="circles"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:notPresent>
		    <logic:present name="fixCircle">
			<td class="textborder">Circle&nbsp;:</td>
				 <logic:present name="RWS_USER" property="circleOfficeName">
				 <html:hidden property="circleCode"/>
			 	<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</logic:present>
			</logic:present>
			<logic:present name="divs" >
		 	<td class="textborder">Divisions :</td>
				<td class="textborder">
		        <html:select property="divCode" style="width:143px" styleClass="mycombo" onchange="javascript:getSubDivisions()" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="divs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="divs">
			
				<td class="textborder">Divisions :</td>
				<td class="textborder">
		        <html:select property="divCode" style="width:143px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent>
			<td>
			<logic:present name="subdivs" >
		 	<td class="textborder">SubDivisions :</td>
				<td class="textborder">
				<html:select property="subdivisioncode" style="width:143px" styleClass="mycombo" onchange="JavaScript:getWorks();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="subdivs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="subdivs">
			
				<td class="textborder">SubDivisions :</td>
				<td class="textborder">
		        <html:select property="subdivisioncode" style="width:143px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent></td>
		</tr>
		<tr>
		<td></td>
		</tr>
		
		<tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Works :</td>
				<td class="textborder" colspan="10"  >
		        <html:select property="workId" style="width:547px" styleClass="mycombo" onchange="javascript:getWorksDetails()" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="rwsWorks"   property="workId" labelProperty="workName" />
	            </html:select>
				</td>
				<td>Scheme :</td>
			    <td><html:text property="scheme"  styleClass="mytext" maxlength="10"style="width:80px" readonly="true"/></td>
			</logic:present>
			<logic:notPresent name="rwsWorks">
				<td class="textborder" >Works :</td>
				<td class="textborder" colspan="6">
		        <html:select property="workId" style="width:547px" styleClass="mycombo"  >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
				<td>Scheme :</td>
			    <td><html:text property="scheme"  styleClass="mytext" maxlength="10"style="width:80px" readonly="true"/></td>
	 		</logic:notPresent>
	 		</tr>
	 	   </table>
		   </label>
		 </fieldset>
    <tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Work Stages</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr class="textborder">	
			<td><html:radio property="workStage" value="01" title="Click to view the Admin & Revised Sanction Details" onclick="includePage()"/></td>	
			<td>Admin Sanction </td>
			<td><html:radio property="workStage" value="02" title="Click to view Tecnical & Revised Technical Sanction Details" onclick="includePage()"/></td>	
			<td>Technical Sanction</td>
			<td><html:radio property="workStage" value="03" title="Click to view Source Idetification Details" onclick="includePageWm()"/></td>	 
			<td>Source Identification </td>
			<td><html:radio property="workStage" value="04" title="Click to view Contractor Management Details" onclick="includePage()"/></td>	 
			<td>Contractor Management </td>
		    </tr>
		    <tr class="textborder">
		    <td><html:radio property="workStage" value="05" title="Click to view Programme Schedule Details" onclick="includePageWm()"/></td>	 
			<td>Programme Schedule </td>
			<td><html:radio property="workStage" value="06" title="Click to view Work Expenditure Details" onclick="includePageWm()"/></td>	 
			<td>Work Expenditure </td>
			<td><html:radio property="workStage" value="07" title="Click to view Work Completion Details" onclick="includePageWm()"/></td>	 
			<td>Work Completion </td>	
		    </tr>	
		   </table>
		   </label>
		 </fieldset>
		 </td> 
	</tr>
	<!-- admin sanction form -->
	<c:if test="${requestScope.Includepage =='01'}">
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Administrative Sanction (Amount In Rs.Lakhs)</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="7" border="0"   
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	 		<tr>
	 		<td colspan="10">
	   		  <fieldset>
			    <legend >
						<B>.</B>
			    </legend>
			    <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Admin Sanction No</td>
					     <td class="clrborder" align="center">Admin Sanction Date</td>
						 <td class="clrborder" align="center">Admin Sanctioned Amount</td>
					     <td class="clrborder" align="center">Programme</td>
					     <td class="clrborder" align="center">Sub programme</td>
					  </tr>
					  <tr>
					      <td class="bwborder" align="center" >
					      1.
					      </td>
					      <td class="clrborder" align="right">
						  <html:text property="adminNo"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="adminDate"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="adminAmnt"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center">
						  <html:text property="progName"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center"> 
						  <html:text property="subProgName"  styleClass="gridtext"   readonly="true" />
						  </td>
					 </tr>
					 <logic:present name="adminProg">
					  <%int i=2; %>
					  <nested:iterate id="snctions" name="adminProg">
				 	  <tr>
					  <td class="bwborder" align="center">
					  <%=i++ %>.
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminNo" styleClass="gridtext" 
						  indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminDate" styleClass="gridtext" 
						  indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminAmnt" styleClass="gridtext" 
						  indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="progName" styleClass="gridtext" 
						  indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="subProgName" styleClass="gridtext" 
						  indexed="true" readonly="true"/>
					  </td>
					  </tr>
					  </nested:iterate>
					 </logic:present>
	 	        </table>
			   </label>
			   </fieldset>
			   </td>
	 	    </tr>
	 	   <tr class="textborder">
	 	     <td>Total Habitations Benefited : 
			 <html:text property="adminHabsBen"  styleClass="mytext"  readonly="true" style="width:80px"  /> 
			  <html:button property="mode" styleClass="btext" value="Show Habitations" onclick="showhabDetails()" title="show habitation detials"/></td>
		   </tr>
		  <tr class="textborder">
			   <td colspan="10">
		   		  <fieldset>
				    <legend >
							<B>Population Benefited(AS Per Census)</B>
				    </legend>
				    <label>
			 		<table cellpadding="0" cellspacing="3" border="0"   
				   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
				   <tr class="textborder">
				    <td>Plain: <html:text property="adminPlainPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Sc: <html:text property="adminScPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   St: <html:text property="adminSTPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Total: <html:text property="adminTotpopu"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
				   </tr>
			   </table>
			   </label>
			   </fieldset>
			   </td>
		  </tr>
	 	</table>
		</label>
		</fieldset>
		</td>
	</tr>
	<!-- Revised admin -->
	    <tr id="revAdmin">
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Revised Administrative Sanction (Amount In Rs.Lakhs)</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="2" border="0"    
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			 
	 		<tr>
	 		<td colspan="6">
	   		  <fieldset>
			    <legend >
						<B>.</B>
			    </legend>
			    <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Revised Admin Sanction No</td>
					     <td class="clrborder" align="center">Revised Admin Sanction Date</td>
						 <td class="clrborder" align="center">Revised Sanctioned Amount</td>
					     <td class="clrborder" align="center">Programme</td>
					     <td class="clrborder" align="center">Sub programme</td>
					  </tr>
					  <tr>
					      <td class="bwborder" align="center">
						   1.
						  </td>
					      <td class="clrborder" align="right">
						  <html:text property="revAdminNo"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="revAdminDate"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="revAdminAmnt"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center">
						  <html:text property="progName"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center"> 
						  <html:text property="subProgName"  styleClass="gridtext"   readonly="true" />
						  </td>
					 </tr>
					 <logic:present name="revAdminProg">
					 <%int j=2; %>
					  <nested:iterate id="snctions" name="revAdminProg">
					  <tr>
					       <td class="bwborder" align="center">
					       <%=j++ %>.
					       </td>
					      <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminNo" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminDate" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminAmnt" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="progName" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="subProgName" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
					  </tr>
					  </nested:iterate>
					 </logic:present>
	 	        </table>
			   </label>
			   </fieldset>
			   </td>
	 	    </tr>
	 	   <tr class="textborder">
	 	     <td>Total Habitations Benefited : 
			  <html:text property="revAdminHabsBen"  styleClass="mytext"   readonly="true" style="width:80px"/> 
			  <html:button property="mode" styleClass="btext" value="Show Habitations" onclick="showRevhabDetails()" title="show habitation detials"/></td>
		   </tr>
		    <tr class="textborder">
			   <td colspan="10">
		   		  <fieldset>
				    <legend >
							<B>Population Benefited(AS Per Census)</B>
				    </legend>
				    <label>
			 		<table cellpadding="0" cellspacing="3" border="0"   
				   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
				   <tr class="textborder">
				   <td>Plain: <html:text property="revPlainPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Sc: <html:text property="revScPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   St: <html:text property="revSTPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Total: <html:text property="revTotpopu"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
				   </tr>
			   </table>
			   </label>
			   </fieldset>
			   </td>
		  </tr>
		  
	 	</table>
		</label>
		</fieldset>
		</td>
	</tr>
	<!--  -->
	</c:if>
	<!-- end -->
	<c:if test="${requestScope.Includepage =='02'}">
	  <%@ include file="/works/rws_works_tecSanction.jsp" %>
	</c:if>
 	<c:if test="${requestScope.Includepage =='04'}">
	  <%@ include file="/works/rws_works_contractor.jsp" %>
 	</c:if>
</table>		
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="817"/>
</jsp:include>
</html:form><!-- -->
</body>
<%@ include file="/commons/rws_footer.jsp"%>
