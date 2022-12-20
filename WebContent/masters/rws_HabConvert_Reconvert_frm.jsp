<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<html>
<head>
<script language="javascript">

function getData()
{
	document.forms[0].action="/pred/masters/reconvertion.do?mode=new";
		document.forms[0].submit();	
	}

function getData1()
{
	document.forms[0].action="/pred/masters/reconvertion.do?mode=exist";
	document.forms[0].submit();	
}



function funcDistrictChanged()
{
	
	document.forms[0].action="/pred/masters/reconvertion.do?mode=exist&mode1=mandals";
	document.forms[0].submit();	
}
function funcDistrictChanged1()
{
	document.forms[0].action="/pred/masters/reconvertion.do?mode=new&mode1=mandals";
	document.forms[0].submit();	
}
function selectionChanged(mode)
{
	if(document.forms[0].panchayat)
	{
		
		document.forms[0].action="/pred/masters/reconvertion.do?mode=exist&mode1="+mode;
		document.forms[0].submit();
	}
}
function selectionChanged1(mode)
{
	if(document.forms[0].panchayat)
	{
		
		document.forms[0].action="/pred/masters/reconvertion.do?mode=new&mode1="+mode;
		document.forms[0].submit();
	}
}
function convertHab()
{
	
	
			var oldCode = document.getElementById("habCode").value;
			var newCode = document.getElementById("habitation1").value;
			var coveredStatus = document.getElementById("coveredStatus").value;
			
			
			
			document.forms[0].action="switch.do?prefix=/masters&page=/reconvertion.do&mode=convert&oldCode="+oldCode+"&newCode="+newCode+"&coveredStatus="+coveredStatus;
			document.forms[0].submit();
			
		}
	

 function ajaxFunction(URL,divobj)
		{ 
			if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
			var xmlHttp;
			try{
				xmlHttp=new XMLHttpRequest();    
			}
			catch (e){    
				try{
					xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
				}
				catch (e){
				  try{
					  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
				  }
				  catch (e){
					  alert("Your browser does not support AJAX!");        
					  return false;        
				  }      
				}    
			}
			if (xmlHttp==null)
			{
			  alert ("Your browser does not support AJAX!");
			  return;
			} 
			xmlHttp.onreadystatechange=function()
			{
			  if(xmlHttp.readyState==4)
			  {
				alert(xmlHttp.responseText);
				document.getElementById('load').style.display='none';
				document.getElementById('convert').style.display='block';
				document.getElementById('convertReport').style.display='block';				
			  }
			  else{
				  document.getElementById('convert').style.display='none';
				  document.getElementById('load').style.display='block';
				  document.getElementById('convertReport').style.display='none';		
			  }
			}
			xmlHttp.open("GET",URL,true);
			xmlHttp.send(null);  
		}
</script>
</head>
<body> 
<html:form action="reconvertion.do">
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
<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
			
			</tr>  
		</table>
	</caption>

