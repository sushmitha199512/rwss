<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</STYLE>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>

<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>


function fnSave()
{
	
    var habitations1="";
	//var district='<%=request.getParameter("dist")%>';
	//var mandal='<%=request.getParameter("mand")%>';
	var habcode='<%=request.getParameter("circleCode")%>';
	//alert(habcode);
    
	
    var len=document.forms[0].resultCount.value;
    //alert(len)
	
		//alert(len);
	len = len-1;
	
    
	
	for( var j=0;j<len;j++)
	{     

		
		if(document.forms[0].elements["COMPLIST["+j+"].checks"].checked==true)
		{
		//alert("fsdfsd");
		//alert(habitations1);
				 

				habitations1=habitations1+document.forms[0].elements["COMPLIST["+j+"].testId"].value;
habitations1=habitations1+","+document.forms[0].elements["COMPLIST["+j+"].sourceCode"].value;
habitations1=habitations1+","+document.forms[0].elements["COMPLIST["+j+"].actionTaken"].value;
habitations1=habitations1+","+document.forms[0].elements["COMPLIST["+j+"].remarks"].value;
habitations1=habitations1+","+document.forms[0].elements["COMPLIST["+j+"].parameter1"].value;

habitations1=habitations1+","

//alert(habitations1);

var s=document.forms[0].elements["COMPLIST["+j+"].testId"].value;
//alert(s);






		     }
			 
			 
	}
	habitations1=habitations1+"D,";
	
	  if(habitations1=="D,")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	   
	     if(confirm("Are You Sure To Save The Checked Sources")) {
			  document.forms[0].hab1.value = habitations1;
	          document.forms[0].action="switch.do?prefix=/wquality&page=/WQAsset.do&mode=save&testId="+s;
         document.forms[0].submit();
			}
	  }
}






function getData2()
{
	
	document.forms[0].action="switch.do?prefix=/wquality&page=/WQAsset.do&mode=data";
    document.forms[0].submit();
}
function getData3()
{
	
	document.forms[0].action="switch.do?prefix=/wquality&page=/WQAsset.do&mode=ongoingdata";
    document.forms[0].submit();
}

</script>
<%

	 
	 	int count = 1;
 %>

<body  onload="javascript:init();">

<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/WQAsset.do">

<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Quality Asset  Status Entry Form " />
	<jsp:param name="TWidth" value="960" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
			<td class="textborder" >
<tr>
<td>
   <fieldset>
   
   <legend><b>Details</b><span class="mandatory">*</span></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    <tr>
	    <td class="btext2" width="100">Circle<font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="circleCode" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="circles">
		<html:options collection="circles" name="rwsLocationBean" property="value" labelProperty="label" />
		</logic:present >
		</html:select>
		</td><td class="btext2" width="100">
	Division<font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="divisionCode" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="divisions">
			<html:options collection="divisions" name="rwsLocationBean" property="value" labelProperty="label" />
            </logic:present >
			</html:select>
	</td>
		<td class="btext2" width="100">
	Sub Division<font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="subdivisionCode" styleClass="mycombo" style="width:130px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="subdivisions">
		<html:options collection="subdivisions" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
	<td class="btext2" width="100">
	Test Type<font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="testType" styleClass="mycombo" style="width:130px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="testtypes">
		<html:options collection="testtypes" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
	</tr>
	<tr>
		<td class="btext2" width="100">
	Source Type<font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select   property="assetType" styleClass="mycombo"   style="width:150px" onchange="javascript:getData2()">
		<html:option value="">SELECT</html:option>
		<html:option value="SO"><font class="myfontclr1">Sources</html:option>
		
		<html:option value="HP"><font class="myfontclr1">Handpumps</html:option>
		<html:option value="SH"><font class="myfontclr1">Shallow Handpumps</html:option>
		<html:option value="OW"><font class="myfontclr1">Open Wells</html:option>
		<html:option value="PD"><font class="myfontclr1">Ponds</html:option>
		</html:select>
		</td> 

		
	
	<td class="btext2" >Financial Year<font color="#FF6666">*</font><font color="#FF6666"></font>

