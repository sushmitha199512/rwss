/*
 * Created on 10-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

/**
 * @author NIC
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class DroughtOperaions {

	Connection conn = null;

	String sqlQuery = null;

	Statement stmt = null;

	Statement stmt1 = null;

	DroughtOperaions() {
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void close() {
		try {
			if (conn != null) {
				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (stmt1 != null) {
				stmt1.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	public int insertRecords(ArrayList transportDetails) {

		try {

			SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
			String currentDate = dateFormatter.format(new Date());

			for (int i = 0; i < transportDetails.size(); i++) {
				DialyDroughtDetailsBean d = (DialyDroughtDetailsBean) transportDetails
						.get(i);

				if (d != null) {

					if (!d.isUpdate()) {

						if (d.getChecks() != null && d.getChecks().equals("on")) {

							sqlQuery = "insert into RWS_DROUGHT_HAB_TR_PVT_SO_TBL(HABITATION_CODE,DATE_OF_ENTRY,DATE_ENTERED,POPULATION_SER_TRANSPORT,POPULATION_SER_PVT_HIRED,"
									+ "TANKER_NO_OF_TRIPS,TANKER_CAPACITY,TANKER_QTY,TANKER_REMARKS,ASSET_TYPE_CODE,"
									+ "PVT_SOURCES_HIRED_NO,PVT_SOURCES_QTY,PVT_MODE_OF_SUPPLY,PVT_SOURCES_REMARKS,"
									+ "POWER_SUPPLY_REG_IRREG_LOW,POWER_SUPPLY_REMARKS,TRANSPORT_COST_PER_TRIP,TRANSPORT_TOTAL_COST,"
									+ "CAT_POPULATION_SER_TRANSPORT,CAT_TANKER_NO_OF_TRIPS,CAT_TANKER_CAPACITY,CAT_TANKER_QTY,CAT_TANKER_REMARKS,CAT_TRP_COST_PER_TRIP,CAT_TRP_TOTAL_COST)"
									+ "values ('"
									+ d.getHabCode()
									+ "',"
									+ "to_date('"
									+ d.getDateOfEntry()
									+ "',"
									+ "'dd/mm/yyyy'),"
									+ "to_date(sysdate,"
									+ "'dd/mm/yyyy')"
									+ ",'"
									+ d.getTransportPopulationServed()
									+ "','"
									+ d.getHiringPopulationServed()
									+ "','"
									+ d.getNoOfTrips()
									+ "','"
									+ d.getTanker_Capacity()
									+ "','"
									+ d.getTanker_QTY()
									+ "','"
									+ d.getTanker_Remarks()
									+ "','"
									+ d.getAssetType()
									+ "','"
									+ d.getPvtSourceHiredNo()
									+ "','"
									+ d.getPvtSourceQTY()
									+ "','"
									+ d.getPvtModeOfSupply()
									+ "','"
									+ d.getPvtRemarks()
									+ "','"
									+ d.getPowerProblemType()
									+ "','"
									+ d.getPowerSupplyRemarks() 
									+ "','"
									+ d.getTankerCostPerTrip() 
									+ "','"
									+ d.getTankerCost() 
									+ "','"
									+ d.getCattle_transportPopulationServed()
									+ "','"
									+ d.getCattle_noOfTrips()
									+ "','"
									+ d.getCattle_tanker_Capacity()
									+ "','"
									+ d.getCattle_tanker_QTY()
									+ "','"
									+ d.getCattle_tanker_Remarks()
									+ "','"
									+ d.getCattle_tankerCostPerTrip() 
									+ "','"
									+ d.getCattle_tankerCost() 	
									+ "')";
							stmt.addBatch(sqlQuery);

						}
					} else {

						if (isExists(d)) {
							sqlQuery = "update RWS_DROUGHT_HAB_TR_PVT_SO_TBL set POPULATION_SER_TRANSPORT ='"
									+ d.getTransportPopulationServed()
									+ "',POPULATION_SER_PVT_HIRED ='"
									+ d.getHiringPopulationServed()

									+ "',TANKER_NO_OF_TRIPS='"
									+ d.getNoOfTrips()
									+ "',TANKER_CAPACITY='"
									+ d.getTanker_Capacity()
									+ "',TANKER_QTY='"
									+ d.getTanker_QTY()
									+ "',TANKER_REMARKS='"
									+ d.getTanker_Remarks()
									+ "',ASSET_TYPE_CODE='"
									+ d.getAssetType()
									+ "',PVT_SOURCES_HIRED_NO='"
									+ d.getPvtSourceHiredNo()
									+ "',PVT_SOURCES_QTY='"
									+ d.getPvtSourceQTY()
									+ "',PVT_MODE_OF_SUPPLY='"
									+ d.getPvtModeOfSupply()
									+ "',POWER_SUPPLY_REG_IRREG_LOW='"
									+ d.getPowerProblemType()
									+ "',POWER_SUPPLY_REMARKS='"
									+ d.getPowerSupplyRemarks()
									+ "',TRANSPORT_COST_PER_TRIP='"+d.getTankerCostPerTrip()+"'"
									+ ",TRANSPORT_TOTAL_COST='"+d.getTankerCost()+"'"
									+ ",CAT_POPULATION_SER_TRANSPORT='"+d.getCattle_transportPopulationServed()+"'"
									+ ",CAT_TANKER_NO_OF_TRIPS='"+d.getCattle_noOfTrips()+"'"
									+ ",CAT_TANKER_CAPACITY='"+d.getCattle_tanker_Capacity()+"'"
									+ ",CAT_TANKER_QTY='"+d.getCattle_tanker_QTY()+"'"
									+ ",CAT_TANKER_REMARKS='"+d.getCattle_tanker_Remarks()+"'"
									+ ",CAT_TRP_COST_PER_TRIP='"+d.getCattle_tankerCostPerTrip()+"'"
									+ ",CAT_TRP_TOTAL_COST='"+d.getCattle_tankerCost()+"'"
									+ " where HABITATION_CODE='"
									+ d.getHabCode()
									+ "' and  DATE_OF_ENTRY=to_date('"
									+ d.getDateOfEntry() + "','dd/mm/yyyy')";
							stmt.addBatch(sqlQuery);
						} else {
							sqlQuery = "insert into RWS_DROUGHT_HAB_TR_PVT_SO_TBL(HABITATION_CODE,DATE_OF_ENTRY,DATE_ENTERED,POPULATION_SER_TRANSPORT,POPULATION_SER_PVT_HIRED,"
									+ "TANKER_NO_OF_TRIPS,TANKER_CAPACITY,TANKER_QTY,TANKER_REMARKS,ASSET_TYPE_CODE,"
									+ "PVT_SOURCES_HIRED_NO,PVT_SOURCES_QTY,PVT_MODE_OF_SUPPLY,PVT_SOURCES_REMARKS,"
									+ "POWER_SUPPLY_REG_IRREG_LOW,POWER_SUPPLY_REMARKS,TRANSPORT_COST_PER_TRIP,TRANSPORT_TOTAL_COST"
									+ "CAT_POPULATION_SER_TRANSPORT,CAT_TANKER_NO_OF_TRIPS,CAT_TANKER_CAPACITY,CAT_TANKER_QTY,CAT_TANKER_REMARKS,CAT_TRP_COST_PER_TRIP,CAT_TRP_TOTAL_COST)"
									+ "values ('"
									+ d.getHabCode()
									+ "',"
									+ "to_date('"
									+ d.getDateOfEntry()
									+ "',"
									+ "'dd/mm/yyyy'),"
									+ "to_date('"
									+ d.getDateEntered()
									+ "',"
									+ "'dd/mm/yyyy')"
									+ ",'"
									+ d.getTransportPopulationServed()
									+ "','"
									+ d.getHiringPopulationServed()
									+ "','"
									+ d.getNoOfTrips()
									+ "','"
									+ d.getTanker_Capacity()
									+ "','"
									+ d.getTanker_QTY()
									+ "','"
									+ d.getTanker_Remarks()
									+ "','"
									+ d.getAssetType()
									+ "','"
									+ d.getPvtSourceHiredNo()
									+ "','"
									+ d.getPvtSourceQTY()
									+ "','"
									+ d.getPvtModeOfSupply()
									+ "','"
									+ d.getPvtRemarks()
									+ "','"
									+ d.getPowerProblemType()
									+ "','"
									+ d.getPowerSupplyRemarks() 
									+ "','"
									+d.getTankerCostPerTrip()
									+"','"
									+d.getTankerCost()
									+ "','"
									+ d.getCattle_transportPopulationServed()
									+ "','"
									+ d.getCattle_noOfTrips()
									+ "','"
									+ d.getCattle_tanker_Capacity()
									+ "','"
									+ d.getCattle_tanker_QTY()
									+ "','"
									+ d.getCattle_tanker_Remarks()
									+ "','"
									+ d.getCattle_tankerCostPerTrip() 
									+ "','"
									+ d.getCattle_tankerCost() 
									+ "')";
							stmt.addBatch(sqlQuery);

						}
					}

				}
				sqlQuery = "";
			}

			int res[] = stmt.executeBatch();

			for (int i = 0; i < res.length; i++) {
				if (res[i] < 0) {
					return 0;
				}
			}

		}

		catch (Exception e) {
		System.out.println("Exception in insertRecords of DroughtOperations-- "+e);
		}

		return 1;
	}

	/**
	 * @param d
	 * @return
	 */
	private boolean isExists(DialyDroughtDetailsBean d) {
		ResultSet rs = null;
		//System.out.println("ssss");
		String q = "select * from RWS_DROUGHT_HAB_TR_PVT_SO_TBL where HABITATION_CODE='"
				+ d.getHabCode()
				+ "' and DATE_OF_ENTRY=to_date('"
				+ d.getDateOfEntry() + "','dd/mm/yyyy')";
		try {
			rs = stmt1.executeQuery(q);
			if (rs.next())
				return true;
			else
				return false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	public boolean deleteDroughtHabitaionFromDialyEntry(String habCode,
			String currentDate) {

		String q = "delete from RWS_DROUGHT_HAB_TR_PVT_SO_TBL where HABITATION_CODE=?"
				+ " and DATE_OF_ENTRY=to_date(?,'dd/mm/yyyy')";
		try {

			PreparedStatement stmt= conn.prepareStatement(q);
			stmt.setString(1, habCode);
			stmt.setString(2, currentDate);
			if (stmt.executeUpdate() > 0)
				return true;

		} catch (Exception e) {
			System.out.println("Exception in deleteDroughtHabitaionFromDialyEntry of DroughtOperations -- "+e);
		}
		return false;
	}

 
	
	public ArrayList getDistricts() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs1 = null;
		LabelValueBean labelValuebean = null;
		ArrayList districts = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			
			String query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_drought_habitation_tbl c where "
					+ "d.dcode=substr(c.habcode,1,2) order by d.dname";
			stmt = conn.prepareStatement(query);
			rs1 = stmt.executeQuery();
			while (rs1.next()) {
				labelValuebean = new LabelValueBean();
				labelValuebean.setLabel(rs1.getString(2));
				labelValuebean.setValue(rs1.getString(1));
				districts.add(labelValuebean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getDistricts of DroughtOperations -- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getDistricts finally of DroughtOperations -- "+e);
			}
		}
		return districts;
	}

	
	
	public Object getDivisions(String dcode) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs1 = null;
		LabelValueBean labelValuebean = null;
		ArrayList divisions = new ArrayList();

		try {
			conn = RwsOffices.getConn();
		
			String query = "select distinct d.CIRCLE_OFFICE_CODE,d.DIVISION_OFFICE_CODE,d.DIVISION_OFFICE_NAME "
					+ " from rws_division_office_tbl d,rws_drought_habitation_tbl c where d.CIRCLE_OFFICE_CODE=?"
					+ " and d.CIRCLE_OFFICE_CODE=substr(c.habcode,1,2) and d.status<>'UI' order by d.DIVISION_OFFICE_CODE";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			rs1 = stmt.executeQuery();
			while (rs1.next()) {
				labelValuebean = new LabelValueBean();
				labelValuebean.setLabel(rs1.getString(3));
				labelValuebean.setValue(rs1.getString(2));
				divisions.add(labelValuebean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getDivisions  of DroughtOperations -- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getDivisions finally of DroughtOperations -- "+e);
			}
		}
		return divisions;
	}

	
	
	public ArrayList getMandals(String dcode, String divcode) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs1 = null;
		LabelValueBean labelValuebean = null;
		ArrayList mandals = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			
			String query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_drought_habitation_tbl c,"
					+ "rws_mandal_subdivision_tbl man where d.dcode=? and d.mcode=substr(c.habcode,6,2) and d.dcode=substr(c.habcode,1,2)"
					+ " and man.dcode=? and man.CIRCLE_OFFICE_CODE=?  and d.mcode=man.mcode and "
					+ "man.DIVISION_OFFICE_CODE=?  order by d.mname";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, dcode);
			stmt.setString(3,dcode);
			stmt.setString(4, divcode);
			
			rs1 = stmt.executeQuery();
			while (rs1.next()) {
				labelValuebean = new LabelValueBean();
				labelValuebean.setLabel(rs1.getString(3));
				labelValuebean.setValue(rs1.getString(2));
				mandals.add(labelValuebean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getMandals  of DroughtOperations -- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getMandals finally of DroughtOperations -- "+e);
			}
		}
		return mandals;
	}

}

