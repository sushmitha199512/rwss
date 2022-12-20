<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>
<%	
	int start,end,limit =20,slno=0,j,pgcnt,pgno=0;
	int line=0;	
	int r1=0, s1=1, GOPG;
	String stt=request.getParameter("start");

	
	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("repLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	/*while(label1.hasNext())
	{	
		labelNames =(String[]) label1.next();
		for(int l=0;l<labelNames.length;l++)
		{
		//System.out.println("index is  "+l+"   name is   "+ labelNames[l]);
		}
	}
	//System.out.println("LABEEK LENGHT IS   "+labelNames.length);*/

	ArrayList myList1 = (ArrayList)session.getAttribute("repList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	////System.out.println("dffffffffffff   "+mylists1);
	
	/*int sno=0;
	String[] it=(String[])myList1.get(5);
	//while(iterator.hasNext())
		{      
			 //record =(String[]) iterator.next();
			for(int l=0;l<it.length;l++)
		{
			//Debug.print("*******        "+l+"      " );
		//System.out.println("index is  "+l+"   name is   "+ it[l]);
		}
	}
	////System.out.println("LABEEK LENGHT IS   "+record.length);*/
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

		if(request.getParameter("slno") !=  null) {
		slno = Integer.parseInt(request.getParameter("slno"));

		}
		else
		{
			slno = 0;
	
		}

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
	if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				////System.out.println("Go pg no is    "+GOPG);
				pgcnt = GOPG;
			}
			else 
				GOPG=0;


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

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<%	//out.println(query);%>

<form name=f1 action="./rws_rep_proposal_hab_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				
				<a href="./rws_rep_proposal_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>		
				<a href="rws_rep_proposal_rpt_print.jsp"        target="_new">Print&nbsp;|&nbsp;</a>
				<a href="rws_rep_proposal_rpt_excel_print.jsp"  target="_new">Excel</a>
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11"><font color="ffffff">Representative Proposal Habitation  Report</font></td>
	</tr>
<tr><td>
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
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
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" >	<%if(session.getAttribute("atname")!=null){%>
<tr ><td align=center colspan=12 class="mystyle1"><font color=#6600FF>Asset Type:&nbsp;&nbsp; <%=session.getAttribute("atname") %> </font></td><%}%>
	<tr>
<%
	if(GOPG<=((myList1.size()/20)+1))
				{%>
		<td rowspan=2 class="btext">S.No</td>
		<td rowspan=2 class="btext">Work Name</td>
		<td rowspan=2 class="btext">Habitation</td>
		

		<%
		for(j=5; j<labelNames.length;j++ ) {
			if(j<=13)
			{%>
		<td class = btext><%= labelNames[j] %></td>
	<%
			} }%>
			</tr>
			<tr>
					<%		
			for(j=14; j<labelNames.length;j++ ) {
			if(j>=14){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td class = btext><%= labelNames[j] %></td>
	<%
			} 	 } 
				}%>
		
	</tr>	
<%
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
					start=GOPG;
					mylists1=0;
					}
			}

		for(int z = start,sno=start+1; z<end; z++,sno++)
		{	
			if(mylists1>z)
			{		
		String[] record1 =(String[])myList1.get(z);		
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
				<td colspan=10 class="btext"><%= "   "%></td></tr>
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
		
	} //end of if loop
}// end of for loop
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
<table border=0 align=center width="100%">
<tr><td align="RIGHT" nowrap class=mystyle1>GO TO PAGE :</td>
 <td class = mystyle1><input size = 3 type="text" name="gopg"  onchange="this.form.submit()" >
 </td>
<td align="left" class=mystyle1>
<%
for(int r=start,s=pgcnt,lim=1;r<myList1.size(); r+=20,s++,lim++) { 
		// //System.out.println("panchayat  name is   "+pgcnt);		
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
		<a href="rws_rep_proposal_hab_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=#FF00CC>Next </font></a>
		<%}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>