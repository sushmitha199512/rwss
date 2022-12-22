<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>

<%
//Debug.println("in adminstrative sanction.jsp");
String aa = (String)session.getAttribute("leadvalue");
session.setAttribute("leadvalue",aa);
String scheme= request.getParameter("typeOfAsset");
System.out.println("Type OF asset"+scheme);
session= request.getSession(true);
String proposalId=(String)session.getAttribute("proposalId");
//System.out.println("In Jsp ProposalID::"+proposalId);
ArrayList data=new ArrayList();
String sessionId=session.getId();
String tabName1="";

if(proposalId!=null){ %>
 <% 

int k=0;
	String code = proposalId.substring(6,8);
	if(!(code.equals("11")|| code.equals("12")))
				{
					tabName1 = "rws_hab_selected_temp_tbl";
				}
				else if(code.equals("11"))
				{
					tabName1 = "rws_sch_selected_temp_tbl";
				}
				else if(code.equals("12"))
				{
					tabName1 = "rws_lab_selected_temp_tbl";
				}
				
try{
   stmt=conn.createStatement();
  ResultSet rr= stmt.executeQuery("select * from  "+tabName1+"  where proposal_id='"+proposalId+"' and sid='"+sessionId+"'");

 while(rr.next())
{
     
        if(code.equals("12")){
         //System.out.println("lab comm");
data.add(rr.getString(2));		
}

else{
data.add(rr.getString(2)+"@"+rr.getString(3));	}

}

}catch(Exception e){
e.printStackTrace();
}
finally{

  

}


}
 //System.out.println("Data Size"+data.size());
String[] habsarray=new String[data.size()];
for(int i=0;i<data.size();i++){
 //System.out.println("Data:"+(String)data.get(i));

habsarray[i]=(String)data.get(i);     
}




//(String[])session.getAttribute("proposalsHabs");
String noOfHabs = "0";
if(habsarray!=null)
	noOfHabs = ""+habsarray.length;
int lengthHab = Integer.parseInt(noOfHabs);

System.out.println("Hab Count"+habsarray.length);


  %>
<script language="JavaScript">
<!--
var dExist='N';
function getWorkCategory()
{
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=workCategory";
	document.forms[0].submit();
}
function showFields()
{

	if(document.forms[0].wrktype[1].checked)
	{
		document.getElementById('mains2').style.display = 'block';
	}
	else
	{
	 	document.getElementById('mains2').style.display = 'none';
		document.forms[0].augsch.value='';
	}
	if(document.forms[0].typeOfAsset.value=='10')
	{
		document.getElementById('sustainDetails').style.display='block';
	}
	else
	{
		document.getElementById('sustainDetails').style.display='none';
	}
	
<%
if(request.getAttribute("resetForm") == null)
{%>
if(document.forms[0].typeOfAsset.value=="")
	{
	//document.forms[0].workCat.value="";
	}
<%}%>
if (document.forms[0].plan[0].checked)
	{
	document.forms[0].wrktype[0].disabled=false;
	document.forms[0].wrktype[1].disabled=false;
	document.forms[0].wrktype[2].disabled=true;
   	
	}
else if (document.forms[0].plan[1].checked)
	{
	document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=false;
	document.forms[0].wrktype[2].checked=true;
	}
else
{
    document.forms[0].wrktype[0].disabled=false;
	document.forms[0].wrktype[1].disabled=false;
	document.forms[0].wrktype[2].disabled=true;
}
	<%
	//Debug.println(request.getAttribute("duplicateExist"));
	if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("Y"))
	{
    %>
    if(confirm("WORK EXIST - With Same Plan,Category,\nScheme,Programme,SubProgramme,\nCircle,No.Of Habs,Amount and Date.\nDo You Still Want To Save It ?"))
    {
	   	document.getElementById('save').disabled=true;
		document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
		document.forms[0].submit();
	}
	<%
	}
	else if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("N"))
	{
    %>
    document.getElementById('save').disabled=true;
   	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
	document.forms[0].submit();
	<%
	}
	%>
}
function checkMe(type)
{
		if(type==0)
		{
		document.forms[0].wrktype[0].checked=true;
		}
		else if(type==1)
		{
		document.forms[0].wrktype[1].checked=true;
	    }
	    
}

function chkAll(len)
{
	for(var i=1;i<=len;i++)
	{
	 	document.getElementById('chk['+i+'].remove').checked=true;
	}
}
function clrAll(len)
{
	for(var i=1;i<=len;i++)
	{
	 	document.getElementById('chk['+i+'].remove').checked=false;
	}
}

