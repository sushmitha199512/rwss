<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
String workId=request.getParameter("workId");
String table=request.getParameter("table");
String a = request.getParameter("mandals");
Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
   int len =a.length();
   String getMandals = "select distinct hab_code from "+table+" where work_id='"+workId+"'";
   Statement gmst1 = conn.createStatement();
   ResultSet gmrs1 = gmst1.executeQuery(getMandals);
   ArrayList gm = new ArrayList();
   int i = 0;
   while(gmrs1.next())
	{
	   gm.add(i++,gmrs1.getString(1));
	}
String stat123="select distinct h.hab_code,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  "+a.substring(0,len-3)+") order by h.panch_name";
st = conn.createStatement();
rs123=st.executeQuery(stat123);
%>
<%while (rs123.next())
{
		if(gm.contains(rs123.getString(2)))
		{
%>
<input type=checkbox name=habs value="<%=rs123.getString(2)%>" checked><font face=verdana size=2><%=rs123.getString(3)%>-<%=rs123.getString(2)%></font><br>
<%
		}else
		{
%>
<input type=checkbox name=habs value="<%=rs123.getString(2)%>">
<font face=verdana size=2><%=rs123.getString(3)%>-<%=rs123.getString(2)%></font><br>

<%}
}
}
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN Work_HabsGet.jsp"+e.getMessage());
   } 
   finally
   {
try
{
	   if(rs123!=null)rs123.close();
	   if(st!=null)st.close();
	   if(conn!=null)conn.close();
}
catch(Exception d)
{
	
}
   }
	%>

