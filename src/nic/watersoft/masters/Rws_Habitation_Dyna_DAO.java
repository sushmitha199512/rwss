package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_Habitation_Dyna_DAO {	
	private Connection conn = null;
	private String query = null;
	private RwsLocationBean rwsLocation = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null;
	private LabelValueBean labelValueBean;
	
	public String getHabStatusDate() throws Exception {
		String hbdt = "";
		PreparedStatement ps1=null;
		ResultSet rs1=null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT distinct to_char(Status_date,'dd/mm/yyyy') from RWS_HABITATION_DIR_DYNA_TBL where status_date is not null";
			ps1 = conn.prepareStatement(query);
			rs1 = ps1.executeQuery();
			if (rs1.next()) {
				hbdt = rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Habitation_Dyna_DAO getHabStausDate : "+e.getMessage());
		}finally{
			conn.close();
			ps1.close();
			rs1.close();
		}
		return hbdt;
	}
	
	public  ArrayList getPanchayatHabitations1(String user,String dcode,String mcode,String pcode) throws Exception {
		ArrayList habs=new ArrayList();
		try	{
			conn = RwsOffices.getConn();
			String query="";
			if(user.equals("100000"))
			{
				query=" SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIR_DYNA_TBL H WHERE" +
			              " SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=? AND SUBSTR(P.PANCH_CODE,13,2)=? AND " +
						  " H.HAB_CODE=P.PANCH_CODE ORDER BY P.PANCH_NAME";		
				stmt = conn.prepareStatement(query);		
				stmt.setString(1, dcode);
				stmt.setString(2, mcode);
				stmt.setString(3, pcode);
			}
		   else
	       {
		  	   query="SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIR_DYNA_TBL H WHERE" +
			             " SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=? AND SUBSTR(P.PANCH_CODE,13,2)=? AND " +
		  				 " H.HAB_CODE=P.PANCH_CODE AND COVERAGE_STATUS <> 'UI' union SELECT  H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIR_DYNA_TBL H WHERE" +
			             " SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=? AND SUBSTR(P.PANCH_CODE,13,2)=? AND " +
		  				 " H.HAB_CODE=P.PANCH_CODE AND COVERAGE_STATUS is null ORDER BY 3";
		  		stmt = conn.prepareStatement(query);	
		  		stmt.setString(1, dcode);
				stmt.setString(2, mcode);
				stmt.setString(3, pcode);
				stmt.setString(4, dcode);
				stmt.setString(5, mcode);
				stmt.setString(6, pcode);
	       }	
			
			rs =stmt.executeQuery();
			while ( rs.next() ) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				String status=rs.getString(4);
				habs.add(rwsLocation);
			}
		}
		catch (Exception e)	{
			System.out.println("The Exception is in Rws_Habitation_Dyna_DAO getPanchayatHabiatations1 : "+e.getMessage());
		}
		finally {
			conn.close();
			stmt.close();
			rs.close();
		}
		return habs;
	}
	
	public ArrayList getCoverageStatuses(String habCode,String userId) throws Exception {
			ArrayList coverageStatuses = new ArrayList();
			try {
				conn = RwsOffices.getConn();
				query = " SELECT coverage_status  FROM RWS_HABITATION_DIR_DYNA_TBL where hab_code=  ? ";
				stmt=conn.prepareStatement(query);
				stmt.setString(1, habCode);
				rs = stmt.executeQuery();
				String status="";
				while(rs.next()) {
					status=nic.watersoft.masters.RwsMasterData.format(rs.getString("coverage_status"));
				}
				
				if(!userId.equals("admin"))	{
					if(status.equalsIgnoreCase("FC")){
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);						
					}
					else if(status.equalsIgnoreCase("PC4"))	{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);	
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);	
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
					else if(status.equalsIgnoreCase("PC3"))	{						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("PC2"))	{
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);			
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("PC1"))	{						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("NSS"))	{						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);									
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("NC"))	{						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);				
												
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("UI"))	{						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);						
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
												
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}					
					else if(status.equalsIgnoreCase("")) {						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC1");
						labelValueBean.setLabel("PC1");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC2");
						labelValueBean.setLabel("PC2");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC3");
						labelValueBean.setLabel("PC3");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("PC4");
						labelValueBean.setLabel("PC4");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("FC");
						labelValueBean.setLabel("FC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NSS");
						labelValueBean.setLabel("NSS");
						coverageStatuses.add(labelValueBean);
												
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("NC");
						labelValueBean.setLabel("NC");
						coverageStatuses.add(labelValueBean);
						
						labelValueBean = new LabelValueBean();
						labelValueBean.setValue("UI");
						labelValueBean.setLabel("UI");
						coverageStatuses.add(labelValueBean);
					}
				}				
				else{						
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC1");
					labelValueBean.setLabel("PC1");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC2");
					labelValueBean.setLabel("PC2");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC3");
					labelValueBean.setLabel("PC3");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("PC4");
					labelValueBean.setLabel("PC4");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("FC");
					labelValueBean.setLabel("FC");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("NSS");
					labelValueBean.setLabel("NSS");
					coverageStatuses.add(labelValueBean);
										
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("NC");
					labelValueBean.setLabel("NC");
					coverageStatuses.add(labelValueBean);
					
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("UI");
					labelValueBean.setLabel("UI");
					coverageStatuses.add(labelValueBean);
				}					
			}
			
			catch(Exception e){
				System.out.println("The Exception is in Rws_Habitation_Dyna_DAO getCoverageStatuses : "+e.getMessage());
			}
			finally	{	
				conn.close();
				rs.close();
				stmt.close();
			}			
			return coverageStatuses;
		}
	
	 public  ArrayList getHabitationDetails(String dcode,String mcode,String mandalName,String constituencyCode,String constituencyName,String pcode,String pname,String vcode,String vname,DataSource dataSource) throws Exception {   
		 	RwsMaster rwsMaster = null;
			ArrayList habitaitonDetails = new ArrayList();
			String query="";			
			if(!dcode.equals("")&&!mcode.equals("")&&pcode.equals("")) {				
				query="select p.pcode,p.pname,v.vcode,v.vname, h.hab_code,h.hname,pr.panch_code,pr.panch_name from rws_panchayat_tbl p,rws_village_tbl v, " +
					"rws_habmast_tbl h, rws_panchayat_raj_tbl pr,RWS_HABITATION_DIR_DYNA_TBL hd where substr(h.hab_code,1,2)='"+dcode+"' " +
					"and substr(h.hab_code,6,2)='"+mcode+"' and (p.dcode=substr(h.hab_code,1,2)and p.mcode=substr(h.hab_code,6,2) and " +
					"p.pcode=substr(h.hab_code,13,2)) and(v.dcode=substr(h.hab_code,1,2)and v.mcode=substr(h.hab_code,6,2) and " +
					"v.pcode=substr(h.hab_code,13,2) and v.vcode=substr(h.hab_code,8,3)) and (h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code order by hd.hab_code ";
			}			
			else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&vcode.equals("")){			
				query="select v.vcode,v.vname,h.hab_code,h.hname, pr.panch_code,pr.panch_name from rws_village_tbl v," +
					" rws_habmast_tbl h,rws_panchayat_raj_tbl pr,RWS_HABITATION_DIR_DYNA_TBL hd where substr(h.hab_code,1,2)='"+dcode+"'and " +
					"substr(h.hab_code,6,2)='"+mcode+"' and substr(h.hab_code,13,2)='"+pcode+"'" +
					" and(v.dcode=substr(h.hab_code,1,2) and v.mcode=substr(h.hab_code,6,2) and v.pcode=substr(h.hab_code,13,2) " +
					" and v.vcode=substr(h.hab_code,8,3)) and (h.prhab=pr.panch_code) and  pr.panch_code=hd.hab_code";
			}
			else if(!dcode.equals("")&&!mcode.equals("")&&!pcode.equals("")&&!vcode.equals("")) {				
				query="select h.hab_code,h.hname,pr.panch_code, pr.panch_name from rws_habmast_tbl h,RWS_HABITATION_DIR_DYNA_TBL hd," +
					"rws_panchayat_raj_tbl pr where substr(h.hab_code,1,2)='"+dcode+"' and substr(h.hab_code,6,2)='"+mcode+"' " +
					"and substr(h.hab_code,13,2)='"+pcode+"' and substr(h.hab_Code,8,3)='"+vcode+"' and (h.prhab=pr.panch_code) and pr.panch_code=hd.hab_code";  
			}
			Connection conn=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			try {
				conn = RwsOffices.getConn();
				stmt = conn.prepareStatement(query);
				rs = stmt.executeQuery();
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			if(pcode.equals("")){
				rwsMaster.setPcode(rs.getString("PCODE"));
				rwsMaster.setPname(rs.getString("PNAME"));
			}
			if(vcode.equals("")) {
				rwsMaster.setVcode(rs.getString("VCODE"));
				rwsMaster.setVname(rs.getString("VNAME"));
			}
			rwsMaster.setHabCode(rs.getString("panch_CODE"));
			rwsMaster.setHabName(rs.getString("PANCH_NAME"));
			habitaitonDetails.add(rwsMaster);
		}				
		rs.close();
		stmt.close();		
		} catch (Exception e) {
			Debug.println("The Exception is in Rws_Habitation_Dyna_DAO getHabitationDetails : " + e.getMessage());
		} finally {			
			if(conn!=null){
				conn.close();
			}
		}		
		return habitaitonDetails;
	}
	 
	 public ArrayList getUiHabitations(String dcode, String mcode) throws Exception{
			ArrayList uiHabs = new ArrayList();
			PreparedStatement stmt = null;
			ResultSet rs = null;		
			try {
				conn = RwsOffices.getConn();
				String query = "select a.hab_code,panch_name  from RWS_HABITATION_DIR_DYNA_TBL a,RWS_PANCHAYAT_RAJ_TBL b where a.HAB_CODE=b.PANCH_CODE and COVERAGE_STATUS='UI' and substr(a.HAB_CODE,1,2)= ? and substr(a.HAB_CODE,6,2)= ? order by UPDATE_DATE desc  ";
				conn = RwsOffices.getConn();
				stmt = conn.prepareStatement(query);
				stmt.setString(1, dcode);
				stmt.setString(2, mcode);
				rs = stmt.executeQuery();
				while (rs.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rs.getString("hab_code"));
					labelValueBean.setLabel(rs.getString("hab_code") + "-" + rs.getString("panch_name"));
					uiHabs.add(labelValueBean);
				}
				rs.close();
				stmt.close();
			} catch (Exception e) {
				Debug.println("The Exception is in Rws_Habitation_Dyna_DAO getUiHabitations : " + e.getMessage());
			} finally {
				if(conn!=null)
				conn.close();
			}
			return uiHabs;
		}
		
		public int setStatusUItoNC(String habcode) throws Exception{
			PreparedStatement stmt = null;
			int i=0;
			try {
				conn = RwsOffices.getConn();
				String query = "update RWS_HABITATION_DIR_DYNA_TBL set COVERAGE_STATUS='NC' where HAB_CODE= ? ";
				conn = RwsOffices.getConn();
				stmt = conn.prepareStatement(query);
				stmt.setString(1, habcode);
				i=stmt.executeUpdate();
			} catch (Exception e) {
				Debug.println("The Exception is in Rws_Habitation_Dyna_DAO setStatusUItoNC : " + e.getMessage());
			} finally {
				if(conn!=null)
				conn.close();
			}
			return i;
		}
}
