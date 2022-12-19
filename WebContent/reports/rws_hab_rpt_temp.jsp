<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%		
 
	int start,end,limit =20,  j, slno=0, pgcnt, pgno=0;
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
		if(request.getParameter("pgcnt") !=  null) {
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
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_status_form.jsp">Back </a>|
				<a href="../home.jsp">Home </a>|
				<a href="./rws_hab_status_rpt_xls.jsp" target="_new">Excel</a>
		        <!--<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a> -->
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
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(!FDATE.equals("null") && !FDATE.equals("0") )
	{%>
<tr >
		<td class="textborder" align="center">
				<font size=2>Status As On : </font><font color=#F2A80D> <%=FDATE %> </font></font></td>
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
		
		<td  class = btext>Habitation Name</td>

		<%
			for(j=1; j<labelNames.length;j++ )
			{
				
			%>
				<td class = btext><%= labelNames[j] %></td>
			<%
				 
			}%>
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

				<% 		String stacov =null;	
						for(int k=1;k<labelNames.length;k++){
							 stacov= record1[k];
							 if(!stacov.equals("UI"))
							{
							try
							{
							double d=Double.parseDouble(""+record1[k]);
							{
							%> 
							<td class="mystyle1" align="right"><%=record1[k]%></td>
							<%
							}
							}
							catch(Exception eee){
							%> 
							<td class="mystyle1" align="left"><%=record1[k]%></td>
							<%}
												
							} else { %>
							<td class="mystyle1">UI</td>
							<%} }%>

							</tr>
							<%	
			}	 
	}
	
	

%>
</table>
</TD></TR>
</TABLE>
<table border=0 align=center width="90%">
<tr><td align="RIGHT" nowrap class=mystyle1>GO TO PAGE :</td>
 <td class = mystyle1><input size = 3 type="text" name="gopg"  onchange="this.form.submit()" >
 </td>
<td align="left" class=mystyle1 align="right">
<%
for(int r=start,s=pgcnt,lim=1;r<myList1.size(); r+=20,s++,lim++) { 
		// System.out.println("panchayat  name is   "+pgcnt);		
		if(pgcnt==s)
		{ 
			r1=r+20;
			s1=s+1;

		}	
		}
		if(request.getParameter("gopg") ==  null) 
	{
%>
<td align="right" class=mystyle1>Page <font color=red><%= pgcnt %></font> of <font color=blue> <%= (myList1.size()/20)+1 %></font>
<%
	} else {
%>
<td align="right" class=mystyle1>Page <font color=red><%= request.getParameter("gopg") %></font> of <font color=blue> <%= (myList1.size()/20)+1 %></font>
<% 
	//start=0;
	//pgcnt=1;
	}
	
		if((start+20)<=myList1.size())
		{
		%>
		<a href="rws_hab_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font color=blue>Next </font></a>
		<%}
			
 %>

</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>