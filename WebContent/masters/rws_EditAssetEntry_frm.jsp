<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
 

function check()
{
  var assetTypeCode="<%=request.getParameter("typeOfAssetCode")%>";
  if(assetTypeCode=='04' || assetTypeCode=="HANDPUMPS"){
     document.forms[0].hablnk.disabled="true";
  }
} 

 
function getData()
{
       var assetTypeCode="<%=request.getParameter("typeOfAssetCode")%>";
   	   document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=disp&typeOfAssetCode="+assetTypeCode;
	   document.forms[0].submit();
	   
} 
function showComponents(that)
{
    var assetTypeCode="<%=request.getParameter("typeOfAssetCode")%>";
	var assetCompTypeCode=assetForm.compTypeCode.value;
	var assetSubCompTypeCode=that.value;
	 
	var habCode=assetForm.habCode.value;
  	if(assetSubCompTypeCode==""){
	 alert("Please Select Asset Sub Component");
	}else{ 
	  if((assetTypeCode=="01" || assetTypeCode=="04" )&& assetCompTypeCode=="01" && assetSubCompTypeCode=="001")
	  {
	   url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode;
	   window.open(url,"","width=595,height=330,left=230,top=100,scrollbars=1");
	  }
	  else{
	   url = "switch.do?prefix=/masters&page=/Asset.do&mode=params&assetCode="+assetForm.assetCode.value+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode+"&assetSubCompTypeCode="+assetSubCompTypeCode+"&habCode="+habCode;
	   window.open(url,"","width=530,height=180,left=230,top=250,scrollbars=1");
	  } 
    }	
}

function showAsset()
{
    var assetTypeCode="<%=request.getParameter("typeOfAssetCode")%>";
 
    url = "switch.do?prefix=/masters&page=/Asset.do?mode=hab&form=edit&dcode="+assetForm.dcode.value+"&district="+assetForm.district.value+"&habCode="+assetForm.habCode.value+"&assetTypeCode="+assetTypeCode+"&mandal="+assetForm.mandal.value ;
	window.open(url,"","width=600,height=400,left=100,top=100,scrollbars=1");
}
function fun()
{
	
	collex2(div2,f1.plus2);
	collex3(div3,f1.plus3);
	collex4(div4,f1.plus4);
	collex5(div5,f1.plus5);
	collex6(div6,f1.plus6);
	collex7(div7,f1.plus7);
	collex8(div8,f1.plus8);
	collex9(div9,f1.plus9);
	collex10(div10,f1.plus10);
	collex11(div11,f1.plus11);
}
var collapse1=true
var th1
function collex1(divId,imgId)
{
		if(collapse1)
		{
			th1 = divId.innerHTML
			var index = th1.indexOf("</THEAD>")
			var thead = th1.substring(0,index+8)
			thead = thead + "</table>"
			var len = thead.length
			var ind1 = thead.indexOf("collapse.gif")
			var ind2 = ind1 + 9
			var one = thead.substring(0,ind1)
			var two = thead.substring(ind2,len)
			thead = one + "expand." + two
			
			//imgId.src="./resources/images/expand.gif"
			divId.innerHTML = thead
			collapse1=false
		}
		else
		{	
			divId.innerHTML = th1
			imgId.src="<rws:context page='/images/collapse.gif'/>"
			collapse1=true
		}
}
var collapse2=true
var th2
function collex2(divId,imgId)
{
		if(collapse2)
		{
			th2 = divId.innerHTML
			var index = th2.indexOf("</THEAD>")
			var thead = th2.substring(0,index+8)
			thead = thead + "</table>"
			var len = thead.length
			var ind1 = thead.indexOf("collapse.gif")
			var ind2 = ind1 + 9
			var one = thead.substring(0,ind1)
			var two = thead.substring(ind2,len)
			thead = one + "expand." + two
			
			imgId.src="<rws:context page='/images/expand.gif'/>"
			divId.innerHTML = thead
			collapse2=false
		}
		else
		{	
			divId.innerHTML = th2
			imgId.src="<rws:context page='/images/expand.gif'/>"
			collapse2=true
		}
	
}
var collapse3=true
var th3
function collex3(divId,imgId)
{
		if(collapse3)
		{
			th3 = divId.innerHTML
			var index = th3.indexOf("</THEAD>")
			var thead = th3.substring(0,index+8)
			thead = thead + "</table>"
			var len = thead.length
			var ind1 = thead.indexOf("collapse.gif")
			var ind2 = ind1 + 9
			var one = thead.substring(0,ind1)
			var two = thead.substring(ind2,len)
			thead = one + "expand." + two
			
			imgId.src="<rws:context page='/images/expand.gif'/>"
			divId.innerHTML = thead
			collapse3=false
		}
		else
		{	
			divId.innerHTML = th3
			imgId.src="<rws:context page='/images/expand.gif'/>"
			collapse3=true
		}
	
}
var collapse4=true
var th4
function collex4(divId,imgId)
{
		if(collapse4)
		{
			th4 = divId.innerHTML
			var index = th4.indexOf("</THEAD>")
			var thead = th4.substring(0,index+8)
			thead = thead + "</table>"
			var len = thead.length
			var ind1 = thead.indexOf("collapse.gif")
			var ind2 = ind1 + 9
			var one = thead.substring(0,ind1)
			var two = thead.substring(ind2,len)
			thead = one + "expand." + two
			
			imgId.src="<rws:context page='/images/expand.gif'/>"
			divId.innerHTML = thead
			collapse4=false
		}
		else
		{	
			divId.innerHTML = th4
			imgId.src="<rws:context page='/images/collapse.gif'/>"
			collapse4=true
		}
	
}
//-->
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp" %>
<body onload="check()">

