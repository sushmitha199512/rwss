<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="nic.watersoft.commons.RwsUtils"%>



<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Anganwadi_Target_Achievement.xls");
System.out.println("Ip:"+request.getRemoteAddr());
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
StringBuffer loggedUser =new StringBuffer();
loggedUser.append(user.getUserId());

StringBuffer dcode=new StringBuffer();
if(loggedUser.toString().substring(0,3).equals("col")){
	dcode.append((String.valueOf(session.getAttribute("district"))));    
   }
//22/08/2013
System.out.println("Server Date:"+w.getServerDate());

StringBuffer cYear=new StringBuffer();
cYear.append(w.getServerDate().substring(6,10));



StringBuffer currentMonth=new StringBuffer();
currentMonth.append(RwsUtils.getCurrentMont());
if(currentMonth.toString()!=null&& !(currentMonth.toString().equals("APR") || currentMonth.toString().equals("MAY") || currentMonth.toString().equals("JUN")
		|| currentMonth.toString().equals("JUL")
		|| currentMonth.toString().equals("AUG")
		|| currentMonth.toString().equals("SEP")
		|| currentMonth.toString().equals("OCT")
		|| currentMonth.toString().equals("NOV")
		|| currentMonth.toString().equals("DEC")
 
)){
	int tempYear=Integer.parseInt(cYear.toString());
	tempYear-=1;
	cYear.delete(0,cYear.length());
	cYear.append(String.valueOf(tempYear));

	
}

StringBuffer prevmonth=new StringBuffer();
prevmonth.append(RwsUtils.getPreviousMonth().toUpperCase());

int nYear=Integer.parseInt(cYear.toString());
nYear+=1;
StringBuffer finYear=new StringBuffer();

StringBuffer nextMonth=new StringBuffer();
nextMonth.append(RwsUtils.getNextMonth());





System.out.println("Server1");
%>
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
	<% 

    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	

	<html>
	<body>
    
                                 

<!-- Search Panel Starts -->


                                                

<!-- Search Panel Ends -->



			
                       

			
                                    

<!-- Grid Table Starts -->                                      

					<table width="100%" border="1" cellspacing="0" cellpadding="0">
                                            
                                        <tr >
		<td align="center" colspan=5>Drinking Water  In Anganwadi Centers. <%=cYear %>-<%=nYear %></td>	
	</tr>
		<tr >
		<td  align=center>Sl.No</td>
		<td  align=center>District</td>
<td  align=center  nowrap >Target(<%=cYear %>-<%=nYear %>)</td>
<td align=center >Achievement&nbsp;UpTo (<%=prevmonth %>-<%=cYear %>)</td>
<td align=center >Achievement % </td>
</tr>





