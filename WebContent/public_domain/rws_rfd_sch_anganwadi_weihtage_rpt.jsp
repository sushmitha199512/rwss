<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>


<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%



////System.out.println("Ip:"+request.getRemoteAddr());
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;

user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
StringBuffer loggedUser =new StringBuffer();
loggedUser.append(user.getUserId());
//System.out.println("Q1****:");
StringBuffer dcode=new StringBuffer();


StringBuffer totalSchools=null;

if(loggedUser.toString().substring(0,3).equals("col")){
	
	dcode.append((String.valueOf(session.getAttribute("district"))));    
   }
//22/08/2013
////System.out.println("Server Date:"+w.getServerDate());


StringBuffer style=new StringBuffer();
StringBuffer qry=new StringBuffer();
StringBuffer cYear=new StringBuffer(w.getServerDate().substring(6,10));

StringBuffer currentMonth=new StringBuffer(RwsUtils.getCurrentMont().toUpperCase());

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
	cYear.append(String.valueOf(tempYear));
	
}



StringBuffer prevmonth=new StringBuffer(RwsUtils.getPreviousMonth());

int nYear=Integer.parseInt(cYear.toString());
nYear+=1;
StringBuffer finYear=new StringBuffer();

StringBuffer nextMonth=new StringBuffer(RwsUtils.getNextMonth());




prevmonth.append(prevmonth.toString().toUpperCase());
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
	
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>
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


<!-- Search Panel Ends -->



				    </td>
				</tr>
<tr>
<td height="20"></td>

<tr><td align="right" class="bwborder" colspan="2"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;
                    <a href="rws_rfd_sch_anganwadi_weihtage_excel.jsp" target="_new">Excel</a></td></tr>       

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                   <tr >
		<td align="center" class="gridhdbg" colspan=18><font color="white">Drinking Water Facilities to Schools & Anganwadies <%=cYear %>-<%=nYear %></font></td>	
	</tr>
		<tr >
		
		<td align="right" class="gridhdbg" colspan=9><font color="white">Schools </font></td>
		<td align="center" class="gridhdbg" colspan=7><font color="white">Anganwadies</font></td>
		</tr>
		<tr>
		<td class="gridhdbg"  align=center>Sl.No</td>
		<td class="gridhdbg"  align=center>District</td>
		
		<td class="gridhdbg"  align=center>Total Schools</td>
		<td class="gridhdbg"  align=center>Drinking Facilities available</td>
		<td class="gridhdbg"  align=center>Balance</td>
<td class="gridhdbg"  align=center  nowrap >Target(<%=cYear %>-<%=nYear %>)</td>
<td class="gridhdbg" align=center >Achievement (<%=prevmonth %>-<%=cYear %>)</td>
<td class="gridhdbg" align=center >Percentage Achievement </td>
<td class="gridhdbg" align=center >Weightage-5 </td>

        <td class="gridhdbg"  align=center>Total Anganwadies</td>
		<td class="gridhdbg"  align=center>Drinking Facilities available</td>
		<td class="gridhdbg"  align=center>Balance</td>
<td class="gridhdbg"  align=center  nowrap >Target(<%=cYear %>-<%=nYear %>)</td>
<td class="gridhdbg" align=center >Achievement (<%=prevmonth %>-<%=cYear %>)</td>
<td class="gridhdbg" align=center >Percentage Achievement </td>
<td class="gridhdbg" align=center >Weightage-5 </td>

</tr>




