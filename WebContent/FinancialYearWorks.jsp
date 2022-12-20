
<%@page import="nic.watersoft.commons.ValidationUtils"%>
<%@page import="nic.watersoft.commons.Constants"%>
<%@ include file="/reports/conn.jsp"%>
<%
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	Statement st2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	Statement st6 = null;
	Statement st7 = null;
	Statement st8 = null;
	ResultSet rs5 = null;
	ResultSet rs6 = null;
	ResultSet rs7 = null;
	ResultSet rs8 = null;

	try {
		
		ValidationUtils utils=new ValidationUtils();
		String finYear = request.getParameter("finyear");
		if(utils.financialYearValidator(finYear)){
		
		String progCodes = Constants.getNrdwp();
		String schemes = "'01','02','03','10'";
		//progCodes=progCodes+",04,65,70,57,77";
		//System.out.println("progCodes---"+progCodes);
		
		
		String reqMode = request.getParameter("reqMode");
	//	System.out.println(reqMode);
		String dcode = request.getParameter("dcode");
		if ((dcode == null || dcode.equals("")) && reqMode != null && reqMode.equals("update")) {
			java.util.Date currentDate = new java.util.Date();
			int cyear = currentDate.getYear() + 1900;
			int pyear = currentDate.getYear() + 1900 - 1;
			int sources = 0, flouride = 0, brakish = 0, iron = 0, nitrate = 0;

			String programQuery = " and substr(w.work_id,1,2) in ("	+ progCodes + ") and ";
			String habtable = "RWS_HABITATION_DIRECTORY_TBL";
			
			int month = currentDate.getMonth();
			//System.out.println("month :"+month);
			
			if (finYear != null) {
				String fyears[] = finYear.split("-");
				String fy = fyears[0].substring(2, 4);

				//System.out.println("Before String.valueOf(cyear) :"+String.valueOf(cyear));
				//Code writen on 27-01-2022
				if(month<3)
					{
						cyear = cyear -1;
					}
				//System.out.println("fyears[0] :"+fyears[0]);
				//System.out.println("After String.valueOf(cyear) :"+String.valueOf(cyear));
				
				if (fyears[0].equals(String.valueOf(cyear))) {
					habtable = "RWS_HABITATION_DIRECTORY_TBL";
				} else if (fyears[0].equals(String.valueOf(pyear))) {
					habtable = "RWS_HABITATION_DIR_HIS_TBL";
				} else if (Integer.parseInt(fyears[0]) > 2005) {
					habtable = "RWS_HABITATION_DIR_HIS" + fyears[0]	+ "_TBL";
				} else {
					habtable = "RWS_HABITATION_DIRECTORY_TBL";
				}
				/* String query = "select (SELECT count(*) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]
						+ "') and  substr(w.work_id,7,2)='01'  "+programQuery+" w.work_cancel_dt is null and substr(w.work_id,7,2) not in ('11','12') and w.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id=w.work_id and m.work_id=i.work_id) ongoingpws "
				+" ,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]	+ "') and  substr(w.work_id,7,2)='03' "+programQuery+"  w.work_cancel_dt is null and substr(w.work_id,7,2) not in ('11','12') and w.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id=w.work_id and m.work_id=i.work_id) ongoingcpws "
				+",(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]
						+ "') and   substr(w.work_id,7,2)='01'  "+programQuery+"  w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null)notgroundedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]
						+ "') and  substr(w.work_id,7,2)='03'  "+programQuery+"  w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null)notgroundedcpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(DATE_OF_COMPLETION,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "') ) and w.work_cancel_dt is null "+programQuery+"   substr(w.work_id,7,2)='01')completedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(DATE_OF_COMPLETION,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "') ) and w.work_cancel_dt is null "+programQuery+"  substr(w.work_id,7,2)='03')completedcpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMPLETION<'01/APR/"
						+ fyears[1]
						+ "' )  and date_of_comm is not null ) and w.work_cancel_dt is null "+programQuery+"  substr(w.work_id,7,2)='01')commisionedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMM is not null and DATE_OF_COMM>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMM<'01/APR/"
						+ fyears[1]
						+ "' )  and date_of_comm is not null ) "+programQuery+" w.work_cancel_dt is null AND  substr(w.work_id,7,2)='03')commisionedcpws,(select count(*) from RWS_WQ_TEST_RESULTS_TBL r where r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' )phy,(select count(*) from RWS_WQ_TEST_RESULTS_TBL r where  r.test_code='2' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' )bact, (select count(distinct dcode||mcode) from rws_complete_hab_View)mandals,(select count(distinct dcode||mcode||pcode) from rws_complete_hab_View)panchayats,(select count(distinct dcode||mcode||pcode||vcode) from rws_complete_hab_View)villages, (select count(*) from "+habtable+" a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.coverage_status <>'UI' and a.coverage_status is not null)habs,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "')pws,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%') and  DATE_CREATION <'01/APR/"+ fyears[1]+ "')mpws,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and M.HAB_CODE=H.PANCH_CODE and SUBSTR(SCHEME_CODE,17,3) LIKE '8%' and DATE_CREATION <'01/APR/"+ fyears[1]+ "' )cpws,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S , RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and DATE_CREATION <'01/APR/"+ fyears[1]+ "') borewells,(select count(*) from rws_water_quality_lab_tbl where status<>'UI' and substr(OFFICE_CODE,2,2)  not in ('14','15','16','17','18','19','20','21','22','23') )  labs ,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r where  to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' )totsources,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='13' AND TESTING_PARAMETER_VALUE > 1.5) )flouride,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='05' AND TESTING_PARAMETER_VALUE > 2000) )brakish,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='16' AND TESTING_PARAMETER_VALUE > 0.3) )iron,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"
						+ fyears[0]
						+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"
						+ fyears[1]
						+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='15' AND TESTING_PARAMETER_VALUE > 45) )nitrate from dual"; */
						
						
						/*before modification   on Nov 2018*/
						/* "select (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in('01','02','10')  "
						+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') ongoingpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) ongoingcpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='01'  "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') groundingpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery + "  w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) groundingcpws, "
						+" (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2)='01'  "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') underprogresspws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION  is not null ) and  substr(w.work_id,7,2)='03' "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) underprogresscpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2)='01'  "
						+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedcpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2)='01' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + "  substr(w.work_id,7,2)='03' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedcpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2)='01' and w.CORE_DASHBOARD_STATUS='Y') commisionedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) "
						+ programQuery + " w.work_cancel_dt is null AND  substr(w.work_id,7,2)='03'  and w.CORE_DASHBOARD_STATUS='Y') commisionedcpws, "  */
						
						/* Modified as per the requirement of Bangarraju Sir on 02-11-2018 (In Mail)*/
						/* Commented on 25-01-2022 by sagar	
						String query = "select (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")  "
						+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') ongoingpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') groundingpws, "
						+" (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') underprogresspws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+")  "
						+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and w.CORE_DASHBOARD_STATUS='Y') commisionedpws, "
						+ " (select count(*) from RWS_WQ_TEST_RESULTS_TBL r where r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]	+ "' )phy, "
						+ " (select count(*) from RWS_WQ_TEST_RESULTS_TBL r where  r.test_code='2' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' )bact, "
						+ " (select count(distinct dcode||mcode) from rws_complete_hab_View) mandals,"
						+ " (select count(distinct dcode||mcode||pcode) from rws_complete_hab_View) panchayats, "
						+ " (select count(distinct dcode||mcode||pcode||vcode) from rws_complete_hab_View) villages, "
						+ " (select count(*) from "+ habtable+ " a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.coverage_status <>'UI' and a.coverage_status is not null)habs,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "')pws, "
						+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%') and  DATE_CREATION <'01/APR/"+ fyears[1]+ "')mpws, "
						+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and M.HAB_CODE=H.PANCH_CODE and SUBSTR(SCHEME_CODE,17,3) LIKE '8%' and DATE_CREATION <'01/APR/"	+ fyears[1]	+ "' )cpws, "
						+ " (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S , RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and DATE_CREATION <'01/APR/"+ fyears[1]+ "') borewells, "
						+ " (select count(*) from rws_water_quality_lab_tbl where status<>'UI' and substr(OFFICE_CODE,2,2)  not in ('14','15','16','17','18','19','20','21','22','23') )  labs ,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r where  to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]+ "' )totsources,"
						+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]	+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='13' AND TESTING_PARAMETER_VALUE > 1.5) ) flouride,"
						+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]	+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='05' AND TESTING_PARAMETER_VALUE > 2000) )brakish, "
						+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]	+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='16' AND TESTING_PARAMETER_VALUE > 0.3) )iron, "
						+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+ fyears[0]+ "' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+ fyears[1]	+ "' and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='15' AND TESTING_PARAMETER_VALUE > 45) )nitrate from dual";				
						*/
						// Query re-Write on 27-01-2022 by sagar (changes date format conversions)	
						String query = "select (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")  "
								+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') ongoingpws, "
								+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")   "
								+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') groundingpws, "
								+" (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ " where w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+")   "
								+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') underprogresspws, "
								+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
								+ " where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+")  "
								+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedpws, "
								+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
								+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>=to_date('01/APR/"+fyears[0]+"','dd/mon/yyyy'))) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
								+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedpws, "
								+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
								+ " where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) and w.work_cancel_dt is null "
								+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and w.CORE_DASHBOARD_STATUS='Y') commisionedpws, "
								+ " (select count(*) from RWS_WQ_TEST_RESULTS_TBL r where r.test_code='1' and r.PREPARED_ON >=to_date('01/APR/"+fyears[0]+"','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]	+ "','dd/mon/yyyy') )phy, "
								+ " (select count(*) from RWS_WQ_TEST_RESULTS_TBL r where  r.test_code='2' and r.PREPARED_ON >=to_date('01/APR/"+fyears[0]+"','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]+ "','dd/mon/yyyy') )bact, "
								+ " (select count(distinct dcode||mcode) from rws_complete_hab_View) mandals,"
								+ " (select count(distinct dcode||mcode||pcode) from rws_complete_hab_View) panchayats, "
								+ " (select count(distinct dcode||mcode||pcode||vcode) from rws_complete_hab_View) villages, "
								+ " (select count(*) from "+ habtable+ " a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.coverage_status <>'UI' and a.coverage_status is not null)habs,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S ,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+ fyears[1]+ "')pws, "
								+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%') and  DATE_CREATION <'01/APR/"+ fyears[1]+ "')mpws, "
								+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' and M.HAB_CODE=H.PANCH_CODE and SUBSTR(SCHEME_CODE,17,3) LIKE '8%' and DATE_CREATION <'01/APR/"	+ fyears[1]	+ "' )cpws, "
								+ " (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S , RWS_COMPLETE_HAB_VIEW H WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='04' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and DATE_CREATION <'01/APR/"+ fyears[1]+ "') borewells, "
								+ " (select count(*) from rws_water_quality_lab_tbl where status<>'UI' and substr(OFFICE_CODE,2,2)  not in ('14','15','16','17','18','19','20','21','22','23') )  labs ,(select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r where  r.PREPARED_ON >=to_date('01/APR/"+ fyears[0]+ "','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]+ "','dd/mon/yyyy') )totsources,"
								+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and r.PREPARED_ON >=to_date('01/APR/"+ fyears[0]+ "','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]	+ "','dd/mon/yyyy') and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='13' AND TESTING_PARAMETER_VALUE > '1.5') ) flouride,"
								+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and r.PREPARED_ON >=to_date('01/APR/"+ fyears[0]+ "','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]	+ "','dd/mon/yyyy') and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='05' AND TESTING_PARAMETER_VALUE > '2000') )brakish, "
								+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and r.PREPARED_ON >=to_date('01/APR/"+ fyears[0]+ "','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]	+ "','dd/mon/yyyy') and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='16' AND TESTING_PARAMETER_VALUE > '0.3') )iron, "
								+ " (select count(distinct source_code) from RWS_WQ_TEST_RESULTS_TBL r,RWS_WQ_TEST_RESULTS_LNK_TBL l where  r.test_code='1' and r.PREPARED_ON >=to_date('01/APR/"+ fyears[0]+ "','dd/mon/yyyy') and r.PREPARED_ON<to_date('01/APR/"+ fyears[1]	+ "','dd/mon/yyyy') and r.test_id=l.test_id and (TESTING_PARAMETER_CODE='15' AND TESTING_PARAMETER_VALUE > '45') )nitrate from dual";
	//System.out.println("query 1234 :"+query);
				//	String query1 = "select sum(case when a.coverage_status='FC' then 1 else 0 end)fc,sum(case when a.coverage_status='PC4' then 1 else 0 end) PC4,sum(case when a.coverage_status='PC3' then 1 else 0 end)PC3,sum(case when a.coverage_status='PC2' then 1 else 0 end) PC2,sum(case when a.coverage_status='PC1' then 1 else 0 end)PC1,sum(case when a.coverage_status='NSS' then 1 else 0 end) NSS,sum(case when a.coverage_status='NC' then 1 else 0 end)Nc from "
				//			+ habtable + " a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.COVERAGE_STATUS<>'UI' and a.COVERAGE_STATUS is not null  ";
				String query1 = "select sum(case when a.safe_lpcd>=55 then 1 else 0 end) fc, "
						+ " sum(case when a.safe_lpcd>=41.25 and a.safe_lpcd<55 then 1 else 0 end) PC4, "
						+ " sum(case when a.safe_lpcd>=27.50 and a.safe_lpcd<41.25 then 1 else 0 end) PC3, "
						+ " sum(case when a.safe_lpcd>=13.75 and a.safe_lpcd<27.50 then 1 else 0 end) PC2, " 
						+ " sum(case when a.safe_lpcd>0 and a.safe_lpcd<13.75 then 1 else 0 end) PC1, "
						+ " sum(case when a.safe_lpcd=0 and a.unsafe_lpcd<>0 then 1 else 0 end) NSS, "
						+ " sum(case when a.safe_lpcd=0 and a.unsafe_lpcd=0  then 1 else 0 end) NC from "
						+ habtable + " a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.COVERAGE_STATUS<>'UI' and a.COVERAGE_STATUS is not null and substr(hab_code,1,2) in('01','02','03','04','05','06','07','08','09','10','11','12','13')";
			
				
				//System.out.println("Query:"+query);
				//System.out.println("Query incoverage:"+query1);

				/* added by Sowjanya on 04/08/2015 for schemes (PWS,CPWS,MPWS,HP) count based on AssetAbstract report (Masters/AssetReports/16th report(AssetAbstract report)) */
				String pws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='01'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st5 = conn.createStatement();
				rs5 = st5.executeQuery(pws);
		//	System.out.println("pwsQuery:"+pws);
				int pwscount = 0;
				while (rs5.next()) {
					pwscount = pwscount + rs5.getInt(1);
				}
				//System.out.println("pwscount----"+pwscount);

				String cpws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='03'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st6 = conn.createStatement();
				rs6 = st6.executeQuery(cpws);
			//	System.out.println("cpwsQuery:" + cpws);
				int cpwscount = 0;
				while (rs6.next()) {
					cpwscount = cpwscount + rs6.getInt(1);
				}
			//	System.out.println("cpwscount----"+cpwscount);

				String mpws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='02'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"	+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st7 = conn.createStatement();
				rs7 = st7.executeQuery(mpws);
				//System.out.println("mpwsQuery:"+mpws);
				int mpwscount = 0;
				while (rs7.next()) {
					mpwscount = mpwscount + rs7.getInt(1);
				}
				//System.out.println("mpwscount----"+mpwscount);

				String hp = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE M.TYPE_OF_ASSET_CODE='04'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st7 = conn.createStatement();
				rs7 = st7.executeQuery(hp);
			//	System.out.println("hpQuery:" + hp);
				int hpcount = 0;
				while (rs7.next()) {
					hpcount = hpcount + rs7.getInt(1);
				}
				//System.out.println("hpcount----"+hpcount);
				/*End of PWS,CPWS,MPWS,HP Query*/

				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				rs2 = st2.executeQuery(query);
				rs2.next();
				rs3 = st3.executeQuery(query1);
				rs3.next();
				sources = rs2.getInt("totsources");
				flouride = rs2.getInt("flouride");
				brakish = rs2.getInt("brakish");
				iron = rs2.getInt("iron");
				nitrate = rs2.getInt("nitrate");
				st4.executeUpdate("delete from rws_secretary_details_tbl where fin_year='"+finYear+"' and dcode is null ");
			//	System.out.println("before insert");
				String insertQuery = "insert into rws_secretary_details_tbl(MANDALS,PANCHAYATS,VILLAGES,HABS,PWS,MPWS,CPWS,BOREWELLS,ONGOING,NOTGROUNDED,COMPLETED,COMMISSIONED,FC,PC4,PC3,PC2,PC1,NSS,NC,PHY_TESTS,BACT_TESTS"+/* ,CPWS_ONGOING,CPWS_NOTGROUNDED,CPWS_COMPLETED,CPWS_COMMISSIONED */",FIN_YEAR,TOT_LABS,TOT_SOURCES_TESTS,CONTAMINATION_FLOURIDE,CONTAMINATION_BRAKISH,CONTAMINATION_IRON,CONTAMINATION_NITRATE,GROUNDED,"+/* CPWS_GROUNDED, */"UNDERPROGRESS"+/* ,CPWS_UNDERPROGRESS */") values('"
						+ rs2.getString("mandals")
						+ "','"
						+ rs2.getString("panchayats")
						+ "','"
						+ rs2.getString("villages")
						+ "','"
						+ rs2.getString("habs")
						+ "','"
						+ pwscount
						+ "','"
						+ mpwscount
						+ "','"
						+ cpwscount
						+ "','"
						+ hpcount
						+ "','"
						+ rs2.getString("ongoingpws")
						+ "','"
						+ rs2.getString("notgroundedpws")
						+ "','"
						+ rs2.getString("completedpws")
						+ "','"
						+ rs2.getString("commisionedpws")
						+ "','"
						+ rs3.getString("fc")
						+ "','"
						+ rs3.getString("PC4")
						+ "','"
						+ rs3.getString("PC3")
						+ "','"
						+ rs3.getString("PC2")
						+ "','"
						+ rs3.getString("PC1")
						+ "','"
						+ rs3.getString("NSS")
						+ "','"
						+ rs3.getString("NC")
						+ "','"
						+ rs2.getString("phy")
						+ "','"
						+ rs2.getString("bact")
						+ "','"
					/* + rs2.getString("ongoingcpws")
						+ "','"
						+ rs2.getString("notgroundedcpws")
						+ "','"
						+ rs2.getString("completedcpws")
						+ "','"
						+ rs2.getString("commisionedcpws")
						+ "','" */
						+ finYear
						+ "','"
						+ rs2.getString("labs") 
						+ "','"
						+ sources
						+ "','"
						+ flouride
						+ "','"
						+ brakish
						+ "','"
						+ iron
						+ "','" 
						+ nitrate 
						+ "','"
						+ rs2.getString("groundingpws")
					/* 	+ "','"
						+ rs2.getString("groundingcpws") */
						+ "','"
						+ rs2.getString("underprogresspws")
					/* 	+ "','"
						+ rs2.getString("underprogresscpws") */ + "')";
				//System.out.println(insertQuery);
				st4.executeUpdate(insertQuery);
