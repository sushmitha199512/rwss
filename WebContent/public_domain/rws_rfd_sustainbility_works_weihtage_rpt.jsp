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
                    <a href="rws_rfd_sustainbility_works_weihtage_excel.jsp" target="_new">Excel</a></td></tr>       

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="gridhdbg" colspan=13><font color="white"><b>Sustainability Structures</b></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
      <td class="gridhdbg"  align=center colspan=2 nowrap >Works</td>
        <td class="gridhdbg"  align=center colspan=4 nowrap ></td>

</tr>
<tr>
<td class="gridhdbg"  align="center"  >Total Works</td>
 <td class="gridhdbg"  align="center"  >Estimate Cost</td>
 <td class="gridhdbg"  align="center"  >Target</td>
 <td class="gridhdbg"  align="center"  >Achievement</td>
 <td class="gridhdbg"  align="center"  >% of Achievement</td>
 <td class="gridhdbg"  align=center >Weightage-5</td>
</tr>

<tr><td class="gridhdbg"   align=center>1</td>
<td class="gridhdbg"   align=center>2</td>
<td class="gridhdbg"   align=center>3</td>
<td class="gridhdbg"   align=center>4</td>
<td class="gridhdbg"   align=center>5</td>
<td class="gridhdbg"   align=center>6</td>
<td class="gridhdbg"   align=center>7</td>
<td class="gridhdbg"   align=center>8</td>

	</tr>

<%
Statement stmt1=null;
ResultSet rs1=null;
int count=1;
try
{

stmt1=conn.createStatement();

String query="",dname="";
String style="";
int styleCount=0;
//query for Spill over total works 

String spilloverwrkq="select  d.dcode,count(*) ,sum(sanction_amount)  from rws_work_admn_tbl w,rws_district_tbl d where  to_date(w.ADMIN_DATE) < '01-Apr-"+cYear+"' and type_of_asset='10' and  d.dcode=substr(work_id,5,2) and work_cancel_dt is null and work_id not in (select work_id from rws_work_completion_tbl  where to_date(date_of_completion,'dd/mm/yy') <'01-APR-"+cYear+"')   group by substr(work_id,5,2),d.dcode order by d.dcode";
Statement stmt2=conn.createStatement();
//System.out.println("spilloverwrkqry:"+spilloverwrkq);
ResultSet rs2=stmt2.executeQuery(spilloverwrkq);
Hashtable spilloverwrkList=new Hashtable();
while(rs2.next())
{
	spilloverwrkList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
}
if(rs2!=null)rs2.close();
if(stmt2!=null)stmt2.close();

//query for new works
String newworksq="select  d.dcode,count(*) ,sum(sanction_amount)  from rws_work_admn_tbl w,rws_district_tbl d where  to_date(w.ADMIN_DATE) >= '01-Apr-"+cYear+"' and type_of_asset='10' and  d.dcode=substr(work_id,5,2) and work_cancel_dt is null   group by substr(work_id,5,2),d.dcode order by d.dcode";
Statement stmt3=conn.createStatement();
//System.out.println("newworksqry:"+newworksq);
ResultSet rs3=stmt3.executeQuery(newworksq);
Hashtable newworksList=new Hashtable();
while(rs3.next())
{
	newworksList.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3));
}
if(rs3!=null)rs3.close();
if(stmt3!=null)stmt3.close();

/*String estcostqry="select  d.dcode,sum(sanction_amount)  from rws_work_admn_tbl,rws_district_tbl d where substr(work_id,7,2)='10' and  d.dcode=substr(work_id,5,2) and work_cancel_dt is null and work_id not in (select work_id from rws_work_completion_tbl )  group by substr(work_id,5,2),d.dcode order by d.dcode";
Statement stmt3=conn.createStatement();
//System.out.println("estcostqry:"+estcostqry);
ResultSet rs3=stmt3.executeQuery(estcostqry);
Hashtable estcostList=new Hashtable();
while(rs3.next())
{
	estcostList.put(rs3.getString(1),rs3.getString(2));
}
if(rs3!=null)rs3.close();
if(stmt3!=null)stmt3.close();
*/
String expqry="select substr(e.work_id,5,2),sum(case when (to_date(voucher_dt)< '01-Apr-"+cYear+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl e where   w.work_id=e.work_id  and w.type_of_asset='10' and WORK_CANCEL_DT  is null and e.work_id not in (select work_id from rws_work_completion_tbl where to_date(date_of_completion,'dd/mm/yy') <'01-APR-"+cYear+"' ) group by substr(e.work_id,5,2)";
Statement stmt4=conn.createStatement();
//System.out.println("expqry:"+expqry);
ResultSet rs4=stmt4.executeQuery(expqry);
Hashtable expList=new Hashtable();
while(rs4.next())
{
	expList.put(rs4.getString(1),rs4.getString(2));
}
if(rs4!=null)rs4.close();
if(stmt4!=null)stmt4.close();


