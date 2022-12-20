<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<% 
//This code makes an entry of logout into the log table
System.out.println("rws_ho_admin_logout get :"+session.getAttribute("hoLogged"));
	session.removeAttribute("hoLogged");
//end of code
%>
<script>
//document.location.href="./rws_login_frm.html";
alert("Logged Out Successfully");
window.close();
</script>