%>
<%-- <%=rs2.getString(11) + "/" + rs2.getString(12) + "/"
						+ rs2.getString(13) + "/" + rs2.getString(14) + "/"
						+ rs2.getString(15) + "/" + rs2.getString(16) + "/"+ rs2.getString(17) + "/" + rs2.getString(18) + "/" + rs2.getString(1) + "/" + rs2.getString(3) + "/"+ rs2.getString(5) + "/" + rs2.getString(7) + "/" + rs3.getString(1) + "/" + rs3.getString(2) + "/"+ rs3.getString(3) + "/"+ rs3.getString(4) + "/"+ rs3.getString(5) + "/"+ rs3.getString(6) + "/"
						+ rs3.getString(7) + "/" + rs2.getString(9) + "/"
						+ rs2.getString(10) + "/" + rs2.getString(2) + "/"
						+ rs2.getString(4) + "/" + rs2.getString(6) + "/"
						+ rs2.getString(8) +"/" + rs2.getString(19)  %> --%>

<%=rs2.getString("mandals") + "/" + rs2.getString("panchayats")
								+ "/" + rs2.getString("villages") + "/"
								+ rs2.getString("habs") + "/" + pwscount + "/"
								+ mpwscount + "/" + cpwscount + "/" + hpcount
								+ "/" + rs2.getString("ongoingpws") + "/"
								+ rs2.getString("notgroundedpws") + "/" + rs2.getString("completedpws")
								+ "/" + rs2.getString("commisionedpws") + "/"
								+ rs3.getString("fc") + "/" + rs3.getString("PC4")
								+ "/" + rs3.getString("PC3") + "/"
								+ rs3.getString("PC2") + "/" + rs3.getString("PC1")
								+ "/" + rs3.getString("NSS") + "/"
								+ rs3.getString("NC") + "/" + rs2.getString("phy")
								+ "/" + rs2.getString("bact") + "/"
							/* 	+ rs2.getString("ongoingcpws") + "/" + rs2.getString("notgroundedcpws")
								+ "/" + rs2.getString("completedcpws") + "/"
								+ rs2.getString("commisionedcpws") + "/"  */+ rs2.getString("labs")
								+ "/" + sources + "/" + flouride + "/"
								+ brakish + "/" + iron + "/" + nitrate
								+ "/" + rs2.getString("groundingpws")/*  + "/" + rs2.getString("groundingcpws") */
								+ "/" + rs2.getString("underprogresspws") /* + "/" + rs2.getString("underprogresscpws") */%>
						
								
