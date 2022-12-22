<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header2.jsp" %>



<script language="JavaScript" type="text/javascript">

function funcDelete(habcode,solidcode)
{	//alert("1");
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/SolidWaste.do&mode=delete&habCode="+habcode+"&solidCode="+solidcode;
	    document.forms[0].submit();
	}
}


function openEditWindow(url)
{
	
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}

</script>
<body>

<html:form action="/SolidWaste.do" >
<table width=100%>
<tr><td align=right><html:link page="/SolidWaste.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="home.jsp">Home</a></td>
</tr>
</table>


<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="12">BaseLine SurveySolid Waste details List </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					
				
                    <td class=clrborder align=center nowrap>Habitation</td>
                    <td class=clrborder align=center nowrap>Total Dust Bins</td>
                     <td class=clrborder align=center nowrap>Total Soak Pits</td>
                    <td class=clrborder align=center nowrap>Total Composite Pits</td>
<td class=clrborder align=center nowrap>Total Tri Cycles</td>
<td class=clrborder align=center nowrap>Extra Facilities</td>
<td class=clrborder align=center nowrap>Other In No</td>
<td class=clrborder align=center nowrap>Drainage Exists</td>
                    <td class=clrborder align=center nowrap>Survey Date</td>
                    <td class=clrborder align=center nowrap>Action</td>

				</tr>
				<%
try{
	int count=0;
	
java.util.Collection a = (java.util.Collection)session.getAttribute("solid"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<logic:iterate id="COMPLIST" name="solid">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		
		<td class=bwborder align=left nowrap><%=count++%></td>
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="habCode" />/<bean:write
		name="COMPLIST" property="panchName" /><Br><html:hidden
		name="COMPLIST" property="solidCode" /></td>
	
		 <html:hidden
		name="COMPLIST" property="dName"  /><html:hidden
		name="COMPLIST" property="mName"  /><html:hidden
		name="COMPLIST" property="pName"  /><html:hidden
		name="COMPLIST" property="vName"  />
		
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="totDustbins"  /></td>
		
		
      <td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="totSoakpits"  /></td>

		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="totCompits"  /></td>
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="totTricycles"  /></td>

<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="extraFacilities"  /></td>

<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="otherInNo"  /></td>
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="drainageExist"  /></td>


		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="surveyDate"  /></td>
		
		
		<html:hidden
		name="COMPLIST" property="solidCode"  />
	<td class="rptValue" align=center>
		<a href="#1" onclick="openEditWindow('switch.do?prefix=/BaseLineSurvey&page=/SolidWaste.do?mode=get&habCode=<bean:write name='COMPLIST' property='habCode'/>&solidCode=<bean:write name='COMPLIST' property='solidCode'/> ')">Edit&nbsp;|</a>&nbsp;
				<a href="#" onclick="funcDelete('<bean:write name='COMPLIST' property='habCode'/>','<bean:write name='COMPLIST' property='solidCode'/>')">Delete</a>

 


</td> 

		
				
		</tr>
			</logic:iterate>
				
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
System.out.println("Exception in baseline status jsp:"+p);
}
%>
	</table>
	</td>
	</tr>
</html:form>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
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




