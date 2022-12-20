<%@page import="ChartDirector.*" %><%
try 
{ 
System.out.println("Chadddrt");
	out.clear();
	GetSessionImage.getImage(request, response); 

	if (Math.max(1, 2) == 2) return;
}
catch (Exception e) 
{ 
e.printStackTrace();
	}
%>