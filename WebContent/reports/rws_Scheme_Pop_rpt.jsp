<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null;
Statement st1=null,st2=null,st3=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null;
ResultSet rs6=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs7=null;
ResultSet rs8=null;
ResultSet pwsrs=null;
ResultSet pwscovrs=null;
ResultSet pwspoprs=null;
Statement pwsst=null;
Statement pwscovst=null;
Statement pwspopst=null;
int gtot=0;
int gatot=0;
int bgtot=0;
int tot=0;
int tot1=0;
int tot2=0;
ResultSet r1=null,r2=null,r3=null,r4=null,r5=null,r6=null,r7=null,r8=null,r9=null;
Statement t1=null,t2=null,t3=null,t4=null,t5=null,t6=null,t7=null,t8=null,t9=null;
String dcode=request.getParameter("rDistrict");
session.setAttribute("dcode",dcode);
String dname=request.getParameter("rDistrictName");
session.setAttribute("dname",dname);

int sno=1;
String qry="";
String queryasset="";

%>
		
		<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a><a href="./rws_Scheme_Pop_xls.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Schemewise Habs and Population Details  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>
	 </td>
	</tr>
	</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

	<td class=btext rowspan="2">Sl.No</td>
	<td class=btext rowspan="2">District</td>
	<td class=btext rowspan="2"><font color="red"><b>Cpws</b></font></td>
	<td class=btext colspan="4">Habs Covered</td>
	<td class=btext rowspan="2"><font color="green">Population</b></font></td>
	<td class=btext rowspan="2"><font color="red"><b>PWS</b></font></td>
	<td class=btext colspan="4">Habs Covered</td>
	<td class=btext rowspan="2"><font color="green">Population</b></font></td>
	<td class=btext rowspan="2"><font color="red"><b>MPWS</b></font></td>
	<td class=btext colspan="4">Habs Covered</td>
	<td class=btext rowspan="2"><font color="green">Population</b></font></td>
	<td class=btext rowspan="2"><font color="red"><b>Hp</b></font></td>
	<td class=btext colspan="4">Habs Covered</td>
	<td class=btext rowspan="2"><font color="green">Population</b></font></td>
	<td class=btext rowspan="2"><font color="red"><b>Direct Pumping</b></font></td>
	<td class=btext colspan="4">Habs Covered</td>
	<td class=btext rowspan="2"><font color="green">Population</b></font></td>
	</tr>
	<tr>
	<td class=btext align="center">PLAIN Habs</td>
	<td class=btext align="center">SC Habs</td>
		<td class=btext align="center">ST Habs</td>
		<td class=btext align="center">TOTAL Habs</td>
			<td class=btext align="center">PLAIN Habs</td>
	<td class=btext align="center">SC Habs</td>
		<td class=btext align="center">ST Habs</td>
		<td class=btext align="center">TOTAL Habs</td>
	
	<td class=btext align="center">PLAIN Habs</td>
	<td class=btext align="center">SC Habs</td>
		<td class=btext align="center">ST Habs</td>
		<td class=btext align="center">TOTAL Habs</td>
	
	<td class=btext align="center">PLAIN Habs</td>
	<td class=btext align="center">SC Habs</td>
		<td class=btext align="center">ST Habs</td>
		<td class=btext align="center">TOTAL Habs</td>
	
	<td class=btext align="center">PLAIN Habs</td>
	<td class=btext align="center">SC Habs</td>
		<td class=btext align="center">ST Habs</td>
		<td class=btext align="center">TOTAL Habs</td>
	
	</tr>
