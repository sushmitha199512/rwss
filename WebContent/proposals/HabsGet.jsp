<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
System.out.println("sssss");
String a = request.getParameter("mandals");
String proposalId=request.getParameter("proposalId");
Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
   int len =a.length();
String stat123="select distinct h.hab_code,h.panch_code,h.panch_name,p.pname,v.vname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and "+a.substring(0,len-3)+") order by h.panch_name";
System.out.println("stat123:"+stat123);
st = conn.createStatement();
rs123=st.executeQuery(stat123);
%>
<%while (rs123.next())
{
	
%>
<option  value=<%=rs123.getString(2)%>><%=rs123.getString(2)%>-<%=rs123.getString(3)%>(<%=rs123.getString(4)%>-<%=rs123.getString(5)%>)</option>

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

