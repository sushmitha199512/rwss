<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<script language="javascript">

<%	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userid = users.getUserId(); 
Boolean flag= (Boolean)session.getAttribute("AGENCY");
System.out.println("UserId:"+userid+"flag    "+flag );%>

function winClose1()
{
	location.href="./rws_login_frm.jsp";
}
function winClose()
{
	location.href="/pred/home.do";
}

<%if(request.getParameter("contextHelpUrl")!=null)
{%>
function getHelp()
{

var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = '<%=request.getParameter("contextHelpUrl")%>';
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
}
<%}else{%>
function getHelp(){}
<%}%>
</script>

<TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_left1.gif'/>" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=<%=request.getParameter("TWidth")%>>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B><%=request.getParameter("TableName")%></B><font></td>
	    <td align=right><IMG SRC="<rws:context page='/images/icon_help.gif'/>" WIDTH="12" HEIGHT="12" style="cursor:hand" ALT="Click here to get Context Help" onclick="getHelp()">&nbsp;
		<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" 
		<%if(flag!=null && flag==true && userid != null){ %>
		onclick="winClose()" 
		<%}else{ %>
		onclick="winClose1()" 
		<%}%>
		style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_right1.gif'/>" ></TD>
</TABLE>