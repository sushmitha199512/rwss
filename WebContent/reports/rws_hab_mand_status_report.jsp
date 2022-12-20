<%@ include file = "conn.jsp" %>


<%	Statement st1 = null;
    Statement st7 = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSetMetaData rsm=null;
	//String st[]=new String[40];
	int Count=0,Cnt=0;
	//int start,end,limit = 3;
	String assetType = request.getParameter("aType");
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
	//String[] coverStatus = {"FC","PC1","PC2","PC3","PC4","NC","NSS", "UI"};
	ArrayList coverList  = null;
	ArrayList coverLst=new ArrayList();
	String mcode = null;

	if(dName==null || dName.equals("null"))
	{
		dName = request.getParameter("dname");
		session.setAttribute("dName",dName);
		
		dCode = request.getParameter("dcode");	
		
		session.setAttribute("dCode",dCode);
	}

	//System.out.println("name is "+dCode);
	String fdate = (String)session.getAttribute("FDATE");
	//String tdate = String.valueOf(session.getAttribute("tdate"));
	String distCode= request.getParameter("district");
	 

	int a=0,chkflag=0; 
	String q1="",query="", b1="",currentYear=null,query3=null;
	
	String names[] = request.getParameterValues("ch");
	//out.println(request.getParameterValues("ch"));
	if(names != null)
	{

	String[] w1=new String[names.length];	
	// System.out.println("MMMMM   "  +names.length);
	for (int i=0; i < names.length; i++)
	{
		// System.out.println(names[i]);
		String sr1 = names[i].substring(0,names[i].lastIndexOf(","));
		// System.out.println("YYYYYYYY   "+sr1);
		String sr2 = names[i].substring(names[i].lastIndexOf(",")+1, names[i].length());
		// System.out.println("YYYYYYYY   "+sr2);
		w1[i]=sr1 + " AS \"" + sr2 +"\"";
		q1=q1+","+w1[i];
	}
//System.out.println("Query  dddd "+q1);
//System.out.println("Query  dddd "+q1);
session.setAttribute("Query",q1);
}
else
{
q1=(String)session.getAttribute("Query");
//System.out.println("Query  fffff "+q1);
if(q1==null)
q1="";
}

