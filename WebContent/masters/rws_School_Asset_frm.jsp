
<%@page import="nic.watersoft.masters.Rws_SchoolDetailsBean"%>
<%@ include file="/commons/rws_head.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%int count=0; %>
<%java.util.ArrayList progs = (java.util.ArrayList)request.getAttribute("assets");
//System.out.println("progs:"+progs);
String msg = request.getParameter("selCr");%>
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
function getAssetsWorks()
{
	var habCode='<%=request.getParameter("habCode")%>';
	//alert(habCode);
	var schoolCode='<%=request.getParameter("schoolCode")%>';
	//alert(schoolCode);
	var rowid='<%=request.getParameter("rowid")%>';
	var msg = '<%=request.getParameter("selCr")%>';
	//alert(rowid);
	var aTypes="";
	var checkbox_choices=0;
	for(counter=0;counter<document.forms[0].assetType.length;counter++)
	{
		if(document.forms[0].assetType[counter].checked)
		{
			aTypes=aTypes+document.forms[0].assetType[counter].value+",";
			checkbox_choices++;
		}
	}
	if(checkbox_choices==0)
	{
		alert("Please Select any of Check Boxes");
	}
	else
	{
		//alert(aTypes);
		document.forms[0].action="/pred/switch.do?prefix=/masters&page=/school.do&mode=getAssetsWorks&habCode="+habCode+"&rowid="+rowid+"&schoolCode="+schoolCode+"&aTypes="+aTypes+"&selCr="+msg;
		document.forms[0].submit();
	}

}
function saveAssetsWorks()
{
	var habCode='<%=request.getParameter("habCode")%>';
	//alert(habCode);
	var schoolCode='<%=request.getParameter("schoolCode")%>';
	//alert(schoolCode);
	var rowid='<%=request.getParameter("rowid")%>';
	//alert(rowid);
	var checkbox_choices=0;
	var assets = "";
	if(document.forms[0].resultCount.value==0)
	{
		assets=assets+document.forms[0].update.value+",";
		document.forms[0].action="/pred/switch.do?prefix=/masters&page=/school.do&mode=saveAssetsWorks&habCode="+habCode+"&rowid="+rowid+"&schoolCode="+schoolCode+"&assets="+assets;
		document.forms[0].submit();
	}
	else
	{
			for(counter=0;counter<document.forms[0].update.length;counter++)
			{
				if(document.forms[0].update[counter].checked)
				{
					assets=assets+document.forms[0].update[counter].value+",";
					checkbox_choices++;
				}
			}
			if(checkbox_choices==0)
			{
				alert("Please Select any of Check Boxes");
			}
			else
			{
				//alert(assets);
				document.forms[0].action="/pred/switch.do?prefix=/masters&page=/school.do&mode=saveAssetsWorks&habCode="+habCode+"&rowid="+rowid+"&schoolCode="+schoolCode+"&assets="+assets;
				document.forms[0].submit();
			}
	}
}
</script>
<body topmargin="0">
<html:form action="school.do">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">
<tr><td colspan=18><%=msg%></td></tr>
<tr><td colspan=18 class="textborder"><FONT class=myfontclr><font color="#993366">Asset Types</font></td></tr>
<tr>
	<td class="bwborder"><input type="checkbox" name="assetType" value="01">PWS</td>
	<td class="bwborder"><input type="checkbox" name="assetType" value="03">CPWS</td>
</tr>
<tr>
	<td class="bwborder"><input type="checkbox" name="assetType" value="02">MPWS</td>
	<td class="bwborder"><input type="checkbox" name="assetType"  value="04">HAND PUMPS</td>
</tr>
<tr>
	<td class="bwborder"><input type="checkbox" name="assetType" value="09">DIRECT PUMPING</td>
	<td class="bwborder"><input type="checkbox" name="assetType" value="05">SHALLOW HAND PUMPS</td>
</tr>
<tr>
	<td class="bwborder"><input type="checkbox" name="assetType" value="06">OPEN WELLS</td>
	<td class="bwborder"><input type="checkbox" name="assetType" value="07">PONDS</td>
</tr>
<tr>
	<td class="bwborder"><input type="checkbox" name="assetType" value="08">OTHERS </td>
	<td>&nbsp;</td>
</tr>
<tr><td colspan=2 align=center><input type="button" name="mode" value="Get Assets(or)Works" onClick="getAssetsWorks()"></td></tr>
</table>
<%if(progs!=null){%>
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">
<tr><td colspan=18 class="textborder"><font color="#993366" size=2 face=verdana>List of Assets (or) Works based on <%=request.getAttribute("selATypes")%></font></td></tr>
<tr>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Sel<BR>ect</FONT></TD>
	<td align=center>
		<FONT class=myfontclr><font color="#993366">S.NO.</FONT></FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Asset Type</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Asset(or)Work</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Asset(or)Work Name</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Cost(In Lakhs)</FONT>
		</td>
		<td  align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Asset Location</FONT>
		</td>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Date of Creation(or)Commission</FONT>
		</td>
</tr>

<%
for(int i=0;i<progs.size();i++)
			{
				Rws_SchoolDetailsBean rs = (Rws_SchoolDetailsBean)progs.get(i);%>
<tr   onclick="toggleRowColor(this)">
		 <TD class="bwborder" align="center">
		 <%if(rs.getAlreadyExists().equals("Y")){%>
				<input type="checkbox" name="update"  value="<%=rs.getAssetCode()%>" checked="true"/>
				<%}else{%>
				<input type="checkbox" name="update"  value="<%=rs.getAssetCode()%>"/>
				<%}%>
		 </TD>
		<td class="bwborder" align="center"><%= ++count %></td>
		<td class="bwborder" align="left" nowrap><%=rs.getAssetTypeName()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getType()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getAssetName()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getAssetCost()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getLocation()%></td>
		<td class="bwborder" align="left" nowrap><%=rs.getDate()%></td>
</tr>
<%}
if(count==0){%>
<tr><td colspan=8 align=center><FONT class=myfontclr ><font color="#993366">No Assets or Works</font></td></tr>
<%}else{ %>
<tr><td colspan=8 align=center><input type="button" name="mode" value="Save Selected Assets(or)Works" onClick="saveAssetsWorks()"></td></tr>
<%} %>
</table>
<%}%>
	<BR>
	<BR>
	<input type="hidden" name="resultCount" value="<%=--count%>">
</html:form>
<p align=center>
<%@ include file="/commons/rws_footer.jsp"%></p>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
</body>
</html>