<%@ include file ="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%	
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,sms=null,sms1=null,st9=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rss=null,rss1=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="",query1=null,currentYear=null,qu1=null,qu2=null,qu3=null;
	int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0,j=0,Count1=0,Count2=0;
    String dCode;
    String mCode;
    String pCode;
    String vCode;
    String habCode;
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String panchayat=request.getParameter("panchayat");
	String village=request.getParameter("village");
	String hab=request.getParameter("hab");
 //String fdate=(String)session.getAttribute("FDate");
 String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");
if(district==null && mandal==null && panchayat==null)
{
   //dCode=String.valueOf(session.getAttribute("dcode"));
 // mCode=String.valueOf(session.getAttribute("mCode")); 
	dCode=request.getParameter("dcode");
	mCode=request.getParameter("mcode");
	pCode=request.getParameter("pcode");
	vCode=request.getParameter("vcode");
	habCode=request.getParameter("hcode");
	session.setAttribute("pCode",pCode); 
	session.setAttribute("vCode",vCode); 
	session.setAttribute("habCode",habCode); 
	String pName=request.getParameter("pname");
	session.setAttribute("pName",pName); 
}
else
{
dCode=district;
mCode = mandal;
pCode= panchayat;
vCode=village;
habCode=hab;
}
	String dnames=(String)session.getAttribute("dName");
	String mnames=(String)session.getAttribute("mName");
	String vnames=request.getParameter("vName");
//// //// System.out.println("dname:"+dnames);
//// //// System.out.println("mname:"+mnames);


session.setAttribute("dName1",dnames);
session.setAttribute("mName1",mnames);




String s=request.getParameter("start");

int slno=0;
try{
	 if(fdate!=null && !fdate.equals("0") )
	{
		a1 = " and status_date ='" + fdate +"' ";
	}
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
stmt=conn.createStatement();
query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null ORDER BY to_char(status_date,'yyyy') ";

rs2=st7.executeQuery(query1);
while(rs2.next())
	{
   // currentYear=rs2.getString(1);
	}
rs2.close();
st7.close();
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);
//System.out.println("currentyear:"+currentYear);
// System.out.println("fdate:"+fdate.substring(7,11));

 	if(fdate.substring(7,11).equals(currentYear))
	{
        qu1="select distinct d.dcode,d.dname,m.mcode,m.mname, p.pcode,p.pname,v.vcode,v.vname, pr.panch_name, nvl(h.coverage_status,'--'),pr.panch_code,h.census_plain_popu,h.census_sc_popu,h.census_st_popu, h.exist_water_level,h.existing_sources_no,h.safe_sources_no,(nvl(hs.HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(hs.PWS_UNSAFE_SUPPLY,'0')+nvl(hs.MPWS_UNSAFE_SUPPLY,'0')+nvl(hs.OWS_OTH_SUPPLY,'0')+nvl(hs.PONDS_OTH_SUPPLY,'0')+nvl(hs.SHP_DK_SUPPLY,'0')+nvl(hs.OTHERS_SUPPLY,'0')) as Unsafe, (nvl(hs.HPS_OTH_SUPPLY,'0')+nvl(hs.PWS_SUPPLY,'0')+nvl(hs.MPWS_SUPPLY,'0')+nvl(hs.cpws_supply,'0')+nvl(hs.OTHERS_SUPPLY_SAFE,'0')) as Safe from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h,rws_hab_supply_status_tbl hs  where d.dcode=m.dcode and m.dcode=p.dcode and "+
		 "m.mcode=p.mcode and  "+
		 "p.pcode=v.pcode and  "+
		 "p.dcode=v.dcode and  "+
		 "v.mcode=m.mcode and  "+
		 "substr(pr.panch_code,1,2)=d.dcode and  "+
		 "substr(pr.panch_code,6,2)=m.mcode and  "+
		 "substr(pr.panch_code,8,3)=v.vcode and  "+
		 "substr(pr.panch_code,13,2)=p.pcode and  "+
		 "substr(h.hab_code,1,2)=d.dcode and  "+
		 "substr(h.hab_code,6,2)=m.mcode and  "+
		 "substr(h.hab_code,8,3)=v.vcode and  "+
		 "substr(h.hab_code,13,2)=p.pcode and h.hab_code=hs.hab_code and hs.hab_code=pr.panch_code and  "+
		 " substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' and  substr(h.hab_code,8,3)='"+vCode+"' and  substr(h.hab_code,1,16)='"+habCode+"'  and status_date ='"+fdate+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by d.dcode,m.mcode,p.pcode,v.vcode,pr.panch_code";
        
      //  System.out.println("QU1: IN CURRENT"+qu1);
	}
	else
	{
		 qu1="select distinct d.dcode,d.dname,m.mcode,m.mname, p.pcode,p.pname,v.vcode,v.vname, pr.panch_name, nvl(h.coverage_status,'--'),pr.panch_code,h.census_plain_popu,h.census_sc_popu,h.census_st_popu, h.exist_water_level,h.existing_sources_no,h.safe_sources_no,(nvl(hs.HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(hs.PWS_UNSAFE_SUPPLY,'0')+nvl(hs.MPWS_UNSAFE_SUPPLY,'0')+nvl(hs.OWS_OTH_SUPPLY,'0')+nvl(hs.PONDS_OTH_SUPPLY,'0')+nvl(hs.SHP_DK_SUPPLY,'0')+nvl(hs.OTHERS_SUPPLY,'0')) as Unsafe, (nvl(hs.HPS_OTH_SUPPLY,'0')+nvl(hs.PWS_SUPPLY,'0')+nvl(hs.MPWS_SUPPLY,'0')+nvl(hs.cpws_supply,'0')+nvl(hs.OTHERS_SUPPLY_SAFE,'0')) as Safe from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_dir_his_tbl h,rws_hab_supply_status_tbl hs  where d.dcode=m.dcode and m.dcode=p.dcode and "+
		 "m.mcode=p.mcode and  "+
		 "p.pcode=v.pcode and  "+
		 "p.dcode=v.dcode and  "+
		 "v.mcode=m.mcode and  "+
		 "substr(pr.panch_code,1,2)=d.dcode and  "+
		 "substr(pr.panch_code,6,2)=m.mcode and  "+
		 "substr(pr.panch_code,8,3)=v.vcode and  "+
		 "substr(pr.panch_code,13,2)=p.pcode and  "+
		 "substr(h.hab_code,1,2)=d.dcode and  "+
		 "substr(h.hab_code,6,2)=m.mcode and  "+
		 "substr(h.hab_code,8,3)=v.vcode and  "+
		 "substr(h.hab_code,13,2)=p.pcode and h.hab_code=hs.hab_code and hs.hab_code=pr.panch_code and  "+
		 " substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' and  substr(h.hab_code,8,3)='"+vCode+"' and  substr(h.hab_code,1,16)='"+habCode+"'  and status_date ='"+fdate+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by d.dcode,m.mcode,p.pcode,v.vcode,pr.panch_code";
		// System.out.println("QU1: IN HISTORY"+qu1);
	}
	   
 
	r6=st6.executeQuery(qu1);	
	
	r6.last();
    Count = r6.getRow();
  //  System.out.println("Count :"+Count);
	r6.beforeFirst();
	  
	r6.next();

	
