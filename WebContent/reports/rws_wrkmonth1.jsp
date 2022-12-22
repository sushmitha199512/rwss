<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		

	int start=0,end,limit =20,  j, slno=0, pgcnt, pgno=0;
	int line=0,l=0,m=0,s=0,p=0;	

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
	int labels=labelNames.length;
	//out.println(labels);
	ArrayList myList1 = (ArrayList)session.getAttribute("arrayList");
	//System.out.println("size is"+myList1.size());
	
	//session.setAttribute("arrayLists",myList1);
	//ArrayList coverList1 = (ArrayList)session.getAttribute("coverList");
	Iterator iterator = myList1.iterator();
	int mylists1=myList1.size();
	/*int coversize = coverList1.size();
    
	String val[]=null;
	ArrayList coverList2 =(ArrayList)session.getAttribute("coverList1");
	Iterator lst = coverList2.iterator();
	val=(String[])lst.next();*/
	//System.out.println("val is"+mylists1);
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


<form name=f1 method="post">



<table border = 1 cellspacing = 0 cellpadding = 0  height="3%" width="100%" colspan=28 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
	 <tr align="right">
			<td class="bwborder">
				<a href="./rws_mnth_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
			<!--<a href="./rws_hab_rpt_print.jsp"  target="_new">Print&nbsp;|&nbsp;</a>-->
			
			
				</td> 
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="28">
			<font color="ffffff">Monthly Progress Report-Abstract </font></td>
	</tr>
	</table>


