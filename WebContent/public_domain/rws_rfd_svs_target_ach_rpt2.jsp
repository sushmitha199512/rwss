<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
//Percentage = (Obtained score x 100) / Total Score
//percentage = (score * 100/ total);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);

String currentMonth=RwsUtils.getCurrentMont();
System.out.println("currentMonth11"+currentMonth);

if(currentMonth!=null&& (currentMonth.equals("APR") || currentMonth.equals("MAY") || currentMonth.equals("JUN")
		|| currentMonth.equals("JUL")
		|| currentMonth.equals("AUG")
		|| currentMonth.equals("SEP")
		|| currentMonth.equals("OCT")
		|| currentMonth.equals("NOV")
		|| currentMonth.equals("DEC")

)){
	
}else{
	int tempYear=Integer.parseInt(cYear);
	tempYear-=1;
	cYear=String.valueOf(tempYear);
}



String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
int pYear=nYear-1;
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

	DecimalFormat ndf = new DecimalFormat("####.##");

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

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="gridhdbg" colspan=13><font color="white"><b>Works Program under SVS <%=cYear %>-<%=nYear %></b></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
<td class="gridhdbg"  align=center colspan=2 nowrap >Target(<%=cYear %>-<%=nYear %>) <br></br><font color="red"><b>Amount In Lakhs.</b></font></td>
<td class="gridhdbg" colspan=4 align=center >Achievement (<%=cYear %>-<%=nYear %>) <br><font color="red"><b>Amount In Lakhs.</b></font></br></td>
 <td class="gridhdbg" colspan=4 align=center >Percentage Achieved</td>
</tr>
<tr>
<td class="gridhdbg"  align="center"  >Habitations Coverage</td>
 <td  class="gridhdbg" align="center"  >Anticipated<br>Expenditure</td>	
 <td class="gridhdbg"  align="center"  >Habitations Coverage</td>
 <td  class="gridhdbg"  align="center"  >Expenditure<br>Upto<%=prevmonth %></td>
 <td  class="gridhdbg" align="center"  >Expenditure <br>During&nbsp;<%=currentMonth %></td>
 <td  class="gridhdbg"  align="center"  >Expenditure <br></br>During(<%=cYear %>-<%=nYear %>)</td>
 
 <td  class="gridhdbg"  align="center"  >Habitations <br>(5/3 * 100)</br>During(<%=cYear %>-<%=nYear %>)</td>
 <td  class="gridhdbg"  align="center"  >Expenditure <br>(8/4 * 100)</br>During(<%=cYear %>-<%=nYear %>)</td>
 
 	
</tr>

<tr><td class="gridhdbg"   align=center>1</td>
<td class="gridhdbg"   align=center>2</td>
<td class="gridhdbg"   align=center>3</td>
<td class="gridhdbg"   align=center>4</td>
<td class="gridhdbg"   align=center>5</td>
<td class="gridhdbg"   align=center>6</td>
<td class="gridhdbg"   align=center>7</td>
<td class="gridhdbg"   align=center>8</td>
<td class="gridhdbg"   align=center>9</td>
<td class="gridhdbg"   align=center>10</td>


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
	  
	  String selectedProgramsFin="'01','02','18','23','32','48','49','51','58','59','60','04','57','65','46','12','50'";
	  String selectedProgramsPhy="'01','02','18','23','32','48','49','51','58','04','57','65','46','12'";
	  
	  
	  Hashtable svsCovhabsHash=new Hashtable();
	  String svsHabsQuery="select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d,rws_complete_hab_view ch  where ch.panch_code=b.hab_code  and a.work_id in(select work_id from rws_work_completion_tbl where  to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear+"' )   and a.WORK_CANCEL_DT is null and a.category_code='2'  and a.type_of_asset in('01','02','03') and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsPhy+") group by d.dcode,d.dname order by d.dcode";
	  System.out.println("Q1:"+svsHabsQuery);
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
	  String svsExpLastMonthQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where   a.WORK_CANCEL_DT is null and a.category_code='2'    and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+currentMonth+"-"+cYear+"'  group by d.dcode,d.dname order by d.dcode";
	//  System.out.println("Q2:"+svsExpLastMonthQuery);
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
	  
