<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>

<% 		
String a = request.getParameter("dists");
String workId=request.getParameter("workId");
String table=request.getParameter("table");
Statement st = null;
ResultSet rs123 = null;
	try{
   Statement stqq =null; 
   ResultSet rsqq = null;
   int len =a.length();
   String getMandals = "select distinct substr(hab_code,1,2)||substr(hab_code,6,2) from "+table+" where work_id='"+workId+"'";
   Statement gmst = conn.createStatement();
   ResultSet gmrs = gmst.executeQuery(getMandals);
   ArrayList gm = new ArrayList();
   int i = 0;
   while(gmrs.next())
	{
	   gm.add(i++,gmrs.getString(1));
	}
   String stat123="SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE "+a.substring(0,len-3)+" order by mname";
st = conn.createStatement();
rs123=st.executeQuery(stat123);
%>
<%while (rs123.next())
{
	if(gm.contains(rs123.getString(1)+rs123.getString(2)))
		{
%>
<input type=checkbox name=mandalss value="<%=rs123.getString(1)%>-<%=rs123.getString(2)%>" checked><font face=verdana size=2><%=rs123.getString(3)%></font><br>
<%
		}else
		{
%>
<input type=checkbox name=mandalss value="<%=rs123.getString(1)%>-<%=rs123.getString(2)%>">
<font face=verdana size=2><%=rs123.getString(3)%></font><br>

<%}
}
	}
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN Work_MandalsGet.jsp"+e.getMessage());
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

