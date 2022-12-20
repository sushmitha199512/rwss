
<%@page import="nic.watersoft.commons.Constants"%>
<%@ include file="/reports/conn.jsp"%>
<%
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		Statement st2 = null;
		Statement st3 = null;

		try {
			String schemes = "'01','02','03','10'";
			String progCodes = Constants.getNrdwp();
			java.util.Date currentDate = new java.util.Date();
			int cyear = currentDate.getYear() + 1900;
			int pyear = currentDate.getYear() + 1900 - 1;

			String finYear = request.getParameter("finyear");
            String userId=request.getParameter("userid");

String userQuery="";

  if(userId!=null && !userId.equals("admin") &&  !userId.equals("100000") &&  !userId.equals("1000DR") &&   !userId.equals("guest")  &&   !userId.equals("ENC") &&  !userId.equals("EE-Budget") &&  !userId.equals("aprwssp") &&  !userId.equals("cerwss")  &&  !userId.substring(3,6).equals("vqc") ){
    if(!userId.substring(3,6).equals("000")){
		userQuery=" substr(W.office_code,2,2)='"+userId.substring(1,3)+"' and  substr(W.office_code,4,1)='"+userId.substring(3,4)+"' and  ";
	}else {
		userQuery=" substr(W.office_code,2,2)='"+userId.substring(1,3)+"' and ";
	}
}                 //System.out.println("13UserId:"+userId);

         session.setAttribute("finYear",finYear);
         String programQuery = " and substr(w.work_id,1,2) in (" + progCodes + ") and ";
			String habtable = "RWS_HABITATION_DIRECTORY_TBL";
			if (finYear != null) {
				String fyears[] = finYear.split("-");
				String fy = fyears[0].substring(2, 4);
			
				/* String query = "select (SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[0]
						+ "') and  substr(w.work_id,7,2)='01'  and w.work_cancel_dt is null) ongoingpws "

+" ,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"   w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[0]	+ "') and  substr(w.work_id,7,2)='03'  and w.work_cancel_dt is null) ongoingcpws "

+",(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]
						+ "') and  substr(w.work_id,7,2)='01'  and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null)notgroundedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"   w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"
						+ fyears[1]
						+ "') and substr(w.work_id,7,2)='03'  and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null)notgroundedcpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMPLETION<'01/APR/"
						+ fyears[1]
						+ "') ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='01')completedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMPLETION<'01/APR/"
						+ fyears[1]
						+ "') ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='03')completedcpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMPLETION<'01/APR/"
						+ fyears[1]
						+ "' )  and date_of_comm is not null ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='01')commisionedpws,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where "+userQuery+"  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"
						+ fyears[0]
						+ "' and DATE_OF_COMPLETION<'01/APR/"
						+ fyears[1]
						+ "' )  and date_of_comm is not null ) and w.work_cancel_dt is null AND PLAN_CODE='1' AND substr(w.work_id,7,2)='03')commisionedcpws  from dual"; */
				String query = "select (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') ongoingpws, "
						+" (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery +" w.work_cancel_dt is null  and  i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) ongoingcpws, "
						+"(SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') groundingpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery + "  w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) groundingcpws, "
						+" (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') underprogresspws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
						+ " where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION  is not null ) and  substr(w.work_id,7,2)='03' "
						+ programQuery + " w.work_cancel_dt is null  and  i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ) underprogresscpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+")   "
						+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where "+userQuery+" w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and  substr(w.work_id,7,2)='03' "
						+ programQuery + " w.work_id not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y') notgroundedcpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where "+userQuery+" w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
						+ " where "+userQuery+" w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) and h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
						+ programQuery + "  substr(w.work_id,7,2)='03' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y') completedcpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where "+userQuery+" w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) and w.work_cancel_dt is null "
						+ programQuery + " substr(w.work_id,7,2) in ("+schemes+")  and w.CORE_DASHBOARD_STATUS='Y') commisionedpws, "
						+ " (SELECT count(distinct w.work_id) FROM RWS_WORK_ADMN_TBL W "
						+ " where "+userQuery+" w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"')  and date_of_comm is not null ) "
						+ programQuery + " w.work_cancel_dt is null AND  substr(w.work_id,7,2)='03'  and w.CORE_DASHBOARD_STATUS='Y') commisionedcpws from dual";
        // System.out.println("query:12345"+query);
				st2 = conn.createStatement();
				rs2 = st2.executeQuery(query);
				rs2.next();
				
%>
				<%=rs2.getString("ongoingpws") + "/" + rs2.getString("ongoingcpws") + "/"
						+ rs2.getString("groundingpws") + "/" + rs2.getString("groundingcpws") + "/"
						+ rs2.getString("underprogresspws") + "/" + rs2.getString("underprogresscpws") + "/"
						+ rs2.getString("notgroundedpws") + "/" + rs2.getString("notgroundedcpws")+ "/" 
						+ rs2.getString("completedpws") + "/" + rs2.getString("completedcpws") + "/"
						+ rs2.getString("commisionedpws") + "/" + rs2.getString("commisionedcpws")  
						%>

<%

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	%>
