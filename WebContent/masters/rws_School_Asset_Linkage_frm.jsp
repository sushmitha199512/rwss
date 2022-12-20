<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%//System.out.println("DATA Entered"); 
java.util.ArrayList progs = (java.util.ArrayList)session.getAttribute("assetTypes");%>
<script language="javascript">
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}

function openEditWindow(index)
{
//alert(index);
	var habCode = document.getElementById("LOC_DETAILS_LIST["+index+"].habCode").value;
	//alert(habCode);
	var schoolCode = document.getElementById("LOC_DETAILS_LIST["+index+"].schoolCode").value;
	//alert(schoolCode);
	//var url = "./switch.do?prefix=/masters&page=/school.do&mode=getAssets&habCode="+habCode+"&rowid="+index+"&schoolCode="+schoolCode;
	var url = "./switch.do?prefix=/masters&page=/school.do&mode=getAssets&habCode="+habCode+"&rowid="+index+"&schoolCode="+schoolCode+"&selCr="+document.getElementById("LOC_DETAILS_LIST["+index+"].selCriteria").value;
	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	// alert(url);
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	

}
</script>
<body topmargin="0">
<html:form action="school.do">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right"><a href="./home.jsp" >Home </a>|</td>
		<td	class="bwborder" align="right"><a href="switch.do?prefix=/masters&page=/school.do&mode=data">Back</a></td>
	</tr>
</table>
</caption>
<tr><td colspan=18 class="textborder">Schools List</td></tr>
<tr>
<!-- <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Sel<BR>ect</FONT></TD> -->
	<td align=center>
		<FONT class=myfontclr><font color="#993366">S.NO.</FONT></FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">District</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Mandal</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Panchayat</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Village</FONT>
		</td>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Habitation</FONT>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School Name</FONT></FONT>
		</td>
	
		<!-- <td nowrap>
		<FONT class=myfontclr><font color="#993366">Total Students</FONT></FONT>
		</td> -->
			
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Boys/Girls</FONT></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Category</FONT></FONT>
		</td>
						
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Classification</FONT></FONT><br>
		</td>
		<!-- <td nowrap>
		<FONT class=myfontclr><font color="#993366">Asset Types</FONT></FONT><br>
		</td>
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Asset(or) Work Name/Cost/Location/<BR>Date of Creation(or)Comission</FONT></FONT><br>
		</td> -->
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Select Asset/Work</FONT></FONT><br>
		</td>
			
		</tr>
		<%int count=0; %>
		<nested:iterate id="LOC_DETAILS_LIST" name="list">
		<tr   onclick="toggleRowColor(this)">
		  <!-- <TD class="bwborder" align="center">
				<html:checkbox name="LOC_DETAILS_LIST" property="update"  indexed="true" />
		 </TD> -->
		<td class="bwborder" align="center"><%= ++count %></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="dname" /></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="mname"/></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="pname"/></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="vname"/></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="habname" /></td>
		<nested:hidden  name="LOC_DETAILS_LIST" property="habCode"  indexed="true"/>
		<nested:hidden  name="LOC_DETAILS_LIST" property="selCriteria"  indexed="true"/>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="schoolname"/></td>
		<nested:hidden  name="LOC_DETAILS_LIST" property="schoolcode"  indexed="true"/>
		<!-- <td class="bwborder" align="center"><nested:text  name="LOC_DETAILS_LIST" property="students"  indexed="true"  styleClass="mytext" style="width:100" onkeypress="upperOnly()" readonly="true"/></td> -->
		<td class="bwborder" align="center" nowrap><nested:write  name="LOC_DETAILS_LIST" property="boysgirls" /></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="category"  /></td>
		<td class="bwborder" align="left" nowrap><nested:write  name="LOC_DETAILS_LIST" property="classification"/></td>
		<td>
		<input type=button  class=btext value="..." style="width:120" onclick='<%="openEditWindow("+(count-1)+");" %>'>
		</td>
		<!-- <td class="bwborder" align="center"><nested:select name="LOC_DETAILS_LIST" property="assetTypeCode" style="width: 100px" styleClass="noborder-text-box" indexed="true" onchange='<%="getWorks("+(count-1)+");" %>'>
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:present name="LOC_DETAILS_LIST" property="assetTypes">
			  <nested:optionsCollection name="LOC_DETAILS_LIST" property="assetTypes" label="label" value="value"/>
			</logic:present>	
		</nested:select>
		</td>
		<td class="bwborder" align="center"><nested:select name="LOC_DETAILS_LIST" property="assetCode" style="width: 400px" styleClass="noborder-text-box" indexed="true" onchange='<%="setAsset("+(count-1)+");" %>'>
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:present name="LOC_DETAILS_LIST" property="assetsList">
			  <nested:optionsCollection name="LOC_DETAILS_LIST" property="assetsList" label="label" value="value"/>
			</logic:present>	
		</nested:select>
		</td> -->
	  </tr>
</nested:iterate>
<input type="hidden" name="resultCount" value="<%=count%>">
<% int a=1; 
%>
<script language="javascript">
function fnViewUpdateSchool()
{
	//alert("in dash");
	alert(document.forms[0].resultCount.value);
	var rCount = '<%=count%>';
//	alert(rCount);
	var yes = 0;
	for(var index=0;index<document.forms[0].resultCount.value;index++)
	{
		if(document.getElementById("LOC_DETAILS_LIST["+index+"].update").checked)
		{
			if(document.getElementById("LOC_DETAILS_LIST["+index+"].assetTypeCode").value=="" || document.getElementById("LOC_DETAILS_LIST["+index+"].assetCode").value=="")
			{
				alert("Before Updating the School(s) You must select the Asset Type and Asset(or)Work for the Check Box with Sl. No:"+(index+1));
			}
			else
			{
				var assetTypeCode = document.getElementById("LOC_DETAILS_LIST["+index+"].assetTypeCode").value;
				var habCode = document.getElementById("LOC_DETAILS_LIST["+index+"].habCode").value;
				var assetCode = document.getElementById("LOC_DETAILS_LIST["+index+"].assetCode").value;
				var schoolCode = document.getElementById("LOC_DETAILS_LIST["+index+"].schoolCode").value;
			}
		}
	}
	document.forms[0].action="./switch.do?prefix=/masters&page=/school.do&mode=saveSchool&assetTypeCode="+assetTypeCode+"&habCode="+habCode+"&rowid="+index+"&assetCode="+assetCode+"&schoolCode="+schoolCode;
	document.forms[0].submit();
	
}
</script>
</table>
	<BR>
	<BR>
</html:form>
<p align=center>
<%@ include file="/commons/rws_footer.jsp"%></p>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
</body>
</html>




