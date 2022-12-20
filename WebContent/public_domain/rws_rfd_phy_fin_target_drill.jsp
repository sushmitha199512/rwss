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

</script>
<form>
<%

String dcode=request.getParameter("dcode");
String mode=request.getParameter("mode");
String dname=request.getParameter("dname");
String programe=request.getParameter("programe");

String scheme=request.getParameter("scheme");
String poptype=request.getParameter("poptype");
//String programe=request.getParameter("programe");
//String financialstartyr=request.getParameter("financialstartyr");
//////System.out.println("rDistrict"+rDistrict);

//System.out.println("dcode"+dcode);
//System.out.println("mode"+mode);
System.out.println("poptype"+poptype);


DecimalFormat ndf = new DecimalFormat("##.##");

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";
    
    double gtot=0;

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" >Schemes-(Physical & Financial)-Report </td>
	<td align="center" class="rptHeading" >District:<%=dname%></td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>
   
    <td class=gridhdbg >Work Id</td>
    <td class=gridhdbg >Work Name</td>
    <td class=gridhdbg >Programme</td>
     <td class=gridhdbg >Bal Est Cost</td>
    
     
	  
   

   </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
   
   if(mode!=null && !mode.equals("") && mode.equals("works"))
   {
	   
	 
   qry="select distinct WORK_ID,WORK_NAME,PROGRAMME,BAL_EST_COST  from rws_target_works_tbl where work_id is not null and substr(work_id,5,2)='"+dcode+"' and  substr(work_id,1,2) in ("+programe.toString()+") and  substr(work_id,7,2) in ("+scheme.toString()+") ";
   if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	   qry+=" and work_id  in (select distinct t.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd,rws_target_works_tbl t where ah.hab_code=hd.hab_code and ah.work_id=t.work_id " ;
 		if(poptype.toString().equals("SC"))
		{
 			qry+="  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) ";
		}
		else if(poptype.toString().equals("ST"))
		{
			qry+=" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU ) ";
		}
		else 
		{
			qry+=" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  t.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU))  ";
			
	}
 	
	}

   }
   
   
   
      
   System.out.println("qry"+qry);   
        
   
	 
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
    
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(1)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
       <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(3)%></td>
        <td class="<%=style%> "style="text-align: left;"> <%=ndf.format(rs8.getDouble(4))%></td>
         
        
      
    

  
  	</tr>
  	
<%

 gtot+=rs8.getDouble(4);

}%>
<tr>
	
 <tr>
 <td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
 <td class="gridhdbg"  style="text-align: right;"></td>
	  <td class="gridhdbg"  style="text-align: right;"></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gtot)%></td>
   	
 
 
   	</tr>

<%
if(stmt8!=null){
	stmt8.close();
}
if(rs8!=null){
	rs8.close();
}

	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>