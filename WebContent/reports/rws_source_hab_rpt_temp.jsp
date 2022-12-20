<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>

<%	

	int start,end,limit =20,j,slno=0,pgcnt,pgno=0;
	int line=0;	
	String stt=request.getParameter("start");

	
	if(request.getParameter("start") !=  null) {
		start = Integer.parseInt(request.getParameter("start"));

		}
		else
		{
			start = 0;
	
		}
		
		if(request.getParameter("slno") !=  null) {
		slno = Integer.parseInt(request.getParameter("slno"));

		}
		else
		{
			slno = 0;
	
		}
		end = start + limit;

	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();

	int mylists1=myList1.size();
		
	
	if(request.getParameter("pgcnt") !=  null) {
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
			////System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
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
			
				<a href="./rws_source_hab_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<%
			for(int r=0,s=1;r<myList1.size(); r+=10,s++) { 
			// //System.out.println("panchayat  name is ");		
			if(pgcnt==s)
			{ 
			%>
			
			<a href="rws_source_hab_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_source_hab_rpt_excel_print.jsp"target="_new">Excel</a>
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
			<font color="ffffff">Source Habitation  Report </font></td>
	</tr>
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
	<td align="center" class="mystyle1"><font color="navy">Source Type Name: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Sub Source Type Name: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>

</table>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

	<tr >
		<td class = btext>S.No</td>
		
		
		<%		int i=0;
				for(j=0; j<labelNames.length;j++ ) {			
			%>
		<td class = btext><%= labelNames[j] %></td>
	<%
			} %>
	</tr>	
<%	
	try
	{		
		
		//int slno=0;
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		String panchcode[]=new String[labelNames.length];		
		
		for(int z = start,sno=start+1; z < end; z++,sno++)
		{	
		if(mylists1>z)
			{		
		String[] record1 =(String[])myList1.get(z);		
		String distcode=record1[0];
		String mandcode=record1[1];
		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				
				%>		<tr align=left bgcolor="#ffffff">
						<td class="mystyle1"></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td> 
					
								<% 
			for(int k=2; k<labelNames.length;k++ ) {
			

			if(panchcode[k]==null){
				panchcode[k]=record1[k];			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= record1[k]%></td>
		
					<%} else if(panchcode[k].equals(record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]=record1[k];
			%>
		<td class="mystyle1"><%= record1[k]%></td>
		<%} 
	}%>
		</tr>
<%				}
				else
				{
						////System.out.println("heello");
					temp= record1[0];
					temp1= record1[1];
				//	temp2=rs.getString(3);
%>
					<tr align=left bgcolor="#ffffff">
				<!-- 	<td colspan=2 class="mystyle1"></td> tbis chagne 25/2 -->
					<td class="mystyle1"><%= sno%></td>
					<td  class="mystyle1"></td> 
					<td   class="mystyle1"><%= record1[1]%></td>
					
				<%	
		
		for(int k=2; k<labelNames.length;k++ ) {

			if(panchcode[k]==null){
				panchcode[k]= record1[k];			
							// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
			%>
				<td class="mystyle1"><%=record1[k]%></td>
			
						<%} else if(panchcode[k].equals(record1[k])){ %>
						
			<td class="mystyle1"></td> 
			<%}else{
				panchcode[k]=record1[k];
				%>
			<td class="mystyle1"><%= record1[k]%></td>
			<%} } %>
				
		</tr>
<%				}
			}
			
		else
		{		
			slno++;
			temp= record1[0];
			temp1= record1[1];
			//temp2=rs.getString(3);
			%>
		<tr align=left >
			<td  class="mystyle1"><%= sno%></td>
			<td  class="mystyle1"><%=  record1[0]%></td>
			<td  class="mystyle1"><%= record1[1]%></td>
		
<%		
		
		for(int k=2; k<labelNames.length;k++ ) {

			if(panchcode[k]==null){
				panchcode[k]= record1[k];			
							// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
			%>
				<td class="mystyle1"><%=record1[k]%></td>
			
						<%} else if(panchcode[k].equals(record1[k])){ %>
						
			<td class="mystyle1"></td> 
			<%}else{
				panchcode[k]=record1[k];
				%>
			<td class="mystyle1"><%= record1[k]%></td>
			<%} }			
			 %>
		</tr>

<% 
	}
	}//end of if 
		}//end of for
	}
	catch(Exception ee)
	{
	 //System.out.println("The error is="+ee);
	}
	
%>
</table>
</TD></TR>
</TABLE>
<table border=0 align=center width="30%">
<tr><td align="center"  class=mystyle1>GO TO PAGE :</td>
<td align="left" class=mystyle1><%for(int r=0,s=1;r<myList1.size(); r+=20,s++) { 
		// //System.out.println("panchayat  name is ");		
		if(pgcnt==s)
		{ 
		%><font color=red>	<%=s%></font>
		<%			
		}
		else {
			%>
			
		<a href="rws_asset_hab_off_rpt_temp.jsp?start=<%=r%>&slno=<%=slno%>&pgcnt=<%=s%>"><%=s%></a>
<% 			}%>

				
		<%
		}

		%>
<td></table>
</body>
</html>
<%@ include file = "footer.jsp" %>