<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
StringBuffer programmeNames=new StringBuffer();
StringBuffer Query=new StringBuffer();
StringBuffer style=new StringBuffer();
StringBuffer selectedPrograms=new StringBuffer();
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  
	  selectedPrograms.append("'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46','12'");
	  
	  
	  Hashtable schoolCovhabsHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,RWS_WORK_SCHOOL_LNK_TBL b,RWS_SCHOOL_MASTER_TBL sm ,rws_district_tbl d,rws_complete_hab_view ch  where  sm.hab_code=b.hab_code and  sm.SCHOOL_CATEGORY_CODE ='01' and b.school_code=sm.school_code and  b.work_id=a.work_id and  ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' )  and a.WORK_CANCEL_DT is null  and a.TYPE_OF_ASSET='11' and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedPrograms.toString()+") group by d.dcode,d.dname order by d.dcode");
	  System.out.println("Q1:"+Query);
	  rs2=stmt2.executeQuery(Query.toString());
	  System.out.println("Q133:"+Query);
	  while(rs2.next()){
		  
		  schoolCovhabsHash.put(rs2.getString(1),rs2.getString(3));
		  
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  
	  
	  
	  //Printing Report....
	  
	  
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname,t.ANG_HABS  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2013-2014'");
	  if(dcode.toString()!=null && !dcode.toString().equals("")){
		  Query.append(" and d.dcode='"+dcode.toString()+"'");
		}
	  Query.append(" order by d.dcode");
	 
	  int styleCount=0;
	  rs3=stmt3.executeQuery(Query.toString());
	  double  svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  Statement sst1=conn.createStatement();
	  Statement sst=conn.createStatement();
	  
	  Query.delete(0,Query.length());
      Query.append("delete from rws_svs_graph_view_tbl WHERE TYPE='ANG'");
      sst.executeUpdate(Query.toString());
      Query.delete(0,Query.length());
      Query.append("delete from rws_rfd_cs_rpt_tmp_tbl WHERE RPT_TYPE='ANG'");

      sst.executeUpdate(Query.toString());
	  while(rs3.next()){
		  
		 StringBuffer svsTargetHabs=new StringBuffer();
		 svsTargetHabs.append((String)schoolCovhabsHash.get(rs3.getString(1)));
		 if(svsTargetHabs.toString()==null || svsTargetHabs.toString().equals("null")){
			 svsTargetHabs.append("0");
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs.toString());
		 
		 if(rs3.getString(3)!=null){
				svsT+=Integer.parseInt(rs3.getString(3));
			}
		 style.delete(0,style.length());
		 if(styleCount%2==0){
			
			 style.append("gridbg1");
		 }else{
			
			 style.append("gridbg2");
		 }
		 styleCount++;
		
		 
		 int coveredhabs=Integer.parseInt(svsTargetHabs.toString());
		 double targetHabs= Double.parseDouble(rs3.getString(3));
		 
		 double habper = (coveredhabs * 100/ targetHabs);
		 
		 Query.delete(0,Query.length());
		 Query.append("insert into rws_svs_graph_view_tbl values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+habper+"','','ANG')");
		 sst1.addBatch(Query.toString());
		  Query.delete(0,Query.length());
		  Query.append("insert into rws_rfd_cs_rpt_tmp_tbl (dcode,dname,TARGET_HABS,HAB_ACH,HAB_ACH_PER,RPT_TYPE )values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+targetHabs+"','"+coveredhabs+"','"+habper+"','ANG')");
		  sst1.addBatch(Query.toString());
		  
	  }
	  
	  int res[]=sst1.executeBatch();
	  
	  Query.delete(0,Query.length());
	   Query.append("select *from rws_rfd_cs_rpt_tmp_tbl where rpt_type='ANG' order by HAB_ACH_PER desc ");
		 Statement sts=conn.createStatement();
		 ResultSet rst=sts.executeQuery(Query.toString());
		 
		 count=1;
		     while(rst.next()){
		    	 
		    	double  habper=Double.parseDouble(rst.getString(9));
		    	 if(habper>100){
		    		 habper=100;
		    	 }
		    	 
		    	 
		    	 StringBuffer colorValueHab=new StringBuffer();
		    	 StringBuffer colorValueExp=new StringBuffer();
				 
				 
				 
				 //Habs percentage 
				 if(habper>75){
					 colorValueHab.append("gridbgAbove75");
					 
				 }else  if(habper>=50 && habper<=75){
					 colorValueHab.append("gridbg50_75");
					 
				 }else  if(habper>=25 && habper<50){
					 colorValueHab.append("gridbg25_50");
					 
				 }else if(habper<25){
					 colorValueHab.append("gridbgless25");
				 }
				 style.delete(0,style.length());
				 if(styleCount%2==0){
					
					 style.append("gridbg1");
				 }else{
					 style.append("gridbg2");
				 }
				 styleCount++;
		    	 
		    
		  %>
		  
		  <tr><td style="text-align: left;" ><%=count++ %></td><td style="text-align: left;" ><%=rst.getString(2) %></td><td ><%=rst.getString(3) %></td><td style="text-align: right;"><%=rst.getString(5) %></td>
		  
		  
		  <td  style="text-align: right;"><%=ndf.format(habper) %></td></tr>
		  
		  
		  <% 
		  
		     }
	  double ghabper = ( svsH * 100/ svsT);
	  StringBuffer colorValueHab=new StringBuffer();
		//Habs percentage 
		 if(ghabper>75){
			 colorValueHab.append("gridbgAbove75");
			 
		 }else  if(ghabper>=50 && ghabper<=75){
			 colorValueHab.append("gridbg50_75");
			 
		 }else  if(ghabper>=25 && ghabper<50){
			 colorValueHab.append("gridbg25_50");
			 
		 }else if(ghabper<25){
			 colorValueHab.append("gridbgless25");
		 }
	  %>
	  <tr><td style="text-align: right;"  colspan="2">Total </td><td style="text-align: right;"  ><%=(int)svsT %></td><td style="text-align: right;" ><%=(int)svsH %></td>
	  
	  <td style="text-align: right;"  ><%=ndf.format(ghabper)%></td>
	  </tr>
	  
	  <% 
	  
	  
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 

</table>	
                                        <!-- Grid Table Ends -->


			
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>
</body>
</html>
