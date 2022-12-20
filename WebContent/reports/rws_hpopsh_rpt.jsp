<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
	String dname=request.getParameter("dname");
	session.setAttribute("dname",dname);
	String mname=request.getParameter("mname");
	session.setAttribute("mname",mname);
	String aname=request.getParameter("aname");
	session.setAttribute("aname",aname);
	String dcode=request.getParameter("district");
	session.setAttribute("dcode",dcode);
	String mcode=request.getParameter("mandal");
	session.setAttribute("mcode",mcode);
	String asset=request.getParameter("asset");
	session.setAttribute("asset",asset);
	String gtxidValueOld = "",gtxidValue="";
		String habValueOld = "",habValue="";
	String assetname="";
    double ys=0.0;
    int wp=0;
    double lat=0.0;
    double lon=0.0;
    double ele=0.0;
	if(asset.equals("04"))
	{
      assetname="HAND PUMPS";
	}
	else if(asset.equals("05"))
	{
      assetname="SHALLOW HANDPUMPS";
	}
	else if(asset.equals("06"))
	{
      assetname="OPEN WELLS";
	}
	
	session.setAttribute("assetname",assetname);
	int sno=1;
	String qry="";
	//ResultSet rs10=null;
	String h1="",h2="",h3="",h4="",h5="",h6="",h7="",h8="",h9="",h10="";
	String sh1="",sh2="",sh3="",sh4="",sh5="",sh6="",sh7="",sh8="",sh9="";
	String ow1="",ow2="",ow3="",ow4="",ow5="",ow6="",ow7="",ow8="",ow9="";
	String p1="";
	String p2="";
	
%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a><a href="./rws_hpopsh_xls.jsp" target=_new>Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Scheme Information Report &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Asset Type:<%=assetname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 </td>
	</tr>
	</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
	<tr align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext  rowspan = 2>HabitationCode/Name</td>
	<td class=btext nowrap  rowspan = 2>Asset Name/<br>Asset Code/<br>Date Created/<br>Location/<br>Asset Cost(In Laks)</td>

	<% if(asset.equals("04")){%>
	<td class=btext   colspan=10>Hand Pumps</td>
	<%} if(asset.equals("06")){%>
	<td class=btext   colspan=10>Open Wells</td>
	<%} if(asset.equals("05")){%>
	<td class=btext   colspan=10>Shallow HandPumps</td>
	<%}%>
	<td class=btext   colspan=2>As Per TestResult</td>
		<td class=btext   colspan=2>If Unsafe</td>
	</tr>
<tr align=center>
<% if(asset.equals("05")){%>
<td class=btext>ShallowHP Code/<br>Location/<br>Status </td>
<td class=btext>Area(Gen/SC/<br>ST/Minority)</td>
<td class=btext>Yield(LPM)</td>
<td class=btext>Drain Existing(Y/N)</td>
<td class=btext>Platform Existing(Y/N)</td>
<td class=btext nowrap>GPS Code<br>(Way Point)</td>
<td class=btext>Latitude</td>
<td class=btext>Longitude</td>
<td class=btext>Elevation</td>
<td class=btext>Sample CollectionDate</td>
<td class=btext>Safe</td>
<td class=btext>UnSafe</td>
<td class=btext nowrap>Type of<br>Contamination</td>
			<td class=btext nowrap>Level of<br>Contamination</td>
<%} if(asset.equals("04")){%>
<td class=btext>HP Code/<br>Location/<br>Status/</td>
<td class=btext>Area(Gen/SC/<br>ST/Minority)</td>
<td class=btext>Yield(LPM)</td>
<td class=btext>Drain Existing(Y/N)</td>
<td class=btext>Platform Existing(Y/N)</td>
<td class=btext nowrap>GPS Code<br>(Way Point)</td>
<td class=btext>Latitude</td>
<td class=btext>Longitude</td>
<td class=btext>Elevation</td>
<td class=btext>Sample CollectionDate</td>
<td class=btext>Safe</td>
<td class=btext>UnSafe</td>
<td class=btext nowrap>Type of<br>Contamination</td>
			<td class=btext nowrap>Level of<br>Contamination</td>
<%} if(asset.equals("06")){%>
<td class=btext>OpenWell Code/<br>Location/<br>Status</td>
<td class=btext>Area(Gen/SC/<br>ST/Minority)</td>
<td class=btext>Yield(LPM)</td>
<td class=btext>Drain Existing(Y/N)</td>
<td class=btext>Platform Existing(Y/N)</td>
<td class=btext nowrap>GPS Code<br>(Way Point)</td>
<td class=btext>Latitude</td>
<td class=btext>Longitude</td>
<td class=btext>Elevation</td>
<td class=btext>Sample CollectionDate</td>
<td class=btext>Safe</td>
<td class=btext>UnSafe</td>
<td class=btext nowrap>Type of<br>Contamination</td>
			<td class=btext nowrap>Level of<br>Contamination</td>

<%}%>
</tr>
              
