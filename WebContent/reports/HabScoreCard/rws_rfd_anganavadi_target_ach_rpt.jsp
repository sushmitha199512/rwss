<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_session_validation1.jsp"%>


<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);


String currentMonth=RwsUtils.getCurrentMont();
if(currentMonth!=null&& !(currentMonth.equals("APR") || currentMonth.equals("MAY") || currentMonth.equals("JUN")
		|| currentMonth.equals("JUL")
		|| currentMonth.equals("AUG")
		|| currentMonth.equals("SEP")
		|| currentMonth.equals("OCT")
		|| currentMonth.equals("NOV")
		|| currentMonth.equals("DEC")

)){
	int tempYear=Integer.parseInt(cYear);
	tempYear-=1;
	cYear=String.valueOf(tempYear);
	
}

String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();





%>
<script language="JavaScript">

function changeLanguage(){

	var url="switch.do?prefix=/reports&page=/rwssHabScoreCard.do?mode=ANG";

	document.forms[0].action=url;
	document.forms[0].submit();
}

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
	
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html:form action="rwssHabScoreCard.do">
	<body>
    <table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
        <tr>
            <td style="padding-left: 2px; padding-right: 2px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td align="center" valign="top" bgcolor="#f5f5f5" height="348" style="padding: 4px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="padding: 4px;" width="650">
                                        

			<table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="padding: 4px;" >

<!-- Search Panel Starts -->


 <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                                <tr >
                                                    
                                                 	<td align="right">
                                                 	<table width="70%" align="right">
                                                 	<tr><td bgcolor="#4CC417" width="2%"></td>
                                                 	<td align="left" width="3%"> >75</td>
		                                            <td bgcolor="#1589FF" width="2%"></td><td align="left" width="5%"><=75 & >=50</td>
		                                            <td bgcolor="yellow" width="2%"></td><td align="left" width="5%"><50 & >=25</td>
		                                            <td bgcolor="#F62817" width="2%"></td><td align="left" width="1%"><25</td>
</tr></table>

<!-- Search Panel Ends -->



				    </td>
				</tr>
<tr>
<td height="20"></td>
<tr><td align="right" class="bwborder" colspan="2">
                    <a href="./public_domain/rws_rfd_anganavadi_target_ach_excel.jsp" target="_new"><bean:message key="app.excel" /></a>|<a href="switch.do?prefix=/reports&page=/rwssHabScoreCard.do?mode=home"><bean:message key="app.back" /></a></td></tr>       

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                                
        <tr>
                                            
                                            <td colspan="9" align="right">
                                            
                                            <html:select  style="width:100px" property="language" onchange="changeLanguage()">
                                            <html:option value="English">English</html:option>
<html:option value="Telugu">Telugu</html:option></html:select></td></tr>
                                        <tr >
		<td align="center" class="gridhdbg" colspan=11><font color="white"><bean:message key="app.anganwadiheading" /><%=cYear %>-<%=nYear %></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  align=center><bean:message key="app.sno" /></td>
		<td class="gridhdbg"  align=center><bean:message key="app.district" /></td>
<td class="gridhdbg"  align=center  nowrap ><bean:message key="app.Target" />&nbsp;(<%=cYear %>-<%=nYear %>)</td>
<td class="gridhdbg" align=center ><bean:message key="app.Achievement" />&nbsp; (<bean:message key='<%=prevmonth %>' />-<%=cYear %>)</td>
<td class="gridhdbg" align=center ><bean:message key="app.PercentageAchieved" /> </td>
</tr>





<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
String programmeNames="";
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  String selectedPrograms="'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46','12'";
	  
	  
	  Hashtable schoolCovhabsHash=new Hashtable();
	  String schHabsQuery="select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,RWS_WORK_SCHOOL_LNK_TBL b,RWS_SCHOOL_MASTER_TBL sm ,rws_district_tbl d,rws_complete_hab_view ch  where  sm.hab_code=b.hab_code and  sm.SCHOOL_CATEGORY_CODE ='01' and b.school_code=sm.school_code and  b.work_id=a.work_id and  ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear+"' )  and a.WORK_CANCEL_DT is null  and a.TYPE_OF_ASSET='11' and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedPrograms+") group by d.dcode,d.dname order by d.dcode";
	  //System.out.println("Q1:"+schHabsQuery);
	  rs2=stmt2.executeQuery(schHabsQuery);
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
	  
	  
	  String distQuery="select d.dcode,d.dname,t.ANG_HABS  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2013-2014'";
	  
	  String style="";
	  int styleCount=0;
	  rs3=stmt3.executeQuery(distQuery);
	  double  svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  Statement sst1=conn.createStatement();
	  Statement sst=conn.createStatement();
