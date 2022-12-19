<%@ include file="/reports/conn.jsp" %>
<%
ResultSet rs1 = null,rs2 = null,rs3 = null,rs4 = null;
Statement st1 = null,st2 = null,st3 = null,st4 = null;
try
{

java.util.Date currentDate=new java.util.Date();
int cyear=currentDate.getYear()+1900;
int pyear=currentDate.getYear()+1900-1;


	conn.setAutoCommit(false);
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
System.out.println("Deleteing");
	String q1 = "select (select count(distinct dcode||mcode) from rws_complete_hab_View)mandals,(select count(distinct dcode||mcode||pcode) from rws_complete_hab_View)panchayats,(select count(distinct dcode||mcode||pcode||vcode) from rws_complete_hab_View)villages, (select count(*) from rws_complete_hab_View)habs,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01')pws,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02')mpws,(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '8%' AND M.TYPE_OF_ASSET_CODE='03')cpws,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and (substr (s.scheme_code,17,3) like '0%' or substr(s.scheme_code,17,3) like '1%' or substr(s.scheme_code,17,3) like '2%'))borewells, (select round(nvl(sum(AMT_NOW_AUTH),0),2) from rws_bro_details_tbl a,rws_bro_master_tbl b where a.bro_id=b.bro_id and fin_year='2010-2011')bro,(select round(nvl(sum(loc_amount),0),2) from rws_loc_details_tbl a,rws_bro_master_tbl b where a.bro_id=b.bro_id and fin_year='2010-2011')loc,(select round(nvl(sum(voucher_amt),0)/100000,2) from rws_work_exp_voucher_tbl where BILL_SL_NO <> '0')expvoucher, (SELECT COUNT(*) FROM RWS_WORK_ADMN_TBL W where w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01/APR/2010')) AND PLAN_CODE='1' AND (CATEGORY_CODE='1' OR CATEGORY_CODE='2'))ongoing,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01/APR/2010')) AND PLAN_CODE='1' AND (CATEGORY_CODE='1' OR CATEGORY_CODE='2') and w.work_id not in(select work_id from rws_work_commencement_tbl))notgrounded, (SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/2010') and date_of_completion is not null) AND PLAN_CODE='1' AND (CATEGORY_CODE='1' OR CATEGORY_CODE='2'))completed,(SELECT count(*) FROM RWS_WORK_ADMN_TBL W where w.work_id in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01/APR/2010') and date_of_comm is not null) AND PLAN_CODE='1' AND (CATEGORY_CODE='1' OR CATEGORY_CODE='2') )commissioned,(select count(*) from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id and c.test_code='1')phy,(select count(*) from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id and c.test_code='2')bact from dual";
	String q2 = "select sum(case when a.coverage_status='FC' then 1 else 0 end)fc,sum(case when a.coverage_status='PC4' then 1 else 0 end) PC4,sum(case when a.coverage_status='PC3' then 1 else 0 end)PC3,sum(case when a.coverage_status='PC2' then 1 else 0 end) PC2,sum(case when a.coverage_status='PC1' then 1 else 0 end)PC1,sum(case when a.coverage_status='NSS' then 1 else 0 end) NSS,sum(case when a.coverage_status='NC' then 1 else 0 end)Nc from rws_complete_hab_View a,rws_habitation_directory_tbl b where a.panch_code=b.hab_code";
	rs1 = st1.executeQuery(q1);
	rs2 = st2.executeQuery(q2);
	rs1.next();rs2.next();
	String q3 = "delete from rws_secretary_details_tbl";
	if(st3.executeUpdate(q3)>=0)
	{
		String q4 = "insert into rws_secretary_details_tbl values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		 PreparedStatement psv=conn.prepareStatement(q4);
         psv.setString(1,rs1.getString(1));
			psv.setString(2,rs1.getString(2));
			psv.setString(3,rs1.getString(3));
			psv.setString(4,rs1.getString(4));
			psv.setString(5,rs1.getString(5));
			psv.setString(6,rs1.getString(6));
			psv.setString(7,rs1.getString(7));
			psv.setString(8,rs1.getString(8));
			psv.setString(9,rs1.getString(9));
			psv.setString(10,rs1.getString(10));
			psv.setString(11, rs1.getString(11));
			psv.setString(12, rs1.getString(12));
			psv.setString(13, rs1.getString(13));
			psv.setString(14, rs1.getString(14));
			psv.setString(15, rs1.getString(15));
			psv.setString(16, rs1.getString(1));
			psv.setString(17,rs1.getString(2));
			psv.setString(18, rs1.getString(3));
			psv.setString(19,rs1.getString(4));
			psv.setString(20,rs1.getString(5));
			psv.setString(21,rs1.getString(6));
			psv.setString(22,rs1.getString(7));
			psv.setString(23,rs1.getString(16) );
			psv.setString(24,rs1.getString(17));
		int value = psv.executeUpdate();
		conn.setAutoCommit(true);
		conn.commit();
	}%>
	<%=rs1.getString(1)+"/"+rs1.getString(2)+"/"+rs1.getString(3)+"/"+rs1.getString(4)+"/"+rs1.getString(5)+"/"+rs1.getString(6)+"/"+rs1.getString(7)+"/"+rs1.getString(8)+"/"+rs1.getString(9)+"/"+rs1.getString(10)+"/"+rs1.getString(11)+"/"+rs1.getString(12)+"/"+rs1.getString(13)+"/"+rs1.getString(14)+"/"+rs1.getString(15)+"/"+rs2.getString(1)+"/"+rs2.getString(2)+"/"+rs2.getString(3)+"/"+rs2.getString(4)+"/"+rs2.getString(5)+"/"+rs2.getString(6)+"/"+rs2.getString(7)+"/"+rs1.getString(16)+"/"+rs1.getString(17)%>
	<%
}
catch(Exception e)
{System.out.println("exception:"+e.getMessage());}
finally
{
	try
	{
		if(rs4!=null)rs4.close();if(rs3!=null)rs3.close();if(rs2!=null)rs2.close();if(rs1!=null)rs1.close();
		if(st4!=null)st4.close();if(st3!=null)st3.close();if(st2!=null)st2.close();if(st1!=null)st1.close();
		if(conn!=null)conn.close();
	}
	catch(Exception ee)
	{System.out.println("exception in finally:"+ee.getMessage());}
}
%>