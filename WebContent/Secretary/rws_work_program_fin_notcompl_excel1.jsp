<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";

     String completionDate=null;String message=null;

   
message="Works which are completed in last Financial Year but Releases are Still in Progress.";
																		
	
    double aas=0;
           String pname="";

 pname=(String)session.getAttribute("pname");




   
financialyr=(String)session.getAttribute("financialyr");

    //schemes
String scheme=(String)session.getAttribute("scheme");

String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
    String endyr1 =financialyr.substring(5,9);
   
session.setAttribute("financialyr",financialyr);

 
String programe=(String)session.getAttribute("programe");
	

   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
    
  
String prevmonth=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}
String startyr1="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {

endyr1=endyr;

}

String statePrograms="00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67";

System.out.println("Current Month"+cmonth);
String relTable="",amount="";
String relColumn="";String txid="";
if(statePrograms.contains(programe)){
relTable="RWS_bill_pao_bridge_det_TBL";
relColumn="STATE_SEND_DATE";
txid="STATE_TXID";
amount="BILL_AMOUT_STATE";
}else {
relTable="RWS_bill_BANK_bridge_det_TBL";
relColumn="BANK_SEND_DATE";
txid="TXID";
amount="BILL_AMOUNT_CENTRAL";
}

session.setAttribute("relTable",relTable);
session.setAttribute("relColumn",relColumn);
session.setAttribute("txid",txid);
session.setAttribute("amount",amount);

	%>
	
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=15>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=4>Sl.No</td>
		<td class=btext rowspan=4>District</td>
</tr>
<tr>
		<td class=btext align="center"  colspan=3>No.of Works</td>
		<td class=btext align="center" rowspan=3 >Bal Est Cost<br>(As On 1.4.<%=startyr %>)<br>(Est.Cost-Expenditure)</td>
	
 <td  class=btext align="center"  colspan=2>Releases During <br><%=financialyr %></td>	

<td  class=btext align="center"  colspan=2>Expenditure During <br><%=financialyr %></td>	
	


</tr>
<tr>
<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=2  colspan=1 class=btext align="center">MVS</td>	
		<td rowspan=2  colspan=1 class=btext align="left">Total <br>(3+4)</td>
	

</tr><tr>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>

</tr>
<tr><td class=btext align="center">1</td><td class=btext align="center">2</td><td class=btext align="center">3</td><td class=btext align="center">4</td><td class=btext align="center">5</td><td class=btext align="center">6</td><td class=btext align="center">7</td><td class=btext align="center">8</td><td class=btext align="center">9</td><td class=btext align="center">10</td></tr>
<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/

	String newWorksMVSQuery="select substr(a.office_code,2,2),count(*),sum(sanction_amount)  from rws_work_admn_tbl a ,rws_work_completion_tbl cmp  where  a.work_cancel_dt is null and a.category_code='1' ";
 if(scheme!=null && !scheme.equals("")){
          newWorksMVSQuery+="and a.type_of_asset in("+scheme+")";
}
 newWorksMVSQuery+=" and  a.programme_code in ("+programe+") and a.work_id = cmp.work_id and  (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null   group by  substr(a.office_code,2,2)  order by 1";

	Statement	stmt3=conn.createStatement();
