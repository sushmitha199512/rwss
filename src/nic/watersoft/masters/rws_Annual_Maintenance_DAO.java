package nic.watersoft.masters;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;


import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class rws_Annual_Maintenance_DAO

{

	/**
	 * @param location
	 * @return
	 */
	private boolean isExists(Connection conn,String assetCode,String finYear) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select * from RWS_ASSET_MAS_YR_EXP_TBL where ASSET_CODE='"+assetCode+"' and fin_year='"+finYear+"'";
			rs = stmt1.executeQuery(query);
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}
	

	public ArrayList getFinancialYear(String assetCode) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;
		ArrayList arrayList=new  ArrayList();
		String finYear="";
		String fy="";
		int fy1=0;
		Connection conn=null;
		LabelValueBean labelValueBean=null;
		try {
			int year = Calendar.getInstance().get(Calendar.YEAR);
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			query = "select substr(to_char(DATE_CREATION,'dd/mm/yyyy'),7,4)  from  rws_asset_mast_tbl where DATE_CREATION is not null and asset_code='"+assetCode+"'";
			rs = stmt1.executeQuery(query);
			
				if(rs.next())
				{
					
					 fy=rs.getString(1);
					 for(int i=Integer.parseInt(fy);i<=year;i++){
						 fy=i+"";
					 fy1=Integer.parseInt(fy)+1;
					 finYear=fy+"-"+fy1;
					 labelValueBean = new LabelValueBean();
						labelValueBean.setValue(finYear);
						labelValueBean.setLabel(finYear);
					 arrayList.add(labelValueBean);
					 }
				}

		} catch (Exception e) {
			
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return arrayList;
	}

	public String saveAnnualMaintenance(AssetForm assetForm,String userid) {
		

		String query = "";
		int rcount=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String message="";
		try {
			conn = RwsOffices.getConn();
			
			if (!isExists(conn,assetForm.getAssetCode(),assetForm.getFinYear())) {

				query = "insert into RWS_ASSET_MAS_YR_EXP_TBL values(?,?,?,?,?,?,sysdate)";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, assetForm.getAssetCode());
				pstmt.setString(2, assetForm.getFinYear());
				pstmt.setString(3, assetForm.getPower());
				pstmt.setString(4, assetForm.getMeterial());
				pstmt.setString(5, assetForm.getSalaries());
				pstmt.setString(6, userid);
				rcount=pstmt.executeUpdate();
				if(rcount>0){
					message="Annual Maintenance details are saved Successfully";
					
				}
				else
				{
					message="Failed to save Annual Maintenance details";
					
				}
			} else {

				query = "update RWS_ASSET_MAS_YR_EXP_TBL set ANNUAL_POWER=?,ANNUAL_MATERIAL=?,ANNUAL_SALARIES=?,PREPARED_BY=?,UPDATE_DATE=sysdate where ASSET_CODE=? and fin_year=?";
				pstmt=conn.prepareStatement(query);
				
				pstmt.setString(1, assetForm.getPower());
				pstmt.setString(2, assetForm.getMeterial());
				pstmt.setString(3, assetForm.getSalaries());
				pstmt.setString(4, userid);
				pstmt.setString(5, assetForm.getAssetCode());
				pstmt.setString(6, assetForm.getFinYear());
				rcount=pstmt.executeUpdate();
				if(rcount>0){
					message="Annual Maintenance details are Updated Successfully";
					
				}
				else
				{
					message="Failed to Update Annual Maintenance details";
					
				}
			}

			

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in insertAnnual Maintenamce=" + e);
		} finally {
			try
			{
			if (conn != null) {

				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return message;
	
	}

	public void getAnnualMaintenanceDetails(AssetForm assetForm) {
		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;
		Connection conn=null;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			query = "select ANNUAL_POWER,ANNUAL_MATERIAL,ANNUAL_SALARIES from  RWS_ASSET_MAS_YR_EXP_TBL where  asset_code='"+assetForm.getAssetCode()+"' and fin_year='"+assetForm.getFinYear()+"'";
			System.out.println(query);
			rs = stmt1.executeQuery(query);
			
				if(rs.next())
				{
					assetForm.setPower(rs.getString("ANNUAL_POWER"));
					assetForm.setMeterial(rs.getString("ANNUAL_MATERIAL"));
					assetForm.setSalaries(rs.getString("ANNUAL_SALARIES"));
				}
				else{
					assetForm.setPower("");
					assetForm.setMeterial("");
					assetForm.setSalaries("");
				}

		} catch (Exception e) {
			
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
	
	}
	
}