String deleteQuery="delete from rws_svs_graph_view_tbl WHERE TYPE='ANG'";
sst.executeUpdate(deleteQuery);

String deleteQuery2="delete from rws_rfd_cs_rpt_tmp_tbl WHERE RPT_TYPE='ANG'";

sst.executeUpdate(deleteQuery2);
	  while(rs3.next()){
		  
		 String svsTargetHabs=(String)schoolCovhabsHash.get(rs3.getString(1));
		 if(svsTargetHabs==null || svsTargetHabs.equals("null")){
			 svsTargetHabs="0";
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs);
		 
		 if(rs3.getString(3)!=null){
				svsT+=Integer.parseInt(rs3.getString(3));
			}
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		
		 
		 int coveredhabs=Integer.parseInt(svsTargetHabs);
		 double targetHabs= Double.parseDouble(rs3.getString(3));
		 
		 double habper = (coveredhabs * 100/ targetHabs);
		 
		
		 String insertQuery="insert into rws_svs_graph_view_tbl values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+habper+"','','ANG')";
		  sst1.addBatch(insertQuery);
		 
		  insertQuery="insert into rws_rfd_cs_rpt_tmp_tbl (dcode,dname,TARGET_HABS,HAB_ACH,HAB_ACH_PER,RPT_TYPE )values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+targetHabs+"','"+coveredhabs+"','"+habper+"','ANG')";
		  sst1.addBatch(insertQuery);
		  
	  }
	  
	  int res[]=sst1.executeBatch();
	  
	  
		 String q1="select *from rws_rfd_cs_rpt_tmp_tbl where rpt_type='ANG' order by HAB_ACH_PER desc ";
		 Statement sts=conn.createStatement();
		 ResultSet rst=sts.executeQuery(q1);
		 
		 count=1;
		     while(rst.next()){
		    	 
		    	double  habper=Double.parseDouble(rst.getString(9));
		    	 if(habper>100){
		    		 habper=100;
		    	 }
		    	 
		    	 
		    	 String colorValueHab="",colorValueExp="";
				 
				 
				 
				 //Habs percentage 
				 if(habper>75){
					 colorValueHab="gridbgAbove75";
					 
				 }else  if(habper>=50 && habper<=75){
					 colorValueHab="gridbg50_75";
					 
				 }else  if(habper>=25 && habper<50){
					 colorValueHab="gridbg25_50";
					 
				 }else if(habper<25){
					 colorValueHab="gridbgless25";
				 }
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
		    	 
		    
		  %>
		  
		  <tr><td style="text-align: left;" class=<%=style %>><%=count++ %></td><td style="text-align: left;" class=<%=style %> ><bean:message key='<%=rst.getString(2).replaceAll(" ","")%>' /></td><td style="text-align: right;" class=<%=style %> ><%=rst.getString(3) %></td><td style="text-align: right;" class=<%=style %> > <a href="#" onclick="viewWorks('./public_domain/rws_rfd_sch_ang_target_ach_rpt_drill.jsp?dcode=<%=rst.getString(1) %>&type=ang')"><%=rst.getString(5) %></a></td>
		  
		  
		  <td  style="text-align: right;" class=<%=colorValueHab %>><%=ndf.format(habper) %></td></tr>
		  
		  
		  <% 
		  
		     }
	  double ghabper = ( svsH * 100/ svsT);
	  String colorValueHab="";
		//Habs percentage 
		 if(ghabper>75){
			 colorValueHab="gridbgAbove75";
			 
		 }else  if(ghabper>=50 && ghabper<=75){
			 colorValueHab="gridbg50_75";
			 
		 }else  if(ghabper>=25 && ghabper<50){
			 colorValueHab="gridbg25_50";
			 
		 }else if(ghabper<25){
			 colorValueHab="gridbgless25";
		 }
	  %>
	  <tr><td class="gridhdbg" style="text-align: right;"  colspan="2"><bean:message key="app.total" /> </td><td style="text-align: right;"  class="gridhdbg"><%=(int)svsT %></td><td style="text-align: right;" class="gridhdbg" ><%=(int)svsH %></td>
	  
	  <td style="text-align: right;" class=<%=colorValueHab %> ><%=ndf.format(ghabper)%></td>
	  </tr>
	  
	  <% 
	  
	  
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 

</table>	
                                        <!-- Grid Table Ends -->


				    <bean:message key="app.graph" /><a href="<rws:context page='/public_domain/rws_rfd_ang_target_ach_graph.jsp' />" target="_new"><img src="<rws:context page='/images/chart.png' />"  width="40" height="40"/></a></td>
				</tr>
</table>









                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>
</body>
</html:form>