String achqry="select  substr(work_id,5,2),count(*) ,sum(sanction_amount)  from rws_work_admn_tbl  w  where work_id  in (select work_id from rws_work_completion_tbl  where to_date(date_of_completion,'dd/mm/yy') >='01-APR-"+cYear+"') and w.type_of_asset='10' and   w.work_cancel_dt is null   group by substr(w.work_id,5,2) order by  substr(w.work_id,5,2)";
Statement stmt5=conn.createStatement();
//System.out.println("achqry:"+achqry);
ResultSet rs5=stmt5.executeQuery(achqry);
Hashtable achList=new Hashtable();
while(rs5.next())
{
	achList.put(rs5.getString(1),rs5.getString(2));
}
if(rs5!=null)rs5.close();
if(stmt5!=null)stmt5.close();


int achno=0,tot1=0,tot4=0,gtotWorks=0,gtotalBalEst=0;
double expcnt=0,tot2=0,tot3=0,per1=0,wt=0;
query="select  distinct  d.dcode,dname from  rws_district_tbl d,rws_work_admn_tbl w where d.dcode=substr(w.work_id,5,2)  ";
if(dcode!=null && !dcode.equals("")){
	query+=" and d.dcode='"+dcode+"'";
	}
query+=" order by d.dcode";
rs1=stmt1.executeQuery(query);
while(rs1.next())
{    
	  int sWorkCount=0,newWorkCount=0;
	  double spillSanctionedAmt=0,newSanctionedAmt=0;
	 
	 
        String key=rs1.getString(1);
		if(spilloverwrkList.get(key)!=null ){
	
			String spillWorks=(String)spilloverwrkList.get(key);
			String []aa=spillWorks.split("@");
			String a1=aa[0];
			if(a1!=null){
				sWorkCount=Integer.parseInt(a1);
			}
			String a2=aa[1];
			if(a2!=null){
				spillSanctionedAmt=Double.parseDouble(a2);
			}

		}
		if(newworksList.get(key)!=null ){
			String newworks=(String)newworksList.get(key);
			String []aa=newworks.split("@");
			String a1=aa[0];
			if(a1!=null){
				newWorkCount=Integer.parseInt(a1);
			}
			String a2=aa[1];
			if(a2!=null){
				newSanctionedAmt=Double.parseDouble(a2);
			}

		}  
	
	 String exp=(String)expList.get(rs1.getString(1));
	   if(exp==null || exp.equals("null"))
	   {
		   exp="0";
	   }
		   expcnt=Double.parseDouble(exp);
		//   System.out.println("expcnt"+expcnt);
		   tot3=expcnt+tot3;
		//   System.out.println("tot3"+tot3);
		   
      double totalBalEst=(spillSanctionedAmt+newSanctionedAmt)-expcnt;
		
		gtotalBalEst+=totalBalEst;
		int totWorks=sWorkCount+newWorkCount;
		gtotWorks+=totWorks;
	  
      
      String achwrks=(String)achList.get(rs1.getString(1));
  	 //System.out.println("ach"+achwrks);
  	
 	 if(achwrks==null ||  achwrks.equals("null"))
 	   {
 		 achwrks="0";
 		 
 	   }
 	 
 	 achno=Integer.parseInt(achwrks);
 	 tot4=achno+tot4;
 	// System.out.println("tot4"+tot4);
 	 if(achno!=0 && totWorks!=0 && totWorks>=achno)
 	 {
 		 
 		 per1=(100*(double)achno)/(double)totWorks;
 	 }
 	 else
 	 {
 		  per1=0;
 	 }
 	wt=(5*per1)/100;
		 
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
%>    
     <tr>
	 <td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
	 <td class="<%=style %>"  style="text-align: left;"><%=rs1.getString(2) %></td>
	 <td class="<%=style %>"  style="text-align: right;"><%=totWorks %></td>
	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(totalBalEst) %></td>
	  <td class="<%=style %>"  style="text-align: right;"><%=totWorks%></td>
	  <td class="<%=style %>"  style="text-align: right;"><%=achno%></td>
	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(per1) %></td>
	  <td class="<%=style %>"  style="text-align: right;"><%=ndf.format(wt) %></td>
	 </tr>
	  
<% 
    }   
 %>
 <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	  <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gtotWorks) %></td>
	  <td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gtotalBalEst) %></td>
	  <td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gtotWorks) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(tot4) %></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(((double)tot4*100)/(double)gtotWorks)%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(((((double)tot4*100)/(double)gtotWorks)*5)/100)%></td>
	  </tr>
	 
<%

}
catch(Exception e)
{
  e.printStackTrace();
} 
 
%>
</table>
                                        <!-- Grid Table Ends -->


				    <!-- Please Click Here to View Graph<a href="<rws:context page='/public_domain/rws_rfd_svs_target_ach_graph.jsp' />" target="_new"><img src="<rws:context page='/images/chart.png' />"  width="40" height="40"/></a></td> -->
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
