<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="nic.watersoft.commons.*"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "preparation of DPR.xls");

//Percentage = (Obtained score x 100) / Total Score
//percentage = (score * 100/ total);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();

String dcode="";
if(loggedUser.substring(0,3).equals("col")){
	dcode=(String)session.getAttribute("district");    
   }
//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

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
int pYear=nYear-1;
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();

System.out.println("DDED");

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
	
<!-- Grid Table Starts -->                                      

					<table width="100%" border="1" cellspacing="0" cellpadding="0">
                                            
                                         
<tr>
		<td align="center" colspan=13><b>Preparation of DPRs </b></td>	
	</tr>
		<tr >
		<td  rowspan=2 align=center>Sl.No</td>
		<td   rowspan=2 align=center>District</td>
<td  align=center colspan=2 nowrap >Works <br></br><font color="red"><b>.</b></font></td>
 <td  align="center"  rowspan="2" >Target</td>
 <td   align="center"  rowspan="2" >Achievement</td>
  <td   align="center"  rowspan="2">Percentage</td>
  <td   align="center"  rowspan="2" >Weightage</td>
</tr>
<tr>
<td align="center"  >No</td>
 <td  align="center"  >Est.Cost</td>	
 
 	
</tr>

<tr><td   align=center>1</td>
<td  align=center>2</td>
<td   align=center>3</td>
<td   align=center>4</td>
<td    align=center>5</td>
<td    align=center>7</td>
<td  align=center>8</td>
<td   align=center>9</td>
	</tr>