<td class="textborder" ><font color="#FF6666"></font>
    <html:select property="finYear" style="width:135px" styleClass="mycombo"   onchange="javascript:getData3()">

	<logic:present name="expyears">
	<html:option value="">SELECT</html:option>	
	<html:options collection="expyears" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	
	</html:select>
	</td>
</td>
</tr>
		
	<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="10">Water Quality Assets Contaminanted List </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					<td class=clrborder align=center nowrap>Test Id</td>
                    <td class=clrborder align=center nowrap>Source Code</td>
                    <!-- <td class=clrborder align=center nowrap>Potable</td> -->
                    <td class=clrborder align=center nowrap>Action Taken</td>
                     <td class=clrborder align=center nowrap>Date</td>
                  <td class=clrborder align=center nowrap>Testing Parameter Name</td>
                    
                      <!--    <td class=clrborder align=center nowrap>Min Permissible Value</td>
                     <td class=clrborder align=center nowrap>Max Permissible Value</td>
                     <td class=clrborder align=center nowrap>Result</td>-->
                     
                     <td class=clrborder align=center nowrap>Remarks</td>
                     

				</tr>
				<%
try{
	
java.util.Collection a = (java.util.Collection)session.getAttribute("sources"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<nested:iterate id="COMPLIST" name="sources" indexId="ndx">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		<td >
      	<html:checkbox name="COMPLIST" property="checks"   indexed="true"  />
	    </td>

		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="testId" indexed="true" /> <nested:write
		name="COMPLIST" property="testId" /></td>
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="sourceCode" indexed="true" /> <nested:write
		name="COMPLIST" property="sourceCode" /></td>
		<%
		String type=(String)session.getAttribute("type");
		System.out.println("type<<<<<<<<"+type);%>
		
		<td class="rptValue" align=center>
		<html:select name="COMPLIST"  property="actionTaken" styleClass="mycombo" indexed="true"  style="width:150px">
		<html:option value="">SELECT</html:option>
		<%if(type!=null && type.equals("1")){ %>
		<html:option value="Put X"><font class="myfontclr1">Put"X" mark with red colour on H.P.indicating not suitable for drinking purpose and suitable for other purposes.	
</html:option>
<%}else{ %>
		<html:option value="Flushing"><font class="myfontclr1">Flushing / Chlorination	
</html:option>
<%} %>
		
		</html:select>
		</td> 
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="preparedDate" indexed="true" /> <nested:write
		name="COMPLIST" property="preparedDate" /></td>
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="parameter1" indexed="true" /><nested:write name="COMPLIST"
		property="parameter1"  />/<br>
		<nested:hidden name="COMPLIST"
		property="parameter4" indexed="true" /> 
		<nested:write
		name="COMPLIST" property="parameter4" /></td>
		
		
	<!-- 	<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="parameter5" indexed="true" /> <nested:write
		name="COMPLIST" property="parameter5" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="parameter2" indexed="true" /> <nested:write
		name="COMPLIST" property="parameter2" /></td>
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="parameter3" indexed="true" /> <nested:write
		name="COMPLIST" property="parameter3" /></td>
		
		 -->
		<td class=bwborder align=left nowrap><html:text name="COMPLIST"  property="remarks" maxlength="50"  indexed="true"  onkeypress="textOnly(event)"  /></td>
		
		
		
				</tr>
				</nested:iterate>
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%
	}
}catch(Exception p)
{
p.printStackTrace();
}
%>
	</table>
	</td>
	</tr>
	
	
					
						</label>
				</fieldset>
		
	
	<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="Update/Save the Fields" styleClass="btext2" value="Save" onclick="fnSave()"  />
		<!--<html:button property="mode" title="View the Fields" styleClass="btext2" value="View" onclick="fnView()" />-->
		<input type="hidden" name="resultCount" value="<%=count%>">
	<input type=hidden name=hab1>
		
				</td>
				
	</tr>
	</table>
	</table>
	
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="960"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>