function fnSubmit()
{
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnAddWork()
{
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=Add";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnRemove(that)
{
	var frm = that.form;
	var removeIds = frm.elements("remove");
	
	if(removeIds)
	{
		var len = removeIds.length;
		var count = 0;
		if(typeof len != "number")
			removeIds = [removeIds];
		for(var i=0; i<len; i++)
		{
			if(removeIds[i].checked)
		 		count++;
		}
		if(count == 0)
			alert("Please select atleast one work to remove!");
		else
		if(count == len)
			alert("You cannot remove all works!\nPlease de-select one work.");
		else		
		{
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
				+ "&mode=Remove";
			frm.action = url;
			frm.submit();		  
		}
	}
}
function fnGetOffices(that)
{
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=subdivisions";	
    frm.action = url;
	frm.submit();

}
function getScheme()
{
showFields();
document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=scheme";
document.forms[0].submit();
}

function getProgrammes()
{
	if(document.forms[0].typeOfAsset.value=='10')
	{
		document.forms[0].prooved.value='Sustainability';
		document.getElementById('sustainDetails').style.display='block';
	}
	else
	{
		document.forms[0].prooved.value='';
		document.getElementById('sustainDetails').style.display='none';
	}
	document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=programmes";
	document.forms[0].submit();
}
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}
function fnGetSubprogrammes1(elem)
{
	var index = elem.name.substr(5,1);
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=subprogrammes1"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

var newWindow;
function fnPickHabitations(index)
{
  
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	var subdivisionOfficeCode = document.getElementById("subdivisionOfficeCode").value;
	var prooved = document.getElementById("prooved").value;
	 

	if(coc == '')
		alert("Please select circle.");
	 	
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var assetcode=proposalId.substring(6,8);
		//alert(assetcode);
		var width = 1000;
		var height = 375;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/proposals&page=/PickAdminHabitation.do&mode=pickhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
				+ "&index="+index+"&assetcode="+assetcode+"&All=yes&subdivisionOfficeCode="+subdivisionOfficeCode+"&prooved="+prooved;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=no";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
}

function fnShowAugmentationWork(index)
{
    var workId= document.getElementById("WORK["+index+"].proposalId").value;
    var workName= document.getElementById("WORK["+index+"].proposalName").value;
     if(workId!='')
     {
	var checkField = document.getElementById("WORK["+index+"].augmentation");
	if(checkField.checked)
	{
		
		var proposalId = proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=Add New";
		var properties = "width=648,height=380,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=no";
		newWindow = window.open(url, "", properties);
	}
	}
	else{
	alert("Enter WorkId & Name");
	document.getElementById("WORK["+index+"].augmentation").checked=false;
	return;
	}
}
function validateWorks()
{
	var scheme=document.forms[0].typeOfAsset.value;
	var workCount = document.getElementById("workCount").value;
	var workName;
	var noOfHabs;
	var noOfLabs;
	var sancAmt;
	var adminNum;
	var adminDate;
	var estimateCostElem;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		workName = document.getElementById("WORK["+i+"].proposalName").value;
		noOfHabs = document.getElementById("WORK["+i+"].noOfHabs").value;
		sancAmt = document.getElementById("WORK["+i+"].sanctionAmout").value;
		adminNum = document.getElementById("WORK["+i+"].adminiStrativeNum").value;
		adminDate = document.getElementById("WORK["+i+"].adminiStrativeDate").value;
		estimateCostElem = document.getElementById("WORK["+i+"].estimateCost");

		if(workName.length == 0 || workName == '')
			message+="Work Name with S.No:" + (i+1) + " is required\n"; 
		//message+="Habitation(s) for work with S.No:" + (i+1) + " is required\n"; 
		if(sancAmt.length == 0 || sancAmt == '')
			message+="Sanction Amount with S.No:" + (i+1) + " is required\n"; 
		if(adminNum.length == 0 || adminNum == '')
					message+="Admin.Sanction Number with S.No:" + (i+1) + " is required\n"; 
		if(adminDate.length == 0 || adminDate == '')
					message+="Admin. Sanction Date with S.No:" + (i+1) + " is required\n"; 
   }
   var admDate=document.getElementById('WORK[0].adminiStrativeDate').value;
   var dt=admDate.split('/');
   var rdt=dt[1]+'/'+dt[0]+'/'+dt[2];
   var revdt = new Date(rdt);
   var sysdt = new Date();
   if (revdt.getTime() > sysdt.getTime())
 	{
 	 message+="Admin Sanction Date cannont be greater than Current Date.";
 	}
 	if(document.forms[0].wrktype[1].checked)
   	 {
   		if(document.forms[0].typeOfAsset.value!='10')
		{
			if(document.forms[0].augsch.value == null || document.forms[0].augsch.value == "")
	   		{
	   			message +="Please Select Augumentation Scheme";
	   		}
	   	}
	   	else
	   	{
	   		if(document.forms[0].sustainDetails.value=="")
	   		{
	   			message += "Please Select Sustainability Options for Sustainability Scheme";
	   		}
	   	}
   	 }
	if(message.length >0)
	{
		alert(message);
		return false;
	}
   	if(document.forms[0].typeOfAsset.value=='10')
	{
   		if(document.forms[0].sustainDetails.value=="")
   		{
   			message += "Please Select Sustainability Options for Sustainability Scheme";
   		}
   	}
	if(message.length >0)
	{
		alert(message);
		return false;
	}
	var lengthHabs = <%=noOfHabs%>;
	if(parseInt(lengthHabs)==0)
	{
		alert("Please Add Habitations/Schools/Labs");
		return false;
	}
  return true;
}
function fnView(that)
{
	var coc = document.getElementById("circleOfficeCode").value;
	if(coc=="")
	{
		alert("Select Circle");
	}
	else
	{
		var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=View";
			document.forms[0].action=url;
			document.forms[0].submit();
	}
}
function fnSave(that)
{ 
	//alert(document.forms[0].typeOfAsset.value);
	var scheme=document.forms[0].typeOfAsset.value;
	var leadradio;                                                     
    var sub=false;
   if(validateAdminstrativeSanctionForm(AdminstrativeSanctionForm))
	{
	if(validateWorks())
	 {
	  	sub=true;
	 }
	}
    if(sub)
	{
	if(dExist == 'N')
	{
		var checkLead = "false";
		var lengthHabs = <%=lengthHab%>;
			
		
		if(lengthHabs!="1" && (document.forms[0].typeOfAsset.value!="11" && document.forms[0].typeOfAsset.value!="12"))
		{
			for(var v=0;v<document.forms[0].leads.length;v++)
				{
				
					if(document.forms[0].leads[v].checked)
					{
				
						leadradio = document.forms[0].leads[v].value;
						checkLead="true";
					}
				}
					if(checkLead=="false")
				{
					alert("Select One of the Habitation as a Lead Habitation");
				}
				else
				{
		//			alert("Temporarily Freezed");
					if(document.forms[0].wrktype[0].checked)
					{
						if(confirm("Attention:\nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type"))
						{
							var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadhab="+leadradio+"&mode=Save";
							document.forms[0].action=url;
							document.forms[0].submit();
						}
					}
					else
					{
						var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
						document.forms[0].action=url;
						document.forms[0].submit();
					}
				}
		}
		else
		{
		//alert("Temporarily Freezed");
			if(document.forms[0].wrktype[0].checked)
			{
				if(confirm("Attention:\nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type"))
				{
					leadradio = document.forms[0].leads.value;
					var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			}
			else
			{
				leadradio = document.forms[0].leads.value;
				var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
				document.forms[0].action=url;
				document.forms[0].submit();
			}
		}
			
	}
    }
}


function showWorks()
{
	 var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks";
	 var width = 638;
	 var height = 332;
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
//-->
</script>
<body onload="showFields();">
<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="AdminstrativeSanctionSaveForm">

<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;<BR>
<a href="./help/AdminSanctionHelp.doc" target="_new"><img src="/pred/images/new1.gif" align="right" border=0><b>&raquo;&raquo;&raquo;Click for Help&laquo;&laquo;&laquo;</a></caption>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Administrative Sanction Form" />
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
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table>
		<tbody class="formTBody">
		<tr>
		<td class="column1"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		<logic:equal name="RWS_USER" property="headOfficeCode" value="0"> 
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual> 
		</td>
         <td class="column3">
         <html:radio value="1" property="plan" onclick="showFields();checkMe(0);getWorkCategory()"/>
		 Plan
         </td>
         <td class="class4">
         <html:radio value="2" property="plan" onclick="showFields();getWorkCategory();"/>
         Non-Plan
    	 </td> 
    	 </tr>
			<tr>
		<td class="column1">
		Work Category 
		<span class="mandatory">*</span></td>
         <td class="class2">
         <html:select property="workCat" styleClass="combo" onchange="JavaScript:getScheme();">
    		<html:option value="">SELECT...</html:option>
    		<logic:notEmpty name="workcategory1">
    		<html:options collection="workcategory1" name="labelValueBean" property="value" labelProperty="label" />
    		</logic:notEmpty>
    	</html:select>
    	</td>
    	<td class="column3">
			Scheme
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		 		<html:select property="typeOfAsset" styleClass="combo" onchange="getProgrammes();">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 		<logic:notEmpty name="assetTypes1">
			 		<html:options collection="assetTypes1" name="labelValueBean" property="value" labelProperty="label" />
			 		</logic:notEmpty>
			 	</html:select>
 		  </td>
 		  </tr>
 		  <tr>
 		  <td colspan=4>
 		  <div id="sustainDetails" style="display:none">
 		  <table align=right>
 		  <tr>
 		  <td><font face=verdana size=2><b>Sustainability Options<span class="mandatory">*</span></b></font></td>
 		  <td class="column3">
 		  <html:select property="sustainDetails" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="01">Infiltration Rings</html:option>
					<html:option value="02">Recharge Pits</html:option>
					<html:option value="03">Check Dams</html:option>
					<html:option value="04">Percolation Tanks</html:option>
					<html:option value="05">Sub-surface Dykes</html:option>
					<html:option value="06">Injection Wells</html:option>
					<html:option value="07">Rain Water Harvesting Structure</html:option>
					<html:option value="08">Soak Pit for Handpump</html:option>
					<html:option value="09">Removal of Defunct HP</html:option>
					<html:option value="10">Revival of Traditional Water Harvesting Structures</html:option>
					<html:option value="11">Ponds/Tanks</html:option>
					<html:option value="12">Others</html:option>
		  </html:select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  </td>
 		  </tr></table></div></td></tr>
 		  <tr>
          <td colspan="2" nowrap>
			<html:radio value="1" property="wrktype" onclick="getProgrammes();"/>
			MainScheme
           	<html:radio value="2" property="wrktype" onclick="checkMe(1);getProgrammes();"/>
           	Augmentation
			<html:radio value="3" property="wrktype" onclick="getProgrammes();"/>          
			Maintenance
            </td>
            <td colspan="2">
		   <div id="mains2" style="display:none">
			Augmentation Link<span class="mandatory">*</span>&nbsp;&nbsp;
			
				<html:text property="augsch" style="width:120px" styleClass="thin-text-box" readonly="true"/>
				<html:button property="mode" value="..." style="width:25px" styleClass="btext" title="Click Here"
								 onclick='<%= "javascript: showWorks()"%>' />
	       </div>
		</td>
		<tr>
		<td class="column1">
			Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
				<html:select property="programs" style="width:150px" styleClass="mycombo" onchange="javascript: fnGetSubprogrammes(this);checkLinkAug();" >
	            <html:option value=""><font class="myfontclr1">SELECT...</html:option>
	             <logic:present name="programmes1" >
	             <html:options collection="programmes1"  name="labelValueBean" property="value" labelProperty="label" />
        	     </logic:present>
	             </html:select>
		</td>
	 	<td class="column3">Sub Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
	 		<html:select property="subPrograms"  style="width:150px" onchange="javascript: fnGetSubprogrammes1(this)" styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:present name="SubPrograms1">
		 	<html:options collection="SubPrograms1" name="SubPrograms" property="value" labelProperty="label" />
			</logic:present>			  
	 		</html:select>
	 	</td>
		</tr>
		<tr>
        
	 	<td class="column1">
			<bean:message key="app.circle" />
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
			       <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
					<html:select property="circleOfficeCode" onchange="javascript:fnGetOffices(this)" styleClass="combo">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="circles1">
						<html:options collection="circles1" name="labelValueBean" property="value" labelProperty="label" />
						</logic:notEmpty>			  
					</html:select>
			        </logic:equal>
			        <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00"> 
					<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
					<html:hidden property="circleOfficeCode" name="RWS_USER" />
			        </logic:notEqual>
		</td>
		<td class="column3"><bean:message key="app.division"/>
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
			    <logic:equal name="RWS_USER" property="divisionOfficeCode"  value="0" >
				<html:select property="divisionOfficeCode" onchange="javascript:fnGetOffices(this);" styleClass="combo" >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="divisions1">
				<html:options collection="divisions1" name="labelValueBean" property="value" labelProperty="label" />
				</logic:notEmpty>			  
				</html:select>
			    </logic:equal>
			    <logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0" > 
				<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
			    </logic:notEqual>
		</td>
		</TR>
		<TR>	
		<td class="column1">SubDivision</td>
        <td class="column2">
    		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions1">
			<html:options collection="subdivisions1" name="labelValueBean" property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	</td>
	<td class="column1">Approved Under.....<span class="mandatory">*</span></td>
        <td class="column2">
			<html:select property="prooved" styleClass="combo" >
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<html:option value="Normal Coverage">Normal Coverage</html:option>
			<html:option value="Submission">Submission(Water Quality)</html:option>
			<html:option value="Sustainability">Sustainability</html:option>
			</html:select>
	</td>
		</tr>
	
	
	</tbody>
	
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
<!-- 	<%
	//System.out.println("type of asset:"+request.getParameter("typeOfAsset"));
	%> -->
	<td>
		<fieldset>
		<legend><bean:message key="legend.workDetails" /></legend>
		<label>
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th rowspan=2 nowrap>S. No.</th>
				<th rowspan=2><bean:message key="app.select" /></th>
				<th width="15%" rowspan=2>Work Id</th>
				<%if(request.getParameter("typeOfAsset")!=null && !((request.getParameter("typeOfAsset").equals("11") ||request.getParameter("typeOfAsset").equals("12"))))
				{%>
				<th rowspan=2>Select Habs</th>
				<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11"))
				{%>
				<th rowspan=2 >Select Schools</th>
				<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12"))
				{%>
				<th rowspan=2 >Select Labs</th> 
			<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("13"))
				{%>
				<th rowspan=2 >Select Offices</th> 
				<%}
				else{%>
				<th rowspan=2 >Select</th> 
				<%}%>
				<th rowspan=2><bean:message key="app.workName" /></th>
			  	<th rowspan=2>Sanctioned Amount(Rs. in Lakhs)</th>
			 	<th colspan=2  width="25%">Adminstrative Sanction </th>
		 		<th rowspan=2>More Than One Programme</th>
				<th rowspan=2><bean:message key="app.remarks" /></th>
			</tr>
			<tr>
			<th width="15%">Number</th>
			<th>Date</th>
			</tr>
			</thead>
			<tbody>
			<% int workCount = 0; int count=0,index=1;%>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				<td width="40px" align="center"><font face="verdana" size="2"><%=index++%></font>
				</td>
				<td width="40px" align="center">
					<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				<td>
					<nested:text name="WORK" property="proposalId" indexed="true" readonly="true"
							     style="width: 100px;text-align: center" styleClass="noborder-text-box"/>
				</td>
				<td nowrap>
					<nested:text name="WORK" property="noOfHabs" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 25px"/>
					<html:button property="addHab" value="..." styleClass="btext" onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
				</td>
				<td>
					<nested:text name="WORK" property="proposalName" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" />
				</td>
				<td>
					<nested:text name="WORK" property="sanctionAmout" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
				</td>
				<td>
					<nested:text name="WORK" property="adminiStrativeNum" indexed="true" maxlength="50" style="width: 100px;text-align: left" styleClass="noborder-text-box"/>
				</td>
				<td NOWRAP>
					<nested:text name="WORK" property="adminiStrativeDate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count++%>].adminiStrativeDate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
 				</td>
 				<td align="center">
					<nested:checkbox name="WORK" property="augmentation" value="Y" indexed="true" onclick='<%= "javascript: fnShowAugmentationWork(\"+ndx+\")"%>'/>
					<nested:hidden name="WORK" property="workId" indexed="true"/>
				</td>
				<td>
					<nested:text name="WORK" property="remarks" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
				</td>
			</tr>
			</nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			</tbody>
			</table>
			<table width="100%">
			<tr>
			<td align="left">
			<!-- <a href="#1" onclick="chkAll(<%=workCount%>)">Check All</a>&nbsp;&nbsp;
			<a href="#2" onclick="clrAll(<%=workCount%>)">Clear All</a>-->
			</td>
			<td align="right">
			<%
			int sp = 0;
			if(request.getAttribute("special") != null && !request.getAttribute("special").equals(""))sp = Integer.parseInt((String)request.getAttribute("special"));
		 %>

			</td>
			</tr>
			</tbody>
			</table>
		</label>
		</fieldset>
	
<%if(request.getParameter("typeOfAsset")!=null && !(request.getParameter("typeOfAsset").equals("11")  || request.getParameter("typeOfAsset").equals("12"))){ %>
	<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.habitationDetails" /></legend>
		<label>
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.leadHabitation" /></th>
				<th><bean:message key="app.habitationCode" /></th>
				<th><bean:message key="app.habitationName" /></th>
			</tr>
			</thead>
			<tbody class="gridText">
			<%
	if(habsarray!=null){
	if(habsarray.length==1)
			{
%>
			<tr>
			<td><input type="radio" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked></td>
			<td><%=habsarray[0].substring(0,16)%></td>
			<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
			</tr>
<%
			}
else
{
			 %>
			<%for(int i=0;i<habsarray.length;i++){ %>
			<tr>
			<td><input type="radio" name="leads" value="<%=habsarray[i].substring(0,16)%>"></td>
			<td><%=habsarray[i].substring(0,16)%></td>
			<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
			</tr>
			<%}} }%></tbody>
			</table></label>
		</fieldset></td>
	</tr>
<%} %>
			<%if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")) { %>
	<tr>
	<td>
		<fieldset>
		<legend>School Details</legend>
		<label>
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.habitationCode" /></th>
				<th>School Code-Hab Name-School Name</th>
			</tr>
			</thead>
			<tbody class="gridText">
			<%
				System.out.println("sddd"+habsarray.length);
			 	if(habsarray!=null){
				 if(habsarray.length==1)
			{
%>
			<tr>
			<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked>
			<td><%=habsarray[0].substring(0,16)%></td>
			<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
			</tr>
<%
			}
else
{
			 %>
			<%for(int i=0;i<habsarray.length;i++){ %>
			<tr>
			<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,16)%>">
			<td><%=habsarray[i].substring(0,16)%></td>
			<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
			</tr>
			<%}} }%></tbody>
			</table></label>
		</fieldset></td>
	</tr>
<%} %>
			
			
	</td>
	</tr>
<%if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")) { %>	<tr>
	<td>
		<fieldset>
		<legend>Lab Details</legend>
		<label>
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th>Lab Code</th>
				<th>Lab Name-Location</th>
			</tr>
			</thead>
			<tbody class="gridText">
			<%	System.out.println("Length:"+habsarray.length);
               if(habsarray!=null){
				if(habsarray.length==1)
			{
%>
			<tr>
			<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,2)%>" checked>
			<td><%=habsarray[0].substring(0,3)%></td>
			<td><%=habsarray[0].substring(3,habsarray[0].length())%></td>
			</tr>
<%
			}
else
{
			 %>
			<%for(int i=0;i<habsarray.length;i++){ %>
			<tr>
			<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,2)%>">
			<td><%=habsarray[i].substring(0,2)%></td>
			<td><%=habsarray[i].substring(3,habsarray[i].length())%></td>
			</tr>
			
			<%}}} %>
			</tbody>
			</table></label>
		</fieldset>
		</td>
	</tr>
		<%} %>
		
	<tr>
	<td>
		 <table width="100%">
		    <tr>
			<td align="center">
		  <input type="button" value="Save" name="save" class="btext" onclick="JavaScript:fnSave(this);">          
          <html:reset property="mode" styleClass="btext" onclick="Reset();">
					<bean:message key="button.clear" />
			</html:reset>
	      <input type="button" value="View" name="mode" class="btext" onclick="JavaScript:fnView(this);">          
			</td>
		    </tr>
		</table>
	</td>
	</tr>

	</table>
</td>
</tr>
</tbody>
</table>
 <html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER" />
<html:hidden property="officeCode" name="RWS_USER" />
<input type="hidden" name="special" value="">
</html:form>
</body>
<% 

if(session.getAttribute("flag")!=null && session.getAttribute("flag").equals("true"))
	{
 //System.out.println("Refreshing");
   session.removeAttribute("flag");
%>
<script>
		<!--
			alert("Processing...\nPlease wait...")
			document.location.reload();
		//-->
		</script>

	
		<!--   <meta http-equiv="refresh" content="0;"> -->
<%	} %>



<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
<%
	if(request.getAttribute("message")!= null)
	{
%>	
		<script>
		<!--
			alert("Processing...\nPlease wait...")
			document.location.reload();
		//-->
		</script>
		
<%	}
%>
<script>
document.getElementById("WORK[0].noOfHabs").value='<%=noOfHabs%>';
</script>