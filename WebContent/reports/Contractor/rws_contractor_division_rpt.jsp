<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp"%>
<script language="javascript">
function wopen(url, name, w, h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>

<form>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
<%@ include file="/commons/rws_header2.jsp" %>

<% } 


DecimalFormat ndf = new DecimalFormat("######.##");
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rr=null,rr1=null,rs7=null;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,st=null,sst1=null;
int tSOurces=0,otherCount=0;
int sno=1,bactCount=0,multiExcessPar=0;
int totalnitcount=0,totironCount=0,totfloridCount=0,tottdsCount=0,totnitrateCoount=0,totbactCount=0,totmultiExcessPar=0,totOtherCount=0;
String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
String division=request.getParameter("division");
String district =request.getParameter("district");

String category=request.getParameter("cat");
String dname=request.getParameter("dname");
session.setAttribute("dname",dname);
session.setAttribute("fromdate",fromdate);
session.setAttribute("todate",todate);
int tnofSources=0,totalTestedSources=0;
int totalnfound=0,cnt=0;
int totalhardcoount=0;
double testValue=0;
HashMap results=new HashMap();
%>


<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	<caption>
	<table border=0 rules=none style="border-collapse:collapse"
		align="right">

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|
		| </a></td><td class="bwborder"><a href="./rws_contractor_rpt_xls.jsp" target="_new">Excel
		 </a></td></tr>
<%  } else {%>

	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
			<td class="bwborder"><a href="#" onclick="window.close()">Close|
		| </a></td><td class="bwborder"><a href="./rws_contractor_rpt_xls.jsp" target="_new">Excel
		</a></td></tr>
	
<%} %>


		<tr align="right">
			<td class="bwborder"></td>
		</tr>
	</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Contractor Status Report</td>
	</tr>


</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext >Sl.No</td>
		<td class=btext >Contractor Code</td>
		<td class=btext >Contrator Name</td>
		<td class=btext >Pan/Votter ID</td>
		<td class=btext >No Of Works entrusted</td>
		<td class=btext width="50">Estimate Cost<br>(In lakhs)</td>
		<td class=btext >Agreement Value <br>(In Rupees)</td>
		<td class=btext >No. of Works Completed</td>
		<td class=btext >Amount Released(In Lakhs)<br>(Bank+Pao)</td>
		<td class=btext >No Of OnGoing Works</td>
		<td class=btext >Total Amount Pai<br>d(In lakhs)</td>
		<td class=btext >Balance Estimate cost<br>(In Lakhs)</td>
		
			


	</tr>

	<% 
