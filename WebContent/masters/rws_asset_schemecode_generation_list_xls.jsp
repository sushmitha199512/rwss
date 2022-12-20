
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>


<form>
<%
 



    String qry="";
    int styleCount=0;
    String style="";
  ArrayList assets=(ArrayList)session.getAttribute("assets");  
 // System.out.println("assets"+assets.size());

   	%>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<!--<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>
	<td ><a href="rws_news_paper_clippings_rpt_xls.jsp">Excel  &nbsp; </td>-->
	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	 
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="14"><b>Asset Scheme Code Generated List</b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>Asset Code</td>
    <td class=gridhdbg>Scheme Code</td>
    <td class=gridhdbg>Asset Name</td>
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Asset Status</td>
    <td class=gridhdbg>Cost of Asset</td>
    <td class=gridhdbg>Start Year</td>
    <td class=gridhdbg>District</td>
    <td class=gridhdbg>Mandal</td>
    <td class=gridhdbg>Panchayat</td>
    <td class=gridhdbg>Village</td>
    <td class=gridhdbg>Habitation Name</td>
    <td class=gridhdbg>Habitation Code</td>
    
   
       </tr>
	
     <%
    Connection conn=null;
     Statement stmt1=null;
     ResultSet rs1=null;
     try{
    	 conn=RwsOffices.getConn();
         int sno=1;
         stmt1=conn.createStatement();
         Iterator iterator=assets.iterator();
         while(iterator.hasNext()){
        	 String asset_code=(String)iterator.next();
        	// System.out.println("asset_code---"+asset_code);
         qry="select a.ASSET_CODE as ASSET_CODE,nvl(ASSET_NAME,'--') as ASSET_NAME,HAB_CODE,nvl(LOCATION,'--') as LOCATION,DATE_CREATION,ASSET_STATUS,ASSET_COST,nvl(START_YEAR,'--') as START_YEAR,scheme_code,DNAME,MNAME,PNAME,VNAME,PANCH_CODE,PANCH_NAME  from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and a.asset_code='"+asset_code+"'";
      						
     
        
       //  System.out.println("qry anupama"+qry);
      	 
         rs1=stmt1.executeQuery(qry);
       
         if(rs1.next())
         {
        	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>  

 
    <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("ASSET_CODE")%>&nbsp;</td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("SCHEME_CODE")%>&nbsp;</td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("ASSET_NAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("LOCATION")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("ASSET_STATUS")%></td>
      <td class="<%=style%> "style="text-align: right;"><%= rs1.getString("ASSET_COST")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("START_YEAR")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("DNAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("MNAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PNAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("VNAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PANCH_NAME")%></td>
      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PANCH_CODE")%>&nbsp;</td>
      
      
         
             
            
     </tr> 
   
    <%}
         }
     }
     catch(Exception e){
    	 e.printStackTrace();
     }
     finally{
    	 
     }
    %>
</table>
	</table> 
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>