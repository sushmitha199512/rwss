<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@ page import="java.util.ArrayList"%>

<script language="javascript">

function openEditWindow(url,width,height)
{
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));	 
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();	
}
  function deleteRec()
  {
	return (confirm("Do u want to Delete the Record Y/N")); 	
  }
</script>
<table width=550>
<tr><td align=right><a href="javascript:history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a>
<%-- <html:link page="/rws_work_Category_view_xls.jsp" target="_new">Excel</html:link> --%>
<% 
 session.setAttribute("viewsum",request.getAttribute("viewsum"));
 %> 
 <table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>			 
	 	<td  class= "btext">S.No</td>
	    <td class="btext">Programme Code-Name</td>
	    <td class="btext">SubProgramme Code-Name</td>
  		<td class="btext">ImisProgramme Code-Name</td>
  		<td class="btext">State/Central</td>
	    <td class="btext">Place Amount In</td>
	    <td class="btext">Place Amount In(For SVS)</td>
	    <td class="btext">Action</td>
	</tr>
	<%int cnt=0;
	%>
	<logic:notEmpty name="imisList">
	<logic:iterate id="imisList" name="imisList">	
		<tr align="left">		
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><%=++cnt%></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><bean:write name="imisList" property="programmeName" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="imisList" property="subProgrammeName" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="imisList" property="imisProgrammeName" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
	<%-- <bean:write name="imisList" property="belTo" />  --%>
		<logic:equal value="S" name="imisList" property="belTo"><FONT class=myfontclr1>State</FONT></logic:equal>	
		<logic:equal value="C" name="imisList" property="belTo"><FONT class=myfontclr1>Central</FONT></logic:equal>    	
		</td>		
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="imisList" property="amtIn" /></FONT>	    	
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="imisList" property="amtInSvs" /></FONT>	    	
		</td>				
		<td>	
		<a href="#1" onclick="openEditWindow('./switch.do?prefix=/masters&page=/ImisProgrammeLink.do?programme=<bean:write name='imisList' property='programme'/>&subprogramme=<bean:write name='imisList' property='subProgramme'/>&imisProgramme=<bean:write name='imisList' property='imisProgramme'/>&amtIn=<bean:write name='imisList' property='amtIn'/>&amtInSvs=<bean:write name='imisList' property='amtInSvs'/>&belTo=<bean:write name='imisList' property='belTo'/>&mode=get','838','648')" style="color:blue">Edit&nbsp;&nbsp;</a>
	    </td>
	</tr>		
	</logic:iterate>
	</logic:notEmpty>
	 <logic:empty name="imisList">
	  <tr>
	  <td colspan=5 align=center>No Record Match With This Selection Criteria</td>
	  </tr>       
    </logic:empty>
	</table>
	<%@ include file="/commons/rws_alert.jsp"%>