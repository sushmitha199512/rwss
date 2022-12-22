<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>

<form>
<%
 



    String qry="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    

    
    String level=request.getParameter("level");
    String fromDate=request.getParameter("fromDate");
    String toDate=request.getParameter("toDate");
    

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  |&nbsp; </td>
	<td ><a href="rws_news_paper_clippings_rpt_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>">Excel  &nbsp; </td>
	 
	</tr>  
	</table>
	</caption>
	
	
    
	</table>
	<%
	if(level.equals("All")){
	%>
	<table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="9"><b>News Paper Clippings(Level:<%=level %>)</b></td>
		
		</tr>
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg>Level</td>
    <td class=gridhdbg >NO.Of Clippings </td>
    </tr>
	 <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		
		
			</tr>
       
<%
try
{
	
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   
						
qry="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where clip_level='State' and dcode='00' and PAPER_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy')";
  
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   
	   totalClippings=rs8.getInt(1);
	  String s="State";
  	
	 if(styleCount%2==0){
		 style="gridbg2";
	 }else{
		 style="gridbg1";
	 }
	 styleCount++;
	

	 
%>
 <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: right;">State</td>
       
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=s%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=totalClippings%></a></td>      
   
      	</tr>
	
   	
   	
<%


}
   %>
 
   	
   
   <%
   
	if(rs8!=null){
		rs8.close();
	}
	if(stmt8!=null){
		stmt8.close();
	}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>
 <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
  
		
  
	 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District Name</td>
    <td class=gridhdbg colspan=5> Total NO.Of Clippings</td>
	
       </tr>
	<tr>
	
	<td class=gridhdbg>District</td>
    <td class=gridhdbg>Mandal</td>
    <td class=gridhdbg>Panchayat</td>
    <td class=gridhdbg>Village</td>
    <td class=gridhdbg>Habitation</td>
   
    
    
	</tr>
	 <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		<td class="gridhdbg">4</td>
		<td class="gridhdbg">5</td>
		<td class="gridhdbg">6</td>
		<td class="gridhdbg">7</td>
		
			</tr>
     <%
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>  
<%
try
{
	


   //main qry
   PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
   Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
   int sno=1;
   int tdcount=0,tmcount=0,tpcount=0,tvcount=0,thcount=0;
  
   String qrydistricts="select distinct dcode,dname from rws_complete_hab_view order by dcode";
   pstmt1=conn.prepareStatement(qrydistricts);
   rs1=pstmt1.executeQuery();
   while(rs1.next()){
	   int dcount=0,mcount=0,pcount=0,vcount=0,hcount=0;
	  String dcode=rs1.getString(1);
	  String dname=rs1.getString(2);
  	String d="District";
   					
	qry="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where dcode=? and CLIP_Level='District' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   if(rs2.next())
   {
	   dcount=rs2.getInt(1);
	   tdcount+=dcount;
   }
   pstmt2.close();
   rs2.close();
   %>
   <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: center;"><%=dname%></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=d%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=dcount%></a></td> 
   <%
 
	  String qrymandals="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Mandal' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String m1="Mandal";
	  pstmt3=conn.prepareStatement(qrymandals);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   mcount=rs3.getInt(1);
		   tmcount+=mcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=m1%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=mcount%></a></td>
   
  <%
 
	  String qryPanchayats="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Panchayat' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String p="Panchayat";
	  pstmt3=conn.prepareStatement(qryPanchayats);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   pcount=rs3.getInt(1);
		   tpcount+=pcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=p%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=pcount%></a></td>
       
       <%
 
	  String qryVillages="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Village' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String v="Village";
	  pstmt3=conn.prepareStatement(qryVillages);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   vcount=rs3.getInt(1);
		   tvcount+=vcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=v%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=vcount%></a></td>       
   
   <%
 
	  String qryHabitations="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Habitation' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String h="Habitation";
	  pstmt3=conn.prepareStatement(qryHabitations);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   hcount=rs3.getInt(1);
		   thcount+=hcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=h %>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=hcount%></a></td>
      	</tr>
	
   	
   	
<%


}
   %>
 
   	<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=tdcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tmcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tpcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tvcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=thcount %></td>

</tr>
   
   <%
   
	
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>

    
</table>
	<%	
	}
	else if(level.equals("State")){
		%>
		
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="9"><b>News Paper Clippings(Level:<%=level %>)</b></td>
		
		</tr>
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg>Level</td>
    <td class=gridhdbg >NO.Of Clippings </td>
    </tr>
	
       
<%
try
{
	
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   
						
qry="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where clip_level='State' and dcode='00' and PAPER_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy')";
  
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   
	   totalClippings=rs8.getInt(1);
	  
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
 <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: right;"><%=level%></td>
       
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=totalClippings%></a></td>      
   
      	</tr>
	
   	
   	
<%


}
   %>
 
   	
   
   <%
   
	if(rs8!=null){
		rs8.close();
	}
	if(stmt8!=null){
		stmt8.close();
	}
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>
		<%
	}
	else if(level.equals("District")){
		%>
		
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="9"><b>News Paper Clippings(Level:<%=level %>)</b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District Name</td>
    <td class=gridhdbg colspan=5> Total NO.Of Clippings</td>
	
       </tr>
	<tr>
	
	<td class=gridhdbg>District</td>
    <td class=gridhdbg>Mandal</td>
    <td class=gridhdbg>Panchayat</td>
    <td class=gridhdbg>Village</td>
    <td class=gridhdbg>Habitation</td>
   
    
    
	</tr>
	 <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		<td class="gridhdbg">4</td>
		<td class="gridhdbg">5</td>
		<td class="gridhdbg">6</td>
		<td class="gridhdbg">7</td>
		
			</tr>
     <%
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>  
<%
try
{
	


   //main qry
   PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null,pstmt8=null;
   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
   Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
   int sno=1;
   int tdcount=0,tmcount=0,tpcount=0,tvcount=0,thcount=0;
  
   String qrydistricts="select distinct dcode,dname from rws_complete_hab_view order by dcode";
   pstmt1=conn.prepareStatement(qrydistricts);
   rs1=pstmt1.executeQuery();
   while(rs1.next()){
	   int dcount=0,mcount=0,pcount=0,vcount=0,hcount=0;
	  String dcode=rs1.getString(1);
	  String dname=rs1.getString(2);
  
   					
	qry="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where dcode=? and CLIP_Level='District' and PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')";
	pstmt2=conn.prepareStatement(qry);  
	pstmt2.setString(1, dcode);
	pstmt2.setString(2, fromDate);
	pstmt2.setString(3, toDate);
   rs2=pstmt2.executeQuery();
   if(rs2.next())
   {
	   dcount=rs2.getInt(1);
	   tdcount+=dcount;
   }
   pstmt2.close();
   rs2.close();
   %>
   <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: center;"><%=dname%></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=level%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=dcount%></a></td> 
   <%
 
	  String qrymandals="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Mandal' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String m1="Mandal";
	  pstmt3=conn.prepareStatement(qrymandals);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   mcount=rs3.getInt(1);
		   tmcount+=mcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=m1%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=mcount%></a></td>
   
  <%
 
	  String qryPanchayats="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Panchayat' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String p="Panchayat";
	  pstmt3=conn.prepareStatement(qryPanchayats);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   pcount=rs3.getInt(1);
		   tpcount+=pcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=p%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=pcount%></a></td>
       
       <%
 
	  String qryVillages="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Village' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String v="Village";
	  pstmt3=conn.prepareStatement(qryVillages);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   vcount=rs3.getInt(1);
		   tvcount+=vcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=v%>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=vcount%></a></td>       
   
   <%
 
	  String qryHabitations="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where DCODE=? and CLIP_Level='Habitation' and   PAPER_DATE between to_date(?,'dd/mm/yyyy') and to_date(?,'dd/mm/yyyy')"; 
	  String h="Habitation";
	  pstmt3=conn.prepareStatement(qryHabitations);  
	  pstmt3.setString(1, dcode);
	  pstmt3.setString(2, fromDate);
	  pstmt3.setString(3, toDate);
	   rs3=pstmt3.executeQuery();
	   if(rs3.next())
	   {
		   hcount=rs3.getInt(1);
		   thcount+=hcount;
	   }
	   pstmt3.close(); 
	   rs3.close();
	  
  // }
   %>
   <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_news_paper_clippings_rpt_drill.jsp?level=<%=h %>&dcode=<%=dcode%>&dname=<%=dname%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>')"><%=hcount%></a></td>
      	</tr>
	
   	
   	
<%


}
   %>
 
   	<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=tdcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tmcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tpcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=tvcount %></td>
<td class="gridhdbg" style="text-align: right;"><%=thcount %></td>

</tr>
   
   <%
   
	
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>

    
</table>
		<%
	}
	%>
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>