<%
try
{

int ctot=0,ccptot=0,csctot=0,csttot=0,cttot=0,cptot=0;
	int ptot=0,ppptot=0,psctot=0,psttot=0,pttot=0,pptot=0;
		int mtot=0,mmptot=0,msctot=0,msttot=0,mttot=0,mptot=0;
			int htot=0,hhptot=0,hsctot=0,hsttot=0,httot=0,hptot=0;
				int dtot=0,ddptot=0,dsctot=0,dsttot=0,dttot=0,dptot=0;

String query = "";   
String cpwsquery="";
String cpwspop="";
String pwscount="";
String pwscov="";
String pwspop="";
int s1=0;
int s2=0;
int s3=0;
int gtot1=0;
int gtot2=0;
int s4=0;
int s5=0;
int s6=0;
int g4=0;
int g5=0;
int g6=0;
int s7=0;
int s8=0;
int s9=0;
int g7=0;
int g8=0;
int g9=0;
int s10=0;
int s11=0;
int s12=0;
int s13=0;
int s14=0;
int s15=0;
int g10=0;
int g11=0;
int g12=0;
int g13=0;
int g14=0;
int g15=0;

cpwsquery="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' group by substr(panch_code,1,2)";

st1=conn.createStatement();
// System.out.println("qry2cpws:"+cpwsquery);
rs4=st1.executeQuery(cpwsquery);
Hashtable cpws=new Hashtable();
while(rs4.next())
 {
   cpws.put(rs4.getString(2),rs4.getString(1));
 }


cpwspop="select sum(CENSUS_PLAIN_POPU +CENSUS_SC_POPU +CENSUS_ST_POPU),substr(panch_code,1,2)  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' group by substr(panch_code,1,2)";

st2=conn.createStatement();
 //System.out.println("qry2cpws2pop:"+query);
rs6=st2.executeQuery(cpwspop);
Hashtable cpwspop1=new Hashtable();
while(rs6.next())
 {
   cpwspop1.put(rs6.getString(2),rs6.getString(1));
 }

//
String cpwscov="select count(distinct b.hab_code),substr(panch_code,1,2),habitation_sub_type  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c  where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' group by habitation_sub_type,substr(panch_code,1,2) order by 2,3";
st3=conn.createStatement();
 //System.out.println("qry2habscpws:"+cpwscov);
rs7=st3.executeQuery(cpwscov);
Hashtable cpwscov1=new Hashtable();
while(rs7.next())
 {
   cpwscov1.put(rs7.getString(2)+"@"+rs7.getString(3),rs7.getString(1));
 }

//pws
pwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03') group by substr(panch_code,1,2)";

pwsst=conn.createStatement();
 //System.out.println("qry2:"+pwscount);
pwsrs=pwsst.executeQuery(pwscount);
Hashtable pws=new Hashtable();
while(pwsrs.next())
 {
   pws.put(pwsrs.getString(2),pwsrs.getString(1));
 }
pwspop="select sum(CENSUS_PLAIN_POPU +CENSUS_SC_POPU +CENSUS_ST_POPU),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03') group by substr(panch_code,1,2)";

pwspopst=conn.createStatement();
 //System.out.println("qry2:"+pwspop);
pwspoprs=pwspopst.executeQuery(pwspop);
Hashtable pwspop1=new Hashtable();
while(pwspoprs.next())
 {
   pwspop1.put(pwspoprs.getString(2),pwspoprs.getString(1));
 }
pwscov="select count(distinct b.hab_code),substr(panch_code,1,2),habitation_sub_type from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03') group by substr(panch_code,1,2),habitation_sub_type order by 2,3";
pwscovst=conn.createStatement();
 //System.out.println("qry2:"+pwscov);
pwscovrs=pwscovst.executeQuery(pwscov);
Hashtable pwscov1=new Hashtable();
while(pwscovrs.next())
 {
   pwscov1.put(pwscovrs.getString(2)+"@"+pwscovrs.getString(3),pwscovrs.getString(1));
 }
//mpws
String mpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01')) group by substr(panch_code,1,2)";

t1=conn.createStatement();
// System.out.println("qry2:"+mpwscount);
r1=t1.executeQuery(mpwscount);
Hashtable mpws=new Hashtable();
while(r1.next())
 {
   mpws.put(r1.getString(2),r1.getString(1));
 }
String mpwspop="select sum(CENSUS_PLAIN_POPU +CENSUS_SC_POPU +CENSUS_ST_POPU),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01')) group by substr(panch_code,1,2)";


t2=conn.createStatement();
 //System.out.println("qry2:"+mpwspop);
r2=t2.executeQuery(mpwspop);
Hashtable mpwspop1=new Hashtable();
while(r2.next())
 {
   mpwspop1.put(r2.getString(2),r2.getString(1));
 }
String mpwscov="select count(distinct b.hab_code),substr(panch_code,1,2),habitation_sub_type  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01')) group by substr(panch_code,1,2),habitation_sub_type order by 2,3";
t3=conn.createStatement();
// System.out.println("qry2:"+mpwscov);
r3=t3.executeQuery(mpwscov);
Hashtable mpwscov1=new Hashtable();
while(r3.next())
 {
   mpwscov1.put(r3.getString(2)+"@"+r3.getString(3),r3.getString(1));
 }

//hp
String hpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='04' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02')) group by substr(panch_code,1,2)";

t4=conn.createStatement();
 //System.out.println("qry2:"+hpwscount);
r4=t4.executeQuery(hpwscount);
Hashtable hmpws=new Hashtable();
while(r4.next())
 {
   hmpws.put(r4.getString(2),r4.getString(1));
 }

String hmpwspop="select count(distinct b.hab_code),substr(panch_code,1,2),habitation_sub_type  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='04' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02' )) group by substr(panch_code,1,2),habitation_sub_type order by 2,3";

t5=conn.createStatement();
// System.out.println("qry2:"+hmpwspop);
r5=t5.executeQuery(hmpwspop);
Hashtable hmpwspop1=new Hashtable();
while(r5.next())
 {
   hmpwspop1.put(r5.getString(2)+"@"+r5.getString(3),r5.getString(1));
 }
String hmpwscov="select sum(CENSUS_PLAIN_POPU +CENSUS_SC_POPU +CENSUS_ST_POPU),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='04' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02')) group by substr(panch_code,1,2)";

t6=conn.createStatement();
// System.out.println("qry2:"+hmpwscov);
r6=t6.executeQuery(hmpwscov);
Hashtable hmpwscov1=new Hashtable();
while(r6.next())
 {
   hmpwscov1.put(r6.getString(2),r6.getString(1));
 }


//dp
String dpwscount="select count(distinct a.asset_code),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02' OR type_of_asset_code='04' OR type_of_asset_code='05' OR type_of_asset_code='06' OR type_of_asset_code='07' OR type_of_asset_code='08')) group by substr(panch_code,1,2)";
t7=conn.createStatement();
// System.out.println("qry2:"+dpwscount);
r7=t7.executeQuery(dpwscount);
Hashtable dmpws=new Hashtable();
while(r7.next())
 {
   dmpws.put(r7.getString(2),r7.getString(1));
 }

String dmpwspop="select sum(CENSUS_PLAIN_POPU +CENSUS_SC_POPU +CENSUS_ST_POPU),substr(panch_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02' OR type_of_asset_code='04' OR type_of_asset_code='05' OR type_of_asset_code='06' OR type_of_asset_code='07' OR type_of_asset_code='08')) group by substr(panch_code,1,2)";


t8=conn.createStatement();
 //System.out.println("qry2:"+dmpwspop);
r8=t8.executeQuery(dmpwspop);
Hashtable dmpwspop1=new Hashtable();
while(r8.next())
 {
   dmpwspop1.put(r8.getString(2),r8.getString(1));
 }
String dmpwscov="select count(distinct b.hab_code),substr(panch_code,1,2),habitation_sub_type  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09' and a.hab_code not in(select distinct b.hab_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and (type_of_asset_code='03' OR type_of_asset_code='01' OR type_of_asset_code='02'OR type_of_asset_code='04' OR type_of_asset_code='05' OR type_of_asset_code='06' OR type_of_asset_code='07' OR type_of_asset_code='08' )) group by substr(panch_code,1,2),habitation_sub_type order by 2,3";
t9=conn.createStatement();
 //System.out.println("qry2:"+dmpwscov);
r9=t9.executeQuery(dmpwscov);
Hashtable dmpwscov1=new Hashtable();
while(r9.next())
 {
   dmpwscov1.put(r9.getString(2)+"@"+r9.getString(3),r9.getString(1));
 }


 

	 if(dcode!=null && !dcode.equals("") && dcode.equals("00"))
		{
	  qry="select  dcode,dname from rws_district_tbl where dcode<>'16' order by dname";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("00"))
	{
	  qry="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	  }
  stmt1=conn.createStatement();
   
//System.out.println("qry2:"+qry);
  rs1=stmt1.executeQuery(qry);
  while(rs1.next())
  {
		String ast=""+cpws.get(rs1.getString(1));
		if(ast!=null && !ast.equals("") && !ast.equals("null")){} else{ ast="0";}
		String cpwshplain=""+cpwscov1.get(rs1.getString(1)+"@"+"PLAIN");
		if(cpwshplain!=null && !cpwshplain.equals("") && !cpwshplain.equals("null")){} else{ cpwshplain="0";}
		String cpwshsc=""+cpwscov1.get(rs1.getString(1)+"@"+"SC");
		if(cpwshsc!=null && !cpwshsc.equals("") && !cpwshsc.equals("null")){} else{ cpwshsc="0";}
		String cpwshst=""+cpwscov1.get(rs1.getString(1)+"@"+"ST");
		if(cpwshst!=null && !cpwshst.equals("") && !cpwshst.equals("null")){} else{ cpwshst="0";}

		String ast2=""+cpwspop1.get(rs1.getString(1));
		if(ast2!=null && !ast2.equals("") && !ast2.equals("null")){} else{ ast2="0";}
		  //pws
		String ast3=""+pws.get(rs1.getString(1));
		if(ast3!=null && !ast3.equals("") && !ast3.equals("null")){} else{ ast3="0";}
		String pwshplain=""+pwscov1.get(rs1.getString(1)+"@"+"PLAIN");
		if(pwshplain!=null && !pwshplain.equals("") && !pwshplain.equals("null")){} else{ pwshplain="0";}
		String pwshsc=""+pwscov1.get(rs1.getString(1)+"@"+"SC");
		if(pwshsc!=null && !pwshsc.equals("") && !pwshsc.equals("null")){} else{ pwshsc="0";}
		String pwshst=""+pwscov1.get(rs1.getString(1)+"@"+"ST");
		if(pwshst!=null && !pwshst.equals("") && !pwshst.equals("null")){} else{ pwshst="0";}

		String ast5=""+pwspop1.get(rs1.getString(1));
		if(ast5!=null && !ast5.equals("") && !ast5.equals("null")){} else{ ast5="0";}

//mpws
		String ast6=""+mpws.get(rs1.getString(1));
		if(ast6!=null && !ast6.equals("") && !ast6.equals("null")){} else{ ast6="0";}
		String mpwshplain=""+mpwscov1.get(rs1.getString(1)+"@"+"PLAIN");
		if(mpwshplain!=null && !mpwshplain.equals("") && !mpwshplain.equals("null")){} else{mpwshplain="0";}
		String mpwshsc=""+pwscov1.get(rs1.getString(1)+"@"+"SC");
		if(mpwshsc!=null && !mpwshsc.equals("") && !mpwshsc.equals("null")){} else{ mpwshsc="0";}
		String mpwshst=""+mpwscov1.get(rs1.getString(1)+"@"+"ST");
		if(mpwshst!=null && !mpwshst.equals("") && !mpwshst.equals("null")){} else{mpwshst="0";}

		String ast8=""+mpwspop1.get(rs1.getString(1));
		if(ast8!=null && !ast8.equals("") && !ast8.equals("null")){} else{ ast8="0";}

//hp
		String ast9=""+hmpws.get(rs1.getString(1));
		if(ast9!=null && !ast9.equals("") && !ast9.equals("null")){} else{ ast9="0";}
		String hphplain=""+hmpwspop1.get(rs1.getString(1)+"@"+"PLAIN");
		if(hphplain!=null && !hphplain.equals("") && !hphplain.equals("null")){} else{ hphplain="0";}
		String hphsc=""+hmpwspop1.get(rs1.getString(1)+"@"+"SC");
		if(hphsc!=null && !hphsc.equals("") && !hphsc.equals("null")){} else{ hphsc="0";}
		String hphst=""+hmpwspop1.get(rs1.getString(1)+"@"+"ST");
		if(hphst!=null && !hphst.equals("") && !hphst.equals("null")){} else{ hphst="0";}

		String ast11=""+hmpwscov1.get(rs1.getString(1));
		if(ast11!=null && !ast11.equals("") && !ast11.equals("null")){} else{ ast11="0";}
		//
//
//dp
		String ast12=""+dmpws.get(rs1.getString(1));
		if(ast12!=null && !ast12.equals("") && !ast12.equals("null")){} else{ ast12="0";}
		String dphplain=""+dmpwscov1.get(rs1.getString(1)+"@"+"PLAIN");
		if(dphplain!=null && !dphplain.equals("") && !dphplain.equals("null")){} else{ dphplain="0";}
		String dphsc=""+dmpwscov1.get(rs1.getString(1)+"@"+"SC");
		if(dphsc!=null && !dphsc.equals("") && !dphsc.equals("null")){} else{ dphsc="0";}
		String dphst=""+dmpwscov1.get(rs1.getString(1)+"@"+"ST");
		if(dphst!=null && !dphst.equals("") && !dphst.equals("null")){} else{ dphst="0";}

		String ast14=""+dmpwspop1.get(rs1.getString(1));
		if(ast14!=null && !ast14.equals("") && !ast14.equals("null")){} else{ ast14="0";}


%>
<tr>
<td class="rptValue" align="center"><%=sno++%></td>
<td class="rptValue"><%=rs1.getString(2)%></td>
<td class="rptValue" align="right"><%=ast%></td>
<td class="rptValue" align="right"><%=cpwshplain%></td>
<td class="rptValue" align="right"><%=cpwshsc%></td>
<td class="rptValue" align="right"><%=cpwshst%></td>
<%int chtot=Integer.parseInt(cpwshplain)+Integer.parseInt(cpwshsc)+Integer.parseInt(cpwshst);%>
<td class="rptValue" align="right"><%=chtot%></td>
<td class="rptValue" align="right"><%=ast2%></td>

<td class="rptValue" align="right"><%=ast3%></td>
<td class="rptValue" align="right"><%=pwshplain%></td>
<td class="rptValue" align="right"><%=pwshsc%></td>
<td class="rptValue" align="right"><%=pwshst%></td>
<%int phtot=Integer.parseInt(pwshplain)+Integer.parseInt(pwshsc)+Integer.parseInt(pwshst);%>
<td class="rptValue" align="right"><%=phtot%></td>
<td class="rptValue" align="right"><%=ast5%></td>

<td class="rptValue" align="right"><%=ast6%></td>
<td class="rptValue" align="right"><%=mpwshplain%></td>
<td class="rptValue" align="right"><%=mpwshsc%></td>
<td class="rptValue" align="right"><%=mpwshst%></td>
<%int mhtot=Integer.parseInt(mpwshplain)+Integer.parseInt(mpwshsc)+Integer.parseInt(mpwshst);%>
<td class="rptValue" align="right"><%=mhtot%></td>
<td class="rptValue" align="right"><%=ast8%></td>

<td class="rptValue" align="right"><%=ast9%></td>
<td class="rptValue" align="right"><%=hphplain%></td>
<td class="rptValue" align="right"><%=hphsc%></td>
<td class="rptValue" align="right"><%=hphst%></td>
<%int hhtot=Integer.parseInt(hphplain)+Integer.parseInt(hphsc)+Integer.parseInt(hphst);%>
<td class="rptValue" align="right"><%=hhtot%></td>
<td class="rptValue" align="right"><%=ast11%></td>

<td class="rptValue" align="right"><%=ast12%></td>
<td class="rptValue" align="right"><%=dphplain%></td>
<td class="rptValue" align="right"><%=dphsc%></td>
<td class="rptValue" align="right"><%=dphst%></td>
<%int dhtot=Integer.parseInt(dphplain)+Integer.parseInt(dphsc)+Integer.parseInt(dphst);%>
<td class="rptValue" align="right"><%=dhtot%></td>
<td class="rptValue" align="right"><%=ast14%></td>
</tr>
<%
	
//cpws
				ctot+=Integer.parseInt(""+ast);
				ccptot+=Integer.parseInt(""+cpwshplain);
				csctot+=Integer.parseInt(""+cpwshsc);
				csttot+=Integer.parseInt(""+cpwshst);
				cttot+=Integer.parseInt(""+chtot);
				cptot+=Integer.parseInt(""+ast2);
//pws
			ptot+=Integer.parseInt(""+ast3);
			ppptot+=Integer.parseInt(""+pwshplain);
			psctot+=Integer.parseInt(""+pwshsc);
			psttot+=Integer.parseInt(""+pwshst);
			pttot+=Integer.parseInt(""+phtot);
			pptot+=Integer.parseInt(""+ast5);

	//mpws
	        mtot+=Integer.parseInt(""+ast6);
			mmptot+=Integer.parseInt(""+mpwshplain);
			msctot+=Integer.parseInt(""+mpwshsc);
			msttot+=Integer.parseInt(""+mpwshst);
			mttot+=Integer.parseInt(""+mhtot);
			mptot+=Integer.parseInt(""+ast8);
//hp
			htot+=Integer.parseInt(""+ast9);
			hhptot+=Integer.parseInt(""+hphplain);
			hsctot+=Integer.parseInt(""+hphsc);
			hsttot+=Integer.parseInt(""+hphst);
			httot+=Integer.parseInt(""+hhtot);
			hptot+=Integer.parseInt(""+ast11);
//dp
				dtot+=Integer.parseInt(""+ast12);
				ddptot+=Integer.parseInt(""+dphplain);
				dsctot+=Integer.parseInt(""+dphsc);
				dsttot+=Integer.parseInt(""+dphst);
				dttot+=Integer.parseInt(""+dhtot);
				dptot+=Integer.parseInt(""+ast14);
}%>
<tr>
<td class="btext" align="right" colspan="2" >Total</td>

<td class="btext" align="right"><%=ctot%></td>
<td class="btext" align="right"><%=ccptot%></td>
<td class="btext" align="right"><%=csctot%></td>
<td class="btext" align="right"><%=csttot%></td>
<td class="btext" align="right"><%=cttot%></td>
<td class="btext" align="right"><%=cptot%></td>

<td class="btext" align="right"><%=ptot%></td>
<td class="btext" align="right"><%=pptot%></td>
<td class="btext" align="right"><%=psctot%></td>
<td class="btext" align="right"><%=psttot%></td>
<td class="btext" align="right"><%=pttot%></td>
<td class="btext" align="right"><%=pptot%></td>

<td class="btext" align="right"><%=mtot%></td>
<td class="btext" align="right"><%=mmptot%></td>
<td class="btext" align="right"><%=msctot%></td>
<td class="btext" align="right"><%=msttot%></td>
<td class="btext" align="right"><%=mttot%></td>
<td class="btext" align="right"><%=mptot%></td>

<td class="btext" align="right"><%=htot%></td>
<td class="btext" align="right"><%=hhptot%></td>
<td class="btext" align="right"><%=hsctot%></td>
<td class="btext" align="right"><%=hsttot%></td>
<td class="btext" align="right"><%=httot%></td>
<td class="btext" align="right"><%=hptot%></td>

<td class="btext" align="right"><%=dtot%></td>
<td class="btext" align="right"><%=ddptot%></td>
<td class="btext" align="right"><%=dsctot%></td>
<td class="btext" align="right"><%=dsttot%></td>
<td class="btext" align="right"><%=dttot%></td>
<td class="btext" align="right"><%=dptot%></td>

<%

}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
try
{
if(rs4 != null)
{
rs4.close();
}
if(st1 != null)
{
st1.close();
}
if(rs6 != null)
{
rs6.close();
}
if(st2 != null)
{
st2.close();
}
if(rs7 != null)
{
rs7.close();
}
if(st3 != null)
{
st3.close();
}
if(pwsrs != null)
{
pwsrs.close();
}
if(pwsst !=null)
{
pwsst.close();
}
if(pwspoprs != null)
{
pwspoprs.close();
}
if(pwspopst !=null)
{
pwspopst.close();
}
if(pwscovrs != null)
{
pwscovrs.close();
}
if(pwscovst !=null)
{
pwscovst.close();
}
if(r1 !=null)
{
r1.close();
}
if(t1 != null)
{
t1.close();
}
if(r2 !=null)
{
r2.close();
}
if(t2 != null)
{
t2.close();
}
if(r3 !=null)
{
r3.close();
}
if(t3 != null)
{
t3.close();
}
if(r4 !=null)
{
r4.close();
}
if(t4 != null)
{
t4.close();
}
if(r5 !=null)
{
r5.close();
}
if(t5 != null)
{
t5.close();
}
if(r6 !=null)
{
r6.close();
}
if(t6 != null)
{
t6.close();
}
if(r7 !=null)
{
r7.close();
}
if(t7 != null)
{
t7.close();
}
if(r8 !=null)
{
r8.close();
}
if(t8 != null)
{
t8.close();
}
if(r9 !=null)
{
r9.close();
}
if(t9 != null)
{
t9.close();
}
if(rs1 != null)
{
rs1.close();
}
if(stmt1 != null)
{
stmt1.close();
}
if( conn != null )
{
conn.close();
}



}
catch(Exception p)
{
p.printStackTrace();
}
}
%>
</tr>
</table>
</body>

<%@ include file="/commons/rws_footer.jsp" %>
  


