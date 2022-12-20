<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ include file = "header_rpt.jsp" %>

<%		
//java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	int start,end,limit =25,  j, slno=0, pgcnt, pgno=0;
	int line=0;	
		int r1=0, s1=1, GOPG;
	String st=request.getParameter("start");
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	////System.out.println("lebal are  count  "+labelNames.length);
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	if(request.getParameter("start") !=  null) 
		{
			start = Integer.parseInt(request.getParameter("start"));
			//System.out.println("start is    "+start);

		}
		else
		{
			start = 0;
	
		}
		end = start + limit;
		////System.out.println("end value is   "+end);
		if(request.getParameter("pgcnt") !=  null) {
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
			////System.out.println("pgcnt is   99999999999  "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt *************is    "+pgcnt);	
		}
	if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				////System.out.println("Go pg /////////////no is    "+GOPG);
				pgcnt = GOPG;
			}
			else 
			{
				GOPG=0;
				}

	String FDATE = String.valueOf(session.getAttribute("fdate"));
	String TDATE = String.valueOf(session.getAttribute("tdate"));
	//System.out.println("fdate is in temp is   "+FDATE);
	
 %>

<html>
<head>
<title> WaterSoft </title>
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


<form name=f1 action="./rws_hab_dist_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">



<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_consti_hab_status_form.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
			<!-- 	<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_hab_rpt_excel_print.jsp"	 target="_new">Excel</a> -->
				</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation  Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
	<!-- <td align="center" class="mystyle1"><font color="navy">District:ALL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td> -->
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(!FDATE.equals("null") && !FDATE.equals("0") && !TDATE.equals("null") && !TDATE.equals("0"))
	{%>
<tr >
		<td class="textborder" align="center">
				<font size=2>Status Dates Between: </font><font color=#F2A80D> <%=FDATE %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= TDATE %></font></td>
	</tr>
	<% }%>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<% 
				if(GOPG<=((myList1.size()/20)+1))
				{
	%>
	<tr >
		<td  class = btext>S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		<% if(session.getAttribute("dName")==null){ %>
		<td  class = btext>District Name</td> <% } %>

		<!-- <td class="mystyle">Mandal Name</td>	 -->
		
		<%
			for(j=2; j<labelNames.length;j++ )
			{
				
			%>
				<td class = btext><%= labelNames[j] %></td>
			<%
				 
			}
				}%>
			</tr>
			
<%
	try
	{		
		
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
				////System.out.println("valiue of   "+record1.length);
				String distcode=record1[0];
				String mandcode=record1[1];
				String panchcode=record1[2];

				slno++;
				
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>

			
			<% if(session.getAttribute("dName")==null){ %>
			<td class="mystyle1">
			<a href="rws_hab_mand_status_rpt.jsp?dcode=<%=record1[0]%>&dname=<%=record1[1]%>">
			<%=record1[1]%></a></td> 
			<% } %>

				<% 			
						for(int k=2;k<labelNames.length;k++){
							%>
<td class="mystyle1"><%=record1[k]%></td>

						
						<%} 
			 
}%>

</tr>
<%	}
			}
	catch(Exception ee)
	{
	//System.out.println("sadiq The error is="+ee);
	}
	
finally
{
	
	}

%>
</table>
</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>