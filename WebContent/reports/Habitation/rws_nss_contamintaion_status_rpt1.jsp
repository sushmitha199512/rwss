<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<!-- <script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script> -->
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
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "center">
	<tr align=center>
	<td align="center" class="rptHeading">District:<font color="red"><%=dname%></font>
	</tr>
		</table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back |&nbsp; </td>
	 <td ><a href="rws_nss_contamintaion_status_rpt1_xls.jsp?district=<%=dcode%>&dname=<%=dname%>">Excel &nbsp; </td>
	</tr>  
	</table>
	</caption>
	<tr >
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
	   
	   qry="select count(*) from  RWS_HAB_CONTAMINATION_TBL b,rws_complete_hab_view a,RWS_CONTAMINATION_TBL c,rws_habitation_directory_tbl d  where a.panch_code=b.hab_code  and a.panch_code=d.hab_code and b.hab_code=d.hab_code AND b.cont_type=c.contamination_code and d.coverage_status='NSS' and dcode='"+rs1.getString(1)+"' and CONTAMINATION_CODE='03'  order by dcode  ";
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
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=f%>&contaminationType=<%=tf%>')"> <%=flouride%></a></td> 
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=b%>&contaminationType=<%=tb%>')"> <%=brakish%></a></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=i%>&contaminationType=<%=ti%>')"> <%=iron%></a></td>  
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=a%>&contaminationType=<%=ta%>')"> <%=aresenic%></a></td>
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=n%>&contaminationType=<%=tn%>')"> <%=nitrate%></a></td>  
      <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_nss_contamintaion_status_rpt1_drill.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>&contaminationCode=<%=n%>&contaminationType=<%=all%>')"> <%=total%></a></td>
     
     
             
   
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