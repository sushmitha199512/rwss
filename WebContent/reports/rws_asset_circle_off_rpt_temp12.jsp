<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>

<%	
	int start,end,limit =30,j,slno=0,pgcnt,pgno=0;
	int line=0,habCnt=1;	
	int r1=0, s1=1, GOPG;
	String stt=request.getParameter("start");

	
	if(request.getParameter("start") !=  null) {
		start = Integer.parseInt(request.getParameter("start"));

		}
		else
		{
			start = 0;
	
		}
		
		/*if(request.getParameter("slno") !=  null) {
		slno = Integer.parseInt(request.getParameter("slno"));

		}
		else
		{
			slno = 0;
	
		}*/
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
		if(request.getParameter("gopg") !=  null) 
			{
				GOPG = Integer.parseInt(request.getParameter("gopg"));
				// //System.out.println("Go pg no is    "+GOPG);
					pgcnt = GOPG;
			}
			else 
				GOPG=0;
		
String asseType=String.valueOf(session.getAttribute("assetType"));
String ATName="";
if(!asseType.equals("null")){
if(asseType.equals("01")){ATName="PWS";}
else if(asseType.equals("02")){ATName="MPWS";} 
else if(asseType.equals("03")){ATName="CPWS";}
else if(asseType.equals("04")){ATName="HANDPUMPS";}
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

<form name=f1 action="./rws_asset_hab_off_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

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
			
				<a href="./rws_asset_hab_off_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<a href="rws_asset_hab_off_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_asset_hab_off_rpt_excel_print.jsp"target="_new">Excel</a>
			
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Asset Habitation  Status  Report </font></td>
	</tr>
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
		
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<%if(!asseType.equals("null")){%>
<td align=center colspan=8 class="mystyle1"><font color="navy">Asset Type:&nbsp;&nbsp;<%=ATName %> </font></td></tr>
<%}%>
</table>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

	<tr >
	<%
	if(GOPG<=((myList1.size()/30)+1))
				{
					if(!assetType.equals("00"))
					{
					%>
		<td class = btext>S.No</td>
		
		
		<%	
			int i=0;
				for(j=1; j<labelNames.length;j++ ) {			
			%>
		<td class = btext><%= labelNames[j] %></td>
	<%
			} %>
	</tr>	
<%	}
			else
			{
				%>
				<tr>
				<td class = btext>S.No</td>
				<td class = btext>Circle Name</td>
				<td class = btext>Total Asset Cost</td>
				<td class = btext>PWS</td>
				<td class = btext>HABITATIONS</td>
				
				<td class = btext>Total Asset Cost</td>
				<td class = btext>CPWS</td>
				<td class = btext>HABITATIONS</td>
				</TR>

		
		
				<%
			}
				}
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
				// //System.out.println("Go pg no is    "+GOPG);
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
					//start=GOPG;
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

		if(assetType.equals("00"))
				{
		query = "SELECT nvl(sum(asset_cost),0) as \"Total Asset Cost (in Lakhs)\", count(distinct tm.asset_code) as \"Total No. of Assets\", count(tm.hab_code) as \"Total No. of Habitations\" from TEMP_ASSET_HAB_TBL tm, ASSET_mast1 am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code and am.asset_code=tm.asset_code and substr(am.asset_code,7,2) = '01' AND am.circle_office_code = '" + record1[0] + "'";
		
		rs = stmt.executeQuery(query);
				
				}
			habCnt = 0;
			slno++;
			temp= record1[0];
			temp1= record1[1];
			//temp2=rs.getString(3);
			%>
		<tr align=left >
			<td  class="mystyle1"><%= sno%></td>
			<td  class="mystyle1"><a href = "rws_asset_div_off_rpt.jsp?district=<%=record1[0]%>&district1=<%=record1[1]%>"><%= record1[1]%></a></td>
		
<%		if(assetType.equals("00"))
				{
					if (rs.next())
					{
	
			%>
				<td  class="mystyle1"><%= rs.getInt(1) %></td>
				<td  class="mystyle1"><%= rs.getInt(2) %></td>
				<td  class="mystyle1"><%= rs.getInt(3) %></td>
				<%
				}
				}
		else
				{
		for(int k=2; k<labelNames.length;k++ )
		{
%>
				<td class="mystyle1"><%=record1[k]%></td>
<% 

		}//end of for
			}
			}	}
%>
</tr>
<%
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
		<a href="rws_asset_hab_off_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=#FF00CC>Next </font></a>
		<%}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>