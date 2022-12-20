<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		

	int start,end,limit =25,  j, slno=0, pgcnt, pgno=0;
	int line=0;	
		int r1=0, s1=1, GOPG;
	int[] stat=new int[8];
	String st=request.getParameter("start");
	String[] coverStatus1 = {"FC","PC1","PC2","PC3","PC4","NC","NSS"};
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	System.out.println("cnt "+cnty);
		
	String labelNames[]=null;
	labelNames =(String[])label1.next();
	
	
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = myList1.iterator();

	ArrayList coverList1 = (ArrayList)session.getAttribute("coverList");

	int mylists1=myList1.size();
	
	String val[]=null;
	ArrayList coverList2 =(ArrayList)session.getAttribute("coverList1");
	Iterator lst = coverList2.iterator();
	val=(String[])lst.next();

	
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
		if(request.getParameter("pgcnt") !=  null) {
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
	//System.out.println("fdate is in temp is   "+FDATE);
	
 %>

<html>
<head>
<script>
window.history.forward(1);
</script>
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


<form name=f1 method="post" action="./rws_hab_dist_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">



<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_status_form.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
				<a href="./rws_hab_dist_status_xls.jsp?district=<%=district%>&fdate=<%=fdate%>&dCode=<%=dCode%>&start=<%=start%>&pgcnt=<%=pgcnt%>&GOPG=<%=GOPG%>" target="_new">Excel</a>
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
	<%if(session.getAttribute("dName")==null){%>
	 <td align="center" class="mystyle1"><font color="navy">District:ALL &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	<%}%>

<%if(!FDATE.equals("null") && !FDATE.equals("0"))
	{%>
<tr >
		<td class="textborder" align="center">
				<font size=2>Status As On </font><font color=#F2A80D> <%=FDATE %> </font></td>
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
		<td  class = btext>S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		<% //if(session.getAttribute("dName")==null){ %>
		<td  class = btext>District Name</td> <% //} %>

		<!-- <td class="mystyle">Mandal Name</td>	 -->
<%			for(j=2; j<labelNames.length;j++ )
			{
%>				<td class = btext><%= labelNames[j] %></td>
<%			} 
			for(j=0; j < coverStatus1.length-1; j++)
			{
%>				<td class=btext><%=coverStatus1[j]%></td>
<%			}

     	}
%>
				
			<td class=btext>NSS</td>
			</tr>
<%
		
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
			//stat=(int[])coverList2.get(z); 
			if(mylists1>z)
			{		
				String[] record1 =(String[])myList1.get(z);	
				int[] status =(int[])coverList1.get(z);
				
				//out.println("valiue of status1   "+coverList2.Item(2));
				String distcode=record1[0];
				String mandcode=record1[1];				

				slno++;
				
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>

			
			<% //if(session.getAttribute("dName")==null){ %>
			<td class="mystyle1">
			<a href="rws_hab_mand_status_rpt.jsp?dcode=<%=record1[0]%>&dname=<%=record1[1]%>">
			<%=record1[1]%></a></td> 
			<% //} %>

			<%  for(int k=2;k<labelNames.length;k++)
				{
				//System.out.println("record "+record1[k]);
			 %>
				 <td class="mystyle1" align="right"><%=record1[k]%></td>
<%				 } 
				 for(int t=0;t<status.length-1; t++)
				 {
				// System.out.println("status "+status[t]);
%>
					<td class="mystyle1" align="right"><%=status[t]%></td>
					<%}
					}
		}%>
		</tr>
		<%  
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
        <td><%=val[j]%></td> 
       <%}%>
	    </tr>
	   </table>
</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>