<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>


<%@ include file = "header_rpt.jsp" %>
<%	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	Statement st5=null,st6=null;
	ResultSet rs5=null,rs6=null;
	int start,end,limit =20,slno=0,j,pgcnt,pgno=0;
	int line=0;	
	int r1=0, s1=1, GOPG;
	String pid=null;
	String wid=null;
	String stt=request.getParameter("start");
	
	RwsOffices RS1=(RwsOffices)session.getAttribute("RSet1");
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("repLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	

	ArrayList myList1 = (ArrayList)session.getAttribute("repList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	//System.out.println("name of  count is  "+mylists1);
		
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

		/*if(request.getParameter("slno") !=  null) {
		slno = Integer.parseInt(request.getParameter("slno"));

		}
		else
		{
			slno = 0;
	
		}*/

		if(request.getParameter("pgcnt") !=  null) {
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
			////System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
		}

	if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				//System.out.println("Go pg no is    "+GOPG);
				pgcnt = GOPG;
			}
			else 
				GOPG=0;

String fdat=String.valueOf(session.getAttribute("fdate"));
String tdat=String.valueOf(session.getAttribute("tdate"));
String rCde=String.valueOf(session.getAttribute("repcode"));
String rpName=String.valueOf(session.getAttribute("repname"));
//System.out.println("rp name is   "+rpName);
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

<form name=f1 action="./rws_proposal_pendency_consti_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

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
			
				<a href="./rws_proposal_pendency_rep_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
		
			<a href="rws_proposal_pendency_rep_rpt_print.jsp"        target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_proposal_pendency_rep_rpt_xsl.jsp"  target="_new">Excel</a>
				
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11"><font color="ffffff">Pendency Status Details Report</font></td>
	</tr>
<tr><td>
	

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" >	
	<tr>
<% if(fdat!=null && !fdat.equals("0") && tdat!=null && !tdat.equals("0"))
	{%>
	<tr >
		<td class="textborder" align="center" colspan="14">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdat %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdat %></font></td>
	</tr>
	<%
	}
	
	if(GOPG<=((myList1.size()/20)+1))
				{
	
 
	//System.out.println("rCode is  "+rCde);
	if(!rCde.equals("00") && rCde!=null)
		{
		%>
	<tr>	
	<td align=center colspan=15 class="mystyle1">Represented By:&nbsp;&nbsp;<font color="red"><%= rpName %> </font></td></tr>
	<td class = btext >S.No</td>
	
	<% } else
		{	%><td class = btext >S.No</td>
			<td class = btext >Represented By</td> 
		<%}%>
		<td class = btext >Representative Name</td>
		<td   class="btext">Asset Name</td>		
		<td   class="btext"> Proposal Id</td>
		<td   class="btext"> Work Name </td>
		<td   class="btext" > Proposal Date    </td>
		<td   class="btext"> Work Description </td>
		<td   class="btext">Status</td>
		<td   class="btext">Pending At </td>
		<td   nowrap class="btext">Endorsed By<br>/No <br>/Date </td>
		<!-- <td   class="btext">Endorsed No </td>
		<td   class="btext" >Endorsement Date</td> -->
		<td   class="btext" >Estimated Cost (Rs. in Lakhs)</td> 
		<!-- <td   class="btext">Recommenda- -tions</td> -->
		<td   class="btext">Prepared On <br>/By</td>
		<td   class="btext">Prepared At </td>
		
		
		<!--  <td   class="btext">No. of Habitations</td>  -->
		
	</tr>
	<tr>
<%	}
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
		   
			if(!rCde.equals("00") && rCde!=null && !rCde.equals("null") && !rpName.equals("null") )
			{	%>
		 
			<td class = mystyle1 ><%= sno %></td>
		<% } else
				{	%>
					<td class = mystyle1 ><%= sno %></td>
					<td  class="mystyle1"><%=  record1[28] %>  </td>

			<%	 }	 %>
		
		<td class="mystyle1"><%=record1[26] %> </td>
		<td  class="mystyle1"><%= record1[27] %>  </td>		
		<td class="mystyle1"><%= record1[0] %>   </td>
		<td class="mystyle1"><%= record1[1] %> </td>
		<td  class="mystyle1"><%= record1[11] %> </td>
		<td  class="mystyle1"><%= record1[15] %> </td>
		<%
			 pid = record1[0];
			 wid = record1[18];
			 //System.out.println(" wid is   "+wid);
			 if(wid!=null)
			{
			st5=conn.createStatement();
			String q5="select et.TS_NO, et.TS_OFFICE from  RWS_NEW_EST_TBL et where et.work_id='"+wid+"'"  ;	 
				rs5=st5.executeQuery(q5);
			
				if(rs5.next())
				{%>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Technical Sanction </td>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=2> <%=RS1.getOfficeName(rs5.getString(2),true) %> </td>
					
		<% }
				else
				{
					st6=conn.createStatement();
					String q6="select  ACTION_FROM, ACTION_TO from RWS_PROPOSAL_WORKFLOW_TBL pw where track_no=(sELECT max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL pw where pw.proposal_id='"+ pid +"') and pw.proposal_id='"+pid+"'" ;
					rs6=st6.executeQuery(q6);
					rs6.next();
		%>
				<td  bgcolor=#FFFFFF><font color=#CC00CC size=3>Considered for Sanction</td>
				<td bgcolor=#FFFFFF><font color=#CC00CC size=2> <%=RS1.getOfficeName(rs6.getString(2),true) %> </td>
				
				<% }
			}
			else
			{ %>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Not Considered </td>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3><%=RS1.getOfficeName(record1[12],true) %>   </td>
			

			<%}

			rs5.close();
			st5.close();
		%>
		<!-- <td class="mystyle1"> <%=RS1.getOfficeName(record1[12],true) %>   </td> -->
		<td  class="mystyle1"> <%= record1[3] %> <br><%= record1[4] %><br> <%= record1[5]%>
		<td  class="mystyle1" align=right><%=record1[2]%> </td>
	
		<td class="mystyle1"> <%=record1[13]%> <br>  <%=record1[14] %> </td>
		 <td class="mystyle1"> <%=RS1.getOfficeName(record1[12],true) %>   </td>
		
		
		 


	</tr>

	 

<%}
	}%>
</table>		
<%
		}
		
	
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
		try
		{
			conn.close();
		}
		catch(Exception e)
		{
		
		}
}
	%>
	
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
		<a href="rws_proposal_pendency_consti_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=#FF00CC>Next </font></a>
		<%}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>



