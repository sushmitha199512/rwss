<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@page import="nic.watersoft.commons.*"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Mvs_Target_Acheivement.xls");
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();

String dcode="";
if(loggedUser.substring(0,3).equals("col")){
	dcode=(String)session.getAttribute("district");    
   }
//22/08/2013
System.out.println("Server Date:"+w.getServerDate());
String nYearStr="";

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
	nYearStr=String.valueOf(tempYear);
	tempYear-=1;
	cYear=String.valueOf(tempYear);
	
}
else{
	nYearStr=cYear;
}

String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();




prevmonth=prevmonth.toUpperCase();
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
	
<!-- Grid Table Starts -->                                      

				<table width="100%" border="1" cellspacing="0" cellpadding="0">
<tr>
		<td align="center" colspan=11><b>Works Program under MVS <%=cYear %>-<%=nYear %></b></td>	
	</tr>
		<tr >
		<td   rowspan=2 align=center>Sl.No</td>
		<td  rowspan=2 align=center>District</td>
<td  align=center colspan=2 nowrap >Target(<%=cYear %>-<%=nYear %>) <br></br><b>Amount In Lakhs.</b></td>
<td colspan=4 align=center >Achievement (<%=cYear %>-<%=nYear %>) <br><b>Amount In Lakhs.</b></br></td>
<td  colspan=3 align=center >Percentage Achieved</td>
</tr>
<tr>
<td  align="center"  >Habitations Coverage</td>
 <td align="center"  >Anticipated<br>Expenditure</td>	
 <td align="center"  >Habitations Coverage</td>
 <td align="center"  >Expenditure<br>Upto<%=prevmonth %></td>
 <td align="center"  >Expenditure <br>During&nbsp;<%=currentMonth %></td>
 <td align="center"  >Expenditure <br></br>During(<%=cYear %>-<%=nYear %>)</td>
 
 <td  align="center"  >Habitations <br>(5/3 * 100)</br>During(<%=cYear %>-<%=nYear %>)</td>
 <!-- 
 <td   align="center"  >Expenditure <br>(8/4 * 100)</br>During(<%=cYear %>-<%=nYear %>)</td>
  -->
 	
</tr>

