

<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@page import="nic.watersoft.commons.Debug"%>

<html>
<head>
<script language="JavaScript">
 
  function getData()
 {   
   document.forms[0].action="switch.do?prefix=/masters&page=/ImisProgrammeLink.do&mode=data";
   document.forms[0].submit();
 } 
  	function fnSave()
 	{ 
 		//alert("save");
	 if(document.forms[0].programme.value=="")
        {
	        alert("Please Select the Programme");
	        return;
        }
        else  if(document.forms[0].subProgramme.value=="")
        {
	        alert("Please Select the Sub Programme");
	        return;
        }
 	    else if(document.forms[0].belTo[0].checked==false && document.forms[0].belTo[1].checked==false )
 	    {
	   	    alert("Please select State or Central");
	        return;
 	    }	
 	    else if(document.forms[0].imisProgramme.value=="")
        {
	        alert("Please Select the IMIS Programme");
	        return;
        }
 	   else if(document.forms[0].amtIn.value=="")
       {
	        alert("Please Select Place Amount In");
	        return;
       }
 	  else if(document.forms[0].amtInSvs.value=="")
      {
	        alert("Please Select the Amount In(For SVS Schemes)");
	        return;
      }
	 
 	    else 
 	    {
 	        document.forms[0].action="switch.do?prefix=/masters&page=/ImisProgrammeLink.do&mode=save"; 
 	    	document.forms[0].submit();
 	   		document.forms[0].save.disabled=true;
 	   }
 	} 
 	 function fnView()
 	{
 	  document.forms[0].action="switch.do?prefix=/masters&page=/ImisProgrammeLink.do&mode=view"; 
 	  document.forms[0].submit();
 	} 
 	function autocompletion(){
 	    for (i=0; i<document.forms.length; i++) {
 	     document.forms[i].setAttribute("AutoComplete","off");
 	    }
 	}  
		 	
 </script>
</head>
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
<body  onload="autocompletion()">
<html:form action="ImisProgrammeLink.do">
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
				<td class="bwborder">
					<a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a>
				</td>			
			</tr>  
		</table>
	</caption>
</table>
	<table align="center" cellpadding="0" cellspacing="0" border=0>
		<thead>
			<tr>
				<td>
				<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
					<jsp:param name="TableName" value="IMIS Program Linkage Form" />
					<jsp:param name="TWidth" value="100%" />
				</jsp:include>
				</td>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td>
					<jsp:include page="/commons/TableFotter.jsp">
						<jsp:param name="TWidth" value="100%" />
				    </jsp:include>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<tr>
				<td>
				<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="none" border=1
					style="border-collapse:collapse;">
					<tr>
						<td class="textborder">Programme<span class="mandatory">*</span></td>
						<td>
							<html:select property="programme" style="width:143px" styleClass="mycombo" onchange="getData()" >
								<html:option value="">Select...</html:option>
								<logic:present name="programs">
									<html:options collection="programs" property="programmeCode" labelProperty="programmeName" />
								</logic:present>
							</html:select>
						</td>
					</tr>
					<tr>
						<td class="textborder">Sub Programme<span class="mandatory">*</span></td>
						<td><html:select property="subProgramme" style="width:143px" styleClass="mycombo"  >
								<html:option value="">Select...</html:option>
								<logic:present name="subPrograms">
									<html:options collection="subPrograms" property="subProgrammeCode" labelProperty="subProgrammeName" />
								</logic:present>
						</html:select></td>
					</tr>
					<tr>
						<td class="textborder" colspan="2" align="center"><html:radio property="belTo" value="S">State</html:radio>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<html:radio property="belTo" value="C" >Central</html:radio>
						</td>
					</tr>					
					<tr>
						<td class="textborder">Imis Programme<span class="mandatory">*</span></td>
						<td><html:select property="imisProgramme" style="width:143px" styleClass="mycombo">
							<html:option value="">Select...</html:option>
							<logic:present name="imisPrograms">
								<html:options collection="imisPrograms" property="imisProgrammeCode" labelProperty="imisProgrammeName" />
							</logic:present>
						</html:select></td>
					</tr>
					<tr>
					<td class="textborder">Place Amount In<span class="mandatory">*</span></td>
						<td>
							<html:select property="amtIn" style="width:143px" styleClass="mycombo">
								<html:option value="">Select...</html:option>
								<html:option value="GOI">GOI</html:option>
								<html:option value="State">State</html:option>
								<html:option value="Community">Community</html:option>
								<html:option value="DDP">DDP</html:option>
								<html:option value="NCEF">NCEF</html:option>
							</html:select>
						</td>						
					</tr>
					<tr>
					<td colspan="2"><span class="mandatory">Note:- For MVS schemes Amount divided based on the population </span></td>
					</tr>
					<tr>
					<td class="textborder">Amount In(For SVS Schemes)<span class="mandatory">*</span></td>
						<td>
						<html:select property="amtInSvs" style="width:143px" styleClass="mycombo">
							<html:option value="">Select...</html:option>
							<html:option value="All">All</html:option>
							<html:option value="SC">SC</html:option>
							<html:option value="ST">ST</html:option>
							<html:option value="GEN">GEN</html:option>							
						</html:select>
						</td>						
					</tr>
					<tr align="center">
						<td class="textborder" align=center colspan="2">&nbsp;</td>
					</tr>
					<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
					<tr align="center">
						<td class="textborder" align=center colspan="2">
						<html:button property="save" title="Save the Fields" styleClass="btext"
							value="Save" onclick=" return fnSave()" /> 
						<html:button property="mode" title="View program linkage" styleClass="btext"
							value="View" onclick="return fnView()" />
						</td>
					</tr> 
				</table>
				</td>
			</tr>
		</tbody>
	</table>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>