/**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsExpCurrenMonHash=new Hashtable();
	  String svsExpCurrentMonthQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where    a.WORK_CANCEL_DT is null and a.category_code='2'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-"+currentMonth+"-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+nextMonth+"-"+cYear+"'  group by d.dcode,d.dname order by d.dcode";
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
	  Hashtable svsTotExpHash=new Hashtable();
	  String svsTotExpQuery="select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where   a.WORK_CANCEL_DT is null and a.category_code='2'   and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-APR-"+nYear+"'  group by d.dcode,d.dname order by d.dcode";
	  //System.out.println("Q5:"+svsTotExpQuery);
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
	  
	  
	  
	  //Printing Report....
	  
	  
	  String distQuery="select d.dcode,d.dname,t.SVS_HABS,(t.SVS_EXP*100)  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2013-2014' order by dcode";
	  
	  
	  rs3=stmt3.executeQuery(distQuery);
	  double svsH=0,svsT=0;
	  
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  String style="";
	  double d1=0,d2=0,d3=0;
	  int styleCount=0;
	  double gexpper = 0;
		double ghabper = 0;
		double  svsHg=0.0,svsTg=0.0;
		Statement sst1=conn.createStatement();
		  Statement sst=conn.createStatement();
String deleteQuery="delete from rws_svs_graph_view_tbl WHERE TYPE='SVS'";
		  
		  sst.executeUpdate(deleteQuery);
		  
		
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
		//System.out.println("svsExpupto:"+svsExpupto);
		d2=Double.parseDouble(svsCurrentExp);
		expCurrent+=d2;
		
		
/******************************************************/
		
		String svsTotExp=(String)svsTotExpHash.get(rs3.getString(1));
		if(svsTotExp==null || svsTotExp.equals("null")){
			
			svsTotExp="0.0";
		}
		//System.out.println("svsExpupto:"+svsExpupto);
		d3=Double.parseDouble(svsTotExp);
		expTot+=d3;
		
		double targetExp=Double.parseDouble(rs3.getString(4));
		double targetHabs= Double.parseDouble(rs3.getString(3));
		int coveredhabs=Integer.parseInt(svsTargetHabs);
		
		double expper = (d3 * 100/ targetExp);
		double habper = (coveredhabs * 100/ targetHabs);
		
		
		
		double targetE=Double.parseDouble(rs3.getString(4));
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		  %>
		  
		  <tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td><td class="<%=style %>"  style="text-align: left;"><%=rs3.getString(2) %></td><td class="<%=style %>" style="text-align: left;"><%=rs3.getString(3) %></td><td class="<%=style %>" style="text-align: right;" ><%=ndf.format(targetE)+".00" %></td><td class="<%=style %>" style="text-align: left;"><a href="#" onclick="viewWorks('rws_rfd_svs_target_ach_rpt_drill.jsp?dcode=<%=rs3.getString(1) %>&type=2')"><%=svsTargetHabs %></a></td><td class="<%=style %>" style="text-align: right;" ><%=ndf.format(d1) %></td><td class="<%=style %>" style="text-align: right;" ><%=ndf.format(d2) %></td><td class="<%=style %>" style="text-align: right;" ><%=ndf.format(d3) %></td> <td class="<%=style %>" style="text-align: right;"><%=ndf.format(habper) %></td><td class="<%=style %>" style="text-align: right;"><%=ndf.format(expper) %></td></tr>
		  
		  
		  <% 
		  
		  
		  
		  
		  String insertQuery="insert into rws_svs_graph_view_tbl values ('"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+habper+"','"+expper+"','SVS')";
		  sst1.executeUpdate(insertQuery);
		  
	  }
	  		gexpper = (expTot * 100/ expT);
		 ghabper = ( svsH * 100/ svsT);
			
	  
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td><td style="text-align: left;"  class="gridhdbg"  ><%=(int)svsT %></td><td class="gridhdbg" style="text-align: right;"><%=ndf.format(expT)+".00" %></td><td class="gridhdbg"  style="text-align: left;"><%=(int)svsH %></td><td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expUpto) %></td><td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expCurrent) %></td><td class="gridhdbg" style="text-align: right;" > <%=ndf.format(expTot) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(ghabper) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(gexpper) %></td>
	  
	  
	  </tr>
	  
	  <% 
	  
	  String programmeQuery="select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+selectedProgramsFin+") order by 2 ";
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(programmeQuery);
	  while(rs4.next()){
		  programmeNames+=rs4.getString(1);
		  
		  programmeNames+=",  ";
	  }
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 
 

</table>
                                        <!-- Grid Table Ends -->


				    Please Click Here to View Graph<a href="<rws:context page='/public_domain/rws_rfd_svs_target_ach_graph.jsp' />" target="_new"><img src="<rws:context page='/images/chart.png' />"  width="40" height="40"/></a></td>
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
