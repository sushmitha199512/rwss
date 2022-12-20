<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

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
String dcode=request.getParameter("dcode");

String dname=request.getParameter("dname");


String contaminationCode=request.getParameter("contaminationCode");
String contaminationType=request.getParameter("contaminationType");



    
    
   	%>
	
	<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>
			
		 |<a href="rws_nss_contamintaion_status_rpt1_drill_xls.jsp?dcode=<%=dcode%>&dname=<%=dname%>&contaminationCode=<%=contaminationCode%>&contaminationType=<%=contaminationType%>">Excel</a></td> 

  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >NSS contamination report as per habitation status(District:<%=dname %>&nbsp;&nbsp;Parameter:<%=contaminationType %>)</td>
</tr>

</table>
   
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg >Sl.No</td>
   
    <td class=gridhdbg >Mandal</td>
    <td class=gridhdbg >Panchayat</td>
    <td class=gridhdbg >Village</td>
	<td class=gridhdbg >Habitation Code</td>
	<td class=gridhdbg >Habitation Name</td>
	<%
	if(contaminationType.equals("All")){
		%>
		<td class=gridhdbg >Contamination Type</td>
		<%
	}
	%>
	<!-- <td class=gridhdbg >Contamination Percentage</td>
	<td class=gridhdbg >Status Date</td> -->
	
       </tr>
	
	
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   if(contaminationType.equals("All")){
	   qry="select dname,mname,pname,vname,d.hab_code,panch_name,CONTAMINATION_NAME,nvl(CONT_PERC,0),nvl(to_char(b.STATUS_DATE,'dd/mm/yyyy'),'-') from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+dcode+"'  order by dcode  ";
   }
   else{
	   qry="select dname,mname,pname,vname,d.hab_code,panch_name,CONTAMINATION_NAME,nvl(CONT_PERC,0),nvl(to_char(b.STATUS_DATE,'dd/mm/yyyy'),'-') from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+dcode+"' and c.contamination_code='"+contaminationCode+"'  order by dcode  ";   
   }

 
   
	 
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
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
      
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td> 
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td> 
      <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(4)%></td> 
      <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(5)%></td>
      <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(6)%></td>
      <%
	if(contaminationType.equals("All")){
		%>
		<td class="<%=style%> "style="text-align: left;"><%=rs8.getString(7)%></td>
		<%
	}
	%>  
      
     
      	</tr>
	
   	
   	
<%


}
   %>
  <tr>
	
   
   
      	</tr>
   	
   
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

