<%@ include file="/commons/rws_header1.jsp"%>


<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 


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

	
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "inline; filename="
			+ "ContyractorWise.xls");

	
nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	
    double aas=0;

String pname=(String)session.getAttribute("pname");

String scheme=(String)session.getAttribute("scheme");
    String programe=(String)session.getAttribute("programe");

String dcode=(String)session.getAttribute("dcode");
	String divCode=(String)session.getAttribute("divCode");
	%>
<head>

<script language="JavaScript"
	src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,right=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

</hea>
<html>
<body>

	<table border=0 cellspacing=0 cellpadding=0 width="80%"
		style="border-collapse: collapse">
		
		<tr >
		<td align="center" colspan="11" >
			<b>Amount in Rs. lakhs</b>
			</td>
		</tr>
		<tr>
			<td class="bwborder" align="center"><font color="red"><b></b></font></td>
		</tr>
	</table>
	<table border=1 cellspacing=0 cellpadding=0 width="76%"
						bordercolor=#000000 style="border-collapse: collapse"
						bgcolor="#ffffff" align="center">
						<tr>
							<td align="center" class="gridhdbg" colspan=11>Contractor Wise Online Payments Details
							</td>
						</tr>
	
	
	
	
		<%
			Statement stmt1 = null, stmt2 = null, stmt3 = null,stmt4=null;
			ResultSet rs1 = null, rs2 = null, rs3 = null,rs4=null;
			int count=1;
			
			int styleCount=0;
			String style="";
		    
	      try {

				stmt1 = conn.createStatement();
				stmt2=conn.createStatement();
				stmt3=conn.createStatement();
				stmt4=conn.createStatement();
               %>
		
 <tr>   <td class="gridhdbg" style="text-align: left;" rowspan="2">Slno</td>
			<td class="gridhdbg" style="text-align: left;" rowspan="2">Circle</td>
			<td class="gridhdbg" style="text-align: left;" rowspan="2">Contractor Code</td>
			<td class="gridhdbg" style="text-align: left;" rowspan="2">Contractor Name</td>
			<td class="gridhdbg" style="text-align: left;" rowspan="2">PAN NO/VOTER ID </td>
            <td class="gridhdbg" style="text-align: center;" colspan="3">Total No.of Works</td>
            <td class="gridhdbg" style="text-align: center;" colspan="4">Payment Details Year Wise</td>
            
		</tr>
		<tr>
		     <td class="gridhdbg" style="text-align: center;" >Total Works</td>
		    <td class="gridhdbg" style="text-align: center;" >No.of Works<br>(on going)</td>
            <td class="gridhdbg" style="text-align: center;" >No.of Works<br>(Completed)</td>          
			<td class="gridhdbg" style="text-align: center;">2011</td>
			<td class="gridhdbg" style="text-align: center;">2012</td>
            <td class="gridhdbg" style="text-align: center;">2013</td>
            <td class="gridhdbg" style="text-align: center;">2014</td>
              
		</tr>

<%
// *******Ongoing works query
String ongoingworksQry="";

if(!loggedUser.equals(Constants.SEC_USER))
{
if(dcode!=null && !dcode.equals("00") && !loggedUser.equals(Constants.GUEST))
{
  
	ongoingworksQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and substr(c.work_id,5,2)='"+dcode+"' and work_cancel_dt is null  and c.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
  
 }
else
{
	ongoingworksQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and work_cancel_dt is null  and c.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
}
}
else
{
	ongoingworksQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and work_cancel_dt is null  and c.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
}
rs2 = stmt2.executeQuery(ongoingworksQry);
 //System.out.println("ongoingworksQry ............" + ongoingworksQry);

Hashtable ongoingwrks_hash=new Hashtable();
	while(rs2.next())
	{
		ongoingwrks_hash.put(rs2.getInt(1)+rs2.getInt(2),rs2.getInt(3));
	}
if (rs2 != null){
	rs2.close();
}
if (stmt2 != null){
	stmt2.close(); 
}
	
//******* works Completed query
String workscomptdQry="";

if(!loggedUser.equals(Constants.SEC_USER))
{
if(dcode!=null && !dcode.equals("00") && !loggedUser.equals(Constants.GUEST))
{
  
	workscomptdQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and substr(c.work_id,5,2)='"+dcode+"' and work_cancel_dt is null  and c.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
	
 }
else
{
   workscomptdQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and work_cancel_dt is null  and c.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
 
}
}
else
{
	workscomptdQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,count(distinct c.work_id) from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and work_cancel_dt is null  and c.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
}

rs3 = stmt3.executeQuery(workscomptdQry);
//System.out.println("workscomptdQry ............" + workscomptdQry);

Hashtable workscomptd_hash=new Hashtable();
	while(rs3.next())
	{
		workscomptd_hash.put(rs3.getInt(1)+rs3.getInt(2),rs3.getInt(3));
	}
if (rs3 != null){
	rs3.close();
}
if (stmt3 != null){
	stmt3.close(); 
}
///*******qyr for year wise details
String yearwiseQry="";

if(!loggedUser.equals(Constants.SEC_USER))
{
	if(dcode!=null && !dcode.equals("00") && !loggedUser.equals(Constants.GUEST))
	{
	  
		yearwiseQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2011') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2012') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2013') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2014') then BILL_AMOUNT_CENTRAL else 0 end)/100000  from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d,rws_bill_bank_bridge_det_tbl e where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and a.work_id=e.work_id and c.work_id=e.work_id and substr(c.work_id,5,2)=d.dcode and substr(c.work_id,5,2)='"+dcode+"' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
	  
	 }
	else
	{
		yearwiseQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE ,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2011') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2012') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2013') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2014') then BILL_AMOUNT_CENTRAL else 0 end)/100000  from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d,rws_bill_bank_bridge_det_tbl e where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and a.work_id=e.work_id and c.work_id=e.work_id and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
	}
	}
	else
	{
		yearwiseQry="select distinct substr(c.work_id,5,2),a.CONTRACTOR_CODE,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2011') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2012') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2013') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_char(BANK_SEND_DATE,'yyyy')='2014') then BILL_AMOUNT_CENTRAL else 0 end)/100000  from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d,rws_bill_bank_bridge_det_tbl e where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and a.work_id=e.work_id and c.work_id=e.work_id and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY  order by 1,2";
	}

