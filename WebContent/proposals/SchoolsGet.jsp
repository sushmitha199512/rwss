<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
String a = request.getParameter("mandals");
Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
   int len =a.length();
   Calendar rightNow = Calendar.getInstance();
	int year = rightNow.get(Calendar.YEAR);
	String stat123 = "";
	if(year <2021){
	
		//System.out.println("!!!!!!!!");
		stat123="select a.HAB_CODE||SCHOOL_CODE,a.HAB_CODE||'-'||SCHOOL_CODE||'-'||panch_name||'-'||SCHOOL_NAME as a from RWS_SCHOOL_MASTER_TBL a,rws_panchayat_raj_tbl b where a.HAB_CODE=panch_code and ( a.HAB_CODE ="+a.substring(12,len-3)+")";
	
	}else{
		//System.out.println("**********");
		stat123="select a.HABCODE||SCHOOL_ID,a.HABCODE||'-'||SCHOOL_ID||'-'||panch_name||'-'||SCH_NAME as a from IMIS_SCHOOLS_TBL a,rws_panchayat_raj_tbl b where a.HABCODE=panch_code and ("+a.substring(0,len-3)+")";	
	}
 //String stat123="select a.habcode||school_id,a.habcode||'-'||school_id||'-'||panch_name||'-'||sch_name as a from IMIS_SCHOOLS_TBL a,rws_panchayat_raj_tbl b where a.habcode=panch_code and ( a.HABcode ='0608850008010800' )";
 
//System.out.println("!!!!!!!!stat123:   "+stat123);
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