<%
	}
		} else if ((dcode == null || dcode.equals(""))	&& reqMode != null && reqMode.equals("view")) {
			//System.out.println("2222222222:");
			st2 = conn.createStatement();
			String viewQuery = "select MANDALS,PANCHAYATS,VILLAGES,HABS,PWS,MPWS,CPWS,BOREWELLS,ONGOING,NOTGROUNDED,COMPLETED,COMMISSIONED,FC,PC4,PC3,PC2,PC1,NSS,NC,PHY_TESTS,BACT_TESTS"+/* ,CPWS_ONGOING,CPWS_NOTGROUNDED,CPWS_COMPLETED,CPWS_COMMISSIONED */",TOT_LABS,TOT_SOURCES_TESTS,CONTAMINATION_FLOURIDE,CONTAMINATION_BRAKISH,CONTAMINATION_IRON,CONTAMINATION_NITRATE,GROUNDED,UNDERPROGRESS"+/* ,CPWS_GROUNDED,CPWS_UNDERPROGRESS */" from rws_secretary_details_tbl where fin_year='"+finYear+"' and dcode is null";
			rs2 = st2.executeQuery(viewQuery);
			while (rs2.next()) { %>
			
<%=rs2.getString("MANDALS") + "/" + rs2.getString("PANCHAYATS")
						+ "/" + rs2.getString("VILLAGES") + "/"
						+ rs2.getString("HABS") + "/" + rs2.getString("PWS")
						+ "/" + rs2.getString("MPWS") + "/"
						+ rs2.getString("CPWS") + "/" + rs2.getString("BOREWELLS")
						+ "/" + rs2.getString("ONGOING") + "/"
						+ rs2.getString("NOTGROUNDED") + "/" + rs2.getString("COMPLETED")
						+ "/" + rs2.getString("COMMISSIONED") + "/"
						+ rs2.getString("FC") + "/" + rs2.getString("PC4")
						+ "/" + rs2.getString("PC3") + "/"
						+ rs2.getString("PC2") + "/" + rs2.getString("PC1")
						+ "/" + rs2.getString("NSS") + "/"
						+ rs2.getString("NC") + "/" + rs2.getString("PHY_TESTS")
						+ "/" + rs2.getString("BACT_TESTS") +/*  "/"
						+ rs2.getString("CPWS_ONGOING") + "/" + rs2.getString("CPWS_NOTGROUNDED")
						+ "/" + rs2.getString("CPWS_COMPLETED") + "/"
						+ rs2.getString("CPWS_COMMISSIONED") + */ "/" + rs2.getString("TOT_LABS")
						+ "/" + rs2.getString("TOT_SOURCES_TESTS") + "/"
						+ rs2.getString("CONTAMINATION_FLOURIDE") + "/" + rs2.getString("CONTAMINATION_BRAKISH")
						+ "/" + rs2.getString("CONTAMINATION_IRON") + "/" + rs2.getString("CONTAMINATION_NITRATE")
						+ "/" + rs2.getString("GROUNDED") /* + "/" + rs2.getString("CPWS_GROUNDED") */
						+ "/" + rs2.getString("UNDERPROGRESS") /* + "/" + rs2.getString("CPWS_UNDERPROGRESS")		 */			
						%>
<%
	}
		} else if (dcode != null && reqMode != null	&& reqMode.equals("update")) {
			java.util.Date currentDate = new java.util.Date();
			int cyear = currentDate.getYear() + 1900;
			int pyear = currentDate.getYear() + 1900 - 1;
			String programQuery = " and substr(w.work_id,1,2) in ("+ progCodes +") ";
			String habtable = "RWS_HABITATION_DIRECTORY_TBL";
			if (finYear != null) {
				String fyears[] = finYear.split("-");
				String fy = fyears[0].substring(2,4);
				if (fyears[0].equals(String.valueOf(cyear))) {
					habtable = "RWS_HABITATION_DIRECTORY_TBL";
				} else if (fyears[0].equals(String.valueOf(pyear))) {
					habtable = "RWS_HABITATION_DIR_HIS_TBL";
				} else if (Integer.parseInt(fyears[0]) > 2005) {
					habtable = "RWS_HABITATION_DIR_HIS" + fyears[0] + "_TBL";
				} else {
					habtable = "RWS_HABITATION_DIRECTORY_TBL";
				}
				String query = "select "
						+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+") "
						+ programQuery +" and w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) ongoingpws, "						
						/* + "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery +" and  w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id  and TARGET_DATE_COMP>='01-APR-"+ fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) ongoingcpws, " */
						+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+") "
						+ programQuery +" and w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) groundingpws, "						
					/* 	+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery +" and  w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+ fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) groundingcpws, " */
						+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+") "
						+ programQuery +" and w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) underprogresspws, "						
					/* 	+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2)='03' "
						+ programQuery +" and  w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+ fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) underprogresscpws, " */
						+ "(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ "	where substr(w.work_id,5,2)='"+dcode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and substr(w.work_id,7,2) in ("+schemes+") "
						+ programQuery +"  and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedpws, "
					/* 	+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery + " and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+ "' and w.CORE_DASHBOARD_STATUS='Y') notgroundedcpws, " */
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "  
						+ " where substr(w.work_id,5,2)='"+dcode+"' and  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"' ) ) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + " AND substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) completedpws, "
					/* 	+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>'01/APR/"+fyears[0]+"') ) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + " AND substr(w.work_id,7,2)='03' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> ''))completedcpws, " */
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"') and date_of_comm is not null ) and w.work_cancel_dt is null "
						+ programQuery + " AND substr(w.work_id,7,2) in ("+schemes+") and w.CORE_DASHBOARD_STATUS='Y') commisionedpws,"
					/* 	+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where substr(w.work_id,5,2)='"+dcode+"' and w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMM is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  and date_of_comm is not null ) and w.work_cancel_dt is null "
						+ programQuery + " AND substr(w.work_id,7,2)='03' and w.CORE_DASHBOARD_STATUS='Y') commisionedcpws," */
						+ " (select count(*) from rws_water_sample_collect_tbl c,RWS_WQ_TEST_RESULTS_TBL r where substr(c.HAB_CODE,1,2)='"+dcode+"' and c.test_id is not null and r.test_id=c.test_id and c.test_code='1' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+fyears[1]+"') phy,"
						+ " (select count(*) from rws_water_sample_collect_tbl c,RWS_WQ_TEST_RESULTS_TBL r where substr(c.HAB_CODE,1,2)='"+dcode+"' and c.test_id is not null and r.test_id=c.test_id and c.test_code='2' and to_date(r.PREPARED_ON ,'dd/mm/yy')>='01/APR/"+fyears[0]+"' and to_date(r.PREPARED_ON,'dd/mm/yy')<'01/APR/"+fyears[1]+"') bact,"
						+ " (select count(distinct dcode||mcode) from rws_complete_hab_View where dcode='"+dcode+"') mandals, "
						+ " (select count(distinct dcode||mcode||pcode) from rws_complete_hab_View where dcode='"+dcode+"') panchayats," 
						+ " (select count(distinct dcode||mcode||pcode||vcode) from rws_complete_hab_View where dcode='"+dcode+"') villages, "
						+ " (select count(*) from "+habtable+" a,rws_complete_hab_view b where b.dcode='"+dcode+"' and a.hab_code=b.panch_code and a.coverage_status <>'UI' and a.coverage_status is not null) habs, "
						+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE H.dcode='"+dcode+"' and M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' and M.HAB_CODE=H.PANCH_CODE and DATE_CREATION <'01/APR/"+fyears[1]+"') pws,"
						+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE H.dcode='"+dcode+"' and M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%') and  DATE_CREATION <'01/APR/"+fyears[1]+"') mpws,"
						+ " (SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE H.dcode='"+dcode+"' and M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' and M.HAB_CODE=H.PANCH_CODE and SUBSTR(SCHEME_CODE,17,3) LIKE '8%' and DATE_CREATION <'01/APR/"+fyears[1]+"' ) cpws,"
						+ " (select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,RWS_COMPLETE_HAB_VIEW H WHERE H.dcode='"+dcode+"' and M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and M.HAB_CODE=H.PANCH_CODE and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%'or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and DATE_CREATION <'01/APR/"+fyears[1]+"') borewells,"
						+ " (select count(*) from rws_water_quality_lab_tbl where substr(OFFICE_CODE,2,2)='"+dcode+"' and status<>'UI')  labs from dual";

				String query1 = "select sum(case when a.safe_lpcd>=55 then 1 else 0 end) fc,"
				        + " sum(case when a.safe_lpcd>=41.25 and a.safe_lpcd<55 then 1 else 0 end) PC4,"
				        + " sum(case when a.safe_lpcd>=27.50 and a.safe_lpcd<41.25 then 1 else 0 end) PC3,"
				        + " sum(case when a.safe_lpcd>=13.75 and a.safe_lpcd<27.50 then 1 else 0 end) PC2,"
				        + " sum(case when a.safe_lpcd>0 and a.safe_lpcd<13.75 then 1 else 0 end) PC1,"
				        + " sum(case when a.safe_lpcd=0 and a.unsafe_lpcd<>0 then 1 else 0 end) NSS,"
				        + " sum(case when a.safe_lpcd=0 and a.unsafe_lpcd=0  then 1 else 0 end) NC from "
						+ habtable
						+ " a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.COVERAGE_STATUS<>'UI' and a.COVERAGE_STATUS is not null and substr(hab_code,1,2) in('01','02','03','04','05','06','07','08','09','10','11','12','13')";

				//      System.out.println("Query1111111:"+query);
				//System.out.println("Query2222 in coverage2222:"+query1);
				/* added by Sowjanya on 04/08/2015 for schemes (PWS,CPWS,MPWS,HP) count based on AssetAbstract report (Masters/AssetReports/16th report(AssetAbstract report)) */

				String pws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE  M.TYPE_OF_ASSET_CODE='01'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st5 = conn.createStatement();
				rs5 = st5.executeQuery(pws);
				//System.out.println("pwsQuery:"+pws);
				int pwscount = 0;
				while (rs5.next()) {
					pwscount = pwscount + rs5.getInt(1);
				}
				//System.out.println("pwscount----"+pwscount);

				String cpws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE  M.TYPE_OF_ASSET_CODE='03'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st6 = conn.createStatement();
				rs6 = st6.executeQuery(cpws);
				//System.out.println("cpwsQuery:" + cpws);
				int cpwscount = 0;
				while (rs6.next()) {
					cpwscount = cpwscount + rs6.getInt(1);
				}
				//System.out.println("cpwscount----"+cpwscount);

				String mpws = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE  M.TYPE_OF_ASSET_CODE='02'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st7 = conn.createStatement();
				rs7 = st7.executeQuery(mpws);
				//System.out.println("mpwsQuery:"+mpws);
				int mpwscount = 0;
				while (rs7.next()) {
					mpwscount = mpwscount + rs7.getInt(1);
				}
				//System.out.println("mpwscount----"+mpwscount);

				String hp = "SELECT count(distinct M.asset_code),h.dcode FROM RWS_ASSET_MAST_TBL M,RWS_COMPLETE_HAB_VIEW H WHERE  M.TYPE_OF_ASSET_CODE='04'  and M.HAB_CODE=H.PANCH_CODE and (DATE_CREATION <'01/APR/"
						+ fyears[1]
						+ "' or DATE_CREATION is null ) group by h.dname,h.dcode order by h.dname";
				st7 = conn.createStatement();
				rs7 = st7.executeQuery(hp);
				//System.out.println("hpQuery:"+hp);
				int hpcount = 0;
				while (rs7.next()) {
					hpcount = hpcount + rs7.getInt(1);
				}
				//System.out.println("hpcount----"+hpcount);
				/*End of PWS,CPWS,MPWS,HP Query*/
				st2 = conn.createStatement();
				st3 = conn.createStatement();
				st4 = conn.createStatement();
				rs2 = st2.executeQuery(query);
				rs2.next();
				rs3 = st3.executeQuery(query1);
				rs3.next();
				//System.out.println("insert into rws_secretary_details_tbl(MANDALS,PANCHAYATS,VILLAGES,HABS,PWS,MPWS,CPWS,BOREWELLS,ONGOING,NOTGROUNDED,COMPLETED,COMMISSIONED,FC,PC4,PC3,PC2,PC1,NSS,NC,PHY_TESTS,BACT_TESTS,CPWS_ONGOING,CPWS_NOTGROUNDED,CPWS_COMPLETED,CPWS_COMMISSIONED,FIN_YEAR,TOT_LABS,dcode) values('"+rs2.getString(11)+"','"+rs2.getString(12)+"','"+rs2.getString(13)+"','"+rs2.getString(14)+"','"+pwscount+"','"+mpwscount+"','"+cpwscount+"','"+hpcount+"','"+rs2.getString(1)+"','"+rs2.getString(3)+"','"+rs2.getString(5)+"','"+rs2.getString(7)+"','"+rs3.getString(1)+"','"+rs3.getString(2)+"','"+rs3.getString(3)+"','"+rs3.getString(4)+"','"+rs3.getString(5)+"','"+rs3.getString(6)+"','"+rs3.getString(7)+"','"+rs2.getString(9)+"','"+rs2.getString(10)+"','"+rs2.getString(2)+"','"+rs2.getString(4)+"','"+rs2.getString(6)+"','"+rs2.getString(8)+"','"+finYear+"','"+rs2.getString(19)+"','"+dcode+"')");
				st4.executeUpdate("delete from rws_secretary_details_tbl where fin_year='"	+ finYear + "' and dcode='" + dcode + "'");
				st4.executeUpdate("insert into rws_secretary_details_tbl(MANDALS,PANCHAYATS,VILLAGES,HABS,PWS,MPWS,CPWS,BOREWELLS,ONGOING,NOTGROUNDED,COMPLETED,COMMISSIONED,FC,PC4,PC3,PC2,PC1,NSS,NC,PHY_TESTS,BACT_TESTS"+/* ,CPWS_ONGOING,CPWS_NOTGROUNDED,CPWS_COMPLETED,CPWS_COMMISSIONED */",FIN_YEAR,TOT_LABS,dcode,GROUNDED"+/* ,CPWS_GROUNDED */",UNDERPROGRESS"+/* ,CPWS_UNDERPROGRESS */") values('"
						+ rs2.getString("mandals")
						+ "','"
						+ rs2.getString("panchayats")
						+ "','"
						+ rs2.getString("villages")
						+ "','"
						+ rs2.getString("habs")
						+ "','"
						+ pwscount
						+ "','"
						+ mpwscount
						+ "','"
						+ cpwscount
						+ "','"
						+ hpcount
						+ "','"
						+ rs2.getString("ongoingpws")
						+ "','"
						+ rs2.getString("notgroundedpws")
						+ "','"
						+ rs2.getString("completedpws")
						+ "','"
						+ rs2.getString("commisionedpws")
						+ "','"
						+ rs3.getString("fc")
						+ "','"
						+ rs3.getString("PC4")
						+ "','"
						+ rs3.getString("PC3")
						+ "','"
						+ rs3.getString("PC2")
						+ "','"
						+ rs3.getString("PC1")
						+ "','"
						+ rs3.getString("NSS")
						+ "','"
						+ rs3.getString("NC")
						+ "','"
						+ rs2.getString("phy")
						+ "','"
						+ rs2.getString("bact")
						+ "','"
						/* + rs2.getString("ongoingcpws")
						+ "','"
						+ rs2.getString("notgroundedcpws")
						+ "','"
						+ rs2.getString("completedcpws")
						+ "','"
						+ rs2.getString("commisionedcpws")
						+ "','"
 */					+ finYear
						+ "','"
						+ rs2.getString("labs") + "','" 
						+ dcode + "','"
						+ rs2.getString("groundingpws")
						/* + "','"
						+ rs2.getString("groundingcpws") */
						+ "','"
						+ rs2.getString("underprogresspws")
					/* 	+ "','"
						+ rs2.getString("underprogresscpws") */
						+ "')");
%>
<%-- <%=rs2.getString(11) + "/" + rs2.getString(12) + "/"
							+ rs2.getString(13) + "/" + rs2.getString(14) + "/"
							+ rs2.getString(15) + "/" + rs2.getString(16) + "/"+ rs2.getString(17) + "/" + rs2.getString(18) + "/" + rs2.getString(1) + "/" + rs2.getString(3) + "/"+ rs2.getString(5) + "/" + rs2.getString(7) + "/" + rs3.getString(1) + "/" + rs3.getString(2) + "/"+ rs3.getString(3) + "/"+ rs3.getString(4) + "/"+ rs3.getString(5) + "/"+ rs3.getString(6) + "/"
							+ rs3.getString(7) + "/" + rs2.getString(9) + "/"
							+ rs2.getString(10) + "/" + rs2.getString(2) + "/"
							+ rs2.getString(4) + "/" + rs2.getString(6) + "/"
							+ rs2.getString(8) +"/" + rs2.getString(19)  %> --%>
<%=rs2.getString("mandals") + "/" + rs2.getString("panchayats")
								+ "/" + rs2.getString("villages") + "/"
								+ rs2.getString("habs") + "/" + pwscount + "/"
								+ mpwscount + "/" + cpwscount + "/" + hpcount
								+ "/" + rs2.getString("ongoingpws") + "/"
								+ rs2.getString("notgroundedpws") + "/" + rs2.getString("completedpws")
								+ "/" + rs2.getString("commisionedpws") + "/"
								+ rs3.getString("fc") + "/" + rs3.getString("PC4")
								+ "/" + rs3.getString("PC3") + "/"
								+ rs3.getString("PC2") + "/" + rs3.getString("PC1")
								+ "/" + rs3.getString("NSS") + "/"
								+ rs3.getString("NC") + "/" + rs2.getString("phy")
								+ "/" + rs2.getString("bact") + "/"
							/* 	+ rs2.getString("ongoingcpws") + "/" + rs2.getString("notgroundedcpws")
								+ "/" + rs2.getString("completedcpws") + "/"
								+ rs2.getString("commisionedcpws") + "/" */ + rs2.getString("labs") 
								+"/" + rs2.getString("groundingpws")+ /* "/" + rs2.getString("groundingcpws") + */ "/"
								+ rs2.getString("underprogresspws")/*  + "/" + rs2.getString("underprogresscpws") */%>
<%
	}
		} else {
			st2 = conn.createStatement();
			String viewQuery = "select MANDALS,PANCHAYATS,VILLAGES,HABS,PWS,MPWS,CPWS,BOREWELLS,ONGOING,NOTGROUNDED,COMPLETED,COMMISSIONED,FC,PC4,PC3,PC2,PC1,NSS,NC,PHY_TESTS,BACT_TESTS"+/* ,CPWS_ONGOING,CPWS_NOTGROUNDED,CPWS_COMPLETED,CPWS_COMMISSIONED */",TOT_LABS,GROUNDED,UNDERPROGRESS"+/* ,CPWS_GROUNDED,CPWS_UNDERPROGRESS */" from rws_secretary_details_tbl where fin_year='"+finYear+"' and dcode ='"+dcode+"'";
			rs2 = st2.executeQuery(viewQuery);
			while (rs2.next()) {
			%>
<%=rs2.getString("MANDALS") + "/" + rs2.getString("PANCHAYATS")
								+ "/" + rs2.getString("VILLAGES") + "/"
								+ rs2.getString("HABS") + "/" + rs2.getString("PWS")
								+ "/" + rs2.getString("MPWS") + "/"
								+ rs2.getString("CPWS") + "/" + rs2.getString("BOREWELLS")
								+ "/" + rs2.getString("ONGOING") + "/"
								+ rs2.getString("NOTGROUNDED") + "/" + rs2.getString("COMPLETED")
								+ "/" + rs2.getString("COMMISSIONED") + "/"
								+ rs2.getString("FC") + "/" + rs2.getString("PC4")
								+ "/" + rs2.getString("PC3") + "/"
								+ rs2.getString("PC2") + "/" + rs2.getString("PC1")
								+ "/" + rs2.getString("NSS") + "/"
								+ rs2.getString("NC") + "/" + rs2.getString("PHY_TESTS")
								+ "/" + rs2.getString("BACT_TESTS") + "/"
								/* + rs2.getString("CPWS_ONGOING") + "/" + rs2.getString("CPWS_NOTGROUNDED")
								+ "/" + rs2.getString("CPWS_COMPLETED") + "/"
								+ rs2.getString("CPWS_COMMISSIONED") + "/" */ + rs2.getString("TOT_LABS")
								+ "/" + rs2.getString("GROUNDED") /* + "/" + rs2.getString("CPWS_GROUNDED") */
						        + "/" + rs2.getString("UNDERPROGRESS") /* + "/" + rs2.getString("CPWS_UNDERPROGRESS")				 */	
						%>
<%
	}

		}
	}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (st2 != null) {
			st2.close();
		}
		if (rs2 != null) {
			rs2.close();
		}
	}
%>
