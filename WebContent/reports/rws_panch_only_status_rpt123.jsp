<%@ include file ="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
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
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String panchayat=request.getParameter("panchayat");
	String village=request.getParameter("village");
// String fdate=(String)session.getAttribute("FDate");
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
	session.setAttribute("pCode",pCode); 
   session.setAttribute("vCode",vCode); 
	 String pName=request.getParameter("pname");
	session.setAttribute("pName",pName); 
}
else
{
dCode=district;
mCode = mandal;
pCode= panchayat;
vCode=village;
}
	String dnames=(String)session.getAttribute("dName");
	String mnames=(String)session.getAttribute("mName");
	String vnames=request.getParameter("vName");
//// System.out.println("dname:"+dnames);
//// System.out.println("mname:"+mnames);


session.setAttribute("dName1",dnames);
session.setAttribute("mName1",mnames);




String s=request.getParameter("start");

int slno=0;
try{
	 if(fdate!=null && !fdate.equals("0") )
	{
		a1 =  " and status_date ='" + fdate +"' ";
	}
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
rs2=st7.executeQuery(query1);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}
/*java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);*/

 	if(fdate.substring(7,11).equals(currentYear))
	{
		qu1 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vname,h.panch_name,nvl(hd.coverage_status,'--'),h.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' and  substr(h.hab_code,8,3)='"+vCode+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vname,h.panch_name,hd.coverage_status,h.panch_code";
	}
	else
	{
		qu1 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vname,h.panch_name,nvl(hd.coverage_status,'--'),h.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' and  substr(h.hab_code,8,3)='"+vCode+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vname,h.panch_name,hd.coverage_status,h.panch_code";
//       qu1 = "SELECT pr.panch_name,nvl(coverage_status,'--'),pr.panch_code  from rws_panchayat_raj_tbl pr,rws_habitation_dir_his_tbl h where pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and  substr(h.hab_code,13,2)='"+pCode+"' and status_date ='" + fdate +"' and h.coverage_status is not null and coverage_status <> 'UI' order by coverage_status";
	}
	// System.out.println("QU1:"+qu1);
	//qu1 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,nvl(hd.coverage_status,'--'),h.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,hd.coverage_status,h.panch_code";
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	

	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	r6.beforeFirst();
	r6.next();
	
%>
<html>
<head>
<script>
	// window.history.forward(1);
</script>
<title> WaterSoft </title>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="../home.jsp">Home|</a>
			<a href="javascript:history.back(-1)">Back&nbsp;</a>
				<!--<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation Status-Resource Report</font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<%if(fdate!=null && !fdate.equals("0") )
	{%>
<tr><td></td>
		<td class="textborder" align="center">
			<font size=2>Status As On : </font><font color=#F2A80D> <%=fdate %> </font></td>
	</tr>
	<% }%>
	<tr><% if(!dCode.equals("51")) {%>
	<td align="center" class="btext"><font color="navy">District: <%=r6.getString(2)%><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="btext"><font color="navy">Mandal: <%=r6.getString(4) %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>

<td align="center" class="btext"><font color="navy">Panchayat: <%=r6.getString(6)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><font color="navy">Village: <%=r6.getString(7)%></font></td>
</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// ////// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr>	
	
		<td class="btext" >S.NO.</td>
		<td class="btext" >Habitation</td>
		<td class="btext" >Coverage Status</td> 
		<td class="btext" >Assets</td> 
		<td class="btext" >Works</td> 
</tr>	

<%	r6.beforeFirst(); 
if(Count!=0){
	while(r6.next())
	{
			
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=++start%> </td>
			<td class="rptValue"><%=r6.getString(8) %> </td> 
			<td class="rptValue"><%=r6.getString(9) %> </td>
			<% 
             
 qu2="select  distinct  count(*) from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code  and   d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dCode+"' and substr(d.panch_code,6,2)='"+mCode+"' and substr(d.panch_code,13,2)='"+pCode+"' and substr(d.panch_code,8,3)='"+vCode+"' and substr(d.panch_code,1,16)='"+r6.getString(10)+"' and  b.type_of_asset_code=a.type_of_asset_code";
//// System.out.println("QU2:"+qu2);

		
		r7=st8.executeQuery(qu2);
		r7.last();
	    Count2 = r7.getRow();
	    r7.beforeFirst();
		while(r7.next())
		{
			if(!r7.getString(1).equals("0"))
			{
				
		 %>
<td class="rptValue"><a href="./rws_assets123.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(10)%>&hname=<%=r6.getString(1)%>&code=<%="Assets"%>"><%=r7.getString(1)%></a></td>

	<%
			}
	else{%>
<td class="rptValue"><%="-"%></td>
<%}
	}
	  if(Count2==0)
		{%>
<td class="rptValue"><%="-"%></td>

<%}
 qu3="select distinct count(*) from rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and substr(pr.panch_code,1,2)='"+dCode+"' and  substr(pr.panch_code,6,2)='"+mCode+"' and substr(pr.panch_code,13,2)='"+pCode+"' and substr(pr.panch_code,8,3)='"+vCode+"' and substr(pr.panch_code,1,16)='"+r6.getString(10)+"'";
  //// System.out.println("QU3:"+qu3);
    r1=st1.executeQuery(qu3);
	r1.last();
	Count1 = r1.getRow();
	r1.beforeFirst();
		
		while(r1.next())
		{
			if(!r1.getString(1).equals("0"))
			{
				
		 %>
<td class="rptValue"><a href="./rws_assets123.jsp?code=<%="Works"%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(10)%>&hname=<%=r6.getString(1)%>"><%=r1.getString(1)%>
</a></td>

	<% }
	else{%>
<td class="rptValue"><%="-"%></td>
<%}
	}
	  if(Count1==0)
		{%>
<td class="rptValue"><%="-"%></td>

<%}
%>
</tr>	
<%}
}else { // ////// System.out.println("There are no Recoreds");%>
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
</td></tr>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>