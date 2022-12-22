<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "asset-hab.xls");
String mcode="",pcode="",district="",temp="",tempconst="";
String dcode=(String)session.getAttribute("dcode");

if(session.getAttribute("mcode")!=null){
 mcode=(String)session.getAttribute("mcode");
}
if(session.getAttribute("pcode")!=null){
 pcode=(String)session.getAttribute("pcode");
}
DecimalFormat ndf = new DecimalFormat("####.##");
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";
int sno=1;
    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="rptHeading" > RWS&S-Assets with Habs Information								
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="2">Sl.No</td>
    <td class=gridhdbg rowspan="2">District</td>
    <td class=gridhdbg rowspan="2">Constituency</td>
    <td class=gridhdbg rowspan="2">Mandal</td>
    <td class=gridhdbg rowspan="2">Panchayat</td>
    <td class=gridhdbg rowspan="2">Habitation Code/Name</td>
    <td class=gridhdbg rowspan="1" colspan="4">Population</td>
    <td class=gridhdbg rowspan="1" colspan="5">Existing Assets(No.s)-Safe & Un-Safe in lead hab</td>
   <td class=gridhdbg rowspan="1" colspan="5">Existing Assets(No.s)-Safe & Un-Safe not in lead hab</td>
    <td class=gridhdbg rowspan="1" colspan="2">Level of supply</td>
	<td class=gridhdbg rowspan="1" colspan="2">Status</td>
	</tr>
	<tr>
	<td class=gridhdbg>Plain</td>
	<td class=gridhdbg>SC</td>
	<td class=gridhdbg>ST</td>
	<td class=gridhdbg>Total</td>
	<td class=gridhdbg>CPWS</td>
	<td class=gridhdbg>PWS</td>
	<td class=gridhdbg>MPWS</td>
	<td class=gridhdbg>Direct Pump</td>
	<td class=gridhdbg>HP/SHP's</td>
	<td class=gridhdbg>CPWS</td>
	<td class=gridhdbg>PWS</td>
	<td class=gridhdbg>MPWS</td>
	<td class=gridhdbg>Direct Pump</td>
	<td class=gridhdbg>HP/SHP's</td>
	<td class=gridhdbg>Safe</td>
	<td class=gridhdbg>Un-Safe</td>
	<td class=gridhdbg>Previous Year</td>
	<td class=gridhdbg>Current Year</td>
	
	</tr>
       
