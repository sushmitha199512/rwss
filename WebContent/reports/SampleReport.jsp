<%@		taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@		page import = "java.sql.*, java.text.*, java.util.*, nic.*, javax.naming.*, javax.sql.*" %>


<%!
		PensionDAO pensionDAO = null;
		Connection conn = null;
%>
<%
	try
	{
		pensionDAO = new PensionDAO();
		conn = pensionDAO.conn;
		out.println("Connection1"+conn);
		
	}
	catch(Exception e)
	{
		out.println(e);
	}
%>
<FONT size=3 color=black>
<%

	GregorianCalendar cal = new GregorianCalendar();
	int mon = cal.get(Calendar.MONTH);

	String curdate = cal.get(Calendar.DAY_OF_MONTH) + "/" + (mon+1) + "/" + cal.get(Calendar.YEAR);
	out.println(curdate);

	ArrayList OldMembers = new ArrayList();
	OldMembers = pensionDAO.getOldMembers();

	int p = OldMembers.size();

	out.println("Size"+OldMembers.size());

	for (int i =0; i < p ; i++)
	{
		String[] record1 =(String[])OldMembers.get(2);	
		
		out.println("lenth of record  "+record1.length);
		String memcode = record1[0];
		String memname = record1[1];

		out.println(memcode);
		out.println(memname);
	}
	
%>
<c:out value="PADMA" />

<c:forEach items="${record1}" var="t">
	<c:out value="${t}" />
</c:forEach>