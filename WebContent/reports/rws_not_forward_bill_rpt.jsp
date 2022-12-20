<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
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
<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
	 <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	 <tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td>
	</tr>
	</table>
	</caption>
	
   <tr></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="60%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=6><font color="white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pending  Bills Report</font> </td>	
	</tr>
		<tr>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Division</td>
		<td class=btext rowspan=2>EE</td>
		<td class=btext rowspan=2>EE Budget</td>
		<td class=btext rowspan=2>ENC</td>
		</tr>

<tr>

<%
String dcode=request.getParameter("circle_office_code");
session.setAttribute("circle_office_code",dcode);
//System.out.println("dcode"+dcode);
nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");    
	   }
Statement stmt1=null;
ResultSet rs1=null;
int count=1,svscnt=0,mvscnt=0,svscompcnt=0;
int tot1=0,tot2=0,tot3=0;


int s1=0,s2=0,s3=0;
int gs1=0,gs2=0,gs3=0;
String sw="",sw1="",sw3="";
try
{

stmt1=conn.createStatement();

String query="",dname="";

Statement st15=null,st16=null,st17=null;
ResultSet rs15=null,rs16=null,rs17=null;
String qry15="",qry16="",qry17="";
st15=conn.createStatement();
st16=conn.createStatement();
st17=conn.createStatement();



String selectedProgramsFin="'01','48','32','23','49','51','18','60','59','58','50'";
//String SVS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='2' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
//String ee="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_bill_tbl c where   substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and w.work_id=c.work_id and c.EE_FWD_DATE is  null and w.programme_code in ('02','01','48','32','23','49','51','18','37','60')  and bill_sl_no<>0 group by  b.circle_office_code,b.division_office_code  order by 1";
String ee="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_bill_tbl c where   substr(c.work_id,1,2) in ("+selectedProgramsFin+" )   and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and w.work_id=c.work_id and c.EE_FWD_DATE is  null  and bill_sl_no<>0 group by  b.circle_office_code,b.division_office_code  order by 1";
Statement stmt2=conn.createStatement();
   //System.out.println("EE:"+ee);
	ResultSet rs2=stmt2.executeQuery(ee);
	Hashtable SVSList=new Hashtable();
	while(rs2.next())
	{
		SVSList.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();



	
	//String eebudget="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from rws_work_bill_tbl a,rws_work_admn_tbl b where  b.programme_code in ('02','01','48','32','23','49','51','18','37','60') and a.work_id=b.work_id and   EE_FWD_DATE is not null and BILL_SL_NO <>'0' and  (a.work_id,a.BILL_SL_NO ) not in( select c.work_id,c.BILL_SL_NO  from RWS_BILL_BANK_BRIDGE_TBL c ) and (a.work_id,a.BILL_SL_NO )  not in( select d.work_id,d.BILL_SL_NO  from rws_bill_bank_bridge_temp_tbl d ) group by substr(b.office_code,2,2),substr(b.office_code,4,1) ";
   String eebudget="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from rws_work_bill_tbl a,rws_work_admn_tbl b where   substr(b.work_id,1,2) in ("+selectedProgramsFin+" )   and a.work_id=b.work_id and   EE_FWD_DATE is not null and BILL_SL_NO <>'0' and  (a.work_id,a.BILL_SL_NO ) not in( select c.work_id,c.BILL_SL_NO  from RWS_BILL_BANK_BRIDGE_TBL c ) and (a.work_id,a.BILL_SL_NO )  not in( select d.work_id,d.BILL_SL_NO  from rws_bill_bank_bridge_temp_tbl d ) group by substr(b.office_code,2,2),substr(b.office_code,4,1) ";
	 //System.out.println("eebudget"+eebudget);

	Statement stmt22=conn.createStatement();
	  //System.out.println("eebudget:"+eebudget);
		ResultSet rs22=stmt22.executeQuery(eebudget);
		Hashtable eeList=new Hashtable();
		while(rs22.next())
		{
			eeList.put(rs22.getString(2)+rs22.getString(3),rs22.getString(1));
		}
		if(rs22!=null)rs22.close();
		if(stmt22!=null)stmt22.close();


		
		String enc="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from rws_work_bill_tbl a,rws_work_admn_tbl b where  substr(b.work_id,1,2) in ("+selectedProgramsFin+ ")   and a.work_id=b.work_id and   EE_FWD_DATE is not null and BILL_SL_NO <>'0' and  (a.work_id,a.BILL_SL_NO )not in( select c.work_id,c.BILL_SL_NO  from RWS_BILL_BANK_BRIDGE_TBL c ) and (a.work_id,a.BILL_SL_NO )   in( select d.work_id,d.BILL_SL_NO  from rws_bill_bank_bridge_temp_tbl d ) group by substr(b.office_code,2,2),substr(b.office_code,4,1) ";
		//System.out.println("eebudget"+eebudget);

			Statement stmt222=conn.createStatement();
			//  System.out.println("enc:"+enc);
				ResultSet rs222=stmt222.executeQuery(enc);
				Hashtable encList=new Hashtable();
				while(rs222.next())
				{
					encList.put(rs222.getString(2)+rs222.getString(3),rs222.getString(1));
				}
				if(rs222!=null)rs222.close();
				if(stmt222!=null)stmt222.close();





query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code,dcode from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI'  ";

if(dcode!=null && !dcode.equals("")){
	query+=" and dcode='"+dcode+"'";
}
query+=" order by circle_office_code";

rs1=stmt1.executeQuery(query);
int eeBudgetBills=0;
while(rs1.next())
{
	 sw=(String)SVSList.get(rs1.getString(3)+rs1.getString(4));
	if(sw!=null && !sw.equals(""))
	{
		
	}
	else
	{
	sw="0";
	}
	sw1=(String)eeList.get(rs1.getString(3)+rs1.getString(4));
	if(sw1!=null && !sw1.equals(""))
	{
		
	}
	else
	{
	sw1="0";
	}
	
	
	
	 sw3=(String)encList.get(rs1.getString(3)+rs1.getString(4));
		if(sw3!=null && !sw3.equals(""))
		{
			
		}
		else
		{
		sw3="0";
		}
		
	s1=Integer.parseInt(sw);
	s2=Integer.parseInt(sw1);
	s3=Integer.parseInt(sw3);
	//System.out.println("s1******"+s1);
	
	gs1=s1+gs1;
	gs2=s2+gs2;
	gs3=s3+gs3;
	//System.out.println("gs1******"+gs1);
	
//end of while
%>
<tr>
<td class=rptLabel><%=count++ %></td>

<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else
{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>
<%
if(s1==0)
{%>
<td class=rptValue align="right" ><%=s1%></td>
<%}else{%>
<td class=rptValue align="right" ><a href="#" onclick="viewWorks('rws_not_forward_bill_drill_rpt.jsp?circleofficecode=<%=rs1.getString(3)%>&divisionofficecode=<%=rs1.getString(4)%>&dcode=<%=rs1.getString(5)%>&dname=<%=rs1.getString(1)%>&divisionname=<%=rs1.getString(2)%>')"><%=SVSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscnt=(Integer.parseInt((String)SVSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<%} if(s2==0){
%>	
<td class=rptValue align="right" ><%=s2%></td>
<%}else{ %>
<td class=rptValue align="right" ><a href="#" onclick="viewWorks('rws_not_forward_bill_eebudget_drill.jsp?circleofficecode=<%=rs1.getString(3)%>&divisionofficecode=<%=rs1.getString(4)%>&dcode=<%=rs1.getString(5)%>&dname=<%=rs1.getString(1)%>&divisionname=<%=rs1.getString(2)%>')"><%=eeList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvscnt=(Integer.parseInt((String)eeList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<%} %>
<td class=rptValue align="right" ><%=encList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscompcnt=(Integer.parseInt((String)encList.get(rs1.getString(3)+rs1.getString(4)))))%></td>

</tr>


<% 


tot1=tot1+svscnt;
tot2=tot2+mvscnt;
tot3+=svscompcnt;
}

%>
<tr>
<td class=rptLabel colspan="3" align="right"> Total:</td>
<td class=rptLabel align="right" ><%=gs1%></td>
<td class=rptLabel align="right"><%=gs2 %></td>
<td class=rptLabel align="right" ><%=gs3 %></td>
</tr>

<%
//svscnt=0;
//mvscnt=0;
}
catch(Exception e)
{
  e.printStackTrace();
}

 %>



</table>	

