<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
String a = request.getParameter("mandals");
System.out.println("aa:"+a);
Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
   int len =a.length();
String stat123="select a.HABCODE||LOCATION,a.HABCODE||'-'||PI_ID||'-'||panch_name||'-'||LOCATION as a from IMIS_PUBLIC_INSTITUTIONS_TBL a,rws_panchayat_raj_tbl b where a.HABCODE=panch_code and ("+a.substring(0,len-3)+")";
System.out.println("stat123:"+stat123);
st = conn.createStatement();
rs123=st.executeQuery(stat123);
%>
<%while (rs123.next())
{
	
%>
<option  value=<%=rs123.getString(1)%>><%=rs123.getString(2)%></option>

<%}
}
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e.getMessage());
   } 
   finally
   {
try
{
	   if(rs123!=null)rs123.close();
	   if(st!=null)st.close();
}
catch(Exception d)
{
	
}
   }
	%>

