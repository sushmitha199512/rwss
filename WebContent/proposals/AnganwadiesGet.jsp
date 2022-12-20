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
//String stat123="select a.hab_code||school_code,a.hab_code||'-'||school_code||'-'||panch_name||'-'||school_name as a from rws_school_master_tbl a,rws_panchayat_raj_tbl b where a.hab_code=panch_code and ("+a.substring(0,len-3)+")";

String stat123=" select a.habcode||school_id,a.habcode||'-'||school_id||'-'||panch_name||'-'||sch_name as a from IMIS_ANGANWADIES_TBL a,rws_panchayat_raj_tbl b where a.habcode=panch_code and ("+a.substring(0,len-3)+")";
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

