<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname1=request.getParameter("dname1");
	session.setAttribute("dname1",dname1);
	String dcode1=request.getParameter("district1");
	session.setAttribute("dcode1",dcode1);
	String asset1=request.getParameter("asset1");
	session.setAttribute("asset1",asset1);
	//System.out.println("asset:::"+asset1);
	System.out.println("dname:::"+dname1);
	//System.out.println("district1:::"+dcode1);
	String gtxidValueOld = "",gtxidValue="";
	String habValueOld = "",habValue="";
	String assetValueOld = "",assetValue="";
	String leadhabValueOld = "",leadhabValue="";
	String b1="",b2="",b3="",b4="";
	String a1="",a2="",a3="",a4="";
	String c1="",c2="",c3="",c4="";
	String cis1="",cis2="",cis3="",cis4="";
	String ss1="",ss2="";
	String ff1="",ff2="";
	String d1="",d2="",d3="",d4="";
	String t1="",t2="",t3="",t4="",t5="";
	String leadname="";
	Statement	stmth=null,stmth1=null ,stmth2=null,stmth3=null,stmt18=null,stmt44=null,stmt2=null,stmt3=null ,stmt1=null,stmt10=null,stmth4=null,stmt11=null ,stmth5=null,water=null,locality=null;
	ResultSet rsh=null,rsh1=null,rsh2=null,rsh3=null,rs18=null,rs44=null,rs2=null,rs3=null ,rs1=null,rs10=null,rs11=null,rs12=null,rsh4=null,rsh5=null,rswater=null,rslocality=null;

	String assetname="";
	if(asset1.equals("01"))
	{
      assetname="PWS";
	}
	else if(asset1.equals("02"))
	{
      assetname="MPWS";
	}
	else if(asset1.equals("03"))
	{
      assetname="CPWS";
	}
	else if(asset1.equals("09"))
	{
      assetname="DIRECT PUMPING";
	}
	session.setAttribute("assetname1",assetname);
	int sno=1,ah=1;
	String qry="";
	String lcode="";
	String lname="";
	//ResultSet rs10=null;
%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a><a href="./rws_cpwsGis_xls.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Scheme Information Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname1%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scheme Type:<%=assetname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<!-- <td class=btext  rowspan = 2>HabitationCode/Name</td> -->
	<td class=btext   colspan=2>Scheme Details</td>
	<td class=btext   colspan=2>Source Details</td>
	<td class=btext   colspan=1>SS Tank</td>
	<td class=btext   colspan=1>Treatment Plant</td>
	<td class=btext  colspan=1>Pumpset Details</td>
	<td class=btext  colspan=1>Covered Habitations<br>Under this Scheme</td>
	<td class=btext  colspan=1>Scheme Covered Area Under</td>
	<%if(!asset1.equals("09")){%>
	<td class=btext   colspan=1>Reservoirs</td>
	<!-- <td class=btext  colspan=4>Co-ordinates</td> -->
	<%}%>
	</tr>
	<tr align=center>
	<td class=btext nowrap>Scheme Name/<br>Scheme Code/<br>Status</td>
	<td class=btext nowrap>LeadHab/Name</td>
<td class=btext nowrap>Source Type/<br>Source Name/<br>Source Code/<br>Location/<br>SubSourceType</td>
<td class=btext nowrap>Sample Collect Date</td>
<td class=btext nowrap>Capacity(MLD)/Location</td>
<td class=btext nowrap>Type/Location</td>
<td class=btext nowrap>Make/<br>Capacity(HP)/<br>Discharge<br>(LPM)</td>
<!-- <td class=btext nowrap>Discharge<br>(LPM)</td> -->
<td class=btext nowrap>Hab Code/Hab Name</td>
<td class=btext nowrap>(SC/ST<br>/PLAIN/MINORITY)</td>
	<!-- <td class=btext nowrap>SC Area</td>
	<td class=btext nowrap>ST Area</td>
	<td class=btext nowrap>Minority <br>Area</td> -->
<%if(!asset1.equals("09")){%>
<td class=btext nowrap>Balancing Reservoirs /GLBR/OHSR<br>/GLSR/OHBR </td>

<%}%>
</tr>
           