rs4 = stmt4.executeQuery(yearwiseQry);
//System.out.println("workscomptdQry ............" + workscomptdQry);

Hashtable yearwise_hash=new Hashtable();
	while(rs4.next())
	{
		yearwise_hash.put(rs4.getInt(1)+rs4.getInt(2),rs4.getDouble(3)+"@"+rs4.getDouble(4)+"@"+rs4.getDouble(5)+"@"+rs4.getDouble(6));
	}
if (rs4!= null){
	rs4.close();
}
if (stmt4 != null){
	stmt4.close(); 
}



///////////////////////////////////////////////////////////////////
String query="";String dname="";
if(!loggedUser.equals(Constants.SEC_USER))
{
if(dcode!=null && !dcode.equals("00") && !loggedUser.equals(Constants.GUEST))
{
  
  query="select distinct substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE ,CONTRACTOR_NAME_COMPANY,count(distinct c.work_id),nvl(PAN_NO,'-'),nvl(VOTER_ID,'-') from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and substr(c.work_id,5,2)='"+dcode+"' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY,nvl(PAN_NO,'-'),nvl(VOTER_ID,'-')  order by 1,2";
  
 }
else
{
	query="select distinct substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE ,CONTRACTOR_NAME_COMPANY,count(distinct c.work_id),nvl(PAN_NO,'-'),nvl(VOTER_ID,'-') from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY,nvl(PAN_NO,'-'),nvl(VOTER_ID,'-')  order by 1,2";
}
}
else
{
	query="select distinct substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE ,CONTRACTOR_NAME_COMPANY,count(distinct c.work_id),nvl(PAN_NO,'-'),nvl(VOTER_ID,'-') from RWS_CONTRACTOR_SELECTION_TBL a ,RWS_CONTRACTOR_TBL b ,rws_work_admn_tbl c,rws_district_tbl d  where a.work_id=c.work_id and a.CONTRACTOR_CODE  is not null and a.CONTRACTOR_CODE =b.CONTRACTOR_CODE and substr(c.work_id,5,2)=d.dcode and d.dcode<>'16' and c.type_of_asset in(03) and  c.programme_code in (01,02,18,23,32,48,49,51,58) group by substr(c.work_id,5,2),d.dname,a.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY,nvl(PAN_NO,'-'),nvl(VOTER_ID,'-')  order by 1,2";
}
//System.out.println("main query"+query);
rs1=stmt1.executeQuery(query);

