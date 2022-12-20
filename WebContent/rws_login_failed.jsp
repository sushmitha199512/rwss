
 <% if(session.getAttribute("message")!=null)
 { %>
 <script>
 var message='<%= session.getAttribute("message") %>';
 if(message)
 alert(message);
 </script>
 <%}%>
 
<%
try
{
     session.getAttributeNames();
     session.invalidate();
     
     //response.sendRedirect("rws_login_frm.jsp");
}
catch (java.lang.Exception isse)
{
   System.out.println("Exception in Login Failed JSP");
}

 %>
 <script>
 function init(){
	 document.location.href="rws_login_frm.jsp";
 }
 </script>
 <body onload="init();">
 </body>