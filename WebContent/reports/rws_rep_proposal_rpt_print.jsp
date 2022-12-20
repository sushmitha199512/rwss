
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>


<%	
	int start,end,limit =10,slno=0,j,LNO;
	int line=0;	
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	String stt=request.getParameter("start");

	
	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("repLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	

	ArrayList repList1 = (ArrayList)session.getAttribute("repList");
	Iterator iterator = repList1.iterator();
	int mylists1=repList1.size();
	

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
<table  width="100%">
	<tr  align=center>
	<td align="center" class="mystyle1"><font color="black"><h5>Representative Proposal Habitation Report</h5></font></td>
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
	font-size:7pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:7pt;
}
.test1
	{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:7pt;
}
</style>
</head>
<body>
<table border = 0 cellspacing = 0 cellpadding = 0 width=100%  height="68%" bordercolor=#000000 style="border-collapse:collapse" >
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
	<tr>
		<td align="center" class="mystyle1"><font color="black">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="black">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="black">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
<tr align=center> <%if(session.getAttribute("repname")!=null){%>
<td align="center" class="mystyle1"><font color="black">Represented By: <%= session.getAttribute("repname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="black">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("Fyr")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="black">Finantial Year: <%= session.getAttribute("Fyr") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
<%if(session.getAttribute("atname")!=null){%>
<tr><td align=center colspan=3 class="mystyle1"><font color=black>Asset Type:&nbsp;&nbsp; <%=session.getAttribute("atname") %> </font></td><%}%>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td class="test1" rowspan=2 ><b>S.No</td>
		<td class="test1" rowspan=2 ><b>Work Name</td>
		<td class="test1" rowspan=2 ><b>Habitation</td>
		

		<%
		for(j=5; j<labelNames.length;j++ ) {
			if(j<=13)
			{%>
		<td class="test1"><b><%= labelNames[j] %></td>
	<%
			} }%>
			</tr>
			<tr>
					<%		
			for(j=14; j<labelNames.length;j++ ) {
			if(j>=14){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td class="test1"><b><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
	</tr>	
<%	LNO=6;
	try
	{		
		
//		int slno=0;
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		String panchcode[]=new String[labelNames.length];		
		
		for(int z = 0,sno=1; z<mylists1; z++,sno++)
		{	
				if(mylists1>z && LNO<=50)
			{		
		String[] record1 =(String[])repList1.get(z);		
		String distcode=record1[3];
		String mandcode=record1[4];

		if(temp.equals(distcode))
			{
			if(temp1.equals(mandcode))
			{
				//sno++;
				%>		<tr align=left>
						<td class="mystyle1"><%= sno%></td>
						<td class="mystyle1"></td>
						<td class="mystyle1"></td> 
					
					<% 
			for(int k=5; k<labelNames.length;k++ ) {
			if(k<=13){

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
					
				<%	
		
		for(int k=14; k<labelNames.length;k++ ) {
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
					
					temp= record1[3];
					temp1= record1[4];
				//	temp2=RS.getString(3);
%>
					<tr align=left colspan=2 bgcolor="#ffffff">
				<!-- 	<td colspan=2 class="mystyle1"></td> tbis chagne 25/2 -->
					<td class="mystyle1"><%= sno%></td>
					<td  class="mystyle1"></td>
					<td   class="mystyle1"><%= record1[4]%></td>
					<%	
		
		for(int k=5; k<labelNames.length;k++ ) {
			if(k<=13){
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
		
	for(int k=14; k<labelNames.length;k++ ) {
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
			 
			//slno++;
			temp= record1[3];
			temp1= record1[4];
			//temp2=RS.getString(3);
			if(line>0){%>
				<tr>
				<td colspan=10 ><%= "   "%></td></tr>
				<%
					%></tr><% } line++;%>
		<tr align=left >
			<td rowspan=2 class="mystyle1"><%= sno%></td>
			<td rowspan=2 class="mystyle1"><%=  record1[3]%></td>
			<td rowspan=2 class="mystyle1"><%= record1[4]%></td>
	<%	
		for(int k=5; k<labelNames.length;k++ ) {
		if(k<=13){
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
		
	for(int k=14; k<labelNames.length;k++ ) {
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
		
	if(j>15)
				LNO=LNO+2;
		else
				LNO++;
			}		//end of if loop
			else{
				
				LNO=6;
				z--; sno--;
				////System.out.println("Valie os Z ias "+z);
				%>
<table align=center>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>
</TABLE>
		<p style="page-break-before:always">
	
<table align="center" width="100%">
	<tr>
	<td align="center" class="mystyle1"><font color="navy"><h5>Habitation  Status  Report</h3></font></td>
	</tr>
	<tr>
	<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" >
	<tr><td valign=top>
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
	<tr>
		<td align="center" class="mystyle1"><font color="black">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="black">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="black">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
<tr align=center> <%if(session.getAttribute("repname")!=null){%>
<td align="center" class="mystyle1"><font color="black">Represented By: <%= session.getAttribute("repname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="black">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("Fyr")!=null){%>
<td align="center" class="mystyle1" nowrap><font color="black">Finantial Year: <%= session.getAttribute("Fyr") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
<%if(session.getAttribute("atname")!=null){%>
<tr><td align=center colspan=3 class="mystyle1"><font color=black>Asset Type:&nbsp;&nbsp; <%=session.getAttribute("atname") %> </font></td><%}%>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td rowspan=2 ><b>S.No</td>
		<td rowspan=2 ><b>Work Name</td>
		<td rowspan=2 ><b>Habitation</td>
		

		<%
		for(j=5; j<labelNames.length;j++ ) {
			if(j<=13)
			{%>
		<td ><b><%= labelNames[j] %></td>
	<%
			} }%>
			</tr>
			<tr>
					<%		
			for(j=14; j<labelNames.length;j++ ) {
			if(j>=14){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td ><b><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
	</tr>	

</p>
<%} //END  OF ELSE
} // end of for loop

	}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
//	conn.close();
	////System.out.println("The slno is="+slno);
	}

%>
</table>
</TD></TR>
</TABLE>
</body>
</html>

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