try
{
	
	if(fdate!=null && !fdate.equals("0"))
	{
	b1 = " and status_date ='"+ fdate+"' ";
	session.setAttribute("fdate", fdate);
	//System.out.println("fadate is"+fdate);
	}
	
	/*else{	session.setAttribute("fdate", null);}*/
	/*java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
	java.util.Date currentDate1 = new java.util.Date();
	String currentYear=null;
	currentYear= dateFormat.format(currentDate1).substring(0,4);*/

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
//out.println();
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query3="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
rs2=st7.executeQuery(query3);

while (rs2.next())
	{
    	currentYear=rs2.getString(1);
	}

	if(fdate.substring(7,11).equals(currentYear))
	{
      if(assetType.equals("01"))
	  {
		  /*query ="select distinct d.mcode,d.mname,pr.panch_code,pr.panch_name "+q1+" from RWS_HABMAST_TBL a,RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where b.hab_code=a.prhab and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)and b.hab_code = PR.panch_CODE  and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' order by d.mcode,pr.panch_code";*/
		   query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl p,rws_village_tbl v,rws_constituency_tbl con where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode) and b.hab_code = PR.panch_CODE  and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and  substr(b.hab_code,8,3)=v.vcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    order by d.mcode,pr.panch_code";
	  }
  	//else if(assetType.equals("02") || assetType.equals("04"))
	  //{
		// query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and coverage_status is not null and coverage_status <> 'UI'  and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode) order by d.mcode,pr.panch_code";
      //}
		//code modified to display PublicInstitutions Details in ALL Option on 021208
  	  else if(assetType.equals("02"))//|| assetType.equals("04") code modified 
	  {
		query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode) and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  order by d.mcode,pr.panch_code";
	  }
	  else if(assetType.equals("04"))
	  {
		//query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_hab_institute_tbl p,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  group by d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code,nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_MINORITY_POPU,'0'),nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),nvl(PLAIN_POPU_COVERED,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),NVL(MINORITY_POP_COVERED ,'0'),nvl(to_char(UPDATE_DATE,'dd-mm-yyyy'),'-'),nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY ,'0'),nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT,'0'), nvl(HOUSEHOLDS_PLAIN,'0'),nvl(HOUSEHOLDS_SC,'0'),nvl(HOUSEHOLDS_ST,'0'),nvl(HOUSEHOLDS_MINORITY,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'),nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),nvl(OTHERS_NO_SAFE,'0'),nvl(OTHERS_SUPPLY_SAFE,'0'),nvl(HPS_NO_UNSAFE,'0'),nvl(HPS_OTH_SUPPLY_UNSAFE,'0'),nvl(PWS_UNSAFE_SUPPLY,'0'),nvl(PWS_UNSAFE_NO,'0'),nvl(MPWS_UNSAFE_SUPPLY,'0'),nvl(MPWS_UNSAFE_NO,'0'),nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),NC_SOURCE_TYPE,SOURCE_DISTANCE,nvl(QUALITY_AFFECTED,'-'),nvl(SLIPPAGE_CODE,'0'),EXIST_WATER_LEVEL ,nvl(WAY_POINT,'0'),nvl(LATITUDE,'0.0'),nvl(LONGITUDE,'0.0'),nvl(ELEVATION,'0.0'),nvl(LANDMARK,'-'),nvl(decode(LWE,'Y','Yes','N','No'),nvl(CON_PLAIN,'0'),nvl(CON_SC,'0'),nvl(CON_ST,'0'),nvl(CON_MINORITY,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0'),nvl(decode(IS_ITDA,'Y','Yes','N','No'),'-'),nvl(decode(MINORITY_DOMINATED,'Y','Yes','N','No'),'-')     order by d.mcode,pr.panch_code";
          query="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_hab_institute_tbl p,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  group by d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code,nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_MINORITY_POPU,'0'),nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),nvl(PLAIN_POPU_COVERED,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),NVL(MINORITY_POP_COVERED ,'0'),nvl(HOUSEHOLDS_PLAIN,'0'),nvl(HOUSEHOLDS_SC,'0'),nvl(HOUSEHOLDS_ST,'0'),nvl(HOUSEHOLDS_MINORITY,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'), nvl(WAY_POINT,'0'),nvl(LATITUDE,'0.0'),nvl(LONGITUDE,'0.0'),nvl(ELEVATION,'0.0'),nvl(LANDMARK,'-'), nvl(CON_PLAIN,'0'),nvl(CON_SC,'0'),nvl(CON_ST,'0'),nvl(CON_MINORITY,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0'), nvl(decode(IS_ITDA,'Y','Yes','N','No'),'-'),nvl(decode(MINORITY_DOMINATED,'Y','Yes','N','No'),'-'),nvl(decode(LWE,'Y','Yes','N','No'),'-'),nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY ,'0'),nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT,'0'), nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),nvl(OTHERS_NO_SAFE,'0'),nvl(OTHERS_SUPPLY_SAFE,'0'),nvl(HPS_NO_UNSAFE,'0'),nvl(HPS_OTH_SUPPLY_UNSAFE,'0'),nvl(PWS_UNSAFE_SUPPLY,'0'),nvl(PWS_UNSAFE_NO,'0'),nvl(MPWS_UNSAFE_SUPPLY,'0'),nvl(MPWS_UNSAFE_NO,'0'),nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),NC_SOURCE_TYPE,SOURCE_DISTANCE,nvl(QUALITY_AFFECTED,'-'),nvl(SLIPPAGE_CODE,'0'),EXIST_WATER_LEVEL,nvl(safe_lpcd,'0.0'),nvl(unsafe_lpcd,'0.0')      order by d.mcode,pr.panch_code";	  }
 	  else
	  {
		query ="select distinct d.mcode,con.constituency_name,d.mname,pa.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_constituency_tbl con,rws_mandal_tbl d,rws_village_tbl v,rws_panchayat_tbl pa,rws_hab_institute_tbl p where  substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code = PR.panch_CODE  and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)   and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and(substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode) group by d.mcode,d.mname,pr.panch_code,pr.panch_name,pa.pname,v.vname,con.constituency_name,to_char(b.UPDATE_DATE,'dd-mm-yyyy')   order by d.mcode,pr.panch_code";
      }
	 
	}
	else
	{
      if(assetType.equals("01"))
	  {
		  /*query ="select distinct d.mcode,d.mname,pr.panch_code,pr.panch_name "+q1+" from RWS_HABMAST_TBL a,RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where b.hab_code=a.prhab and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)and b.hab_code = PR.panch_CODE  and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' order by d.mcode,pr.panch_code";*/
		   query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode) and b.hab_code = PR.panch_CODE  and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI'  and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode  and substr(b.hab_code,8,3)=v.vcode) order by d.mcode,pr.panch_code";
	  }
  	 // else if(assetType.equals("02") || assetType.equals("04"))
	 // {
		 //query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIR_HIS_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and coverage_status is not null and coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)   and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode  and substr(b.hab_code,8,3)=v.vcode) order by d.mcode,pr.panch_code";
	 // }
		//code modified to display PublicInstitutions Details in ALL Option on 021208
	  else if(assetType.equals("02"))//|| assetType.equals("04")
	  {
		 query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode) order by d.mcode,pr.panch_code";
	  }
	  else if(assetType.equals("04"))//|| assetType.equals("04")
	  {
		// query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIR_HIS_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_hab_institute_tbl p,rws_panchayat_tbl pa,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode) group by d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code,nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),nvl(PLAIN_POPU_COVERED,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),nvl(to_char(UPDATE_DATE,'dd-mm-yyyy'),'-'),nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY ,'0'),nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'),nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),,nvl(OTHERS_NO_SAFE,'0'),nvl(OTHERS_SUPPLY_SAFE,'0'),nvl(HPS_NO_UNSAFE,'0'),nvl(HPS_OTH_SUPPLY_UNSAFE,'0'),nvl(PWS_UNSAFE_SUPPLY,'0'),nvl(PWS_UNSAFE_NO,'0'),nvl(MPWS_UNSAFE_SUPPLY,'0'),nvl(MPWS_UNSAFE_NO,'0'),nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),nvl(NC_SOURCE_TYPE ,'-'),nvl(SOURCE_DISTANCE ,'0'),nvl(QUALITY_AFFECTED,'-'),nvl(SLIPPAGE_CODE,'0') order by d.mcode,pr.panch_code";
		  //System.out.println("1*");
		  query ="select distinct d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_supply_status_tbl hp,rws_hab_institute_tbl p,rws_panchayat_tbl p,rws_constituency_tbl con,rws_village_tbl v where substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode) and b.hab_code =PR.panch_CODE and b.hab_code=hp.hab_code(+) and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and (substr(b.hab_code,1,2)=p.dcode and substr(b.hab_code,6,2)=p.mcode and substr(b.hab_code,13,2)=p.pcode) and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)    and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  group by d.mcode,con.constituency_name,d.mname,p.pname,v.vname,pr.panch_name,pr.panch_code ,nvl(CENSUS_PLAIN_POPU,'0'),nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_MINORITY_POPU,'0'),nvl(FLOAT_POP,'0'),nvl(FLOAT_POP_REASONS ,'-'),nvl(PLAIN_POPU_COVERED,'0'),nvl(SC_POP_COVERED,'0'),nvl(ST_POP_COVERED,'0'),NVL(MINORITY_POP_COVERED ,'0'),nvl(HOUSEHOLDS_PLAIN,'0'),nvl(HOUSEHOLDS_SC,'0'),nvl(HOUSEHOLDS_ST,'0'),nvl(HOUSEHOLDS_MINORITY,'0'),nvl(HOUSEHOLD_NO,'0'),nvl(NO_OF_CATTLE ,'0'), nvl(WAY_POINT,'0'),nvl(LATITUDE,'0.0'),nvl(LONGITUDE,'0.0'),nvl(ELEVATION,'0.0'),nvl(LANDMARK,'-'), nvl(CON_PLAIN,'0'),nvl(CON_SC,'0'),nvl(CON_ST,'0'),nvl(CON_MINORITY,'0'),nvl(NO_OF_HOUSECONN_GIVEN,'0'), nvl(decode(IS_ITDA,'Y','Yes','N','No'),'-'),nvl(decode(MINORITY_DOMINATED,'Y','Yes','N','No'),'-'),nvl(decode(LWE,'Y','Yes','N','No'),'-'),nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),nvl(HPS_NO,'0'),nvl(HPS_OTH_SUPPLY,'0'),nvl(PWS_NO,'0'),nvl(PWS_SUPPLY,'0'),nvl(MPWS_NO,'0'),nvl(MPWS_SUPPLY,'0'),nvl(CPWS_NO,'0'),nvl(CPWS_SUPPLY,'0'),nvl(OWS_NO,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(OWS_OTH_SUPPLY ,'0'),nvl(PONDS_NO,'0'),nvl(PONDS_OTH_SUPPLY ,'0'),nvl(SHP_NO,'0'),nvl(SHP_DK_SUPPLY,'0'),nvl(OTHERS_NO,'0'),nvl(OTHERS_SUPPLY ,'0'),nvl(PREVIOUS_YR_STATUS,'-'),nvl(b.COVERAGE_STATUS,'-'),nvl(NEAR_SURFACE_SOURCE,'0'),nvl(NEAR_GROUND_SOURCE,'0'),nvl(PROPOSED_FC_YEAR ,'-'),nvl(PROPOSED_FC_EST_AMT,'0'), nvl(HABITATION_TYPE,'-'),nvl(HABITATION_SUB_TYPE,'-'),nvl(HABITATION_CATEGORY ,'-'),nvl(OTHERS_NO_SAFE,'0'),nvl(OTHERS_SUPPLY_SAFE,'0'),nvl(HPS_NO_UNSAFE,'0'),nvl(HPS_OTH_SUPPLY_UNSAFE,'0'),nvl(PWS_UNSAFE_SUPPLY,'0'),nvl(PWS_UNSAFE_NO,'0'),nvl(MPWS_UNSAFE_SUPPLY,'0'),nvl(MPWS_UNSAFE_NO,'0'),nvl(EXISTING_SOURCES_NO,'0'),nvl(SAFE_SOURCES_NO ,'0'),NC_SOURCE_TYPE,SOURCE_DISTANCE,nvl(QUALITY_AFFECTED,'-'),nvl(SLIPPAGE_CODE,'0'),EXIST_WATER_LEVEL ,nvl(safe_lpcd,'0.0'),nvl(unsafe_lpcd,'0.0') order by d.mcode,pr.panch_code";
          //System.out.println("2*");
		//
 	       
	  }
 	  else
	  {
       // System.out.println("32");
		query ="select distinct d.mcode,con.constituency_name,d.mname,pa.pname,v.vname,pr.panch_name,pr.panch_code "+q1+" from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_constituency_tbl con,rws_mandal_tbl d,rws_village_tbl v,rws_panchayat_tbl pa,rws_hab_institute_tbl p where  substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code = PR.panch_CODE  and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and b.coverage_status is not null and b.coverage_status <> 'UI' and con.dcode=substr(b.hab_code,1,2)  and con.mcode=substr(b.hab_code,6,2)   and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and(substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)   group by d.mcode,d.mname,pr.panch_code,pr.panch_name,pa.pname,v.vname,con.constituency_name,to_char(b.UPDATE_DATE,'dd-mm-yyyy')  order by d.mcode,pr.panch_code";
		//query ="select distinct nvl(to_char(b.UPDATE_DATE,'dd-mm-yyyy'),'-'),d.mname,pr.panch_name "+q1+",pr.panch_code,d.mcode from RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIR_HIS_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_hab_institute_tbl p where  substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and b.hab_code = PR.panch_CODE  and b.hab_code=p.hab_code(+) and substr(b.hab_code,1,2)='"+dCode+"' and b.status_date='"+fdate+"' and coverage_status is not null and coverage_status <> 'UI' group by d.mcode,d.mname,pr.panch_code,pr.panch_name,to_char(b.UPDATE_DATE,'dd-mm-yyyy')  order by d.mcode,pr.panch_code";
       }
	}

     // System.out.println("panchayat="+panchayat);
    // String a1=" group by m.mcode,m.mname order by m.mname";
   //query=query+a1;
  // System.out.println("Query   is *****************22 : "+query);
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  //   System.out.println("q1********"+q1);
    // System.out.println("query********"+query);
	 stmt1 = conn.createStatement();
	 rs = stmt.executeQuery(query);
	 rs.setFetchSize(4000);
	 rs.last();
	Count = rs.getRow();
   // System.out.println("Count*****"+Count);
	// System.out.println("Total Records = "+Count);
	rs.beforeFirst();
	//session.setAttribute("RSet",rs);
	//session.setAttribute("RSet1",rs1);
	rsm=rs.getMetaData();
	Cnt=rsm.getColumnCount();
  //  System.out.println("Cnt*****"+Cnt);

	String[] colLabel=null;
	ArrayList labelcol = new ArrayList();

	colLabel=new String[Cnt];
	
	for(int j=0,c=1; j<Cnt;j++,c++)
	{
		colLabel[j]=rsm.getColumnLabel(c);
		//System.out.println("colLabel"+colLabel[j]);
		if(colLabel[j].equals("Status") && chkflag==0){
		//System.out.println("coverage status is checked");
		//System.out.println("colcount of status-------->"+j);
		session.setAttribute("statuscount", j+"");
		chkflag=1;
		} 
		//else{		
		//session.setAttribute("statuscount","0");
		//}
		if(colLabel[j].equals("slippage")&& chkflag==1 ){
		//System.out.println("Reasons for slippage is checked");
		//System.out.println("colcount of slippage-------->"+j);
		chkflag=2;
		session.setAttribute("slippagecount", j+"");
		} 
		//else{		
		//session.setAttribute("slippagecount","0");
		//}
		
	}
	labelcol.add(colLabel);

	session.setAttribute("arrayLabel", labelcol);
	String[] record = null;
	int[] coverrecord ;
	ArrayList myList = new ArrayList();
	coverList = new ArrayList();
	ResultSetMetaData resultSetMetaData = rs.getMetaData ();
      int columnCount = resultSetMetaData.getColumnCount ();
      String columnlable=null;
    if(chkflag>1){
	//System.out.println("in this loop 1");
	while(rs.next())
	{
	record = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
			record[z] = rs.getString(c);
		}
		myList.add(record);
		}session.setAttribute("arrayList", myList);
	}else{
	while(rs.next())
	{
		record = new String[Cnt];
		for(int z=0,c=1;z<Cnt && c<=Cnt;z++,c++)
		{
			record[z] = rs.getString(c);
		}
		myList.add(record);
		}
		session.setAttribute("arrayList", myList);
		}
		
		
    //myList.add(record);
	//session.setAttribute("arrayList",myList);
	//System.out.println("size is"+myList.size());
	%>
	<%@ include file="./rws_hab_mand_report_temp.jsp"%>
	<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
