
<%//System.out.println("in addHabs.jsp"); %>
<%@ include file="/commons/rws_header1.jsp" %>
<head>
<script language="javascript">
<% //System.out.println("new is"+session.getAttribute("isNewHab")); %>
<!--
function getData()
{
	//alert("toDo is"+document.forms[0].toDo.value);
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=AddHabs";
	document.forms[0].submit();
	
}

function districtChanged()
{
	//alert("toDo is"+document.forms[0].toDo.value);
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=AddHabs&changed=district&toDo=selectDistrict";
	document.forms[0].submit();
	
}

function mandalChanged()
{
	//alert("toDo is"+document.forms[0].toDo.value);
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=AddHabs&changed=mandal&toDo=selectMandal";
	document.forms[0].submit();
	
}
<% if(((String)session.getAttribute("isNewHab")).equals("true"))
{ %>
	function savefunc()
	{
		if(document.forms[0].addHabsDistrict.value=="")
			alert("please select District");
		else if(document.forms[0].addHabsMandal.value=="")
			alert("please select Mandal");
		else if(document.forms[0].addHabsHabitation.value=="")
			alert("please select Habitation");
		else
		{
		
			var toDo="newHab";
			var assetTypeCode=document.forms[0].assetTypeCode.value;
			var assetCompTypeCode=document.forms[0].assetCompTypeCode.value;
			var assetSubCompTypeCode=document.forms[0].assetSubCompTypeCode.value;
			var habCode=document.forms[0].addHabsHabitation.value;
			var assetCode="<%=request.getParameter("assetCode")%>";
			
			//alert("toDo is"+document.forms[0].toDo.value);
			//document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=SaveHab";
				//document.forms[0].submit();
				
				window.opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do?mode=SaveHab&toDo="+toDo+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode+"&assetCode="+assetCode;
				window.opener.document.forms[0].submit();
				self.close();
				
		}
	}
<%}%>


</script>
 </head>

<html:form action="Asset.do">

<table cellpadding="0" cellspacing="0">
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Habitation Entry Form" />
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

<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
		   style="border-collapse:collapse">
<tr>
<td>
		<fieldset>
		<legend>Habitation Details</legend>
		<label>
		<table border=0 width="100%" align=center>
		<tbody class="formTBody">	
			<tr>
				<td width="200">
					<bean:message key="app.district" /><span class="mandatory">*</span>
				</td>
				<td width="150">
				<% if(((String)session.getAttribute("isNewHab")).equals("true"))
				{ %>
					<html:select property="addHabsDistrict" style="width:150px" styleClass="mycombo" onchange="districtChanged()" >
						<html:option value="">SELECT...</html:option>
						<html:options collection="dists" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
					</html:select>
				<%}
				else
				{ %>
				<html:text property="addHabsDistrictName" style="width:150px" styleClass="mycombo"  readonly="true"/>
				<%} %>
				</td>
				<html:hidden property="toDo" />
				<html:hidden property="assetTypeCode" />
				<html:hidden property="assetCompTypeCode" />
				<html:hidden property="assetSubCompTypeCode" />
				</tr>
				<tr>
				<td width="210">
					<bean:message key="app.mandal" /><span class="mandatory">*</span>
				</td>
				<td width="150">
				<% if(((String)session.getAttribute("isNewHab")).equals("true"))
				{ %>
				
					<html:select property="addHabsMandal" styleClass="mycombo" style="width:150px" onchange="mandalChanged()" >
						<html:option value="">SELECT...</html:option>
						<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
					</html:select>
				<%}
				else
				{ %>
				<html:text property="addHabsMandalName" styleClass="mycombo" style="width:150px"  readonly="true"/>
				<%} %>
				</td>
			</tr>
			<tr>
				
				
			</tr>
			<tr>	
				<td>
					<bean:message key="app.habCode" /><span class="mandatory">*</span>
				</td>
				<td colspan=3>
				<% if(((String)session.getAttribute("isNewHab")).equals("true"))
				{ %>
				
					<html:select property="addHabsHabitation" styleClass="mycombo" style="width:250px"   >
						<html:option value="">SELECT...</html:option>
						<html:options collection="prhabs" name="rwsLocationBean" property="habCode" labelProperty="habName" />
					</html:select>
				<%}
				else
				{ %>
				<html:text property="addHabsHabitation" styleClass="mycombo" style="width:250px" readonly="true"/>
				<%} %>
				</td>
			</tr>
			</tbody>
			</table>
			</label>
			</fieldset>
</td>
</tr>
<tr>
<td align="center">	
	<% if(((String)session.getAttribute("isNewHab")).equals("true"))
	{ %>
	<html:button property="save"  title="Save the Habitation" styleClass="btext" value="Save" onclick="savefunc()"/>
	<%} %>
	 <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>	
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>