<%
try
{

//,nvl(a.way_point,'6'),nvl(a.latitude,'7'),nvl(a.longitude,'8'),nvl(a.elevation,'9'),
String shp="select  nvl(shallowhp_code,'-'),nvl(a.location,'-'),nvl(yield,'0'),a.asset_code  from rws_shallowhandpumps_tbl a,rws_asset_mast_tbl b where  substr(a.shallowhp_code,1,2)='"+dcode+"' and substr(a.shallowhp_code,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' and a.asset_code=b.asset_code and a.asset_code is not null ";
	Statement	stmt13=conn.createStatement();
	//System.out.println("shallow handpumps:"+shp);
	ResultSet rs13=stmt13.executeQuery(shp);
	Hashtable shph=new Hashtable();
		while(rs13.next())
	{
		shph.put(rs13.getString(4),rs13.getString(1)+"#"+rs13.getString(2)+"#"+rs13.getString(3));
	}
	if(rs13!=null)rs13.close();
	if(stmt13!=null)stmt13.close();
//
    String shp1="select  nvl(a.way_point,'0'),nvl(a.latitude,'0'),nvl(a.longitude,'0'),nvl(a.elevation,'0'),a.asset_code  from rws_shallowhandpumps_tbl a,rws_asset_mast_tbl b where  substr(a.shallowhp_code,1,2)='"+dcode+"' and substr(a.shallowhp_code,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' and a.asset_code=b.asset_code and a.asset_code is not null ";
	Statement	stmt131=conn.createStatement();
	//System.out.println("shallow handpumps:"+shp1);
	ResultSet rs131=stmt131.executeQuery(shp1);
	Hashtable shph1=new Hashtable();
		while(rs131.next())
	{
		shph1.put(rs131.getString(5),rs131.getString(1)+"#"+rs131.getString(2)+"#"+rs131.getString(3)+"#"+rs131.getString(4));
	}
	if(rs131!=null)rs131.close();
	if(stmt131!=null)stmt131.close();

//
    String hp="select  hp_code,nvl(a.location,'-'),nvl(P_YEILD,0),nvl(decode(platform_existing,'Y','Y','N','N'),'-') as platform_existing,nvl(DECODE(DRAIN,'E','Y','N','N'),'-') AS DRAIN,nvl(a.way_point,'0'),nvl(a.latitude,'0'),nvl(a.longitude,'0'),nvl(a.elevation,'0'),a.asset_code  from rws_hp_subcomp_param_tbl a,rws_asset_mast_tbl b where  substr(a.hp_code,1,2)='"+dcode+"' and substr(a.hp_code,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' and a.asset_code=b.asset_code and a.asset_code is not null ";
	Statement	stmt6=conn.createStatement();
	//System.out.println("ohsr:"+hp);
	ResultSet rs6=stmt6.executeQuery(hp);
	Hashtable hph=new Hashtable();
		while(rs6.next())
	{
		hph.put(rs6.getString(10),rs6.getString(1)+"@"+rs6.getString(2)+"@"+rs6.getString(3)+"@"+rs6.getString(4)+"@"+rs6.getString(5)+"@"+rs6.getString(6)+"@"+rs6.getString(7)+"@"+rs6.getString(8)+"@"+rs6.getString(9));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	String owq="select OPENWELL_CODE ,nvl(a.location,'-'),nvl(decode(platform_exists,'Y','Y','N','N'),'-') as platform_exists,nvl(a.way_point,'0'),nvl(a.latitude,'0'),nvl(a.longitude,'0'),nvl(a.elevation,'0'),a.asset_code  from RWS_OPEN_WELL_MAST_TBL  a,rws_asset_mast_tbl b where  substr(a.HABITATION_CODE ,1,2)='"+dcode+"' and substr(a.HABITATION_CODE ,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' and a.asset_code=b.asset_code and a.asset_code is not null ";
	Statement	stmt11=conn.createStatement();
	//System.out.println("owq:"+owq);
	ResultSet rs11=stmt11.executeQuery(owq);
	Hashtable owh=new Hashtable();
		while(rs11.next())
	{
		owh.put(rs11.getString(8),rs11.getString(1)+"@"+rs11.getString(2)+"@"+rs11.getString(3)+"@"+rs11.getString(4)+"@"+rs11.getString(5)+"@"+rs11.getString(6)+"@"+rs11.getString(7));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
	//for locality

	String locality="select nvl(locality_code,'-'),nvl(locality_name,'-'),hab_code from RWS_SC_ST_MIN_LOCALITY_TBL where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'";
	Statement	stmt77=conn.createStatement();
	//System.out.println("locality:"+locality);
	ResultSet rs77=stmt77.executeQuery(locality);
	Hashtable loh=new Hashtable();
		while(rs77.next())
	{
		loh.put(rs77.getString(3),rs77.getString(1)+"@"+rs77.getString(2));
	}
	if(rs77!=null)rs77.close();
	if(stmt77!=null)stmt77.close();
	//locality ends here
	//watersample collect date


	String sample="select nvl(to_char(SAMP_COLLECT_DATE,'dd/mm/yyyy'),'-'),source_code  from rws_water_sample_collect_tbl where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'";
	Statement stmt55=conn.createStatement();
	//System.out.println("sourcesample:"+sample);
	ResultSet rs55=stmt55.executeQuery(sample);
	Hashtable sourceh=new Hashtable();
		while(rs55.next())
	{
		sourceh.put(rs55.getString(2),rs55.getString(1));
	}
	if(rs55!=null)rs55.close();
	if(stmt55!=null)stmt55.close();


	//watersample ends here

	String gqry=" select c.dname,c.mname,c.pname,c.panch_name,c.panch_code,a.asset_code,a.asset_name,decode(a.type_of_asset_code,'01','Pws','02','Mpws','03','Cpws','04','handpumps','09','Direct pumping','06','openwells','05','Shallow Handpumps')atype ,nvl(a.location,'-'),to_char(DATE_CREATION,'dd/mm/yyyy') ,nvl(asset_cost,0),decode(a.asset_status,'1','Working','2','Not Working','3','Seasonl','4','Dried','5','Condemened')as asset_status   from rws_asset_mast_tbl a,rws_complete_hab_view c,rws_asset_scheme_tbl s where s.asset_code=a.asset_code and substr(s.scheme_code,1,16)=c.panch_code and c.panch_code=a.hab_code and  substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and type_of_asset_code='"+asset+"' order by c.pname,c.panch_name";
	Statement	stmt8=conn.createStatement();
    System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	if(rs8.isBeforeFirst())
   {
	while (rs8.next())
	{
	
	String hiss=""+hph.get(rs8.getString(6));
	if(hiss!=null && !hiss.equals("") && !hiss.equals("null"))
	{
	String []hhh=hiss.split("@");
	h1=hhh[0];
	
	h2=hhh[1];
	
	h3=hhh[2];
	
	h4=hhh[3];
	
	h5=hhh[4];
	
	h6=hhh[5];
	
	h7=hhh[6];
	
	h8=hhh[7];
	
	h9=hhh[8];
	
	
	}
	else{
	h1="-";
	h2="-";
	h3="-";
	h4="-";
	h5="-";
	h6="0";
	h7="0";
	h8="0";
	h9="0";
	
	}
	//sample collect date for handpumps
	String sam=""+sourceh.get(h1);
	if(sam !=null && !sam.equals("") && !sam.equals("null"))
		{
		}
		else
		{
			sam="-";
		}
		//for shallowhandpumps
		String sam1=""+sourceh.get(sh1);
	    if(sam1 !=null && !sam1.equals("") && !sam1.equals("null"))
		{
		}
		else
		{
			sam1="-";
		}
		//for openwells
		String sam2=""+sourceh.get(ow1);
	    if(sam2 !=null && !sam2.equals("") && !sam2.equals("null"))
		{
		}
		else
		{
			sam2="-";
		}



	//sample collect date

    //locality
	
	String l1=""+loh.get(rs8.getString(5));
	if(l1!=null && !l1.equals("") && !l1.equals("null"))
		{
		String []loo=l1.split("@");
		p1=loo[0];
		p2=loo[1];
		}
		else
		{
			p1="-";
			p2="-";
		}


	String ow=""+owh.get(rs8.getString(6));
	if(ow!=null && !ow.equals("") && !ow.equals("null"))
	{String []oo=ow.split("@");ow1=oo[0];ow2=oo[1];
	ow3=oo[2];
	ow4=oo[3];
	ow5=oo[4];
	ow6=oo[5];
	ow7=oo[6];
	
	}
	else{
	ow1="-";
	ow2="-";
	ow3="-";
	ow4="0";
	ow5="0";
	ow6="0";
	ow7="0";
	}
	String sw=""+shph.get(rs8.getString(6));
	if(sw!=null && !sw.equals("") && !sw.equals("null"))
	{String []sh=sw.split("#");
    sh1=sh[0];sh2=sh[1];
	sh3=sh[2];
	
	
	}
	else{
	sh1="-";
	sh2="-";
	sh3="0";
	}
  ys=Double.parseDouble(sh3);
//for latitude,longitude
String sw1=""+shph1.get(rs8.getString(6));
	if(sw1!=null && !sw1.equals("") && !sw1.equals("null"))
	{String []sh11=sw1.split("#");
    sh4=sh11[0];sh5=sh11[1];
	sh6=sh11[2];
    sh7=sh11[3];
	
	
	}
	else{
	sh4="0";
	sh5="0";
	sh6="0";
    sh7="0";
	}

wp=Integer.parseInt(sh4);
lat=Double.parseDouble(sh5);
lon=Double.parseDouble(sh6);
ele=Double.parseDouble(sh7);

	
	

		gtxidValue = ""+rs8.getString(3);
		habValue = ""+rs8.getString(5);
		if(!gtxidValue.equals(gtxidValueOld)){
		//System.out.println("gtxidValue::"+gtxidValue);
		//System.out.println("gtxidValueOld::"+gtxidValueOld);
		%>
<tr><td  colspan="17"  class=btext>Panchayat Name:<%=rs8.getString(3)%></td></tr>
<%}else{}%>
	  
		<tr>
		<td class="rptValue"><%=sno++%></td>
		<%if(habValue.equals(habValueOld)){%>
<td>&nbsp;</td>
	<%}else{%>
		<td class="rptValue"><%=rs8.getString(5)%>/<br><%=rs8.getString(4)%></td>
		<%}%>
		<td class="rptValue"><%=rs8.getString(7)%>/<br><%=rs8.getString(6)%>/<br><%=rs8.getString(10)%>/<br><%=rs8.getString(9)%>/<br><%=rs8.getString(11)%></td>
		<% if(asset.equals("04")){%>
		<td class="rptValue"><%=h1%>/<br><%=h2%>/<br><%=rs8.getString(12)%></td>
		<td class="rptValue"><%=p1%><%=p2%></td>
		<td class="rptValue"><%=h3%></td>
		<td class="rptValue"><%=h5%></td>
		<td class="rptValue"><%=h4%></td>
		<td class="rptValue"><%=h6%></td>
		<td class="rptValue"><%=h7%></td>
		<td class="rptValue"><%=h8%></td>
		<td class="rptValue"><%=h9%></td>
		<td class="rptValue"><%=sam%></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<%} if(asset.equals("06")){%>
		<td class=rptValue><%=ow1%>/<br><%=ow2%>/<br><%=rs8.getString(12)%></td>
		<td class="rptValue"><%=p1%><%=p2%></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"><%=ow3%></td>
		<td class="rptValue"><%=ow4%></td>
		<td class="rptValue"><%=ow5%></td>
		<td class="rptValue"><%=ow6%></td>
		<td class="rptValue"><%=ow7%></td>
		<td class="rptValue"><%=sam2%></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<%}
		if(asset.equals("05")){%>
		<td class=rptValue><%=sh1%>/<br><%=sh2%>/<br><%=rs8.getString(12)%></td>
		<td class="rptValue"><%=p1%><%=p2%></td>
		<td class="rptValue"><%=ys%></td>
		<td class="rptValue"></td>
		<td class="rptValue"><%=ow3%></td>
		<td class="rptValue"><%=wp%></td>
		<td class="rptValue"><%=lat%></td>
		<td class="rptValue"><%=lon%></td>
		<td class="rptValue"><%=ele%></td>
		<td class="rptValue"><%=sam1%></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>
		<td class="rptValue"></td>

<%}
	gtxidValueOld = gtxidValue;
	habValueOld = habValue;
%>
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

  
