<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.lang.String"%>


    <%
   String fvalue=null,ivalue=null,qaffect=null,place=null,diameter=null,stalevel=null,summerlevel=null,
   drillyr=null,status=null,devalue=null,brvalue=null;
  
   //System.out.println("************************REPORT BEGINING************************");
    try
	{
	ResultSet rset=(ResultSet)session.getAttribute("format");	
	//rset.beforeFirst();
    
	int limitPerPage = 20;	
	int iPage = 0;
	String sPage = request.getParameter("pg");
	if(sPage != null && !sPage.equals("null"))
		iPage = Integer.parseInt(sPage);
	int pr = 1 ;
	int pg = 0;
	int pgCntNo = 0;
	int totalpgs = 0;
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">
</head>

<body>
<table border=1 cellspacing=0 cellpadding=0 style="border-collapse:collapse" bgcolor="#edf2f8" width=100% bordercolor=#000000>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right" class="bwborder">
			<td >
				<a href="javascript:window.history.back()">Back |</a>
				<!--<a href="excelrpt.jsp">Excel</a>-->
				<a href="../home.jsp">Home</a>
				
			</td>
		</tr>
	</table>
</caption>
<tr bgcolor="#efefef" align="center">
			<td align="center" class="rptHeading" colspan=13>Borewell-Details-Report</td>	
		</tr>
  <tr class="rptLabel">
		            <td>Sno</td>
					<td>Hpcode</td>
					<td>Location</td>
					<td>DrillYear</td>
					<td>Diameter</td>
					<td>Status</td>
					<td>StaticWL</td>
					<td>SummerWL</td>
					<td>Depth</td>
					<td>Quality<br>Affected</td>
					<td>Flouride</td>
					<td>Brakish</td>
					<td>Iron</td>
				
		</tr>
  <% 
	
   Integer integer = (Integer)session.getAttribute("rsSize");
	int rsSize1 = integer.intValue();
	totalpgs = Math.round( rsSize1/ limitPerPage);
	
	if ((totalpgs % limitPerPage) > 0) 
		totalpgs++;
	
	if(request.getParameter("pr") != null)
	{
		pr = Integer.parseInt(request.getParameter("pr"));
		pg = pr;		
	}
	else
		{
			pr = 0;			
		}
	if(request.getParameter("pgCntNo") != null)
	{
		pgCntNo = Integer.parseInt(request.getParameter("pgCntNo"));
		pgCntNo = pgCntNo + 1;		
	}
	else
		{
			pgCntNo = 1;		
		}		
			rset.absolute(pr+1);	
			
			int i = pr;
			while( i<limitPerPage + pg && i<rsSize1 )
				
			{	
				i++;				
				if( i <= rsSize1)
				{

						
	    String code=rset.getString(1);

        if(rset.getString(2)!=null)
        place=rset.getString(2);
		else
        place="-";

		if(rset.getString(3)!=null)
        drillyr=rset.getString(3);
		else
        drillyr="-";

		if(rset.getString(4)==null || String.valueOf(rset.getInt(4))=="0")
        diameter="-";
		else
        diameter=rset.getString(4);
        
		if(rset.getString(5)!=null)
         status=rset.getString(5);
		 else
        status="-";
        
		if(rset.getString(6)==null || String.valueOf(rset.getInt(6))=="0")
        stalevel="-";
		else
        stalevel=rset.getString(6);

		if(rset.getString(7)==null || String.valueOf(rset.getInt(7))=="0")
        summerlevel="-";
		else
        summerlevel=rset.getString(7);
		
		if(rset.getString(8)==null || String.valueOf(rset.getInt(8))=="0")
        devalue="-";
		else
        devalue=rset.getString(8);
		
		if(rset.getString(9)!=null && rset.getString(9).equals("Y"))
         qaffect="Yes";
		else if(rset.getString(9)!=null && rset.getString(9).equals("N"))
         qaffect="No";
		else
        qaffect="-";
		
		if(rset.getString(10)==null || String.valueOf(rset.getInt(10))=="0")
        fvalue="-";
		else
        fvalue=rset.getString(10);
        if(rset.getString(11)==null || String.valueOf(rset.getInt(11))=="0")
        brvalue="-";
		else
        brvalue=rset.getString(11);
		
		if(rset.getString(12)==null || String.valueOf(rset.getInt(12))=="0")
        ivalue="-";
		else
        ivalue=rset.getString(12);
%>	
	<tr>
		

		            <td class="rptValue"><%=i%></td>
					<td class="rptValue"><%=code%></td>
					<td class="rptValue"><%=place%></td>
					<td class="rptValue"><%=drillyr%></td>
					<td class="rptValue"><%=diameter%></td>
					<td class="rptValue"><%=status%></td>
					<td class="rptValue"><%=stalevel%></td>
					<td class="rptValue"><%=summerlevel%></td>
					<td class="rptValue"><%=devalue%></td>
					<td class="rptValue"><%=qaffect%></td>
					<td class="rptValue"><%=fvalue%></td>
					<td class="rptValue"><%=brvalue%></td>
					<td class="rptValue"><%=ivalue%></td>
		
		

	</tr>
<%
					}
	                rset.next();
			}
%>

<tr>
</td>
<table align=center>
	<tr>
		<td colspan= 12>
<%
		if (pr > 0) 
		{
%>
				
			<a href="page.jsp?pr=0">[First Page]</a> 
			<a href="page.jsp?pr=<%=pr-limitPerPage%>&pg=<%=iPage-1%>">[Previous Page]</a> 
<%
		}
			if (pr < (totalpgs * limitPerPage) - limitPerPage) 
			{
%>
				<a href="page.jsp?pr=<%=pr+limitPerPage%>&pg=<%=iPage+1%>">[Next Page]</a> 
				<a href="page.jsp?pr=<%=(totalpgs * limitPerPage) - limitPerPage%>&pg=<%=(iPage * limitPerPage) - limitPerPage%>">[Last Page]</a> 
<%
			}
	

%>
		</td>
	</tr>
</table>
</body>
</html>
<%@ include file= "footer.jsp"%>
<%}
catch(Exception e)
{
  e.printStackTrace();
}

	//conn.close();
%>








