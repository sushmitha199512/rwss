<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname=request.getParameter("dname");
	session.setAttribute("dname",dname);
	String mname=request.getParameter("mname");
	session.setAttribute("mname",mname);
		String dcode=request.getParameter("district");
	session.setAttribute("dcode",dcode);
	String mcode=request.getParameter("mandal");
	session.setAttribute("mcode",mcode);
	String asset=request.getParameter("asset");
	session.setAttribute("asset",asset);
	String gtxidValueOld = "",gtxidValue="";
		String habValueOld = "",habValue="";

		Statement	stmth=null,stmth1=null ,stmth2=null,stmth3=null,stmt18=null,stmt44=null,stmt2=null,stmt3=null ,stmt1=null,stmt10=null,stmth4=null,stmt11=null ,stmth5=null,water=null,locality=null;
	ResultSet rsh=null,rsh1=null,rsh2=null,rsh3=null,rs18=null,rs44=null,rs2=null,rs3=null ,rs1=null,rs10=null,rs11=null,rs12=null,rsh4=null,rsh5=null,rswater=null ,rslocality=null;

	//System.out.println("asset:::"+asset);
String assetname="";
	if(asset.equals("01"))
	{
      assetname="PWS";
	}
	else if(asset.equals("02"))
	{
      assetname="MPWS";
	}
	else if(asset.equals("03"))
	{
      assetname="CPWS";
	}
	else if(asset.equals("09"))
	{
      assetname="DIRECT PUMPING";
	}
	session.setAttribute("assetname",assetname);
	int sno=1;
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
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a><a href="./rws_asurfaceohsr_xls.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Scheme Information Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Scheme Type:<%=assetname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext  rowspan = 2>HabitationCode/Name</td>
	<td class=btext   colspan=1>Scheme Details</td>
	<td class=btext  colspan=1>Scheme Covered Area Under</td>
	<td class=btext   colspan=2>Source Details</td>
		<td class=btext   colspan=2>As per TestReults</td>
		<td class=btext   colspan=2>If Unsafe</td>
	<%if(!asset.equals("09")){%>
	<td class=btext   colspan=1>Reservoirs</td>
	<!-- <td class=btext  colspan=4>Co-ordinates</td> -->
	
	<%}%>
	<td class=btext  colspan=1>Filters</td>
	<td class=btext  colspan=1>SS Tank</td>
	<td class=btext  colspan=1>Pumpset Details</td>
	</tr>
	<tr align=center>
	<td class=btext nowrap>Scheme Name/<br>Scheme Code/<br>Status/<br>Location</td>
	<td class=btext nowrap>(SC/ST<br>/PLAIN/MINORITY)</td>
	<!-- <td class=btext nowrap>SC Area</td>
	<td class=btext nowrap>ST Area</td>
	<td class=btext nowrap>Minority <br>Area</td> -->
	<td class=btext nowrap>Source Type/<br>Source Name/<br>Source Code/<br>Location</td>
	<td class=btext nowrap>Sample Collect Date</td>
	<td class=btext nowrap>Safe</td>
	<td class=btext nowrap>UnSafe</td>
	<td class=btext nowrap>Type of<br>Contamination</td>
	<td class=btext nowrap>Level of<br>Contamination</td>
	<%if(!asset.equals("09")){%>
	<td class=btext nowrap>Service Reservoirs/GLSR/<br>GLBR/OHSR/OHBR<br>/CISTERN/STANDPOST  </td>

	<%}%>
	<!-- sstank -->
	<td class=btext nowrap>Type/Capacity(MLD)/<br>Location</td>
<td class=btext nowrap>Type/Location</td>
	<td class=btext nowrap>Make/<br>Capacity(HP)/<br>Discharge(LPM)</td>
	
</tr>
             
