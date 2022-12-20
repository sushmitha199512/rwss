<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		

	int start=0,end,limit =20,  j, slno=0, pgcnt, pgno=0;
	int line=0;	

	//ResultSet rset = null;
	int[] status1=null;
		int r1=0, s1=1, GOPG;
     
	String st=request.getParameter("start");
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	//session.setAttribute("arrayLabels",labelcol2);
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	//System.out.println("name of  count is  "+cnty);
	//String[] coverStatus1 = {"FC","PC1","PC2","PC3","PC4","NC","NSS", "UI"};
	String labelNames[]=null;
	//String record[]=null;
	labelNames =(String[]) label1.next();
	//System.out.println("lebal are  count  "+labelNames.length);
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	System.out.println("size is"+myList1.size());
	
	//session.setAttribute("arrayLists",myList1);
	//ArrayList coverList1 = (ArrayList)session.getAttribute("coverList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	/*int coversize = coverList1.size();
    
	String val[]=null;
	ArrayList coverList2 =(ArrayList)session.getAttribute("coverList1");
	Iterator lst = coverList2.iterator();
	val=(String[])lst.next();*/
	//System.out.println("val is"+val.length);
	if(request.getParameter("start") !=  null) 
		{
			start = Integer.parseInt(request.getParameter("start"));
			//System.out.println("start is    "+start);

		}
		/*else
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
				}*/
    dCode = String.valueOf(session.getAttribute("dCode"));
	String FDATE = String.valueOf(session.getAttribute("fdate"));
	String Month = String.valueOf(session.getAttribute("month"));
	//String TDATE = String.valueOf(session.getAttribute("tdate"));
	//System.out.println("fdate is in temp is   "+FDATE);
	
 %>

<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
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
<body bgcolor="#edf2f8">


<form name=f1 method="post" action="./rws_hab_mand_report_temp.jsp">



<table border = 1 cellspacing = 0 cellpadding = 0 width=70% height=20% colspan=24 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
	 <tr align="right">
			<td class="bwborder">
				<a href="./rws_workwise_monthly_rpt.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
			<!--<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a>-->
			
			
				</td> 
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="24">
			<font color="ffffff">Monthly Progress Report-Abstract </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align="center">	
	<tr>
	<td colspan=6></td><td align="center" class="textborder" colspan=11><font color="navy">Month:<%=session.getAttribute("monthname")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Year<%=":"+FDATE %></font></td><td class="btext" colspan=5 align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Amount in Rs Crores)</td></tr>


</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
       <tr align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Programme</td>
		<td colspan=4 class=btext align="center">Financial</td>
	    <td colspan=13 class=btext align="center">Works & Habitations</td>
	    <td colspan=6 class=btext align="center">Physical</td>
		</tr>
	   <tr>
		<td rowspan=1 colspan=3 class=btext align="center">OB+Releases</td>
		<td rowspan=1 colspan=1 class=btext align="center">Exp. During The Year</td>	
		<td colspan=4 class=btext align="center">SpillOverWorks</td>
	    <td colspan=5 class=btext align="center">NewWorksSanctioned</td>
		<td colspan=4 class=btext align="center">TotalWorks</td>
		<td colspan=2 class=btext align="center">Progress</td>
		<td colspan=4 class=btext align="center">Completed</td>
	 </tr>
		<tr>
			<%	
			for(j=1; j<labelNames.length;j++ )
		     {
				//out.println("label is"+labelNames[j]);
			if(labelNames[j].equals("OP_BAL"))
		     {
            %>
			<td rowspan=1 colspan=1 class=btext align="center">OB</td>
			<% 
			}

			if(labelNames[j].equals("Releases"))
				{
			%>
		  <td rowspan=1 colspan=1 class=btext align="center">Releases</td>
			<% 
			}
			if(labelNames[j].equals("Total"))
				{
			%>
		  <td rowspan=1 colspan=1 class=btext align="center">Total</td>
			<% 
			}
			if(labelNames[j].equals("EXPENDITURE_DUR_THE_MONTH"))
				{
			%>
			<td rowspan=1 n=1 class=btext align="center">During The Month</td>	
	       <% 
			}
			if(labelNames[j].equals("SPILL_WORKS_NO"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">No</td>
			<% 
			}
			if(labelNames[j].equals("SPILL_BAL_COST"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">Bal Cost</td>
			<% 
			}
			if(labelNames[j].equals("SPILL_BAL_HABS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">Bal Habs</td>
			<% 
			}
			if(labelNames[j].equals("SPILL_BAL_IP_PH1_HABS"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Bal IP PH-I HABS</td>

			<% 
			}
			if(labelNames[j].equals("NEW_NO"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">No</td>

			<% 
			}
			if(labelNames[j].equals("NEW_COST"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Cost</td>

			<% 
			}
			if(labelNames[j].equals("TOTAL_HABS"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Total Habs</td>

			<% 
			}
			if(labelNames[j].equals("NEW_IP_PH1_HABS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">IP PH-1 Habs</td>
			<% 
			}
			if(labelNames[j].equals("NEW_IP_PH2_HABS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">IP PH-2 Habs</td>
			<% 
			}
			if(labelNames[j].equals("TOTWRKS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">No</td>
			<% 
			}
			if(labelNames[j].equals("TOTCOST"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">Cost</td>
			<% 
			}
			if(labelNames[j].equals("HABITATIONS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">Habs</td>
			<% 
			}
			if(labelNames[j].equals("IPHABS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">IP Habs</td>
			<% 
			}
			
			if(labelNames[j].equals("PROGRESS_ENTRUSTED"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Entrusted</td>	

			<% 
			}if(labelNames[j].equals("PROGRESS_GROUNDED"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Grounded</td>

			<% 
			}
			if(labelNames[j].equals("WORKS_COMP"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Works</td>	

			<% 
			}
			if(labelNames[j].equals("COVERED_HABS"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Covered Habs</td>

			<% 
			}
			if(labelNames[j].equals("COVERED_IP_PH1_HABS"))
				{
			%>
	<td rowspan=1 colspan=1 class=btext align="center">Covered IP PH-1 Habs</td>
			<% 
			}
			if(labelNames[j].equals("COVERED_IP_PH2_HABS"))
				{
			%>
	<td rowspan=1 colspan=1 class=btext align="center">Covered IP PH-2 Habs</td>
			<% 
			}
		} %>
		</tr>
		    
	  <% 
		   
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		 if(myList1.size()==0)
	{%>
		<tr><td colspan=26 align=center><a href="rws_workwise_monthly_rpt.jsp"><b>There Are No Records</b></a></td></tr>
	<%}
		

		for(start=0;start<=myList1.size();start++)
		{	
				
				String[] record1 =(String[])myList1.get(start);		
				//System.out.println("valiue of   "+record1.length);
				//int[] status =(int[])coverList1.get(z);
				//System.out.println("valiue of   "+status.length  + " coverList1  "+coverList1.size());
				//String distcode=record1[0];
				//String mandcode=record1[1];
				

				slno++;
		
					
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=slno%></td>
			<td class="mystyle1"><%=record1[0]%></td>
			<%
			for(int k=1;k<labelNames.length;k++){
					     %>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} 
			}%>
</tr>	
</table>
</TD></TR>
</TABLE>
</td>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>