%>
<html>
<head>
<title> WaterSoft </title>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><a href="javascript:history.back(-1)">Back|</a><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
<tr><a href="javascript:history.back(-1)">Back|</a><a href="/pred/rws_login_frm.jsp">Home</td></tr>
<%} %>


	</table>
</caption>
<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7" width="1%" height="1%">
			<font color="ffffff">Habitation Status-Resource Report </font></td>
	</tr>
<%if(fdate!=null && !fdate.equals("0") )
	{%>

		<tr><td class="textborder" align="center">
			<font size=2>Status As On : </font><font color=#F2A80D> <%=fdate %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font>

	<% }

	%>
	

<font color="navy">District: <%=r6.getString(2) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<font color="navy">Mandal: <%=r6.getString(4) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<font color="navy">Panchayat: <%=r6.getString(6) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<font color="navy">village: <%=r6.getString(8) %></font></td>
</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	
	String st=request.getParameter("start");
// //System.out..println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr>	
		 <td class=btext rowspan=2 >SNO</td>
	     <td class=btext rowspan=2>Habitation Name</td>
		 <td class=btext rowspan=2>Habitation Code</td>
 		 <td class=btext rowspan=2>Coverage Status</td>
		 <td class=btext rowspan=2>Lpcd(Safe Supply)</td>
		 <td class=btext colspan=5 rowspan=1 align="center">Phycial&nbsp;progress</td>
		 <td class=btext colspan=2 rowspan=1 align="center">Financial&nbsp;progress(amt in lakhs)</td>
		 <td class=btext rowspan=2>Schools</td> 
 		<!--  <td class=btext rowspan=2>Sources</td> -->
		 <td class=btext rowspan=2>Census Plain Pop</td>
		 <td class=btext rowspan=2>Census SC Pop</td>
		 <td class=btext rowspan=2>Census ST Pop</td>
		<!--  <td class=btext rowspan=2>No Of Exisiting Sources</td> -->
		<!--  <td class=btext rowspan=2>No Of  Safe Sources</td>
		 <td class=btext rowspan=2>Total Water Supply (Unsafe)</td>
		 <td class=btext rowspan=2>Total Water Supply (Safe)</td> -->
		</tr>	
		 <tr>
			<td class="btext" >NO Of HPS </td>
			<td class="btext" >NO Of CPWS </td>
			<td class="btext">NO Of PWS </td>
			<td class="btext">NO Of MPWS </td>
			<td class="btext">NO Of DP </td>
			<td class="btext">Assets </td>
			<td class="btext">Works </td>
		 </tr>

