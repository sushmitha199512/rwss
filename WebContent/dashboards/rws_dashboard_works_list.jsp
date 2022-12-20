<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
String schemes = "'01','02','03','10'";
String name = (String)request.getParameter("name");
String type =(String)request.getParameter("type");
String finYear=(String)session.getAttribute("finYear");
String userId=request.getParameter("userid");
String dcode="",divCode="";
String userQuery="";
if(userId!=null && !userId.equals("admin") &&  !userId.equals("100000") &&  !userId.equals("1000DR") &&   !userId.equals("guest")  &&   !userId.equals("ENC") &&  !userId.equals("EE-Budget") &&  !userId.equals("aprwssp") &&  !userId.equals("cerwss") &&  !userId.substring(3,6).equals("vqc") ){
    if(!userId.substring(3,6).equals("000")){
		dcode=userId.substring(1,3);
		divCode=userId.substring(3,4);
	}else {
		userQuery=" substr(W.office_code,2,2)='"+userId.substring(1,3)+"' and ";
		dcode=userId.substring(1,3);
	}
}  

String progCodes=Constants.getNrdwp();
/* String programQuery=" and substr(w.work_id,1,2) in (01,02,18,23,32,48,49,51,58,62,04,57,65,70,63)  and substr(w.work_id,7,2) <>'11' and substr(w.work_id,7,2) <>'12' and    "; */
String programQuery=" and substr(w.work_id,1,2) in ("+progCodes+")  and substr(w.work_id,7,2) <>'11' and substr(w.work_id,7,2) <>'12' and    ";
		String query = "";
String fyears[]=finYear.split("-");

		/* if (name.equals("OnGoing") && type.equals("01")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code   "+programQuery+" d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
		} else if (name.equals("OnGoing") && type.equals("03")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"   d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("01")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and   substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"  w.work_id  not in(select work_id from rws_work_commencement_tbl ) and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("03")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and   substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"  w.work_id  not in(select work_id from rws_work_commencement_tbl ) and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
		}else if (name.equals("Completed") && type.equals("01")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"') ) and w.work_cancel_dt is null AND PLAN_CODE='1' and substr(w.work_id,5,2)=d.dcode "+programQuery+"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' AND substr(w.work_id,7,2)='01' order by d.dname";
		}else if (name.equals("Completed") && type.equals("03")) {
			query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"') ) and w.work_cancel_dt is null AND PLAN_CODE='1' and substr(w.work_id,5,2)=d.dcode "+programQuery+"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' AND substr(w.work_id,7,2)='03' order by d.dname";
		}else if (name.equals("Commissioned") && type.equals("01")) {
           query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"' )  and date_of_comm is not null ) and w.work_cancel_dt is null  "+programQuery+"  substr(w.work_id,7,2)='01' and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and substr(w.office_code,4,1)=dv.division_office_code  order by d.dname";
		}else if (name.equals("Commissioned") && type.equals("03")) {
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/"+fyears[0]+"' and DATE_OF_COMPLETION<'01/APR/"+fyears[1]+"' )  and date_of_comm is not null ) and w.work_cancel_dt is null "+programQuery+" substr(w.work_id,7,2)='03' and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and substr(w.office_code,4,1)=dv.division_office_code  order by d.dname";
		} */
		//System.out.println(name+ "   "+type);
		
		if (name.equals("OnGoing") && type.equals("01")) {
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+") and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		} else if (name.equals("OnGoing") && type.equals("03")) {
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'";
		} else if (name.equals("NotGrounded") && type.equals("01")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+") and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and   w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		} else if (name.equals("NotGrounded") && type.equals("03")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		}else if (name.equals("Completed") && type.equals("01")) {
			/* query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "; */
			
			query="SELECT distinct d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_division_office_tbl dv "
					+ " where  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) "+ programQuery +"  h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
					+ " AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2) in ("+schemes+")  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y'";
		}else if (name.equals("Completed") && type.equals("03")) {
			/* query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv 
					where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null 
					AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='03'  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') "; */
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_division_office_tbl dv "
					+ " where  w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION,'dd/mm/yy')>='01/APR/"+fyears[0]+"')) "+ programQuery +"  h.work_id=w.work_id and hd.hab_code=h.hab_code and w.work_cancel_dt is null "
					+ " AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='03'  and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and w.CORE_DASHBOARD_STATUS='Y'";
		}else if (name.equals("Commissioned") && type.equals("01")) {
	       query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +" date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2) in ("+schemes+") and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y' ";
		}else if (name.equals("Commissioned") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')   FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +"  date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2)='03' and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y' ";
		}else if (name.equals("Grounded") && type.equals("01")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+") and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  "; 
		}else if (name.equals("Grounded") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		}else if (name.equals("UnderProgress") && type.equals("01")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+") and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		}else if (name.equals("UnderProgress") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' ";
		}
		
		if(!dcode.equals("") && dcode!=null){
			query+=" and d.dcode='"+dcode+"' ";
		}
		if(!dcode.equals("") && dcode!=null && divCode!=null && !divCode.equals("")){
			query+=" and  dv.division_office_code='"+divCode+"'";
		}
		query+=" order by d.dname";
	%>
<form>
	<table border=1 cellspacing=0 cellpadding=0 width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse" align="right">
				<tr align="right">
					<td class="bwborder"><!-- <a
						href="javascript:window.history.go(-1);">Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --></td>
				</tr>
			</table>
		</caption>
		<tr>
			<td align="center" class="gridhdbg"><%=name %>Works</td>
			<td align="right" class="gridhdbg">*** Rupees in Lakhs</td>
		</tr>
	</table>
	<table width="100%" style="border-collapse: collapse" ALIGN=CENTER>
		<tr align=center>
			<td class=gridhdbg><b>SLNO </b></td>
			<td class=gridhdbg><b>Division </b></td>
			<td class=gridhdbg><b>Work ID </b></td>
			<td class=gridhdbg><b>Work Name </b></td>
			<td class=gridhdbg><b>Admin Sanction Date </b></td>
			<td class=gridhdbg><b>Sanction Amount </b></td>
		</tr>
<%
	try
      {
	   int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       
  // System.out.println("qry***********"+query);
       rs1=stmt1.executeQuery(query);
       int styleCount=0;
       String style="";
       while(rs1.next())
       {
          distname1 = ""+rs1.getString(1);
	      
          if(styleCount%2==0)
			{
				 style="gridbg1";
			 }else
			 {
				 style="gridbg2";
			 }
			 styleCount++;

		%>

		<tr>

			<td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%>
			</td>
			<td class=<%=style %> style="text-align: left;">&nbsp;<%=rs1.getString(2)%>
			</td>
			<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>
			</td>
			<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%>
			</td>
			<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%>
			</td>
			<td class=<%=style %> style="text-align: right;"><%=rs1.getString(6)%>
			</td>
		</tr>
		<% 
           distname2 = distname1;
       }
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>

	</table>
</form>

