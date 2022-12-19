<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header2.jsp" %>



<script language="JavaScript" type="text/javascript">
function funcDelete(habcode,bldgcode)
{	//alert("1");
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/Govtgp.do&mode=delete&habCode="+habcode+"&bldgCode="+bldgcode;
	    document.forms[0].submit();
	}
}


function openDeleteWindow(url)
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

<html:form action="/Govtgp.do" >
<table width=100%>
<tr><td align=right><html:link page="/Govtgp.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="home.jsp">Home</a></td>
</tr>
</table>


<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="12">Government Buildings in Gram Panchayats List </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					
				
                    <td class=clrborder align=center nowrap>Habitation</td>
                    <td class=clrborder align=center nowrap>Building Name</td>
                     <td class=clrborder align=center nowrap>Latrine Facility</td>
                    <td class=clrborder align=center nowrap>Water Facility</td>
                    <td class=clrborder align=center nowrap>Survey Date</td>
                    <td class=clrborder align=center nowrap>Action</td>
				
				</tr>
				<%
try{
	int count=0;
	
java.util.Collection a = (java.util.Collection)session.getAttribute("bldgs"); 


	if( a != null && a.size() > 0)
	{
	%>
	
	
	<logic:iterate id="COMPLIST" name="bldgs">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		
		<td class=bwborder align=left nowrap><%=count++%></td>
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="habCode" />/<bean:write
		name="COMPLIST" property="panchName" /><Br><html:hidden
		name="COMPLIST" property="bldgCode" /></td>
		
		 <html:hidden
		name="COMPLIST" property="dName"  /><html:hidden
		name="COMPLIST" property="mName"  /><html:hidden
		name="COMPLIST" property="pName"  /><html:hidden
		name="COMPLIST" property="vName"  />
		
		
		<td class=bwborder align=left nowrap> <bean:write
		name="COMPLIST" property="bldgName"  /></td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="latFacility"  /></td>
		
		</td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="watFacility"  /></td>
		
		</td>
		
		<td class="rptValue" align=center>
		<bean:write
		name="COMPLIST" property="surveyDate"  /></td>
		
		</td>
		<!-- <td><bean:write
		name="COMPLIST" property="bldgCode"  /></td> -->
		<td  class=mycborder1 align=center><font color="#990066">

<a href="#1" onclick="openEditWindow('switch.do?prefix=/BaseLineSurvey&page=/Govtgp.do?mode=get&habCode=<bean:write name='COMPLIST' property='habCode'/>&bldgCode=<bean:write name='COMPLIST' property='bldgCode'/> ')">Edit&nbsp;|</a>&nbsp;
 
 <a href="#" onclick="funcDelete('<bean:write name='COMPLIST' property='habCode'/>','<bean:write name='COMPLIST' property='bldgCode'/>')">Delete</a>


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