<%// //// System.out.println("ddddd");	
r6=st6.executeQuery(qu1);	
if(Count!=0){
	while(r6.next())
	{
	 // //// System.out.println("wwwww");
			
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=++start%> </td>
			<td class="rptValue" nowrap><%=r6.getString(9) %></td> 
			<td class="rptValue" nowrap><%=r6.getString(11) %></td> 
			<td class="rptValue"><%=r6.getString(10) %></td>
			<td class="rptValue"  align="right"><%=r6.getString(15) %></td>
			<%
int hpcount=0,shpcount=0,pwscount=0,mpwscount=0,cpwscount=0,dpcount=0;
String hpCountQuery=" select count(*) from RWS_HP_SUBCOMP_PARAM_TBL where substr(HP_CODE,1,16)='"+r6.getString(11)+"' and substr(asset_code,7,2)='04'";
st9=conn.createStatement();
r7=st9.executeQuery(hpCountQuery);
if(r7.next()){
	hpcount=r7.getInt(1);	
}
st9.close();
r7.close();

String shpCountQuery=" select count(*) from RWS_SHALLOWHANDPUMPS_TBL where hab_code='"+r6.getString(11)+"'";
st9=conn.createStatement();
r7=st9.executeQuery(shpCountQuery);
if(r7.next()){
	shpcount=r7.getInt(1);	
}
st9.close();
r7.close();

String pwsCountQuery=" select count(*) from rws_source_tbl where hab_code='"+r6.getString(11)+"' and substr(asset_code,7,2)='01'";
st9=conn.createStatement();
r7=st9.executeQuery(pwsCountQuery);
if(r7.next()){
	pwscount=r7.getInt(1);	
}
st9.close();
r7.close();

String cpwsCountQuery=" select count(*) from rws_source_tbl where hab_code='"+r6.getString(11)+"' and substr(asset_code,7,2)='02'";
st9=conn.createStatement();
r7=st9.executeQuery(cpwsCountQuery);
if(r7.next()){
	mpwscount=r7.getInt(1);	
}
st9.close();
r7.close();
String mpwsCountQuery=" select count(*) from rws_source_tbl where hab_code='"+r6.getString(11)+"' and substr(asset_code,7,2)='03'";
st9=conn.createStatement();
r7=st9.executeQuery(mpwsCountQuery);
if(r7.next()){
	cpwscount=r7.getInt(1);	
}
st9.close();
r7.close();

String dpCountQuery=" select count(*) from rws_source_tbl where hab_code='"+r6.getString(11)+"' and substr(asset_code,7,2)='09'";
st9=conn.createStatement();
r7=st9.executeQuery(dpCountQuery);
if(r7.next()){
	dpcount=r7.getInt(1);	
}
st9.close();
r7.close();
%>
<%if(hpcount+shpcount>0){ %>
<td class="rptValue" align="right"><a href="./rws_assets_resource_out_rpt1.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="HP"%>"><%=hpcount+shpcount%></a></td>
<%}else{ %>
<td class="rptValue" align="right">--</td>
<%}if(cpwscount>0){ %>
<td class="rptValue" align="right"><a href="./rws_assets_resource_out_rpt1.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="CPWS"%>"><%=cpwscount%></a></td>
<%}else{ %>
<td class="rptValue" align="right">--</td>
<%}if(pwscount>0){ %>
<td class="rptValue" align="right"><a href="./rws_assets_resource_out_rpt1.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="PWS"%>"><%=pwscount%></a></td>
<%}else{ %>
<td class="rptValue" align="right">--</td>
<%}if(mpwscount>0){ %>
<td class="rptValue" align="right"><a href="./rws_assets_resource_out_rpt1.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="MPWS"%>"><%=mpwscount%></a></td>
<%}else{ %>
<td class="rptValue" align="right">--</td>
<%}if(dpcount>0){ %>
<td class="rptValue" align="right"><a href="./rws_assets_resource_out_rpt1.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="DP"%>"><%=dpcount%></a></td>
<%}else{ %>
<td class="rptValue" align="right">--</td>
<%} %>
  <%
	//if(r1!=null) r1.close();
	//if(st1!=null) st1.close();
	String costqry="select (select  sum(b.asset_cost) from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code  and   d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dCode+"' and substr(d.panch_code,6,2)='"+mCode+"' and substr(d.panch_code,13,2)='"+pCode+"' and substr(d.panch_code,8,3)='"+vCode+"' and substr(d.panch_code,1,16)='"+r6.getString(11)+"' and  b.type_of_asset_code=a.type_of_asset_code) a,(	select sum(sanction_amount) from rws_work_admn_tbl w,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where h.hab_code=pr.panch_code and w.lead_habitation=pr.panch_code and substr (pr.panch_code,1,2)='"+dCode+"'  and substr (pr.panch_code,6,2)='"+mCode+"' and substr(pr.panch_code,13,2)='"+pCode+"' and substr (pr.panch_code,8,3)='"+vCode+"'  and w.lead_habitation='"+r6.getString(11)+"' and w.work_id not in (select asset_code from rws_asset_mast_tbl))b from dual";
	//System.out.println("costqry:"+costqry);
	rs=stmt.executeQuery(costqry);
	while(rs.next()){
		if(rs.getString(1)!=null && !rs.getString(1).equals("0")) { %>
	<td class="rptValue"  align="right"><a href="./rws_assets_resource_out_rpt.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="Assets"%>"><%=rs.getString(1)%></a></td>
	<%} else{%>
		<td class="rptValue"  align="right">-</td>	
	<%} if(rs.getString(2)!=null && !rs.getString(2).equals("0")) {%>
	<td class="rptValue"  align="right"><a href="./rws_assets_resource_out_rpt.jsp?code=<%="Works"%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>"><%=rs.getString(2)%></a></td>
	<%}else {%>
<td class="rptValue"  align="right">-</td>

<%}
}
if(rs!=null){rs.close();}
if(stmt!=null){stmt.close();}
String qschool="select  count(*) from rws_school_master_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code and substr (v.panch_code,1,2)='"+dCode+"' and substr(v.panch_code,6,2)='"+mCode+"'  and substr(v.panch_code,13,2)='"+pCode+"' and substr (v.panch_code,8,3)='"+vCode+"' and substr(v.panch_code,1,16)='"+r6.getString(11)+"' " ;

st2=conn.createStatement();
//System.out.println("school qry:"+qschool);
rs2=st2.executeQuery(qschool);
while(rs2.next()) 
{
	if(!rs2.getString(1).equals("0")){
	%>
	<td class="rptValue"  align="right"><a href="./rws_assets_resource_out_rpt.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=
	<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="school"%>"><%=rs2.getString(1)%></a></td>

 <% }
 else
	{%>
<td class="rptValue"  align="right"><%="-"%></td>
<%}
  }
   if(rs2!=null){ rs2.close();}
 if(st2!=null) {st2.close();}

 String qsource="select  count(*) from rws_source_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code and substr (v.panch_code,1,2)='"+dCode+"' and substr(v.panch_code,6,2)='"+mCode+"'  and substr(v.panch_code,13,2)='"+pCode+"' and substr (v.panch_code,8,3)='"+vCode+"' and substr(v.panch_code,1,16)='"+r6.getString(11)+"' " ;

st3=conn.createStatement();
//System.out.println("source qry:"+qsource);
rs3=st3.executeQuery(qsource);
while(rs3.next()) 
{
	if(!rs3.getString(1).equals("0")){
	%>
	<%-- <td class="rptValue"  align="right"><a href="./rws_assets_resource_out_rpt.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=
	<%=r6.getString(11)%>&hname=<%=r6.getString(9)%>&code=<%="source"%>"><%=rs3.getString(1)%></a></td> --%>

 <% }
 else
	{%>
<td class="rptValue"  align="right"><%="-"%></td>
<%}
  
 }
 if(rs3!=null){ rs3.close();}
 if(st3!=null) {st3.close();}

	 
%>
			
			<td class="rptValue"  align="right"><%=r6.getString(12) %> </td>
			<td class="rptValue"  align="right"><%=r6.getString(13) %> </td>
			<td class="rptValue"  align="right"><%=r6.getString(14) %> </td>
			<%-- <td class="rptValue"  align="right"><%=r6.getString(16) %> </td> --%>
		<%-- 	<td class="rptValue"  align="right"><%=r6.getString(17) %> </td>
			<td class="rptValue"  align="right"><%=r6.getString(18) %> </td>
			<td class="rptValue"  align="right"><%=r6.getString(19) %> </td> --%>
</tr>	
<%}
	if(r6!=null) {r6.close();}
	if(st6!=null) {st6.close();}
}else { %>
<%="There are no Records"%>
<%}

}catch(Exception e)
{e.printStackTrace();}
finally
{
	conn.close();
}
%>
</table>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>