<%
//Total No of Works
Statement stmt2=null,stmt3=null,stmt4=null,stmt33=null,stmt44=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs23=null,rs44=null;
String programmeNames="";
int count=1;
double sanamount=0;
  try{
	  
	  String  dprsvs="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id ";
	  dprsvs+="and a.dprstatus is not null and  a.work_id not in(select work_id from    RWS_NOTGROUNDWORKS_STATUS_TBL where   (to_date(DPRCOMPDATE) < '01-Apr-"+cYear+"')) ";
	  dprsvs+="group by	  substr(b.office_code,2,2) order by 2" ;
	
  
  
  
  
   
   
   
       Statement stmt36=conn.createStatement();
     // System.out.println("dprsvs0911********"+dprsvs);
	  ResultSet rs26=stmt36.executeQuery(dprsvs);
	Hashtable dprSVS=new Hashtable();
	while(rs26.next())
	{
		dprSVS.put(rs26.getString(2),rs26.getString(1));
		
	}

	  //for Achievement of works
	  String dprSVScomple="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.DPRSTATUS='Completed/Approved' and a.DPRSTATUS is not null and  a.DPRCOMPDATE  is not null  and (to_date(DPRCOMPDATE) >= '01-Apr-"+cYear+"') ";
		 
	  	
	
	
	dprSVScomple+=" group by  substr(b.office_code,2,2) order by 2";
	  		stmt3=conn.createStatement();
	  //System.out.println("dprSVScompletedLLLLLLLLL******"+dprSVScomple);
	  	 rs2=stmt3.executeQuery(dprSVScomple);
	  	Hashtable dprSVScom=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprSVScom.put(rs2.getString(2),rs2.getString(1));
	  	}

	  
	   String dpr331="select sum(a.SANCTION_AMOUNT ),substr(b.office_code,2,2) from rws_work_admn_prog_lnk_tbl a,rws_work_admn_tbl b,RWS_NOTGROUNDWORKS_STATUS_TBL c where c.work_id=a.work_id and b.work_id=c.work_id and  a.work_id=b.work_id and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"'))   ";
	  
		  dpr331+="  group by  substr(b.office_code,2,2) order by 2";
	 Statement stmt333=conn.createStatement();
	//System.out.println("dpr33******KKKKKK"+dpr331);
		 ResultSet rs233=stmt333.executeQuery(dpr331);
		Hashtable dpr333=new Hashtable();
		while(rs233.next())
		{
			dpr333.put(rs233.getString(2),rs233.getString(1));
			
		}
	
	 
	 
	  ///Sanction Amount
	  String dprlan1="select sum(b.SANCTION_AMOUNT),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) ";
	  
		  dprlan1+="  group by  substr(b.office_code,2,2) order by 2";
	 stmt33=conn.createStatement();
	//System.out.println("dprlan1******KKKKKK"+dprlan1);
		 rs23=stmt33.executeQuery(dprlan1);
		Hashtable dprlanper1=new Hashtable();
		while(rs23.next())
		{
			dprlanper1.put(rs23.getString(2),rs23.getString(1));
			
		}
	  //
	  ///Voucher Amount
	  String dprlan11="select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+cYear+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,RWS_NOTGROUNDWORKS_STATUS_TBL c,rws_work_bill_tbl wb  where bill_type='A' and wb.BILL_SL_NO =exp.BILL_SL_NO and  wb.work_id=c.work_id and wb.work_id=W.work_id and substr(wb.work_id,5,2)=d.dcode and  c.work_id=exp.work_id and substr(c.work_id,5,2)=d.dcode and c.work_id=w.work_id and  to_date(w.ADMIN_DATE) < '01-Apr-"+cYear+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) and WORK_CANCEL_DT  is null group by d.dcode";

	 stmt44=conn.createStatement();
	//System.out.println("dprlan11******KKKKKK"+dprlan11);
		 rs44=stmt44.executeQuery(dprlan11);
		Hashtable dprlanper11=new Hashtable();
		while(rs44.next())
		{
			dprlanper11.put(rs44.getString(1),rs44.getString(2));
			
		}
	  //
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  //Printing Report....
	  
	  
	  String distQuery="select d.dcode,d.dname  from rws_district_tbl d  where d.dcode<>'16'";
	  if(dcode!=null && !dcode.equals("")){
		  distQuery+=" and d.dcode='"+dcode+"'";
		}
	  distQuery+=" order by d.dcode";
	  
	  rs3=stmt3.executeQuery(distQuery);
	  double svsH=0,svsT=0;
	  
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  String style="";
	  double d1=0,d2=0,d3=0;
	  int styleCount=0;
	  double gexpper = 0;
		double ghabper = 0;
		double s1=0,s2=0;
		
		double  svsHg=0.0,svsTg=0.0;
		Statement sst1=conn.createStatement();
		  Statement sst=conn.createStatement();
		  int svstot=0,gtot=0;

		  
	  double i1=0,i2=0,i3=0;
	  double i4=0,i5=0;
	  double san=0;
	  double gsantot=0;
	  double gtarget=0;
	  double gach=0;
	  double gper=0;
	  double gw=0;
	  int w2=0;
	  int w3=0;
	  int gpending=0;
	  ////Main while *KKKKKKKKKKKHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGGGGGGGGGGG************************************************************************************************///////
	  //////***********************************************************************************/////////////////////////////
	  while(rs3.next()){
		  
		  
		  //Total No of Works
		  
		 //
		 String w1=(String)dprSVS.get(rs3.getString(1));
		  if(w1!=null && !w1.equals(""))
		  {
			  
		  }
		  else
		  {
			  w1="0";
		  }
		  w2=Integer.parseInt(w1);
		 
		 String pending=(String)dprSVScom.get(rs3.getString(1));
		 if(pending!=null && !pending.equals(""))
		 {
			 
		 }
		 else
		 {
			 pending="0";
		 }
		 
		 
		 //System.out.println("pending"+pending);
		 //Total Sanction amount
		 String amount=(String)dprlanper1.get(rs3.getString(1));
		// System.out.println("amount"+amount);
		 if(amount==null || amount.equals("null")){
			 sanamount=0;
			 
		 }
		 else
		 {
			 sanamount=Double.parseDouble(amount);
		 }
		 //
		 
		 //morethan one program
		 String morethan="";
		 if(dpr333.get(rs3.getString(1))!=null && !dpr333.get(rs3.getString(1)).equals("null")){
		  morethan=(String)dpr333.get(rs3.getString(1));
		  //System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 morethan="0";
		 }
		 san=Double.parseDouble(morethan);
		 sanamount=san+sanamount;
		 //System.out.println("sanamountKKKKKKKKKKKKKKKKKKK"+san);
		// System.out.println("sanamount"+sanamount);
		 //Voucher
		 String vamount1=(String)dprlanper11.get(rs3.getString(1));
		 //System.out.println("amountHHHHH"+vamount1);
		 if(vamount1==null || vamount1.equals("null")){
			 s1=0;
			 
		 }
		 else
		 {
			 s1=Double.parseDouble(vamount1);
		 }
		 s2=sanamount-s1;
		// System.out.println(""+s1);
		 //System.out.println(""+s2);
		 
		 
		 
		 
		 //for grandtotals
		 svstot=Integer.parseInt(w1);
		 gtot=svstot+gtot;
		 //
		 i1=Double.parseDouble(w1);
		 i2=Double.parseDouble(pending);
		 if(i1>0)
		 {	 
		 i3=(i2/i1)*100;
		 i4=(5*i3)/100;
		 }
		 else
		 {
			 i3=0;
			 i4=0;
		 }
		 
		 
		 gsantot=s2+gsantot;
		 gach=i2+gach;
		 gper=(gach/gtot)*100;
		 gw=(5*gper)/100;
		 
		 
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		  %>
		  
		  <tr><td  style="text-align: left;" ><%=count++ %></td>
		  <td style="text-align: left;"><%=rs3.getString(2) %></td>
		  <td style="text-align: right;"><%=w2 %></td>
		  
		  <td style="text-align: right;" ><%=ndf.format(s2) %></td>
		  <td  style="text-align: right;"><%=w2 %></td>
		  <td style="text-align: right;"><%=pending %></td>
		  <td style="text-align: right;"><%=ndf.format(i3)%></td>
		  <td style="text-align: right;"><%=ndf.format(i4)%></td>
		  </tr>
		
		  <% 
		  
		  
		  
		  
		   
	  }
	  		gexpper = (expTot * 100/ expT);
		 ghabper = ( svsH * 100/ svsT);
			
	  
	  %>
	  <tr><td  style="text-align: right;"   colspan="2">Total </td>
	  <td  style="text-align: right;"   ><%=gtot %> </td>
	  <td  style="text-align: right;"  ><%=ndf.format(gsantot) %> </td>
	  <td  style="text-align: right;"  ><%=gtot %> </td>
	   <td  style="text-align: right;"  ><%=(int)gach %> </td>
	   <td  style="text-align: right;"  ><%=ndf.format(gper) %> </td>
	   <td  style="text-align: right;"  ><%=ndf.format(gw) %> </td>
	  </tr>
	  
	  <% 
	  
	  
	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 
 

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
