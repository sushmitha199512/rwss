<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@ include file = "header_rpt.jsp" %>

<%		
//java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	int start,end,limit =20,j,slno=0,pgcnt,pgno=0;
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
			//System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			//System.out.println("pgcnt is    "+pgcnt);	
		}
	


	
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
<form name=f1 action="<%= request.getRequestURI()%>">
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
				<a href="./rws_hab_status_form.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
					
					 <% 
					
			for(int r=0,s=pgcnt;r<myList1.size(); r+=10,s++) { 
			// //System.out.println("panchayat  name is ");		
			if(pgcnt==s)
			{ 
			%>
			
			<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_hab_rpt_excel_print.jsp?start=<%=r%>&slno=<%=slno%>&pgcnt=<%=s%>"
				 target="_new">Excel</a>
				<%			
		}
		}

		%>
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
<%}%>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
		<td rowspan=2 class = btext>S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		<% if(session.getAttribute("dName")==null){ %>
		<td rowspan=2 class = btext>District Name</td> <% } %>

		<!-- <td class="mystyle">Mandal Name</td>	 -->
		<% if(session.getAttribute("mName")==null){ %>
		<td rowspan=2 class = btext>Mandal Name</td> <% } %>

		<!-- <td class="mystyle">Panchayat Name</td> -->
		<% if(session.getAttribute("pName")==null){ %>
		<td rowspan=2 class = btext>Panchayat Name</td> <% } %>

		<td rowspan=2 class = btext>Habitation Name</td>

		<%
			for(j=4; j<labelNames.length;j++ )
			{
				if(j<=13)
				{
			%>
				<td class = btext><%= labelNames[j] %></td>
			<%
				} 
			}%>
			</tr>
			<tr>
			<%		
			for(j=13; j<labelNames.length;j++ ) {
			if(j>13){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td class = btext><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
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
				else
				{
					start=(GOPG * 20)-20;
					end = start + limit;
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
				if(temp.equals(distcode))
				{
					if(temp1.equals(mandcode))
					{
						if(temp2.equals(panchcode))
						{
		%>					<tr align=left bgcolor="#ffffff">
								<td class="mystyle1"><%= sno%></td>
								<!-- <td class="mystyle1"></td> -->
								<% if(session.getAttribute("dName")==null){ %>
								<td class="mystyle1"> </td> <% } %>

								<!-- <td class="mystyle1"></td> -->
								<% if(session.getAttribute("mName")==null){ // //System.out.println("888888888888888888"); %>
								<td class="mystyle1"> </td> <% } %>

							<!-- 	<td class="mystyle1"></td> -->
					<% if(session.getAttribute("pName")==null){ // //System.out.println("888888888888888888"); %>
		<td class="mystyle1"> </td> <% } %>
			
					<td class="mystyle1"><%=record1[3]%></td>
					<%		
						for(int k=4; k<labelNames.length;k++){
							if(k<=13){
								if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==14){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>13){ if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
		}
			if(k==labelNames.length && k>13){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

			}
				else
				{	temp=record1[0];
					temp1=record1[1];
					temp2=record1[2];
%>
					<tr align=left bgcolor="#ffffff">
					<td class="mystyle1"><%= sno%></td>
					<!-- <td class="mystyle1"></td> -->
					 <% if(session.getAttribute("dName")==null){ %>
					<td class="mystyle1"> </td> <% } %>

					<!-- <td class="mystyle1"></td> -->
					<% if(session.getAttribute("mName")==null){ // //System.out.println("999999999999");%>
					<td class="mystyle1"> </td> <% } %>


					<% if(session.getAttribute("pName")==null){  %>
		<td class="mystyle1"><%=record1[2]%> </td> <% } %>
					<td class="mystyle1"><%=record1[3]%></td>
					
					<% 
						for(int k=4;k<labelNames.length;k++){
							if(k<=13){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==14){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>13){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}	}
			if(k==labelNames.length && k>13){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

				}
			}
			else
			{
					temp=record1[0];
					temp1=record1[1];
					temp2=record1[2];
		%>
			<tr align=left bgcolor="#ffffff">
				<td class="mystyle1"><%= sno%></td>
				<!-- <td class="mystyle1"></td> -->
				 <% if(session.getAttribute("dName")==null){ %>
				<td class="mystyle1"> </td> <% } %>


				 <% if(session.getAttribute("mName")==null){// //System.out.println("0000000000000000"); %>
				<td class="mystyle1"><%= record1[1]%> </td> <% } %>

				
				 <% if(session.getAttribute("pName")==null){ %>
				<td class="mystyle1"><%= record1[2]%> </td> <% } %>
				

				<td class="mystyle1"><%=record1[3]%></td>
					<% 
						 for(int k=4;k<labelNames.length;k++){
							if(k<=13){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==14){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>13){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
		}
			if(k==labelNames.length && k>13){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

}
	
		}
		else
		{
					temp=record1[0];
					temp1=record1[1];
					temp2=record1[2];
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>

			<% if(session.getAttribute("dName")==null){ %>
		<td class="mystyle1"> <%=record1[0]%> </td> <% } %>


<% if(session.getAttribute("mName")==null){ %>
		<td class="mystyle1"> <%=record1[1]%> </td> <% } %>


<% if(session.getAttribute("pName")==null){ %>
		<td class="mystyle1"> <%=record1[2]%> </td> <% } %>

			<td class="mystyle1"><%=record1[3]%></td>
				<% 			
						for(int k=4;k<labelNames.length;k++){
							if(k<=13){
								if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
									}

						 else if(k==14){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			 if(k<labelNames.length && k>13){
			 
			 if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
						<%}
			
			} if(k==labelNames.length && k>13){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
			 
}%>

</tr>
<%	}
			}	 
	}
	
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
<table border=0 align=center width="100%">
<tr><td align="center" nowrap class=mystyle1>GO TO PAGE :</td>
 <td class = btext><input size = 3 type="text" name="gopg" class="btext" onchange="this.form.submit()" >
 </td>
<td align="left" class=mystyle1>
<% 

if(pgcnt!=1)
{
%>
<a href="rws_hab_rpt_temp.jsp?start=<%=start-20%>&slno=<%=slno%>&pgcnt=<%=pgcnt-1%>"><font   color=blue>Previous </font></a>
<%
}
	
for(int r=start,s=pgcnt,lim=1;r<myList1.size(); r+=20,s++,lim++) { 
		// //System.out.println("panchayat  name is ");		
		if(pgcnt==s)
		{ 
		%><font color=red>	<%=s%></font>
		
		<%			
			r1=r+20;
			s1=s+1;

		}
		else {
			if(lim<=20)
			{
				//lim=1;
			%>
			
		<a href="rws_hab_rpt_temp.jsp?start=<%=r%>&slno=<%=slno%>&pgcnt=<%=s%>"><%=s%></a>
		
		
<%		 
	}
		}
		
		}
		//System.out.println("slno is "+slno);
		if((start+20)<=myList1.size())
		{
		%>
		<a href="rws_hab_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=blue>Next </font></a>
		<%}
			%>
</td>
<%
 if(request.getParameter("gopg") ==  null) 
	{
%>
<td align="right" class=mystyle1>Page <font color=red><%= pgcnt %></font> of <font color=blue> <%= (myList1.size()/20)+1 %></font>
<%
	} else {
%>
<td align="right" class=mystyle1>Page <font color=red><%= request.getParameter("gopg") %></font> of <font color=blue> <%= (myList1.size()/20)+1 %></font>
<% 
	start=0;
	pgcnt=1;
	}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>