<%
try
{
		String slatitude="",slongitude="",selevation="",swaypoint="";
		String glsrlatitude="",glsrlongitude="",glsrelevation="",glsrwaypoint="";
		String ohsrlatitude="",ohsrlongitude="",ohsrelevation="",ohsrwaypoint="";
		String cislatitude="",cislongitude="",ciselevation="",ciswaypoint="";
		String sslatitude="",sslongitude="",sselevation="",sswaypoint="";
		String filterlatitude="",filterlongitude="",filterelevation="",filterwaypoint="";
		String pumplatitude="",pumplongitude="",pumpelevation="",pumpwaypoint="";
		String glbrlatitude="",glbrlongitude="",glbrelevation="",glbrwaypoint="";
String wdate="";
	
String gqry=" select c.dname,c.mname,c.pname,c.panch_name,c.panch_code,a.asset_code,a.asset_name,decode(a.type_of_asset_code,'01','Pws','02','Mpws','03','Cpws','04','handpumps','09','Direct pumping','06','openwells')atype ,nvl(a.location,'-'),to_char(DATE_CREATION,'dd/mm/yyyy') ,nvl(asset_cost,0),nvl(decode(asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),'-')   from rws_asset_mast_tbl a,rws_complete_hab_view c,rws_asset_scheme_tbl s where s.asset_code=a.asset_code and substr(s.scheme_code,1,16)=c.panch_code and c.panch_code=a.hab_code and  substr(a.hab_code,1,2)='"+dcode1+"'  and type_of_asset_code='"+asset1+"' and a.asset_code is not null order by pname ,panch_name ";
	
	Statement	stmt8=conn.createStatement();
// System.out.println("gqryssssssssssss:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	if(rs8.isBeforeFirst())
   {
	while (rs8.next())
	{
  
			String space="";
		gtxidValue = ""+rs8.getString(3);
		if(!gtxidValue.equals(gtxidValueOld)){
	//System.out.println("gtxidValue::"+gtxidValue);
	//System.out.println("gtxidValueOld::"+gtxidValueOld);
	%>
	<tr><td  colspan="32"  class=btext>Panchayat Name:<%=rs8.getString(3)%></td></tr>
	<%}else{}%>
	<tr>
	<td class="rptValue"><%=sno++%></td>
<!-- 	<td class="rptValue"><%=rs8.getString(5)%>/<br><%=rs8.getString(4)%></td> -->
		<td class="rptValue" ><%=rs8.getString(8)%>/<br><%=rs8.getString(6)%>/<br><%=rs8.getString(12)%></td>
		<td class="rptValue"><%=rs8.getString(5)%>/<br><%=rs8.getString(4)%></td>
		<td>
       <%
		String source="select  decode(s.SOURCE_TYPE_CODE,'1','SUBSURFACE SOURCE ','2','SURFACE SOURCE ','3','RAIN WATER','4','TRADITIONAL','5','OTHERS','6','SUSTAINABILITY ')stype ,Source_code,nvl(source_name,'_'),nvl(s.location,'-'),s.hab_code,subsource_type_name,latitude,longitude,elevation,way_point from rws_source_tbl s ,rws_subsource_type_tbl c  where  s.asset_code is not null and s.subsource_type_code=c.subsource_type_code and s.source_type_code=c.source_type_code and asset_code='"+rs8.getString(6)+"'";
	
		stmt10=conn.createStatement();
        rs10=stmt10.executeQuery(source);
        while(rs10.next())
			{%>
	<%=rs10.getString(1)%>/<br><%=rs10.getString(3)%>/<br><%=rs10.getString(2)%>/<br><%=rs10.getString(4)%>/<br><%=rs10.getString(6)%><br>
		<%if(rs10.getString(7)==null){slatitude="-";}else{slatitude=rs10.getString(7);}%>
		<%if(rs10.getString(8)==null){slongitude="-";}else{slongitude=rs10.getString(8);}%>
		<%if(rs10.getString(9)==null){selevation="-";}else{selevation=rs10.getString(9);}%>
		<%if(rs10.getString(10)==null){swaypoint="-";}else{swaypoint=rs10.getString(10);}%>
		<b>Latitude:</b><%=slatitude%><b>Longitude:</b><%=slongitude%><br>
		<b>Elevation:</b><%=selevation%><b>Way Point:</b><%=swaypoint%><br>
	
		<%}
		
		if(rs10!=null)rs10.close();
		if(stmt10!=null)stmt10.close();
%>
</td>
<td></td>
	<td>
	<%
				
	String sstank="select nvl(CAPACITY_MCUM,'0'),nvl(ss.location,'-'),latitude,longitude,elevation,way_point  from RWS_AST_SS_SC_PARAM_TBL ss  where  asset_code='"+rs8.getString(6)+"'";
	//System.out.println("sstank:"+sstank);
	stmt11=conn.createStatement();
	rs11=stmt11.executeQuery(sstank);
	while(rs11.next())
	{
	//System.out.println("in ss tank::");
	%>
	<%=rs11.getString(1)%>/<br><%=rs11.getString(2)%><br>
	<%if(rs11.getString(3)==null){sslatitude="-";}else{sslatitude=rs11.getString(3);}%>
		<%if(rs11.getString(4)==null){sslongitude="-";}else{sslongitude=rs11.getString(4);}%>
		<%if(rs11.getString(5)==null){sselevation="-";}else{sselevation=rs11.getString(5);}%>
		<%if(rs11.getString(6)==null){sswaypoint="-";}else{sswaypoint=rs11.getString(6);}%>
		<b>Latitude:</b><%=sslatitude%><b>Longitude:</b><%=sslongitude%><br>
		<b>Elevation:</b><%=sselevation%><b>Way Point:</b><%=sswaypoint%><br>

	<%}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
	%>
		</td>
	<td>
	<%
			
	String filter="select nvl(wtp_typw,'-'), nvl(ss.location,'-') ,ss.hab_code,latitude,longitude,elevation,way_point from RWS_AST_WTP_SC_PARAM_TBL SS where SS.WTP_TYPW in('SSF','RSF') and asset_code='"+rs8.getString(6)+"'";
//	and hab_code='"+rsh5.getString(1)+"' and asset_code='"+rsh5.getString(2)+"'";
	//System.out.println("filter:"+filter);
	stmt1=conn.createStatement();
     rs1=stmt1.executeQuery(filter);
	while(rs1.next())
	{
	//System.out.println("in ssfilter::");
	%>
	<%=rs1.getString(1)%>/<br><%=rs1.getString(2)%><br>
		<%if(rs1.getString(4)==null){filterlatitude="-";}else{filterlatitude=rs1.getString(4);}%>
		<%if(rs1.getString(5)==null){filterlongitude="-";}else{filterlongitude=rs1.getString(5);}%>
		<%if(rs1.getString(6)==null){filterelevation="-";}else{filterelevation=rs1.getString(6);}%>
		<%if(rs1.getString(7)==null){filterwaypoint="-";}else{filterwaypoint=rs1.getString(7);}%>
		<b>Latitude:</b><%=filterlatitude%><b>Longitude:</b><%=filterlongitude%><br>
		<b>Elevation:</b><%=filterelevation%><b>Way Point:</b><%=filterwaypoint%><br>
	<%}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();

	//}
	//if(rsh5!=null)rsh5.close();
	//if(stmth5!=null)stmth5.close();
	%>
		</td>
		<td>
	<%
				
	String pump="select  nvl(PUMP_MAKE,'-') ,nvl(PUMP_CPTY,'0') ,nvl(DESIGNED_LPM,'0') ,a.hab_code ,latitude,longitude,elevation,way_point  from rws_ast_subcomp_param_tbl a where asset_code='"+rs8.getString(6)+"'";
//	hab_code='"+rsh4.getString(1)+"' and asset_code='"+rsh4.getString(2)+"' ";
	Statement	stmt6=conn.createStatement();
	//System.out.println("pump:"+pump);
	ResultSet rs6=stmt6.executeQuery(pump);
	while(rs6.next())
	{
	//System.out.println("in ss pumpsets::");
	%>
	<%=rs6.getString(1)%>/<%=rs6.getString(2)%>/<%=rs6.getString(3)%><br>
	<%if(rs6.getString(5)==null){pumplatitude="-";}else{pumplatitude=rs6.getString(5);}%>
		<%if(rs6.getString(6)==null){pumplongitude="-";}else{pumplongitude=rs6.getString(6);}%>
		<%if(rs6.getString(7)==null){pumpelevation="-";}else{pumpelevation=rs6.getString(7);}%>
		<%if(rs6.getString(8)==null){pumpwaypoint="-";}else{pumpwaypoint=rs6.getString(8);}%>
		<b>Latitude:</b><%=pumplatitude%><b>Longitude:</b><%=pumplongitude%><br>
		<b>Elevation:</b><%=pumpelevation%><br><b>Way Point:</b><%=pumpwaypoint%><br>
	<%}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	%>
		</td>
		<td>
	<%
		String habs=" select b.hab_code,b.asset_code,panch_name,mname from rws_asset_hab_tbl b ,rws_complete_hab_view c where  c.panch_code=b.hab_code and asset_code='"+rs8.getString(6)+"' ";
		//System.out.println("habs:"+habs);
stmth=conn.createStatement();
 rsh=stmth.executeQuery(habs);
	while(rsh.next())
		{
	%>
		<b>Mandal Name:</b><%=rsh.getString(4)%><br><%=rsh.getString(1)%>/<%=rsh.getString(3)%><br>
		
		<%}%>
	</td>
	<td>
	<%String localityq="select LOCALITY_NAME  from   RWS_SC_ST_MIN_LOCALITY_TBL  where   hab_code='"+rs8.getString(5)+"'";
		locality=conn.createStatement();
		rslocality=locality.executeQuery(localityq);
		while(rslocality.next())
		{%>
	<%=rslocality.getString(1)%>
	
	<%}%>
	</td>

	<%if(!asset1.equals("09")){%>
	<td>
	<%
		
		String glbr="select glbr_code,nvl(glbr_loc,'-'),GLBR_CAP_LTS,nvl(glbr_fill_hr,0) ,a.hab_code,latitude,longitude,elevation,way_point  from rws_ast_glbr_sc_param_tbl a  where   asset_code='"+rs8.getString(6)+"' ";
		//hab_code='"+rsh1.getString(1)+"' and  asset_code='"+rsh1.getString(2)+"' ";
			stmt3=conn.createStatement();
		//System.out.println("glbr:"+glbr);
	 rs3=stmt3.executeQuery(glbr);
		while(rs3.next())
		{%>
		<b>GLBR:</b><%=rs3.getString(1)%><br>
		<b>Location:</b><%=rs3.getString(2)%>
		<b>Capacity(LTS):</b><%=rs3.getString(3)%><br>
		<%if(rs3.getString(5)==null){glbrlatitude="-";}else{glbrlatitude=rs3.getString(5);}%>
		<%if(rs3.getString(6)==null){glbrlongitude="-";}else{glbrlongitude=rs3.getString(6);}%>
		<%if(rs3.getString(7)==null){glbrelevation="-";}else{glbrelevation=rs3.getString(7);}%>
		<%if(rs3.getString(8)==null){glbrwaypoint="-";}else{glbrwaypoint=rs3.getString(8);}%>
		<b>Latitude:</b><%=glbrlatitude%><b>Longitude:</b><%=glbrlongitude%><br>
		<b>Elevation:</b><%=glbrelevation%><b>Way Point:</b><%=glbrwaypoint%><br>
		
		<%}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();
		
		String cis="select  cissc_code,nvl(cis_loc,'-'),CIS_CAP_LTS,nvl(CIS_HR_ALL,'0') ,a.hab_code,latitude,longitude,elevation,way_point  from rws_ast_cis_sc_param_tbl a  where  asset_code='"+rs8.getString(6)+"'";
		//hab_code='"+rsh1.getString(1)+"'  and  asset_code='"+rsh1.getString(2)+"' ";
	//System.out.println("cis:"+cis);
	stmt18=conn.createStatement();
	 rs18=stmt18.executeQuery(cis);
		while(rs18.next())
		{%>
<b>Cistern:</b><%=rs18.getString(1)%><br><b>Location:</b><%=rs18.getString(2)%><b>Capacity(LTS):</b><%=rs18.getString(3)%><br>	
<%if(rs18.getString(5)==null){cislatitude="-";}else{cislatitude=rs18.getString(5);}%>
		<%if(rs18.getString(6)==null){cislongitude="-";}else{cislongitude=rs18.getString(6);}%>
		<%if(rs18.getString(7)==null){ciselevation="-";}else{ciselevation=rs18.getString(7);}%>
		<%if(rs18.getString(8)==null){ciswaypoint="-";}else{ciswaypoint=rs18.getString(8);}%>
		<b>Latitude:</b><%=cislatitude%><b>Longitude:</b><%=cislongitude%><br>
		<b>Elevation:</b><%=ciselevation%><b>Way Point:</b><%=ciswaypoint%><br>
<%}

		if(rs18!=null)rs18.close();
		if(stmt18!=null)stmt18.close();
		
		String ohsr="select  ohsr_code,nvl(ohsr_loc,'-'),OHSR_CAP_LTS ,nvl(ohsr_no_of_filling,0),a.hab_code,latitude,longitude,elevation,way_point  from rws_ast_OHSR_sc_param_tbl a where  asset_code='"+rs8.getString(6)+"'";
	//	hab_code='"+rsh1.getString(1)+"'  and asset_code='"+rsh1.getString(2)+"'  ";
	stmt44=conn.createStatement();
	//System.out.println("ohsr:"+ohsr);
 rs44=stmt44.executeQuery(ohsr);
	while(rs44.next())
		{%>
<b>OHSR:</b><%=rs44.getString(1)%><br><b>Location:</b><%=rs44.getString(2)%><b>Capacity(LTS):</b><%=rs44.getString(3)%><br>	
<%if(rs44.getString(6)==null){ohsrlatitude="-";}else{ohsrlatitude=rs44.getString(6);}%>
		<%if(rs44.getString(7)==null){ohsrlongitude="-";}else{ohsrlongitude=rs44.getString(7);}%>
		<%if(rs44.getString(8)==null){ohsrelevation="-";}else{ohsrelevation=rs44.getString(8);}%>
		<%if(rs44.getString(9)==null){ohsrwaypoint="-";}else{ohsrwaypoint=rs44.getString(9);}%>
		<b>Latitude:</b><%=ohsrlatitude%><b>Longitude:</b><%=ohsrlongitude%><br>
		<b>Elevation:</b><%=ohsrelevation%><b>Way Point:</b><%=ohsrwaypoint%><br>


<%}
		
		if(rs44!=null)rs44.close();
		if(stmt44!=null)stmt44.close();
		String glsr="select  glsr_code,nvl(glsr_loc,'-'),GLSR_CAP_LTS,nvl(GLSR_NO_OF_FILLING,0) ,a.hab_code,latitude,longitude,elevation,way_point   from rws_ast_glsr_sc_param_tbl a where asset_code='"+rs8.getString(6)+"'";
		//hab_code='"+rsh1.getString(1)+"'  and  asset_code='"+rsh1.getString(2)+"'  ";
	stmt2=conn.createStatement();      
	//System.out.println("glsr:"+glsr);
 rs2=stmt2.executeQuery(glsr);
while(rs2.next())
		{%>
<b>GLSR:</b><%=rs2.getString(1)%><br><b>Location:</b><%=rs2.getString(2)%><b>Capacity(LTS):</b><%=rs2.getString(3)%><br>		
<%if(rs2.getString(6)==null){glsrlatitude="-";}else{glsrlatitude=rs2.getString(6);}%>
		<%if(rs2.getString(7)==null){glsrlongitude="-";}else{glsrlongitude=rs2.getString(7);}%>
		<%if(rs2.getString(8)==null){glsrelevation="-";}else{glsrelevation=rs2.getString(8);}%>
		<%if(rs2.getString(9)==null){glsrwaypoint="-";}else{glsrwaypoint=rs2.getString(9);}%>
		<b>Latitude:</b><%=glsrlatitude%><b>Longitude:</b><%=glsrlongitude%><br>
		<b>Elevation:</b><%=glsrelevation%><b>Way Point:</b><%=glsrwaypoint%><br>

<%}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	%>
</td>
		<%}%>
	</tr>
		<%gtxidValueOld = gtxidValue;
		%>
	
	<%}}else{ %>
		<script>
		alert(" No Matching data is Found- You are redirected to Previous page");
		document.location.href="rws_asurfaceohsr_frm.jsp";
		</script>
<%}}catch(Exception e)
		{
		System.out.println("error::"+e);
		}

		%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>
</p>

  
