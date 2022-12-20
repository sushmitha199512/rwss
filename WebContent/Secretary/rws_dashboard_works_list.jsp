
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table-fixed-header.css'/>">
    <script language="JavaScript" src="<rws:context page='/resources/javascript/jquery-1.7.2.min.js'/>"></script>
    <script language="JavaScript" src="<rws:context page='/resources/javascript/table-fixed-header.js'/>"></script>

<%
String schemes = "'01','02','03','10'";
String name = (String)session.getAttribute("name");
String type =(String)session.getAttribute("type");
String finYear=(String)session.getAttribute("finYear");
String dcode=(String)session.getAttribute("dcode");
String dname=(String)session.getAttribute("dname");
String divCode=(String)request.getParameter("divCode");
String progCodes=Constants.getNrdwp();
//progCodes=progCodes+",04,65,70,57,77";
String programQuery=" and substr(w.work_id,1,2) in ("+progCodes+")  and substr(w.work_id,7,2) <>'11' and substr(w.work_id,7,2) <>'12' and    ";
		String query = "";
String fyears[]=finYear.split("-");

		/* if (name.equals("OnGoing") && type.equals("01")) {
			//query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code   "+programQuery+" d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[1]+ "') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and substr(w.work_id,7,2) not in ('11','12') and w.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id=w.work_id and m.work_id=i.work_id and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' order by d.dname";
		} else if (name.equals("OnGoing") && type.equals("03")) {
			//query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"   d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' and w.work_cancel_dt is null order by d.dname";
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[1]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and substr(w.work_id,7,2) not in ('11','12') and w.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id=w.work_id and m.work_id=i.work_id and d.dcode='"+dcode+"' and dv.division_office_code='"+divCode+"' order by d.dname";
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
		
		if (name.equals("OnGoing") && type.equals("01")) {
			//query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='01' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and d.dcode='"+dcode+"' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and dv.division_office_code='"+divCode+"' order by d.dname";
		} else if (name.equals("OnGoing") && type.equals("03")) {
			//query = "SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[1]+"') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+programQuery+"   w.work_cancel_dt is null and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
			query="SELECT d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0') FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null and i.work_id(+)=w.work_id  and c.work_id(+)=w.work_id and m.work_id(+)=w.work_id and d.dcode='"+dcode+"' and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and dv.division_office_code='"+divCode+"' order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("01")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and   w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		} else if (name.equals("NotGrounded") && type.equals("03")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+fyears[0]+"') and   substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +"  substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and w.work_id  not in(select work_id from rws_work_commencement_tbl ) and w.work_cancel_dt is null and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}else if (name.equals("Completed") && type.equals("01")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2) in ("+schemes+")  and h.work_id=w.work_id and hd.hab_code=h.hab_code and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}else if (name.equals("Completed") && type.equals("03")) {
			query = "SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_division_office_tbl dv,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-"+fyears[0]+"' ) ) "+ programQuery +"  w.work_cancel_dt is null AND  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code AND substr(w.work_id,7,2)='03' and h.work_id=w.work_id and hd.hab_code=h.hab_code and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}else if (name.equals("Commissioned") && type.equals("01")) {
	       query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +" date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2) in ("+schemes+")  and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}else if (name.equals("Commissioned") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')   FROM RWS_WORK_ADMN_TBL W,rws_district_tbl d,rws_division_office_tbl dv where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMM>='01/APR/"+fyears[0]+"' and DATE_OF_COMM<'01/APR/"+fyears[1]+"' )  "+ programQuery +"  date_of_comm is not null ) and w.work_cancel_dt is null AND substr(w.work_id,7,2)='03' and  substr(w.work_id,5,2)=d.dcode and substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code  and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}
		else if (name.equals("Grounded") && type.equals("01")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname"; 
		}
		else if (name.equals("Grounded") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-APR-"+ fyears[0]+ "') and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}
		else if (name.equals("UnderProgress") && type.equals("01")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2) in ("+schemes+")  and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}
		else if (name.equals("UnderProgress") && type.equals("03")) {
			query="SELECT  d.dname,dv.DIVISION_OFFICE_NAME,w.work_id,w.WORK_NAME ,to_char(w.ADMIN_DATE,'dd/mm/yyyy'),nvl(w.SANCTION_AMOUNT,'0')  FROM RWS_WORK_ADMN_TBL W,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl d,rws_division_office_tbl dv where w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  substr(w.work_id,7,2)='03' and substr(w.work_id,5,2)=d.dcode "+ programQuery +" substr(w.work_id,5,2)=dv.CIRCLE_OFFICE_CODE  and substr(w.office_code,4,1)=dv.division_office_code and  w.work_cancel_dt is null  and i.work_id=w.work_id  and c.work_id=w.work_id and m.work_id=w.work_id and TARGET_DATE_COMP>='01-APR-"+fyears[0]+"' and w.CORE_DASHBOARD_STATUS='Y'  and d.dcode='"+dcode+"'  and dv.division_office_code='"+divCode+"' order by d.dname";
		}




	%>



<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
               <td class="bwborder"><a href="#" onclick="viewReport('Secretary/rws_dashboard_works_div_abstract.jsp?dcode=<%=dcode %>&dname=<%=dname %>')" >Back</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
	</tr>  
		</table>
	</caption>
<tr >
		<th align="center" class="gridhdbg" colspan="5" ><%=name %>Works </th><th align="right" class="gridhdbg" >*** Rupees in Lakhs</th>
</tr>
</table>
<table   bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>Division  </b></td>
<td class=gridhdbg ><b>Work ID   </b></td>
<td class=gridhdbg ><b>Work Name </b></td>    
<td class=gridhdbg ><b>Admin Sanction Date   </b></td>  
<td class=gridhdbg ><b>Sanction Amount   </b></td>    
</tr>
 
	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       String distname1="",distname2="";
       
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
                
                <td class=<%=style %> style="text-align: left;">&nbsp;<%=count++%> </td>
				<td class=<%=style %> style="text-align: left;">&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%>   </td>  
				<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%>   </td>  
				<td class=<%=style %> style="text-align: left;" ><%=rs1.getString(5)%>  </td> 
				<td class=<%=style %> style="text-align: right;"><%=rs1.getString(6)%>  </td>  
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
	</tbody>
	
</table></div>
</form>

