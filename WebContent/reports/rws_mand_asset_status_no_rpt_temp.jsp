<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>

<%@ include file = "header_rpt.jsp" %>

<%	
	int start,end,limit =30,j,slno=0,pgcnt,pgno=0;
	int line=0,habCnt=0;	
	int r1=0, s1=1, GOPG;
	String stt=request.getParameter("start");
	ResultSet rset = (ResultSet)session.getAttribute("format3");	
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
			
				<a href="./rws_hab_asset_status_no_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<a href="rws_hab_asset_status_no_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_hab_asset_status_no_rpt_excel_print.jsp"target="_new">Excel</a>
			
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Assets in Habitation  </font></td>
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
<td align="center"  class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("vName")!=null){%>
<td align="center"  class="mystyle1"><font color="navy">Village: <%=session.getAttribute("vName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("hName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Habitation:<%=session.getAttribute("hName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</table>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

	<tr >
	<%
	if(GOPG<=((myList1.size()/30)+1))
				{%>
		<td class = btext>S.No</td>
		
		
		<%		int i=0;
				for(j=1; j<labelNames.length;j++ ) {			
			%>
		<td class = btext><%= labelNames[j] %></td>
	<%
			} }%>
	</tr>	
<%	
	try
	{		
		
		String mandcode[]=new String[labelNames.length];	
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
				
	%>
		<tr align=left >
		<td  class="mystyle1"><%= sno%></td>
		<td class="mystyle1"><a href="rws_panch_asset_status_no_rpt.jsp?mandal=<%=record1[0]%>&mName=<%=record1[1]%>"><%=record1[1]%></a></td>
<%		
		
		for(int k=2; k<labelNames.length;k++ )
		{
		%>
			<td class="mystyle1"><%=record1[k]%></td>
		<%
		
		}			
	%>
		</tr>

<%	}
   }//end of for
   if((start+30)>=myList1.size())
		{
   %>
   <tr><td colspan=2 class ="btext">GrandTotal:</td>
	 <%
        rset.next();
        //System.out.println("R"+ rset.getInt(1));
	 %>
		<td class="btext"><%=rset.getString(1)%></td>
		<td class="btext"><%=rset.getString(2)%></td>
		<td class="btext"><%=rset.getString(3)%></td>
		<td class="btext"><%=rset.getString(4)%></td>		
		<td class="btext"><%=rset.getString(5)%></td>
		<td class="btext"><%=rset.getString(6)%></td>		
		<td class="btext"><%=rset.getString(7)%></td>
	    </tr>

  <% }
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
		<a href="rws_mand_asset_status_no_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=#FF00CC>Next </font></a>
	<%}
    }
	catch(Exception ee)
	{
	 //System.out.println("The error is="+ee);
	}
	%>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
