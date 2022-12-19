<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="header_rpt.jsp"%>
<%@ include file = "variables.jsp" %>


<% 
 String fvalue=null,ivalue=null,qaffect=null,place=null,diameter=null,stalevel=null,summerlevel=null,
 drillyr=null,status=null;
   
   try
 {
	
   distcode=request.getParameter("dcode");
   mcode=request.getParameter("mcode");
   pcode=request.getParameter("pcode");
   vcode=request.getParameter("vcode");
  
    
   sqlquery ="select hp_code,location,drill_year,diameter,status,static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and substr(hp_code,6,2)=? and substr(hp_code,13,2)=? and substr(hp_code,8,3)=? order by drill_year";
   
   ps=con.prepareStatement(sqlquery);
        
		 ps.setString(1, distcode);
         ps.setString(2, mcode);
		 ps.setString(3, pcode);
         ps.setString(4, vcode);
		 
  rs = ps.executeQuery(); 
  }
   catch (Exception e)
 {
	 //System.out.println("About Connection " + e);
 }
%>
<html>
<head>
<title>Villages</title>
<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">
</head>
<body>
<table border = 1 align = center cellspacing = 0 cellpadding = 0  bordercolor = "#000000" style = "border-collapse:collapse" bgcolor="#edf2f8" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder">
					<a href="javascript:window.history.back()">Back |
					<a href="../home.jsp">Excel
					</td> 
				</tr>
			</table>
		</caption>
		<tr bgcolor="#efefef" align="center">
			<td align="center" class="rptHeading" colspan=13>Village-Borewell-Details-Report</td>	
		</tr>

	<tr align="center" class="rptLabel">
					<th>Sno</th>
					<th>Hpcode</th>
					<th>Location</th>
					<th>DrillYear</th>
					<th>Diameter</th>
					<th>Status</th>
					<th>StaticWL</th>
					<th>SummerWL</th>
					<td>Depth</td>
					<th>Quality<br>Affected</th>
					<th>Flouride</th>
					<th>Brakish</th>
					<th>Iron</th>
				</tr>
<% 
try
{
	while(rs.next())
	{	
		srlno++; 
        if(rs.getString(2)!=null)
        place=rs.getString(2);
		else
        place="-";

		if(rs.getString(3)!=null)
        drillyr=rs.getString(3);
		else
        drillyr="-";

		if(rs.getString(4)==null || String.valueOf(rs.getInt(4))=="0")
        diameter="-";
		else
        diameter=rs.getString(4);
        
		if(rs.getString(5)!=null)
         status=rs.getString(5);
		 else
        status="-";
        
		if(rs.getString(6)==null || String.valueOf(rs.getInt(6))=="0")
        stalevel="-";
		else
        stalevel=rs.getString(6);

		if(rs.getString(7)==null || String.valueOf(rs.getInt(7))=="0")
        summerlevel="-";
		else
        summerlevel=rs.getString(7);
		
		if(rs.getString(8)==null || String.valueOf(rs.getInt(8))=="0")
        dvalue="-";
		else
        dvalue=rs.getString(8);
		
		if(rs.getString(9)!=null && rs.getString(9).equals("Y"))
         qaffect="Yes";
		else if(rs.getString(9)!=null && rs.getString(9).equals("N"))
         qaffect="No";
		else
        qaffect="-";
		
		if(rs.getString(10)==null || String.valueOf(rs.getInt(10))=="0")
        fvalue="-";
		else
        fvalue=rs.getString(10);
        if(rs.getString(11)==null || String.valueOf(rs.getInt(11))=="0")
        bvalue="-";
		else
        bvalue=rs.getString(11);
		
		if(rs.getString(12)==null || String.valueOf(rs.getInt(12))=="0")
        ivalue="-";
		else
        ivalue=rs.getString(12);
     %>
		
		<tr>
					<td class="rptValue"><%=srlno%></td>
					<td class="rptValue"><%=rs.getString(1)%></td>
					<td class="rptValue"><%=place%></td>
					<td class="rptValue"><%=drillyr%></td>
					<td class="rptValue"><%=diameter%></td>
					<td class="rptValue"><%=status%></td>
					<td class="rptValue"><%=stalevel%></td>
					<td class="rptValue"><%=summerlevel%></td>
					<td class="rptValue"><%=dvalue%></td>
					<td class="rptValue"><%=qaffect%></td>
					<td class="rptValue"><%=fvalue%></td>
					<td class="rptValue"><%=bvalue%></td>
					<td class="rptValue"><%=ivalue%></td>
		</tr>
	<%
	}
	rs.close();
	ps.close();
	con.close();
    }
   catch(Exception q)
   {
    //System.out.println("excep"+q);
   }
	
%>
</table>
</body>
</html>
<%@ include file="footer.jsp"%>
