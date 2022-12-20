<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<script language="javascript">
function winClose1()
{
	location.href="./rws_login_frm.jsp";
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
	    </tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_right1.gif'/>" ></TD>
</TABLE>