</table>
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
		<jsp:param name="TableName" value="Habitation ReOrganisation Form" />
		<jsp:param name="TWidth" value="100%" />
		<jsp:param name="contextHelpUrl" value="/pred/help/Hab.doc" />
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
	   style="border-collapse:collapse;" width="920" >
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.rwsOffices"/></legend>
	<label>
	<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" 
	   style="border-collapse:collapse;" width="920" >
	   <tr>
			<td class="textborder" align="center" width="450">Existing Hab Info</td>
			<td class="textborder" align="center" width="20">&nbsp;</td>
			<td class="textborder" align="center" width="450">New Hab Info</td>
		</tr>
	<tr>
    <td><table  border=0  width="450">
      <tr>
        <td class="textborder">District <span class="mandatory">*</span> </td>
        <td class="textborder"><html:select property="district" style="width:300px"  onchange="javascript:getData1()" styleClass="mycombo">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Mandal <span class="mandatory">*</span> </td>
        <td><html:select property="mandal" style="width:300px"    styleClass="mycombo" onchange="javascript:getData1()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="mandals1" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Panchayat <span class="mandatory">*</span> </td>
        <td><html:select property="panchayat" style="width:300px"    styleClass="mycombo" onchange="javascript:getData1()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="panchayats1" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Village <span class="mandatory">*</span> </td>
        <td><html:select property="village" style="width:300px"    styleClass="mycombo" onchange="javascript:getData1()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="villages1" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Habitation Name <span class="mandatory">*</span> </td>
        <td><html:select property="habCode" style="width:300px"    styleClass="mycombo" onchange="javascript:getData1()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="habitations1" name="labelValueBean" 
								  property="habCode" labelProperty="panchayatName" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Habitation Code <span class="mandatory">*</span> </td>
        <td><html:text property="habCode" style="width:300px"  readonly="true"/>
        </td>
      </tr>
      <!--
      <tr>
        <td class="textborder">Coverage Status<span class="mandatory">*</span> </td>
        <td><input type=text name="oldStatus" style="width:300px" readonly value="UI"/>
        </td>
      </tr>
    -->
    </table></td>
    <td width="20">&nbsp;</td>
    <td><table  border=0  width="450">
      <tr>
        <td class="textborder">District <span class="mandatory">*</span> </td>
        <td class="textborder"><html:select property="district1" style="width:300px" onchange="javascript:getData()" styleClass="mycombo">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="districts1" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Mandal <span class="mandatory">*</span> </td>
        <td><html:select property="mandal1" style="width:300px"    styleClass="mycombo" onchange="javascript:getData()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="mandals2" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Panchayat <span class="mandatory">*</span> </td>
        <td><html:select property="panchayat1" style="width:300px"    styleClass="mycombo" onchange="javascript:getData()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="panchayats2" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Village <span class="mandatory">*</span> </td>
        <td><html:select property="village1" style="width:300px"    styleClass="mycombo" onchange="javascript:getData()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="villages2" name="labelValueBean" 
								  property="value" labelProperty="label" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Habitation Name <span class="mandatory">*</span> </td>
        <td><html:select property="habitation1" style="width:300px"    styleClass="mycombo" onchange="javascript:getData()">
            <html:option value="">
              <bean:message key="app.pleaseSelect" />
            </html:option>
            <html:options collection="habitations2" name="labelValueBean" 
								  property="habCode" labelProperty="panchayatName" />
          </html:select>
        </td>
      </tr>
      <tr>
        <td class="textborder">Habitation Code <span class="mandatory">*</span> </td>
        <td><html:text property="habName1" style="width:300px"   readonly="true"/>
        </td>
      </tr>
      <tr>
        <td class="textborder">Coverage Status <span class="mandatory">*</span> </td>
        <td><html:select property="coveredStatus" style="width:300px"    styleClass="mycombo" onchange="javascript:getData()">
            <html:option value="LAST">Last Year</html:option>
            <html:option value="PC1">PC1</html:option>
            <html:option value="PC2">PC2</html:option>
			<html:option value="PC3">PC3</html:option>
			<html:option value="PC4">PC4</html:option>
			<html:option value="FC">FC</html:option>
			<html:option value="NSS">NSS</html:option>
			<html:option value="NC">NC</html:option>
          </html:select>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr>
	<td>
		<table width="100%">
			<tr><td class="textborder" align=center>
				<div id="convert" style="position:relative;overflow-y:auto;left:10;height:20;width:270;top:1;display:block">
					<input type="button" name="submits" class="btext" value="Copy&nbsp;&nbsp;&gt;&gt;&gt;&gt;" onclick="convertHab()"/>
				</div>
				
				<div id="load" style="position:relative;overflow-y:auto;left:10;height:20;width:270;top:5;display:none"><img src="../images/loader-3.gif"/></div>				
			</td></tr>
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
	</html>
<%@ include file="/commons/rws_alert.jsp"%>	
<%//String mes=(String)request.getAttribute("message");
//System.out.println("mes"+mes);%>	