String cont_name="",cont_id="";
int work_cnt=0;
int work_tot=0;
int ongngworks=0,ongngworkstot=0,workscomptd=0,workscomptdtot=0;
double yr11=0.0,yr12=0.0,yr13=0.0,yr14=0.0;
double yr11tot=0,yr12tot=0,yr13tot=0,yr14tot=0;
styleCount=0;
while(rs1.next())
{
	
	
	
	if(ongoingwrks_hash.get(rs1.getInt(1)+rs1.getInt(3))!=null){
		ongngworks=(Integer)ongoingwrks_hash.get(rs1.getInt(1)+rs1.getInt(3));
	}
	if(workscomptd_hash.get(rs1.getInt(1)+rs1.getInt(3))!=null){
		workscomptd=(Integer)workscomptd_hash.get(rs1.getInt(1)+rs1.getInt(3));
	}
	if(yearwise_hash.get(rs1.getInt(1)+rs1.getInt(3))!=null){
		String amount=(String) yearwise_hash.get(rs1.getInt(1)+rs1.getInt(3));
		String amountval[]=amount.split("@");
		yr11=Double.parseDouble(amountval[0]);
		yr12=Double.parseDouble(amountval[1]);
		yr13=Double.parseDouble(amountval[2]);
		yr14=Double.parseDouble(amountval[3]);
		

		if(styleCount%2==0){
			 style="gridbg1";
		}else{
			 style="gridbg2";
		}
		styleCount++;

		
	
}
	
	
	

%>


<tr>       


<% 

if(!dname.equals(rs1.getString(2)))
{
dname=rs1.getString(2);
%>
<td class=<%=style %> style="text-align: right;"><%=count++ %></td>
<td class=<%=style %> style="text-align: left;"><%=dname %></td>
<% }
else{
%>
<td class=<%=style %> style="text-align: left;"></td>
<td class=<%=style %> style="text-align: left;"></td>
<%} %>

			<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3) %></td>
            <td class=<%=style %> style="text-align: left;"><%=rs1.getString(4) %></td>
            <td class=<%=style %> style="text-align: right;"><%=rs1.getString(6) %> / <%=rs1.getString(7) %> </td>
            <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(5) %></td>   
                       
         	<td class=<%=style %> style="text-align: right;"><%=ongngworks%></td>
			<td class=<%=style %> style="text-align: right;"><%=workscomptd%></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(yr11) %></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(yr12) %></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(yr13) %></td>
            <td class=<%=style %> style="text-align: right;"><%=ndf.format(yr14) %></td>
   

 

		<%
		work_tot+=rs1.getInt(5);
		ongngworkstot+=ongngworks;
		workscomptdtot+=workscomptd;
		
		yr11tot+=yr11;
		yr12tot+=yr12;
		yr13tot+=yr13;
		yr14tot+=yr14;
}
	      


%>

 <tr>

			
			<td class="gridhdbg" style="text-align: right;" colspan=5>Total</td>
			<td class="gridhdbg" style="text-align: right;"><%=work_tot %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ongngworkstot %></td>
			<td class="gridhdbg" style="text-align: right;"><%=workscomptdtot %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(yr11tot) %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(yr12tot) %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(yr13tot) %></td>
			<td class="gridhdbg" style="text-align: right;"><%=ndf.format(yr14tot) %></td>
			
		</tr>
<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

	</table>
</body>
</html>