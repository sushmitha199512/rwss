<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%	
	int start,end,limit =25,  j, slno=0, pgcnt, pgno=0;
	int line=0;	
	int r1=0, s1=1, GOPG;
	int[] stat=new int[8];
	String st=request.getParameter("start");
	String[] coverStatus1 = {"FC","PC1","PC2","PC3","PC4","NC","NSS"};//feild UI is removed
	
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
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
//	System.out.println("inside the Xls Temp file");

	if(request.getParameter("start") !=  null) 
	{
		start = Integer.parseInt(request.getParameter("start"));
	}
	else
	{
		start = 0;
	}
	end = start + limit;
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
	{
		GOPG=0;
	}

	String FDATE = String.valueOf(session.getAttribute("fdate"));
//	System.out.println("start in xls"+start);
//	System.out.println("pgcnt in xls"+pgcnt);
//	System.out.println("GOPG in xls"+GOPG);
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

<body bgcolor="#edf2f8">
<form name=f1 method="post" action="./rws_hab_dist_rpt_temp.jsp?start=<%=start%>&slno=<%=slno%>&pgcnt=<%=GOPG%>">

<table border = 0 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	
<tr><td valign=top>
<table border =1 cellspacing = 0 cellpadding = 0  width=100% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	
	<tr>
	<td class="textborder" align="center" colspan="16">Location Status Excel Report</td>
	</tr>
	
	<%if(session.getAttribute("dName")==null){%>
	<tr>
		<td align="center" class="textborder" colspan="16"><font color="navy">District:ALL &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	</tr>
		<%}%>

	<%if(!FDATE.equals("null") && !FDATE.equals("0")){%>
	<tr>
		<td class="textborder" align="center" colspan="16"><font size=2>Status As On </font><font color=#F2A80D><%=FDATE %> </font></td>
	</tr>
	<% }%>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<% 
try{
		if(GOPG<=((myList1.size()/20)+1))
		{
%>
	<tr>
		<td  class = btext>S.No</td>
			<td  class = btext>District Name</td> 
		
<%		  for(j=2;j<labelNames.length;j++ )
		  {
%>
			<td class = btext><%=labelNames[j] %></td>
<%
			//.out.println("labelNames[j] "+labelNames[j]);
			} 
			for(j=0; j < coverStatus1.length-1; j++)
			{
			//System.out.println("coverStatus1.length "+coverStatus1.length+" "+coverStatus1[j]);
%>
			<td class=btext><%=coverStatus1[j]%></td>
			
<%		//	System.out.println("coverstatus1[j] "+coverStatus1[j]);
			}

		}
%>
<td class=btext>NSS</td>
</tr>
<%
		String distname="";
		String mandname="";
		String panchname="";
		 
		for(int z = start,sno=start+1; z<end; z++,sno++)
		{	
			if(mylists1>z)
			{		
				String[] record1 =(String[])myList1.get(z);	
				int[] status =(int[])coverList1.get(z);
				//System.out.println("Start "+start+" end "+end+" sno "+sno);
				
				//String distcode=record1[0];
				//String mandcode=record1[1];				
				slno++;
%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>
			<td class="mystyle1"><%=record1[1]%></a></td> 
<% 			
			for(int k=2;k<labelNames.length;k++)
			{
%>
			<td class="mystyle1" align="right"><%=record1[k]%></td>
<%			} 
			for(int t=0;t<status.length-1; t++)
			{
			//System.out.println("status.length "+status.length+" "+status[t]);
%>
			<td class="mystyle1" align="right"><%=status[t]%></td>
<%			}
		}
	}
%>
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
	
	for(j=0;j<val.length-1;j++)
	{
	//System.out.println("val.length"+val.length);
	 %>
        <td><%=val[j]%></td> 
      <%}%>
	    </tr>
	   </table>
	  <%}catch(Exception e)
	  {
	  }
	  finally{
	  session.removeAttribute("arrayLabel");
	  session.removeAttribute("arrayList");
	  session.removeAttribute("coverList");
  	  session.removeAttribute("coverList1");
  	  session.removeAttribute("fdate");
	  } %>
</TD></TR>
</TABLE>

</body>
</html>
<%@ include file = "footer.jsp" %>