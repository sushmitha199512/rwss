<SCRIPT LANGUAGE="JavaScript">
<%
try
{
     session.getAttributeNames();
     session.invalidate();
}
catch (java.lang.Exception isse)
{
    System.out.println("session already invalidated");
}
 %>
<!--
window.close();
//-->
</SCRIPT>
