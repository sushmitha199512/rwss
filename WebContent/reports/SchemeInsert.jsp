ip<%@	page import="java.sql.*, java.util.*,java.math.BigDecimal " %>

<%
	Connection conn=null,conn1=null;
	Statement st1=null,st2=null;
    ResultSet rs2=null,rs1=null;
	int total = 0;
	String workid="",main="0",workname="",stateid="002",dcode="",schemetypeid="",type="",sancyear="",estcost="0",revestcost="0",goicost="0",statecost="0",commcont="0",capacity="0",service="",exp="0",moreexp="0",dofcomm="",dofcomp="",psy="",atm="No";
	double popcov = 0;
	Statement stq1=null,stq2=null,stq3=null,stq31=null,stq4=null,stq5=null,sss=null,prev=null;
	ResultSet rsq1=null,rsq2=null,rsq3=null,rsq31=null,rsq4=null,rsq5=null,prevrs=null,san=null;

    %>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="780" >
<% 			
try{
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft","preduser","preduser");
		System.out.println("oracle con"+conn);

	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	System.out.println("oracle con111111");
	conn1 = DriverManager.getConnection("jdbc:odbc:schemePorting21082012");
	System.out.println("oracle c222222222");
	System.out.println("access con"+conn1);


   }
   catch(Exception e)
   {
		System.out.println("EXCEPTION IN getting Connection"+e);
   }   
   Statement stqq =null,stqq1 =null; 
   ResultSet rsqq = null;
   String query = "";
   try{
		String qq = "select a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,to_char (b.grounding_date,'dd/mm/yyyy') as grounding_date,to_char (c.date_of_completion,'dd/mm/yyyy')as date_of_completion,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010','09','00 11','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021','20','00 22','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code from rws_work_admn_tbl a,rws_work_commencement_tbl b,rws_work_completion_tbl c where (category_code='1' or category_code='2') and plan_code='1' and a.work_id=b.work_id and a.work_id=c.work_id(+) and b.grounding_date is not null";
		//new query -- Only Schemes taken which are having sources in source_iden_fin_tbl
		//qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,to_char (b.grounding_date,'dd/mm/yyyy') as grounding_date,to_char (c.date_of_completion,'dd/mm/yyyy')as date_of_completion,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010','09','00 11','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021','20','00 22','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code from rws_work_admn_tbl a,rws_work_commencement_tbl b,rws_work_completion_tbl c,rws_source_iden_fin_tbl d where (category_code='1' or category_code='2') and plan_code='1' and a.work_id=b.work_id and a.work_id=c.work_id(+) and a.work_id=d.work_id and b.grounding_date is not null";
		//Type-I qry:
		qq = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,to_char (com.grounding_date,'dd/mm/yyyy') as grounding_date,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_work_commencement_tbl com,rws_habitation_directory_tbl hd where a.work_id=b.work_id and a.work_id=com.work_id and a.work_id=com.work_id and b.hab_code=c.panch_code and b.hab_code=hd.hab_code and c.panch_code=hd.hab_code and category_code<> '3' and (a.ADMIN_DATE < '01-Apr-2010' or a.ADMIN_DATE >= '01-Apr-2010') and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010')) and prepared_on<'20/MAY/2010' AND AUG_NEW_CODE='1' and grounding_date is not null and coverage_status<>'FC' and (substr (a.work_id,7,2)<>'08' and substr (a.work_id,7,2)<>'04'  and substr (a.work_id,7,2)<>'07') and a.programme_code in ('01','02','32','23','24','55','57','15','03','38','34','01','18','10','12','06','39','44','46','54','49','53','58','59' ,'60','61','51','04')";
		//and a.work_id='12001203090001'
		//Type-II:
		qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_habitation_directory_tbl hd where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=hd.hab_code and c.panch_code=hd.hab_code and category_code<> '3' and (a.ADMIN_DATE < '01-Apr-2010' or a.ADMIN_DATE >= '01-Apr-2010') and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010')) and prepared_on>='20/MAY/2010' AND SUBSTR(A.WORK_ID,7,2)<>'10' and coverage_status<>'FC' and lead_habitation is not null and substr(a.work_id,7,2)<>'08' and a.programme_code in ('01','02','32','23','24','55','57','15','03','38','34','01','18','10','12','06','39','44','46','54','49','53','58','59' ,'60','61','51','04')"; //and a.work_id='15001701100130'";
		//Level-II DDWS Project Shelf Porting:
		qq = "select distinct a.work_id,lead_habitation,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_habitation_directory_tbl hd where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=hd.hab_code and c.panch_code=hd.hab_code and category_code<> '3' and (a.ADMIN_DATE < '01-Apr-2010' or a.ADMIN_DATE >= '01-Apr-2010') and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010')) AND (SUBSTR(A.WORK_ID,7,2)<>'10' and substr(a.work_id,7,2)<>'08') and coverage_status<>'FC' and lead_habitation is not null and a.programme_code in ('01','02','32','23','24','55','57','15','03','38','34','01','18','10','12','06','39','44','46','54','49','53','58','59' ,'60','61','51','04') and prepared_on>='15/jun/2010' and a.WORK_ID not in('18001503090003','49010503100007') union select distinct a.work_id,lead_habitation,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_work_commencement_tbl com,rws_habitation_directory_tbl hd where a.work_id=b.work_id and a.work_id=com.work_id(+) and b.hab_code=c.panch_code and b.hab_code=hd.hab_code and c.panch_code=hd.hab_code and category_code<> '3' and (a.ADMIN_DATE < '01-Apr-2010' or a.ADMIN_DATE >= '01-Apr-2010') and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2010')) and coverage_status<>'FC' and b.hab_code in ('0202831008010600', '0100523004010300', '0100523052013900', '0100624016011100', '0100524034022500', '0303716021051300', '0303716021071300', '0303716021081300', '0303716021091300', '0303716021111300', '0303716021121300', '0303716021131300', '0303716021161300', '0303119002100100', '0303440012041300', '0403802047010500', '0404410029010600', '0608937012041200', '0608844004030400', '0608844010010500', '0608844015011200', '0608844023051800', '0608745001100300', '0710603005020500', '0710603005040600', '0710603006010700', '0710603010031400', '0710604009011300', '0710514014022000', '0710424012021500', '0710126002040700', '0709632012011700', '0710842003030400', '0710842004020600', '0710842004030700', '0710843008010600', '0710843008020600', '0710844003040200', '0710844007021000', '0711045001010100', '0709748020012700', '1419114013021200', '1419438021011600', '1419549017011300', '1419451019011600', '1419653013011300', '1521911009030300', '2025705020032400', '2025248011021100', '2227514016071100', '2227514019041200', '2227514021031200', '2227731021022300') AND (SUBSTR (A.WORK_ID,7,2)<>'10' and substr(a.work_id,7,2)<>'08') ";
		//project shelf level-3 on 250610
		qq="select distinct a.work_id,lead_habitation,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','04','0004','08','0900') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_habitation_directory_tbl hd where a.work_id=b.work_id and b.hab_code=c.panch_code and b.hab_code=hd.hab_code and c.panch_code=hd.hab_code and category_code<> '3' and prepared_on>='23/JUN/2010' and prepared_by='100000'";
		qq = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from RWS_WORK_admn_tbl a,rws_work_completion_tbl b,rws_admn_hab_lnk_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl e,rws_source_iden_fin_tbl f where a.work_id=b.work_id and b.date_of_completion>='01/APR/2010' and a.work_id not in (select work_id from RWS_DDWS_SCHEME_DATA_PORT where work_asset='W' and fin_year='2010-2011') and (a.programme_code<>49 and a.programme_code<>50 and a.programme_code<>51) and a.work_id in(select work_id from rws_work_commencement_tbl where grounding_date is not null) and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and d.panch_code=e.hab_code and a.work_id=f.work_id and plan_code='1' and coverage_status<>'FC'";
		qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from RWS_WORK_admn_tbl a,rws_work_completion_tbl b,rws_admn_hab_lnk_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl e,rws_source_iden_fin_tbl f where a.work_id=b.work_id and b.date_of_completion>='01/APR/2010' and a.work_id not in (select work_id from RWS_DDWS_SCHEME_DATA_PORT where work_asset='W' and fin_year='2010-2011') and (a.programme_code<>49 and a.programme_code<>50 and a.programme_code<>51) and a.work_id in(select work_id from rws_work_commencement_tbl where grounding_date is not null and grounding_date<>'01/APR/2010') and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and d.panch_code=e.hab_code and a.work_id=f.work_id and plan_code='1' and coverage_status<>'FC' union select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from RWS_WORK_admn_tbl a,rws_work_completion_tbl b,rws_admn_hab_lnk_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl e,rws_source_iden_fin_tbl f where a.work_id=b.work_id and b.date_of_completion>='01/APR/2010' and a.work_id not in (select work_id from RWS_DDWS_SCHEME_DATA_PORT where work_asset='W' and fin_year='2010-2011') and (a.programme_code<>49 and a.programme_code<>50 and a.programme_code<>51) and a.work_id in(select work_id from rws_work_commencement_tbl where grounding_date is not null and grounding_date='01/APR/2010') and a.work_id=c.work_id and c.hab_code=d.panch_code and c.hab_code=e.hab_code and d.panch_code=e.hab_code and a.work_id=f.work_id and plan_code='1'";
		//project shelf level-4 on 141010
		qq = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from rws_work_admn_tbl a,rws_work_commencement_tbl b,rws_habitation_directory_tbl h,rws_admn_hab_lnk_tbl l,rws_complete_hab_view v,rws_work_completion_tbl comp,RWS_SOURCE_IDEN_FIN_TBL fin where a.work_id=b.work_id and a.work_id=l.work_id and l.work_id=b.work_id and h.hab_code=l.hab_code and a.work_id not in(select work_id from rws_ddws_scheme_data_port where WORK_ASSET ='W' ) and v.panch_code=h.hab_code and l.hab_code=v.panch_code and b.grounding_date is not null and a.work_id=comp.work_id and b.work_id=comp.work_id and l.work_id=comp.work_id and date_of_completion is not null and date_of_completion>'31/MAR/2010' and a.category_code<>'3' and plan_code='1' and a.work_id=fin.work_id and b.work_id=fin.work_id and l.work_id=fin.work_id and comp.work_id=fin.work_id and source_code is not null and aug_new_code='1' and a.programme_code in ('01','15','49')";
		//16-02-2012 added by swapna
//qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code from rws_work_admn_tbl a where work_id in(select   work_id  from rws_work_completion_tbl where work_id in(	select distinct a.work_id from rws_work_admn_tbl a where work_id not in(select work_id from rws_work_completion_tbl where date_of_completion<='31/mar/2011') and plan_code='1' and programme_code<>'50' and substr(work_id,7,2)<>'10' and work_id in (select distinct work_id from RWS_work_commencement_tbl) and work_id in (select work_id from RWS_contractor_selection_tbl where PROBABLE_DATE <'01/apr/2012' ) AND (WORK_NAME NOT LIKE '%M.P.E.S%' AND WORK_NAME NOT LIKE '%MPES%' AND WORK_NAME NOT LIKE '%SCHOOL%' AND WORK_NAME NOT LIKE '%Z.P.H.S.%' AND WORK_NAME NOT LIKE '%ZPHS%' AND WORK_NAME NOT LIKE '%MPUPS%' AND WORK_NAME NOT LIKE '%M.P.U.P.S%' AND ADMIN_NO NOT LIKE '%SCHOOL%' AND ADMIN_NO NOT LIKE '%RWHS%' AND ADMIN_NO NOT LIKE '%RTWHS%' AND work_name NOT LIKE '%M.P%') and work_id in (select work_id from RWS_source_iden_fin_tbl) and work_id not in (select distinct work_id from RWS_DDWS_WORKS_MPR_TBL minus select distinct work_id from RWS_DDWS_WORKS_MPR_TBL where month>=4 and year>=2011)minus(select work_id from rws_ddws_scheme_data_port where fin_year='2011-2011' union select work_id from rws_ddws_scheme_data_port where work_asset='w' and fin_year <> '2010-2011' and fin_year <> '2011-2011'))and date_of_completion is not null)";

		//12-02-2012 added by Sai Prasad N
/*qq ="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code, to_char(b.GROUNDING_DATE,'dd/mm/yyyy'),to_char(c.DATE_OF_COMPLETION,'dd/mm/yyyy')  from rws_work_admn_tbl a,RWS_work_commencement_tbl b ,rws_work_completion_tbl c "+
"where c.work_id=a.work_id and c.work_id=b.work_id and a.work_id=b.work_id and a.work_id in('00000901110003','00002001120004','00002001120006','00002001120008','00002001120009','00002001120010','00002001120011','00002001120013',"+
"'00002001120014','00002001120015','00002001120018','00002001120019','00002001120020','00002001120021','00002001120022','00002001120023',"+
"'00010601110002','00011001120002','01010101100019','01010101110005','01010201080068','01010201090020','01010201090037','01010501090235',"+
"'01010601100485','01010701080130','01010701080137','01010701090011','01010701090223','01010708080024','01010801090055','01010901110017',"+
"'01011401090068','01011408090057','01011501090224','01011901110004','01011911110020','01011911110021','01011911110022','01011911110025',"+
"'01011911110027','01011911110029','01011911110031','01011911110032','01011911110033','01011911110037','01011911110039','01011911110040',"+
"'01011911110041','01011911110042','01011911110043','01011911110045','01011911110046','01011911110047','01011911110048','01011911110049',"+
"'01011911110050','01011911110051','01011911110052','01011911110053','01011911110054','01011911110055','01011911110057','01011911110058',"+
"'01011911110059','01011911110063','01011911110064','01011911110065','01011911110066','01011911110067','01011911110070','01011911110071',"+
"'01011911110072','01011911110073','01011911110074','01011911110076','01011911110077','01011911110078','01011911110080','01011911110082',"+
"'01011911110085','01011911110086','01011911110088','01011911110090','01011911110091','01011911110092','01011911110093','01011911110095',"+
"'01011911110096','01011911110097','01011911110099','01011911110100','01011911110102','01011911110103','01011911110104','01011911110105',"+
"'01011911110106','01011911110107','01011911110108','01011911110109','01011911110110','01011911110111','01011911110112','01011911110113',"+
"'01011911110114','01011911110116','01011911110117','01011911110118','01011911110119','01011911110120','01011911110121','01011911110122',"+
"'01011911110124','01011911110125','01011911110126','01011911110127','01011911110128','01011911110129','01011911110130','01011911110131',"+
"'01011911110132','01011911110134','01011911110135','01011911110136','01011911110137','01011911110138','01011911110139','01011911110140',"+
"'01011911110141','01011911110142','01011911120001','01011911120002','01011911120003','01011911120004','01011911120005','01011911120006',"+
"'01011911120008','01011911120010','01011911120011','01011911120012','01011911120013','01012101080016','01012101090030','01012108080048',"+
"'01020101090004','01020108090077','01020601080143','01030301100001','01030301100153','01030301100184','01030301100291','01040101100002',"+
"'01040102080001','01040201080010','01050101090022','01050108090015','01050201090003','01050201090004','01050201100028','01050201100043',"+
"'01050501090083','01050501090202','01050601090195','01050601100033','01050701080065','01051408090144','01051901090044','01051901090067',"+
"'01051901100020','01051901100021','01052101090030','01052108090065','01052301090133','01052301110003','01071203090003','01071203090004',"+
"'04031303090001','04051501090041','04051501090045','04130603110001','05001901120001','12011303090002','14000104110015','14000104110016',"+
"'14000104110017','14000104110022','14000104110024','14000104110028','14000104110030','14000104110031','14000104110033','14000104110034',"+
"'14000104110035','14000104110038','14000104110039','14000104110134','14000104110140','14000104110141','14000104110147','14000104110160',"+
"'14000104110168','14000104110199','14000104110205','14000104110206','14000104110207','14000304110056','14000304110058','14000304110060',"+
"'14000304110066','14000304110067','14000304110068','14000304110070','14000304110110','14000501110015','14000501110016','14000901110016',"+
"'14000901110060','14000904110085','14002001120001','14002001120002','14002001120003','14002001120013','14002204120001','14002204120002',"+
"'14002204120003','14002204120004','14010104110028','14011001110018','14011001120001','14011001120002','14011001120003','14011001120004',"+
"'14011001120005','14011001120006','14011001120007','15000101110046','15000101110048','15000101110054','15000101110056','15000101110057',"+
"'15000901110241','15002303100005','15010501110010','15012301120008','18000803090004','23002301080060','25011001120001','25011001120002',"+
"'26011001120002','34000104110002','34000104110004','34000104110012','34000104110064','34000104110065','34000104110066','34000104110067',"+
"'34000104110068','34000104110069','34000104110070','34000104110071','34000104110074','34000601100014','34000601100018','34002001120003',"+
"'34002001120004','34002001120005','34002001120006','34002001120009','34002001120010','34002001120011','34011301120001','35000904120001',"+
"'35010501110003','35020904120001','36000601110008','36000601110009','36000601110011','36000601110013','36000601110014','36000701110007',"+
"'36000701110027','36000701110029','36000701110032','36000701110033','36000701110034','36001401110028','36001901120001','36002201110055',"+
"'36002201110056','36010501110018','36010601110043','36010601110044','36010601110046','36010601110047','36010601110049','36010601110050',"+
"'36010601110053','36010601110055','36010601110056','36010601110057','36010601110063','36010601110066','36010601110069','36010601110070',"+
"'36010601110072','36010601110074','36010601110077','36010601110079','36010601110084','36010601110088','36010601110090','36010601110095',"+
"'36010601110099','36010601110105','36010601110107','36010601110108','36010601110136','36010601110138','36010601110139','36010601110140',"+
"'37001901120001','37001901120002','37001901120003','37001901120009','37001901120011','37001901120012','37001901120013','37001901120014',"+
"'37001901120015','37001901120016','37001901120017','37001901120018','37001901120019','37001901120021','37001901120022','37001901120023',"+
"'37001901120025','37001901120026','37001901120027','37001901120028','37001901120029','37001901120031','37001901120033','37001901120035',"+
"'37001901120036','44002001120001','44011001120001','44011001120002','44011001120003','44011001120004','44011001120005','44011001120007',"+
"'44012301120001','49010101100010','49010101100062','49010101100094','49010101100108','49010111110003','49010111110004','49010111110005',"+
"'49010111110008','49010111110009','49010111110010','49010111110011','49010111110012','49010111120001','49010111120002','49010111120003',"+
"'49010111120004','49010111120005','49010111120006','49010111120027','49010111120030','49010201100023','49010201100028','49010201100038',"+
"'49010201100058','49010401100067','49010401100142','49010401100147','49010401110022','49010401110026','49010401110059','49010501110006',"+
"'49010511120001','49010701100077','49010701100083','49010701100125','49010701100128','49010701100132','49010701110032','49010701110059',"+
"'49010711120088','49010711120089','49010711120103','49010711120123','49010711120139','49010711120142','49010711120144','49010711120145',"+
"'49010801110018','49010901100052','49010901110029','49011001100002','49011001100005','49011001100013','49011001100023','49011001100024',"+
"'49011001100026','49011001100027','49011001100035','49011001100036','49011001100037','49011001100040','49011001100041','49011001100046',"+
"'49011001100047','49011001100055','49011001100067','49011001100068','49011001100075','49011001100086','49011001100088','49011001100097',"+
"'49011001100143','49011001100145','49011001100146','49011001100147','49011001100148','49011001100216','49011001100268','49011001100277',"+
"'49011001100279','49011001100349','49011001100362','49011001100391','49011001100393','49011001100396','49011001100408','49011001100504',"+
"'49011001100509','49011001100511','49011001100532','49011001100572','49011001110008','49011001110010','49011001110206','49011001110214',"+
"'49011001110220','49011001110221','49011001110409','49011001110419','49011001110453','49011001110463','49011001110468','49011001110470',"+
"'49011001110474','49011001110480','49011001110492','49011001110499','49011001110502','49011001110505','49011001110510','49011001110516',"+
"'49011001110517','49011001110520','49011001110522','49011001110523','49011001110524','49011001110526','49011001110527','49011001110528',"+
"'49011001110529','49011001110530','49011001110532','49011001110533','49011001110535','49011001110536','49011001110537','49011001110539',"+
"'49011001110540','49011001110541','49011001110542','49011001110543','49011001110544','49011001110545','49011001110546','49011001110547',"+
"'49011001110549','49011001110550','49011001110551','49011001110553','49011001110554','49011001110555','49011001110598','49011301100009',"+
"'49011301100053','49011301100085','49011301100090','49011301100097','49011301100100','49011301110023','49011501100002','49011501100047',"+
"'49011501100060','49011501100090','49011501110004','49011501110016','49011501110028','49011701100003','49011701100019','49011701100029',"+
"'49011701100045','49011701100092','49011701100134','49011701100146','49011701100173','49011701100177','49011701100189','49011701110016',"+
"'49011701110033','49011701110047','49011701110048','49011701110049','49011701110050','49011701110052','49011701110054','49011701110055',"+
"'49011701110056','49011701110075','49011701110076','49011701110113','49011701110118','49011711110002','49011711110003','49011711110004',"+
"'49011711110007','49011711110009','49011711110011','49011711110012','49011711110056','49011711110060','49011711110086','49011711110091',"+
"'49011711120016','49011711120017','49011711120018','49011801100011','49011801100020','49011801100031','49011801100048','49011801100078',"+
"'49011801110040','49011801110070','49011801110071','49011801110072','49011801110073','49011801110074','49011801110075','49011801110077',"+
"'49011801110079','49011801110080','49011801110081','49011801110092','49011801110093','49011801110105','49011801110112','49012001110089',"+
"'49012001110096','49012011120001','49012011120004','49012011120025','49012011120026','49012011120027','49012101100088','49012101100094',"+
"'49012101100095','49012101100097','49012101100108','49012101100130','49012101100132','49012101100133','49012101100142','49012101100144',"+
"'49012101100148','49012101110037','49012101110038','49012101110051','49012101110055','49012201100011','49012201100025','49012201100026',"+
"'49012201100037','49012201100038','49012201100042','49012201100043','49012201100049','49012201100052','49012201100062','49012201110001',"+
"'49012201110012','49012211120002','49012211120007','49012211120008','49012211120009','49012211120010','49012211120011','49012211120012',"+
"'49012211120017','49012211120018','49012211120019','49012211120020','49012211120036','49012211120044','49012211120045','49012211120046',"+
"'49012301100052','49012301100068','49012301100069','49012301100093','49012301110022','49012301110034','49012301110039','49012301110040',"+
"'49012301110041','49012301110101','49020201100003','49020601110005','49021001100065','49021001100131','49021001100144','49021001110045',"+
"'49021001110049','49021001110052','49021001110053','49021001110056','49021101110003','49021501100018','49021501110007','49021501110011',"+
"'49021801100005','49022001110007','49022101100003','49022101100035','49022101100044','49022101100049','49022101100050','49022101100052',"+
"'49022101110005','49022201100004','49022201100007','49022201100009','49022201100010','49022301100001','49030101100020','49030401100028',"+
"'49031001100025','49031001110005','49031001110006','49031501100017','49031501100032','49031501100038','49031701100001','49031701100014',"+
"'49031701100015','49031701100023','49031701100031','49031701110015','49031801110009','49032101100020','49032101100034','49032101100036',"+
"'49032101100040','49032101100146','49032101100151','49032101100154','49032101100167','49032101100176','49032101100191','49032101100192',"+
"'49032101110012','49032101110022','49032101110046','49032101110047','49032101110051','49032101110078','49032101110093','49032101110096',"+
"'49032201100009','49032201100011','49032201100013','49032201100026','49032201100028','49032201100032','49032201110005','49032211120001',"+
"'49032211120002','49032211120006','49032211120009','49032211120014','49032211120017','49032211120018','49032211120021','49032211120025',"+
"'49032211120026','49032301100022','49032301110010','49032301110021','49032301110022','49032301110029','53010701110028','58011201100030',"+
"'58011201100040','58011201100052','58011201100057','58011201110001','58011201110006','58011201110032','60012001110005','60012001110006',"+
"'60012001120001','60012203110001','60012303110001','61010601110004','63012201120001','63012201120002','63012201120003','63012201120010',"+
"'63012201120039','63012201120041','63012201120061','63012201120075','63012201120078','63012201120079','63012201120080','63012201120137',"+
"'63012201120150','63012201120151','63012201120180','63012201120183','63012201120186','63012201120189','63012201120190','63012201120194',"+
"'63012201120197','63012201120198','63012201120214','63012201120225','63012201120230','63012201120233','63012201120240','63012201120247',"+
"'63012201120248','63012201120249','63012201120252','01011911110034','01021901100002','14012301120002','15000101110055','15012301110004','36000701110036','36000701110037','36000701110038',"+
"'37001901120010','49011301100101','49011501100038','49012301110038','01010701090189','01020701080031','01020701080010','01050701080065','49010701100128','49010701100126','49020701110013','49010701100132','51010703100006','46011203100001','60012203110001')";*/


//qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code, to_char(b.GROUNDING_DATE,'dd/mm/yyyy'),to_char(c.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_commencement_tbl b,rws_work_completion_tbl c where a.work_id=b.work_id and a.work_id=c.work_id(+) and b.grounding_date is not null";


qq="select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0 011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20',' 0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code  from rws_work_admn_tbl a,temp_works t where t.work_id=a.work_id";

	st1 = conn1.createStatement();
stqq  = conn.createStatement();
	System.out.println("MyQuery:"+qq);
				
		rsqq = stqq.executeQuery(qq);
	

		while(rsqq.next())
		{  
		  
			System.out.println(">>>>>>>>>>>>>>>>>>.");
			String slipreason = "";
			int prstatus = 0,prestatus = 0;
			try{
						workid = rsqq.getString("WORK_ID");
                              //49012111120432
                         if(workid.substring(6,8).equals("11")){
						workname = rsqq.getString("WORK_NAME");
						dcode = rsqq.getString("dcode");
						schemetypeid = rsqq.getString("SCHEMETYPEID");
						type = rsqq.getString("TYPE");
						String dates = rsqq.getString("SANCYEAR");
						String finalSancYear="";int da=0;int ye=0;
 if(dates!=null){
						 da = Integer.parseInt(dates.substring(3,5));
						 ye = Integer.parseInt(dates.substring(6,10)); }
						if(da<=03)finalSancYear = ye-1+"-"+ye;
						else finalSancYear = ye+"-"+(ye+1);
						sancyear = finalSancYear;
						if(rsqq.getInt("SANCTION_AMOUNT")>100)
							estcost = ""+rsqq.getLong("SANCTION_AMOUNT")*100000;
						else
							estcost = ""+rsqq.getDouble("SANCTION_AMOUNT")*100000;
						BigDecimal bd = new BigDecimal(estcost);
						bd = bd.setScale(2,BigDecimal.ROUND_HALF_UP);
						estcost = ""+bd.doubleValue();
						revestcost = "0";
						//goicost=rsqq.getString("A");
						//statecost=rsqq.getString("B");
						//commcont=rsqq.getString("C");
						//dofcomm = rsqq.getString("GROUNDING_DATE");
						//if(dofcomm==null)dofcomm="01/09/2010";
						  //dofcomm=rsqq.getString(12);  //15-MAY-06 
					      System.out.println("Date Of Comm"+dofcomm);

						capacity = "0";
						service = "40";
						exp = "0";
						moreexp = "0";
						psy="2012-2013";
						atm="No";
				//dofcomp="31/03/2013";

		query = "insert into RWS_Schemes1(SchemeId,work_id,MainSchemeId,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,ProjectShelfYear,programme_code,subprogramme_code,category_code,old_new,aug_new_code)	values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'1',?)";
				System.out.println("final querysreeeeeeeee:"+query);
				PreparedStatement ps=conn.prepareStatement(query);
                ps.setString(1,workid);
				ps.setString(2,  workid);
				ps.setString(3, main);
				ps.setString(4,workname);
				ps.setString(5, stateid);
				ps.setString(6, dcode);
				ps.setString(7,schemetypeid);
				ps.setString(8,type);
				ps.setString(9, sancyear);
				ps.setString(10,estcost);
				ps.setString(11, revestcost);
				ps.setString(12, goicost);
				ps.setString(13, statecost);
				ps.setString(14, commcont);
				ps.setDouble(15, popcov);
				ps.setString(16, capacity);
				ps.setString(17,service);
				ps.setString(18,  exp);
				ps.setString(19,moreexp);
				ps.setString(20,psy);
				ps.setString(21,rsqq.getString("programme_code"));
				 ps.setString(22,rsqq.getString("subprogramme_code"));
				 ps.setString(23,rsqq.getString("category_code"));
				 ps.setString(24,rsqq.getString("aug_new_code"));
				total +=ps.executeUpdate();
}
		    	}
		    	catch(Exception e)
		    	{
					System.out.println("errorquery:"+query);
					     e.printStackTrace();
		    	}
				finally{
				try{
				//if(st1!=null)st1.close();
				}catch(Exception e){}
		   	}
		}
		out.println("<font face=verdana size=2>"+total+" no.of Habitations exported Successfully! To download the mdb file Click the following Link:<!-- <a href=d:/habdata/habdata.mdb></font><font face=verdana size=3 color=red>Download</a></font> -->");
   }
	  catch(Exception e)
   {
        e.printStackTrace();
		System.out.println("Exception in conn"+e);
   }
   finally{
   try{
	rsqq.close();
	stqq.close();			
	}catch(Exception e){}	
   }
	%>