System.out.println("newWorksMVSQuery"+newWorksMVSQuery);
session.setAttribute("mvsQuery",newWorksMVSQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksMVSQuery);
	Hashtable newMvsWorks=new Hashtable();
	while(rs2.next())
	{
		newMvsWorks.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();






	String newWorksSVSQuery="select substr(a.office_code,2,2),count(*),sum(sanction_amount)  from rws_work_admn_tbl a , rws_work_completion_tbl cmp where a.work_cancel_dt is null and a.category_code='2'";
 if(scheme!=null && !scheme.equals("")){
          newWorksSVSQuery+="and a.type_of_asset in("+scheme+")";
}
 newWorksSVSQuery+=" and  substr(a.work_id,1,2) in  ("+programe+") and a.work_id =cmp.work_id and  (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null  group by  substr(a.office_code,2,2)  order by 1";

	stmt3=conn.createStatement();
System.out.println("newWorksSVSQuery"+newWorksSVSQuery);
session.setAttribute("svsQuery",newWorksSVSQuery);
	 rs2=stmt3.executeQuery(newWorksSVSQuery);
	Hashtable newSvsWorks=new Hashtable();
	while(rs2.next())
	{
		newSvsWorks.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




	String newWorksReleaesQuery="select substr(a.office_code,2,2),sum(case when (to_date("+relColumn+")>= '01-APR-"+startyr+"' and to_date("+relColumn+") < '01-APR-"+endyr+"') then "+amount+" else 0 end) from rws_work_admn_tbl a ,"+relTable+" b  where a.work_id =b.work_id and  to_date("+relColumn+")>= '01-APR-"+startyr+"' and "+txid+" is not null  and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksReleaesQuery+="and a.type_of_asset in("+scheme+")";
}
newWorksReleaesQuery+=" and a.CATEGORY_CODE='1' and  substr(a.work_id,1,2)  in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  substr(a.office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksReleaesQuery"+newWorksReleaesQuery);
	 rs2=stmt3.executeQuery(newWorksReleaesQuery);
	Hashtable newWorksRel=new Hashtable();
	while(rs2.next())
	{
		newWorksRel.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String newWorksReleaesSVS="select substr(a.office_code,2,2),sum(case when (to_date("+relColumn+")>= '01-APR-"+startyr+"' and to_date("+relColumn+") < '01-APR-"+endyr+"') then "+amount+" else 0 end) from rws_work_admn_tbl a ,"+relTable+" b   where  a.work_id=b.work_id and to_date("+relColumn+")>= '01-APR-"+startyr+"' and "+txid+" is not null and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksReleaesSVS+="and a.type_of_asset in("+scheme+")";
}
newWorksReleaesSVS+=" and a.CATEGORY_CODE='2' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  substr(a.office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksReleaesSVS"+newWorksReleaesSVS);
	 rs2=stmt3.executeQuery(newWorksReleaesSVS);
	Hashtable newWorksRelSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksRelSVS.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String newWorksExpenSVS="select substr(a.office_code,2,2),sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt) < '01-APR-"+endyr+"' )then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+startyr+"' and "+txid+" is not null) and a.work_id=b.work_id and    a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenSVS+="and a.type_of_asset in("+scheme+")";
}
newWorksExpenSVS+=" and a.CATEGORY_CODE='2' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  substr(a.office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksExpenSVS"+newWorksExpenSVS);
	 rs2=stmt3.executeQuery(newWorksExpenSVS);
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksExpSVS.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWorksExpenMVS="select substr(a.office_code,2,2),sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and  to_date(voucher_dt) < '01-APR-"+endyr+"' ) then voucher_amt else 0 end)  from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+startyr+"' and "+txid+" is not null) and  a.work_id=b.work_id and    a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenMVS+="and a.type_of_asset in("+scheme+")";
}
newWorksExpenMVS+=" and a.CATEGORY_CODE='1' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  substr(a.office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksExpenMVS"+newWorksExpenMVS);
	 rs2=stmt3.executeQuery(newWorksExpenMVS);
	Hashtable newWorksExpMVS=new Hashtable();
	while(rs2.next())
	{
		newWorksExpMVS.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWorksExpenTot="select substr(a.office_code,2,2),(sum(case when (to_date(voucher_dt)< '01-Apr-"+startyr+"' )then voucher_amt else 0 end)/100000)   from rws_work_admn_tbl a ,rws_work_exp_voucher_tbl d  where a.work_id=d.work_id and  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+startyr+"' and "+txid+" is not null)  and a.work_cancel_dt is null  ";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenTot+="and a.type_of_asset in("+scheme+")";
}
 newWorksExpenTot+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') and DATE_OF_COMPLETION is not null and  DT_FIN_COMPLETION is null)  group by   substr(a.office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksExpenTot"+newWorksExpenTot);
	 rs2=stmt3.executeQuery(newWorksExpenTot);
	Hashtable newWorksExpTot=new Hashtable();
	while(rs2.next())
	{
		newWorksExpTot.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




/***********************************End  ************************************/



String query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code  and  a.status <> 'UI' order by circle_office_code";

query="select dname,dcode from rws_district_tbl where dcode <>'16'  order by 2"; 

rs1=stmt2.executeQuery(query);

String dname="";
int svs=0,mvs=0;
int gsvs=0,gmvs=0,gtot=0;
double rel1=0,grel1=0,relUpto=0,relCur=0,grelUpto=0,grelCur=0,relUptoSVS=0,relCurSVS=0,grelUptoSVS=0,grelCurSVS=0;
double expUptoMVS=0,expCurSVS=0,expUptoSVS=0,expCurMVS=0,gexpUptoSVS=0,gexpCurSVS=0,gexpUptoMVS=0,gexpCurMVS=0;
double svsSanction=0.0,mvsSanction=0.0,balEstimate=0.0,gbalEstimate=0.0;
String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){

exp=(String)newWorksRel.get(rs1.getString(2));
if(exp!=null){
relUpto=Double.parseDouble(exp)/100000;
grelUpto+=relUpto;

}

//mvs

nexp=(String)newWorksRelSVS.get(rs1.getString(2));
if(nexp!=null){
 relUptoSVS=Double.parseDouble(nexp)/100000;
	grelUptoSVS+=relUptoSVS;


}



relS=(String)newWorksExpSVS.get(rs1.getString(2));
if(relS!=null){
 expUptoSVS=Double.parseDouble(relS)/100000;
  gexpUptoSVS+=expUptoSVS;



}

relS1=(String)newWorksExpMVS.get(rs1.getString(2));
if(relS1!=null){
 expUptoMVS=Double.parseDouble(relS1)/100000;
gexpUptoMVS+=expUptoMVS;


}



if( newSvsWorks.get(rs1.getString(2))!=null){

 String svsStr=(String)newSvsWorks.get(rs1.getString(2));
  if(!svsStr.equals("")){
       String a[]=svsStr.split("@");
        svs=Integer.parseInt(a[0]);
        svsSanction=Double.parseDouble(a[1]);
 }

}

if( newMvsWorks.get(rs1.getString(2))!=null){

 String svsStr=(String)newMvsWorks.get(rs1.getString(2));
  if(!svsStr.equals("")){
       String a[]=svsStr.split("@");
        mvs=Integer.parseInt(a[0]);
        mvsSanction=Double.parseDouble(a[1]);
 }

}

if( newWorksExpTot.get(rs1.getString(2))!=null){

   String str=(String)newWorksExpTot.get(rs1.getString(2));
   balEstimate=((svsSanction+mvsSanction)-Double.parseDouble(str));
gbalEstimate+=balEstimate;
}


%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>


<%} %>

