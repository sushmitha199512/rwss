
<%@ include file="/commons/rws_header1.jsp" %>
<%@include file="/commons/rws_header4.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
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

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>
<form>

<%
String drill="";

String mcode="",pcode="",district="",temp="",tempconst="";
String dcode=request.getParameter("district");
if(dcode !=null && !dcode.equals("00")){
	drill="d";
}
if(request.getParameter("drill")!=null){
	drill=request.getParameter("drill");
}
session.setAttribute("drill", drill);
//System.out.println("drill is="+drill);
session.setAttribute("dcode",dcode);
////System.out.println("dcode**********" +dcode);
if(request.getParameter("mandal")!=null){
 mcode=request.getParameter("mandal");
session.setAttribute("mcode",mcode);}
if(request.getParameter("panchayath")!=null){
 pcode=request.getParameter("panchayath");
session.setAttribute("pcode",pcode);}
DecimalFormat ndf = new DecimalFormat("####.##");
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";
int sno=1;
    
    
    
    
	if(drill.equals("d")||drill==null||drill.equals("")){
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </a></td>
	  <!-- <td><a href="./rws_asset_hab_abstract_excel.jsp">Excel</a></td> -->  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" > RWS&S-Assets with Habs Information								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="3">Sl.No</td>
    <td class=gridhdbg rowspan="3">District</td>
       <td class=gridhdbg rowspan="3">No. of Habitations</td>
    <td class=gridhdbg rowspan="1" colspan="5">Population</td>
    <td class=gridhdbg rowspan="3">House Holds</td>
    <td class=gridhdbg rowspan="3">House Connections</td>
    <td class=gridhdbg rowspan="1" colspan="16">Existing Assets(No & Supply Quantity(LPD) </td>
   
    <td class=gridhdbg rowspan="1" colspan="2">Level of supply(LPCD)</td>
	<td class=gridhdbg rowspan="1" colspan="7">Previous Year Status</td>
	<td class=gridhdbg rowspan="1" colspan="7">Current Year Status</td>
	
	</tr>
	<tr>
	<td class=gridhdbg rowspan="2">Plain</td>
	<td class=gridhdbg rowspan="2">SC</td>
	<td class=gridhdbg rowspan="2">ST</td>
	<td class=gridhdbg rowspan="2">Minority</td>
	<td class=gridhdbg rowspan="2">Total</td>
	<td class=gridhdbg rowspan="2">CPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="1">CPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">PWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">PWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">MPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">MPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">Others(Direct Pump & Open Well) No</td>
	<td class=gridhdbg rowspan="1" colspan="2">Others(Direct Pump & Open Well) Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP's No</td>
	<td class=gridhdbg rowspan="1" colspan="2">HP/SHP's Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Platforms</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Soakpits</td>
	<td class=gridhdbg rowspan="2">Safe</td>
	<td class=gridhdbg rowspan="2">Un-Safe</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	
	</tr>
	<tr>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	</tr>
       
<%
try
{
	Statement statement=null;
	ResultSet resultSet=null;
	Statement st1=null,st=null;
	ResultSet rset=null,rset1=null;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0;
	int totcpwssafe=0,totpwssafe=0,totmpwssafe=0,totothsafe=0,tothpsafe=0,totshpsafe=0,totpwsunsafe=0,totmpwsunsafe=0,totothunsafe=0,tothpunsafe=0,totshpunsafe=0;
	int tothouseholds=0,tothouseconn=0,totplatforms=0,totsoakpit=0;
	int totnecpwscnt=0,totnepwscnt=0,totnempwscnt=0,totnedpcnt=0,totnehpcnt=0,totneshpcnt=0;
	int totplainpop=0,totscpop=0,totstpop=0,totminpop=0,totpop=0,tothabs=0;
	int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnss=0,totnc=0;
	int totprevfc=0,totprevpc1=0,totprevpc2=0,totprevpc3=0,totprevpc4=0,totprevnss=0,totprevnc=0;
	double totsafe=0.0,totunsafe=0.0;
	
	st1=conn.createStatement();
	String assetqry="select substr(hab_code,1,2),TYPE_OF_ASSET_NAME,count(1) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code ";
	if(dcode !=null && !dcode.equals("00")){
		assetqry+=" and substr(hab_code,1,2)='"+dcode+"'";
	}
	
	assetqry+=" group by substr(hab_code,1,2),TYPE_OF_ASSET_NAME";
	//System.out.println("333="+assetqry);
	rset1=st1.executeQuery(assetqry);
	Hashtable asset_hash=new Hashtable();
	while(rset1.next()){
		asset_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getInt(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String neassetqry="select substr(c.hab_code,1,2),TYPE_OF_ASSET_NAME,count(distinct a.asset_code) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,RWS_ASSET_HAB_TBL c where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and a.asset_code=c.asset_code ";
	
	if(dcode !=null && !dcode.equals("00")){
		neassetqry+=" and substr(c.hab_code,1,2)='"+dcode+"'";
	}
	neassetqry+=" group by substr(c.hab_code,1,2),TYPE_OF_ASSET_NAME";
	//System.out.println("444="+neassetqry);
	rset1=st1.executeQuery(neassetqry);
	Hashtable neasset_hash=new Hashtable();
	while(rset1.next()){
		neasset_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getInt(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	String mainqry="select b.dname,count(b.panch_code),sum(nvl(b.CENSUS_PLAIN_POPU,0)),sum(nvl(b.CENSUS_SC_POPU,0)),sum(nvl(b.CENSUS_ST_POPU,0)),sum(nvl(b.CENSUS_PLAIN_POPU,0)+nvl(b.CENSUS_SC_POPU,0)+nvl(b.CENSUS_ST_POPU,0)+nvl(a.CENSUS_MINORITY_POPU,0)),sum(nvl(b.SAFE_LPCD,0)),sum(nvl(b.UNSAFE_LPCD,0)),sum(case when b.coverage_status='FC' then 1 else 0 end) as fccount,sum(case when b.coverage_status='PC1' then 1 else 0 end) as pc1count,sum(case when b.coverage_status='PC2' then 1 else 0 end) as pc2count,sum(case when b.coverage_status='PC3' then 1 else 0 end) as pc3count,sum(case when b.coverage_status='PC4' then 1 else 0 end) as pc4count,sum(case when b.coverage_status='NSS' then 1 else 0 end) as nsscount,sum(case when b.coverage_status='NC' then 1 else 0 end) as nccount,sum(case when b.PREVIOUS_YR_STATUS='FC' then 1 else 0 end) as fcprevcount,sum(case when b.PREVIOUS_YR_STATUS='PC1' then 1 else 0 end) as pc1prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC2' then 1 else 0 end) as pc2prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC3' then 1 else 0 end) as pc3prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC4' then 1 else 0 end) as pc4prevcount,sum(case when b.PREVIOUS_YR_STATUS='NSS' then 1 else 0 end) as nssprevcount,sum(case when b.PREVIOUS_YR_STATUS='NC' then 1 else 0 end) as ncprevcount,b.dcode,sum(nvl(a.CENSUS_MINORITY_POPU,0)) as minority from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_habitation_directory_tbl a,rws_complete_hab_view b ";
	if(dcode !=null && !dcode.equals("00")){
		mainqry+=" where b.dcode='"+dcode+"' and a.hab_code=b.panch_code  and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (b.panch_code,1,2) = v.dcode and substr(b.panch_code,6,2) = v.mcode and substr(b.panch_code,13,2) = v.pcode and substr (b.panch_code,8,3) = v.vcode and b.coverage_status<>'UI' AND  b.coverage_status IS NOT NULL   group by b.dname,b.dcode order by b.dcode";	
	}
	else
	{
		
		mainqry+=" where a.hab_code=b.panch_code  and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (b.panch_code,1,2) = v.dcode and substr(b.panch_code,6,2) = v.mcode and substr(b.panch_code,13,2) = v.pcode and substr (b.panch_code,8,3) = v.vcode and b.coverage_status<>'UI' AND  b.coverage_status IS NOT NULL   group by b.dname,b.dcode order by b.dcode ";
	}
	
	st=conn.createStatement();
rset=st.executeQuery(mainqry);
while(rset.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,owcnt=0;
	 int necpwscnt=0,nepwscnt=0,nempwscnt=0,nedpcnt=0,nehpcnt=0,neshpcnt=0;
	 
	// System.out.println("ssssss"+rset.getString(23));
	 if(asset_hash.get(rset.getString(23)+"CPWS")!=null){
		 cpwscnt=(Integer)asset_hash.get(rset.getString(23)+"CPWS");
	 }
	 if(asset_hash.get(rset.getString(23)+"PWS")!=null){
		 pwscnt=(Integer)asset_hash.get(rset.getString(23)+"PWS");
	 }
	 if(asset_hash.get(rset.getString(23)+"MPWS")!=null){
		 mpwscnt=(Integer)asset_hash.get(rset.getString(23)+"MPWS");
	 }
	 if(asset_hash.get(rset.getString(23)+"DIRECT PUMPING")!=null){
		 dpcnt=(Integer)asset_hash.get(rset.getString(23)+"DIRECT PUMPING");
	 }
	 if(asset_hash.get(rset.getString(23)+"HANDPUMPS")!=null){
		 hpcnt=(Integer)asset_hash.get(rset.getString(23)+"HANDPUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+"SHALLOW HAND PUMPS")!=null){
		 shpcnt=(Integer)asset_hash.get(rset.getString(23)+"SHALLOW HAND PUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+"OPEN WELLS")!=null){
		 owcnt=(Integer)asset_hash.get(rset.getString(23)+"OPEN WELLS");
	 }
	 int pwssafe=0,pwsunsafe=0,mpwssafe=0,mpwsunsafe=0,cpwssafe=0,cpwsunsafe=0,hpsafe=0,hpunsafe=0,shpsafe=0,shpunsafe=0,othsafe=0,othunsafe=0;
	 String pws="select sum(PWS_SUPPLY),sum(PWS_HAB_SUPPLY),sum(PWS_UNSAFE_SUPPLY),sum(MPWS_SUPPLY),sum(MPWS_HAB_SUPPLY),sum(MPWS_UNSAFE_SUPPLY),sum(CPWS_SUPPLY),sum(CPWS_HAB_SUPPLY),sum(HPS_OTH_SUPPLY),sum(HPS_OTH_SUPPLY_UNSAFE),sum(SHP_DK_SUPPLY_SAFE),sum(SHP_DK_SUPPLY),sum(OTHERS_SUPPLY_SAFE),sum(DP_HAB_SUPPLY),sum(OTHERS_SUPPLY) from rws_hab_supply_status_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"'";
	//System.out.println("pws----"+pws);
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(pws);
	 if(resultSet.next()){
		 pwssafe=resultSet.getInt(1)+resultSet.getInt(2);
		 pwsunsafe=resultSet.getInt(3);
		 mpwssafe=resultSet.getInt(4)+resultSet.getInt(5);
		 mpwsunsafe=resultSet.getInt(6);
		 cpwssafe=resultSet.getInt(7)+resultSet.getInt(8);
		 hpsafe=resultSet.getInt(9);
		 hpunsafe=resultSet.getInt(10);
		 shpsafe=resultSet.getInt(11);
		 shpunsafe=resultSet.getInt(12);
		 othsafe=resultSet.getInt(13)+resultSet.getInt(14);
		 othunsafe=resultSet.getInt(15);
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int households=0,houseconn=0;
	 String house="select sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN) from rws_habitation_directory_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(house);
	 if(resultSet.next()){
		 households=resultSet.getInt(1);
		 houseconn=resultSet.getInt(2);
		
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int platforms=0;
	 String hpplatform="select count(PLATFORM_EXISTING) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpplatform="select count(PLATFORM_EXISTING) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 int soakpit=0;
	 String hpsoakpits="select count(SOAK_PIT) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpsoakpits="select count(SOAK_PIT) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 
	 if(neasset_hash.get(rset.getString(23)+"CPWS")!=null){
		 necpwscnt=(Integer)neasset_hash.get(rset.getString(23)+"CPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+"PWS")!=null){
		 nepwscnt=(Integer)neasset_hash.get(rset.getString(23)+"PWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+"MPWS")!=null){
		 nempwscnt=(Integer)neasset_hash.get(rset.getString(23)+"MPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+"DIRECT PUMPING")!=null){
		 nedpcnt=(Integer)neasset_hash.get(rset.getString(23)+"DIRECT PUMPING");
	 }
	 if(neasset_hash.get(rset.getString(23)+"HANDPUMPS")!=null){
		 nehpcnt=(Integer)neasset_hash.get(rset.getString(23)+"HANDPUMPS");
	 }
	 if(neasset_hash.get(rset.getString(23)+"SHALLOW HAND PUMPS")!=null){
		 neshpcnt=(Integer)neasset_hash.get(rset.getString(23)+"SHALLOW HAND PUMPS");
	 }
	 
	 
	
	%>
	<tr>
	 <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
	 <td class="<%=style%>"style="text-align: left;"> <a href="rws_asset_hab_abstract_home_rpt.jsp?drill=m&district=<%=rset.getString(23)%>&dname=<%= rset.getString(1)%>"><%=rset.getString(1)%></a></td>
	 <td class="<%=style%>"style="text-align: right;"><a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&dname=<%= rset.getString(1)%>')"> <%=rset.getInt(2)%></a></td>
	 
	 	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(3)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(4)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(5)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt("minority")%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(6)%></td>
	 <td class="<%=style%>"style="text-align: right;"><%=households %> </td>
	 <td class="<%=style%>"style="text-align: right;"><%=houseconn %> </td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwscnt %></td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%= mpwssafe%></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=dpcnt+owcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=othsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=othunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpcnt+shpcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpsafe+shpsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%= hpunsafe+shpunsafe%></td>
		<td class="<%=style%>"style="text-align: right;"> <%=platforms%></td>
		<td class="<%=style%>"style="text-align: right;"> <%=soakpit%></td>
		
		 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(7)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(8)%></td>
	 
	 	<td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(16)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(17)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(18)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(19)%></td>
			  <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(20)%></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(21)%></td>
			    <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(22)%></td>
	 
			<td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(9)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(10)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(11)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(12)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(13)%></td>
			  <td class="<%=style%>"style="text-align: right;"><a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&dname=<%= rset.getString(1)%>&mode=NSS')"> <%=rset.getInt(14)%></a></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(15)%></td>
			   
	 	 
	 
	</tr>
	
	<%
	
	totplatforms+=platforms;
	totsoakpit+=soakpit;
	
	
	tothouseconn+=houseconn;
	tothouseholds+=households;
	
	totcpwssafe+=cpwssafe;
	totpwssafe+=pwssafe;
	totmpwssafe+=mpwssafe;
	totothsafe+=othsafe;
	tothpsafe+=hpsafe;
	totshpsafe+=shpsafe;
	totpwsunsafe+=pwsunsafe;
	totmpwsunsafe+=mpwsunsafe;
	totothunsafe+=othunsafe;
	tothpunsafe+=hpunsafe;
	totshpunsafe+=shpunsafe;
	
	
	tothabs+=rset.getInt(2);
	
	totplainpop+=rset.getInt(3);
	totscpop+=rset.getInt(4);
	totstpop+=rset.getInt(5);
	totminpop+=rset.getInt("minority");
	totpop+=rset.getInt(6);
	totcpwscnt+=cpwscnt;
	totpwscnt+=pwscnt;
	totmpwscnt+=mpwscnt;
	totdpcnt+=dpcnt+owcnt;
	tothpcnt+=hpcnt;
	totshpcnt+=shpcnt;
	totnecpwscnt+=necpwscnt;totnepwscnt+=nepwscnt;totnempwscnt+=nempwscnt;totnedpcnt+=nedpcnt;totnehpcnt+=nehpcnt;totneshpcnt+=neshpcnt;
	totsafe+=rset.getDouble(7);
	totunsafe+=rset.getDouble(8);
	totfc+=rset.getInt(9);totpc1+=rset.getInt(10);totpc2+=rset.getInt(11);totpc3+=rset.getInt(12);totpc4+=rset.getInt(13);totnss+=rset.getInt(14);totnc+=rset.getInt(15);
	totprevfc+=rset.getInt(16);totprevpc1+=rset.getInt(17);totprevpc2+=rset.getInt(18);totprevpc3+=rset.getInt(19);totprevpc4+=rset.getInt(20);totprevnss+=rset.getInt(21);totprevnc+=rset.getInt(22);
}
%>
<tr>
<td class=gridhdbg style="text-align: center;" colspan="2">Total</td>
<td class=gridhdbg style="text-align: right;" ><%=tothabs %></td>
<td class=gridhdbg style="text-align: right;" ><%=totplainpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totscpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totstpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totminpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothouseholds %> </td>
<td class=gridhdbg style="text-align: right;" ><%= tothouseconn%></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwsunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwsunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totdpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totothsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totothunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpcnt+totshpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpsafe+totshpsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpunsafe+totshpunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totplatforms %></td>
<td class=gridhdbg style="text-align: right;" ><%=totsoakpit %></td>
<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totsafe) %></td>
<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totunsafe) %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnc %></td>


</tr>

<%
if(rset!=null){
	rset.close();
}
if(st!=null){
	st.close();
}
}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>
<%}else if(drill.equals("m")){
    
    
  	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<!-- <td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td> -->
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <!-- <td><a href="./rws_asset_hab_abstract_excel.jsp">Excel</a></td> -->  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" colspan="39"> RWS&S-Assets with Habs Information			
 - Report (District: <%=request.getParameter("dname") %>)</td>
	</tr>
	
   
	<!-- </table>
  
  <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER > -->
   
	<tr>
	
	<td class=gridhdbg rowspan="3">Sl.No</td>
  <!--  <td class=gridhdbg rowspan="2">District</td> -->
   <td class=gridhdbg rowspan="3">Mandal</td>
      <td class=gridhdbg rowspan="3">No. of Habitations</td>
   <td class=gridhdbg rowspan="1" colspan="5">Population</td>
   <td class=gridhdbg rowspan="3">House Holds</td>
    <td class=gridhdbg rowspan="3">House Connections</td>
   <td class=gridhdbg rowspan="1" colspan="16">Existing Assets(No & Supply Quantity(LPD)</td>
     <td class=gridhdbg rowspan="1" colspan="2">Level of supply(LPCD)</td>
	<td class=gridhdbg rowspan="1" colspan="7">Previous Year Status</td>
	<td class=gridhdbg rowspan="1" colspan="7">Current Year Status</td>
	</tr>
	<tr>
	<td class=gridhdbg rowspan="2">Plain</td>
	<td class=gridhdbg rowspan="2">SC</td>
	<td class=gridhdbg rowspan="2">ST</td>
	<td class=gridhdbg rowspan="2">Minority</td>
	<td class=gridhdbg rowspan="2">Total</td>
	<td class=gridhdbg rowspan="2">CPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="1">CPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">PWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">PWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">MPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">MPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">Others(Direct Pump & Open Well) No</td>
	<td class=gridhdbg rowspan="1" colspan="2">Others(Direct Pump & Open Well) Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP's No</td>
	<td class=gridhdbg rowspan="1" colspan="2">HP/SHP's Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Platforms</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Soakpits</td>
	<td class=gridhdbg rowspan="2">Safe</td>
	<td class=gridhdbg rowspan="2">Un-Safe</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	
	</tr>
	<tr>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	</tr>
      
<%
try
{
	Statement st1=null,st=null,statement=null;
	ResultSet rset=null,rset1=null,resultSet=null;
	int totcpwssafe=0,totpwssafe=0,totmpwssafe=0,totothsafe=0,tothpsafe=0,totshpsafe=0,totpwsunsafe=0,totmpwsunsafe=0,totothunsafe=0,tothpunsafe=0,totshpunsafe=0;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0;
	int totnecpwscnt=0,totnepwscnt=0,totnempwscnt=0,totnedpcnt=0,totnehpcnt=0,totneshpcnt=0;
	int totplainpop=0,totscpop=0,totstpop=0,totminpop=0,totpop=0,tothabs=0;
	int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnss=0,totnc=0;
	int totprevfc=0,totprevpc1=0,totprevpc2=0,totprevpc3=0,totprevpc4=0,totprevnss=0,totprevnc=0;
	double totsafe=0.0,totunsafe=0.0;
	 int tothouseholds=0,tothouseconn=0,totplatforms=0,totsoakpit=0;
	
	st1=conn.createStatement();
	String assetqry="select substr(hab_code,1,2),substr(hab_code,6,2),TYPE_OF_ASSET_NAME,count(1) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code ";
	if(dcode !=null && !dcode.equals("00")){
		assetqry+=" and substr(hab_code,1,2)='"+dcode+"'";
	}
	
	assetqry+=" group by substr(hab_code,1,2),substr(hab_code,6,2),TYPE_OF_ASSET_NAME";
	//System.out.println("333="+assetqry);
	rset1=st1.executeQuery(assetqry);
	Hashtable asset_hash=new Hashtable();
	while(rset1.next()){
		asset_hash.put(rset1.getString(1)+rset1.getString(2)+rset1.getString(3), rset1.getInt(4));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String neassetqry="select substr(c.hab_code,1,2),substr(c.hab_code,6,2),TYPE_OF_ASSET_NAME,count(distinct a.asset_code) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,RWS_ASSET_HAB_TBL c where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and a.asset_code=c.asset_code ";
	
	if(dcode !=null && !dcode.equals("00")){
		neassetqry+=" and substr(c.hab_code,1,2)='"+dcode+"'";
	}
	neassetqry+=" group by substr(c.hab_code,1,2),substr(c.hab_code,6,2),TYPE_OF_ASSET_NAME";
	//System.out.println("444="+neassetqry);
	rset1=st1.executeQuery(neassetqry);
	Hashtable neasset_hash=new Hashtable();
	while(rset1.next()){
		neasset_hash.put(rset1.getString(1)+rset1.getString(2)+rset1.getString(3), rset1.getInt(4));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	String mainqry="select dname,count(panch_code),sum(nvl(b.CENSUS_PLAIN_POPU,0)),sum(nvl(b.CENSUS_SC_POPU,0)),sum(nvl(b.CENSUS_ST_POPU,0)),sum(nvl(b.CENSUS_PLAIN_POPU,0)+nvl(b.CENSUS_SC_POPU,0)+nvl(b.CENSUS_ST_POPU,0)+nvl(a.CENSUS_MINORITY_POPU,0)),sum(nvl(b.SAFE_LPCD,0)),sum(nvl(b.UNSAFE_LPCD,0)),sum(case when b.coverage_status='FC' then 1 else 0 end) as fccount,sum(case when b.coverage_status='PC1' then 1 else 0 end) as pc1count,sum(case when b.coverage_status='PC2' then 1 else 0 end) as pc2count,sum(case when b.coverage_status='PC3' then 1 else 0 end) as pc3count,sum(case when b.coverage_status='PC4' then 1 else 0 end) as pc4count,sum(case when b.coverage_status='NSS' then 1 else 0 end) as nsscount,sum(case when b.coverage_status='NC' then 1 else 0 end) as nccount,sum(case when b.PREVIOUS_YR_STATUS='FC' then 1 else 0 end) as fcprevcount,sum(case when b.PREVIOUS_YR_STATUS='PC1' then 1 else 0 end) as pc1prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC2' then 1 else 0 end) as pc2prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC3' then 1 else 0 end) as pc3prevcount,sum(case when b.PREVIOUS_YR_STATUS='PC4' then 1 else 0 end) as pc4prevcount,sum(case when b.PREVIOUS_YR_STATUS='NSS' then 1 else 0 end) as nssprevcount,sum(case when b.PREVIOUS_YR_STATUS='NC' then 1 else 0 end) as ncprevcount,dcode,mname,mcode,sum(nvl(a.CENSUS_MINORITY_POPU,0)) as minority from rws_habitation_directory_tbl a,rws_complete_hab_view b ";
	if(dcode !=null && !dcode.equals("00")){
		mainqry+=" where dcode='"+dcode+"' and a.hab_code=b.panch_code and b.coverage_status<>'UI' AND  b.coverage_status IS NOT NULL group by dname,dcode,mname,mcode order by dcode,mcode";	
	}
	else
	{
		
		mainqry+=" where a.hab_code=b.panch_code and b.coverage_status<>'UI' AND  b.coverage_status IS NOT NULL   group by dname,dcode,mname,mcode order by dcode,mcode";
	}	
//System.out.println("222=mmmmmmmmmmmmm"+mainqry);
	st=conn.createStatement();
rset=st.executeQuery(mainqry);
while(rset.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,owcnt=0;
	 int necpwscnt=0,nepwscnt=0,nempwscnt=0,nedpcnt=0,nehpcnt=0,neshpcnt=0;
	
	 
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"CPWS")!=null){
		 cpwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"CPWS");
	 }//System.out.println("inside while");
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"PWS")!=null){
		 pwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"PWS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"MPWS")!=null){
		 mpwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"MPWS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"DIRECT PUMPING")!=null){
		 dpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"DIRECT PUMPING");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"HANDPUMPS")!=null){
		 hpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"HANDPUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"SHALLOW HAND PUMPS")!=null){
		 shpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"SHALLOW HAND PUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+"OPEN WELLS")!=null){
		 owcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+"OPEN WELLS");
	 }
	
	 int pwssafe=0,pwsunsafe=0,mpwssafe=0,mpwsunsafe=0,cpwssafe=0,cpwsunsafe=0,hpsafe=0,hpunsafe=0,shpsafe=0,shpunsafe=0,othsafe=0,othunsafe=0;
	 String pws="select sum(PWS_SUPPLY),sum(PWS_HAB_SUPPLY),sum(PWS_UNSAFE_SUPPLY),sum(MPWS_SUPPLY),sum(MPWS_HAB_SUPPLY),sum(MPWS_UNSAFE_SUPPLY),sum(CPWS_SUPPLY),sum(CPWS_HAB_SUPPLY),sum(HPS_OTH_SUPPLY),sum(HPS_OTH_SUPPLY_UNSAFE),sum(SHP_DK_SUPPLY_SAFE),sum(SHP_DK_SUPPLY),sum(OTHERS_SUPPLY_SAFE),sum(DP_HAB_SUPPLY),sum(OTHERS_SUPPLY) from rws_hab_supply_status_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"'";
	
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(pws);
	 if(resultSet.next()){
		 pwssafe=resultSet.getInt(1)+resultSet.getInt(2);
		 pwsunsafe=resultSet.getInt(3);
		 mpwssafe=resultSet.getInt(4)+resultSet.getInt(5);
		 mpwsunsafe=resultSet.getInt(6);
		 cpwssafe=resultSet.getInt(7)+resultSet.getInt(8);
		 hpsafe=resultSet.getInt(9);
		 hpunsafe=resultSet.getInt(10);
		 shpsafe=resultSet.getInt(11);
		 shpunsafe=resultSet.getInt(12);
		 othsafe=resultSet.getInt(13)+resultSet.getInt(14);
		 othunsafe=resultSet.getInt(15);
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int households=0,houseconn=0;
	 String house="select sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN) from rws_habitation_directory_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(house);
	 if(resultSet.next()){
		 households=resultSet.getInt(1);
		 houseconn=resultSet.getInt(2);
		
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int platforms=0;
	 String hpplatform="select count(PLATFORM_EXISTING) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and substr(hp_code,6,2)='"+rset.getString(25)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpplatform="select count(PLATFORM_EXISTING) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 int soakpit=0;
	 String hpsoakpits="select count(SOAK_PIT) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and substr(hp_code,6,2)='"+rset.getString(25)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpsoakpits="select count(SOAK_PIT) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"CPWS")!=null){
		 necpwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"CPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"PWS")!=null){
		 nepwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"PWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"MPWS")!=null){
		 nempwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"MPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"DIRECT PUMPING")!=null){
		 nedpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"DIRECT PUMPING");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"HANDPUMPS")!=null){
		 nehpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"HANDPUMPS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+"SHALLOW HAND PUMPS")!=null){
		 neshpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+"SHALLOW HAND PUMPS");
	 }
	
	%>
	<tr>
	 <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
	 <%-- <td class="<%=style%>"style="text-align: left;"> <%=rset.getString(1)%></td> --%>
	 <td class="<%=style%>"style="text-align: left;"><a href="rws_asset_hab_abstract_home_rpt.jsp?drill=p&district=<%=rset.getString(23)%>&mandal=<%=rset.getString(25)%>&mname=<%=rset.getString(24)%>&dname=<%=rset.getString(1)%>">  <%=rset.getString(24)%></a></td>
	 <td class="<%=style%>"style="text-align: right;"><a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&mandal=<%=rset.getString(25)%>&mname=<%=rset.getString(24)%>&dname=<%=rset.getString(1)%>')"> <%=rset.getInt(2)%></a></td>
	 	 
	 	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(3)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(4)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(5)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt("minority")%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(6)%></td>
	 <td class="<%=style%>"style="text-align: right;"><%=households %> </td>
	 <td class="<%=style%>"style="text-align: right;"><%=houseconn %> </td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwscnt %></td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=dpcnt+owcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=othsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=othunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpcnt+shpcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpsafe+shpsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpunsafe+shpunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=platforms %></td>
		<td class="<%=style%>"style="text-align: right;"><%=soakpit %></td>
		 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(7)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(8)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(16)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(17)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(18)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(19)%></td>
			  <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(20)%></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(21)%></td>
			    <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(22)%></td>
		<td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(9)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(10)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(11)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(12)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(13)%></td>
			  <td class="<%=style%>"style="text-align: right;"><a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&mandal=<%=rset.getString(25)%>&mname=<%=rset.getString(24)%>&dname=<%=rset.getString(1)%>&mode=NSS')"> <%=rset.getInt(14)%></a></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(15)%></td>
			   
	 	 
	 
	</tr>
	
	<%
	totplatforms+=platforms;
	totsoakpit+=soakpit;
	
	tothouseconn+=houseconn;
	tothouseholds+=households;
	
	totcpwssafe+=cpwssafe;
	totpwssafe+=pwssafe;
	totmpwssafe+=mpwssafe;
	totothsafe+=othsafe;
	tothpsafe+=hpsafe;
	totshpsafe+=shpsafe;
	totpwsunsafe+=pwsunsafe;
	totmpwsunsafe+=mpwsunsafe;
	totothunsafe+=othunsafe;
	tothpunsafe+=hpunsafe;
	totshpunsafe+=shpunsafe;
	
	
	tothabs+=rset.getInt(2);
	
	totplainpop+=rset.getInt(3);
	totscpop+=rset.getInt(4);
	totstpop+=rset.getInt(5);
	totminpop+=rset.getInt("minority");
	totpop+=rset.getInt(6);
	totcpwscnt+=cpwscnt;totpwscnt+=pwscnt;totmpwscnt+=mpwscnt;totdpcnt+=dpcnt+owcnt;tothpcnt+=hpcnt;totshpcnt+=shpcnt;
	totnecpwscnt+=necpwscnt;totnepwscnt+=nepwscnt;totnempwscnt+=nempwscnt;totnedpcnt+=nedpcnt;totnehpcnt+=nehpcnt;totneshpcnt+=neshpcnt;
	totsafe+=rset.getDouble(7);
	totunsafe+=rset.getDouble(8);
	totfc+=rset.getInt(9);totpc1+=rset.getInt(10);totpc2+=rset.getInt(11);totpc3+=rset.getInt(12);totpc4+=rset.getInt(13);totnss+=rset.getInt(14);totnc+=rset.getInt(15);
	totprevfc+=rset.getInt(16);totprevpc1+=rset.getInt(17);totprevpc2+=rset.getInt(18);totprevpc3+=rset.getInt(19);totprevpc4+=rset.getInt(20);totprevnss+=rset.getInt(21);totprevnc+=rset.getInt(22);
}
%>
<tr>
<td class=gridhdbg style="text-align: center;" colspan="2">Total</td>
<td class=gridhdbg style="text-align: right;" ><%=tothabs %></td>
<td class=gridhdbg style="text-align: right;" ><%=totplainpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totscpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totstpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totminpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothouseholds %> </td>
<td class=gridhdbg style="text-align: right;" ><%= tothouseconn%></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwsunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwsunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totdpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totothsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totothunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpcnt+totshpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpsafe+totshpsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpunsafe+totshpunsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%=totplatforms %></td>
<td class=gridhdbg style="text-align: right;" ><%=totsoakpit %></td>

<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totsafe) %></td>
<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totunsafe) %></td>

<td class=gridhdbg style="text-align: right;" ><%=totprevfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnc %></td>

</tr>

<%
if(rset!=null){
	rset.close();
}
if(st!=null){
	st.close();
}
}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
   
</table>
<%}if(drill.equals("p")){
	

    
    
  	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<!-- <td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td> -->
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <!-- <td><a href="./rws_asset_hab_abstract_excel.jsp">Excel</a></td> -->  
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="gridhdbg" colspan="37"> RWS&S-Assets with Habs Information								
 - Report (District: <%=request.getParameter("dname") %> and Mandal: <%= request.getParameter("mname") %>)</td>
	</tr>
	
   
	<!-- </table>
  
  <table width="60%" border=0 style="border-collapse:collapse"  ALIGN=CENTER > -->
   
	<tr>
	
	<td class=gridhdbg rowspan="3">Sl.No</td>
   <!-- <td class=gridhdbg rowspan="2">District</td>
   <td class=gridhdbg rowspan="2">Mandal</td> -->
   <td class=gridhdbg rowspan="3">Panchayat</td>
      <td class=gridhdbg rowspan="3">No. of Habitations</td>
   <td class=gridhdbg rowspan="1" colspan="5">Population</td>
   <td class=gridhdbg rowspan="3">House Holds</td>
    <td class=gridhdbg rowspan="3">House Connections</td>
   <td class=gridhdbg rowspan="1" colspan="16">Existing Assets(No & Supply Quantity(LPD)</td>
   <td class=gridhdbg rowspan="1" colspan="2">Level of supply(LPCD)</td>
	<td class=gridhdbg rowspan="1" colspan="7">Previous Year Status</td>
	<td class=gridhdbg rowspan="1" colspan="7">Current Year Status</td>
	</tr>
	<tr>
	<td class=gridhdbg rowspan="2">Plain</td>
	<td class=gridhdbg rowspan="2">SC</td>
	<td class=gridhdbg rowspan="2">ST</td>
	<td class=gridhdbg rowspan="2">Minority</td>
	<td class=gridhdbg rowspan="2">Total</td>
	<td class=gridhdbg rowspan="2">CPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="1">CPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">PWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">PWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">MPWS No</td>
	<td class=gridhdbg rowspan="1" colspan="2">MPWS Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">Others(Direct Pump & Open Well) No</td>
	<td class=gridhdbg rowspan="1" colspan="2">Others(Direct Pump & Open Well) Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP's No</td>
	<td class=gridhdbg rowspan="1" colspan="2">HP/SHP's Supply(LPD)</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Platforms</td>
	<td class=gridhdbg rowspan="2">HP/SHP Not Having Soakpits</td>
	<td class=gridhdbg rowspan="2">Safe</td>
	<td class=gridhdbg rowspan="2">Un-Safe</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	<td class=gridhdbg rowspan="2">FC</td>
	<td class=gridhdbg rowspan="2">PC1</td>
	<td class=gridhdbg rowspan="2">PC2</td>
	<td class=gridhdbg rowspan="2">PC3</td>
	<td class=gridhdbg rowspan="2">PC4</td>
	<td class=gridhdbg rowspan="2">NSS</td>
	<td class=gridhdbg rowspan="2">NC</td>
	
	</tr>
      <tr>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>UnSafe</td>
	</tr>
<%
try
{
	Statement st1=null,st=null,statement=null;
	ResultSet rset=null,rset1=null,resultSet=null;
	int totcpwssafe=0,totpwssafe=0,totmpwssafe=0,totothsafe=0,tothpsafe=0,totshpsafe=0,totpwsunsafe=0,totmpwsunsafe=0,totothunsafe=0,tothpunsafe=0,totshpunsafe=0;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0;
	int totnecpwscnt=0,totnepwscnt=0,totnempwscnt=0,totnedpcnt=0,totnehpcnt=0,totneshpcnt=0;
	int totplainpop=0,totscpop=0,totstpop=0,totminpop=0,totpop=0,tothabs=0;
	int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnss=0,totnc=0;
	int totprevfc=0,totprevpc1=0,totprevpc2=0,totprevpc3=0,totprevpc4=0,totprevnss=0,totprevnc=0;
	double totsafe=0.0,totunsafe=0.0;
	int tothouseholds=0,tothouseconn=0,totplatforms=0,totsoakpit=0;
	
	st1=conn.createStatement();
	String assetqry="select substr(hab_code,1,2),substr(hab_code,6,2),substr(hab_code,13,2),TYPE_OF_ASSET_NAME,count(1) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code ";
	if(dcode !=null && !dcode.equals("00")){
		assetqry+=" and substr(hab_code,1,2)='"+dcode+"'";
	}
	if(mcode !=null && !mcode.equals("00")){
		assetqry+=" and substr(hab_code,6,2)='"+mcode+"'";
	}
	
	assetqry+=" group by substr(hab_code,1,2),substr(hab_code,6,2),substr(hab_code,13,2),TYPE_OF_ASSET_NAME";
	//System.out.println("333="+assetqry);
	rset1=st1.executeQuery(assetqry);
	Hashtable asset_hash=new Hashtable();
	while(rset1.next()){
		asset_hash.put(rset1.getString(1)+rset1.getString(2)+rset1.getString(3)+rset1.getString(4), rset1.getInt(5));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String neassetqry="select substr(c.hab_code,1,2),substr(c.hab_code,6,2),substr(c.hab_code,13,2),TYPE_OF_ASSET_NAME,count(distinct a.asset_code) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,RWS_ASSET_HAB_TBL c where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and a.asset_code=c.asset_code ";
	
	if(dcode !=null && !dcode.equals("00")){
		neassetqry+=" and substr(c.hab_code,1,2)='"+dcode+"'";
	}
	if(mcode !=null && !mcode.equals("00")){
		neassetqry+=" and substr(c.hab_code,6,2)='"+mcode+"'";
	}
	neassetqry+=" group by substr(c.hab_code,1,2),substr(c.hab_code,6,2),substr(c.hab_code,13,2),TYPE_OF_ASSET_NAME";
	//System.out.println("444="+neassetqry);
	rset1=st1.executeQuery(neassetqry);
	Hashtable neasset_hash=new Hashtable();
	while(rset1.next()){
		neasset_hash.put(rset1.getString(1)+rset1.getString(2)+rset1.getString(3)+rset1.getString(4), rset1.getInt(5));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	String mainqry="select dname,count(panch_code),sum(nvl(a.CENSUS_PLAIN_POPU,0)),sum(nvl(a.CENSUS_SC_POPU,0)),sum(nvl(a.CENSUS_ST_POPU,0)),sum(nvl(a.CENSUS_PLAIN_POPU,0)+nvl(a.CENSUS_SC_POPU,0)+nvl(a.CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)),sum(nvl(a.SAFE_LPCD,0)),sum(nvl(a.UNSAFE_LPCD,0)),sum(case when a.coverage_status='FC' then 1 else 0 end) as fccount,sum(case when a.coverage_status='PC1' then 1 else 0 end) as pc1count,sum(case when a.coverage_status='PC2' then 1 else 0 end) as pc2count,sum(case when a.coverage_status='PC3' then 1 else 0 end) as pc3count,sum(case when a.coverage_status='PC4' then 1 else 0 end) as pc4count,sum(case when a.coverage_status='NSS' then 1 else 0 end) as nsscount,sum(case when a.coverage_status='NC' then 1 else 0 end) as nccount,sum(case when a.PREVIOUS_YR_STATUS='FC' then 1 else 0 end) as fcprevcount,sum(case when a.PREVIOUS_YR_STATUS='PC1' then 1 else 0 end) as pc1prevcount,sum(case when a.PREVIOUS_YR_STATUS='PC2' then 1 else 0 end) as pc2prevcount,sum(case when a.PREVIOUS_YR_STATUS='PC3' then 1 else 0 end) as pc3prevcount,sum(case when a.PREVIOUS_YR_STATUS='PC4' then 1 else 0 end) as pc4prevcount,sum(case when a.PREVIOUS_YR_STATUS='NSS' then 1 else 0 end) as nssprevcount,sum(case when a.PREVIOUS_YR_STATUS='NC' then 1 else 0 end) as ncprevcount,dcode,mname,mcode,pname,pcode,sum(nvl(CENSUS_MINORITY_POPU,0)) minority from rws_complete_hab_view a,rws_habitation_directory_tbl b where a.panch_code=b.hab_code";
	if(dcode !=null && !dcode.equals("00")){
		mainqry+=" and dcode='"+dcode+"'";	
	}
	if(mcode !=null && !mcode.equals("00")){
		mainqry+=" and mcode='"+mcode+"'";	
	}
		mainqry+=" group by dname,dcode,mname,mcode,pname,pcode";
	//System.out.println("222=in ddddppppppppppp"+mainqry);
	st=conn.createStatement();
rset=st.executeQuery(mainqry);
while(rset.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,owcnt=0;
	 int necpwscnt=0,nepwscnt=0,nempwscnt=0,nedpcnt=0,nehpcnt=0,neshpcnt=0;
	 
	 
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"CPWS")!=null){
		 cpwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"CPWS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"PWS")!=null){
		 pwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"PWS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"MPWS")!=null){
		 mpwscnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"MPWS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"DIRECT PUMPING")!=null){
		 dpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"DIRECT PUMPING");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"HANDPUMPS")!=null){
		 hpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"HANDPUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"SHALLOW HAND PUMPS")!=null){
		 shpcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"SHALLOW HAND PUMPS");
	 }
	 if(asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"OPEN WELLS")!=null){
		 owcnt=(Integer)asset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"OPEN WELLS");
	 }
	
	
	 int pwssafe=0,pwsunsafe=0,mpwssafe=0,mpwsunsafe=0,cpwssafe=0,cpwsunsafe=0,hpsafe=0,hpunsafe=0,shpsafe=0,shpunsafe=0,othsafe=0,othunsafe=0;
	 String pws="select sum(PWS_SUPPLY),sum(PWS_HAB_SUPPLY),sum(PWS_UNSAFE_SUPPLY),sum(MPWS_SUPPLY),sum(MPWS_HAB_SUPPLY),sum(MPWS_UNSAFE_SUPPLY),sum(CPWS_SUPPLY),sum(CPWS_HAB_SUPPLY),sum(HPS_OTH_SUPPLY),sum(HPS_OTH_SUPPLY_UNSAFE),sum(SHP_DK_SUPPLY_SAFE),sum(SHP_DK_SUPPLY),sum(OTHERS_SUPPLY_SAFE),sum(DP_HAB_SUPPLY),sum(OTHERS_SUPPLY) from rws_hab_supply_status_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and substr(hab_code,13,2)='"+rset.getString(27)+"'";
	
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(pws);
	 if(resultSet.next()){
		 pwssafe=resultSet.getInt(1)+resultSet.getInt(2);
		 pwsunsafe=resultSet.getInt(3);
		 mpwssafe=resultSet.getInt(4)+resultSet.getInt(5);
		 mpwsunsafe=resultSet.getInt(6);
		 cpwssafe=resultSet.getInt(7)+resultSet.getInt(8);
		 hpsafe=resultSet.getInt(9);
		 hpunsafe=resultSet.getInt(10);
		 shpsafe=resultSet.getInt(11);
		 shpunsafe=resultSet.getInt(12);
		 othsafe=resultSet.getInt(13)+resultSet.getInt(14);
		 othunsafe=resultSet.getInt(15);
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 int households=0,houseconn=0;
	 String house="select sum(HOUSEHOLD_NO),sum(NO_OF_HOUSECONN_GIVEN) from rws_habitation_directory_tbl a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and substr(hab_code,13,2)='"+rset.getString(27)+"'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(house);
	 if(resultSet.next()){
		 households=resultSet.getInt(1);
		 houseconn=resultSet.getInt(2);
		
		 
	 }
	 statement.close();
	 resultSet.close();
	 
	 
	 int platforms=0;
	 String hpplatform="select count(PLATFORM_EXISTING) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and substr(hp_code,6,2)='"+rset.getString(25)+"' and substr(hp_code,13,2)='"+rset.getString(27)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpplatform="select count(PLATFORM_EXISTING) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and substr(hab_code,13,2)='"+rset.getString(27)+"' and PLATFORM_EXISTING='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpplatform);
	 if(resultSet.next()){
		 platforms+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 int soakpit=0;
	 String hpsoakpits="select count(SOAK_PIT) from RWS_HP_SUBCOMP_PARAM_TBL a,rws_complete_hab_view c where substr(hp_code,1,16)=c.panch_code and substr(hp_code,1,2)='"+rset.getString(23)+"' and substr(hp_code,6,2)='"+rset.getString(25)+"' and substr(hp_code,13,2)='"+rset.getString(27)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(hpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 String shpsoakpits="select count(SOAK_PIT) from RWS_SHALLOWHANDPUMPS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and substr(hab_code,1,2)='"+rset.getString(23)+"' and substr(hab_code,6,2)='"+rset.getString(25)+"' and substr(hab_code,13,2)='"+rset.getString(27)+"' and SOAK_PIT='N'";
	 statement=conn.createStatement();
	 resultSet=statement.executeQuery(shpsoakpits);
	 if(resultSet.next()){
		 soakpit+=resultSet.getInt(1);
	 }
	 statement.close();
	 resultSet.close();
	 
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"CPWS")!=null){
		 necpwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"CPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"PWS")!=null){
		 nepwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"PWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"MPWS")!=null){
		 nempwscnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"MPWS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"DIRECT PUMPING")!=null){
		 nedpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"DIRECT PUMPING");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"HANDPUMPS")!=null){
		 nehpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"HANDPUMPS");
	 }
	 if(neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"SHALLOW HAND PUMPS")!=null){
		 neshpcnt=(Integer)neasset_hash.get(rset.getString(23)+rset.getString(25)+rset.getString(27)+"SHALLOW HAND PUMPS");
	 }
	
	%>
	<tr>
	 <td class="<%=style%>"style="text-align: right;"> <%=sno++%></td>
	 <%-- <td class="<%=style%>"style="text-align: left;"> <%=rset.getString(1)%></td>
	 <td class="<%=style%>"style="text-align: left;"><%=rset.getString(24)%></td> --%>
	  <td class="<%=style%>"style="text-align: left;"> <%=rset.getString(26)%></td>
	 <td class="<%=style%>"style="text-align: right;"><a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&mandal=<%=rset.getString(25)%>&panchayath=<%=rset.getString(27)%>')"> <%=rset.getInt(2)%></a></td>
	 
	 	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(3)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(4)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(5)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt("minority")%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(6)%></td>
	 <td class="<%=style%>"style="text-align: right;"><%=households %> </td>
	 <td class="<%=style%>"style="text-align: right;"><%=houseconn %> </td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwscnt %></td>
	<td class="<%=style%>"style="text-align: right;"><%=cpwssafe %></td>
	
		<td class="<%=style%>"style="text-align: right;"><%=pwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=pwssafe %></td>
	<td class="<%=style%>"style="text-align: right;"><%=pwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwssafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=mpwsunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=dpcnt+owcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=othsafe %></td>
	<td class="<%=style%>"style="text-align: right;"><%=othunsafe %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpcnt+shpcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=hpsafe+shpsafe %></td>
	<td class="<%=style%>"style="text-align: right;"><%=hpunsafe+shpunsafe %></td>
	<td class="<%=style%>"style="text-align: right;"><%=platforms %></td>
	<td class="<%=style%>"style="text-align: right;"><%=soakpit %></td>
		<!-- 
		<td class="<%=style%>"style="text-align: right;"><%=necpwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=nepwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=nempwscnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=nedpcnt %></td>
		<td class="<%=style%>"style="text-align: right;"><%=nehpcnt+neshpcnt %></td>
		
		 -->
		 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(7)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getDouble(8)%></td>
	 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(16)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(17)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(18)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(19)%></td>
			  <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(20)%></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(21)%></td>
			    <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(22)%></td>
		<td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(9)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(10)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(11)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(12)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(13)%></td>
			 <td class="<%=style%>"style="text-align: right;"> <a href="#" onclick="viewWorks('./rws_asset_hab_rpt.jsp?district=<%=rset.getString(23)%>&mandal=<%=rset.getString(25)%>&panchayath=<%=rset.getString(27)%>&mode=NSS')"><%=rset.getInt(14)%></a></td>
			   <td class="<%=style%>"style="text-align: right;"> <%=rset.getInt(15)%></td>
			   
	 	 
	 
	</tr>
	
	<%
	
	totplatforms+=platforms;
	totsoakpit+=soakpit;
	
	tothouseconn+=houseconn;
	tothouseholds+=households;
	
	totcpwssafe+=cpwssafe;
	totpwssafe+=pwssafe;
	totmpwssafe+=mpwssafe;
	totothsafe+=othsafe;
	tothpsafe+=hpsafe;
	totshpsafe+=shpsafe;
	totpwsunsafe+=pwsunsafe;
	totmpwsunsafe+=mpwsunsafe;
	totothunsafe+=othunsafe;
	tothpunsafe+=hpunsafe;
	totshpunsafe+=shpunsafe;
	
	tothabs+=rset.getInt(2);
	
	totplainpop+=rset.getInt(3);
	totscpop+=rset.getInt(4);
	totstpop+=rset.getInt(5);
	totminpop+=rset.getInt("minority");
	totpop+=rset.getInt(6);
	totcpwscnt+=cpwscnt;totpwscnt+=pwscnt;totmpwscnt+=mpwscnt;totdpcnt+=dpcnt+owcnt;tothpcnt+=hpcnt;totshpcnt+=shpcnt;
	totnecpwscnt+=necpwscnt;totnepwscnt+=nepwscnt;totnempwscnt+=nempwscnt;totnedpcnt+=nedpcnt;totnehpcnt+=nehpcnt;totneshpcnt+=neshpcnt;
	totsafe+=rset.getDouble(7);
	totunsafe+=rset.getDouble(8);
	totfc+=rset.getInt(9);totpc1+=rset.getInt(10);totpc2+=rset.getInt(11);totpc3+=rset.getInt(12);totpc4+=rset.getInt(13);totnss+=rset.getInt(14);totnc+=rset.getInt(15);
	totprevfc+=rset.getInt(16);totprevpc1+=rset.getInt(17);totprevpc2+=rset.getInt(18);totprevpc3+=rset.getInt(19);totprevpc4+=rset.getInt(20);totprevnss+=rset.getInt(21);totprevnc+=rset.getInt(22);
}
%>
<tr>
<td class=gridhdbg style="text-align: center;" colspan="2">Total</td>
<td class=gridhdbg style="text-align: right;" ><%=tothabs %></td>
<td class=gridhdbg style="text-align: right;" ><%=totplainpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totscpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totstpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totminpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpop %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothouseholds %> </td>
<td class=gridhdbg style="text-align: right;" ><%= tothouseconn%></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totcpwssafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%= totpwssafe%></td>
<td class=gridhdbg style="text-align: right;" ><%= totpwsunsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%=totmpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%= totmpwssafe%></td>
<td class=gridhdbg style="text-align: right;" ><%= totmpwsunsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%=totdpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%= totothsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%= totothunsafe%></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpcnt+totshpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpsafe+totshpsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=tothpunsafe+totshpunsafe %></td>
<td class=gridhdbg style="text-align: right;" ><%=totplatforms %></td>
<td class=gridhdbg style="text-align: right;" ><%=totsoakpit %></td>
<!-- 
<td class=gridhdbg style="text-align: right;" ><%=totnecpwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnepwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnempwscnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnedpcnt %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnehpcnt+totneshpcnt %></td>
 -->
<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totsafe) %></td>
<td class=gridhdbg style="text-align: right;" ><%=ndf.format(totunsafe) %></td>

<td class=gridhdbg style="text-align: right;" ><%=totprevfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totprevnc %></td>

<td class=gridhdbg style="text-align: right;" ><%=totfc %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc1 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc2 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc3 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totpc4 %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnss %></td>
<td class=gridhdbg style="text-align: right;" ><%=totnc %></td>
</tr>

<%
if(rset!=null){
	rset.close();
}
if(st!=null){
	st.close();
}
}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
   
</table>
<%
} %>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p><%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


<table align="center">
<td align="center"><font color='red' size="2">Note:Based on Coverage Status.</font></td>
</table>