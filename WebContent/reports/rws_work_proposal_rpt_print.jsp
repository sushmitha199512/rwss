
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>


<%	
	int start,end,limit =10,slno=0,j,pgcnt,pgno=0;
	int line=0;	
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	String stt=request.getParameter("start");

	
	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("workLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	

	ArrayList workList1 = (ArrayList)session.getAttribute("workList");
	Iterator iterator = workList1.iterator();
	int workslists1=workList1.size();
	
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
			////System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
		}

			/*if(mylists1>=(end-1))
			{
				//System.out.println("mylist is     "+start);
					
				if(request.getParameter("slno") !=  null) 
				{
					slno = Integer.parseInt(request.getParameter("slno"));
					//System.out.println("slno is    "+slno);
				}
				else
				{
					slno = 0;
					//System.out.println("slno is    "+slno);	
				}
	
			}					
			else
			{	//System.out.println("end  is     "+end);
				slno=0;
			}*/
	

 %>
 
<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font>
<br>
<table  width="112%">
	<tr>
	<td align="center" class="mystyle1"><font color="navy"><h5>Work Proposal Habitation Report</h5></font></td>
	</tr>
	<tr align="right">
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>

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
.btest1
{
	border-width:1;
	color:black;
	font-family:bold;
	font-size:8pt;
}
</style>
</head>
<body>
<table border = 0 cellspacing = 0 cellpadding = 0 width=100%  height="68%" bordercolor=#000000 style="border-collapse:collapse" >
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
	<tr>
		<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
<tr> <%if(session.getAttribute("repname")!=null){%>
<td align="center" class="mystyle1"><font color="#9900CC">Represented By: <%= session.getAttribute("repname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="#9900CC">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("Fyr")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="#9900CC">Finantial Year: <%= session.getAttribute("Fyr") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"> 	
	<%if(session.getAttribute("atname")!=null){%>
<tr ><td align=center colspan=12 class="mystyle1"><font color=#6600FF>Asset Type:&nbsp;&nbsp; <%=session.getAttribute("atname") %> </font></td><%}%>
	<tr>
		<td rowspan=2 ><b>S.No</td>
		<td rowspan=2 ><b>Work Name</td>
		<td rowspan=2 ><b>Habitation</td>
		<%
		for(j=5; j<labelNames.length;j++ ) {
			if(j<=12)
			{%>
		<td ><b><%= labelNames[j] %></td>
	<%
			} }%>
			</tr>
			<tr>
					<%		
			for(j=13; j<labelNames.length;j++ ) {
			if(j>=13){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td ><b><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
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
		
		for(int z = start,sno=start+1; z < workslists1; z++,sno++)
		{	
			if(workslists1>z)
			{		
		String[] record1 =(String[])workList1.get(z);		
		String distcode=record1[3];
		String mandcode=record1[4];

		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				//slno++;
				%>		<tr align=left>
						<td class="mystyle1"><%= sno%></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td> 
					<% 
			for(int k=5; k<labelNames.length;k++ ) {
			if(k<=12){

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
		<%} }
	}%>
			</tr>
					<tr>
					<td class="mystyle1"></td>
					<td class="mystyle1"></td> 
					<td class="mystyle1"></td> 
					
				<%	
		
		for(int k=13; k<labelNames.length;k++ ) {
			if(panchcode[k]==null){
			panchcode[k]= record1[k];			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= record1[k]%></td>
		
					<%} else if(panchcode[k].equals( record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]= record1[k];
			%>
		<td class="mystyle1"><%= record1[k]%></td>
		<%} } %>
		</tr>

<%				}
				else
				{
					////System.out.println("heello");
					temp= record1[3];
					temp1= record1[4];
				//	temp2=rs.getString(3);
%>
					<td class="mystyle1"><%= sno%></td>
				<!-- 	<td colspan=2 class="mystyle1"></td> tbis chagne 25/2 -->
					<td  class="mystyle1"></td> 
					<td   class="mystyle1"><%= record1[4]%></td>
					
				<%	
		
		for(int k=5; k<labelNames.length;k++ ) {
			if(k<=12){
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
			<%} } }%>
	</tr>
				<tr>
				<td class="mystyle1"></td>
				<td class="mystyle1"></td> 
				<td class="mystyle1"></td> 					
							<%	
		
	for(int k=13; k<labelNames.length;k++ ) {
			if(panchcode[k]==null){
			panchcode[k]= record1[k];			
						// //System.out.println("EEEEEEEEEEEEEEEEEE"+k +"is "+panchcode[k]);
		%>
			<td class="mystyle1"><%= record1[k]%></td>
		
					<%} else if(panchcode[k].equals( record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]= record1[k];
			%>
		<td class="mystyle1"><%= record1[k]%></td>
		<%} } %>

		</tr>

<%				}
			}
			
		else
		{
			slno++;
			temp= record1[3];
			temp1= record1[4];
			//temp2=rs.getString(3);
			if(line>0){%>
				<tr>
				<td colspan=10 ><b><%= "   "%></td></tr>
				<%
					%></tr><% } line++;%>
		<tr align=left >
			<td rowspan=2 class="mystyle1"><%= sno%></td>
			<td rowspan=2 class="mystyle1"><%=  record1[3]%></td>
			<td rowspan=2 class="mystyle1"><%= record1[4]%></td>
		
<%	
		for(int k=5; k<labelNames.length;k++ ) {
		if(k<=12){
		if(panchcode[k]==null){
			panchcode[k]= record1[k];			
						 
						if(labelNames[k].equals("Prepared At"))
						{%>
			<td class="mystyle1"><%=RS1.getOfficeName(record1[k],true) %></td>
			<%} else {%>
			<td class="mystyle1"><%=record1[k] %></td>
		
					<%} }else if(panchcode[k].equals(record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]= record1[k];
				if(labelNames[k].equals("Prepared At"))
						{%>
			<td class="mystyle1"><%=RS1.getOfficeName(record1[k],true) %></td>
			<%} else {%>		
	
		<td class="mystyle1"><%= record1[k]%></td>
		<%} } } }%>
		</tr>
				<tr>
				<!-- <td class="mystyle1"></td>
				<td class="mystyle1"></td>  -->
					
			<%	
		
	for(int k=13; k<labelNames.length;k++ ) {
		 if(panchcode[k]==null){
			panchcode[k]= record1[k];			
						
						if(labelNames[k].equals("Prepared At"))
						{%>
			<td class="mystyle1"><%=RS1.getOfficeName( record1[k],true) %></td>
			<%} else {%>		
			<td class="mystyle1"><%=  record1[k]%></td>
		
					<%} }else if(panchcode[k].equals( record1[k])){ %>
					
		<td class="mystyle1"></td> 
		<%}else{
			panchcode[k]= record1[k];
				if(labelNames[k].equals("Prepared At"))
				{%>
				<td class="mystyle1"><%=RS1.getOfficeName(record1[k],true) %></td>
			<%} else {%>		
	
		<td class="mystyle1"><%=  record1[k]%></td>
		<%} }			
			} %>
		</tr>

<% 
	}
	}//end of if
		}   //end of for
	
	}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
	//conn.close();
	}

%>
</table>
</TD></TR>
</TABLE>

<table>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>

</body>
</html>