<table border =0 cellspacing = 0 cellpadding = 0 colspan="28"  bordercolor="#000000" bgcolor="#edf2f8" >	
	<tr>
	<td class="textborder" align="center">District:<%=session.getAttribute("dName")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month:<%=session.getAttribute("monthname")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Year<%=":"+FDATE %><td class="textborder"  align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Amount in Rs Lakhs)</td></tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
       <tr align=center>
		<td class=btext rowspan=2 >Sl.No</td>
		<td class=btext rowspan=2>Programme</td>
        
		<%	
			for(j=3; j<labelNames.length;j++ )
		     {
				//out.println("label is"+labelNames[j]);
				//out.println("in for");
				
			if(labelNames[j].equals("OPBAL"))
		     {
            %>
			
			<td  colspan=4 class=btext align="center">OB+Releases</td>
			<% 
			}

			if(labelNames[j].equals("EXPENDITURE"))
				{
			%>
		   <td  colspan=2 class=btext align="center">Exp.During The Year</td>
			<% 
			}
			if(labelNames[j].equals("SPILLS"))
				{
			%>
		  <td colspan=5 class=btext align="center">SpillOverWorks</td>
			<% 
			}
			if(labelNames[j].equals("NEW"))
				{
			%>
			  <td colspan=5 class=btext align="center">NewWorksSanctioned</td>
	       <% 
			}
			if(labelNames[j].equals("TOTWRKS"))
				{
			%>
			  <td colspan=4 class=btext align="center">TotalWorks</td>
	       <% 
			}
			if(labelNames[j].equals("PROGRESS"))
				{
			%>
			<td colspan=2 class=btext align="center">Progress</td>
			<% 
			}
			if(labelNames[j].equals("COMPLETED"))
				{
			%>
			<td colspan=4 class=btext align="center">Completed</td>
			<% 
			}
			
		} %>
		</tr>
			
		<%	
			for(j=3; j<labelNames.length;j++ )
		     {
				//out.println("label is"+labelNames[j]);
			if(labelNames[j].equals("OPBAL"))
		     {
            %>
			
			<td  colspan=1 class=btext align="center">OB</td>
			<td  colspan=1 class=btext align="center">Release Dur The Month</td>
			<td  colspan=1 class=btext align="center">Release Upto The Month</td>
			<td  colspan=1 class=btext align="center">Total</td>
			<% 
			}
             if(labelNames[j].equals("EXPENDITURE"))
				{
			%>
			<td  colspan=1 class=btext align="center">During The Month</td>
			<td  colspan=1 class=btext align="center">Upto The Month</td>
	       <% 
			}
			if(labelNames[j].equals("SPILLS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">No</td>
			<td rowspan=1 colspan=1 class=btext align="center">Bal Cost</td>
			<td rowspan=1 colspan=1 class=btext align="center">Commitment On Physical<br>Comp Works</td>
			<td rowspan=1 colspan=1 class=btext align="center">Bal Habs</td>
			<td rowspan=1 colspan=1 class=btext align="center">Bal IP PH-I HABS</td>
			<% 
			}
			
			if(labelNames[j].equals("NEW"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">No</td>
				<td rowspan=1 colspan=1 class=btext align="center">Cost</td>
				<td rowspan=1 colspan=1 class=btext align="center">Total Habs</td>
				<td rowspan=1 colspan=1 class=btext align="center">IP PH-1 Habs</td>
				<td rowspan=1 colspan=1 class=btext align="center">IP PH-2 Habs</td>

			<% 
			}
			
			if(labelNames[j].equals("TOTWRKS"))
				{
			%>
			<td rowspan=1 colspan=1 class=btext align="center">No</td>
			<td rowspan=1 colspan=1 class=btext align="center">Cost</td>
			<td rowspan=1 colspan=1 class=btext align="center">Habs</td>
			<td rowspan=1 colspan=1 class=btext align="center">IP Habs</td>
			<% 
			}
			
			
			if(labelNames[j].equals("PROGRESS"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Entrusted</td>	
				<td rowspan=1 colspan=1 class=btext align="center">Grounded</td>

			<% 
			}
			if(labelNames[j].equals("COMPLETED"))
				{
			%>
				<td rowspan=1 colspan=1 class=btext align="center">Works</td>	
				<td rowspan=1 colspan=1 class=btext align="center">Covered Habs</td>
				<td rowspan=1 colspan=1 class=btext align="center">Covered IP PH-1 Habs</td>
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
		String plan="";
		String normal="";
		String program="";
		 if(myList1.size()==0)
	{%>
		<tr><td colspan=27 align=center><a href="rws_workwise_monthly_rpt.jsp"><b>There Are No Records</b></a></td></tr>
	<%}
		
       for(start=0;start<myList1.size();start++)
		{	
			//out.println("mylists1............"+mylists1);	
		   String[] record1 =(String[])myList1.get(start);
			
		    plan=record1[0];
		   //out.println("plannnnn"+plan);

		    normal=record1[1];
		   // out.println("normalnnnnn"+normal);
			program=record1[2];
			
			
			if(plan.equals("PLAN") && normal.equals("NORMAL") && slno==0 || plan.equals("PLAN") && normal.equals("PROJECTS") && slno==0)
              {%>
             <tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle">I</td>
			<td class="mystyle"><%=plan%></td>
			</TR>
			<%
			if(plan.equals("PLAN") && normal.equals("NORMAL") && slno==0)
				  {%>
			<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle"></td>
			<td class="mystyle"><%=normal%></td>
			</tr>
			<%
				
			slno++;
	
				  %>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=slno%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
				  }
			}
			else if(plan.equals("PLAN") && normal.equals("NORMAL") && slno!=0)
              {
				
				//String[] record1 =(String[])myList1.get(start);		
				//System.out.println("valiue of   "+record1.length);
				//int[] status =(int[])coverList1.get(z);
				//System.out.println("valiue of   "+status.length  + " coverList1  "+coverList1.size());
				//String distcode=record1[0];
				//String mandcode=record1[1];
				slno++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=slno%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}

			if(plan.equals("PLAN") && normal.equals("PROJECTS") && l==0)
              {%>
				<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle"></td>
			<td class="mystyle"><%=normal%></td>
			</tr>
				<%
				l++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=l%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}

            
//*****************************************************
	if(plan.equals("NONPLAN") && normal.equals("NATURAL CALAMITIES") && m==0 || plan.equals("NONPLAN") && normal.equals("OPERN_MAINTENANCE") && m==0 ||  plan.equals("NONPLAN") && normal.equals("SCHOOLS HOSTELS AND RES INSTITUTIONS") && m==0  ||  plan.equals("NONPLAN") && normal.equals("OTHER PROGRAMMES") && m==0 )
              {%>
             <tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle">II</td>
			<td class="mystyle"><%=plan%></td>
			</TR>
			<%
			if(plan.equals("NONPLAN") && normal.equals("NATURAL CALAMITIES") && m==0)
				  {%>
			<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle"></td>
			<td class="mystyle"><%=normal%></td>
			</tr>
			<%
				
			m++;
	
				  %>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=m%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
				  }
			}
			else if(plan.equals("NONPLAN") && normal.equals("NATURAL CALAMITIES") && m!=0)
              {
				
				//String[] record1 =(String[])myList1.get(start);		
				//System.out.println("valiue of   "+record1.length);
				//int[] status =(int[])coverList1.get(z);
				//System.out.println("valiue of   "+status.length  + " coverList1  "+coverList1.size());
				//String distcode=record1[0];
				//String mandcode=record1[1];
				m++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=m%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}

			if(plan.equals("NONPLAN") && normal.equals("OPERN_MAINTENANCE") && s==0)
              {%>
				<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle"></td>
			<td class="mystyle">OPERATION&MAINTENANCE</td>
			</tr>
				<%
				s++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=s%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}
			else if(plan.equals("NONPLAN") && normal.equals("OPERN_MAINTENANCE") && s!=0)
              {
				s++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=s%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}
//***********************************************
	if(plan.equals("NONPLAN") && normal.equals("SC_HOST_RES_INST") && p==0)
              {%>
				<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle"></td>
			<td class="mystyle">SCHOOLS,HOSTELS & RES.INSTITUTIONS</td>
			</tr>
				<%
				p++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=p%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}
			else if(plan.equals("NONPLAN") && normal.equals("SC_HOST_RES_INST") && p!=0)
              {
				p++;
	
	%>
	    
		<tr align=left bgcolor="#ffffff">
		    
			<td class="mystyle1"><%=p%></td>
			<td class="mystyle1"><%=program%></td>
			<%
		    
			for(int k=3;k<=labelNames.length-1;k++){
		                
					     %>
						 <td class="mystyle1" align="right"><%=record1[k]%></td>
			<%} 
			}
			  }%>
</tr>
 
</table>

</body>
</html>
<%@ include file = "footer.jsp" %>