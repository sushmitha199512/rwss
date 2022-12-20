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
<html:link page="/rws_work_Category_view_xls.jsp" target="_new">Excel</html:link>
<%
 
 session.setAttribute("viewsum",request.getAttribute("viewsum"));
 //Integer count=(Integer)session.getAttribute("count");
 
 	   
	
/* ArrayList myList = (ArrayList)session.getAttribute("v");
 Iterator iterator = myList.iterator();
 int mylists1=myList.size();
 
 if(request.getParameter("start") !=  null) 
	{
		start = Integer.parseInt(request.getParameter("start"));
	}*/
 
 %>
 
 <table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>	  
		 
		 <td  class= "btext">S.No</td>
		   <td class="btext">Plan Name</td>
		    <td class="btext">Work Type</td>
   		    <td class="btext">Category Name</td>
		    <td class="btext">Programme Name</td>
		    <td class="btext">Action</td>
	</tr>
	<%int cnt=0;
	

	%>
	<logic:iterate id="rep" name="viewsum">
	
		<tr align="left" >
		
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><%=++cnt%></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><bean:write name="rep" property="plan" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="rep" property="category" /></FONT>
		</td>
		<td  class=mycborder1 >
		<FONT class=myfontclr1><bean:write name="rep" property="wrktype" /></FONT>
		</td>
		
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="rep" property="program" /></FONT>
	    	
		</td>
		
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1>
		
	<c:if test='${rep.count == "0"}'>
		<a href="#1" onclick="openEditWindow('./switch.do?prefix=/masters&page=/workCategory.do?plan=<bean:write name='rep' property='plancode'/>&wrktype=<bean:write name='rep' property='workcode'/>&category=<bean:write name='rep' property='categorycode'/>&program=<bean:write name='rep' property='programcode'/>&mode=get','838','648')" style="color:blue">Edit&nbsp;&nbsp;</a>
		

		 
    </c:if>
    <c:if test='${rep.count != "0"}'>
        <!-- <a href="#1"  style="color:red" onclick="return false" disabled="true">Edit</a>|
		 <a href="#1" style="color:red" onclick="return false" disabled="true">Delete</a> -->
		 		 <a href="#1" style="color:red" onclick="return false" disabled="true">Works Exist</a>
    </c:if>
     </td>
	</tr>
		
	</logic:iterate>
	 <%if(cnt==0)
	  {%>
	  <tr>
	  <td colspan=5 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
       
     <%}%>
	</table>
	<%@ include file="/commons/rws_alert.jsp"%>