<%
		String message = "";
		if( request.getAttribute("msg") != null )
		{
			message = (String) request.getAttribute("msg");
		}
%>

<%@ include file="/reports/conn.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
stmt = conn.createStatement();
rs = stmt.executeQuery("select * from rws_scheme_asset_feedback_tbl order by id");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
     
    <title>Feed Backs</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script language="javascript">
	function deleteFeedBack(id)
	{
		if(confirm("Do You Want to Delete this Feed Back"))
		{
			var url = "/pred/works/deleteFeedBack.jsp";
			ajaxFunction(url,document.getElementById("mydivid"));
		}
	}
	function replyMail(id)
	{
      //alert(id);
		var width = 650;
		var height = 450;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		url="/pred/works/rws_feedback_reply.jsp?mail="+id;
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
								+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
								+ "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
	}
	function ajaxFunction(URL,divobj)
		{ 
			if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
			//alert(URL);
			var xmlHttp;
			try{
				xmlHttp=new XMLHttpRequest();    
			}
			catch (e){    
				try{
					xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
				}
				catch (e){
				  try{
					  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
				  }
				  catch (e){
					  alert("Your browser does not support AJAX!");        
					  return false;        
				  }      
				}    
			}
			if (xmlHttp==null)
			{
			  alert ("Your browser does not support AJAX!");
			  return;
			} 
			xmlHttp.onreadystatechange=function()
			{
			  if(xmlHttp.readyState==4)
			  {
				//divobj.innerHTML=xmlHttp.responseText;
				alert(xmlHttp.responseText);
				//divobj.innerHTML="";
				document.forms[0].action="/pred/works/ViewFeedBacks.jsp";
				document.forms[0].submit();
			  }
			  else{
					//document.getElementById('show').style.display='none';
				  	document.getElementById('hideShow1').style.display='block';
			  }
			}
			//alert(URL);
			xmlHttp.open("POST",URL,true);
			xmlHttp.send(null);  
		}
	</script>
  </head>
  
  <body>
  <form method="post">
  <div id="hideShow1"  style="position:relative;overflow-y:auto;left:500;height:40;width:270;top:79;display:none"><img src="images/loading.gif"/></div>
  <div align="center" id="show">
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="75%" id="AutoNumber2">
    
<%
try
{
  if(rs.isBeforeFirst())
  {%>
  <tr>
      <td width="100%"><BR><p align="center"><font face="Verdana"><b>
		<font color="#0066FF" face="Verdana" size="4">Feed Back</font></b><font color="#0066FF" size="4"><BR>
      </font>
</font>
</p>
<div align="center">
  <center>
    <table border="1" bordercolor="#8A9FCD"  cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="60%" id="AutoNumber1">
  <tr>
  <td  nowrap><font face=verdana size=2>S No</td>
  <td  nowrap><font face=verdana size=2>User Id</td>
	<td  nowrap><font face=verdana size=2>Name</td>
	<td  nowrap><font face=verdana size=2>Designation</td>
  <td align="center"><font face=verdana size=2>Feed Back</td>
  <td align="center"><font face=verdana size=2>Action</td>
  <td align="center"><font face=verdana size=2>Reply</td>
  </tr>
  <%
  int sno = 1;
  
  while(rs.next()){
    %>
    <tr align="center">    			
    <td><font face=verdana size=2><%=sno++%></td>
	<td><font face=verdana size=2><%=rs.getString(3)%></td>
	<td><font face=verdana size=2><%if(rs.getString("name")!=null){out.println(rs.getString("name"));}else {out.println("-");}%></td>
	<td><font face=verdana size=2><%if(rs.getString("desg")!=null){out.println(rs.getString("desg"));}else {out.println("-");}%></td>
      <td height=25 width=50 align="left">
      <font face="Verdana" size="2" color="black">
	  <textarea name="desc" rows="4" cols="50" ><%=rs.getString(2)%></textarea>
	  </td>
	  <td style="cursor:pointer" onclick="deleteFeedBack('<%=rs.getString(1)%>')" >
      <font face=verdana size=2 color=blue><U>Delete</U></font></td>
	  <%if(rs.getString(4)!=null && !rs.getString(4).equals("")){%>
	  <td style="cursor:pointer" onclick="replyMail('<%=rs.getString("id")%>')" >
      <font face=verdana size=2 color=blue><U>Reply</U></font></td>
	  <%}
	else
	  {
	%>
	<td>&nbsp;</td>
	<%}%>
    </tr>
    <%
    }
   %>
  	</table>
	<p align=left>
<font face=verdana size=2 color=red>Note:****</font><font face=verdana size=2 color=blue>To Delete Feed Back Click on the FeedBack</a>
</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
	<% }
    else{
    %>
    <tr>    			
      <td align="center" colspan=2><font face="Verdana" size="2" color="black">No Feed Backs</font>
      </td>
    </tr>
    
    <%
    }
  	%>
<%}
catch(Exception e){e.printStackTrace();} %>
	</table>
	</div>
	<p align="center"><font color="red" face=verdana size=2><%=message%></font></p>
	</form>
  </body>
</html>