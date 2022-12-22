package nic.watersoft.BaseLineSurvey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;



public class baselineSurveyDAO {
	Connection conn=null;
	ResultSet rst=null,rst1=null,rst2=null;  
	
	Statement stmt=null,stmt1=null,stmt2=null;
	DataSource datasource=null;
	
	baselineSurveyDAO()
	{
	}
	baselineSurveyDAO(DataSource datasource)
	{
		this.datasource=datasource;
	}
	private void closeAll() {
		if (rst != null) {
			try {
				rst.close();
			} catch (SQLException sqle) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException sqle) {
			}
		}
		
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
		}
	}


public void getHabDetails(String habcode,blsOrgForm frm) throws Exception {
	
	System.out.println("hab code is "+habcode);
	Connection conn;
	
	
	String qry="select ngos,shgs,women_grps,other_grps,to_char(survey_date,'dd/mm/yy') from rws_bls_other_org_ingp_tbl where HABITATION_CODE ='"+habcode+"' ";
	try{
	
		
		System.out.println("query is"+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		rst=stmt.executeQuery(qry);
		if(rst.next()){
			
			
			if(rst.getString("ngos")!=null){
				frm.setNgos(rst.getString("ngos"));
			}
			if(rst.getString("shgs")!=null){
				frm.setShgs(rst.getString("shgs"));
			}
			if(rst.getString("women_grps")!=null){
				frm.setWmngrps(rst.getString("women_grps"));
			}
			if(rst.getString("other_grps")!=null){
				frm.setOthergrps(rst.getString("other_grps"));
			}
			if(rst.getString(5)!=null){
				frm.setSurveydt(rst.getString(5));
			}

		}else{
			frm.setNgos("");
			frm.setShgs("");
			frm.setOthergrps("");
			frm.setWmngrps("");
			frm.setSurveydt("");
		}
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	
	
	

}



public int updatedata(blsOrgForm frm){
	Connection conn;
	int i=0;
	String searchqry="select * from rws_bls_other_org_ingp_tbl where HABITATION_CODE ='"+frm.getHabCode()+"' ";
	String insertqry="insert into rws_bls_other_org_ingp_tbl values(?,?,?,?,?,TO_DATE(?,'dd/mm/yyyy'))";
		String qry="update rws_bls_other_org_ingp_tbl  set ngos=?,shgs=?,women_grps=?,other_grps=?,SURVEY_DATE=TO_DATE(?,'dd/mm/yyyy') " +
			" where HABITATION_CODE =?";
	
	try{
conn=RwsOffices.getConn();
System.out.println("searchqry"+searchqry);
stmt1=conn.createStatement();
rst=stmt1.executeQuery(searchqry);
if(rst.next()){
	System.out.println("insertqry"+insertqry);
	stmt2=conn.createStatement();
	PreparedStatement pst= conn.prepareStatement(qry);
   pst.setString(1,frm.getHabCode());
   pst.setString(2,frm.getNgos());
   pst.setString(3,frm.getShgs());
   pst.setString(4,frm.getWmngrps());
   pst.setString(5,frm.getOthergrps());
   pst.setString(6,frm.getSurveydt());
	i=pst.executeUpdate();
	if(stmt2!=null){
		stmt2.close();
	}
}else{
stmt=conn.createStatement();
PreparedStatement pst= conn.prepareStatement(insertqry);
i=pst.executeUpdate();
pst.setString(1, frm.getHabCode());
pst.setString(2,frm.getShgs());
pst.setString(3,frm.getWmngrps());
pst.setString(4,frm.getOthergrps());
pst.setString(5,frm.getSurveydt());
pst.setString(6,frm.getHabCode());
if(stmt!=null){
	stmt.close();
}
}
if(stmt1!=null){
	stmt1.close();
}
	}
	catch(Exception e){
		e.getMessage();
	}
	finally
	{
		closeAll();
		}
	return i;
}

//house hold


public ArrayList gethouseholdHabDetails(String habcode) throws Exception {
	ArrayList householddet=new ArrayList();
	System.out.println("hab code is "+habcode);
	Connection conn;
	blsHouseHoldForm frm=null;
	
	String qry="select nvl(Name_of_the_head,'-'),nvl(Father_Husband_Name,'-'),nvl(RelationShip_with_Head,'-'),nvl(Card_Type,'-'),nvl(Card_Number,'-'),nvl(JobCard_Number,'-'),nvl(Total_Family_Members,0),nvl(Female_Count,0),nvl(Male_Count,0),nvl(BaseLine_Status,'-'),nvl(Caste,'-'),nvl(Is_Toilet_Available,'-'),nvl(Constructed_Department,'-'),nvl(Toilet_Type,'-'),nvl(In_Sanitary_Latrine_Serviced,'-'),nvl(Is_Toilet_being_Used,'-'),nvl(Reason_For_Not_Using_Toilets,'-'),nvl(Is_Water_Avail_For_Toilets,'-'),nvl(Is_Toilet_Functional,'-'),nvl(Is_Toilet_Defunt,'-'),nvl(Reason_For_Toilet_Defunt,'-'),nvl(Using_Community_Toilets,'-'),nvl(Drinking_Water_Source,'-'),nvl(Usageof_Water_PerDay_in_Pots,'-'),nvl(Liters_per_One_Pot,0),nvl(Is_Drinking_Water_Available,'-'),nvl(Water_Avail_In_Months,'-'),nvl(Quality_of_Drinking_Water,'-'),nvl(Dist_to_Resource_in_Meters,0),nvl(Household_PhoneNumber,'-'),nvl(Survey_Date,'-') as surveydt,nvl(household_num,0) as household_num,nvl(gender,''),nvl(aadhar_no,'-') from rws_bls_Household_tbl where HABITATION_CODE ='"+habcode+"' ";
	try{
	
		
		System.out.println("query is"+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		rst=stmt.executeQuery(qry);
		while(rst.next()){
			frm=new blsHouseHoldForm();
			frm.setHabCode(habcode);
			frm.setHedname(rst.getString(1));
			frm.setFathername(rst.getString(2));
			frm.setHedrelation(rst.getString(3));
			frm.setCardtype(rst.getString(4));
			frm.setCardnum(rst.getString(5));
			frm.setJobcardnum(rst.getString(6));
			frm.setFamilycount(Integer.toString(rst.getInt(7)));
			frm.setFemalecount(Integer.toString(rst.getInt(8)));
			frm.setMalecount(Integer.toString(rst.getInt(9)));
			frm.setBlsstatus(rst.getString(10));
			frm.setCaste(rst.getString(11));
			frm.setToilets(rst.getString(12));
			frm.setDepartmentnm(rst.getString(13));
			frm.setToilettype(rst.getString(14));
			frm.setLatrineserviced(rst.getString(15));
			frm.setToiletsuse(rst.getString(16));
			frm.setToiletsnotusereason(rst.getString(17));
			frm.setWateraviltoilets(rst.getString(18));
			frm.setToiletfnstatus(rst.getString(19));
			frm.setToiletsdefuntstatus(rst.getString(20));
			frm.setToiletsdefuntstatus(rst.getString(21));
			frm.setCommtoiletsuse(rst.getString(22));
			frm.setWatersource(rst.getString(23));
			frm.setUsagewaterpots(rst.getString(24));
			frm.setPotcapacity(Integer.toString(rst.getInt(25)));
			frm.setDrinkwateravail(rst.getString(26));
			frm.setWateravailmnths(rst.getString(27));
			frm.setWaterquality(rst.getString(28));
			frm.setSourcedistance(Double.toString(rst.getDouble(29)));
			frm.setPhonenum(rst.getString(30));
			frm.setSurveydt(rst.getString(31));
			frm.setHouseholdnum(rst.getString(32));
			frm.setGender(rst.getString(33));
			frm.setAdharcardnum(rst.getString(34));
			householddet.add(frm);
			
		}
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	
	
	
return householddet;
}
public long getHouseholdnumber(){
	long sno=0;
	Connection conn;
	String qry="select max(household_num) from rws_bls_household_tbl";
	System.out.println("maxqry is"+qry);
	try{
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		rst=stmt.executeQuery(qry);
		if(rst.next()){
				
			sno=rst.getLong(1)+1;
			
		}else{
			sno=1;
		}
		System.out.println("serial number is"+sno);
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	return sno;
}
public int inserthouseholddata(blsHouseHoldForm frm){
	System.out.println("in save method");
	int i=0;
	Connection conn;
	int famcnt=0,malecnt=0,femalecnt=0,ltforpot=0;
	Double dist=0.0;
	if(frm.getFamilycount()!=null){
		famcnt=Integer.parseInt(frm.getFamilycount());
	}
	if(frm.getFemalecount()!=null){
		femalecnt=Integer.parseInt(frm.getFemalecount());
	}
	if(frm.getMalecount()!=null){
		malecnt=Integer.parseInt(frm.getMalecount());
	}
	if(frm.getPotcapacity()!=null){
		ltforpot=Integer.parseInt(frm.getPotcapacity());
	}
	if(frm.getSourcedistance()!=null){
		dist=Double.parseDouble(frm.getSourcedistance());
	}
	String qry="insert into rws_bls_Household_tbl values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yy'),?,?,?)";
	try{
		System.out.println("insert query is "+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		PreparedStatement ps= conn.prepareStatement(qry);
		ps.setString(1, frm.getHabCode());
		ps.setString(2,frm.getHedname());
		ps.setString(3, frm.getFathername());
		ps.setString(4, frm.getHedrelation());
		ps.setString(5,frm.getCardtype());
		ps.setString(6,frm.getCardnum() );
		ps.setString(7, frm.getJobcardnum());
		ps.setInt(8, famcnt);
		ps.setInt(9,femalecnt);
		ps.setInt(10,malecnt );
		ps.setString(11,frm.getBlsstatus() );
		ps.setString(12,frm.getCaste());
		ps.setString(13,frm.getToilets() );
		ps.setString(14, frm.getDepartmentnm());
		ps.setString(15,frm.getToilettype() );
		ps.setString(16,frm.getLatrineserviced() );
		ps.setString(17,frm.getToiletsuse() );
		ps.setString(18,frm.getToiletsnotusereason());
		ps.setString(19,frm.getWateraviltoilets());
		ps.setString(20,frm.getToiletfnstatus());
		ps.setString(21,frm.getToiletsdefuntstatus());
		ps.setString(22,frm.getToiletsdefuntreason());
		ps.setString(23,frm.getCommtoiletsuse());
		ps.setString(24,frm.getWatersource());
		ps.setString(25,frm.getUsagewaterpots());
		ps.setInt(26,ltforpot);
		ps.setString(27, frm.getDrinkwateravail());
		ps.setString(28, frm.getWateravailmnths());
		ps.setString(29, frm.getWaterquality());
		ps.setDouble(30, dist);
		ps.setString(31, frm.getPhonenum());
		ps.setString(32, frm.getSurveydt());
		ps.setString(33, frm.getGender());
		ps.setString(34,frm.getAdharcardnum());
		ps.setString(35, frm.getHouseholdnum());

		i=ps.executeUpdate();
		System.out.println("value of i is"+i);
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	return i;
}
public blsHouseHoldForm getholddetails(int hhnum){
		Connection conn;
	blsHouseHoldForm frm=null;
	String qry="select nvl(Name_of_the_head,'-'),nvl(Father_Husband_Name,'-'),nvl(RelationShip_with_Head,'-'),nvl(Card_Type,'-'),nvl(Card_Number,'-'),nvl(JobCard_Number,'-'),nvl(Total_Family_Members,0),nvl(Female_Count,0),nvl(Male_Count,0),nvl(BaseLine_Status,'-'),nvl(Caste,'-'),nvl(Is_Toilet_Available,'-'),nvl(Constructed_Department,'-'),nvl(Toilet_Type,'-'),nvl(In_Sanitary_Latrine_Serviced,'-'),nvl(Is_Toilet_being_Used,'-'),nvl(Reason_For_Not_Using_Toilets,'-'),nvl(Is_Water_Avail_For_Toilets,'-'),nvl(Is_Toilet_Functional,'-'),nvl(Is_Toilet_Defunt,'-'),nvl(Reason_For_Toilet_Defunt,'-'),nvl(Using_Community_Toilets,'-'),nvl(Drinking_Water_Source,'-'),nvl(Usageof_Water_PerDay_in_Pots,'-'),nvl(Liters_per_One_Pot,0),nvl(Is_Drinking_Water_Available,'-'),nvl(Water_Avail_In_Months,'-'),nvl(Quality_of_Drinking_Water,'-'),nvl(Dist_to_Resource_in_Meters,0),nvl(Household_PhoneNumber,'-'),nvl(Survey_Date,'-') as surveydt,nvl(household_num,0) as household_num,nvl(gender,''),nvl(aadhar_no,'-'),dname,mname,pname,vname,HABITATION_CODE from rws_bls_Household_tbl a,rws_complete_hab_view b where habitation_code=panch_code and household_num ="+hhnum+" ";
	try{
		System.out.println("insert query is "+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		rst=stmt.executeQuery(qry);
		if(rst.next()){
			System.out.println("in if statement");
			frm=new blsHouseHoldForm();
			frm.setDistrict(rst.getString("dname"));
			frm.setMandal(rst.getString("mname"));
			frm.setPanchayat(rst.getString("pname"));
			frm.setVillage(rst.getString("vname"));
			frm.setHabCode(rst.getString("HABITATION_CODE"));
			frm.setHedname(rst.getString(1));
			frm.setFathername(rst.getString(2));
			frm.setHedrelation(rst.getString(3));
			frm.setCardtype(rst.getString(4));
			frm.setCardnum(rst.getString(5));
			frm.setJobcardnum(rst.getString(6));
			frm.setFamilycount(Integer.toString(rst.getInt(7)));
			frm.setFemalecount(Integer.toString(rst.getInt(8)));
			frm.setMalecount(Integer.toString(rst.getInt(9)));
			frm.setBlsstatus(rst.getString(10));
			frm.setCaste(rst.getString(11));
			frm.setToilets(rst.getString(12));
			frm.setDepartmentnm(rst.getString(13));
			frm.setToilettype(rst.getString(14));
			frm.setLatrineserviced(rst.getString(15));
			frm.setToiletsuse(rst.getString(16));
			frm.setToiletsnotusereason(rst.getString(17));
			frm.setWateraviltoilets(rst.getString(18));
			frm.setToiletfnstatus(rst.getString(19));
			frm.setToiletsdefuntstatus(rst.getString(20));
			frm.setToiletsdefuntstatus(rst.getString(21));
			frm.setCommtoiletsuse(rst.getString(22));
			frm.setWatersource(rst.getString(23));
			frm.setUsagewaterpots(rst.getString(24));
			frm.setPotcapacity(Integer.toString(rst.getInt(25)));
			frm.setDrinkwateravail(rst.getString(26));
			frm.setWateravailmnths(rst.getString(27));
			frm.setWaterquality(rst.getString(28));
			frm.setSourcedistance(Double.toString(rst.getDouble(29)));
			frm.setPhonenum(rst.getString(30));
			frm.setSurveydt(rst.getString(31));
			frm.setHouseholdnum(rst.getString(32));
			frm.setGender(rst.getString(33));
			frm.setAdharcardnum(rst.getString(34));
		}
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	return frm;
}
public int updatehouseholddata(blsHouseHoldForm frm){
	int i=0;
	Connection conn;
	String qry="update rws_bls_Household_tbl set HABITATION_CODE=?,NAME_OF_THE_HEAD=?,FATHER_HUSBAND_NAME=?,RELATIONSHIP_WITH_HEAD=?,CARD_TYPE=?,CARD_NUMBER=?,JOBCARD_NUMBER=?," +
			"TOTAL_FAMILY_MEMBERS=?,FEMALE_COUNT=?,MALE_COUNT=?,BASELINE_STATUS=?,CASTE=?,IS_TOILET_AVAILABLE=?," +
					"CONSTRUCTED_DEPARTMENT=?,TOILET_TYPE=?,IN_SANITARY_LATRINE_SERVICED=?,IS_TOILET_BEING_USED=?,REASON_FOR_NOT_USING_TOILETS=?,IS_WATER_AVAIL_FOR_TOILETS=?," +
							"IS_TOILET_FUNCTIONAL=?,IS_TOILET_DEFUNT=?,REASON_FOR_TOILET_DEFUNT=?,USING_COMMUNITY_TOILETS=?,DRINKING_WATER_SOURCE=?,USAGEOF_WATER_PERDAY_IN_POTS=?," +
									"LITERS_PER_ONE_POT=?,IS_DRINKING_WATER_AVAILABLE=?,WATER_AVAIL_IN_MONTHS=?,QUALITY_OF_DRINKING_WATER=?,DIST_TO_RESOURCE_IN_METERS=?,HOUSEHOLD_PHONENUMBER=?,SURVEY_DATE=to_date(?,'dd/mm/yy'),gender=?,aadhar_no=? where HOUSEHOLD_NUM=?";
	try{
		System.out.println("update query is "+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		PreparedStatement ps=conn.prepareStatement(qry);
		ps.setString(1, frm.getHabCode());
		ps.setString(2, frm.getHedname());
		ps.setString(3, frm.getFathername());
		ps.setString(4, frm.getHedrelation());
		ps.setString(5,frm.getCardtype());
		ps.setString(6, frm.getCardnum());
		ps.setString(7, frm.getJobcardnum());
		ps.setInt(8, Integer.parseInt(frm.getFamilycount()));
		ps.setInt(9, Integer.parseInt(frm.getFemalecount()));
		ps.setString(10,frm.getMalecount());
		ps.setString(11, frm.getBlsstatus());
		ps.setString(12, frm.getCaste());
		ps.setString(13, frm.getToilets());
		ps.setString(14, frm.getDepartmentnm());
		ps.setString(15, frm.getToilettype());
		ps.setString(16, frm.getLatrineserviced());
		ps.setString(17, frm.getToiletsuse());
		ps.setString(18, frm.getToiletsnotusereason());
		ps.setString(19, frm.getWateraviltoilets());
		ps.setString(20, frm.getToiletfnstatus());
		ps.setString(21, frm.getToiletsdefuntstatus());
		ps.setString(22, frm.getToiletsdefuntreason());
		ps.setString(23,frm.getCommtoiletsuse());
		ps.setString(24, frm.getWatersource());
		ps.setString(25, frm.getUsagewaterpots());
		ps.setString(26, frm.getPotcapacity());
		ps.setString(27, frm.getDrinkwateravail());
		ps.setString(28, frm.getWateravailmnths());
		ps.setString(29,frm.getWaterquality());
		ps.setDouble(30, Double.parseDouble(frm.getSourcedistance()));
		ps.setString(31, frm.getPhonenum());
		ps.setString(32, frm.getSurveydt());
		ps.setString(33, frm.getGender());
		ps.setString(34, frm.getAdharcardnum());
	    ps.setString(35, frm.getHouseholdnum());
		i=ps.executeUpdate();
		System.out.println("value of i is"+i);
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	return i;
}
public int deletehouseholddata(String hhnum){
	int i=0;
	Connection conn;
	String qry="delete from rws_bls_Household_tbl where HOUSEHOLD_NUM=?";
	try{
		System.out.println("delete query is "+qry);
		conn=RwsOffices.getConn();
		stmt=conn.createStatement();
		PreparedStatement ps=conn.prepareStatement(qry);
		ps.setInt(1,Integer.parseInt(hhnum));
		i=ps.executeUpdate();
		System.out.println("value of i is"+i);
	}catch(Exception e){
		e.getMessage();
	}finally
	{
		closeAll();
		}
	return i;
}
public int[] insertgiodata(ArrayList resultData) {
	int i[]={};
	Connection conn;
	
	
try{

conn=RwsOffices.getConn();
stmt=conn.createStatement();
for(int j=0;j<resultData.size();j++){
	String qry="update rws_bls_Household_tbl set gender='"+((blsHouseHoldForm)resultData.get(j)).getGender()+"',aadhar_no='"+((blsHouseHoldForm)resultData.get(j)).getAdharcardnum()+"' where HOUSEHOLD_NUM="+((blsHouseHoldForm)resultData.get(j)).getHouseholdnum()+" ";
	System.out.println("update query is "+qry);
	stmt.addBatch(qry);
}
i=stmt.executeBatch();
System.out.println("value of i is"+i);
}catch(Exception e){
e.getMessage();
}finally
{
closeAll();
}
	return i;
}
}
