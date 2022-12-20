<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%	
	int start,end,limit =20,  j, slno=0, pgcnt, pgno=0,ftotal=0;
	int line=0;	
	int r1=0, s1=1, GOPG;
	String st=request.getParameter("start");
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	String[] coverStatus1 = {"FC","PC1","PC2","PC3","PC4","NC","NSS"};//"UI"
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	//System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	//String record[]=null;
	labelNames =(String[]) label1.next();
	//System.out.println("lebal are  count  "+labelNames.length);
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	ArrayList coverList1 = (ArrayList)session.getAttribute("coverList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();

	String val[]=null;
	ArrayList coverList2 =(ArrayList)session.getAttribute("coverList1");
	Iterator lst = coverList2.iterator();
	val=(String[])lst.next();
	//System.out.println("val is"+val.length);

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
	//System.out.println("end value is   "+end);
	if(request.getParameter("pgcnt") !=  null) 
	{
		pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
		//System.out.println("pgcnt is   99999999999  "+pgcnt);
	}
	else
	{
		pgcnt = 1;
		//System.out.println("pgcnt *************is    "+pgcnt);	
	}
	if(request.getParameter("gopg") !=  null) 
	{
		GOPG = Integer.parseInt(request.getParameter("gopg"));
		//System.out.println("Go pg /////////////no is    "+GOPG);
		pgcnt = GOPG;
	}
	else 
	{
		GOPG=0;
	}

	String FDATE = String.valueOf(session.getAttribute("fdate"));
	//String TDATE = String.valueOf(session.getAttribute("tdate"));
	System.out.println("fdate is in temp is   "+FDATE);
%>

<html>
<head>
<title> WaterSoft </title>
<script>
	window.history.forward(1);
</script>
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

<form name=f1 method="post" action="./rws_hab_panch_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="rws_hab_status_form.jsp">Back </a>|
				<a href="../home.jsp">Home </a>|
				<a href="./rws_hab_panch_rpt_xls.jsp" target="_new">Excel</a>
				 <!--<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a>-->
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


<%if(!FDATE.equals("null") && !FDATE.equals("0") )
	{%>
<tr >
		<td class="textborder" align="center">
				<font size=2>Status As on: </font><font color=#F2A80D> <%=FDATE %> </font></td>
	</tr>
	<% }%>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<% 
				if(GOPG<=((myList1.size()/20)+1))
				{
	%>
	<tr >
		<td class = btext>S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		
		<!-- <td class="mystyle">Panchayat Name</td> -->
		<%// if(session.getAttribute("pName")==null){ %>
		<td class = btext>Panchayat Name</td> <%// } %>

		<%
			for(j=2; j<labelNames.length;j++ )
			{
				
			%>
				<td class = btext align="right"><%= labelNames[j] %></td>
			<%
				} 	for(j=0; j < coverStatus1.length-1; j++)
			{
		%>
				<td class=btext align="right"><%=coverStatus1[j]%></td>
				
		<%}
		%>
			<td class=btext>NSS</td>	
	</tr>	
<%}
			
		
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
				else if(GOPG<=((myList1.size()/20)+1))
				{
					start=(GOPG * 20)-20;
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


		for(int z = start,sno=start+1; z<end; z++,sno++)
		{	
			if(mylists1>z)
			{		
				String[] record1 =(String[])myList1.get(z);		
				//System.out.println("valiue of   "+record1.length);
				int[] status =(int[])coverList1.get(z);
				//System.out.println("valiue of   "+status.length  + " coverList1  "+coverList1.size());
				String distcode=record1[0];
				String mandcode=record1[1];
				

				slno++;
		
					
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>
<%//if(session.getAttribute("pName")==null){ %>
		<td class="mystyle1"> 
		<a href="rws_hab_status_rpt.jsp?pcode=<%=record1[0]%>&pname=<%=record1[1]%>">
			<%=record1[1]%></a></td> 
		 <% // } %>

			
				<% 			
						for(int k=2;k<labelNames.length;k++){
					     %>
						<td class="mystyle1" align="right"><%=record1[k]%></td>
						<%} 
							for(int t=0;t<status.length-1; t++)
								{
							%>
					 <td class="mystyle1" align="right"><%=status[t]%></td> 
					<%}
			 
}
		}
%>
</tr>
<%	
if((start+20)>=myList1.size())
		{
   if(labelNames.length==2)
			{
           %>
          <tr class="btext" align="right"><td colspan=2>GrandTotal:</td>
	       <%
			}
          if(labelNames.length==3)
			{
           %>
        <tr class="btext" align="right"><td colspan=3>GrandTotal:</td>
	      <%
			}
        if(labelNames.length==4)
			{
           %>
        <tr class="btext" align="right"><td colspan=4>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==5)
			{
           %>
        <tr class="btext" align="right"><td colspan=5>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==6)
			{
           %>
        <tr class="btext" align="right"><td colspan=6>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==7)
			{
           %>
        <tr class="btext" align="right"><td colspan=7>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==8)
			{
           %>
        <tr class="btext" align="right"><td colspan=8>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==9)
			{
           %>
        <tr class="btext" align="right"><td colspan=9>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==10)
			{
           %>
        <tr class="btext" align="right"><td colspan=10>GrandTotal:</td>
	      <%
			}
		   if(labelNames.length==11)
			{
           %>
        <tr class="btext" align="right"><td colspan=11>GrandTotal:</td>
	      <%
			}
	 for(j=0;j<val.length-1;j++){
	  //System.out.println(iter.next()); %>
    <td align="right"><%=val[j]%></td> 
<%}
}%>
 </tr>
	
</table>
</TD></TR>
</TABLE>
<table border=0 align=center width="90%">
<tr><td align="RIGHT" nowrap class=mystyle1>GO TO PAGE :</td>
 <td class = mystyle1><input size = 3 type="text" name="gopg"  onchange="this.form.submit()" >
 </td>
<td align="left" class=mystyle1>
<%
for(int r=start,s=pgcnt,lim=1;r<myList1.size(); r+=20,s++,lim++) { 
		// System.out.println("panchayat  name is   "+pgcnt);		
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
		<a href="rws_hab_panch_rpt_temp.jsp?start=<%=r1%>&slno=<%=slno%>&pgcnt=<%=s1%>"><font   color=blue>Next </font></a>
		<%}
			
 %>

</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>