<%
try
{
		String gqry=" select c.dname,c.mname,c.pname,c.panch_name,c.panch_code,a.asset_code,a.asset_name,decode(a.type_of_asset_code,'01','Pws','02','Mpws','03','Cpws','04','handpumps','09','Direct pumping','06','openwells')atype ,nvl(a.location,'-'),to_char(DATE_CREATION,'dd/mm/yyyy') ,nvl(asset_cost,0),nvl(decode(asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),'-')   from rws_asset_mast_tbl a,rws_complete_hab_view c,rws_asset_scheme_tbl s where s.asset_code=a.asset_code and substr(s.scheme_code,1,16)=c.panch_code and c.panch_code=a.hab_code and  substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' and a.asset_code is not null order by pname ,panch_name ";
	Statement	stmt8=conn.createStatement();
  System.out.println("gqryssssssssssss:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	if(rs8.isBeforeFirst())
   {
	while (rs8.next())
	{
	String space="";
	gtxidValue = ""+rs8.getString(3);
	habValue = ""+rs8.getString(5);
	if(!gtxidValue.equals(gtxidValueOld)){
	//System.out.println("gtxidValue::"+gtxidValue);
	//System.out.println("gtxidValueOld::"+gtxidValueOld);
	%>
	<%if(!asset.equals("09")){%>
<tr><td  colspan="39"  class=btext>Panchayat Name:<%=rs8.getString(3)%></td></tr>
<%}else{%>
<tr><td  colspan="32"  class=btext>Panchayat Name:<%=rs8.getString(3)%></td></tr>
<%}%>
<%}else{}%>
	 
	<tr>
	<td class="rptValue"><%=sno++%></td>
	<%if(habValue.equals(habValueOld)){%>
	<td>&nbsp;</td>
	<%}else{%>
	<td class="rptValue"><%=rs8.getString(5)%>/<br><%=rs8.getString(4)%></td>
	<%}%>
	<td class="rptValue" ><%=rs8.getString(8)%>/<br><%=rs8.getString(6)%>/<br><%=rs8.getString(12)%>/<br><%=rs8.getString(9)%></td>
	<td>
	<%String localityq="select LOCALITY_NAME  from   RWS_SC_ST_MIN_LOCALITY_TBL  where   hab_code='"+rs8.getString(5)+"'";
		locality=conn.createStatement();
		rslocality=locality.executeQuery(localityq);
		while(rslocality.next())
		{%>
	<%=rslocality.getString(1)%>
	
	<%}%>
	</td>
	<td class="rptValue">
	<%
		System.out.println("hab_code <><><><><>"+rs8.getString(5));

		String slatitude="",slongitude="",selevation="",swaypoint="";
		String glsrlatitude="",glsrlongitude="",glsrelevation="",glsrwaypoint="";
		String ohsrlatitude="",ohsrlongitude="",ohsrelevation="",ohsrwaypoint="";
		String cislatitude="",cislongitude="",ciselevation="",ciswaypoint="";
		String sslatitude="",sslongitude="",sselevation="",sswaypoint="";
		String filterlatitude="",filterlongitude="",filterelevation="",filterwaypoint="";
		String pumplatitude="",pumplongitude="",pumpelevation="",pumpwaypoint="";
        String wdate="";
		String source="select  decode(SOURCE_TYPE_CODE,'1','SUBSURFACE SOURCE ','2','SURFACE SOURCE ','3','RAIN WATER')stype ,Source_code,nvl(source_name,'_'),nvl(s.location,'-'),latitude,longitude,elevation,way_point from rws_source_tbl s  where  s.asset_code is not null and  asset_code='"+rs8.getString(6)+"'";
		System.out.println("source:"+source);
		stmt10=conn.createStatement();
		rs10=stmt10.executeQuery(source);
		while(rs10.next())
		{
		//System.out.println("in source::");
		%>
		<%=rs10.getString(1)%>/<br><%=rs10.getString(3)%>/<br><%=rs10.getString(2)%>/<br><%=rs10.getString(4)%><br>
		<%if(rs10.getString(5)==null){slatitude="-";}else{slatitude=rs10.getString(5);}%>
		<%if(rs10.getString(6)==null){slongitude="-";}else{slongitude=rs10.getString(6);}%>
		<%if(rs10.getString(7)==null){selevation="-";}else{selevation=rs10.getString(7);}%>
		<%if(rs10.getString(8)==null){swaypoint="-";}else{swaypoint=rs10.getString(8);}%>
		<b>Latitude:</b><%=slatitude%><b>Longitude:</b><%=slongitude%><br>
		<b>Elevation:</b><%=selevation%><b>Way Point:</b><%=swaypoint%><br>
		</td>
	<%String waterq="select to_char(SAMP_COLLECT_DATE,'dd/mm/yyyy') from RWS_WATER_SAMPLE_COLLECT_TBL  where source_code='"+rs10.getString(2)+"'";
			water=conn.createStatement();
				rswater=water.executeQuery(waterq);
				%>		<td><%
		while(rswater.next())
		{ if(rswater.getString(1)==null){wdate="-";}else{wdate=rswater.getString(1);} %>

		<%=wdate%>

		<%}}
		
		
			if(rswater!=null)rswater.close();
		if(water!=null)water.close();

		if(rs10!=null)rs10.close();
		if(stmt10!=null)stmt10.close();
%>
</td>
	<!-- source -->		<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<%if(!asset.equals("09")){%>

	<td class="rptValue">
	<%
		String glsr1="select  glsr_code,nvl(glsr_loc,'-'),GLSR_CAP_LTS,nvl(GLSR_NO_OF_FILLING,0) ,a.hab_code,latitude,longitude,elevation,way_point  from rws_ast_glsr_sc_param_tbl a where     asset_code='"+rs8.getString(6)+"'  ";
		stmt2=conn.createStatement();      
		//System.out.println("glsr:"+glsr1);
		rs2=stmt2.executeQuery(glsr1);
		while(rs2.next())
		{%>
		<b>GLSR:</b><%=rs2.getString(1)%><b>Location:</b><%=rs2.getString(2)%><br>
		<b>Capacity(LTS):</b><%=rs2.getString(3)%>	
		<b>No.of Fillings/Day:</b><%=rs2.getString(4)%><br><b>StandPost(Numbers):</b>&nbsp;&nbsp;&nbsp;<br>
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

	<%
		String ohsr2="select  ohsr_code,nvl(ohsr_loc,'-'),OHSR_CAP_LTS ,nvl(ohsr_no_of_filling,0),a.hab_code ,latitude,longitude,elevation,way_point from rws_ast_OHSR_sc_param_tbl a where   asset_code='"+rs8.getString(6)+"'  ";
		stmt44=conn.createStatement();
		//System.out.println("ohs2r:"+ohsr2);
		rs44=stmt44.executeQuery(ohsr2);
		while(rs44.next())
		{%>
		<b>OHSR:</b><%=rs44.getString(1)%><b>Location:</b><%=rs44.getString(2)%><br>
		<b>Capacity(LTS):</b><%=rs44.getString(3)%>	
		<b>No.of Fillings/Day:</b><%=rs44.getString(4)%><br>
		<%if(rs44.getString(6)==null){ohsrlatitude="-";}else{ohsrlatitude=rs44.getString(6);}%>
		<%if(rs44.getString(7)==null){ohsrlongitude="-";}else{ohsrlongitude=rs44.getString(7);}%>
		<%if(rs44.getString(8)==null){ohsrelevation="-";}else{ohsrelevation=rs44.getString(8);}%>
		<%if(rs44.getString(9)==null){ohsrwaypoint="-";}else{ohsrwaypoint=rs44.getString(9);}%>
		<b>Latitude:</b><%=ohsrlatitude%><b>Longitude:</b><%=ohsrlongitude%><br>
		<b>Elevation:</b><%=ohsrelevation%><b>Way Point:</b><%=ohsrwaypoint%><br>
		
		<%}

		if(rs44!=null)rs44.close();
		if(stmt44!=null)stmt44.close();
%>

<%
		String cisternq="select  cissc_code,nvl(cis_loc,'-'),CIS_CAP_LTS,nvl(CIS_HR_ALL,'0') ,latitude,longitude,elevation,way_point from rws_ast_cis_sc_param_tbl a  where    asset_code='"+rs8.getString(6)+"' ";
		//System.out.println("cisternq:"+cisternq);
		stmt18=conn.createStatement();
		rs18=stmt18.executeQuery(cisternq);
		while(rs18.next())
		{%>
		<b>Cistern:</b><%=rs18.getString(1)%><b>Location:</b><%=rs18.getString(2)%><br>
		<b>Capacity(LTS):</b><%=rs18.getString(3)%>	
		<b>No.of Fillings/Day:</b><%=rs18.getString(4)%><br>
		<%if(rs18.getString(5)==null){cislatitude="-";}else{cislatitude=rs18.getString(5);}%>
		<%if(rs18.getString(6)==null){cislongitude="-";}else{cislongitude=rs18.getString(6);}%>
		<%if(rs18.getString(7)==null){ciselevation="-";}else{ciselevation=rs18.getString(7);}%>
		<%if(rs18.getString(8)==null){ciswaypoint="-";}else{ciswaypoint=rs18.getString(8);}%>
		<b>Latitude:</b><%=cislatitude%><b>Longitude:</b><%=cislongitude%><br>
		<b>Elevation:</b><%=ciselevation%><b>Way Point:</b><%=ciswaypoint%><br>
		<%}
		if(rs18!=null)rs18.close();
		if(stmt18!=null)stmt18.close();
%>
</td>



	<!-- <td></td>
		<td></td>
			<td></td>	
			<td></td> -->
	<!-- <td class="rptValue" width="40%"><b>GLSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>OHSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>Cistern:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue" width="40%"><b>GLSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>OHSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>Cistern:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	
	<td class="rptValue" width="40%"><b>GLSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>OHSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>Cistern:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td class="rptValue" width="40%"><b>GLSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>OHSR:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br><b>Cistern:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
	<%}%>
<!-- sstank -->
<td>
<%String sstank="select nvl(CAPACITY_MCUM,'0'),nvl(ss.location,'-') ,latitude,longitude,elevation,way_point from RWS_AST_SS_SC_PARAM_TBL ss  where  asset_code='"+rs8.getString(6)+"'";
	//System.out.println("sstank:"+sstank);
	stmt11=conn.createStatement();
	rs11=stmt11.executeQuery(sstank);
	while(rs11.next())
	{
//	System.out.println("in ss tank::");
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
	if(stmt11!=null)stmt11.close();%>
	</td>

	<!-- <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td> -->
	<!-- Treatementplant -->
	<td><%String filter="select nvl(wtp_typw,'-'), nvl(ss.location,'-') ,ss.hab_code,latitude,longitude,elevation,way_point  from RWS_AST_WTP_SC_PARAM_TBL SS where SS.WTP_TYPW in('SSF','RSF')  and asset_code='"+rs8.getString(6)+"'";
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
	%>

	</td>
	
	<!-- <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td> -->
	<td>
	<%String pump="select  nvl(PUMP_MAKE,'-') ,nvl(PUMP_CPTY,'0') ,nvl(DESIGNED_LPM,'0') ,a.hab_code ,latitude,longitude,elevation,way_point  from rws_ast_subcomp_param_tbl a where  asset_code='"+rs8.getString(6)+"' ";
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
	<%gtxidValueOld = gtxidValue;
	habValueOld = habValue;%>
	</tr>
	<%}}else{ %>
		<script>
		alert(" No Matching data is Found- You are redirected to Previous page");
		document.location.href="rws_asurfaceohsr_frm.jsp";
		</script>
<%}}catch(Exception e)
		{
		System.out.println("error::"+e);
		}%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