<td class=rptValue ><%= svs %></td>
<td class=rptValue ><%= mvs %></td>
<td class=rptValue ><%=(svs+mvs) %></td>
<td class=rptValue ><%= ndf.format(balEstimate) %></td>
<td class=rptValue ><%= ndf.format(relUptoSVS) %></td>
<td class=rptValue ><%= ndf.format(relUpto) %></td>
<td class=rptValue ><%= ndf.format(expUptoSVS) %></td>
<td class=rptValue ><%= ndf.format(expUptoMVS) %></td>





<% 
gtot+=svs+mvs;
gsvs+=svs;
gmvs+=mvs;
grel1+=rel1;
svs=0;
mvs=0;rel1=0;
relUpto=0;
relCur=0;
relUptoSVS=0;
relCurSVS=0;
expUptoSVS=0;
expCurSVS=0;
expUptoMVS=0;
expCurMVS=0;
svs=0;
balEstimate=0;
svsSanction=0;
mvsSanction=0;
mvs=0;
}
%>
<tr><td colspan=2 class=btext align=right>Total:</td>

<td class=btext><%=gsvs %></td>
<td class=btext><%=gmvs %></td>
<td class=btext><%=gtot %></td>
<td class=btext><%=ndf.format(gbalEstimate) %></td>
<td class=btext><%=ndf.format(grelUptoSVS) %></td>
<td class=btext><%=ndf.format(grelUpto) %></td>
<td class=btext><%=ndf.format(gexpUptoSVS) %></td>
<td class=btext><%=ndf.format(gexpUptoMVS) %></td>

</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>