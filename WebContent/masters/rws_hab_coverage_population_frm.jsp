<%@ include file="/commons/rws_header1.jsp" %>

<% 
RwsUser user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
	  response.sendRedirect("unAuthorise.jsp");	
}


String showDiv = (String)request.getAttribute("showDiv");
if(showDiv==null)showDiv="false";
java.util.ArrayList aaa = (java.util.ArrayList)session.getAttribute("mandals");

int workCount = 0;%>
<html:javascript formName="mandalSubdivisionForm" />
<SCRIPT LANGUAGE="JavaScript">

function autocompletion()
{
       for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function fnchkdelete()
{
	if(document.forms[0].vname.value=="")
	{
		alert("Please Map the Village with Census Village");
	}
	else
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=saveHabData";
    	document.forms[0].submit();
    }
}
function habListHide()
{
	document.getElementById('habList').style.display='none';
}
function fnSave()
{
	//alert("in save");
	var qastatus = new Boolean(false);
	//alert("length:"+document.forms[0].checks.length);
	if(document.forms[0].checks.length==undefined)
	{
		//alert("undef");
		if(document.forms[0].checks.checked==false)
		{
			alert("Select Record to Save");
		}
		else
		{
			document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=saveHabData";
			document.forms[0].submit();	
		}
	}
	else
	{
		for (i=0; i<document.forms[0].checks.length; i++)
		{
			if (document.forms[0].checks[i].checked==true)
				qastatus = true;
		}
		if(qastatus==true)
		{
			document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=saveHabData";
			document.forms[0].submit();	
		}
		else
			alert("Select Records to Save");
	}
}
function init()
{
	//alert("in init");
	var sd = '<%=showDiv%>';
	//alert(sd);
	if(sd=="true")
	{
		document.getElementById('habList').style.display='block';
	}
	
}
function showDetails()
{
	//document.getElementById('habList').style.display='block';
	var district = document.forms[0].coc.value;
	if(document.forms[0].coc.value!="" && document.forms[0].doc.value!="" && document.forms[0].sdoc.value!="" && document.forms[0].mandal.value!="")
	{
		return true;
	}
	else
		return false;
	
}
function resetfn()
{
if(mandalSubdivisionForm.district.value!="")
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=resetForm";
	document.forms[0].submit();
	}
}

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=data1";
	document.forms[0].submit();
}
function viewfun()
{
  document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=View";
  document.forms[0].submit();
}
var newWindow;
function showHabsForMandal()
{
	 var url = "switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=showMandals&coc="+ document.forms[0].coc.value+"&doc="+ document.forms[0].doc.value;
	 var width = 538;
	 var height = 532;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="init();autocompletion();">
<html:form action="/MandalSubdivision.do?mode=showData" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Habitation Status Coverage By Population" />
	<jsp:param name="TWidth" value="907" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
		style="border-collapse:collapse;"  width="890" >
<tr>
<td>
	<table  border=0  width="850"  align=center  style="margin-bottom:5;margin-top:5">
		<tr>
			<td  class="textborder" >
				District<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="coc" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="circles" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
			<td  class="textborder" >
			Mandal<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="doc" style="width:170px" 
							 styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="mandals" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		
			<td  class="textborder" >
				Panchayat<font color="#FF6666">*</font>
			</td>
			<td  class="textborder">
				<html:select property="sdoc" style="width:170px" styleClass="mycombo" onchange="javascript:getData()" >
				<html:option value="">SELECT...</html:option>
				<html:options collection="panchayats" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
			<td  class="textborder" >
				Village<font color="#FF6666">*</font>
			</td>
			<td  class="textborder" >
				<html:select property="mandal" style="width:170px" 
							 styleClass="mycombo" onchange="habListHide()">
				<html:option value="">SELECT...</html:option>
				<html:options collection="villages" name="labelValueBean" 
							  property="value" labelProperty="label" />
				</html:select>
			</td>
		</tr>
	</table>
	

	<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Show" onclick="return showDetails()"/>
	</td>



</tr>
<tr>
	<td>
	<div id="habList" style="display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" width="940" align="center" style="border-collapse:collapse;" >
		 <tr>
		 <%//System.out.println("disableStaus:"+session.getAttribute("disableStatus"));
		 if(session.getAttribute("disableStatus")!=null && session.getAttribute("disableStatus").equals("false")){ %>
		 <td  style="width:940" colspan="8" class="textborder"><html:checkbox property="main"/>Is it main village of the panchayat 
		 <%}
		 else
		 {
		 %>
		<td  style="width:940" colspan="8" class="textborder"><html:checkbox property="main" disabled="true"/>Is it main village of the panchayat 		 
		 <%
		 } %>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		CensusVillage Name
		<html:text property="vname" styleClass="mytext" style="width:150px" readonly="true"/>
		<html:hidden property="vcode"/>
		<a href="#" onclick="javascript:showHabsForMandal()">Map This Village </a>
	<%
		//System.out.println("request.getParameter():"+request.getParameter("vname"));
		
		//if(request.getParameter("vname") == null || request.getParameter("vname").equals("")){%>
	   <!-- <a href="#" onclick="javascript:showHabsForMandal()">Map This Village </a> -->
	<%//}*/%>
		 </td>
		 </tr>
		 
		 
		 <% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
		 <tr>
	<td align="center">
		<html:button property="butt" value="Save" onclick="fnchkdelete()"/>
	</td>
	</tr>
		</table>
	</div>
	</td>
	</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="907"/>
</jsp:include>
<script>
function calTot()
{
	var sc=0,st=0,plain=0,total=0;
	var sc1=0,st1=0,plain1=0,total1=0;
	for(var j=0;j<<%=workCount%>;j++)
	{
		sc=sc+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].scPop").value);
		st=st+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].stPop").value);
		plain=plain+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].plainPop").value);
		document.getElementById("WORKEXP_LIST["+j+"].totalPop").value = parseFloat(document.getElementById("WORKEXP_LIST["+j+"].scPop").value)+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].stPop").value)+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].plainPop").value);
		total=total+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].totalPop").value);
		//alert("sdfs");
		sc1=sc1+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].scCov").value);
		st1=st1+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].stCov").value);
		plain1=plain1+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].plainCov").value);
		document.getElementById("WORKEXP_LIST["+j+"].totalCov").value = parseFloat(document.getElementById("WORKEXP_LIST["+j+"].scCov").value)+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].stCov").value)+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].plainCov").value);
		total1=total1+parseFloat(document.getElementById("WORKEXP_LIST["+j+"].totalCov").value);
		//alert(sc1);
	}
//	alert("sdfsdf:"+sc1)
	document.forms[0].sc.value=sc;
	document.forms[0].st.value=st;	
	document.forms[0].plain.value=plain;
	document.forms[0].tot.value=total;
	document.forms[0].sc1.value=sc1;
//	alert(document.forms[0].sc1.value);
	document.forms[0].st1.value=st1;
	document.forms[0].plain1.value=plain1;	
	document.forms[0].tot1.value=total1;
}
function checkQP()
{	
	var qastatus = new Boolean(false);
	for(var j=0;j<<%=workCount%>;j++)
	{
		
		if(document.getElementById("WORKEXP_LIST["+j+"].qp1").checked == true || document.getElementById("WORKEXP_LIST["+j+"].qp2").checked == true || document.getElementById("WORKEXP_LIST["+j+"].qp3").checked == true || document.getElementById("WORKEXP_LIST["+j+"].qp4").checked == true)
		{		
			document.getElementById("WORKEXP_LIST["+j+"].qa").checked = true;	
		}
		else
		{
			document.getElementById("WORKEXP_LIST["+j+"].qa").checked = false;
		}
	}

}
</script>
<input type="hidden" name="resultCount" value="<%=workCount%>">
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>