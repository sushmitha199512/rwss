
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null;
	ResultSet rs1 = null;
	int Count, Cnt;
	String query = null;
	String query1 = null;
	ResultSetMetaData rsm=null;
	String district=request.getParameter("district");

	String dName = (String)session.getAttribute("dName");
	//System.out.println("Dname is  "+ dName);

	if(dName==null)
	{
		dName = request.getParameter("dName");
		session.setAttribute("dName",dName);
		session.setAttribute("dCode", district);
		//System.out.println("Dname 4444444444is  "+ dName);
	}

	
	
	try
	{
		
			 query = "SELECT  m.mcode AS \"MANDAL CODE\", m.mname AS \"MANDAL\", sum(CENSUS_PLAIN_POPU),sum(CENSUS_Sc_POPU),sum(CENSUS_St_POPU), sum(CENSUS_PLAIN_POPU+CENSUS_Sc_POPU+CENSUS_St_POPU),nvl(sum(HS.OHSRS_NO),0),nvl(sum(CISTERNS_NO),0), nvl(sum(CISTERNS_DK_SUPPLY),0), nvl(sum(HS.OHSRS_DK_SUPPLY),0), nvl(sum(GLSRS_NO),0),nvl(sum(GLSRS_DK_SUPPLY),0)   from RWS_HAB_SUPPLY_STATUS_TBL HS, rws_panchayat_raj_tbl P,rws_habitation_directory_tbl h, rws_mandal_tbl m where P.panch_code = HS.hab_code AND substr(HS.hab_code,1,2) = m.dcode AND substr(HS.hab_code,5,2) = m.mcode and h.hab_code = hs.hab_code AND substr(HS.hab_code,1,2) = '"+district+"' group by m.mname, m.mcode ORDER BY m.mname";
			//for rough use
			/*
			SELECT  m.mcode AS "MANDAL CODE", m.mname AS "MANDAL", sum(CENSUS_PLAIN_POPU),sum(CENSUS_Sc_POPU),sum(CENSUS_St_POPU), sum(CENSUS_PLAIN_POPU+CENSUS_Sc_POPU+CENSUS_St_POPU),
nvl(sum(OHSR_CODE),0),nvl(sum(OHSR_CAP_LTS ),0),
nvl(sum(glSR_CODE),0),nvl(sum(glSR_CAP_LTS),0),nvl(sum(CIS_NO),0), nvl(sum(CIS_CAP_LTS),0)  from RWS_PWS_CIS_SC_PARAM_TBL  c,RWS_PWS_OHSR_SC_PARAM_TBL oh,RWS_PWS_GLSR_SC_PARAM_TBL  gl, rws_panchayat_raj_tbl P,rws_habitation_directory_tbl h, rws_mandal_tbl m  where gl.asset_code=oh.asset_code and oh.asset_code=c.asset_code and gl.asset_code=c.asset_code and h.hab_code=P.panch_code AND substr(P.hab_code,1,2) = m.dcode AND substr(P.hab_code,5,2) = m.mcode and substr(P.hab_code,1,2) = '01' group by m.mname, m.mcode ORDER BY m.mname;


SELECT  m.mcode AS "MANDAL CODE", m.mname AS "MANDAL", sum(CENSUS_PLAIN_POPU),sum(CENSUS_Sc_POPU),sum(CENSUS_St_POPU), sum(CENSUS_PLAIN_POPU+CENSUS_Sc_POPU+CENSUS_St_POPU),nvl(sum(OHSR_CODE),0),nvl(sum(OHSR_CAP_LTS ),0)
  from RWS_PWS_OHSR_SC_PARAM_TBL oh, rws_panchayat_raj_tbl P, rws_habitation_directory_tbl h,rws_mandal_tbl m  where substr(P.hab_code,1,2) = m.dcode AND substr(P.hab_code,5,2) = m.mcode and substr(asset_code,5,2)=01 and substr(asset_code,9,2)=m.mcode  and h.hab_code=P.panch_code and substr(P.hab_code,1,2) = '01' group by m.mname, m.mcode ORDER BY m.mname;



			*/
			//System.out.println("panchayat="+  query);
		
		//System.out.println("query is  "+query);

	} 
	catch(Exception e)
	{
		 //System.out.println("for enumeration "+e);
	}

	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs = stmt.executeQuery(query);

	rsm=rs.getMetaData();
	Cnt=rsm.getColumnCount();

	try
	{
		String[] colLabel=null;
		ArrayList labelcol = new ArrayList();
		colLabel=new String[Cnt];
		for(int j=0,c=1; j<Cnt;j++,c++)
		{
			colLabel[j]=rsm.getColumnLabel(c);
		}
		labelcol.add(colLabel);

		session.setAttribute("arrayLabel", labelcol);
		String[] record = null;
		ArrayList myList = new ArrayList();
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

}catch(Exception e)
{
	//System.out.println("knk error is   "+e);
	//e.printStackTrace();
}
finally
{
	conn.close();
}

%>
<%@ include file = "rws_mandal_pws_status_detail_temp.jsp" %>