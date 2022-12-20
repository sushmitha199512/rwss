
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@page import="nic.watersoft.commons.Debug"%>

<%String ss=request.getParameter("program");
//System.out.println("SS:"+ss);%>
<script language="javascript">

 	function fnSave()
 	{ 
 	    
 	   if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false )
 	   {
 	   	  alert("plan or non plan is required");
 	      return;
 	    }	 
 	    else if(document.forms[0].workCategory.value=="")
             {
             alert("Work Category is required");
             return;
             }
             else if(document.forms[0].program.value=="")
             {
              alert("Programme is required");
              return;
              }
             
 	     else 
 	     {
			  var progcode='<%=request.getParameter("program")%>';
 	        //alert("progcode"+progcode);
			//alert("sss:"+document.forms[0].plan[0].disabled);
		document.forms[0].plan[0].disabled=false;
		document.forms[0].plan[1].disabled=false;
		document.forms[0].wrktype[0].disabled=false;
		document.forms[0].wrktype[1].disabled=false;
		document.forms[0].wrktype[2].disabled=false;
		document.forms[0].workCategory.disabled=false;	document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&progcode="+progcode+"&mode=update"; 
 	    	document.forms[0].submit();
 	   		document.forms[0].save.disabled=true;
			
 	   }
 	}
 	
 	 
 	  	 
 	 function fnView()
 	{
		document.forms[0].plan[0].disabled=false;
		document.forms[0].plan[1].disabled=false;
		document.forms[0].wrktype[0].disabled=false;
		document.forms[0].wrktype[1].disabled=false;
		document.forms[0].wrktype[2].disabled=false;
		document.forms[0].workCategory.disabled=false;
 	  document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&mode=view"; 
 	  document.forms[0].submit();
 	 }
 	   
</script>


<html:form action="/workCategory.do?mode=edit" onsubmit="return winView()">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
				<tr align="right">
						<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Home&nbsp;&nbsp;|</a><a href="javascript:onclick=history.go(-1)">Back</td>		
				</tr>  
			</table>
		</caption>
	</table>
	<table align="center" cellpadding="0" cellspacing="0" border=0>
		<thead>
			<tr>
				<td><jsp:include page="/commons/TableHeaderWithoutClose.jsp">
					<jsp:param name="TableName" value="Program Linkage Form" />
					<jsp:param name="TWidth" value="100%" />
				</jsp:include></td>
			</tr>
		</thead>

		<tfoot>
			<tr>
				<td><jsp:include page="/commons/TableFotter.jsp">
					<jsp:param name="TWidth" value="100%" />
				</jsp:include></td>
			</tr>
		</tfoot>

		<tbody>
			<tr>
				<td>
				<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="none" border=1
					style="border-collapse:collapse;">
					<tr>
						<td class="textborder" colspan="2" align="center"><html:radio
							property="plan" value="1" onclick="checkMe()" disabled="true">Plan</html:radio>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<html:radio property="plan" value="2" onclick="checkMe();" disabled="true" >Non Plan</html:radio>
						</td>
					</tr>
					<tr>
						<td class="textborder" colspan="3"><html:radio property="wrktype"
							value="1"  disabled="true">MainScheme</html:radio> <html:radio property="wrktype"
							value="2"  disabled="true">Augmentation</html:radio> <html:radio
							property="wrktype" value="3" disabled="true" >Maintenance</html:radio></td>
					</tr>
					
					<tr>
						<td class="textborder">Work Category<span class="mandatory">*</span></td>
						<td><html:select property="workCategory" style="width:143px"
							styleClass="mycombo" onchange="fnWchange()"  disabled="true">
							<html:option value="">Select...</html:option>
							<logic:present name="workCategory">
								<html:options collection="workCategory" property="value"
									labelProperty="label" />
							</logic:present>
						</html:select></td>
					</tr>
					<tr>
						<td class="textborder">Programme<span class="mandatory">*</span></td>
						<td><html:select property="program" style="width:143px"
						styleClass="mycombo">
							<html:option value="">Select...</html:option>
							<logic:present name="Programme">
								<html:options collection="Programme" property="value"
									labelProperty="label" />
							</logic:present>
						</html:select></td>
					</tr>
					<tr align="center">
						<td class="textborder" align=center colspan="2">&nbsp;</td>
					</tr>
					<tr align="center">
						<td class="textborder" align=center colspan="2">
						<html:button
							property="save" title="Save the Fields" styleClass="btext"
							value="Save" onclick=" return fnSave()" /> <html:button
							property="mode" title="View program linkage" styleClass="btext"
							value="View" onclick="return fnView()" /></td>


					</tr>
				</table>
				</td>
			</tr>
		</tbody>


	</table>

</html:form>

<%@ include file="/commons/rws_alert.jsp"%>


 