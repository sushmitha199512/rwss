
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<form>
<%
 
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");


    String qry="";
    int styleCount=0;
    String style="";
    int totpopu=0;
    int palin=0;
    int st=0;
    int sc=0;
String dcode=request.getParameter("district");

String dname=request.getParameter("dname");





    
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	
	<tr align="center">
	<td align="center" class="rptHeading" >NSS contamination report as per habitation status</td>
	</tr>
    
	</table>
   
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
    <td class=gridhdbg >District</td>
    <td class=gridhdbg >Flouride</td>
    <td class=gridhdbg >Brakish</td>
    <td class=gridhdbg >Iron</td>
	<td class=gridhdbg >Aresenic</td>
	<td class=gridhdbg >Nitrate</td>
	<td class=gridhdbg >Total</td>
	<!-- <td class=gridhdbg >Contamination Percentage</td>
	<td class=gridhdbg >Status Date</td> -->
	
       </tr>
	<tr>
<td class=gridhdbg >1</td>
<td class=gridhdbg >2</td>
<td class=gridhdbg >3</td>
<td class=gridhdbg >4</td>
<td class=gridhdbg >5</td>
<td class=gridhdbg >6</td>
<td class=gridhdbg >7</td>
<td class=gridhdbg >8</td>
</tr>
	
       
<%
try
{
	


   //main qry
   Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null;
   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
   int sno=1;
   int flouride=0,brakish=0,iron=0,aresenic=0,nitrate=0,total=0;
   int flourideTotal=0,brakishTotal=0,ironTotal=0,aresenicTotal=0,nitrateTotal=0,tTotal=0;
   String f="";
   String b="";
   String i="";
   String a="";
   String n="";
   String tf="";
   String tb="";
   String ti="";
   String ta="";
   String tn="";
   
   if(dcode!= null && !dcode.equals("") && dcode.equals("00"))
   {
	  		
	qry="select distinct dcode,dname from rws_complete_hab_view  order by dcode";
   }
   
   else
   { 
	   qry="select distinct dcode,dname from rws_complete_hab_view where dcode='"+dcode+"'  order by dcode  ";   
   }
   stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(qry);
   

   while(rs1.next())
   {
	   qry="select count(CONTAMINATION_CODE) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='01' order by dcode  ";
	   stmt2=conn.createStatement();
	   rs2=stmt2.executeQuery(qry);
	   if(rs2.next()){
		   flouride= rs2.getInt(1);
		   f="01";
		   tf="Flouride";
	   }
	   stmt2.close();
	   rs2.close();
	   
	   qry="select count(CONTAMINATION_CODE) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='02'  order by dcode  ";
	   stmt3=conn.createStatement();
	   rs3=stmt3.executeQuery(qry);
	   if(rs3.next()){
		   brakish= rs3.getInt(1);
		   b="02";
		   tb="Brakish";
	   }
	   stmt3.close();
	   rs3.close();
	   
	   qry="select count(CONTAMINATION_CODE) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='03'  order by dcode  ";
	   stmt4=conn.createStatement();
	   rs4=stmt4.executeQuery(qry);
	   if(rs4.next()){
		   iron= rs4.getInt(1);
		   i="03";
		   ti="Iron";
	   }
	   stmt4.close();
	   rs4.close();
	   
	   qry="select count(CONTAMINATION_CODE) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='04'  order by dcode  ";
	   stmt5=conn.createStatement();
	   rs5=stmt5.executeQuery(qry);
	   if(rs5.next()){
		   aresenic= rs5.getInt(1);
		   a="04";
		   ta="Aresenic";
	   }
	   stmt5.close();
	   rs5.close();
	   
	   qry="select count(CONTAMINATION_CODE) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='05'  order by dcode  ";
	   stmt6=conn.createStatement();
	   rs6=stmt6.executeQuery(qry);
	   if(rs6.next()){
		   nitrate= rs6.getInt(1);
		   n="05";
		   tn="Nitrate";
	   }
	   stmt6.close();
	   rs6.close();
  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 total=flouride+brakish+iron+aresenic+nitrate;
	 String all="All";
%>
 <tr>
	
	 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs1.getString(2)%></td>   
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=f%>&contaminationType=<%=tf%>')"> <%=flouride%></a></td> 
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=b%>&contaminationType=<%=tb%>')"> <%=brakish%></a></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=i%>&contaminationType=<%=ti%>')"> <%=iron%></a></td>  
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=a%>&contaminationType=<%=ta%>')"> <%=aresenic%></a></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=n%>&contaminationType=<%=tn%>')"> <%=nitrate%></a></td>  
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1.drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=n%>&contaminationType=<%=all%>')"> <%=total%></a></td>
     
     
             
   
      	</tr>
	
   	
   	
<%
flourideTotal=flourideTotal+flouride;
brakishTotal=brakishTotal+brakish;
ironTotal=ironTotal+iron;
aresenicTotal=aresenicTotal+aresenic;
nitrateTotal=nitrateTotal+nitrate;
tTotal=tTotal+total;
}
   stmt1.close();
   rs1.close();
   %>
  <tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=flourideTotal %></td>
<td class="gridhdbg" style="text-align: right;"><%=brakishTotal %></td>
<td class="gridhdbg" style="text-align: right;"><%=ironTotal%></td>
<td class="gridhdbg" style="text-align: right;"><%=aresenicTotal %></td>
<td class="gridhdbg" style="text-align: right;"><%=nitrateTotal %></td>
<td class="gridhdbg" style="text-align: right;"><%=tTotal %></td>
</tr>
   	
   
   <%
   
	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>