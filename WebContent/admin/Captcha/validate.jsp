<form name="form1" method="post" action="form.jsp">
<div align="center">
<input name="Submit" type="submit" value="back"></div>
</form>
<div align="center">
<%
String key=(String)session.getAttribute("key");
String user = request.getParameter("number");
String url = request.getHeader("referer");
System.out.println("url:"+url);
String spath=request.getServerName();
System.out.println("Spath:"+spath);
int val=0;
val= spath.indexOf("www.");

if(val != -1)
{
   spath=spath.replaceFirst("www.","");
}
int domain=url.indexOf(spath); 
if(domain != -1)
{
if(key.compareTo(user)==0)			
{
out.print("Verification success");
}
else{
out.print("You have entered wrong verification code!! <br> Please go back and enter proper value.");
}
}
else
{%>
			<div align=center style='color: red;'><b>Not a Vaild Domain</b></div>
		
<% }
%>
</div>
