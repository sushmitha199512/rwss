<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp" %>

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