<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<% 
   //String fvalue=null,ivalue=null,bvalue=null,qaffected=null,dvalue=null,locn=null,diameter=null,stalevel=null,summerlevel=null,drillyr=null,status=null;
   String fvalue=null,ivalue=null,qaffect=null,place=null,diameter=null,stalevel=null,summerlevel=null,
   drillyr=null,status=null,Status=null;
  String sqlquery=null,sqlquery1=null,dcode=null,mcode=null,pcode=null,vcode=null,prcode=null,distcode=null,bvalue=null,cvalue=null,svalue=null,nvalue=null,dvalue=null,wvalue=null,value=null;
    int srlno=0,total=0,wtotal=0,ntotal=0,stotal=0,dtotal=0,ctotal=0,qaffected=0,tflouride=0,tbrakish=0,
    tiron=0;

 try
 {
 
   distcode=request.getParameter("dcode");
   Status=request.getParameter("status");
 
   if(Status.equals("W"))
	 {
   sqlquery ="select hp_code,location,drill_year,diameter,DECODE(status,'W','Working'),static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and status='W' order by drill_year";

    ps=conn.prepareStatement(sqlquery);
    ps.setString(1, distcode);
   
    rs = ps.executeQuery();  
  
	 }
  else  if(Status.equals("S"))
	 {
   sqlquery ="select hp_code,location,drill_year,diameter,DECODE(status,'S','Seasonal'),static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and status='S' order by drill_year";

    ps=conn.prepareStatement(sqlquery);
    ps.setString(1, distcode);
   
    rs = ps.executeQuery();  
  
	 }
	else if(Status.equals("C"))
	 {
   sqlquery ="select hp_code,location,drill_year,diameter,DECODE(status,'C','Condemned'),static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and status='C' order by drill_year";

    ps=conn.prepareStatement(sqlquery);
    ps.setString(1, distcode);
   
    rs = ps.executeQuery();  
  
	 }
    else if(Status.equals("D"))
	 {
   sqlquery ="select hp_code,location,drill_year,diameter,DECODE(status,'D','Dried'),static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and status='D' order by drill_year";

    ps=conn.prepareStatement(sqlquery);
    ps.setString(1, distcode);
   
    rs = ps.executeQuery();  
  
	 }
	 else
	 {
        sqlquery ="select hp_code,location,drill_year,diameter,DECODE(status,'N','Notworking'),static_wl,summer_wl,depth,quality_affected,flouride,brakish,iron from rws_hp_subcomp_param_tbl where substr(hp_code,1,2)=? and status='N' order by drill_year";

    ps=conn.prepareStatement(sqlquery);
    ps.setString(1, distcode);
   
    rs = ps.executeQuery();  
  
	 }
   
 }
   catch (Exception e)
 {
	 //.out.println("About Connection " + e);
 }
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">
</head>
<body>
<table border = 1 align = center cellspacing = 0 cellpadding = 0  bordercolor = "#000000" style = "border-collapse:collapse" bgcolor="#edf2f8" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width="100%" align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder">
					<a href="../home.jsp">Home|</a> 
					<a href="javascript:window.history.back()">Back|</a> 
					<!--<a target="_new" href="./xlss.jsp?status=<%=Status%>">Excel |</a>
					<a target="_new" href="./xlss_prnt.jsp?status=<%=Status%>">Print</a>-->
				    </td> 
				</tr>
			</table>
		</caption>
		<tr bgcolor="#efefef" align="center">
			<td align="center" class="rptHeading" colspan=13>District-Borewell-Details-Report</td>	
		</tr>

	<tr align="center" class="rptLabel">
		             <td>Sno</td>
					<td>Hpcode</td>
					<td>Location</td>
					<td>DrillYear</td>
					<td>Diameter (mm)</td>
					<td>Status</td>
					<td>StaticWL</td>
					<td>SummerWL</td>
					<td>Depth (metres)</td>
					<td>Quality<br>Affected</td>
					<td>Flouride</td>
					<td>Brakish</td>
					<td>Iron</td>
				
		</tr>
<% 
try
{
	while(rs.next())
	{	
		srlno++; 
        
		if(rs.getString(2)!=null || !rs.getString(2).equals("null"))
        place=rs.getString(2);
		else
        place="-";

		if(rs.getString(3)!=null || !rs.getString(3).equals("0"))
        drillyr=rs.getString(3);
		else
        drillyr="-";

		if(rs.getString(4)==null || String.valueOf(rs.getInt(4))=="0")
        diameter="-";
		else
        diameter=rs.getString(4);
        
		/*if(rs.getString(5)!=null)
         status=rs.getString(5);
		 else
        status="-";*/
        
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
					<td class="rptValue"><%=rs.getString(5)%></td>
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
	
    }
   catch(Exception q)
   {
    //.out.println("excep"+q);
	//response.sendRedirect("./ErrorPage.jsp");
   }
   finally
   {
	   conn.close();
   }

   %>
</table>
  </body>
</html>
<%@ include file="footer.jsp"%>
