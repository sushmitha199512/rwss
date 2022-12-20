<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ page contentType="application/vnd.ms-excel" %>

<%	int start,end,limit =20,  j, slno=0, pgcnt, pgno=0;
	int line=0;	
	int r1=0, s1=1, GOPG;
	String st=request.getParameter("start");
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	//System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	//String record[]=null;
	labelNames =(String[]) label1.next();
	//System.out.println("lebal are  count  "+labelNames.length);
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	if(request.getParameter("start") !=  null) 
	{
		start = Integer.parseInt(request.getParameter("start"));
		//	System.out.println("start is    "+start);
	}
	else
	{
		start = 0;
	}
	end = start + limit;
	//System.out.println("end value is   "+end);
	if(request.getParameter("pgcnt") !=  null) 
	{
		pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
		//System.out.println("pgcnt is   99999999999  "+pgcnt);
	}
	else
	{
		pgcnt = 1;
		//System.out.println("pgcnt *************is    "+pgcnt);	
	}
	if(request.getParameter("gopg") !=  null) 
	{
		GOPG = Integer.parseInt(request.getParameter("gopg"));
		//System.out.println("Go pg /////////////no is    "+GOPG);
		pgcnt = GOPG;
	}
	else 
	{
		GOPG=0;
	}

	String FDATE = String.valueOf(session.getAttribute("fdate"));
	//System.out.println("fdate is in temp is   "+FDATE);
%>

<html>
<head>
<title> WaterSoft </title>
<script>
window.history.forward(1);
</script>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<body bgcolor="#edf2f8"><%	//out.println(query);%>

<form name=f1 method="post" action="./rws_hab_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="10">
			<font size="2">Habitation Status Excel Report </font></td>
	</tr>

	<tr>
	<td align="center" class="mystyle1" colspan="10"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	</tr>
	
<% if(session.getAttribute("mName")!=null){%>
<tr>
<td align="center" class="mystyle1" colspan="10"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<tr>
<td align="center" class="mystyle1" colspan="10"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
<%}if(!FDATE.equals("null") && !FDATE.equals("0") )
	{%>
<tr>
	<td class="textborder" align="center" colspan="10">
	<font size=2>Status As On : </font><font color=#F2A80D> <%=FDATE %> </font></font></td>
	</tr>
<% }%>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<% 
	if(GOPG<=((myList1.size()/20)+1))
	{
	%>
	<tr >
		<td  class = btext>S.No</td>
		<td  class = btext>Habitation Name</td>
<%
		for(j=1; j<labelNames.length;j++ )
		{
%>
		<td class = btext><%= labelNames[j] %></td>
<%
		}
%>
		</tr>

<%}
		
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		 
		String GoPg1=request.getParameter("gopg");
		//System.out.println("go pg is "+GoPg1);
	    if(request.getParameter("gopg") !=  null) 
		{
			GOPG = Integer.parseInt(request.getParameter("gopg"));
			//System.out.println("Go pg no is    "+GOPG);
			if(GOPG==1)
			{
				start= 0;
				end = start + limit;
			}
			else if(GOPG<=((myList1.size()/20)+1))
			{
				start=(GOPG * 20)-20;
				end = start + limit;
			}
			else
			{ %><tr align="center" class="btext"><td>
				<%= "Invalid  Valid Page Number Enetered" %></td></tr>
				<%
				//start=GOPG;
				start=mylists1;
				}
		}


		for(int z = start,sno=start+1; z<end; z++,sno++)
		{	
			if(mylists1>z)
			{		
				String[] record1 =(String[])myList1.get(z);		
				//System.out.println("valiue of   "+record1.length);
				String distcode=record1[0];
				String mandcode=record1[1];
				
				slno++;
		
%>
		<tr align=left bgcolor="#ffffff">
		<td class="mystyle1"><%= sno%></td>
		<td class="mystyle1"> <%=record1[0]%> </td>
<%
	 		String stacov =null;	
			for(int k=1;k<labelNames.length;k++)
			{
				 stacov= record1[k];
			if(!stacov.equals("UI"))
			{%>
			<td class="mystyle1"><%=record1[k]%></td>
			<%} else { %>
				<td class="mystyle1">UI</td>
			<%} 
			}%>

</tr>
<%	
		}	 
	}
	
	

%>
</table>
</TD>
</TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>