<tr><td  align=center>1</td>
<td align=center>2</td>
<td align=center>3</td>
<td align=center>4</td>
<td align=center>5</td>
<td align=center>6</td>
<td align=center>7</td>
<td align=center>8</td>
<td align=center>9</td>



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
	  
	  String selectedProgramsFin="'01','02','18','23','32','48','49','51','58','59','60','50'";
	  String selectedProgramsDirectVouchersFin="'04','12','65','46','57'";
	  String selectedProgramsPhy="'01','02','18','23','32','48','49','51','58','04','57','65','46','12'";
	  
	  
	  
	  Hashtable svsCovhabsHash=new Hashtable();
	  String svsHabsQuery="select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d,rws_complete_hab_view ch  where ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where ((to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear+"') or (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+cYear+"') ))   and a.WORK_CANCEL_DT is null and a.category_code='1' and  a.type_of_asset in('01','02','03')   and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsPhy+") group by d.dcode,d.dname order by d.dcode";
	  System.out.println("Q1333:"+svsHabsQuery);
	  rs2=stmt2.executeQuery(svsHabsQuery);
	  while(rs2.next()){
		  
		  svsCovhabsHash.put(rs2.getString(1),rs2.getString(3));
		  
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  /**********************************************/
	  
	  Hashtable svsExpLastMonHash=new Hashtable();
	  String svsExpLastMonthQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where  a.WORK_CANCEL_DT is null and a.category_code='1'    and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+currentMonth+"-"+nYearStr+"'  group by d.dcode,d.dname order by d.dcode";
	 // System.out.println("Q2:"+svsExpLastMonthQuery);
	  rs4=stmt4.executeQuery(svsExpLastMonthQuery);
	  while(rs4.next()){
		  
		  svsExpLastMonHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
  /******************************Direct exp ************************/
	  
	  stmt4=conn.createStatement();
	  Hashtable svsExpLastMonDirectHash=new Hashtable();
	  String svsExpLastMonthDirectQuery="select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_work_direct_voucher_tbl v  where   a.WORK_CANCEL_DT is null and a.category_code='1'    and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsDirectVouchersFin+") and to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+currentMonth+"-"+nYearStr+"'  group by d.dcode,d.dname order by d.dcode";
	 System.out.println("Q2:"+svsExpLastMonthDirectQuery);
	  rs4=stmt4.executeQuery(svsExpLastMonthDirectQuery);
	  while(rs4.next()){
		  
		  svsExpLastMonDirectHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
/**********************************************/
	  
/**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsExpCurrenMonHash=new Hashtable();
	  String svsExpCurrentMonthQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where a.WORK_CANCEL_DT is null and a.category_code='1'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-"+currentMonth+"-"+nYearStr+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+nextMonth+"-"+nYearStr+"'  group by d.dcode,d.dname order by d.dcode";
	  //System.out.println("Q4:"+svsExpCurrentMonthQuery);
	  rs4=stmt4.executeQuery(svsExpCurrentMonthQuery);
	  while(rs4.next()){
		  
		  svsExpCurrenMonHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
	  
	  
	  /**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsExpCurrenMonDirectHash=new Hashtable();
	  String svsExpCurrentMonthDirectQuery="select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_work_direct_voucher_tbl v  where    a.WORK_CANCEL_DT is null and a.category_code='1'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsDirectVouchersFin+") and to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-"+currentMonth+"-"+nYearStr+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+nextMonth+"-"+nYearStr+"'  group by d.dcode,d.dname order by d.dcode";
	  System.out.println("Q4:"+svsExpCurrentMonthDirectQuery);
	  rs4=stmt4.executeQuery(svsExpCurrentMonthDirectQuery);
	  while(rs4.next()){
		  
		  svsExpCurrenMonDirectHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
/**********************************************/
	  
	  
/**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsTotExpHash=new Hashtable();
	  String svsTotExpQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where  a.WORK_CANCEL_DT is null and a.category_code='1'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-APR-"+nYear+"'  group by d.dcode,d.dname order by d.dcode";
	 // System.out.println("Q5:"+svsTotExpQuery);
	  rs4=stmt4.executeQuery(svsTotExpQuery);
	  while(rs4.next()){
		  
		  svsTotExpHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  /**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsTotExpDirectHash=new Hashtable();
	  String svsTotExpDirectQuery="select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_work_direct_voucher_tbl v  where   a.WORK_CANCEL_DT is null and a.category_code='1'   and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsDirectVouchersFin+") and to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-APR-"+nYearStr+"'  group by d.dcode,d.dname order by d.dcode";
	  System.out.println("Q5:"+svsTotExpDirectQuery);
	  rs4=stmt4.executeQuery(svsTotExpDirectQuery);
	  while(rs4.next()){
		  
		  svsTotExpDirectHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  //Printing Report....
	  
	  
	  String distQuery="select d.dcode,d.dname,t.MVS_HABS,(t.MVS_EXP*100)  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2013-2014'";
	  if(dcode!=null && !dcode.equals("")){
		  distQuery+=" and d.dcode='"+dcode+"'";
		}
	  distQuery+=" order by d.dcode";
	  
	  rs3=stmt3.executeQuery(distQuery);
	  double svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  String style="";
	  int styleCount=0;
	  double d1=0,d2=0,d3=0;
	  double ghabper = 0;
		double  svsHg=0.0,svsTg=0.0;
		 double gexpper = 0;
		 
		 Statement sst1=conn.createStatement();
		  Statement sst=conn.createStatement();
String deleteQuery="delete from rws_svs_graph_view_tbl WHERE TYPE='MVS'";
		  
		  sst.executeUpdate(deleteQuery);
		  
		  
		  String deleteQuery2="delete from rws_rfd_cs_rpt_tmp_tbl WHERE RPT_TYPE='MVS'";
		  		  
		  		  sst.executeUpdate(deleteQuery2);
		 
	  while(rs3.next()){
		  
		  
		 String svsTargetHabs=(String)svsCovhabsHash.get(rs3.getString(1));
		 if(svsTargetHabs==null || svsTargetHabs.equals("null")){
			 svsTargetHabs="0";
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs);
		 svsHg+=svsH;
		 
		 
		/******************************/
		
		String svsExpupto=(String)svsExpLastMonHash.get(rs3.getString(1));
		if(svsExpupto==null || svsExpupto.equals("null")){
			
			svsExpupto="0.0";
		}
		//System.out.println("svsExpupto:"+svsExpupto);
		d1=Double.parseDouble(svsExpupto);
		
String svsUptoDirect=(String)svsExpLastMonDirectHash.get(rs3.getString(1));
		
		if(svsUptoDirect==null || svsUptoDirect.equals("null")){
			
			svsUptoDirect="0.0";
		}
		//System.out.println("svsExpupto:"+svsExpupto);
		
		d1+=Double.parseDouble(svsUptoDirect);
		
		expUpto+=d1;
		 
		if(rs3.getString(3)!=null){
			svsT+=Integer.parseInt(rs3.getString(3));
			svsTg+=svsT;
		}
		if(rs3.getString(4)!=null){
			expT+=Double.parseDouble(rs3.getString(4));
		}
		
		
		/******************************************************/
		
		String svsCurrentExp=(String)svsExpCurrenMonHash.get(rs3.getString(1));
		if(svsCurrentExp==null || svsCurrentExp.equals("null")){
			
			svsCurrentExp="0.0";
		}
		d2=Double.parseDouble(svsCurrentExp);
		
		
String svsCurrentDirectExp=(String)svsExpCurrenMonDirectHash.get(rs3.getString(1));
		
		if(svsCurrentDirectExp==null || svsCurrentDirectExp.equals("null")){
			
			svsCurrentDirectExp="0.0";
		}
		
		
		d2+=Double.parseDouble(svsCurrentDirectExp);
		//System.out.println("svsExpupto:"+svsExpupto);
		expCurrent+=d2;
		
		
/******************************************************/
		
		String svsTotExp=(String)svsTotExpHash.get(rs3.getString(1));
		if(svsTotExp==null || svsTotExp.equals("null")){
			
			svsTotExp="0.0";
		}
		//System.out.println("svsExpupto:"+svsExpupto);
		d3=Double.parseDouble(svsTotExp);
		
		String directExp=(String)svsTotExpDirectHash.get(rs3.getString(1));
		if(directExp==null || directExp.equals("null")){
			
			directExp="0.0";
		}
		//System.out.println("svsExpupto:"+svsExpupto);
		d3+=Double.parseDouble(directExp);
		expTot+=d3;
		
		
		double targetExp=Double.parseDouble(rs3.getString(4));
		double targetHabs= Double.parseDouble(rs3.getString(3));
		int coveredhabs=Integer.parseInt(svsTargetHabs);
		
		double expper = (d3 * 100/ targetExp);
		double habper = (coveredhabs * 100/ targetHabs);
		
		
		 String insertQuery="insert into rws_svs_graph_view_tbl values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+habper+"','"+expper+"','MVS')";
		  sst1.addBatch(insertQuery);
		  
		   insertQuery="insert into rws_rfd_cs_rpt_tmp_tbl values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+rs3.getString(3)+"','"+ndf.format(targetExp)+".00','"+svsTargetHabs+"','"+d1+"','"+d2+"','"+d3+"','"+habper+"','"+expper+"','MVS')";
		  sst1.addBatch(insertQuery);
		  
		  
	  }
		  int res[]=sst1.executeBatch();
		  
		  
			 String q1="select *from rws_rfd_cs_rpt_tmp_tbl where rpt_type='MVS' order by HAB_ACH_PER desc ";
			 Statement sts=conn.createStatement();
			 ResultSet rst=sts.executeQuery(q1);
			 
			 count=1;
			     while(rst.next()){
			    	 
			    	 double expper=0,habper=0;
			    	 
			    	 
			    	 habper=Double.parseDouble(rst.getString(9));
			    	 expper=Double.parseDouble(rst.getString(10));
			    	 if(habper>100){
			    		 habper=100;
			    	 }
			    	 
			    	 if(expper>100){
			    		 expper=100;
			    	 }
			    	 
			    	 String colorValueHab="",colorValueExp="";
					 
					 
					 //Expenditure Percentage 
					 if(expper>75){
						 colorValueExp="gridbgAbove75";
						 
					 }else  if(expper>=50 && expper<=75){
						 colorValueExp="gridbg50_75";
						 
					 }else  if(expper>=25 && expper<50){
						 colorValueExp="gridbg25_50";
						 
					 }else if(expper<25){
						 colorValueExp="gridbgless25";
					 }
					 
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
				  
				  
				  
				  
				  
				  
				  <tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td><td class="<%=style %>"  style="text-align: left;"><%=rst.getString(2) %></td>
				  <td class="<%=style %>" style="text-align: left;"><%=rst.getString(3) %></td><td class="<%=style %>" style="text-align: right;" ><%=rst.getString(4) %></td>
				  <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./public_domain/rws_rfd_svs_target_ach_rpt_drill.jsp?dcode=<%=rst.getString(1) %>&type=1')"><%=rst.getString(5) %></a></td>
				  <td class="<%=style %>" style="text-align: right;" ><%=rst.getString(6) %></td><td class="<%=style %>" style="text-align: right;" ><%=rst.getString(7) %></td>
				  <td class="<%=style %>" style="text-align: right;" ><%=rst.getString(8) %></td>
				  
				   <td class="<%=colorValueHab %>" style="text-align: right;"><%=habper %></td>
				   
				   <!-- 
				   <td class="<%=colorValueExp %>" style="text-align: right;"><%=expper %></td></tr>
				   -->
				  
				  <% 
				  
				  
				  
				
				  
			  }
		gexpper = (expTot * 100/ expT);
		 ghabper = ( svsH * 100/ svsT);
		
		 
String colorValueHab="",colorValueExp="";
		 
		 
		 //Expenditure Percentage 
		 if(gexpper>75){
			 colorValueExp="gridbgAbove75";
			 
		 }else  if(gexpper>=50 && gexpper<=75){
			 colorValueExp="gridbg50_75";
			 
		 }else  if(gexpper>=25 && gexpper<50){
			 colorValueExp="gridbg25_50";
			 
		 }else if(gexpper<25){
			 colorValueExp="gridbgless25";
		 }
		 
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
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td><td style="text-align: left;"  class="gridhdbg"  ><%=(int)svsT %></td><td class="gridhdbg" style="text-align: right;"><%=ndf.format(expT) %></td><td class="gridhdbg"  style="text-align: left;"><%=(int)svsH %></td><td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expUpto) %></td><td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expCurrent) %></td><td class="gridhdbg" style="text-align: right;" > <%=ndf.format(expTot) %></td>
	    <td class="<%=colorValueHab %>"  style="text-align: right;" > <%=ndf.format(ghabper) %></td>
	    <!-- 
	  <td class="<%=colorValueExp %>"  style="text-align: right;" > <%=ndf.format(gexpper) %></td>
	 -->
	  
	  </tr>
	  
	  <% 
	  
	 
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>



</table>
                                        <!-- Grid Table Ends -->


				  
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
