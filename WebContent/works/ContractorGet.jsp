<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>
<% 
Statement st = null;
ResultSet rs123 = null;
String stat123 = "";	
try
{
String a = request.getParameter("district");
String b = request.getParameter("catcode");
String c = request.getParameter("name");
String cqry = "";
if(!c.equals("all"))
	cqry = "where upper(contractor_name_company) like '"+c.toUpperCase()+"%'";

	if(b.equals("1"))
	{
		stat123 = "select * from rws_proj_contractor_view  where contractor_code=contractor_code "+cqry+" order by contractor_name_company";
	}
	else
	{
		stat123 = "select distinct a.contractor_code,contractor_name_company from rws_non_proj_contractor_view a,rws_contractor_selection_tbl b where a.contractor_code=b.contractor_code and substr(b.work_id,5,2)='"+a+"' "+cqry+" order by contractor_name_company";
	}
	stat123 = "select distinct contractor_code,contractor_name_company from rws_contractor_tbl "+cqry+" order by upper(contractor_name_company)";
	System.out.println("query in contractor get:"+stat123);
	st = conn.createStatement();
	rs123=st.executeQuery(stat123);
%>
	<option  value=''>Select...</option>
<%
	while (rs123.next())
	{
%>
		<option  value=<%=rs123.getString(1)%>><%=rs123.getString(2)%> - <%=rs123.getString(1)%></option>
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
		   if(rs123!=null){rs123.close();rs123=null;}
		   if(st!=null){st.close();st=null;}
		   if(conn!=null){conn.close();conn=null;}
		}
		catch(Exception d)
		{
			
		}
	}
	%>

