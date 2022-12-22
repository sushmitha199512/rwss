<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
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
	document.forms[0].action="/pred/smsmobile/TVM.do?mode=mandals";
	document.forms[0].submit();
}

function selectionChanged(mode)
{
	
	if(mode=="tanker")
	{
	var volunteercode=document.forms[0].volunteer[document.forms[0].volunteer.options.selectedIndex].value;
	if(volunteercode=="00")
		{
		mode="volunteer";
		document.forms[0].action="/pred/smsmobile/TVM.do?mode="+mode;
		document.forms[0].submit();	
		}
	else{
		document.forms[0].action="/pred/smsmobile/TVM.do?mode="+mode;
		document.forms[0].submit();
	}
	}
	else{
			document.forms[0].action="/pred/smsmobile/TVM.do?mode="+mode;
			document.forms[0].submit();
	}
		
}

function fnSave()
{
	if(checkTheBox()){
	document.forms[0].action="/pred/smsmobile/TVM.do?mode=save";
	document.forms[0].submit();
	document.forms[0].save.disabled=true;
	}
	else
	{
		return flase;
	}

}
function fnSaveedit()
{
	if(checkTheBox())
	{
	document.forms[0].action="/pred/smsmobile/TVM.do?mode=saveedit";
	document.forms[0].submit();
	document.forms[0].save.disabled=true;
	}
	else
	{
		return flase;
	}
}

function checkTheBox() 
{
	  
    var boxes=document.getElementsByName("mycheck");
    var e = document.getElementById("vol");
    var strUser = e.options[e.selectedIndex].value;
    if(strUser==""){
    	alert("Select  Volunteer...!");
    	return false;
    }else
    {
	var flag = 0;
	$.each(boxes, function(key, obj ) {
		
			if(boxes[key].checked){ 
				
				flag ++;
			} 	
	 });
	/* if (flag == 0) {
	      alert ("Please check atleast one tanker...!");
	      return false;
	    }else{
			return true;
	    } */
	
	 if (flag == 0) {
	      //alert ("Please check atleast one tanker...!");
	      return true;
	    }else{
			return true;
	    } 
	    
	//return true;
    }
  }
