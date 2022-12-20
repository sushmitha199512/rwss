<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>

<%	
	int start,end,limit =30,j,slno=0,pgcnt,pgno=0;
	int line=0,habCnt=0;	
	int r1=0, s1=1, GOPG;
	String stt=request.getParameter("start");

	
	if(request.getParameter("start") !=  null) {
		start = Integer.parseInt(request.getParameter("start"));

		}
		else
		{
			start = 0;
	
		}
		
		end = start + limit;
		
		ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
		Iterator label1 = labelcol2.iterator();
		int cnty=labelcol2.size();
		String labelNames[]=null;
		String record[]=null;
		labelNames =(String[]) label1.next();
		ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
		Iterator iterator = myList1.iterator();
		int mylists1=myList1.size();
		
		if(request.getParameter("pgcnt") !=  null)
		{
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
		}
		else
		{
			pgcnt = 1;
		}
		if(request.getParameter("gopg") !=  null) 
		{
			GOPG = Integer.parseInt(request.getParameter("gopg"));
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
<body bgcolor="#edf2f8"><%	//out.println(query);%>

<form name=f1 action="./rws_hab_asset_status_no_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

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
			
				<a href="./rws_mandal_pws_status_detail_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<!-- <a href="rws_hab_asset_status_no_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_hab_asset_status_no_rpt_excel_print.jsp"target="_new">Excel</a> -->
			
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Mandal Wise PWS Status Details</font></td>
	</tr>
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
	<% if(session.getAttribute("dName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>

</table>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	


	<%
	if(GOPG<=((myList1.size()/30)+1))
				{%>
				<tr align=left >
		
		<td class = btext rowspan=2>Sl. NO</td>
		<td class = btext rowspan=2>Name of the Mandal</td>
		 <td  class = btext colspan=4 ALIGN=CENTER>Population of Village</td> 
		<td class = btext rowspan=2>No. of OHSR & Total Capacity in KL</td>
		<td class = btext rowspan=2>No. & Total Capacity of High level GLSRs in KL</td>
		<td class = btext rowspan=2>No.& Total Capacity of GLSR/Cisterns in KL</td>
		<td class = btext rowspan=2>Source BW/IW</td>
		<td class = btext rowspan=2>quality of water in the source satisfactory/unsafe</td>
		<td class = btext rowspan=2>if unsafe flouride content/brackish content</td>
		<td class = btext rowspan=2>Type of Electrical connection to source LT/HT</td>
		<td class = btext rowspan=2>No.sources working(under direct pumping)</td>
		<td class = btext rowspan=2>No.of HPs working in condition</td>
		<td class = btext rowspan=2>No.of single phase motors working</td>
		<td class = btext  colspan=3 ALIGN=CENTER>No.of sources connected to OHSR/GLSR and Total</td>
		<td class = btext  colspan=4 ALIGN=CENTER>Length of pipe line for distribution diameter wise</td>
		<td class = btext rowspan=2>No.of public taps</td>
		<td class = btext rowspan=2>No.of public taps having standposts with platform</td>
		<td class = btext rowspan=2>No.of public taps not having standposts and platform</td>
		<td class = btext rowspan=2>No.of public taps not having taps ( on/off )</td>
		<td class = btext rowspan=2>No.of private connections</td>
		<td class = btext rowspan=2>No.of private connections not having taps( on/off )</td>
		<td class = btext rowspan=2>No.of un authourised private connections</td>
		<td class = btext rowspan=2>Amount collected by Gram Panchayat for each private connection for giving connection</td>
		<td class = btext colspan=5 ALIGN=CENTER>Approximate amount spent by Gram Panchayat for maintenance of scheme during 2005-06</td>
		<td class = btext rowspan=2>Monthly tarrif collected by Gram Panchayat from each Private connection</td>
		<td class = btext rowspan=2>How many private tap connection house holds paid last year 2005-06</td>
		<td class = btext rowspan=2>No. of families interested to have private tap connections </td>
		<td class = btext rowspan=2>Whether scheme is functional (or) defunct</td>
		<td class = btext rowspan=2>If defunct (since how long it is defunct & reasons)</td>
		<td class = btext rowspan=2>when it will be rectified</td>
		<td class = btext rowspan=2>Remarks</td>
		
		</tr>
		<tr>
		<td class = btext>SC</td>
		<td class = btext>ST</td>
		<td class = btext>OC</td>
		<td class = btext>Total</td>

		<td class = btext>OHSR</td>
		<td class = btext>GLSR</td>
		<td class = btext>Total</td>

		<td class = btext>PVC</td>
		<td class = btext>HDPE</td>
		<td class = btext>AC</td>
		<td class = btext>OTHERS</td>
		
		<td class = btext>Electrical</td>
		<td class = btext>pump operators</td>
		<td class = btext>Bleaching powder</td>
		<td class = btext>repairs of motors/pipes etc </td>
		<td class = btext>Total</td>
		
		</tr>
		
			<%
			 }%>
	
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
		 if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				
				if(GOPG==1)
				{
					start= 0;
					end = start + limit;
				}
				else if(GOPG<=((myList1.size()/30)+1))
				{
					start=(GOPG * 30)-30;
					end = start + limit;
				}
				else
				{ %><tr align="center" class="btext"><td>
					<%= "Invalid  Valid Page Number Enetered" %></td></tr>
					<%
						start=mylists1;
					}
			}

		
		
		for(int z = start,sno=start+1; z < end; z++,sno++)
		{	
			if(mylists1>z)
			{		
				String[] record1 =(String[])myList1.get(z);		
				String distcode=record1[0];
				String mandcode=record1[1];
	%>
		<tr align=left >
		<td  class="mystyle1"><%= sno%></td>
		<td class="mystyle1"><%=record1[1]%></td>
		<td class="mystyle1"><%=record1[2]%></td>
		<td class="mystyle1"><%=record1[3]%></td>
		<td class="mystyle1"><%=record1[4]%></td>
		<td class="mystyle1"><%=record1[5]%></td>
		<td class="mystyle1"><%=record1[6]%> & <%=record1[7]%>
		<td class="mystyle1"><%=record1[8]%> & <%=record1[9]%></td>
		<td class="mystyle1"><%=record1[10]%> / <%=record1[11]%></td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
		<td  class="mystyle1">--</td>
			
		</tr>

<%	}
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
<table border=0 align=center width="100%">
<tr><td align="RIGHT" nowrap class=mystyle1>GO TO PAGE :</td>
 <td class = mystyle1><input size = 3 type="text" name="gopg"  onchange="this.form.submit()" >
 </td>
<td align="left" class=mystyle1>
<%
for(int r=start,s=pgcnt,lim=1;r<myList1.size(); r+=30,s++,lim++) { 
		// //System.out.println("panchayat  name is   "+pgcnt);		
		if(pgcnt==s)
		{ 
			r1=r+30;
			s1=s+1;

		}	
		}
 if(request.getParameter("gopg") ==  null) 
	{
%>
<td align="right" class=mystyle1>Page <font color=red><%= pgcnt %></font> of <font color=blue> <%= (myList1.size()/30)+1 %></font>
<%
	} else {
%>
<td align="right" class=mystyle1>Page <font color=red><%= request.getParameter("gopg") %></font> of <font color=blue> <%= (myList1.size()/30)+1 %></font>
<% 
	//start=0;
	//pgcnt=1;
	}
	if((start+30)<=myList1.size())
		{
		%>
		<a href="rws_hab_asset_status_no_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=#FF00CC>Next </font></a>
		<%}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>