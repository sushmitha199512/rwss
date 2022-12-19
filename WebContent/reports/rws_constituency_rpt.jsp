<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	
    double aas=0;
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialyr=request.getParameter("finyear");
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
   
session.setAttribute("financialyr",financialyr);
String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
    String endyr1 =financialyr.substring(5,9);


    String frmDcode=request.getParameter("district");
    

String scheme="";
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	//System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("scheme",scheme);
}
	
	
	String[] programes=request.getParameterValues("program");
	
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	//System.out.println("programe::"+programe);
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
 


String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();


if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}


String dcode=request.getParameter("dcode");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

//System.out.println("dcode"+dcode);
//System.out.println("DivCode"+divCode);


	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
  
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=35>Work Load as on (<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Constituency Name</td>
		
<td class=btext  align=center colspan=5 style="background-color:#d2b48c">SVS</td>
<td class=btext colspan=3 align=center style="background-color:#d2b48c">MVS</td>
<td class=btext colspan=3 align=center style="background-color:#d2b48c">TOTAL</td>
</tr>
<tr>
		<td class=btext align="center" style="background-color:lightyellow" >No.of Works</td>
		<td class=btext align="center" style="background-color:lightyellow" >Est Cost</td>
		<td class=btext align="center" style="background-color:lightyellow" >Exp Upto <br>31.3.<%=startyr%></td>
		<td class=btext align="center" style="background-color:lightyellow" >Bal Est.Cost as on 31.3.<%=startyr%><br>(5-6)</td>
				<td class=btext align="center" style="background-color:lightyellow" >Habs Sanctioned</td>
		<td class=btext align="center" style="background-color:lightyellow" >No.of Works</td>
		<td class=btext align="center" style="background-color:lightyellow" >Bal Est.Cost as on 31.3.<%=startyr%><br>(5-6)</td>
				<td class=btext align="center" style="background-color:lightyellow" >Habs Sanctioned</td>
		<td class=btext align="center" style="background-color:lightyellow" >No.of Works</td>
		<td class=btext align="center" style="background-color:lightyellow" >Bal Est.Cost as on 31.3.<%=startyr%><br>(5-6)</td>
				<td class=btext align="center" style="background-color:lightyellow" >Habs Sanctioned</td>
 

</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center" class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext>14</td></tr>


<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
int sno=1;
double expUpto=0;
double estAmount=0,balAmount=0;
double gbalAmount=0;
double gestAmount=0;
double gexpAmount=0;
int shabs=0,gshabs=0;
int gsvsCount=0;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/


	String newWorksMVSQuery="select d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE ,count(*),sum(a.sanction_amount) from rws_work_admn_tbl a,RWS_CONSTITUENCY_TBL  b,rws_district_tbl d,rws_mandal_tbl m where substr(work_id,5,2)=d.dcode and b.dcode=d.dcode and m.dcode=d.dcode and b.mcode=m.mcode and lead_habitation is not null and m.mcode=substr(a.lead_habitation,6,2) and  a.work_id not in(select work_id from rws_work_completion_tbl)   and work_cancel_dt is null  and  a.category_code='1'";
	 if(scheme!=null && !scheme.equals("")){
		 newWorksMVSQuery+="and a.type_of_asset in("+scheme+")";
	}
	 if(frmDcode!=null && !frmDcode.equals("") && !frmDcode.equals("00")){
		 newWorksMVSQuery+="and d.dcode='"+frmDcode+"'";
	}
	 newWorksMVSQuery+=" and  a.programme_code in ("+programe+")   group by  d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE order by d.dcode";

		Statement	stmt4=conn.createStatement();
	System.out.println("New MVS Works"+newWorksMVSQuery);
		ResultSet rs3=stmt4.executeQuery(newWorksMVSQuery);
  Hashtable mvsHash=new Hashtable();
  
     while(rs3.next()){
    	 mvsHash.put(rs3.getString(1)+rs3.getString(4),rs3.getString(5));
    	 
     }
     
     
     
     
     String newWorksEXPQuery="select d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE ,count(*),sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end) from rws_work_admn_tbl a,RWS_CONSTITUENCY_TBL  b,rws_district_tbl d,rws_mandal_tbl m,rws_work_exp_voucher_tbl exp    where substr(a.work_id,5,2)=d.dcode and b.dcode=d.dcode and m.dcode=d.dcode and b.mcode=m.mcode and lead_habitation is not null and m.mcode=substr(a.lead_habitation,6,2) and  a.work_id not in(select work_id from rws_work_completion_tbl)   and work_cancel_dt is null  and  a.category_code='2' and exp.work_id=a.work_id";
	 if(scheme!=null && !scheme.equals("")){
		 newWorksEXPQuery+=" and a.type_of_asset in("+scheme+")";
	}
	 if(frmDcode!=null && !frmDcode.equals("") && !frmDcode.equals("00")){
		 newWorksEXPQuery+="and d.dcode='"+frmDcode+"'";
	}
	 newWorksEXPQuery+=" and  a.programme_code in ("+programe+")   group by  d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE order by d.dcode";

		Statement	stmt5=conn.createStatement();
	System.out.println("New EXP Works"+newWorksEXPQuery);
		ResultSet rs4=stmt4.executeQuery(newWorksEXPQuery);
  Hashtable expHash=new Hashtable();
  
     while(rs4.next()){
    	 expHash.put(rs4.getString(1)+rs4.getString(4),rs4.getString(6));
    	 
     }
		
     
     
     

 	String newWorksHabsQuery="select d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE ,count(*) from rws_work_admn_tbl a,RWS_CONSTITUENCY_TBL  b,rws_district_tbl d,rws_mandal_tbl m,rws_admn_hab_lnk_tbl hl where substr(a.work_id,5,2)=d.dcode and b.dcode=d.dcode and m.dcode=d.dcode and b.mcode=m.mcode and  m.mcode=substr(hl.hab_code,6,2) and  a.work_id not in(select work_id from rws_work_completion_tbl)   and work_cancel_dt is null  and  a.category_code='2' and hl.work_id=a.work_id";
  if(scheme!=null && !scheme.equals("")){
	  newWorksHabsQuery+=" and a.type_of_asset in("+scheme+")";
 }
  if(frmDcode!=null && !frmDcode.equals("") && !frmDcode.equals("00")){
	  newWorksHabsQuery+="and d.dcode='"+frmDcode+"'";
 }
  newWorksHabsQuery+=" and  a.programme_code in ("+programe+")   group by  d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE order by d.dcode";

 	Statement	stmt6=conn.createStatement();
 System.out.println("New SVS habs  Works"+newWorksHabsQuery);
 	ResultSet rs5=stmt6.executeQuery(newWorksHabsQuery);
 	Hashtable habsHash=new Hashtable();
 	
 	while(rs5.next()){
 		
 		habsHash.put(rs5.getString(1)+rs5.getString(4),rs5.getString(5));
 	}
     


	String newWorksSVSQuery="select d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE ,count(*),sum(a.sanction_amount) from rws_work_admn_tbl a,RWS_CONSTITUENCY_TBL  b,rws_district_tbl d,rws_mandal_tbl m,rws_admn_hab_lnk_tbl hl where substr(a.work_id,5,2)=d.dcode and b.dcode=d.dcode and m.dcode=d.dcode and b.mcode=m.mcode and m.mcode=substr(hl.hab_code,6,2) and  a.work_id not in(select work_id from rws_work_completion_tbl)   and a.work_id=hl.work_id and work_cancel_dt is null  and  a.category_code='2'";
 if(scheme!=null && !scheme.equals("")){
	 newWorksSVSQuery+="and a.type_of_asset in("+scheme+")";
}
 if(frmDcode!=null && !frmDcode.equals("") && !frmDcode.equals("00")){
	 newWorksSVSQuery+="and d.dcode='"+frmDcode+"'";
}
 newWorksSVSQuery+=" and  a.programme_code in ("+programe+")   group by  d.dcode,d.dname, b.CONSTITUENCY_NAME ,b.CONSTITUENCY_CODE order by d.dcode";

	Statement	stmt3=conn.createStatement();
System.out.println("New SVS Works"+newWorksSVSQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksSVSQuery);
	
	while(rs2.next()){
		expUpto=0;
		estAmount=0;
		gsvsCount+=Integer.parseInt(rs2.getString(5));
		balAmount=0;
		
		String mvsWorksValue=(String)mvsHash.get(rs2.getString(1)+rs2.getString(4));
		if(mvsWorksValue==null || mvsWorksValue.equals("null")){
			mvsWorksValue="0";
		}
		if(expHash.get(rs2.getString(1)+rs2.getString(4))!=null ){
			
			expUpto=Double.parseDouble((String)expHash.get(rs2.getString(1)+rs2.getString(4)))/100000;
			gexpAmount+=expUpto;
			
		}
		
if(habsHash.get(rs2.getString(1)+rs2.getString(4))!=null ){
			
			shabs=Integer.parseInt((String)habsHash.get(rs2.getString(1)+rs2.getString(4)));
			gshabs+=shabs;
			
		}
		
		
	if(rs2.getString(6)!=null){
		
		estAmount=Double.parseDouble(rs2.getString(6));
		gestAmount+=estAmount;
	}
		
	balAmount=estAmount-expUpto;
	gbalAmount+=balAmount;
	%>
	
	<tr><td class="btext"><%=sno++ %></td><td class="btext"><%=rs2.getString(2) %></td><td class="btext"><%=rs2.getString(3) %></td><td class="rptValue"><%=rs2.getString(5) %></td><td class="rptValue"><%=rs2.getString(6) %></td><td class="rptValue"><%=ndf.format(expUpto) %></td><td class="rptValue"><%=ndf.format(balAmount) %></td><td class="rptValue"><%=shabs %></td><td class=rptValue></td><td></td><td></td><td></td><td></td><td></td></tr>
	
	<% 
	}
	
	%>
	<tr ><td class="btext" colspan="3">Grand Total:</td><td class="btext"><%=gsvsCount %></td><td class="btext"><%=ndf.format(gestAmount) %></td><td class="btext"><%=ndf.format(gexpAmount) %></td><td class="btext"><%=ndf.format(gbalAmount) %></td><td class="btext"><%=gshabs %></td></tr>
	<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>