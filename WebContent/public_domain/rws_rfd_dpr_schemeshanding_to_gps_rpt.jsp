<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
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
int pYear=nYear-1;
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();

//System.out.println("DDED");

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

<tr><td align="right" class="bwborder" colspan="2"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;
                    <a href="rws_rfd_dpr_schemeshanding_to_gps_excel.jsp" target="_new">Excel</a></td></tr>    

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD">
		<td align="center" class="gridhdbg" colspan=13><font color="white"><b>Schemes Handing over to GP 's</b></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
<td class="gridhdbg"  align=center colspan=5 nowrap >Works <br></br><font color="red"><b></b></font></td>
<td class="gridhdbg"  align=center rowspan=2 nowrap >Percentage</td>
<td class="gridhdbg"  align=center rowspan=2 nowrap >Weightage</td>



 
</tr>
<tr>
<td class="gridhdbg"  align="center"  >No</td>
 <td  class="gridhdbg" align="center"  >Est.Cost</td>
 	<td  class="gridhdbg" align="center"  >No. Of Schemes Completed<br>(Target)</br></td>
 	<td  class="gridhdbg" align="center"  >No. Of Schemes Commissioned<br>(Achievement)</br></td>
 	<td  class="gridhdbg" align="center"  >No. Of Schemes Handed over to GramPanchayat's</td>
 	
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

	</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt33=null,stmt44=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs23=null,rs44=null;
