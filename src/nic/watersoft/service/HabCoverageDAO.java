package nic.watersoft.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import nic.watersoft.util.DBUtil;

public class HabCoverageDAO {

	public List<DistrictCoverage> getAllCoverages() throws Exception{
		   List<DistrictCoverage> habCovList = new ArrayList<DistrictCoverage>();
		   Connection con = DBUtil.getDbConnection();
		   Statement stmt = DBUtil.getStatement(con);
		   String sql = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname," +
		   				"SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC," +
		   				"SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4," +
		   				"SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3," +
		   				"SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2," +
		   				"SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1," +
		   				"SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC," +
		   				"SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS" +
		   				" from rws_complete_hab_view hv,rws_hab_directory_view hd where" +
		   				" substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code " +
		   				" and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and" +
		   				" status_date ='01-APR-2016' group by hv.dcode,hv.dname order by hv.dcode";
		   ResultSet rs = DBUtil.getResultSet(stmt,sql);
		   while(rs.next())
		   {
			   DistrictCoverage habCovBean = new DistrictCoverage();
				
				habCovBean.setDcode(rs.getString(1));
				habCovBean.setDname(rs.getString(2));
					HabStatus habStatus = new HabStatus();
					habStatus.setFc(rs.getLong(3));
					habStatus.setPc4(rs.getLong(4));
					habStatus.setPc3(rs.getLong(5));
					habStatus.setPc2(rs.getLong(6));
					habStatus.setPc1(rs.getLong(7));
					habStatus.setNc(rs.getLong(8));
					habStatus.setNss(rs.getLong(9));
				habCovBean.setHabStatus(habStatus);
				
				habCovList.add(habCovBean);
		   }
		   DBUtil.closeResultSet(rs);
		   DBUtil.closeStatement(stmt);
		   DBUtil.closeConnection(con);
	      return habCovList;
	   }
	
	public DistrictCoverage getCoverage(String dcode) throws Exception{
	      List<DistrictCoverage> allCoverages = getAllCoverages();

	      for(DistrictCoverage habCoverage: allCoverages){
	         if(habCoverage.getDcode().equals(dcode)){
	            return habCoverage;
	         }
	      }
	      return null;
	   }
	
}
