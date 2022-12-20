<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String dname_in_telugu=(String)session.getAttribute("dname_in_telugu");
//System.out.println("$$$$$$$$$$"+dname_in_telugu);
String dname_in_telugu = "";
if(request.getAttribute("dname_in_telugu") != null)
dname_in_telugu=request.getAttribute("dname_in_telugu").toString();

String mname_in_telugu = "";
if(request.getAttribute("mname_in_telugu") != null)
mname_in_telugu=request.getAttribute("mname_in_telugu").toString();
String pname_in_telugu = "";
if(request.getAttribute("pname_in_telugu") != null)
pname_in_telugu=request.getAttribute("pname_in_telugu").toString();
String vname_in_telugu = "";
if(request.getAttribute("vname_in_telugu") != null)
vname_in_telugu=request.getAttribute("vname_in_telugu").toString();
%>
<head>
<script language="javascript">
function funcClose()
{
	if(typeof(window.opener)!="undefined") 
	{
		//alert("child");
		self.close();
	}
	else
	{
		//alert("parent");
		winClose();
	}

}
function funcDistrictChanged()
{
	document.forms[0].action="/pred/smsmobile/TeluguTranslation.do?mode=mandals";
	document.forms[0].submit();
}

function selectionChanged(mode)
{
	
	
			document.forms[0].action="/pred/smsmobile/TeluguTranslation.do?mode="+mode;
			document.forms[0].submit();
	
		
}

function fnSave()
{
	
	document.forms[0].action="/pred/smsmobile/TeluguTranslation.do?mode=save";
	document.forms[0].submit();
	document.forms[0].save.disabled=true;
	

}




</script>
</head>
<body> 
<html:form action="TeluguTranslation.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Telugu Translation Form" />
		<jsp:param name="TWidth" value="100%" />
			<jsp:param name="contextHelpUrl" value="/pred/help/Tanker_Volunteer_mapping_form.docx" />
 	
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
	   style="border-collapse:collapse;" width="350" >
<tr>
<td>
		<%-- <input type="hidden" name="prevMode" value=<%=request.getAttribute("mode") %> > --%>
		<fieldset>
		<label>
		<table  border=0  width="100%">
		<tr>
			<td class="textborder">District
			<span class="mandatory">*</span>
		</td>
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="district" style="width:150px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="districtName" styleClass="mytext" style="width:150px"
						    readonly="true" />
				<html:hidden property="district" />
			</logic:notEqual>
		</td>
<!-- 		 <td class="textborder" ><input type="text" property="tlabel"   id="tlabel"  ></td> 
 -->		<td class="textborder" > <input type="text" id="dname_in_telugu"  name="dname_in_telugu" style="width:150px"    value="<%=dname_in_telugu%>"  disabled="true"/></td>
		 <%-- <td><html:text property="tlabel" styleClass="mytext" style="width:150px" /></td>  --%>
		</tr>
		<tr>
		</tr>
		<tr>
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="mandal" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('panchayats')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		<!-- <td class="textborder" ><input type="text"    id="DIS"  ></td> -->
		<td class="textborder" > <input type="text" id="mname_in_telugu"  name="mname_in_telugu" style="width:150px"  maxlength="100"  value="<%=mname_in_telugu%>" /></td>
		</tr>
		<tr>
			<td class="textborder">Panchayat
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="panchayat" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('villages')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
				<td class="textborder" > <input type="text" id="pname_in_telugu"  name="pname_in_telugu" style="width:150px"  maxlength="100"   value="<%=pname_in_telugu%>" /></td>

		</tr>
		<tr>
			<td class="textborder">Village
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="village" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('habitations')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="villages" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		<!-- <td class="textborder" ><input type="text"    id="DIS"  ></td> -->
						<td class="textborder" > <input type="text" id="vname_in_telugu"  name="vname_in_telugu" style="width:150px"  maxlength="100"  value="<%=vname_in_telugu%>" /></td>
		
		</tr>
		<tr>
			<td class="textborder" >Habitations<span class="mandatory">*</span></td>
			
		</tr>
		
		<% 
		ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		 if(list!=null&& list.size()!=0)
		 {%>
		 
			 <logic:iterate name="listfromAction" id="labelValueBean" >
			 
			  <tr>
			 <!--  <td class="textborder">Habitations
			<span class="mandatory">*</span>
		</td> -->
			  	<td class="textborder"></td>
<%-- 	 		 	<td class="textborder" ><input type="text"    id="arokya"  value=${labelValueBean.value}><bean:write name="labelValueBean" property="value"/></td>
 --%>	 	
	 	<td class="textborder" >
	 	<input type="hidden"    id="habCode"  name="habCode" value="${labelValueBean.value}">
	 	<%--  <html:hidden property="${labelValueBean.labelValue}" styleClass="mytext" style="width:150px"/> --%> 
	 	<input type="text"    id="habNameInEnglish" name="habNameInEnglish" value="${labelValueBean.label}"></td>
	 	<td class="textborder" ><input type="text"    id="habNameInTelugu"  name="habNameInTelugu"  maxlength="100"  value="${labelValueBean.tlabels}"></td>
	 	
	 	    
	    
			</tr>
			</logic:iterate> 
			
		<% }
		 else
		 {
				//System.out.println("nooooooo"); 

		 }
		 //System.out.println(" ^&^^ dname_in_telugu :"+request.getAttribute("dname_in_telugu") );   
		%>
		
		
		
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		                    <%
								String csrfToken = "";
								nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
								csrfToken = valUtil.getCSRFCode();
								session.setAttribute("csrfToken", csrfToken);
							%>
							<html:hidden property="token" styleClass="mytext"	value="${sessionScope.csrfToken}" />
		<tr>
	<td>
		<table width="100%">
		<tr>
			<td class="textborder" align=center>
		  <% 
		 if(list!=null&& list.size()!=0)
		 {%>
		  
		  <html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
		<%   }else{%>
				  		  		<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()"  disabled='true'/>
		
		<%} %>
		  

		</table>
	</td>
	</tr>
		</table>
		</td>
		</tr>
		</tbody>
		</table>
		</html:form>
	</body>
<%@ include file="/commons/rws_footer.jsp"%>
 <%@ include file="/commons/rws_alert.jsp"%>	 	 