try{

PreparedStatement pstm1=null,pstm2=null,pstm3=null;
 stmt1=conn.createStatement();
 stmt2=conn.createStatement();
 stmt3=conn.createStatement();
 stmt4=conn.createStatement();
 stmt5=conn.createStatement();
 stmt6=conn.createStatement();
 stmt7=conn.createStatement();
 sst1=conn.createStatement();
 st=conn.createStatement();
 
HashMap ongoingList=new HashMap();
HashMap completedList=new HashMap();
HashMap allWorksList=new HashMap();

HashMap records=new HashMap();
 double sancAmount=0,agreementValue=0,releaseAMount=0,paidAmount=0;


String allworks="";
String query="select distinct c.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY ,NVL(PAN_NO,'_'),NVL(VOTER_ID,'_') from rws_contractor_selection_tbl cs,rws_contractor_tbl c,rws_work_admn_tbl w where w.work_cancel_dt is null and w.work_id=cs.work_id and CS.CONTRACTOR_CODE=C.CONTRACTOR_CODE AND substr(w.office_code,2,2)='"+district+"' ";
		if(division != null && !division.equals(""))
		{
			query+="and substr(w.office_code,4,1)='"+division+"'" ;
		}
		if(category != null && !category.equals(""))
		{
			query+="and w.category_code='"+category+"'" ;
		}

 //System.out.println("Quewry"+query);
String ongoing="",completed="";
rs2=stmt2.executeQuery(query);
while(rs2.next()){
	int ongoingCount=0;
    int completedCount=0,allWorksCount=0;agreementValue=0;sancAmount=0;
releaseAMount=0;paidAmount=0;
            
ongoing="select distinct e.work_id from rws_district_tbl t,rws_contractor_selection_tbl a,rws_contractor_tbl c,rws_work_admn_tbl e where  c.contractor_code=a.contractor_code and a.contractor_code='"+rs2.getString(1)+"' and substr(e.work_id,5,2)='"+district+"' and a.work_id=e.work_id and e.work_id not in(select work_id from rws_work_completion_tbl where to_date(date_of_completion)<'01-APR-2012') ";
//System.out.println("Ongoing"+ongoing);
		rs3=stmt3.executeQuery(ongoing);
String work_id="";		
while(rs3.next()){
			work_id+=rs3.getString(1);
			work_id+="@";
				
		ongoingCount++;
			}
ongoingList.put(rs2.getString(1),work_id);
				
completed="select distinct e.work_id from rws_district_tbl t,rws_contractor_selection_tbl a,rws_contractor_tbl c,rws_work_admn_tbl e where  c.contractor_code=a.contractor_code and a.contractor_code='"+rs2.getString(1)+"' and substr(e.work_id,5,2)='"+district+"' and a.work_id=e.work_id and e.work_id in(select work_id from rws_work_completion_tbl where to_date(date_of_completion)<'01-APR-2012')";
//System.out.println("completed"+completed);
rs4=stmt4.executeQuery(completed);
String work_id1="";
		while(rs4.next()){
		work_id1+=rs4.getString(1);
			work_id1+="@";

			completedCount++;
			}
			completedList.put(rs2.getString(1),work_id1);

allworks="select distinct e.work_id,a.agreement_value,e.sanction_amount from rws_district_tbl t,rws_contractor_selection_tbl a,rws_contractor_tbl c,rws_work_admn_tbl e where  c.contractor_code=a.contractor_code and a.contractor_code='"+rs2.getString(1)+"' and substr(e.work_id,5,2)='"+district+"' and a.work_id=e.work_id";
// System.out.println("allworks"+allworks);
rs5=stmt5.executeQuery(allworks);
 String work_id2="";
		while(rs5.next()){
work_id2+=rs5.getString(1);
			work_id2+="@";

				
		if(rs5.getString(2)!=null && !rs5.getString(2).equals("null")){
     		agreementValue+=Double.parseDouble(rs5.getString(2));}
		sancAmount+=Double.parseDouble(rs5.getString(3));

             String q="select sum(BILL_AMOUT_STATE),sum(BILL_AMOUNT_CENTRAL) from rws_bill_bank_bridge_tbl a where a.BILL_SL_NO<>'0' and a.work_id='"+rs5.getString(1)+"'";
			rs6=stmt6.executeQuery(q);	    
			  while(rs6.next()){
							if(rs6.getString(1)!=null && !rs6.getString(1).equals("null")){
								releaseAMount+=	(Double.parseDouble(rs6.getString(1))/100000);					
								}
						if(rs6.getString(2)!=null && !rs6.getString(2).equals("null")){
	         

           releaseAMount+=(Double.parseDouble(rs6.getString(2))/100000);
										}


String q1="select sum(VOUCHER_AMT) from rws_work_exp_voucher_tbl b where b.work_id='"+rs5.getString(1)+"'";
			rs7=stmt7.executeQuery(q1);	    
			  while(rs7.next()){
			
					if(rs7.getString(1)!=null && !rs7.getString(1).equals("null")){
	                    paidAmount+=(Double.parseDouble(rs7.getString(1))/100000);
								
										}

}

							} 
allWorksList.put(rs2.getString(1),work_id2); 
			allWorksCount++;
			}
	
  	records.put(rs2.getString(1),ongoingCount+"@"+completedCount+"@"+allWorksCount+"@"+sancAmount+"@"+agreementValue+"@"+releaseAMount+"@"+paidAmount);		

	
}


session.setAttribute("ongoing",ongoingList);
session.setAttribute("completed",completedList);
session.setAttribute("allWorksList",allWorksList);


//System.out.println("Quewry"+query);
rs1=stmt1.executeQuery(query);
List excelRecords=new ArrayList();

while(rs1.next()){
  String rec= (String)records.get(rs1.getString(1));
  String recs[]=rec.split("@");

double balAmount=Double.parseDouble(recs[3])-Double.parseDouble(recs[6]);
    
    excelRecords.add(rs1.getString(1)+"@"+rs1.getString(2)+"@"+rs1.getString(3)+"@"+rs1.getString(4)+"@"+recs[2]+"@"+recs[3]+"@"+recs[4]+"@"+recs[1]+"@"+recs[5]+"@"+recs[0]+"@"+recs[6]+"@"+balAmount);
	            
%>
	<tr><td class=rptvalue><%=sno++ %></td><td><%=rs1.getString(1) %></td><td class=rptvalue><%=rs1.getString(2) %></td><td class=rptvalue><%=rs1.getString(3) %>  /  <%=rs1.getString(4) %></td><td><a href="#" onClick="wopen('rws_contractor_works_list.jsp?type=3&contractorCode=<%=rs1.getString(1) %>')" ><%=recs[2] %></a></td><td class=rptvalue><%=ndf.format(Double.parseDouble(recs[3])) %></td><td class=rptvalue width="60"><%=ndf.format(Double.parseDouble(recs[4])) %> </td><td><a href="#" onClick="wopen('rws_contractor_works_list.jsp?type=1&contractorCode=<%=rs1.getString(1) %>')" ><%=recs[1] %></a></td><td><%=ndf.format(Double.parseDouble(recs[5])) %></td><td><a href="#" onClick="wopen('rws_contractor_works_list.jsp?type=2&contractorCode=<%=rs1.getString(1) %>')" ><%=recs[0] %></a></td><td><%=ndf.format(Double.parseDouble(recs[6])) %></td><td class=rptvalue><%=ndf.format(balAmount) %></td></tr>

<% 

}

session.setAttribute("excelrecords",excelRecords);



		}catch(Exception e)
		{
		 e.printStackTrace();
		}finally{try{
				if(stmt1!=null)
                   stmt1.close();
                if(stmt4!=null)
                   stmt4.close();
				if(stmt2!=null)
                   stmt2.close();if(sst1!=null)
                   sst1.close();
				if(stmt5!=null)
				stmt5.close();
		
 		}catch(Exception e){e.printStackTrace();}
			}
		
%>
	</table>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</form>