<%
try
{
	Statement st1=null,st=null;
	ResultSet rset=null,rset1=null;
	st1=conn.createStatement();
	String constqry="select distinct dcode,mcode,CONSTITUENCY_NAME,CONSTITUENCY_CODE from RWS_CONSTITUENCY_TBL where dcode='"+dcode+"' ";
	if(mcode !=null && !mcode.equals("")){
		constqry+=" and mcode='"+mcode+"'";
	}
	constqry+=" order by dcode,mcode,CONSTITUENCY_CODE";
	//System.out.println("111="+constqry);
	rset1=st1.executeQuery(constqry);
	Hashtable const_hash=new Hashtable();
	while(rset1.next()){
		const_hash.put(rset1.getString(1)+rset1.getString(2), rset1.getString(3));
	}
	if(rset1!=null){
		rset1.close();
	}
	if(st1!=null){
		st1.close();
	}
	
	st1=conn.createStatement();
	String assetqry="select hab_code,TYPE_OF_ASSET_NAME,count(1) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and substr(hab_code,1,2)='"+dcode+"'";
	if(mcode !=null && !mcode.equals("")){
		assetqry+=" and substr(hab_code,6,2)='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		assetqry+=" and substr(hab_code,13,2)='"+pcode+"'";
	}
	assetqry+=" group by hab_code,TYPE_OF_ASSET_NAME";
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
	String neassetqry="select c.hab_code,TYPE_OF_ASSET_NAME,count(distinct a.asset_code) from RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b,RWS_ASSET_HAB_TBL c where a.TYPE_OF_ASSET_code=b.TYPE_OF_ASSET_code and a.asset_code=c.asset_code and substr(c.hab_code,1,2)='"+dcode+"'";
	if(mcode !=null && !mcode.equals("")){
		neassetqry+=" and substr(c.hab_code,6,2)='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		neassetqry+=" and substr(c.hab_code,13,2)='"+pcode+"'";
	}
	neassetqry+=" group by c.hab_code,TYPE_OF_ASSET_NAME";
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
	
	String mainqry="select dname,nvl(mname,'-'),nvl(pname,'-'),panch_code,nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(SAFE_LPCD,0),nvl(UNSAFE_LPCD,0),nvl(PREVIOUS_YR_STATUS,'-'),nvl(coverage_status,'-'),dcode,mcode,pcode,panch_code from rws_complete_hab_view where dcode='"+dcode+"' ";
	if(mcode !=null && !mcode.equals("")){
		mainqry+=" and mcode='"+mcode+"'";
	}
	if(pcode !=null && !pcode.equals("")){
		mainqry+=" and pcode='"+pcode+"'";
	}
	mainqry+=" order by dcode,mcode,pcode";
	//System.out.println("222="+mainqry);
	st=conn.createStatement();
rset=st.executeQuery(mainqry);
while(rset.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0;
	 int necpwscnt=0,nepwscnt=0,nempwscnt=0,nedpcnt=0,nehpcnt=0,neshpcnt=0;
	 String constname="-";
	 if(const_hash.get(rset.getString(14)+rset.getString(15))!=null){
		 constname=(String)const_hash.get(rset.getString(14)+rset.getString(15));
	 }
	 if(asset_hash.get(rset.getString(4)+"CPWS")!=null){
		 cpwscnt=(Integer)asset_hash.get(rset.getString(4)+"CPWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"PWS")!=null){
		 pwscnt=(Integer)asset_hash.get(rset.getString(4)+"PWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"MPWS")!=null){
		 mpwscnt=(Integer)asset_hash.get(rset.getString(4)+"MPWS");
	 }
	 if(asset_hash.get(rset.getString(4)+"DIRECT PUMPING")!=null){
		 dpcnt=(Integer)asset_hash.get(rset.getString(4)+"DIRECT PUMPING");
	 }
	 if(asset_hash.get(rset.getString(4)+"HANDPUMPS")!=null){
		 hpcnt=(Integer)asset_hash.get(rset.getString(4)+"HANDPUMPS");
	 }
	 if(asset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS")!=null){
		 shpcnt=(Integer)asset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS");
	 }
	 
	 
	 if(neasset_hash.get(rset.getString(4)+"CPWS")!=null){
		 necpwscnt=(Integer)neasset_hash.get(rset.getString(4)+"CPWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"PWS")!=null){
		 nepwscnt=(Integer)neasset_hash.get(rset.getString(4)+"PWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"MPWS")!=null){
		 nempwscnt=(Integer)neasset_hash.get(rset.getString(4)+"MPWS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"DIRECT PUMPING")!=null){
		 nedpcnt=(Integer)neasset_hash.get(rset.getString(4)+"DIRECT PUMPING");
	 }
	 if(neasset_hash.get(rset.getString(4)+"HANDPUMPS")!=null){
		 nehpcnt=(Integer)neasset_hash.get(rset.getString(4)+"HANDPUMPS");
	 }
	 if(neasset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS")!=null){
		 neshpcnt=(Integer)neasset_hash.get(rset.getString(4)+"SHALLOW HAND PUMPS");
	 }
	 
	 district=rset.getString(1);
	 if(district.equals(temp)){
		 district="-";	 
	 }else{
		 district=rset.getString(1); 
	 }
	 
	
	%>
	<tr>
	 <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=district%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=constname%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(2)%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(3)%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=rset.getString(4)%>/<%=rset.getString(5)%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(6)%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(7)%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(8)%></td>
	 <td class="<%=style%> "style="text-align: right;"> <%=rset.getInt(9)%></td>
	 <td class="<%=style%> "style="text-align: right;"><%=cpwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=pwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=mpwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=dpcnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=hpcnt+shpcnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=necpwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=nepwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=nempwscnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=nedpcnt %></td>
		<td class="<%=style%> "style="text-align: right;"><%=nehpcnt+neshpcnt %></td>
			 <td class="<%=style%> "style="text-align: right;"> <%=rset.getDouble(10)%></td>
			 <td class="<%=style%> "style="text-align: right;"> <%=rset.getDouble(11)%></td>
			 <td class="<%=style%> "style="text-align: right;"> <%=rset.getString(12)%></td>
			 <td class="<%=style%> "style="text-align: right;"> <%=rset.getString(13)%></td>
	 	 
	 
	</tr>
	
	<%temp=rset.getString(1);
}
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
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>