String programmeNames="";
int count=1;
double sanamount=0;
  try{
	  //Morethan one program
	   	   String dpr331="select sum(a.SANCTION_AMOUNT ),substr(b.office_code,2,2) from rws_work_admn_prog_lnk_tbl a,rws_work_admn_tbl b where  b.work_id=a.work_id and  b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"'))   ";
	  
		  dpr331+="  group by  substr(b.office_code,2,2) order by 2";
	 Statement stmt333=conn.createStatement();
	//System.out.println("dpr33******KKKKKK"+dpr331);
		 ResultSet rs233=stmt333.executeQuery(dpr331);
		Hashtable dpr333=new Hashtable();
		while(rs233.next())
		{
			dpr333.put(rs233.getString(2),rs233.getString(1));
			
		}
	
	  //Morethan
	 //Handed over to GPs
	 
	 String sample22="select  count(*),substr(b.office_code,2,2) from rws_work_completion_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and date_of_completion is not null and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and HANDOVER_PRI ='Y' and (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+cYear+"')) and work_cancel_dt is null   group by substr(office_code,2,2)";
	Statement stmt51=conn.createStatement();
	//System.out.println("sourcesample22:"+sample22);
	ResultSet rs51=stmt51.executeQuery(sample22);
	Hashtable sourcehhh=new Hashtable();
		while(rs51.next())
	{
		sourcehhh.put(rs51.getString(2),rs51.getString(1));
	}
	 //
	//Work  Completion
	String sample="select count(*),substr(b.office_code,2,2) from rws_work_completion_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and date_of_completion is not null and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+cYear+"')) and work_cancel_dt is null   group by substr(office_code,2,2)";
	Statement stmt55=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs55=stmt55.executeQuery(sample);
	Hashtable sourceh=new Hashtable();
		while(rs55.next())
	{
		sourceh.put(rs55.getString(2),rs55.getString(1));
	}
	//for Commissioning works
	String sample1="select count(*),substr(b.office_code,2,2) from rws_work_completion_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and date_of_comm is not null and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+cYear+"')) and work_cancel_dt is null group by substr(office_code,2,2) ";
	Statement stmt52=conn.createStatement();
	//System.out.println("sourcesampleJJJJJJJJ:"+sample1);
	ResultSet rs52=stmt52.executeQuery(sample1);
	Hashtable sourcehh=new Hashtable();
		while(rs52.next())
	{
		sourcehh.put(rs52.getString(2),rs52.getString(1));
	}
	//  
	  
	  //spill query
	  String dprlan="select count(*),substr(office_code,2,2) from RWS_work_admn_tbl where  (to_date(admin_date) < '01-Apr-"+cYear+"') and work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) and work_cancel_dt is null  "; 
	 
	  
		  dprlan+="  group by  substr(office_code,2,2) order by 2";
	stmt3=conn.createStatement();
//	System.out.println("dprlan****111**"+dprlan);
		 rs2=stmt3.executeQuery(dprlan);
		Hashtable dprlanper=new Hashtable();
		while(rs2.next())
		{
			dprlanper.put(rs2.getString(2),rs2.getString(1));
		}

	  //
	  
	  //New Query
	  String dd="select count(*),substr(office_code,2,2) from RWS_work_admn_tbl where  (to_date(admin_date) >= '01-Apr-"+cYear+"') and  work_cancel_dt is null    group by  substr(office_code,2,2) order by 2"; 
	 
	  
		 
	Statement stmt99=conn.createStatement();
	//System.out.println("dprlan****111**"+dd);
		ResultSet rs99=stmt99.executeQuery(dd);
		Hashtable dpr99=new Hashtable();
		while(rs99.next())
		{
			dpr99.put(rs99.getString(2),rs99.getString(1));
		}

	  //
	  ///Sanction Amount
	  String dprlan1="select sum(a.SANCTION_AMOUNT),substr(a.office_code,2,2) from rws_work_admn_tbl a where  a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) and work_cancel_dt is null ";
	  
		  dprlan1+="  group by  substr(a.office_code,2,2) order by 2";
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
	  String dprlan11="select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+cYear+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp  where   to_date(w.ADMIN_DATE) < '01-Apr-"+cYear+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) and WORK_CANCEL_DT  is null group by d.dcode";

	 stmt44=conn.createStatement();
	//System.out.println("dprlan11******KKKKKK"+dprlan11);
		 rs44=stmt44.executeQuery(dprlan11);
		Hashtable dprlanper11=new Hashtable();
		while(rs44.next())
		{
			dprlanper11.put(rs44.getString(1),rs44.getString(2));
			
		}
	  //
	 
	  /*stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  String selectedProgramsFin="'01','02','18','23','32','48','49','51','58','59','60','04','57','65','46','12','50'";
	  String selectedProgramsPhy="'01','02','18','23','32','48','49','51','58','04','57','65','46','12'";*/
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  //Printing Report....
	  
	  
	  String distQuery="select d.dcode,d.dname  from rws_district_tbl d where dcode <> '16' ";
	  if(dcode!=null && !dcode.equals("")){
		  distQuery+=" and dcode='"+dcode+"'";
		}
	  distQuery+=" order by dcode";
	  
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

		  
	  
	  double g1tot=0;
	  double san1=0;
	  double gsan1=0;
	  double v1=0;
	  double v2=0;
	  double c1=0;
	  double c2=0;
	  double gv2=0,gnoc=0,gnoc1=0,ghanding=0;
	  int n1=0;
	  int tn=0,gtn=0;
	  double santot=0,more=0;
	  double i1=0;
	  double i2=0;
	  double i3=0;
	  double gach=0;
	  double gper=0;
	  double gw=0;
	  ////Main while *KKKKKKKKKKKHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHGGGGGGGGGGGGGGG************************************************************************************************///////
	  //////***********************************************************************************/////////////////////////////
	  while(rs3.next()){
		  
		  
		  //Total No of Works Spill + New
		  
		 String svsTargetHabs=(String)dprlanper.get(rs3.getString(1));
		 if(svsTargetHabs==null || svsTargetHabs.equals("null")){
			 svsTargetHabs="0";
		 }
		 svstot=Integer.parseInt(svsTargetHabs);
		 gtot=svstot+gtot;
		 String new1=(String)dpr99.get(rs3.getString(1));
		 if(new1 !=null && !new1.equals(""))
		 {
			 
		 }
		 else
		 {
			 new1="0";
		 }
		 n1=Integer.parseInt(new1);
		 tn=n1+svstot;
		 //System.out.println("new"+n1);
		 //System.out.println("spill"+svstot);
		 //System.out.println("total"+tn);
		 
		  //Sanction Amount
		  String sanam="";
		  sanam=(String)dprlanper1.get(rs3.getString(1));
		  if(sanam != null  && !sanam.equals(""))
		  {
			  
		  }
		  else
		  {
			  
		  }
		  san1=Double.parseDouble(sanam);
		  //System.out.println("san1JJJJJJ"+san1);
		  	  
		  //Sanction Amount
		  
		 //Sanction Amount morethan one program
		  String mz=(String)dpr333.get(rs3.getString(1));
		  if(mz!=null && !mz.equals(""))
		  {
			  
		  }
		  else
		  {
			  mz="0";
		  }
		  more=Double.parseDouble(mz);
		  
		  //
		//Voucher Amount
	String voucher=(String)dprlanper11.get(rs3.getString(1));
	if(voucher !=null && !voucher.equals("") && !voucher.equals("null"))
	{
		
	}
	else
	{
		voucher="0";
	}
	v1=Double.parseDouble(voucher);
	//System.out.println("v1"+v1);
	
	//Voucher Amount
	//Est Cost
	santot=san1+more;
	//System.out.println("san1kkkkkk*******************"+san1);
	//System.out.println("santot*******************"+santot);
	v2=santot-v1;
	//System.out.println("v2JJJJJ"+v2);//Est Cost
	//For No of Completion
	String noc=(String)sourceh.get(rs3.getString(1));
	if(noc !=null && !noc.equals(""))
	{
		
	}
	else
	{
		noc="0";
	}
	//For No of Commissioned
	String noc1=(String)sourcehh.get(rs3.getString(1));
	if(noc1 !=null && !noc1.equals(""))
	{
		
	}
	else
	{
		noc1="0";
	}
	//Handing over to GPs
	String handing=(String)sourcehhh.get(rs3.getString(1));
	if(handing !=null && !handing.equals("") && !handing.equals("null"))
	{
		
	}
	else
	{
		handing="0";
	}
	//
	//Conevertion
	c1=Double.parseDouble(noc);
	c2=Double.parseDouble(noc1);
	//noc1 is Commissioned and noc is completed->c1 is completed(Target) and c2  is commisioned(Achievement)
	i1=(c2/c1)*100;
	i2=(5*i1)/100;
	//
	 gach=c2+gach;
	 g1tot=c1+g1tot;
	 
		 gper=(gach/g1tot)*100;
		 gw=(5*gper)/100;
	//
	
		 
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		  %>
		  
		  <tr><td class="<%=style %>" style="text-align: left;" ><%=count++ %></td>
		  <td class="<%=style %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
		  <td class="<%=style %>" style="text-align: center;"><%=tn %></td>
		  <td class="<%=style %>" style="text-align: center;"><%=ndf.format(v2)%></td>
		   <td class="<%=style %>" style="text-align: center;"><%=noc %></td>
		    <td class="<%=style %>" style="text-align: center;"><%=noc1 %></td>
		    <td class="<%=style %>" style="text-align: center;"><%=handing %></td>
		     <td class="<%=style %>" style="text-align: center;"><%=ndf.format(i1) %></td>
		  <td class="<%=style %>" style="text-align: center;"><%=ndf.format(i2) %></td>
		  
		  </tr>
		
		  <% 
		  gtn+=tn;
		  gv2+=v2;
			 gnoc+=c1;
			 gnoc1+=c2;
			 ghanding+=Double.parseDouble(handing);
		  
		  
		  
		  
		   
	  }
	  		gexpper = (expTot * 100/ expT);
		 ghabper = ( svsH * 100/ svsT);
			
		 
		
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	  <td  style="text-align: center;"  class="gridhdbg" ><%=gtn %> </td>

 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(gv2)%> </td>
 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(gnoc)%> </td>
 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(gnoc1)%> </td>
 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(ghanding)%> </td>
 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(gper) %> </td>
 <td  style="text-align: center;"  class="gridhdbg" ><%=ndf.format(gw) %> </td>
	  </tr>
	  
	  <% 
	  
	 /* String programmeQuery="select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+selectedProgramsFin+") order by 2 ";
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(programmeQuery);
	  while(rs4.next()){
		  programmeNames+=rs4.getString(1);
		  
		  programmeNames+=",  ";
	  }*/
	  
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
