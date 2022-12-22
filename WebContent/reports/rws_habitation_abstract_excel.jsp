
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/tgrwss/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/tgrwss/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{
//var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	//if(URL!="")
	//{
	//	myNewWin = window.open(URL,'newWinddow',popFeatures);
	//	myNewWin.focus();	
	//}	
	TINY.box.show({url:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "base line survey abstract.xls");



String dcode=String.valueOf(session.getAttribute("dcode"));

System.out.println("dcode**********" +dcode);

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


    int styleCount=0;
    String style="";
    int sno=1;
    Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
    ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
    
    
    
	
     
    
   	%>
	
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td align="center" class=gridhdbg colspan=28>Habitation Details</td>
	</tr>
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Mandal</td>
    <td class=gridhdbg rowspan=2>Panchayat</td>
    <td class=gridhdbg rowspan=2>No.Of Habitations</td>
    <td class=gridhdbg rowspan=1 colspan="4">Population</td>
     <td class=gridhdbg rowspan=1 colspan="7">Status</td>
      <td class=gridhdbg rowspan=1 colspan="5">Existing Assets</td>
        <td class=gridhdbg rowspan=1 colspan="2">Coverage of Habs Under Ongoing Works</td>
   </tr>
   
   
   <tr>
   
      <td class=gridhdbg >Plain</td>
      <td class=gridhdbg >SC</td>
      <td class=gridhdbg> ST</td>
      <td class=gridhdbg> Total </td>
      <td class=gridhdbg >FC</td>
      <td class=gridhdbg >PC4</td>
      <td class=gridhdbg >PC3</td>
      <td class=gridhdbg >PC2</td>
      <td class=gridhdbg >PC1</td>
      <td class=gridhdbg >NC</td>
      <td class=gridhdbg >QA</td>
      <td class=gridhdbg >CPWS</td>
      <td class=gridhdbg >PWS</td>
      <td class=gridhdbg >MPWS</td>
      <td class=gridhdbg >DP</td>
      <td class=gridhdbg >HP&SHP</td>
       <td class=gridhdbg >No.Of Habs</td>
      <td class=gridhdbg >Population</td>
   </tr>
    
    
       
<%
try
{
	int popSum=0;
	 String mainqry="select dname,mname,pname,count(a.Hab_code),sum(a.CENSUS_PLAIN_POPU),sum(a.CENSUS_SC_POPU),sum(a.CENSUS_ST_POPU),sum(case when a.coverage_status='FC' THEN 1 ELSE 0 END),sum(case when a.coverage_status='PC4' THEN 1 ELSE 0 END),sum(case when a.coverage_status='PC3' THEN 1 ELSE 0 END),sum(case when a.coverage_status='PC2' THEN 1 ELSE 0 END),sum(case when a.coverage_status='PC1' THEN 1 ELSE 0 END),sum(case when a.coverage_status='NC' THEN 1 ELSE 0 END),sum(case when a.coverage_status='NSS' THEN 1 ELSE 0 END),sum(case when CPWS_NO>0 then 1 else 0 end),sum(case when PWS_NO>0 then 1 else 0 end),sum(case when MPWS_NO>0 then 1 else 0 end),sum(case when DIRECT_PUMPING_NO>0 then 1 else 0 end),sum(case when HPS_NO>0 then 1 else 0 end),sum(case when SHP_NO>0 then 1 else 0 end),mcode,pcode	 from rws_habitation_directory_tbl a,rws_complete_hab_view b,RWS_HAB_SUPPLY_STATUS_TBL c  where a.hab_code=b.panch_code and a.hab_code=c.hab_code and b.panch_code=c.hab_code and substr(a.hab_code,1,2)='"+dcode+"' group by  dname,mname,pname,dcode,mcode,pcode ";
	//System.out.println("mainqry"+mainqry);
	 stmt1=conn.createStatement();
	 rs1=stmt1.executeQuery(mainqry);
	 while(rs1.next())
	 {
		
		 
		 String qry="select  count(distinct hab_code) from rws_admn_hab_lnk_tbl where substr(hab_code,1,2)='"+dcode+"' and  substr(hab_code,6,2)='"+rs1.getString(21)+"' and substr(hab_code,13,2)='"+rs1.getString(22)+"'   and work_id not in(select work_id from rws_work_completion_tbl )";
		 //System.out.println("qry"+qry);
		 stmt2=conn.createStatement();
		 rs2=stmt2.executeQuery(qry);
		 if(rs2.next())
		 {		
			 
			 String qry1="select distinct a.hab_code,b.CENSUS_PLAIN_POPU,b.CENSUS_SC_POPU,b.CENSUS_ST_POPU from rws_admn_hab_lnk_tbl a,rws_habitation_directory_tbl b where a.hab_code=b.hab_code and substr(a.hab_code,1,2)='"+dcode+"' and  substr(a.hab_code,6,2)='"+rs1.getString(21)+"' and substr(a.hab_code,13,2)='"+rs1.getString(22)+"'    and work_id not in(select work_id from rws_work_completion_tbl )";
			 //System.out.println("qry1"+qry1);
			 stmt3=conn.createStatement();
			 rs3=stmt3.executeQuery(qry1);
			 while(rs3.next())
			 {
				 
				 popSum=popSum+rs3.getInt(2)+rs3.getInt(3)+rs3.getInt(4);
			 }
			 rs3.close();
			 stmt3.close();
		 int population=rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7);
		 int tothpshp=rs1.getInt(19)+rs1.getInt(20);
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;  
		 
		 %>
		 <tr>
		 <td  class="<%=style%>" style="text-align:  left;"> <%=sno++%></td>
     <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getString(1)%></td>
      <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getString(2)%></td>
        <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getString(3)%></td>
        <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(4)%></td>
        <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(5)%></td>
           <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(6)%></td>
              <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(7)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=population%></td>
               
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(8)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(9)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(10)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(11)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(12)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(13)%></td>
               <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(14)%></td>
               
                <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(15)%></td>
                 <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(16)%></td>
                 <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(17)%></td>
                 <td  class="<%=style%>" style="text-align: left;"> <%=rs1.getInt(18)%></td>
                   <td  class="<%=style%>" style="text-align: left;"> <%=tothpshp%></td>
                   <td  class="<%=style%>" style="text-align: left;"> <%=rs2.getString(1)%></td>
                     <td  class="<%=style%>" style="text-align: left;"> <%=popSum%></td>
                     
		 </tr>
		 <%
		 
		 popSum=0;
	    
		 }
		 rs2.close();
		 stmt2.close();
	 }
	rs1.close();
	stmt1.close();
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>