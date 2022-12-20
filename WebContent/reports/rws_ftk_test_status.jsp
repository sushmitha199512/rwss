
<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<html>

<script language="JavaScript">

function aa(srccode,ftkid){
  var newWindow;
     // alert("uuuuuuuuu:"+ftkid);
   var url = "switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=testResult&ftktestid="+ftkid+"&sourceCode="+srccode;;
	
	 var width = 900;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }

}
</script>
<head>
<title>Ftk Sataus Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 
 
</head>
<body>
<p align=right>
<%

String circlecode=null,divisioncode=null,subdivisioncode=null,mandalcode=null,panchcode=null,sourcecode=null,habcode=null,circlename=null,divisionname=null,subdivisionname=null,mandalname=null,panchname=null,habname=null,sourcename=null,year=null,yearcode=null;
String yearStart="",yearEnd="",financialYear="";
int slno=0;
	     
        
	   circlename=(String)session.getAttribute("circleName");
	   divisionname=(String)session.getAttribute("divName");
	   subdivisionname=(String)session.getAttribute("subdivName");
	   mandalname=(String)session.getAttribute("mandalName");
	   panchname=(String)session.getAttribute("panchayatName");
	   habname=(String)session.getAttribute("habName");
	   sourcename=(String)session.getAttribute("sName");
	   year=(String)session.getAttribute("yrName");
	   
	    circlecode=(String)session.getAttribute("circleCode");
		divisioncode=(String)session.getAttribute("divCode");
		subdivisioncode=(String)session.getAttribute("subdivCode");
		mandalcode=(String)session.getAttribute("mandalCode");
		panchcode=(String)session.getAttribute("panchayatCode");
		habcode=(String)session.getAttribute("habCode");
		sourcecode=(String)session.getAttribute("sCode");
		yearcode=request.getParameter("year");
		if(!yearcode.equals("-1")){
			String[] ar=yearcode.split("/");
			 yearStart=ar[0];
			 yearEnd=ar[1];
			 financialYear=ar[2];
		}
		
		
		java.util.ArrayList sourceCodes= new java.util.ArrayList();
		
		if(yearcode.equals("-1"))
		year="All";
		else
		year=financialYear;
		 
		%>
		<% 
		boolean circleflag=true;
		if(circlecode!=null && divisioncode!=null && sourcecode!=null &&!divisioncode.equals("-1"))
		{
		circleflag=false;
		}
		
		 boolean divflag=true;
		if(circlecode!=null && divisioncode!=null && sourcecode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1"))
		{
		divflag=false;
		}
		boolean subdivflag=true;
		if(circlecode!=null && divisioncode!=null && sourcecode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && mandalcode!=null && !mandalcode.equals("-1"))
		{
		subdivflag=false;
		}
		boolean manflag=true;
		if(circlecode!=null && divisioncode!=null && sourcecode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && mandalcode!=null && !mandalcode.equals("-1") && panchcode!=null && !panchcode.equals("-1"))
		{
		manflag=false;
		}
		boolean panchflag=true;
		if(circlecode!=null && divisioncode!=null && sourcecode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && mandalcode!=null && !mandalcode.equals("-1") && panchcode!=null && !panchcode.equals("-1") && habcode!=null && !habcode.equals("-1"))
		{
		panchflag=false;
		
		}
	
			
		 %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			<tr>
				<td align="right" class="bwborder"><a href="./rws_ftk_test_result_frm.jsp">Back</td> 
			  </tr>
			
			</table>
		</caption> 
		 <% if(!panchflag) {%>
		 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	     </tr>
	     <tr>
	     <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Subdivision:<%=subdivisionname%>&nbsp;&nbsp;MandalName:<%=mandalname%>&nbsp;&nbsp;PanchayatName:<%=panchname%>&nbsp;&nbsp;HabName:<%=habname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		
		 <%} else if(!manflag){%>
		  <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	    </tr>
	     <tr>
	     <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Subdivision:<%=subdivisionname%>&nbsp;&nbsp;MandalName:<%=mandalname%>&nbsp;&nbsp;PanchayatName:<%=panchname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		 
		 <%} else if(!subdivflag){%>
		  <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	    </tr>
	     <tr>
	     <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Subdivision:<%=subdivisionname%>&nbsp;&nbsp;MandalName:<%=mandalname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp; Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		 <% }else if(!divflag){%>
		  <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	    </tr>
	     <tr>
	     <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Subdivision:<%=subdivisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		
		 <% }else if(!circleflag) {%>
		  
		 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	    </tr>
	   <tr>
	     <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		
		  <%} else {%>
		   <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=12>Ftk Sample Status Report</td>	
	    </tr>
	   <tr>
	   <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;  Financial Year:<%=year%>&nbsp;&nbsp;&nbsp;</td> 
	     </tr>
		
		<%}%>
		 

	  <tr align=center  align=center>
		<td class=btext >Sl.No</td>
		
		 <% if(!panchflag) {
		   //System.out.println("11111111");%>
		
		 <%} else if(!manflag){
		 //System.out.println("222222"); %>
		 <td class=btext >Habitation Name</td>
		 <%} else if(!subdivflag){
		  //System.out.println("33333333333");%>
		   <td class=btext >Panchayat Name</td>
 		   <td class=btext >Habitation Name</td>
		 <% }else if(!divflag){
		//  System.out.println("444444444");%>
		  <td class=btext >Mandal Name</td>
		  <td class=btext >Panchayat Name</td>
 		  <td class=btext >Habitation Name</td>
		 <% }else if(!circleflag) {
		  //System.out.println("555555555555");%>
		  
		  <td class=btext >Subdivision Name</td>
		  <td class=btext >Mandal Name</td>
		  <td class=btext >Panchayat Name</td>
 		  <td class=btext >Habitation Name</td>
		  <%} else {
		  //System.out.println("6666666");%>
		  
		  <td class=btext >Division Name</td>
		  <td class=btext >Subdivision Name</td>
		  <td class=btext >Mandal Name</td>
		  <td class=btext >Panchayat Name</td>
 		  <td class=btext >Habitation Name</td>
		   <%}%>
		<td class=btext >Source Code</td>
		<td class=btext >Source Type</td>
		<td class=btext >Test&nbsp;Date</td>
		<td class=btext >Ftk TestId</td>
		<td class=btext >Ftk Test Results</td>
		
		</tr>
	      
	   <%
	   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
	   PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null;
		try
		{
	      String str="select c.circle_office_code,c.circle_office_name,f.source_code,f.source_type,to_char(f.test_date,'dd-MON-yyyy')"
	       +",ftk_test_id from rws_ftk_testing_tbl f,rws_circle_office_tbl c";
	       
	        // System.out.println("panch Name:" +panchname);
	   	
	   	 if(circlecode!=null && !circlecode.equals(""))
	     {
	      
	      str+=" where c.circle_office_code=substr(f.source_code,1,2) and c.circle_office_code='"+circlecode+"' and source_type ='"+sourcecode+"'";
	      
	     }
	     
	    if(divisioncode!=null && !divisioncode.equals("") && !divisioncode.equals("-1"))
	     {
	       str+=" and f.division_office_code='"+divisioncode+"'";
	      
	      }
	    
	     if(subdivisioncode!=null && !subdivisioncode.equals("") && !subdivisioncode.equals("-1"))
	      {
	       
	       str+=" and f.subdivision_office_code='"+subdivisioncode+"'";
	      
	     }
	     if(mandalcode!=null && !mandalcode.equals("") && !mandalcode.equals("-1"))
	      {
	       
	       str+=" and substr(f.source_code,6,2)='"+mandalcode+"'";
	     }
	     if(panchcode!=null && !panchcode.equals("") && !panchcode.equals("-1"))
	      {
	        
	       str+=" and substr(f.source_code,13,2)='"+panchcode+"'";
	     }
	     if(habcode!=null && !habcode.equals("") && !habcode.equals("-1"))
	      {
	       
	       str+=" and substr(f.source_code,0,16)='"+habcode+"'";
	     }
        
       if(yearcode!=null && !yearcode.equals("") && !yearcode.equals("-1"))
        {
        	str+=" and test_date between '"+yearStart+"' and '"+yearEnd+"'";
        }
	     slno=0;
	     PreparedStatement pstmt=conn.prepareStatement(str);
	    // System.out.println("str:"+str);
	     rs=pstmt.executeQuery();
		while(rs.next())   
	   {
	      %>
		   
		   <tr>  
		  	<td class=rptValue><%=++slno%></td>
		  	
		  	<% if(!panchflag){
		   
		 
		 
		  }else if(!manflag){
		  
		 
		  String qry="select distinct d.division_office_name,d.division_office_code from rws_division_office_tbl d,rws_ftk_testing_tbl f where f.division_office_code=d.division_office_code and substr(f.source_code,1,2)=d.circle_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt1=conn.prepareStatement(qry);
		  rs1=pstmt1.executeQuery();
		 // System.out.println(qry);
		  if(rs1.next()){
		  }
		  
		  String qry1="select distinct d.subdivision_office_name,d.subdivision_office_code from rws_subdivision_office_tbl d,rws_ftk_testing_tbl f where f.subdivision_office_code=d.subdivision_office_code and substr(f.source_code,1,2)=d.circle_office_code and  f.division_office_code=d.division_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and ftk_test_id='"+rs.getString(6)+"' ";
		  pstmt2=conn.prepareStatement(qry1);
		  rs2=pstmt2.executeQuery();
		 // System.out.println(qry1);
		  if(rs2.next()){ }
		  
		  String qry2="select distinct m.mname,m.mcode from rws_mandal_tbl m, rws_ftk_testing_tbl f where m.dcode=substr(f.source_code,1,2) and m.mcode=substr(f.source_code,6,2) and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and substr(f.source_code,1,2)='"+rs.getString(1)+"'  and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt3=conn.prepareStatement(qry2);
		  rs3=pstmt3.executeQuery();
		  //System.out.println(qry2);
		  if(rs3.next())
		  { }//rs3.close();
		  	
		  String qry3="select p.pname,p.pcode from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and  p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and p.mcode='"+rs3.getString(2)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt4=conn.prepareStatement(qry3);
		  rs4=pstmt4.executeQuery();
		  //System.out.println(qry3);
		  if(rs4.next())
		  {}
		  
		  String qry4="select p.panch_name from rws_panchayat_raj_tbl p,rws_ftk_testing_tbl f where  substr(f.source_code,0,16)=p.panch_code and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt5=conn.prepareStatement(qry4);
		  rs5=pstmt5.executeQuery();
		 // System.out.println(qry4);
		  if(rs5.next()){%>
		  
		  <td class=rptValue><%=rs5.getString(1)%></td>
		  
		  <% } 
		  
		 
		} else if(!subdivflag){
		  String qry="select distinct d.division_office_name,d.division_office_code from rws_division_office_tbl d,rws_ftk_testing_tbl f where f.division_office_code=d.division_office_code and d.STATUS<>'UI' and substr(f.source_code,1,2)=d.circle_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt1=conn.prepareStatement(qry);
		  rs1=pstmt1.executeQuery();
		 // System.out.println(qry);
		  if(rs1.next()){
		  }
		  
		  String qry1="select distinct d.subdivision_office_name,d.subdivision_office_code from rws_subdivision_office_tbl d,rws_ftk_testing_tbl f where f.subdivision_office_code=d.subdivision_office_code and substr(f.source_code,1,2)=d.circle_office_code and  f.division_office_code=d.division_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and ftk_test_id='"+rs.getString(6)+"' ";
		  pstmt2=conn.prepareStatement(qry1);
		  rs2=pstmt2.executeQuery();
		  //System.out.println(qry1);
		  if(rs2.next()){ }
		 
		  String qry2="select distinct m.mname,m.mcode from rws_mandal_tbl m, rws_ftk_testing_tbl f where m.dcode=substr(f.source_code,1,2) and m.mcode=substr(f.source_code,6,2) and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and substr(f.source_code,1,2)='"+rs.getString(1)+"'  and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt3=conn.prepareStatement(qry2);
		  rs3=pstmt3.executeQuery();
		  //System.out.println(qry2);
		  if(rs3.next())
		  { }
		 
		  String qry3="select p.pname,p.pcode from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and  p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and p.mcode='"+rs3.getString(2)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt4=conn.prepareStatement(qry3);
		  rs4=pstmt4.executeQuery();
		  //System.out.println(qry3);
		  if(rs4.next())
		  {%>
		  	 <td class=rptValue><%=rs4.getString(1)%></td>
		   <%}
		   
		  String qry4="select p.panch_name from rws_panchayat_raj_tbl p,rws_ftk_testing_tbl f where  substr(f.source_code,0,16)=p.panch_code and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt5=conn.prepareStatement(qry4);
		  rs5=pstmt5.executeQuery();
		  //System.out.println(qry4);
		  if(rs5.next()){%>
		  
		  <td class=rptValue><%=rs5.getString(1)%></td>
		  
		  <% } 
		 
		  }else if(!divflag){
		  
		 
		  String qry="select distinct d.division_office_name,d.division_office_code from rws_division_office_tbl d,rws_ftk_testing_tbl f where f.division_office_code=d.division_office_code and substr(f.source_code,1,2)=d.circle_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt1=conn.prepareStatement(qry);
		  rs1=pstmt1.executeQuery();
		  //System.out.println(qry);
		  if(rs1.next()){
		  }
		 
		  String qry1="select distinct d.subdivision_office_name,d.subdivision_office_code from rws_subdivision_office_tbl d,rws_ftk_testing_tbl f where f.subdivision_office_code=d.subdivision_office_code and substr(f.source_code,1,2)=d.circle_office_code and  f.division_office_code=d.division_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and ftk_test_id='"+rs.getString(6)+"' ";
		  pstmt2=conn.prepareStatement(qry1);
		  rs2=pstmt2.executeQuery();
		  ////System.out.println(qry1);
		  if(rs2.next()){ }
		  
		  String qry2="select distinct m.mname,m.mcode from rws_mandal_tbl m, rws_ftk_testing_tbl f where m.dcode=substr(f.source_code,1,2) and m.mcode=substr(f.source_code,6,2) and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and substr(f.source_code,1,2)='"+rs.getString(1)+"'  and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt3=conn.prepareStatement(qry2);
		  rs3=pstmt3.executeQuery();
		  //System.out.println(qry2);
		  if(rs3.next())
		  { %>
		  <td class=rptValue><%=rs3.getString(1)%></td>
		  	
		  	<%}//rs3.close();
		  	
		 
		  String qry3="select p.pname,p.pcode from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and  p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and p.mcode='"+rs3.getString(2)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt4=conn.prepareStatement(qry3);
		  rs4=pstmt4.executeQuery();
		  //System.out.println(qry3);
		  if(rs4.next())
		  {%>
		  	 <td class=rptValue><%=rs4.getString(1)%></td>
		   <%}
		   
		  String qry4="select p.panch_name from rws_panchayat_raj_tbl p,rws_ftk_testing_tbl f where  substr(f.source_code,0,16)=p.panch_code and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt5=conn.prepareStatement(qry4);
		  rs5=pstmt5.executeQuery();
		  //System.out.println(qry4);
		  if(rs5.next()){%>
		  
		  <td class=rptValue><%=rs5.getString(1)%></td>
		  
		  <% } 
		  
		 }else if(!circleflag) {
		  
		  String qry="select distinct d.division_office_name,d.division_office_code from rws_division_office_tbl d,rws_ftk_testing_tbl f where f.division_office_code=d.division_office_code and substr(f.source_code,1,2)=d.circle_office_code and d.STATUS<>'UI'and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt1=conn.prepareStatement(qry);
		  rs1=pstmt1.executeQuery();
		  //System.out.println(qry);
		  if(rs1.next()){
		  }
		  
		  String qry1="select distinct d.subdivision_office_name,d.subdivision_office_code from rws_subdivision_office_tbl d,rws_ftk_testing_tbl f where f.subdivision_office_code=d.subdivision_office_code and substr(f.source_code,1,2)=d.circle_office_code and  f.division_office_code=d.division_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and ftk_test_id='"+rs.getString(6)+"' ";
		  pstmt2=conn.prepareStatement(qry1);
		  rs2=pstmt2.executeQuery();
		  //System.out.println(qry1);
		  if(rs2.next()){ %>
		  	 <td class=rptValue><%=rs2.getString(1)%></td>
		  	<%}//rs2.close();
		  	
		  String qry2="select distinct m.mname,m.mcode from rws_mandal_tbl m, rws_ftk_testing_tbl f where m.dcode=substr(f.source_code,1,2) and m.mcode=substr(f.source_code,6,2) and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and substr(f.source_code,1,2)='"+rs.getString(1)+"'  and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt3=conn.prepareStatement(qry2);
		  rs3=pstmt3.executeQuery();
		  //System.out.println(qry2);
		  if(rs3.next())
		  { %>
		  <td class=rptValue><%=rs3.getString(1)%></td>
		  	
		  	<%}//rs3.close();
		  	
		  
		  String qry3="select p.pname,p.pcode from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and  p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and p.mcode='"+rs3.getString(2)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt4=conn.prepareStatement(qry3);
		  rs4=pstmt4.executeQuery();
		  //System.out.println(qry3);
		  if(rs4.next())
		  {%>
		  	 <td class=rptValue><%=rs4.getString(1)%></td>
		   <%}
		  
		  String qry4="select p.panch_name from rws_panchayat_raj_tbl p,rws_ftk_testing_tbl f where  substr(f.source_code,0,16)=p.panch_code and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt5=conn.prepareStatement(qry4);
		  rs5=pstmt5.executeQuery();
		  //System.out.println(qry4);
		  if(rs5.next()){%>
		  
		  <td class=rptValue><%=rs5.getString(1)%></td>
		  
		  <% } 
		  }
		  else {
		 
		  String qry="select distinct d.division_office_name,d.division_office_code from rws_division_office_tbl d,rws_ftk_testing_tbl f where f.division_office_code=d.division_office_code and substr(f.source_code,1,2)=d.circle_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt1=conn.prepareStatement(qry);
		  rs1=pstmt1.executeQuery();
		  //System.out.println(qry);
		  if(rs1.next()){
		  %>
		  <td class=rptValue><%=rs1.getString(1)%></td>
          <%}
		  //rs1.close();
		  
		  String qry1="select distinct d.subdivision_office_name,d.subdivision_office_code from rws_subdivision_office_tbl d,rws_ftk_testing_tbl f where f.subdivision_office_code=d.subdivision_office_code and substr(f.source_code,1,2)=d.circle_office_code and  f.division_office_code=d.division_office_code and substr(f.source_code,1,2)='"+rs.getString(1)+"' and ftk_test_id='"+rs.getString(6)+"' ";
		  pstmt2=conn.prepareStatement(qry1);
		  rs2=pstmt2.executeQuery();
		  //System.out.println(qry1);
		  if(rs2.next()){ %>
		  	 <td class=rptValue><%=rs2.getString(1)%></td>
		  	<%}//rs2.close();
		  	
		  String qry2="select distinct m.mname,m.mcode from rws_mandal_tbl m, rws_ftk_testing_tbl f where m.dcode=substr(f.source_code,1,2) and m.mcode=substr(f.source_code,6,2) and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and substr(f.source_code,1,2)='"+rs.getString(1)+"'  and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt3=conn.prepareStatement(qry2);
		  rs3=pstmt3.executeQuery();
		  //System.out.println(qry2);
		  if(rs3.next())
		  { %>
		  <td class=rptValue><%=rs3.getString(1)%></td>
		  	
		  	<%}//rs3.close();
		  	
		 
		  String qry3="select p.pname,p.pcode from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and  p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and substr(f.source_code,1,2)='"+rs.getString(1)+"' and f.division_office_code='"+rs1.getString(2)+"' and f.subdivision_office_code='"+rs2.getString(2)+"' and p.mcode='"+rs3.getString(2)+"' and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt4=conn.prepareStatement(qry3);
		  rs4=pstmt4.executeQuery();
		  //System.out.println(qry3);
		  if(rs4.next())
		  {%>
		  	 <td class=rptValue><%=rs4.getString(1)%></td>
		   <%}
		  
		  String qry4="select p.panch_name from rws_panchayat_raj_tbl p,rws_ftk_testing_tbl f where  substr(f.source_code,0,16)=p.panch_code and f.ftk_test_id='"+rs.getString(6)+"'";
		  pstmt5=conn.prepareStatement(qry4);
		  rs5=pstmt5.executeQuery();
		  //System.out.println(qry4);
		  if(rs5.next()){%>
		  
		  <td class=rptValue><%=rs5.getString(1)%></td>
		  
		  <% }
		 
		   }%>
		    <% String srccode=rs.getString(3);
		    
		    if(!rs.getString(4).equalsIgnoreCase(""))
				{  
				javax.sql.DataSource ds=null;
				//System.out.println("STYPE:"+rs.getString(4));
				//System.out.println("HabCode:"+rs.getString(3).substring(0,16));
				
				nic.watersoft.wquality.RwsWQualityData RwsWQualityData= new nic.watersoft.wquality.RwsWQualityData();
				sourceCodes=RwsWQualityData.getSourceCodesWithLocation2(ds,rs.getString(4),rs.getString(3).substring(0,16));
				//System.out.println("size:"+sourceCodes.size());
				}
		      
		       int n=sourceCodes.size();
				nic.watersoft.masters.RwsMaster master=new nic.watersoft.masters.RwsMaster();
		       for(int i = 0; i < n ; i++)
		       {
		       master=(nic.watersoft.masters.RwsMaster)sourceCodes.get( i );
		       
               
                // System.out.println("FFFFFFFFFFFFF"+rs.getString(3));
		      }
		       //System.out.println("DDDDDDDDDDDDDDDD:"+ master);
		      //System.out.println("Source code with Location:"+master.getSourceAndLocation());
		      if(master.getSourceAndLocation()!=null){ %>
		     <td class=rptValue><%=master.getSourceAndLocation()%></td>
		     <%}else{ %>
		        <td class=rptValue><%=rs.getString(3)%></td> 
		      <% }
		   
		  String qry5="select decode (source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPS ETS' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS') from rws_ftk_testing_tbl where source_type='"+rs.getString(4)+"'";
		  pstmt6=conn.prepareStatement(qry5);
		  rs6=pstmt6.executeQuery();
		  //System.out.println(qry5);
		  if(rs6.next()){%>
		    
		     <td class=rptValue><%=rs6.getString(1)%></td>
		     <%}%>
  			 <td class=rptValue><%=rs.getString(5)%></td>
             <% 
             String ftkid=rs.getString(6);
     		  
     		%>	
         <td class=rptValue><%=rs.getString(6)%></td>
          	<td  class=bwborder >
            <input type=button name="mode" value="..." style="width:80px" style Class="btext" onclick=aa('<%=srccode%>','<%=ftkid%>') title="Click Here"/>
			</td>
		   
		   </tr>   
             
		   <%
		   if(pstmt1!=null){
			   pstmt1.close();
			   rs1.close();
		   }
			if(pstmt2!=null){
				 pstmt2.close();
				 rs2.close();
			   }
			if(pstmt3!=null){
				 pstmt3.close(); 
				 rs3.close();
			}
			if(pstmt4!=null){
				 pstmt4.close();
				 rs4.close();
			}
			if(pstmt5!=null){
				pstmt5.close();  
				 rs5.close();
			}
			if(pstmt6!=null){
				pstmt6.close(); 
				rs6.close();
			}

		   
		  
		  
		  
		   
		   
			  
			 
			  
			  
			  
			   
	   }
		pstmt.close();
		rs.close();   
	   if(slno==0){%>
	  <tr>
	  <td colspan=8 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
		<%} 
		 
	
 }
   catch(Exception e)
   {
	    e.printStackTrace();
   }
    finally
	{
    	if(conn!=null){
	conn.close();
    	}
	}
	%>
	</table>

	</body>
	</html>
	<%@ include file = "footer.jsp" %>