<html:form action="Asset.do?mode=edit" onsubmit="return validateAssetForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Entry Form" />
	<jsp:param name="TWidth" value="712" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="753">
<tr>
<td class="mycborder">
<fieldset>
<legend>Office Details</legend>
<label>
<table  border=0  width="100%">
<tr>
<html:hidden property="dcode"/>
 <html:hidden property="mandal"/>

<html:hidden property="coc"/>
<html:hidden property="doc"/>
<html:hidden property="sdoc"/>
<html:hidden property="habCode"/>
<html:hidden property="assetTypeCode"/>
 

	<td class=textborder >Circle</td>
	<td class=textborder >
	<html:text property="con"  styleClass="mytext" readonly="true"/></td>
	<td class=textborder >Division</td>

	<td class=textborder >
	<html:text property="don" styleClass="mytext"  readonly="true"/></td>
	<td class=textborder >Subdivision</td>
	<td class=textborder >
	<html:text property="sdon"   styleClass="mytext" readonly="true"/>
	</td>
	</tr>
	</table>
	</label>
	</legend>
	</fieldset>
 </td>
 </tr>
<td class="textborder">
<fieldset>
<legend>Habitation Details</legend>
<label>
 <table  border=0  width="100%">
<tr>
    <TD class="textborder" nowrap><bean:message key="app.district" /></TD>
    <TD class=textborder>
	<html:text property="district" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.mandal" /></TD>
    <TD class=textborder>
	<html:text property="mandalName" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.panchayat" /></TD>
    <TD class=textborder>
	<html:text property="pcode" styleClass="mytext"  readonly="true"/>
	</TD>
  </tr>
 
<tr>
    <TD class="textborder" nowrap><bean:message key="app.village" /></TD>
    <TD class=textborder>
	<html:text property="vcode" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.habCode" /></TD>
    <TD class=textborder>
	<html:text property="habName" styleClass="mytext"  readonly="true"/>
	</TD>
  </tr>
</table>
</label>
</fieldset>
</td>

 <tr>
<td class="textborder">
<fieldset>
<legend>Asset Details</legend>
<label>
	<table  border=0  width="100%">
	<tr>
	<TD class="textborder" nowrap>
	<bean:message key="app.assetTypeCode" /><font color="#FF6666">*</font>
	</TD>
    <TD class=textborder><html:text property="assetTypeName" styleClass="mytext" readonly="true"/></TD>
    <TD class="textborder" nowrap>
	<bean:message key="app.pumpCode" /><font color="#FF6666">*</font>
	</TD>
    <TD class=textborder><html:text property="pumpCode" styleClass="mytext" readonly="true"/></TD>
    </tr>
