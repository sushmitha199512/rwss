<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
 <%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn3.jsp" %>
<%	
	Statement st5=null,st6=null;
	ResultSet rs5=null,rs6=null;
	int start,end,limit =20,slno=0,j,pgcnt,pgno=0;
	int line=0;	
	int  GOPG;
	int ts = 0, cs = 0, nc = 0, as = 0;
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

	if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				//System.out.println("Go pg no is    "+GOPG);
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
			
				<a href="./rws_work_status_different_stages_graph_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
		
			
				
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="10"><font color="ffffff">Work Status At Different Stages Report</font></td>
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
<%if(session.getAttribute("consti")!=null){%>
<td align="center" class="mystyle1"><font color="#9900CC">Constituency: <%= session.getAttribute("consti") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>	
</table>


	
<% if(fdat!=null && !fdat.equals("0") && tdat!=null && !tdat.equals("0"))
	{%>
	<tr >
		<td class="textborder" align="center" colspan="10">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdat %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdat %></font></td>
	</tr>
	<%
	}
	
	
	//System.out.println("rCode is  "+rCde);
	if(!rCde.equals("00") && rCde!=null)
		{
		%>
	<tr align="center">	
	<td align=center colspan=10 class="mystyle1">Represented By:&nbsp;&nbsp;<font color="red"><%= rpName %> </font></td></tr>
	
	
	<% } 
		%>
		
	</tr>
	
	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" >	
	
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
		
		for(int z = start,sno=start+1; z<end; z++,sno++)
		{
			if(mylists1>z)
			{		
			String[] record1 =(String[])myList1.get(z);		
			 pid = record1[0];
			 wid = record1[18];
			 //System.out.println(" wid is   "+wid);
			 if(wid!=null)
			{
			st5=conn1.createStatement();
			String q5="select et.TS_NO, et.TS_OFFICE from  RWS_NEW_EST_TBL et where et.work_id='"+wid+"'"  ;	 
				rs5=st5.executeQuery(q5);
			
				if(rs5.next())
				{  ts = ts + 1 ;
					%>
					
					
		<% }
				else
				{
					st6=conn1.createStatement();
					String q6="select  ACTION_FROM, ACTION_TO from RWS_PROPOSAL_WORKFLOW_TBL pw where track_no=(sELECT max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL pw where pw.proposal_id='"+ pid +"') and pw.proposal_id='"+pid+"'" ;
					rs6=st6.executeQuery(q6);
					rs6.next();
		
				cs = cs + 1;
				
				 }
			}
			else
			{ 
				nc = nc  + 1 ;
			}

			rs5.close();
			st5.close();
		%>
		
	

	 

<%}
	}

	
	%>
	<%@ include file = "rws_work_status_different_stages_graph.jsp" %>	
	
<%
		}
		
	
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
		conn1.close();
	}
	%>
	
</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>