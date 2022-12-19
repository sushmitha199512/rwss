package nic.watersoft.commons;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Writer;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Provider;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.Certificate;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import nic.watersoft.proposals.RepresentativeProposalForm;
import nic.watersoft.works.tenderMemo;


public class RwsOffices {
	private File pkcs11Library;

	private DataSource dataSource = null;
	private Connection conn = null;
	private PreparedStatement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private LabelValueBean labelValueBean = null;

	public RwsOffices(DataSource dataSource) {
		this.dataSource = dataSource;
		try {
			// this.conn1 = conn2;
		} catch (Exception ee) {
			System.out.println("The exception in RwsOffices RwsOffices = "+ee.getMessage());
		}
	}
	public RwsOffices() {

	}

	public void closeAll() throws Exception {
		if (rset != null) {
			try {
				   rset.close();
			    } 
			catch (Exception e) {
				System.out.println("The exception in RwsOffices closeAll = "+e.getMessage());
			}
			rset = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				System.out.println("The exception in RwsOffices closeAll = "+e.getMessage());
			}
			rset = null;
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (Exception e) {
				System.out.println("The exception in RwsOffices closeAll = "+e.getMessage());
			}
			stat = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				System.out.println("The exception in RwsOffices closeAll = "+e.getMessage());
			}
			conn = null;
		}
		
	}

	/**
	 * Gets the various RWS Head Offices
	 */
	public ArrayList getHeads() throws Exception {
		ArrayList headOffices = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT HEAD_OFFICE_CODE, HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL ORDER BY HEAD_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				headOffices.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return headOffices;
	}

	public ArrayList getMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT DISTINCT DCODE, MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE = ? ORDER BY MNAME";			
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getMandals : "+e.getMessage());
		} finally {
			closeAll();
		}
		return mandals;
	}
	
	public ArrayList getUrbanMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM URBAN_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getUrbanMandals = "+e.getMessage());
		} finally {
			closeAll();
		}
		return mandals;
	}

	public String getMonthFromDual() throws Exception {
		String month = "";
		try {
			conn = getConn();
			query = "SELECT TO_CHAR(SYSDATE,'MON') FROM DUAL";
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			if (rset.next()) {
				month = rset.getString(1);
			}
		} finally {
			closeAll();
		}
		return month;
	}

	/**
	 * Gets the various circle offices in specified head office
	 * 
	 * @param headOfficeCode
	 * @return ArrayList
	 * @throws Exception
	 */
	public String getOfficeType(String officeCode) throws Exception {
		if (officeCode.equals("000000"))
			return "";

		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);

		String query = null;
		String officeType = null;

		if (!subdivisionOfficeCode.equals("00")) {
			officeType = "Sub Division";
		} else if (!divisionOfficeCode.equals("0")) {
			officeType = "Division";
		} else if (!circleOfficeCode.equals("00")) {
			officeType = "Circle";
		} else if (!headOfficeCode.equals("0")) {
			officeType = "Head Office";
		}
		return officeType;
	}

	public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL ORDER BY DCODE,DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDistricts : "+e.getMessage());
		} finally {
			closeAll();
		}

		return dists;
	}
	
	public ArrayList getUrbanDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DCODE, DNAME FROM URBAN_DISTRICT_TBL ORDER BY DCODE,DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getUrbanDistricts = "+e.getMessage());
		} finally {
			closeAll();
		}
		return dists;
	}

	public ArrayList getConstituencies(String dcode) throws Exception {
		ArrayList constituencies = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT DISTINCT CONSTITUENCY_CODE, CONSTITUENCY_NAME FROM RWS_CONSTITUENCY_TBL WHERE DCODE=? ORDER BY CONSTITUENCY_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				constituencies.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getConstituencies : "+e.getMessage());
		} finally {
			closeAll();
		}
		return constituencies;
	}

	public String[] getOfficeNames(String officeCode, boolean showOfficeType, DataSource dataSource) throws Exception {
		String officeName[] = new String[5];
		if (officeCode.equals("000000"))
			return null;
		try {
			String headOfficeCode = officeCode.substring(0, 1);
			String circleOfficeCode = officeCode.substring(1, 3);
			String divisionOfficeCode = officeCode.substring(3, 4);
			String subdivisionOfficeCode = officeCode.substring(4, 6);
			String query = null;
			String officeType = null;

			conn = getConn();
			if (!headOfficeCode.equals("0")) {
				query = "SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ?";
				stat = conn.prepareStatement(query);
				stat.setString(1, headOfficeCode);
				rset = stat.executeQuery();
				while (rset.next()) {
					if (rset.getString(1) != null) {
						officeName[0] = rset.getString(1) + " " + "Head Office\n";
					} else {
						officeName[0] = "null";
					}
				}

				if (!circleOfficeCode.equals("00")) {
					query = " SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL "
							+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ";
					stat = conn.prepareStatement(query);
					stat.setString(1, headOfficeCode);
					stat.setString(2, circleOfficeCode);
					rset = stat.executeQuery();
					while (rset.next()) {
						if (rset.getString(1) != null) {
							officeName[1] = rset.getString(1) + " "	+ "Circle Office\n";
						} else {
							officeName[1] = "null";
						}
					}

					if (!divisionOfficeCode.equals("0")) {
						query = " SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL "
							+ " WHERE HEAD_OFFICE_CODE = ? AND  CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ";
						stat = conn.prepareStatement(query);
						stat.setString(1, headOfficeCode);
						stat.setString(2, circleOfficeCode);
						stat.setString(3, divisionOfficeCode);
						rset = stat.executeQuery(query);
						while (rset.next()) {
							if (rset.getString(1) != null) {
								officeName[2] = rset.getString(1) + " "	+ "Division Office\n";
							} else {
								officeName[2] = "null";
							}
						}

						if (!subdivisionOfficeCode.equals("00")) {

							query = " SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL "
								+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
							stat = conn.prepareStatement(query);
							stat.setString(1, headOfficeCode);
							stat.setString(2, circleOfficeCode);
							stat.setString(3, divisionOfficeCode);
							stat.setString(4, subdivisionOfficeCode);
							rset = stat.executeQuery();
							while (rset.next()) {
								if (rset.getString(1) != null) {
									officeName[3] = rset.getString(1) + " "	+ "SubDivision Office";
								} else {
									officeName[3] = "null";
								}
							}
						}
					}
				}
			}

		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getOfficeNames = "+e.getMessage());
		}

		finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The exception in RwsOffices getOfficeNames = "+e.getMessage());
			}
		}
		if (showOfficeType)
			return officeName;
		else
			return officeName;
	}

	public ArrayList getCircles() throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME "
				+ " FROM RWS_CIRCLE_OFFICE_TBL ORDER BY CIRCLE_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getDistricts1() throws Exception {
		ArrayList districts = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DCODE,DNAME FROM RWS_DISTRICT_TBL ORDER BY DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				districts.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getDistricts1 = "+e.getMessage());
		} finally {
			closeAll();
		}

		return districts;
	}

	public static String getDivisions(DataSource dataSource, String headOfficeCode, String circleOfficeCode) throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			String query = " SELECT DIVISION_OFFICE_NAME, DIVISION_OFFICE_CODE FROM RWS_DIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME ";
			PreparedStatement ps = conn.prepareStatement(query,	ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {
				buffer.append("<//>");
			} else {
				rs.beforeFirst();
				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}
				buffer.append("<//>");
				
				query = "SELECT DNAME,DCODE FROM RWS_DISTRICT_TBL WHERE DCODE= ?";
				PreparedStatement ps1 = conn.prepareStatement(query);
				ps1.setString(1, circleOfficeCode);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}
				buffer.append("<//>");

				query = "SELECT MNAME,MCODE FROM RWS_MANDAL_TBL WHERE DCODE= ? ORDER BY MNAME";
				PreparedStatement ps2 = conn.prepareStatement(query);
				ps2.setString(1, circleOfficeCode);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					buffer.append(rs2.getString(1) + "<>");
					buffer.append(rs2.getString(2) + "</>");
				}

			}

		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getDivisions = "+e.getMessage());
		}

		finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("The exception in RwsOffices getDivisions = "+e.getMessage());
			}
		}
		return buffer.toString();
	}

	public static String getOffices(DataSource dataSource, String officeCode) throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			String query = " SELECT DIVISION_OFFICE_NAME, DIVISION_OFFICE_CODE FROM RWS_DIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME ";
			PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ps.setString(1, officeCode);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {
				buffer.append("<//>");
			} else {
				rs.beforeFirst();
				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}
				buffer.append("<//>");				
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getOffices = "+e.getMessage());
		}

		finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Exception in RwsOffices getOffices CloseAll "+e);
			}
		}
		return buffer.toString();

	}

	public static String getSubDivisions(DataSource dataSource, String headOfficeCode, String circleOfficeCode,	String divisionOfficeCode) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			String query = "SELECT SUBDIVISION_OFFICE_NAME, SUBDIVISION_OFFICE_CODE FROM RWS_SUBDIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ORDER BY SUBDIVISION_OFFICE_NAME ";
			PreparedStatement ps = conn.prepareStatement(query,	ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {
			} else {
				rs.beforeFirst();
				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

				buffer.append("<//>");

				query = "SELECT M.MNAME ,M.MCODE FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MM  "
						+ "WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND MM.CIRCLE_OFFICE_CODE= ? AND MM.DIVISION_OFFICE_CODE= ? ORDER BY MNAME";
				PreparedStatement ps1 = conn.prepareStatement(query);
				ps1.setString(1, circleOfficeCode);
				ps1.setString(2, divisionOfficeCode);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}
				rs1.close();
				ps1.close();
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getSubDivisions = "+e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				System.out.println("Exception in RwsOffices getSubDivisions CloseAll "+e);
			}
		}
		return buffer.toString();
	}

	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDistrictMandals : "+e.getMessage());
		} finally {
			closeAll();
		}

		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE=? AND MCODE=? ORDER BY PNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				panchayats.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getPanchayats : "+e.getMessage());
		} finally {
			closeAll();
		}
		return panchayats;
	}

	 
	public String getDivname(String dcode, String mcode) throws Exception {
		String query = null;
		String dname = "";
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_NAME,B.DIVISION_OFFICE_CODE FROM RWS_MANDAL_SUBDIVISION_TBL A, RWS_DIVISION_OFFICE_TBL B WHERE DCODE= ? AND MCODE= ? AND A.DIVISION_OFFICE_CODE=B.DIVISION_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, mcode);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				dname = rs.getString(1) + "-" + rs.getString(2);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDivname : "+e.getMessage());
		} finally {
			closeAll();
		}
		return dname;
	}

	 
	public String getSubDivname1(String dcode, String divcode, String sdcode)throws Exception {
		String query = null;
		String sdname1 = "";
		try {
			conn = getConn();
			query = "SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE= ? AND SUBDIVISION_OFFICE_CODE = ?";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, divcode);
			stmt.setString(3, sdcode);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				sdname1 = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getSubDivname1 : "+e.getMessage());
		} finally {
			closeAll();
		}
		return sdname1;
	}

	public String getSubDivname(String dcode, String mcode, String div)	throws Exception {
		String query = null;
		String sdname = "";
		try {
			conn = getConn();
			query = "SELECT SUBDIVISION_OFFICE_NAME,B.SUBDIVISION_OFFICE_CODE FROM RWS_MANDAL_SUBDIVISION_TBL A, RWS_SUBDIVISION_OFFICE_TBL B "
				+ " WHERE DCODE= ? AND MCODE=  ? AND B.DIVISION_OFFICE_CODE= ? AND A.DIVISION_OFFICE_CODE=B.DIVISION_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE AND A.SUBDIVISION_OFFICE_CODE=B.SUBDIVISION_OFFICE_CODE";
			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, mcode);
			stmt.setString(3, div);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				sdname = rs.getString(1) + "@" + rs.getString(2);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getSubDivname = "+e.getMessage());
		} finally {
			closeAll();
		}
		return sdname;
	}

	
	public ArrayList getVillages(String dcode, String mcode, String pcode) throws Exception {
		ArrayList villages = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT VCODE, VNAME FROM RWS_VILLAGE_TBL WHERE DCODE=? AND MCODE=? AND PCODE=? ORDER BY VNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getVillages : "+e.getMessage());
		} finally {
			closeAll();
		}
		return villages;
	}
	
	public ArrayList getUrbanVillages(String dcode, String mcode) throws Exception {
		ArrayList villages = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT VCODE, VNAME FROM URBAN_VILLAGE_TBL WHERE DCODE=? AND MCODE=? ORDER BY VNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getUrbanVillages = "+e.getMessage());
		} finally {
			closeAll();
		}
		return villages;
	}

	public ArrayList getCircles(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? ORDER BY CIRCLE_OFFICE_NAME";
			System.out.println("RwsOffices query :"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);System.out.println("RwsOffices headOfficeCode :"+headOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getCircles = "+e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}
	
	public ArrayList getUrbanCircles(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM UR_CIRCLE_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getUrbanCircles = "+e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}

	public String getHabStatusDate() throws Exception {
		Debug.println("in get hab status date......");
		String hbdt = "";
		try {
			conn = getConn();
			query = "SELECT DISTINCT TO_CHAR(STATUS_DATE,'DD/MM/YYYY') FROM RWS_HABITATION_DIRECTORY_TBL WHERE STATUS_DATE IS NOT NULL";
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			if (rs1.next()) {
				hbdt = rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The exception in RwsOffices getHabStatusDate = "+e.getMessage());
		}
		return hbdt;
	}

	public ArrayList getAllCirclesWithOfficeCode(String headOfficeCode)	throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL "
				+ " WHERE HEAD_OFFICE_CODE = ? ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1) + "000");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + "1" + rset.getString(1) + "000");
				circles.add(labelValueBean);
			}
		}  catch (Exception e) {
			System.out.println("The exception in RwsOffices getAllCirclesWithOfficeCode = "+e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}

	 
	public ArrayList getDivisions(String headOfficeCode, String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		}  catch (Exception e) {
			System.out.println("The Exception is in RwsOffices getDivisions : "+e.getMessage());
		}finally {
			closeAll();
		}
		return divisions;
	}
	
	public ArrayList getUrbanDivisions(String headOfficeCode, String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM UR_DIVISION_OFFICE_TBL "
				+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getCensusVillage(String dcode, String mcode, String pcode,	String vcode) throws Exception {
		ArrayList mandals = null;
		String query = null;
		try {
			conn = getConn();
			query = "SELECT * FROM RWS_HAB_VILL_CENSUS_CODE_TBL WHERE DISTRICT_CODE = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rset = ps.executeQuery();
			String dist = "", mand = "", dist1 = "", mand1 = "", panch1 = "", panch = "", vill = "", vill1 = "", hab = "", hab1 = "", cvcode = "", cvname = "";
			while (rset.next()) {
				dist = rset.getString("DISTRICT_NAME");
				int posdist = dist.indexOf("(");
				dist1 = dist.substring(posdist + 1, posdist + 3);
				mand = rset.getString("BLOCK_NAME");
				int posmand = mand.indexOf("(");
				mand1 = mand.substring(posmand + 1, posmand + 3);
				panch = rset.getString("GRAM_PANCHAYAT_NAME");
				int pospanch = panch.indexOf("(");
				panch1 = panch.substring(pospanch + 1, pospanch + 3);
				vill = rset.getString("VILLAGE_NAME");
				int posvill = vill.indexOf("(");
				vill1 = vill.substring(posvill + 1, posvill + 4);
				if (dist1.equals(dcode) && mand1.equals(mcode) && panch1.equals(pcode) && vill1.equals(vcode)) {
					mandals = new ArrayList();
					cvcode = rset.getString("CENSUS_VILLAGE_CODE");
					cvname = rset.getString("CENSUS_VILLAGE_NAME");
					mandals.add(0, cvcode);
					mandals.add(1, cvname);
					mandals.add(2, rset.getString("MAIN_VILL_OR_NOT"));
				}
			}
		} catch (Exception e) {
			Debug.println("The error in getMandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getCensusSubDistricts(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT DISTINCT CENSUS_SUBDISTRICT_CODE,CENSUS_SUBDISTRICT_NAME FROM RWS_CENSUS2001_VILLAGES_TBL WHERE CENSUS_DISTRICT_CODE= ?";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
			Debug.println("Mandals size:" + mandals.size());
		} catch (Exception e) {
			Debug.println("The error in getMandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getCensusDistricts() throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT DISTINCT CENSUS_DISTRICT_CODE,CENSUS_DISTRICT_NAME FROM RWS_CENSUS2001_VILLAGES_TBL";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("The error in getMandals()=== RwsLocations "+e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getCensusVillages(String dcode, String mcode)
			throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT DISTINCT CENSUS_VILLAGE_CODE,CENSUS_VILLAGE_NAME FROM RWS_CENSUS2001_VILLAGES_TBL "
					+ " WHERE CENSUS_DISTRICT_CODE= ? AND CENSUS_SUBDISTRICT_CODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			ps.setString(2,mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("The error in getMandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getCensusHabData(String dcode, String mcode, String pcode,	String vcode) throws Exception {
		ArrayList habsData = new ArrayList();
		String query = null;
		tenderMemo tenderMemoObj = new tenderMemo();
		ArrayList wqlist = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT D.DCODE,D.DNAME,M.MCODE,M.MNAME,P.PCODE,P.PNAME,V.VCODE,V.VNAME,H.PANCH_CODE,H.PANCH_NAME,NVL(HD.CENSUS_SC_POPU,0),NVL(HD.CENSUS_ST_POPU,0),NVL(HD.CENSUS_PLAIN_POPU,0),NVL(HD.SC_POP_COVERED,0),NVL(HD.ST_POP_COVERED,0),NVL(HD.PLAIN_POPU_COVERED,0),NVL(HQ.INADEQUATE_QTY,'N'),NVL(HQ.ARSENIC,'N'),NVL(HQ.IRON,'N'),NVL(HQ.FLUORIDE,'N'),NVL(HQ.SALINITY,'N'),NVL(HQ.SOURCE_FOR_NC_POP,'0') FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V,RWS_PANCHAYAT_RAJ_TBL H,RWS_HABITATION_DIRECTORY_TBL HD,RWS_HAB_QUAN_QUAL_STAT_TBL HQ WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (H.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(H.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(H.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (H.PANCH_CODE,8,3) = V.VCODE AND H.PANCH_CODE=HD.HAB_CODE AND HD.COVERAGE_STATUS IS NOT NULL AND HD.COVERAGE_STATUS <> 'UI' AND HD.HAB_CODE = HQ.HAB_CODE(+) AND D.DCODE=? AND M.MCODE=? AND P.PCODE=? AND V.VCODE=? ORDER BY D.DCODE,M.MCODE,P.PCODE,V.VCODE,H.PANCH_CODE";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				tenderMemoObj = new tenderMemo();
				tenderMemoObj.setHabCode(rset.getString(9));
				tenderMemoObj.setHabName(rset.getString(10));
				tenderMemoObj.setScPop(rset.getString(11));
				tenderMemoObj.setStPop(rset.getString(12));
				tenderMemoObj.setPlainPop(rset.getString(13));
				tenderMemoObj.setTotalPop("" + (rset.getInt(11) + rset.getInt(12) + rset.getInt(13)));
				tenderMemoObj.setScCov(rset.getString(14));
				tenderMemoObj.setStCov(rset.getString(15));
				tenderMemoObj.setPlainCov(rset.getString(16));
				tenderMemoObj.setTotalCov("" + (rset.getInt(14) + rset.getInt(15) + rset.getInt(16)));
				tenderMemoObj.setChecks(rset.getString(9));
				if (rset.getString(17) == null || (rset.getString(17) != null && rset.getString(17).equals("N"))) {
					tenderMemoObj.setInQua("null");
				} else if (rset.getString(17) != null && rset.getString(17).equals("Y")) {
					tenderMemoObj.setInQua("on");
				}
				if (rset.getString(18) == null || (rset.getString(18) != null && rset.getString(18).equals("N"))) {
					tenderMemoObj.setQp1("null");
				} else if (rset.getString(18) != null && rset.getString(18).equals("Y")) {
					tenderMemoObj.setQp1("on");
				}
				if (rset.getString(19) == null || (rset.getString(19) != null && rset.getString(19).equals("N"))) {
					tenderMemoObj.setQp2("null");
				} else if (rset.getString(19) != null && rset.getString(19).equals("Y")) {
					tenderMemoObj.setQp2("on");
				}
				if (rset.getString(20) == null || (rset.getString(20) != null && rset.getString(20).equals("N"))) {
					tenderMemoObj.setQp3("null");
				} else if (rset.getString(20) != null && rset.getString(20).equals("Y")) {
					tenderMemoObj.setQp3("on");
				}
				if (rset.getString(21) == null || (rset.getString(21) != null && rset.getString(21).equals("N"))) {
					tenderMemoObj.setQp4("null");
				} else if (rset.getString(21) != null && rset.getString(21).equals("Y")) {
					tenderMemoObj.setQp4("on");
				}
				tenderMemoObj.setSfncpop(rset.getString(22));
				habsData.add(tenderMemoObj);
			}
		} catch (Exception e) {
			System.out.println("The error in getCensusHabData():" + e.getMessage());
		} finally {
			closeAll();
		}
		return habsData;
	}

	public ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode) throws Exception {
		ArrayList habs = new ArrayList();
		String query = "";
		try {
			conn = getConn();
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)= ? AND SUBSTR(RAJ.HAB_CODE,6,2)= ? AND "
					+ "SUBSTR(RAJ.HAB_CODE,13,2)= ? AND SUBSTR(RAJ.HAB_CODE,8,3)= ? AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return habs;
	}
	
	public ArrayList getLocalities(String dcode, String mcode,String vcode) throws Exception {
		ArrayList habs = new ArrayList();
		String query = "";
		try {
			conn = getConn();
			query = "SELECT HAB_CODE,LOCALITY FROM URBAN_LOCALITY  WHERE"
				+ " SUBSTR(HAB_CODE,1,2)= ? AND SUBSTR(RAJ.HAB_CODE,3,2)= ? AND SUBSTR(RAJ.HAB_CODE,5,3) = ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("The error in rwsMasterData getPRHabitations="+e);
		} finally {
			closeAll();
		}
		return habs;
	}

	public String getCensusVillageDisableStatus(String dcode, String mcode,
			String pcode, String vcode) throws Exception {
		String disableStatus = "";
		try {
			conn = getConn();
			query = "SELECT * FROM RWS_HAB_VILL_CENSUS_CODE_TBL WHERE DISTRICT_CODE = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			String dist = "", mand = "", dist1 = "", mand1 = "", panch1 = "", panch = "", vill = "", vill1 = "", hab = "", hab1 = "", cvcode = "", cvname = "";
			while (rset.next()) {
				dist = rset.getString("DISTRICT_NAME");
				int posdist = dist.indexOf("(");
				dist1 = dist.substring(posdist + 1, posdist + 3);
				mand = rset.getString("BLOCK_NAME");
				int posmand = mand.indexOf("(");
				mand1 = mand.substring(posmand + 1, posmand + 3);
				panch = rset.getString("GRAM_PANCHAYAT_NAME");
				int pospanch = panch.indexOf("(");
				panch1 = panch.substring(pospanch + 1, pospanch + 3);
				vill = rset.getString("VILLAGE_NAME");
				int posvill = vill.indexOf("(");
				vill1 = vill.substring(posvill + 1, posvill + 4);
				if (dist1.equals(dcode) && mand1.equals(mcode) && panch1.equals(pcode)) {
					String countQuery = "SELECT * FROM RWS_HAB_VILL_CENSUS_CODE_TBL WHERE DISTRICT_CODE = ? AND BLOCK_CODE = ? AND GRAM_PANCHAYAT_CODE = ?";
					stat = conn.prepareStatement(countQuery);
					stat.setString(1, rset.getString(4));
					stat.setString(2, rset.getString(7));
					stat.setString(3, rset.getString(10));
					ResultSet rs = stat.executeQuery();
					int villageCount = 0;
					boolean alreadyMain = false, actVillage = false;
					while (rs.next()) {
						villageCount++;
						if (rs.getString("MAIN_VILL_OR_NOT") != null && rs.getString("MAIN_VILL_OR_NOT").equals("Y")) {
							alreadyMain = true;
							String vill2 = rs.getString("VILLAGE_NAME");
							int posvill2 = vill2.indexOf("(");
							vill2 = vill2.substring(posvill2 + 1, posvill2 + 4);
							if (vill2.equals(vcode)) {
								actVillage = true;
							}
						}
					}
					if (villageCount > 1 && alreadyMain && !actVillage) {
						disableStatus = "true";
					} else
						disableStatus = "false";
					continue;
				}
			}
		} catch (Exception e) {
			Debug.println("The error in rwsMasterData get census status=" + e.getMessage());
		} finally {
			closeAll();
		}
		return disableStatus;
	}

	public ArrayList getAllDivisionsWithOfficeCode() throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1)	+ rset.getString(2) + "00");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + "1" + rset.getString(1) + rset.getString(2) + "00");
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;
	}

	 
	public ArrayList getSubdivisions(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT SUBDIVISION_OFFICE_CODE, SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ORDER BY SUBDIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		}catch (Exception e) {
        	System.out.println("The Exception is in RwsOffices getSubdivisions : "+e.getMessage());
        } finally {
			closeAll();
		}
		return subdivisions;
	}
	
	// added for data check
	public  String getDataCheck(String path, String userId) {
    String resp="false"; 		
    PreparedStatement statement=null; 
    try {
			conn = getConn();
			String dataqry = "select count(*) from RWSS_ROLE_ACCESS_TBL where path=? and ACCESS_ROLE=?";
			/*ps = conn.prepareStatement(dataqry);
			ps.setString(1, path);
			ps.setString(2,userId);*/
			System.out.println("dataqry==== "+path+"-----"+userId);
			String s="UPDATE RWSS_ROLE_ACCESS_TBL set path=? where Access_role=?";
			ps=conn.prepareStatement(s);
			ps.setString(1, "dff");
			ps.setString(2, "vqc");
			int count = ps.executeUpdate();
			System.out.println("count.. "+count);
			//System.out.println("count value in java??? "+rset);
			/*if(count>0) {
				resp="true";
				return resp;	
			}
			System.out.println("count value in ajax  "+count);*/
		} catch (Exception e) {
			System.out.println("exception in getCircleOfficeName() in rwsoffices" + e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("Exception in closing connections in getDistrictName in rwsoffices" + e);
			}
		}
		return resp;
	
}//end method
	
	public ArrayList getUrbanSubdivisions(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT SUBDIVISION_OFFICE_CODE, SUBDIVISION_OFFICE_NAME FROM UR_SUBDIVISION_OFFICE_TBL "
				+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ORDER BY SUBDIVISION_OFFICE_NAME ";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}

		return subdivisions;
	}

	public static String getLowerOfficeCode(String officeCode) {
		String lowerOfficeCode = "";
		if (officeCode != null && officeCode.length() == 6) {
			String headOfficeCode = officeCode.substring(0, 1);
			String circleOfficeCode = officeCode.substring(1, 3);
			String divisionOfficeCode = officeCode.substring(3, 4);
			String subdivisionOfficeCode = officeCode.substring(4, 6);
			if (!subdivisionOfficeCode.equals("00")) 
				lowerOfficeCode = headOfficeCode + circleOfficeCode	+ divisionOfficeCode + "00";
			else if (!divisionOfficeCode.equals("0"))
				lowerOfficeCode = headOfficeCode + circleOfficeCode + "000";
			else if (!circleOfficeCode.equals("00"))
				lowerOfficeCode = headOfficeCode + "00000";
		}
		return lowerOfficeCode;
	}

	public static String getHigherOfficeCode(String officeCode) {
		String higherOfficeCode = "";
		if (officeCode != null && officeCode.length() == 6) {
			String headOfficeCode = officeCode.substring(0, 1);
			String circleOfficeCode = officeCode.substring(1, 3);
			String divisionOfficeCode = officeCode.substring(3, 4);
			String subdivisionOfficeCode = officeCode.substring(4, 6);
			if (!subdivisionOfficeCode.equals("00"))
				higherOfficeCode = headOfficeCode + circleOfficeCode + divisionOfficeCode + "00";
			else if (!divisionOfficeCode.equals("0"))
				higherOfficeCode = headOfficeCode + circleOfficeCode + "000";
			else if (!circleOfficeCode.equals("00"))
				higherOfficeCode = headOfficeCode + "00000";
			else
				higherOfficeCode = "000000";
		}
		return higherOfficeCode;
	}

	public String getOfficeName(String officeCode, boolean showOfficeType) throws Exception {
		if (officeCode.equals("000000"))
			return "";
		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);
		String query = null;
		String officeName = null;
		String officeType = null;
		Connection conn = null;
		ResultSet rset = null;

		if (!subdivisionOfficeCode.equals("00")) {
			query = " SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL "
				+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
			officeType = "Sub Division";
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ";
			officeType = "Division";
		} else if (!circleOfficeCode.equals("00")) {
			query = "SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ";
			officeType = "Circle";
		} else if (!headOfficeCode.equals("0")) {
			query = "SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL HERE HEAD_OFFICE_CODE = ? ";
			officeType = "";
		}

		try {
			conn = getConn();
			stat = conn.prepareStatement(query);
			if (!subdivisionOfficeCode.equals("00")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);
				stat.setString(3, divisionOfficeCode);
				stat.setString(4, subdivisionOfficeCode);
			} else if (!divisionOfficeCode.equals("0")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);
				stat.setString(3, divisionOfficeCode);				
			} else if (!circleOfficeCode.equals("00")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);				
			} else if (!headOfficeCode.equals("0")) {
				stat.setString(1, headOfficeCode);
			}
			rset = stat.executeQuery();
			while (rset.next()) {
				officeName = rset.getString(1);
			}
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
			  }
			}
			if (stat != null) {
				try {
					stat.close();
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

		if (showOfficeType)
			return officeName + " " + officeType;
		else
			return officeName;
	}

	public String getOfficeName(String officeCode, boolean showOfficeType, Connection conn) throws Exception {
		if (officeCode.equals("000000"))
			return "";
		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);
		String query = null;
		String officeName = null;
		String officeType = null;
		ResultSet rset = null;
		if (!subdivisionOfficeCode.equals("00")) {
			query = " SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL "
				+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? AND SUBDIVISION_OFFICE_CODE = ? ";
			officeType = "Sub Division";
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ";
			officeType = "Division";
		} else if (!circleOfficeCode.equals("00")) {
			query = " SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ";
			officeType = "Circle";
		} else if (!headOfficeCode.equals("0")) {
			query = "SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? ";
			officeType = "";
		}
		try {
			stat = conn.prepareStatement(query);
			if (!subdivisionOfficeCode.equals("00")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);
				stat.setString(3, divisionOfficeCode);
				stat.setString(4, subdivisionOfficeCode);
			} else if (!divisionOfficeCode.equals("0")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);
				stat.setString(3, divisionOfficeCode);
			} else if (!circleOfficeCode.equals("00")) {
				stat.setString(1, headOfficeCode);
				stat.setString(2, circleOfficeCode);
			} else if (!headOfficeCode.equals("0")) {
				stat.setString(1, headOfficeCode);
			}
			rset = stat.executeQuery();
			while (rset.next()) {
				officeName = rset.getString(1);
			}
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (SQLException sqle) {
			  }
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (SQLException sqle) {
			  }
		   }
		}
		if (showOfficeType)
			return officeName + " " + officeType;
		else
			return officeName;
	}

	public ArrayList getLowerOffices(String officeCode) throws Exception {
		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);
		if (!subdivisionOfficeCode.equals("00")) {
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT (HEAD_OFFICE_CODE|| CIRCLE_OFFICE_CODE || DIVISION_OFFICE_CODE || SUBDIVISION_OFFICE_CODE) AS OFFICE_CODE, SUBDIVISION_OFFICE_NAME "
				+ " FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ORDER BY SUBDIVISION_OFFICE_NAME ";
		} else if (!circleOfficeCode.equals("00")) {
			query = " SELECT (HEAD_OFFICE_CODE || CIRCLE_OFFICE_CODE || DIVISION_OFFICE_CODE || '00') AS OFFICE_CODE, DIVISION_OFFICE_NAME "
					+ " FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME ";
		} else if (!headOfficeCode.equals("0")) {
			query = "SELECT (HEAD_OFFICE_CODE || CIRCLE_OFFICE_CODE || '000') AS OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? ORDER BY CIRCLE_OFFICE_NAME ";
		}
		conn = getConn();
		stat = conn.prepareStatement(query);
		if (!subdivisionOfficeCode.equals("00")) {
		} else if (!divisionOfficeCode.equals("0")) {
			stat.setString(1, headOfficeCode);
			stat.setString(1, circleOfficeCode);
			stat.setString(1, divisionOfficeCode);
		} else if (!circleOfficeCode.equals("00")) {
			stat.setString(1, headOfficeCode);
			stat.setString(1, circleOfficeCode);
		} else if (!headOfficeCode.equals("0")) {
			stat.setString(1, headOfficeCode);
		}
		rset = stat.executeQuery();
		ArrayList forwardOffices = new ArrayList();
		LabelValueBean labelValueBean = null;
		while (rset.next()) {
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue(rset.getString(1));
			labelValueBean.setLabel(rset.getString(2));
			forwardOffices.add(labelValueBean);
		}
		return forwardOffices;
	}

	public String getCircleOfficeName(DataSource dataSource, String headOfficeCode, String circleOfficeCode) {
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ?";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			rset = stat.executeQuery();
			while (rset.next())
				return rset.getString("circle_office_name");
		} catch (Exception e) {
			System.out.println("exception in getCircleOfficeName() in rwsoffices" + e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("Exception in closing connections in getDistrictName in rwsoffices" + e);
			}
		}
		return "";
	}

	

	public String getDivisionOfficeName(DataSource dataSource, String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode) {
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ? AND DIVISION_OFFICE_CODE= ?";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			stat.setString(3, divisionOfficeCode);
			rset = stat.executeQuery();
			while (rset.next())
				return rset.getString("division_office_name");
		} catch (Exception e) {
			System.out.println("exception in getDivisionOfficeName() rwsoffices--" + e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("Exception in closing connections in getDistrictName in rwsoffices --" + e);
			}
		}
		return "";
	}

	
	
	public String getSubDivisionOfficeName(DataSource dataSource, String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode, String subDivisionOfficeCode) {
		try {

			conn = getConn();

			query = " SELECT SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ? AND DIVISION_OFFICE_CODE= ? AND SUBDIVISION_OFFICE_CODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			stat.setString(3, divisionOfficeCode);
			stat.setString(4, subDivisionOfficeCode);
			rset = stat.executeQuery();
			while (rset.next())
				return rset.getString("subdivision_office_name");
		} catch (Exception e) {
			 System.out.println("exception in getSubdivisionOfficeName() of rwsoffices-- "+e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				 System.out.println("Exception in closing connections in getDistrictName of rwsoffices -- "+e);
			}
		}
		return "";
	}

	public String getDivisionOfficeCode(DataSource dataSource, String headOfficeCode, String circleOfficeCode) {
		String divisionOfficeCode = "";
		try {
			conn = getConn();
			query = " SELECT DIVISION_OFFICE_CODE FROM RWS_DIVISION_OFFICE_TBL "
					+ " WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			rset = stat.executeQuery();
			while (rset.next())
				divisionOfficeCode = rset.getString("division_office_code");
		} catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeCode()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDistrictName");}
			}
		}
		return divisionOfficeCode;
	}

	public String getSubDivisionOfficeCode(DataSource dataSource, String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) {
		String subDivisionOfficeCode = "";
		try {
			conn = getConn();
			query = " SELECT SUBDIVISION_OFFICE_CODE FROM RWS_SUBDIVISION_OFFICE_TBL "
					+" WHERE HEAD_OFFICE_CODE= ? AND CIRCLE_OFFICE_CODE= ? AND DIVISION_OFFICE_CODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			stat.setString(3, divisionOfficeCode);
			rset = stat.executeQuery();
			while (rset.next())
				subDivisionOfficeCode = rset.getString("subdivision_office_code");
		} catch (Exception e) {
			// System.out.println("exception in getSubDivisionOfficeCode()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDistrictName");}
			}
		}
		return subDivisionOfficeCode;
	}

	public String getSubDivisionOfficeCodeFromMandal(DataSource dataSource,	String dcode, String mcode) {
		String subDivisionOfficeCode = "";
		try {
			conn = getConn();
			query = "SELECT SUBDIVISION_OFFICE_CODE  FROM RWS_MANDAL_SUBDIVISION_TBL WHERE DCODE= ? AND MCODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, dcode);
			stat.setString(2, mcode);
			rset = stat.executeQuery();
			while (rset.next())
				subDivisionOfficeCode = rset.getString("subdivision_office_code");
		} catch (Exception e) {
			// System.out.println("exception in getSubDivisionOfficeCodeFromMandal()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getSubDivisionOfficeCodeFromMandal");}
			}
		}
		return subDivisionOfficeCode;
	}

	public String getDivisionOfficeCodeFromMandal(DataSource dataSource, String dcode, String mcode) {
		String divisionOfficeCode = "";
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_CODE  FROM RWS_MANDAL_SUBDIVISION_TBL WHERE DCODE= ? AND MCODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, dcode);
			stat.setString(2, mcode);
			rset = stat.executeQuery();
			while (rset.next())
				divisionOfficeCode = rset.getString("division_office_code");
		} catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeCodeFromMandal()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDivisionOfficeCodeFromMandal");}
			}
		}
		return divisionOfficeCode;
	}

	public String getPanchayatName(DataSource dataSource, String dcode,	String mcode, String pcode) {
		String pname = "";
		try {
			conn = getConn();
			query ="SELECT PNAME  FROM RWS_PANCHAYAT_TBL WHERE DCODE= ? AND MCODE= ? AND PCODE = ?";
			stat = conn.prepareStatement(query);
			stat.setString(1, dcode);
			stat.setString(2, mcode);
			stat.setString(3, pcode);
			rset = stat.executeQuery();
			while (rset.next())
				pname = rset.getString("pname");
		} catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeCodeFromMandal()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDivisionOfficeCodeFromMandal");}
			}
		}
		return pname;
	}

	
	public String getDistrictName(String dcode) throws Exception {
		String districtName = "";
		try {
			conn = getConn();
			query = "SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				districtName = rset.getString("dname");
			}
		} catch (Exception e) {
			System.out.println("The Exceptiion is in RwsOffices getDistrictName : "+e.getMessage());
		} finally {
			closeAll();
		}
		return districtName;
	}

	public String getDivisionName(String divcode) throws Exception {
		String divisionName = "";
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE DIVISION_OFFICE_CODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, divcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				divisionName = rset.getString("division_office_name");
			}
		} catch (Exception e) {
			// System.out.println("Exception in getDistrictName is "+e);}
		} finally {
			closeAll();
		}
		return divisionName;
	}

	
	public String getMandalName(String dcode, String mcode) throws Exception {
		String mandalName = "";
		try {
			conn = getConn();
			query = "SELECT MNAME FROM RWS_MANDAL_TBL WHERE DCODE=? AND MCODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				mandalName = rset.getString("mname");
			}
		} catch (Exception e) {
			System.out.println("The Exceptiion is in RwsOffices getMandalName : "+e.getMessage());
		} finally {
			closeAll();
		}
		return mandalName;
	}

	public String getPanchayatName(String dcode, String mcode, String pcode) throws Exception {
		String panchayatName = "";
		try {
			conn = getConn();
			query = " SELECT PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE=? AND MCODE=? AND PCODE=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				panchayatName = rset.getString("pname");
			}
		} catch (Exception e) {
			// System.out.println("Exception in getPanchayatName is "+e);}
		} finally {
			closeAll();
		}
		return panchayatName;
	}

	public String getVillageName(DataSource dataSource, String dcode, String mcode, String pcode, String vcode) {
		String vname = "";
		try {
			conn = getConn();
			query = "SELECT VNAME FROM RWS_VILLAGE_TBL WHERE DCODE = ? AND MCODE = ? AND PCODE = ? AND VCODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, dcode);
			stat.setString(2, mcode);
			stat.setString(3, pcode);
			stat.setString(4, vcode);
			rset = stat.executeQuery();
			while (rset.next())
				vname = rset.getString("vname");
		} catch (Exception e) {
			// System.out.println("exception in getVillageName()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getVillageName");}
			}
		}
		return vname;
	}

	
	public String getHabitationName(DataSource dataSource, String habCode) {
		String habName = "";
		try {
			conn = getConn();
			query = "SELECT PANCH_NAME  FROM RWS_PANCHAYAT_RAJ_TBL WHERE PANCH_CODE= ? ";
			stat = conn.prepareStatement(query);	
			stat.setString(1, habCode);
			rset = stat.executeQuery();
			while (rset.next())
				habName = rset.getString("panch_name");
		} catch (Exception e) {
				System.out.println("The Exception is in RwsLocations getHabitationName : "+e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsLocations getHabitationName Finally : "+e.getMessage());
			}
		}
		return habName;
	}

	public ArrayList getPRCircles() throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_PR_CIRCLE_OFFICE_TBL ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getPRCircles is "+e);}
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getQCCircles() throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_QC_CIRCLE_OFFICE_TBL ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getQCCircles is "+e);}
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getPRDivisions(String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_PR_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;

	}

	public ArrayList getQCDivisions(String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_QC_DIVISION_OFFICE_TBL "
				+ " WHERE CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME ";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;

	}

	public ArrayList getProgrammes(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode, String subdiv) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT WD.PROGRAMME_CODE,P.PROGRAMME_NAME FROM RWS_WORK_ADMN_TBL WD, RWS_PROGRAMME_TBL P "
				+ "WHERE P.PROGRAMME_CODE=WD.PROGRAMME_CODE AND SUBSTR(WD.OFFICE_CODE,1,1)= ? AND SUBSTR(WD.OFFICE_CODE,2,2)= ?";
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals("")) && !(divisionOfficeCode.equals("0")))
				query += " AND SUBSTR(WD.OFFICE_CODE,4,1) = ? ";
			if (subdiv != null && !(subdiv.equals("")))
				query += " AND SUBSTR(WD.OFFICE_CODE,5,2) = ? ";
			query += "ORDER BY WD.PROGRAMME_CODE";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals("")) && !(divisionOfficeCode.equals("0"))){
				ps.setString(3, divisionOfficeCode);}
			if (subdiv != null && !(subdiv.equals(""))){
				ps.setString(4, subdiv);}
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				programmes.add(labelValueBean);
			}			
		} catch (Exception e) {
			// System.out.println("Exceptiong in Getting Programmes"+e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Get Programmes Exception in Closing ");}
			}
		}
		return programmes;
	}

	public ArrayList getSubProgrammes(String circleOfficeCode, String divisionOfficeCode, String subdiv, String program) {
		ArrayList subprogrammes = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SP.SUBPROGRAMME_CODE,SP.SUBPROGRAMME_NAME FROM RWS_SUBPROGRAMME_TBL SP,RWS_WORK_ADMN_TBL W "
				+" WHERE SP.PROGRAMME_CODE=W.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE=W.SUBPROGRAMME_CODE AND SP.PROGRAMME_CODE= ? AND SUBSTR(W.OFFICE_CODE,2,2)= ? ";
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals("")) && !divisionOfficeCode.equals("0"))
				query += " AND SUBSTR(W.OFFICE_CODE,4,1) = ? ";
			if (subdiv != null && !(subdiv.equals("")))
				query += " AND SUBSTR(W.OFFICE_CODE,5,2) = ? ";
			query += "ORDER BY SP.SUBPROGRAMME_CODE";
			Debug.println("query in SUBprogrammes:" + query);
			ps = conn.prepareStatement(query);
			ps.setString(1, program);
			ps.setString(2, circleOfficeCode);
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals("")) && !divisionOfficeCode.equals("0")){
				ps.setString(3, divisionOfficeCode);  }
			if (subdiv != null && !(subdiv.equals(""))){
				ps.setString(4, subdiv);
			}			
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subprogrammes.add(labelValueBean);
			}
			Debug.println("NO.OF SUB-PROGRAMS RETURNED = "
					+ subprogrammes.size());
		} catch (Exception e) {
			// System.out.println("Exceptiong in Getting Programmes"+e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Get Programmes Exception in Closing ");}
			}
		}
		return subprogrammes;
	}

	public ArrayList CircleCombo(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SUBSTR(NE.OFFICE_CODE,2,2) AS CIRCLEOFFCODE,CIRCLE_OFFICE_NAME  FROM RWS_WORK_ADMN_TBL NE, RWS_CIRCLE_OFFICE_TBL CO WHERE SUBSTR(NE.OFFICE_CODE,2,2)=CO.CIRCLE_OFFICE_CODE AND SUBSTR(NE.OFFICE_CODE,1,1)=? ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices CircleCombo is :- " + e.getMessage());
		} finally {
				closeAll();
		}
		return circles;
	}
	
	//02-12-2021 START
	
	public ArrayList getCircleCombo(String headOfficeCode, String circleCode) throws Exception {
		ArrayList qccircles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SUBSTR(NE.OFFICE_CODE,2,2) AS CIRCLEOFFCODE,CIRCLE_OFFICE_NAME FROM RWS_WORK_ADMN_TBL NE, RWS_CIRCLE_OFFICE_TBL CO WHERE SUBSTR(NE.OFFICE_CODE,2,2)=CO.CIRCLE_OFFICE_CODE AND SUBSTR(NE.OFFICE_CODE,1,1)=? AND CO.CIRCLE_OFFICE_CODE=? ORDER BY CIRCLE_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);System.out.println("headOfficeCode :"+headOfficeCode);
			ps.setString(2, circleCode);System.out.println("circleCode :"+circleCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));System.out.println("rset.getString(1) :"+rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));System.out.println("rset.getString(2) :"+rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				qccircles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices CircleCombo is :- " + e.getMessage());
		} finally {
				closeAll();
		}
		return qccircles;
	}
	
	//02-12-2021 END
	
	public ArrayList DivisionCombo(String headOfficeCode, String circlecode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SUBSTR(PP.OFFICE_CODE,4,1) AS DIVISIONOFFCODE,DIVISION_OFFICE_NAME FROM RWS_WORK_ADMN_TBL PP ,RWS_DIVISION_OFFICE_TBL CO WHERE "
				+ " SUBSTR(PP.OFFICE_CODE,2,2)=CO.CIRCLE_OFFICE_CODE AND SUBSTR(PP.OFFICE_CODE,4,1)=CO.DIVISION_OFFICE_CODE AND SUBSTR(PP.OFFICE_CODE,1,1) = ? AND SUBSTR(PP.OFFICE_CODE,2,2) = ? ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circlecode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices DivisionCombo is :- " + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices DivisionCombo is :- " + e.getMessage());
			}
		}
		return divisions;

	}

	public ArrayList SubDivisionCombo(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SUBSTR(PP.OFFICE_CODE,5,2) AS SUBDIVISIONOFFCODE,SUBDIVISION_OFFICE_NAME  FROM RWS_WORK_ADMN_TBL PP,RWS_SUBDIVISION_OFFICE_TBL CO WHERE SUBSTR(PP.OFFICE_CODE,2,2)=CO.CIRCLE_OFFICE_CODE  AND SUBSTR(PP.OFFICE_CODE,4,1)=CO.DIVISION_OFFICE_CODE  AND SUBSTR(PP.OFFICE_CODE,5,2)=CO.SUBDIVISION_OFFICE_CODE AND SUBSTR(PP.OFFICE_CODE,1,1) = ? AND SUBSTR(PP.OFFICE_CODE,2,2) = ? AND SUBSTR(PP.OFFICE_CODE,4,1) = ? ORDER BY SUBDIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "	+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices SubDivisionCombo is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return subdivisions;
	}

	public ArrayList getProgrammes1(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode, String subdiv) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals("")) && !(divisionOfficeCode.equals("0")) && subdiv.equals("")) {
				query = "SELECT DISTINCT WD.PROGRAMME_CODE,P.PROGRAMME_NAME FROM RWS_WORK_ADMN_TBL WD, RWS_PROGRAMME_TBL P "
					+ "WHERE P.PROGRAMME_CODE=WD.PROGRAMME_CODE AND SUBSTR(WD.OFFICE_CODE,1,1)= ? AND SUBSTR(WD.OFFICE_CODE,2,2)= ? AND SUBSTR(WD.OFFICE_CODE,4,1)= ? ORDER BY WD.PROGRAMME_CODE";
				ps = conn.prepareStatement(query);
				ps.setString(1, headOfficeCode);
				ps.setString(2, circleOfficeCode);
				ps.setString(3, divisionOfficeCode);
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
					programmes.add(labelValueBean);
				}				
			}
			else if (divisionOfficeCode != null	&& !(divisionOfficeCode.equals(""))	&& !(divisionOfficeCode.equals("0")) && subdiv != null && !(subdiv.equals(""))) {
				query = "SELECT DISTINCT WD.PROGRAMME_CODE,P.PROGRAMME_NAME FROM RWS_WORK_ADMN_TBL WD, RWS_PROGRAMME_TBL P "
					+ "WHERE P.PROGRAMME_CODE=WD.PROGRAMME_CODE AND SUBSTR(WD.OFFICE_CODE,1,1)= ? AND SUBSTR(WD.OFFICE_CODE,2,2)= ? AND SUBSTR(WD.OFFICE_CODE,4,1)= ? AND SUBSTR(WD.OFFICE_CODE,5,2)= ? ORDER BY WD.PROGRAMME_CODE";
				ps = conn.prepareStatement(query);
				ps.setString(1, headOfficeCode);
				ps.setString(2, circleOfficeCode);
				ps.setString(3, divisionOfficeCode);
				ps.setString(4, subdiv);
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
					programmes.add(labelValueBean);
				}				
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getProgrammes1 is :- " + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getProgrammes1 is :- " + e.getMessage());
			}
		}
		return programmes;
	}

	public ArrayList getProgrammes1(String planCode, String wrkType, String workCat) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT DISTINCT W.PROGRAMME_CODE,P.PROGRAMME_NAME FROM RWS_PROGRAMME_TBL P,RWS_WORK_PROG_LNK_TBL W,RWS_WORK_ADMN_TBL AD  "
					+ " WHERE W.PROGRAMME_CODE=P.PROGRAMME_CODE AND W.PLAN_CODE= ? AND W.AUG_NEW_CODE= ? AND W.CATEGORY_CODE = ? " 
					+ " AND W.PROGRAMME_CODE=AD.PROGRAMME_CODE AND P.PROGRAMME_CODE=AD.PROGRAMME_CODE ORDER BY P.PROGRAMME_NAME";
			ps = conn.prepareStatement(query);System.out.println("query :"+query);
			ps.setString(1, planCode);
			ps.setString(2, wrkType);
			ps.setString(3, workCat);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				programmes.add(labelValueBean);
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getProgrammes1 is :- " + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getProgrammes1 is :- " + e.getMessage());
			}
		}
		return programmes;
	}

	public ArrayList getSubProgrammes(String program) {
		ArrayList subprogrammes = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SP.SUBPROGRAMME_CODE,SP.SUBPROGRAMME_NAME  FROM RWS_SUBPROGRAMME_TBL SP,RWS_WORK_ADMN_TBL W "
					+ " WHERE SP.PROGRAMME_CODE=W.PROGRAMME_CODE AND SP.PROGRAMME_CODE= ? ORDER BY SP.SUBPROGRAMME_CODE";
			ps = conn.prepareStatement(query);
			ps.setString(1, program);System.out.println("program : " +program);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subprogrammes.add(labelValueBean);
			}
		   } catch (Exception e) {
			   System.out.println("The Exception is in  RwsOffices getSubProgrammes is :- " + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getSubProgrammes is :- " + e.getMessage());
			}
		}
		return subprogrammes;
	}

	public ArrayList getSlippageReasons() {
		ArrayList slipReasons = new ArrayList();
		try {
			conn = getConn();
			String qry = "SELECT * FROM  RWS_SLIPPAGE_REASON_TBL";
			stat = conn.prepareStatement(qry);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				slipReasons.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getSlippageReasons is :- " + e.getMessage());
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (Exception e) {
					System.out.println("The Exception is in  RwsOffices getSlippageReasons is :- " + e.getMessage());
				}
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (Exception e) {
					System.out.println("The Exception is in  RwsOffices getSlippageReasons is :- " + e.getMessage());
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					System.out.println("The Exception is in  RwsOffices getSlippageReasons is :- " + e.getMessage());
				}
			}
		}
		return slipReasons;
	}

	public String getCircleName(String dcode) throws Exception {
		String circleName = "";
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE= ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				circleName = rset.getString("circle_office_name");
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getCircleName is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return circleName;
	}

	public ArrayList getAssetTypes(String workcat, String plancode)	throws Exception {
		ArrayList assetTypes = new ArrayList();
		try {
			query = "SELECT TYPE_OF_ASSET_CODE , UPPER(TYPE_OF_ASSET_NAME) FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_NAME IN ";
			if (workcat.equals("1") && plancode.equals("1")) {
				query += "('CPWS') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("1") && plancode.equals("2")) {
				query += "('CPWS') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("2") && plancode.equals("1")) {
				query += "('PWS','SUSTAINABILITY','SCHOOLS') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("2") && plancode.equals("2")) {
				query += "('PWS','SUSTAINABILITY','LAB') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("3") && plancode.equals("1")) {
				query += "('PWS','HANDPUMPS','SCHOOLS','OPEN WELLS') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("3") && plancode.equals("2")) {
				query += "('PWS','HANDPUMPS') ORDER BY TYPE_OF_ASSET_CODE";
			} else if (workcat.equals("")) {
				query += "('') ORDER BY TYPE_OF_ASSET_CODE";
			}
			conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getAssetTypes is :- " + e.getMessage());
		}finally {
			closeAll();
		}
		return assetTypes;
	}

	public ArrayList getAssetTypes(String workcat) throws Exception {
		ArrayList assetTypes = new ArrayList();
		try {
			query = "SELECT TYPE_OF_ASSET_CODE , UPPER(TYPE_OF_ASSET_NAME)  FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_NAME IN ";
			if (workcat.equals("1")) {
				query += "('CPWS') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("2")) {
				query += "('PWS','SUSTAINABILITY','SCHOOLS','LAB') ORDER BY TYPE_OF_ASSET_CODE";
			}
			if (workcat.equals("3")) {
				query += "('PWS','HANDPUMPS','SCHOOLS','OPEN WELLS') ORDER BY TYPE_OF_ASSET_CODE";
			} else if (workcat.equals("")) {
				query += "('') ORDER BY TYPE_OF_ASSET_CODE";
			}
			conn = getConn();
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getAssetTypes is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return assetTypes;
	}

	public ArrayList getDivisions1(String ccode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE= ? ORDER BY DIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode); System.out.println("division dao query :"+query);System.out.println(" dao ccode :"+ccode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getDivisions1 is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getSubDivisions1(String ccode, String divcode)	throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE= ? AND DIVISION_OFFICE_CODE= ? ORDER BY SUBDIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			ps.setString(2, divcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in getCircles is "+ e);
		} finally {
			closeAll();
		}
		return subdivisions;
	}

	public ArrayList getPrograms(String workcategory, String plan, String augnew) throws Exception {
		ArrayList programs = new ArrayList();
		try {
			conn = getConn();
			String qq = "SELECT W.PROGRAMME_CODE,P.PROGRAMME_NAME FROM RWS_PROGRAMME_TBL P,RWS_WORK_PROG_LNK_TBL W "
					+ " WHERE W.PROGRAMME_CODE=P.PROGRAMME_CODE AND CATEGORY_CODE = ? AND PLAN_CODE = ? AND AUG_NEW_CODE= ? ORDER BY P.PROGRAMME_CODE,P.PROGRAMME_NAME";
			PreparedStatement sts = conn.prepareStatement(qq);
			sts.setString(1, workcategory);
			sts.setString(2, plan);
			sts.setString(3, augnew);
			ResultSet rs = sts.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				programs.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in getPrograms is "+ e);
		} finally {
			closeAll();
		}
		return programs;
	}

	public ArrayList getSubprograms(String program) throws Exception {
		ArrayList subprograms = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT SUBPROGRAMME_CODE,SUBPROGRAMME_NAME FROM RWS_SUBPROGRAMME_TBL WHERE PROGRAMME_CODE= ? ORDER BY SUBPROGRAMME_NAME";
			PreparedStatement st = conn.prepareStatement(query);
			st.setString(1, program);
			rset = st.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subprograms.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in get sub Programs is " + e);
		} finally {
			closeAll();
		}
		return subprograms;
	}

	public ArrayList getWorkCategory() throws Exception {
		ArrayList subprograms = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CATEGORY_CODE,CATEGORY_NAME FROM RWS_WORK_CATEGORY_TBL";
			PreparedStatement st = conn.prepareStatement(query);
			rset = st.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				subprograms.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getWorkCategory is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return subprograms;
	}

	public ArrayList getExpYears() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentYear = dateFormat.format(currentDate).substring(0, 4);
		int currentYears = Integer.parseInt(currentYear);
		try {
			for (int i = currentYears; i >= 2000; i--) {
				int j = i;
				j++;
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("" + i);
				labelValueBean.setLabel(i + " - " + j);
				labelValueBean.setLabelValue(i + " - " + j + " - " + i);
				years.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in exp years is "
					+ e);
		} finally {
			closeAll();
		}

		return years;
	}

	public ArrayList getExpYears1() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentYear = dateFormat.format(currentDate).substring(0, 4);
		int currentYears = Integer.parseInt(currentYear);
		try {
			for (int i = currentYears; i >= 1970; i--) {
				int j = i;
				j++;
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("" + i);
				labelValueBean.setLabel(i + " - " + j);
				labelValueBean.setLabelValue(i + " - " + j + " - " + i);
				years.add(labelValueBean);
			}
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue("<1970");
			labelValueBean.setLabel("<1970");
			labelValueBean.setLabelValue("<1970 - <1970  - <1970");
			years.add(labelValueBean);
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in exp years is "
					+ e);
		} finally {
			closeAll();
		}
		return years;
	}

	public ArrayList getAllAssetTypes() throws Exception {
		ArrayList assets = new ArrayList();
		try {
			conn = getConn();
			stat = conn.prepareStatement("SELECT * FROM RWS_ASSET_TYPE_TBL ORDER BY TYPE_OF_ASSET_CODE");
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assets.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in get all assets is " + e);
		} finally {
			closeAll();
		}
		return assets;
	}

	public ArrayList getWorksList(String dcode, String expyear, String scheme, RepresentativeProposalForm myForm, String divCode, String subDivCode) throws Exception {
		ArrayList works = new ArrayList();
		try {
			conn = getConn();
			int ey = 0;
			String qry = "";
			if (!expyear.equals("<1970") && !expyear.equals("ALL")) {
				qry = "SELECT WORK_ID,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,WORK_NAME,ADMIN_NO,SANCTION_AMOUNT,TO_CHAR(ADMIN_DATE,'DD/MM/YY') AS ADMIN_DATE,LEAD_HABITATION FROM RWS_WORK_ADMN_TBL W,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE D.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode
							+ "'";
				qry += " AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,5,2)=SD.SUBDIVISION_OFFICE_CODE AND SUBSTR(WORK_ID,5,2)='"
						+ dcode
						+ "' AND SUBSTR(WORK_ID,7,2)='"
						+ scheme
						+ "'  AND TO_CHAR(ADMIN_DATE,'yyyy')='"
						+ expyear
						+ "' AND ADMIN_DATE IS NOT NULL";
			} else if (!expyear.equals("ALL")) {
				qry = "SELECT WORK_ID,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,WORK_NAME,ADMIN_NO,SANCTION_AMOUNT,TO_CHAR(ADMIN_DATE,'DD/MM/YY') AS ADMIN_DATE,LEAD_HABITATION FROM RWS_WORK_ADMN_TBL W,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE D.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode
							+ "'";
				qry += " AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,5,2)=SD.SUBDIVISION_OFFICE_CODE AND SUBSTR(WORK_ID,5,2)='"
						+ dcode
						+ "' AND SUBSTR(WORK_ID,7,2)='"
						+ scheme
						+ "'AND TO_CHAR(ADMIN_DATE,'YYYY')<'1970' AND ADMIN_DATE IS NOT NULL";
			} else {
				qry = "SELECT WORK_ID,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,WORK_NAME,ADMIN_NO,SANCTION_AMOUNT,TO_CHAR(ADMIN_DATE,'DD/MM/YY') AS ADMIN_DATE,LEAD_HABITATION FROM RWS_WORK_ADMN_TBL W,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE D.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode
							+ "'";
				qry += " AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE AND SUBSTR(OFFICE_CODE,5,2)=SD.SUBDIVISION_OFFICE_CODE AND SUBSTR(WORK_ID,5,2)='"
						+ dcode
						+ "' AND SUBSTR(WORK_ID,7,2)='"
						+ scheme
						+ "' AND ADMIN_DATE IS NOT NULL";
			}
			qry += " AND AUG_NEW_CODE='1' ORDER BY DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME";
			stat = conn.prepareStatement(qry);
			rset = stat.executeQuery();
			while (rset.next()) {
				myForm = new RepresentativeProposalForm();
				myForm.setWorkid(rset.getString("work_id"));
				myForm.setTypeOfAsset("WORK");
				myForm.setDivisionOfficeName(rset.getString("division_office_name"));
				myForm.setSubdivisionOfficeName(rset.getString("subdivision_office_name"));
				myForm.setWorkname(rset.getString("work_name"));
				myForm.setAdmin_no(rset.getString("ADMIN_NO"));
				myForm.setAdmin_amount(rset.getString("SANCTION_AMOUNT"));
				myForm.setLocation("-");
				myForm.setAdmin_date(rset.getString("ADMIN_DATE"));
				PreparedStatement stata=null;
				String[] list = getWorkLeadHabMandalName(rset.getString("LEAD_HABITATION"), stata);
				myForm.setMandal(list[0]);
				myForm.setHabCode(list[1]);
				myForm.setRepAddress(list[2]);
				myForm.setRepName(list[3]);
				works.add(myForm);
			}
			if (!expyear.equals("<1970") && !expyear.equals("ALL")) {
				qry = "SELECT A.ASSET_CODE,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,TO_CHAR(A.DATE_CREATION,'DD/MM/YY') AS DATE_CREATION,NVL(A.START_YEAR,'-') AS START_YEAR,NVL(A.ASSET_NAME,'-') AS ASSET_NAME,NVL(A.ASSET_COST,'0') AS ASSET_COST,HAB_CODE,NVL(LOCATION,'-') AS LOCATION FROM RWS_ASSET_MAST_TBL A,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE A.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode
							+ "'";
				qry += " AND A.CIRCLE_OFFICE_CODE=D.CIRCLE_OFFICE_CODE AND A.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND A.SUBDIVISION_OFFICE_CODE=SD.SUBDIVISION_OFFICE_CODE AND  A.TYPE_OF_ASSET_CODE='"
						+ scheme
						+ "' AND TO_CHAR(A.DATE_CREATION,'yyyy')='"
						+ expyear + "'  AND A.DATE_CREATION  IS NOT NULL";
			} else if (!expyear.equals("ALL")) {
				qry = "SELECT A.ASSET_CODE,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,TO_CHAR(A.DATE_CREATION,'DD/MM/YY') AS DATE_CREATION,NVL(A.START_YEAR,'-') AS START_YEAR,NVL(A.ASSET_NAME,'-') AS ASSET_NAME,NVL(A.ASSET_COST,'0') AS ASSET_COST,HAB_CODE,NVL(LOCATION,'-') AS LOCATION FROM RWS_ASSET_MAST_TBL A,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE A.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode
							+ "'";
				qry += " AND A.CIRCLE_OFFICE_CODE=D.CIRCLE_OFFICE_CODE AND A.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND A.SUBDIVISION_OFFICE_CODE=SD.SUBDIVISION_OFFICE_CODE AND  A.TYPE_OF_ASSET_CODE='"
						+ scheme
						+ "' AND TO_CHAR(A.DATE_CREATION,'YYYY') <1970 AND A.DATE_CREATION  IS NOT NULL";
			} else {
				qry = "SELECT A.ASSET_CODE,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME,TO_CHAR(A.DATE_CREATION,'DD/MM/YY') AS DATE_CREATION,NVL(A.START_YEAR,'-') AS START_YEAR,NVL(A.ASSET_NAME,'-') AS ASSET_NAME,NVL(A.ASSET_COST,'0') AS ASSET_COST,HAB_CODE,NVL(LOCATION,'-') AS LOCATION FROM RWS_ASSET_MAST_TBL A,RWS_DIVISION_OFFICE_TBL D,RWS_SUBDIVISION_OFFICE_TBL SD WHERE A.CIRCLE_OFFICE_CODE='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " AND D.DIVISION_OFFICE_CODE='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " AND SD.SUBDIVISION_OFFICE_CODE='" + subDivCode + "'";
				qry += " AND A.CIRCLE_OFFICE_CODE=D.CIRCLE_OFFICE_CODE AND A.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=SD.CIRCLE_OFFICE_CODE AND D.DIVISION_OFFICE_CODE=SD.DIVISION_OFFICE_CODE AND A.SUBDIVISION_OFFICE_CODE=SD.SUBDIVISION_OFFICE_CODE AND A.TYPE_OF_ASSET_CODE='"
						+ scheme + "' AND A.DATE_CREATION IS NOT NULL";
			}
			qry += " ORDER BY DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME";
			rset.close();
			stat.close();
			stat = conn.prepareStatement(qry);
			rset = stat.executeQuery();
			while (rset.next()) {
				myForm = new RepresentativeProposalForm();
				myForm.setWorkid(rset.getString("asset_code"));
				myForm.setTypeOfAsset("ASSET");
				myForm.setDivisionOfficeName(rset.getString("division_office_name"));
				myForm.setSubdivisionOfficeName(rset.getString("subdivision_office_name"));
				myForm.setWorkname(rset.getString("asset_name"));
				myForm.setAdmin_no(rset.getString("start_year"));
				myForm.setAdmin_date(rset.getString("date_creation"));
				myForm.setAdmin_amount(rset.getString("asset_cost"));
				myForm.setLocation(rset.getString("location"));
				PreparedStatement statb = null;
				try {
					String[] list = getWorkLeadHabMandalName(rset.getString("HAB_CODE"), statb);
					myForm.setMandal(list[0]);
					myForm.setHabCode(list[1]);
					myForm.setRepAddress(list[2]);
					myForm.setRepName(list[3]);
				} catch (Exception e) {
					Debug.println("=====================:" + e.getMessage());
				}
				works.add(myForm);
				Debug.println("==========asset end==============");
			}

		} catch (Exception e) {
			Debug.println("Exception in get all assets is " + e);
		} finally {
			closeAll();
		}
		return works;
	}

	public String[] getWorkLeadHabMandalName(String leadHabCode, PreparedStatement stats) {
		String[] list = new String[4];
		ResultSet rss = null;
		try {
			String qry = "SELECT MNAME,PNAME,PANCH_CODE,PANCH_NAME FROM RWS_MANDAL_TBL A,RWS_PANCHAYAT_TBL P,RWS_PANCHAYAT_RAJ_TBL B WHERE SUBSTR(B.HAB_CODE,1,2)=A.DCODE  AND SUBSTR(B.HAB_CODE,6,2)=A.MCODE AND A.MCODE=P.MCODE AND SUBSTR(B.HAB_CODE,13,2)=P.PCODE AND A.DCODE=P.DCODE AND B.PANCH_CODE= ? ";
			stats = conn.prepareStatement(qry);	
			stats.setString(1, leadHabCode);
			rss = stats.executeQuery();
			if (rss.next()) {
				list[0] = rss.getString(1);
				list[1] = rss.getString(3);
				list[2] = rss.getString(4);
				list[3] = rss.getString(2);
			} else {
				list[0] = "-";
				list[1] = "-";
				list[2] = "-";
				list[3] = "-";
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getWorkLeadHabMandalName is :- " + e.getMessage());
		} 
		return list;
	}

	public ArrayList getContractorList() {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			stat = conn.prepareStatement("SELECT DISTINCT CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY FROM RWS_CONTRACTOR_TBL ORDER BY CONTRACTOR_NAME_COMPANY");
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
			}
		}
		return contList;
	}

	public ArrayList getContractorList(String work_id, String category_code) {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			String qry = "";
			if (category_code.equals("1")) {
				qry = "SELECT * FROM RWS_PROJ_CONTRACTOR_VIEW ORDER BY CONTRACTOR_NAME_COMPANY";
			} else {
				qry = "SELECT DISTINCT A.CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY FROM RWS_NON_PROJ_CONTRACTOR_VIEW A,RWS_CONTRACTOR_SELECTION_TBL B WHERE A.CONTRACTOR_CODE=B.CONTRACTOR_CODE AND SUBSTR(B.WORK_ID,5,2)='"
					+ work_id.substring(4, 6)+ "'  ORDER BY CONTRACTOR_NAME_COMPANY";
			}
			qry = "SELECT DISTINCT CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY FROM RWS_CONTRACTOR_TBL ORDER BY UPPER(CONTRACTOR_NAME_COMPANY)";
			stat = conn.prepareStatement(qry);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2) + " - "+ rset.getString(1));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
			}
		}
		return contList;
	}

	public ArrayList getContractorList(String contCode) {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			String qry = "";
			qry = "SELECT DISTINCT CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY FROM RWS_CONTRACTOR_TBL WHERE CONTRACTOR_CODE = ? ";
			stat = conn.prepareStatement(qry);
			stat.setString(1, contCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2) + " - " + rset.getString(1));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices getContractorList is :- " + e.getMessage());
			}
		}
		return contList;
	}

	public ArrayList getCircles4EOAT() throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL ORDER BY CIRCLE_OFFICE_NAME ";
			stat = conn.prepareStatement(query);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getCircles4EOAT is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getDivisions4EOAT(String circleOfficeCode)	throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME FROM  RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE= ? ";
			stat = conn.prepareStatement(query);
			stat.setString(1, circleOfficeCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getDivisions4EOAT is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getSubdivisions4EOAT(String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE =  ? ORDER BY SUBDIVISION_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			stat.setString(1, circleOfficeCode);
			stat.setString(2, divisionOfficeCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getSubdivisions4EOAT is :- " + e.getMessage());
		}  finally {
			closeAll();
		}
		return subdivisions;
	}

	public ArrayList getCircles4Employee(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT C.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL C,RWS_EMPLOYEE_TBL E WHERE "
					+ "SUBSTR (E.OFFICE_CODE,2,2)=C.CIRCLE_OFFICE_CODE AND C.HEAD_OFFICE_CODE= ? ORDER BY C.CIRCLE_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getCircles4Employee is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getDivisions4Employee(String headOfficeCode, String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_EMPLOYEE_TBL E "
					+ " WHERE D.HEAD_OFFICE_CODE = ? AND D.CIRCLE_OFFICE_CODE = ? AND SUBSTR(E.OFFICE_CODE,2,2)=D.CIRCLE_OFFICE_CODE "
					+ "AND SUBSTR (E.OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE ORDER BY DIVISION_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getDivisions4Employee is :- " + e.getMessage());
		}  finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getSubdivisions4Employee(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DISTINCT S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_EMPLOYEE_TBL E WHERE "
				+ " S.HEAD_OFFICE_CODE = ? AND S.CIRCLE_OFFICE_CODE =  ? AND S.DIVISION_OFFICE_CODE = ? AND SUBSTR (E.OFFICE_CODE,2,2) =S.CIRCLE_OFFICE_CODE AND"
				+ " SUBSTR(E.OFFICE_CODE,4,1)=S.DIVISION_OFFICE_CODE AND SUBSTR(E.OFFICE_CODE,5,2) =S.SUBDIVISION_OFFICE_CODE ORDER BY SUBDIVISION_OFFICE_NAME";
			stat = conn.prepareStatement(query);
			stat.setString(1, headOfficeCode);
			stat.setString(2, circleOfficeCode);
			stat.setString(3, divisionOfficeCode);
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		}catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getSubdivisions4Employee is :- " + e.getMessage());
		}  finally {
			closeAll();
		}
		return subdivisions;
	}

	public ArrayList getAllDivisionsWithOfficeCode1(String district) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? ORDER BY DIVISION_OFFICE_NAME ";
			ps = conn.prepareStatement(query);
			ps.setString(1, district);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1) + rset.getString(2) + "00");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + "1" + rset.getString(1) + rset.getString(2) + "00");
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getAllDivisionsWithOfficeCode1 is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return divisions;
	}

	public String getAdminDate(String workId) throws Exception {
		String year = "";
		try {
			conn = getConn();
			query = "SELECT TO_CHAR(ADMIN_DATE,'YYYY') AS FROMDATE FROM RWS_WORK_ADMN_TBL WHERE WORK_ID = ? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);;
			rset = ps.executeQuery();
			if (rset.next()) {
				String yearStart = rset.getString("fromDate");
				int yearTos = Integer.parseInt(yearStart);
				yearTos++;
				String yearTo = "" + yearTos;
				year = yearStart + "-" + yearTo;
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getAdminDate is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return year;
	}

	public ArrayList getDistrictsCodesNames() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL ORDER BY DNAME";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			int i = 0;
			while (rset.next()) {
				dists.add(i++, rset.getString(1) + rset.getString(2));
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getDistrictsCodesNames is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return dists;
	}

	public ArrayList getDivmandals(String circode, String divcode, String sdoc) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();
			query = "SELECT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MM WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND ";
			if (circode != null && !circode.equals("")) {
				query += "MM.CIRCLE_OFFICE_CODE= ? ";
			}
			if (divcode != null && !divcode.equals("")) {
				query += " AND MM.DIVISION_OFFICE_CODE= ? ";
			}
			if (sdoc != null && !sdoc.equals("") && !sdoc.equals("00")) {
				query += "AND MM.SUBDIVISION_OFFICE_CODE= ? ";
			}
			query += " ORDER BY M.MNAME";
			stat = conn.prepareStatement(query);
			if (circode != null && !circode.equals("")) {
				stat.setString(1, circode);
			}
			if (divcode != null && !divcode.equals("")) {
				stat.setString(2, divcode);
			}
			if (sdoc != null && !sdoc.equals("") && !sdoc.equals("00")) {
				stat.setString(3, sdoc);
			}
			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices getDivmandals is :- " + e.getMessage());
		} finally {
			closeAll();
		}
		return mandals;
	}

	public static Connection getConn() {
		Connection conn2 = null;
		try {
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			//conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.26:1521:orcl", "aprwssuser", "aprwssuser");
			//conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.67:1521:orcl", "aprwssuser", "aprwssuser");
			//conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.242.51.240:1521:wsoft", "aprwssuser", "aprwssuser");
			/*conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.160.19.167:1521:orastg", "aprwssuser", "aprwssuser");*/
			//conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft", "aprwssuser", "aprwssuser");
			conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.57:1521:orcl", "aprwssuser", "aprwssuser"); //commented on 07-10-2021
			// conn2 = DriverManager.getConnection("jdbc:oracle:thin:@10.72.4.57:1521:orcl", "aprwssuser", "aprwssuser"); //Commented on 30-03-2022
//conn2 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "aprwssuser", "aprwssuser");
			//System.out.println("Security Audit Localhost");
		} catch (SQLException e) {
			System.out.println("The Exception is in  RwsOffices getConn is :- " + e.getMessage());
		}
		return conn2;
	}

	public static String IndianFormat1(String value) {
		String stringValue = "";
		String stringActValue = "";
		try {
			stringValue = "" + value;
			int dotLocation = stringValue.indexOf(".");
			String integralPart = "", fractionalPart = "";
			if (dotLocation == -1) {
				integralPart = stringValue;
				fractionalPart = "00";
			} else {
				integralPart = stringValue.substring(0, dotLocation);
				fractionalPart = stringValue.substring(dotLocation + 1);
			}
			if (fractionalPart.length() == 1)
				fractionalPart += "0";
			stringActValue = stringValue;
			DecimalFormat df = new DecimalFormat("0.00");
			stringValue = df.format(Long.parseLong(integralPart));
			if (stringActValue.substring(0, 1).equals("-")) {
				stringValue = stringValue.substring(1, stringValue.length());
			}
			int i = 3;
			StringBuffer sb = new StringBuffer(integralPart);
			sb = sb.reverse();
			if (integralPart.length() <= 5) {
				sb.insert(i, ',');
			}
			if (integralPart.length() > 5 && integralPart.length() <= 7) {
				sb.insert(i, ',');
				sb.insert(i + 3, ',');
			}
			if (integralPart.length() > 7 && integralPart.length() <= 8) {
				sb.insert(i, ',');
				sb.insert(i + 3, ',');
			}
			if (integralPart.length() > 8) {
				sb.insert(i, ',');
				sb.insert(i + 3, ',');
				sb.insert(i + 6, ',');
			}
			sb = sb.reverse();
			integralPart = sb.toString();
			if (integralPart.startsWith(",")) {
				integralPart = integralPart.substring(1);
			}
			stringValue = integralPart + "." + fractionalPart;
			if (stringActValue.substring(0, 1).equals("-")) {
				stringValue = "-" + stringValue;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in  RwsOffices IndianFormat1 is :- " + e.getMessage());
		}
		return stringValue;
	}
	
	public boolean encryptData(String passWord, String dataToBeEncrypt, String path, String dataFileName, String sigFileName, String pubKeyFileName) throws Exception {
		String configName = "C:\\a.cfg";
		boolean flag = false;
		try {
			char[] pinn = passWord.toCharArray();
			KeyStore ks = KeyStore.getInstance("PKCS11");
			try {
				ks.load(null, pinn);
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices encryptData is :- " + e.getMessage());
				flag = false;
				return false;
			}
			String keyEntry = null;
			Enumeration en = ks.aliases();
			keyEntry = (String) en.nextElement();

			PrivateKey privKey = (PrivateKey) ks.getKey(keyEntry, null);

			Certificate cert = ks.getCertificate(keyEntry);
			PublicKey publicKey = cert.getPublicKey();

			byte[] data = dataToBeEncrypt.getBytes();

			Provider p = ks.getProvider();
			Signature sig = Signature.getInstance("SHA1withRSA", p);
			sig.initSign(privKey);
			sig.update(data);

			byte[] signature = sig.sign();

			File sss = new File(path, dataFileName);
			sss.createNewFile();

			File sss1 = new File(path, sigFileName);
			sss1.createNewFile();

			File sss2 = new File(path, pubKeyFileName);
			sss2.createNewFile();

			ObjectOutputStream os = new ObjectOutputStream(new FileOutputStream(path + "/" + sigFileName));
			os.writeObject(signature);
			os.flush();
			os.close();

			os = new ObjectOutputStream(new FileOutputStream(path + "/"	+ pubKeyFileName));
			os.writeObject(publicKey);
			os.flush();
			os.close();

			Writer output = new BufferedWriter(new FileWriter(path + "/" + dataFileName));
			output.write(dataToBeEncrypt);
			output.close();

			flag = true;
		} catch (Exception e) {
			flag = false;
			System.out.println("The Exception is in  RwsOffices encryptData is :- " + e.getMessage());
			try {
				File f = new File(sigFileName);
				if (f.exists())
					f.delete();
				File f1 = new File(pubKeyFileName);
				if (f1.exists())
					f1.delete();
				File f2 = new File(dataFileName);
				if (f2.exists())
					f2.delete();
			} catch (Exception ee) {
				System.out.println("The Exception is in  RwsOffices encryptData is :- " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean decryptData(String passWord, String path, String dataFileName, String sigFileName, String pubKeyFileName) throws Exception {
		String configName = "C:\\a.cfg";
		boolean flag = false;
		try {
			char[] pinn = passWord.toCharArray();
			KeyStore ks = KeyStore.getInstance("PKCS11");
			try {
				ks.load(null, pinn);				
			} catch (Exception e) {
				System.out.println("The Exception is in  RwsOffices decryptData is :- " + e.getMessage());
				return false;
			}
			KeyStore ks1 = KeyStore.getInstance("PKCS11");

			Provider p1 = ks1.getProvider();
			Signature sig1 = Signature.getInstance("SHA1withRSA", p1);
			BufferedReader br = new BufferedReader(new FileReader(path + "/" + dataFileName));
			String strLine = "", strLine1 = "";
			String newLine = "\r\n";
			while ((strLine = br.readLine()) != null) {
				strLine1 += strLine;
				strLine1 += newLine;
			}
			strLine1 = strLine1.substring(0, strLine1.length() - 2);
			byte[] data = strLine1.getBytes();

			ObjectInputStream is = new ObjectInputStream(new FileInputStream(path + "/" + sigFileName));
			byte[] readObj = (byte[]) is.readObject();

			ObjectInputStream is1 = new ObjectInputStream(new FileInputStream(path + "/" + pubKeyFileName));
			PublicKey pubbkey = (PublicKey) is1.readObject();

			sig1.initVerify(pubbkey);
			sig1.update(data);
			if (!sig1.verify(readObj)) {
				flag = false;
			} else {
				flag = true;
			}			
		} catch (Exception e) {
			flag = false;
			System.out.println("The Exception is in  RwsOffices decryptData is :- " + e.getMessage());
			try {
				File f = new File(sigFileName);
				if (f.exists())
					f.delete();
				File f1 = new File(pubKeyFileName);
				if (f1.exists())
					f1.delete();
				File f2 = new File(dataFileName);
				if (f2.exists())
					f2.delete();
			} catch (Exception ee) {
				System.out.println("The Exception is in  RwsOffices decryptData is :- " + e.getMessage());
			}
		}
		return flag;
	}

	public ArrayList getAllDivisions() {
		return null;
	}

	public static String ValidtateString(String validateString) {
		String validstring=validateString.replaceAll("[-+^&!--%#*]","");
		System.out.println("validstring== "+validstring);
		return validstring;
		}
}