<tr>

    <TD class="textborder">
	<bean:message key="app.assetCode" /><font color="#FF6666">*</font>
	</TD>
	
    <TD class=textborder><html:text property="assetCode"  styleClass="mytext"   maxlength="14" readonly="true"/></TD>
	<TD class="textborder"  >
	<bean:message key="app.assetName" /><font color="#FF6666">*</font>
	</TD>
    <TD class=textborder><html:text property="assetName"  styleClass="mytext" maxlength="25" style="width:210px" onkeypress="upperOnly()"/></TD>
   
</tr>	
	
	<tr>
	 <TD class="textborder">
	<bean:message key="app.location" /><font color="#FF6666">*</font>
	</TD>
    <TD class=textborder><html:text property="location"  styleClass="mytext" maxlength="25" style="width:120px" onkeypress="upperOnly()"/></TD>
    
	
	<TD class="textborder"  >
	<bean:message key="app.dateofCreation" /><font color="#FF6666">*</font>
	</TD>
    <TD class=textborder><html:text property="dateofCreation"  styleClass="mytext" style="width:80px" />
	<a href="javascript: showCalendar(document.assetForm.dateofCreation);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></TD>
	<TD class="textborder"  nowrap>
	<bean:message key="app.assetCost" /><font color="#FF6666">*</font></TD>
    <TD class="textborder"><html:text property="assetCost" styleClass="mytext"  maxlength="10" style="width:70px"  onkeypress="return decimalsOnly(event)"/>&nbsp;(Rs.)</TD>
     
    </tr>
	<tr>
	<TD class="textborder">
	<bean:message key="app.startYear" /><font color="#FF6666">*</font></TD>
    <TD class=textborder><html:text property="startYear" styleClass="mytext"  maxlength="4" style="width:60px"/></TD>
	<TD class="textborder">
	<bean:message key="app.endYear" /><font color="#FF6666">*</font></TD>
    <TD class=textborder>
	<html:text property="endYear" styleClass="mytext"  maxlength="4" style="width:60px"  onkeypress="return decimalsOnly(event)"/>
	</TD>
	
	<td class="textborder" colspan=2    >
		<fieldset>
		<legend  >Habitation Linkage</legend>
		<label>
		<table  width="100%" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse">
		<tr>
		<td class="textborder">
		Habitations &nbsp;<input type="button" name="hablnk" value="..." style="width:20px;height:18px" onclick="showAsset()">
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
	</td>
    </tr>
   		<tr>
					<TD class="textborder"  >Asset Component Type
							<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
                     <logic:empty name="assetCompTypes">
 				                        <%//System.out.println("gg1"); %>
				         <select name="assetCompTypeCode" style="width:120px">
				         <option value="">SELECT...</option>
				         </select> 
				     </logic:empty>

                      <logic:notEmpty name="assetCompTypes">
				       <c:forEach items="${assetCompTypes}" var="item" varStatus="status">
				       <input type="radio" name="assetCompTypeCode"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getData()" value="<c:out value='${item.value}' />" /><font size="1" face="verdana"><b>&nbsp;<c:out value='${item.label}' /></b></font><br>
		                </c:forEach>
		              </logic:notEmpty>         
                      							  	
					  <logic:notEmpty property="assetCompTypeCode" name="assetForm">
					   <bean:define id="selectedCompTypeCode" property="assetCompTypeCode" name="assetForm"/>
					   <input type="hidden" name="compTypeCode" value="<bean:write name="selectedCompTypeCode"/>">
					  </logic:notEmpty>
					  
					  <logic:notEmpty property="assetSubCompTypeCode" name="assetForm">
					   <bean:define id="selectedSubCompTypeCode" property="assetSubCompTypeCode" name="assetForm"/>
					  </logic:notEmpty>
					   <script>
					   var assetCompTypeCode="";
					   var assetSubCompTypeCode="";
					   <logic:notEmpty property="assetCompTypeCode" name="assetForm">
					    assetCompTypeCode = "<bean:write name="selectedCompTypeCode"/>";
					   </logic:notEmpty>
					   <logic:notEmpty property="assetSubCompTypeCode" name="assetForm">
					    assetSubCompTypeCode = "<bean:write name="selectedSubCompTypeCode"/>";
					   </logic:notEmpty>
					   
					   if(assetCompTypeCode=="" && assetSubCompTypeCode=="")
           			   i=1;
           			   else
           			    for(i=1;i<=document.forms[0].elements.length;i++)
           			   {
             			    if(document.forms[0].elements[i].name!="undefined") {
           			          if(document.forms[0].elements[i].name=="assetCompTypeCode")
           			          {
           			            if(document.forms[0].elements[i].value==assetCompTypeCode)
           			              document.forms[0].elements[i].checked=true;
           			          }
           			          if(document.forms[0].elements[i].name=="assetSubCompTypeCode")
           			          {
           			            if(document.forms[0].elements[i].value==assetSubCompTypeCode)
           			              document.forms[0].elements[i].checked=true;
           			          }
           			        }    
           			   }
            			 
					   </script>
					   
 					  </TD>
				      <TD class="textborder"  >Asset Sub Component Type
							<font color="#FF6666">*</font>
					  </TD>
	                    
					    <TD class="bwborder">
					    <logic:empty name="assetSubCompTypes">
			 	         <select name="assetSubCompTypeCode" style="width:120px">
				         <option value="">SELECT...</option>
				         </select> 
				         </logic:empty>
				     
					   <logic:notEmpty name="assetSubCompTypes">
 					     <c:forEach items="${assetSubCompTypes}" var="item" varStatus="status">
				          <input type="radio" name="assetSubCompTypeCode"  style="width:12px;height:13px" styleClass="mytext" onclick="javascript:showComponents(this)" value="<c:out value='${item.value}' />" /><font size="1" face="verdana"><b>&nbsp;<c:out value='${item.label}' /></b></font><br>
		                </c:forEach>
                        </logic:notEmpty>
                        
						</TD>
						<TD class="textborder"  >Asset Status
							<font color="#FF6666">*</font>
						</TD>
						<td  class="bwborder"  >
						 	<html:select property="assetStatus" styleClass="mycombo">
							<html:option value="">SELECT...</html:option>
							<html:option value="1">WORKING</html:option>
							<html:option value="2">NOT WORKING</html:option>
							<html:option value="3">DRIED</html:option>
							<html:option value="4">SEASONAL</html:option>
							<html:option value="5">CONDEMED</html:option>
							</html:select>
						</td>	
					</tr>
    </table>
    
   

	
	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save an Asset" styleClass="btext" value="Save" onclick="return validateAsstForm(this)" />
	<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	</td>
	</tr>
	</table>
	
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="712"/>
</jsp:include>
<br>
<% int count=1; %>	
	<nested:iterate id="ASSETHAB_LIST" property="assetHabs">
     	<%count=count+1; %>
    </nested:iterate>
  	
<table width="580" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
<td colspan=2 align=left><b>Habatitaions in Asset</b>
</td>
</tr>
<tr bgcolor="#8A9FCD">
	<th colspan="2" align="left">
		Total No. of Habitations:&nbsp;<%= (count-1)%> 
	</th>
</tr>
 <tr bgcolor="#8A9FCD">
	<td class="textborder" align=center>
	 <bean:message key="app.panchCode" /></td>
	<td class="textborder" align=center>
	 <bean:message key="app.panchName" /></td>
	</tr>
</thead>
<tbody class="gridText">
 <% count=1; %>	
	<nested:iterate id="ASSETHAB_LIST" property="assetHabs">
   <tr class="row<%=count%2%>">
 	<%count=count+1; %>
	<td  class=bwborder align=center>
	<bean:write name="ASSETHAB_LIST" property="habCode" />
	</td>
	<td  class=bwborder align=left>
	<bean:write name="ASSETHAB_LIST" property="habName" />
	</td>
	</tr>
	</nested:iterate>
</tbody>
</table>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>