<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null;
//StringBuffer programmeNames=new StringBuffer();
//StringBuffer programmeNamesa=new StringBuffer();
int count=1;
  try{
	 
	  //System.out.println("Q1:");
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  stmt5=conn.createStatement();
	  stmt6=conn.createStatement();
	  stmt7=conn.createStatement();
	  
	  
	  StringBuffer selectedPrograms=new StringBuffer("'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46'");
	  
	  int styleCount=0;
	//schools Achievements qry
	  Hashtable schoolCovhabsHash=new Hashtable();
	  stmt2=conn.createStatement();
	  qry.delete(0,qry.length());
	  qry.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,RWS_WORK_SCHOOL_LNK_TBL b,RWS_SCHOOL_MASTER_TBL sm ,rws_district_tbl d,rws_complete_hab_view ch  where  sm.hab_code=b.hab_code and  sm.SCHOOL_CATEGORY_CODE <>'01' and b.school_code=sm.school_code and  b.work_id=a.work_id and  ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' ) and a.WORK_CANCEL_DT is null  and a.TYPE_OF_ASSET='11' and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedPrograms.toString()+") group by d.dcode,d.dname order by d.dcode");
	  //System.out.println("Q1:"+qry);
	  rs2=stmt2.executeQuery(qry.toString());
	  //System.out.println("Q1yyy:"+qry);
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
	  
//total schools qry
qry.delete(0,qry.length());
	  Hashtable totalschHash=new Hashtable();
	  stmt2=conn.createStatement();
	  qry.append("select substr(hab_code,1,2),count(*) from RWS_SCHOOL_MASTER_TBL  where  SCHOOL_CATEGORY_CODE <>'01' group by substr(hab_code,1,2) order by substr(hab_code,1,2)");
	  //System.out.println("Total schools"+qry);
	  rs2=stmt2.executeQuery(qry.toString());
	  while(rs2.next()){
		  
		  totalschHash.put(rs2.getString(1),rs2.getString(2));
		    
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
//Drinking water facilities in schools qry
qry.delete(0,qry.length());
	  Hashtable waterfacHash=new Hashtable();
	  stmt2=conn.createStatement();
	  qry.append("select  substr(hab_code,1,2),count(*) from RWS_SCHOOL_MASTER_TBL  where SCHOOL_CATEGORY_CODE <>'01'  and  FACILITIES_AVAILABLE in ('Both (Drink. and Sani.)','Drinking Water Only') group by substr(hab_code,1,2) order by substr(hab_code,1,2)");
	  //System.out.println("Drinking Water Facilities"+qry);
	  rs2=stmt2.executeQuery(qry.toString());
	  while(rs2.next()){
		  
		  waterfacHash.put(rs2.getString(1),rs2.getString(2));
		    
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }


//Anganwadies Achievements qry
	  
	  StringBuffer selectedProgramsa=new StringBuffer("'01','02','18','23','32','48','49','51','53','58','59','60','04','57','65','46','12'");
	  
	  qry.delete(0,qry.length());
	  Hashtable schoolCovhabsHasha=new Hashtable();
	 qry.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,RWS_WORK_SCHOOL_LNK_TBL b,RWS_SCHOOL_MASTER_TBL sm ,rws_district_tbl d,rws_complete_hab_view ch  where  sm.hab_code=b.hab_code and  sm.SCHOOL_CATEGORY_CODE ='01' and b.school_code=sm.school_code and  b.work_id=a.work_id and  ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' )  and a.WORK_CANCEL_DT is null  and a.TYPE_OF_ASSET='11' and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsa.toString()+") group by d.dcode,d.dname order by d.dcode");
	  //System.out.println("Q2:"+qry);
	  rs5=stmt5.executeQuery(qry.toString());
	  while(rs5.next()){
		  
		  schoolCovhabsHasha.put(rs5.getString(1),rs5.getString(3));
		  
		  
	  }
	
	  if(rs5!=null)
	  {
		  rs5.close();
	  }
	  if(stmt5!=null){
		  stmt5.close();
	  }

	//total anganwadies qry
	qry.delete(0,qry.length());
	  Hashtable totalangHash=new Hashtable();
	  stmt2=conn.createStatement();
	  qry.append("select substr(hab_code,1,2),dname ,count(SCHOOL_CODE) from RWS_SCHOOL_MASTER_TBL,rws_district_tbl  where substr(hab_code,1,2)=dcode and SCHOOL_CATEGORY_CODE ='01' group by dname, substr(hab_code,1,2) order by substr(hab_code,1,2)");
	  //System.out.println("Total Anganwadies"+qry);
	  rs2=stmt2.executeQuery(qry.toString());
	  while(rs2.next()){
		  
		  totalangHash.put(rs2.getString(1),rs2.getString(3));
		    
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
//Drinking water facilities in anganwadies qry
qry.delete(0,qry.length());
	  Hashtable angwaterfacHash=new Hashtable();
	  stmt2=conn.createStatement();
	qry.append("select  substr(hab_code,1,2),count(*) from RWS_SCHOOL_MASTER_TBL where  SCHOOL_CATEGORY_CODE='01'  and  FACILITIES_AVAILABLE in ('Both (Drink. and Sani.)' ,'Drinking Water Only') group by substr(hab_code,1,2) order by substr(hab_code,1,2)");
	 // //System.out.println(" Awd Drinking Water Facilities"+angwaterfacQuery);
	  rs2=stmt2.executeQuery(qry.toString());
	  while(rs2.next()){
		  
		  angwaterfacHash.put(rs2.getString(1),rs2.getString(2));
		    
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }


	  //Printing Report....
	   qry.delete(0,qry.length());
	  //schools and anganwadies targets qry
	  qry.append("select d.dcode,d.dname,t.SCH_HABS,t.ANG_HABS  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2014-2015'");
	  if(dcode.toString()!=null && !dcode.toString().equals("")){
		  qry.append(" and d.dcode='"+dcode.toString()+"'");
		}
	  qry.append(" order by d.dcode");
	  //System.out.println("distq"+qry);
	  
	  rs3=stmt3.executeQuery(qry.toString());
	  
	  
	  //System.out.println("iiiiii"+qry);
	  double svsH=0,svsT=0,svsHa=0,svsTa=0;
      int gtotsch=0,gwaterfac=0,gschbal=0, gtotang=0,gangwaterfac=0,gangbal=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  
	  
	  Statement sst1=conn.createStatement();
	  

	  
	   totalSchools=new StringBuffer();
	  StringBuffer waterfac=new StringBuffer();
	  
	  StringBuffer svsTargetHabs=new StringBuffer();
	  StringBuffer svsTargetHabsa=new StringBuffer();
	  StringBuffer totalangwd=new StringBuffer();
	  //System.out.println("dgfsdgfg777");
	  
	  while(rs3.next()){
		  //System.out.println("dgfsdgfg");
		
		  totalSchools.delete(0,totalSchools.length());
		 totalSchools.append((String.valueOf((totalschHash.get(rs3.getString(1))))));
		 //System.out.println("kkkk"+totalSchools);
		 if(totalSchools.toString()==null || totalSchools.toString().equals("") || totalSchools.toString().equals("null")){
			 totalSchools.append("0");
			 //System.out.println("rrrr");
		 }
		 gtotsch+=Integer.parseInt(totalSchools.toString());
		 ////System.out.println("jjjkkkk"+totalSchools);
		 waterfac.delete(0,waterfac.length()); 
		waterfac.append((String)waterfacHash.get(rs3.getString(1)));
		 if(waterfac.toString()==null || waterfac.toString().equals("null")){
			 waterfac.append("0");
		 }
		 gwaterfac+=Integer.parseInt(waterfac.toString());
		 
		 int schbal=Integer.parseInt(totalSchools.toString())-Integer.parseInt(waterfac.toString());
		 gschbal=gtotsch-gwaterfac;
		 
		 
		 
		 svsTargetHabs.delete(0,svsTargetHabs.length()); 
		 svsTargetHabs.append((String)schoolCovhabsHash.get(rs3.getString(1)));
		 if(svsTargetHabs.toString()==null || svsTargetHabs.toString().equals("null")){
			 svsTargetHabs.delete(0,svsTargetHabs.length());
			 svsTargetHabs.append("0");
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs.toString());
		// //System.out.println("SVSH"+svsH);
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
		 
		 
		double habper = 0;
		if(targetHabs>0){
		habper=(coveredhabs * 100/ targetHabs);
		}
		
		
		  %>
		  
		  <tr>
		  <td style="text-align: left;" class=<%=style %>><%=count++ %></td>
		  <td style="text-align: left;" class=<%=style %> ><%=rs3.getString(2) %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=totalSchools%></td>
		  <td style="text-align: right;" class=<%=style %> ><%=waterfac%></td>
		  <td style="text-align: right;" class=<%=style %> ><%=schbal%></td>
		  <td style="text-align: right;" class=<%=style %> ><%=rs3.getString(3) %></td>
		  <td style="text-align: right;" class=<%=style %> > <%=svsTargetHabs %></td>
		  <td  style="text-align: right;" class=<%=style %>><%=ndf.format(habper) %></td>
		  <td  style="text-align: right;" class=<%=style %>><%= ndf.format((habper*5)/100)%></td>
		  
		  
		  <% 
		  
		  
	
//Anganwadies
     
	 
	  double expUptoa=0,expTa=0,expCurrenta=0,expTota=0;
	  
		  totalangwd.delete(0,totalangwd.length());
		  totalangwd.append((String)totalangHash.get(rs3.getString(1)));
			 if(totalangwd==null || totalangwd.equals("null")){
				 totalangwd.append("0");
			 }
			 gtotang+=Integer.parseInt(totalangwd.toString());
			 
			 String angwaterfac=(String)angwaterfacHash.get(rs3.getString(1));
			 if(angwaterfac==null || angwaterfac.equals("null")){
				 angwaterfac="0";
			 }
			 gangwaterfac+=Integer.parseInt(angwaterfac.toString());
			 
			 int angwdbal=Integer.parseInt(totalangwd.toString())-Integer.parseInt(angwaterfac.toString());
			 gangbal=gtotang-gangwaterfac;
			 
		  
		  
			 svsTargetHabsa.delete(0,svsTargetHabsa.length());
		  
		svsTargetHabsa.append((String)schoolCovhabsHasha.get(rs3.getString(1)));
		 if(svsTargetHabsa.toString().equals("null")){
			 svsTargetHabsa.delete(0,svsTargetHabsa.length());
			 svsTargetHabsa.append("0");
		 }
		 
		 svsHa+=Integer.parseInt(svsTargetHabsa.toString());
		// //System.out.println("SVSha"+svsHa);
		 if(rs3.getString(4)!=null){
				svsTa+=Integer.parseInt(rs3.getString(4));
			}
		 ////System.out.println("SVSha"+svsTa);
		
		
		 
		 int coveredhabsa=Integer.parseInt(svsTargetHabsa.toString());
		 double targetHabsa= Double.parseDouble(rs3.getString(4));
		 double habpera =0;
		 if(targetHabsa>0){
		habpera = (coveredhabsa * 100/ targetHabsa);
		 }
		 
	   %>
       <td style="text-align: right;" class=<%=style %> ><%=totalangwd %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=angwaterfac %></td>
		  <td style="text-align: right;" class=<%=style %> ><%=angwdbal %></td>
       <td style="text-align: right;" class=<%=style %> ><%=rs3.getString(4) %></td>
       <td style="text-align: right;" class=<%=style%>  ><%=svsTargetHabsa %></td>
       <td style="text-align: right;" class=<%=style %> ><%= ndf.format(habpera) %> </td>
        <td style="text-align: right;" class=<%=style %> ><%= ndf.format(((habpera)*5)/100)%></td>
       </tr>
   
      <% 
		  
		  
	  }
	
	  
	  double ghabper =0;
if(svsT>0)
{
      ghabper = ( svsH * 100/ svsT);
}
double ghabpera =0;
if(svsTa>0)
{
	  ghabpera = ( svsHa * 100/ svsTa);
}
	  %>
	  <tr><td class="gridhdbg" style="text-align: right;"  colspan="2">Total </td>
	  <td class="gridhdbg" style="text-align: right;"><%=gtotsch%> </td>
	  <td class="gridhdbg" style="text-align: right;"><%=gwaterfac%></td>
	  <td class="gridhdbg" style="text-align: right;"><%=gschbal%> </td>
	  <td class="gridhdbg" style="text-align: right;"><%=(int)svsT %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=(int)svsH %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(ghabper) %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format((ghabper)*5/100) %></td>
	   <td class="gridhdbg" style="text-align: right;"> <%=gtotang%></td>
	  <td class="gridhdbg" style="text-align: right;"><%=gangwaterfac%> </td>
	  <td class="gridhdbg" style="text-align: right;"> <%=gangbal%> </td>
	  <td style="text-align: right;"  class="gridhdbg"><%=(int)svsTa %></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=(int)svsHa%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format(ghabpera)%></td>
	  <td style="text-align: right;" class="gridhdbg" ><%=ndf.format((ghabpera)*5/100)%> </td></tr>
	  <% 
	  

	
  }catch(Exception e){
  e.printStackTrace();
}
  finally
  {
	
	  loggedUser=null;
	  dcode=null;
	  style=null;
	  qry=null;
	  cYear=null;
	  currentMonth=null;
	  prevmonth=null;
	  finYear=null;
	  nextMonth=null;
	
	  
	  
  }

 %>
 
 

</table>	
                                        <!-- Grid Table Ends -->


			<!-- 	    Please Click Here to View Graph<a href="<rws:context page='/public_domain/rws_rfd_sch_target_ach_graph.jsp' />" target="_new"><img src="<rws:context page='/images/chart.png' />"  width="40" height="40"/></a></td> -->
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
</html>