function viewfun(mode)
{
	if(document.forms[0].district.value!=""  && document.forms[0].mandal.value!="")
	{
		//var mode ="view";
		var x=document.getElementById("mandal");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var mandalName=x.options[x.selectedIndex].text;
		else
		var mandalName="";
		var x=document.getElementById("panchayat");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var panchayatName=x.options[x.selectedIndex].text;
		else
		var panchayatName="";
		var x=document.getElementById("village");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var villageName=x.options[x.selectedIndex].text;
		else
		var villageName="";
		document.forms[0].action="/pred/smsmobile/TVM.do?mode=view&mandalName="+mandalName+"&panchayatName="+panchayatName+"&villageName="+villageName;
		
		document.forms[0].submit();
	}
	else
	{
		alert("District is Required\nMandal is Required");

	}
}
</script>
</head>
<body> 
<html:form action="TVM.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Tanker Volunteer Mapping Form" />
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
		</tr>
		<tr>
			<td class="textborder">Habitation 
				<span class="mandatory">*</span>
			</td>
			<td>
				<html:select property="habitation" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('volunteer')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="habitations" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
					
				</html:select>
		</td>
		</tr>
				<%
				ArrayList volunteer1 = (ArrayList)request.getAttribute("volunteers");
				if(volunteer1!=null && volunteer1.size()!=0){
					
				
				%>
				<tr>
			<td class="textborder">Volunteer
				<span class="mandatory">*</span>
			</td>
			<td>
				<html:select property="volunteer" style="width:150px" styleId="vol"   styleClass="mycombo" onchange="selectionChanged('tanker')">
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					
					<html:options collection="volunteers" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
				<%}else{
					
					} %>
		   </td>
		   </tr>
		    <%
		    if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("tanker")){
		 ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		 if(list!=null&& list.size()!=0)
		 {
		  %>
		   <tr>
			<td class="textborder" >Tanker Details for Hab<span class="mandatory">*</span></td>
			
		</tr>
			<logic:iterate name="listfromAction" id="labelValueBean" >
		  <tr>
		  	<td class="textborder"></td>
 	<nested:notEqual property="tankerStatus" value="${labelValueBean.tankerStatus}">
 	<td class="textborder" ><input type="checkbox" name="mycheck"   checked="true" id="mycheckbox"  value=${labelValueBean.value}><bean:write name="labelValueBean" property="value"/></td>
 	    </nested:notEqual> 
    <nested:equal property="tankerStatus" value="${labelValueBean.tankerStatus}">
                      
     <td class="textborder" ><input type="checkbox" name="mycheck"    id="mycheckbox"  value=${labelValueBean.value}><bean:write name="labelValueBean" property="value"/></td>                             	                   	 
 	 </nested:equal>
		</tr>
		</logic:iterate>  
		
			<% }}
		 else
		 {}
		%>
		
		<%
		    if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("edit")){
		 ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		 if(list!=null&& list.size()!=0)
		 {
		  %>
		   <tr>
			<td class="textborder" >Tanker Details for Hab<span class="mandatory">*</span></td>
			
		</tr>
			<logic:iterate name="listfromAction" id="labelValueBean" >
		  <tr>
		  	<td class="textborder"></td>
 	<nested:notEqual property="tankerStatus" value="${labelValueBean.tankerStatus}">
 	<td class="textborder" ><input type="checkbox" name="mycheck"   checked="true" id="mycheckbox"  value=${labelValueBean.value}><bean:write name="labelValueBean" property="value"/></td>
 	    </nested:notEqual> 
    <nested:equal property="tankerStatus" value="${labelValueBean.tankerStatus}">
                      
     <td class="textborder" ><input type="checkbox" name="mycheck"    id="mycheckbox"  value=${labelValueBean.value}><bean:write name="labelValueBean" property="value"/></td>                             	                   	 
 	 </nested:equal>
		</tr>
		</logic:iterate>  
		
			<% }}
		 else 
		 {}
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
			 <%-- <% if(request.getAttribute("mode")!=null && !request.getAttribute("mode").equals("volunteer")&& request.getAttribute("mode").equals("tanker")){ %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
			<%} %> --%>
			
			 <%
		    if(request.getAttribute("mode")!=null && !request.getAttribute("mode").equals("volunteer")&& request.getAttribute("mode").equals("tanker")){
		     ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		         if(list!=null&& list.size()!=0)
		        {
		  %>
		  		<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
		  
		  
		  <%}else{%>
		  		  		<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()"  disabled='true'/>
		  
			  
		  <%}
		         } %>
		  
		   <%
		    if(request.getAttribute("mode")!=null && !request.getAttribute("mode").equals("volunteer")&& request.getAttribute("mode").equals("edit")){
		     ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		         if(list!=null&& list.size()!=0)
		        {
		  %>
		  
		  		<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSaveedit()" />
		  <%}
		         } %>
		  
		  <%
		  /* System.out.println("#####mode"+request.getAttribute("mode")); */
		  
		   ArrayList list = (ArrayList)request.getAttribute("listfromAction");
		  
		  if(request.getAttribute("mode")==null || !request.getAttribute("mode").equals("tanker")&& !request.getAttribute("mode").equals("edit")){ %>
			<html:button property="mode" title="View Mapped Tankers" styleClass="btext" value="View"   onclick="return viewfun('view')"/>
			<%}
		  else if(list.isEmpty())
			{
		  %>
			<html:button property="mode" title="View Mapped Tankers" styleClass="btext" value="View"   onclick="return viewfun('view')"/>
		  
		  
		  <%} %>
			</td>
		</tr>
		<%-- <% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("mandals")){ %>
			<html:button property="mode" title="Close The Form" styleClass="btext" value="Close"  onclick="javascript:funcClose()"/>
			<%}%>
		
		<%System.out.println("@#$%$$$$$$$mode"+request.getAttribute("mode")); %> --%>
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