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
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.sql.DataSource;


import nic.watersoft.proposals.RepresentativeProposalForm;
import nic.watersoft.works.tenderMemo;

//
//import nic.watersoft.masters.RwsMaster;

public class UrOffices {
	private File pkcs11Library;

	private DataSource dataSource = null;
	private Connection conn = null;     
	// private Connection conn1 = null;
	private Statement stat = null;
	private ResultSet rset = null;
	private String query = null;
	private PreparedStatement ps;
	private LabelValueBean labelValueBean = null;

	public UrOffices(DataSource dataSource) {
		this.dataSource = dataSource;
		try {
			// this.conn1 = conn2;
		} catch (Exception ee) {
			Debug.println("exception in conn1:" + ee.getMessage());
		}

	}

	public UrOffices() {

	}

	public void closeAll() throws Exception {
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll"+e);
			}
			rset = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll"+e);
			}
			rset = null;
		}
		if (stat != null) {
			try {
				stat.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll="+e);
			}
			stat = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll="+e);
			}
			conn = null;
		}
		/*
		 * if (conn1 != null) { try { conn1.close(); } catch (Exception e) {
		 * //System.out.println("The error in closeAll="+e); } conn1 = null; }
		 */

	}

	/**
	 * Gets the various RWS Head Offices
	 */
	public ArrayList getHeads() throws Exception {
		ArrayList headOffices = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT head_office_code, head_office_name "
					+ " FROM ur_head_office_tbl ORDER BY head_office_name";

			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
					+ " DCODE=? ORDER BY MNAME";
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			// System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - "
						+ rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("The error in getMandals()=== RwsLocations "+e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public String getMonthFromDual() throws Exception {
		String month = "";
		try {
			conn = getConn();
			query = " select to_char(sysdate,'MON') from dual";

			stat = conn.createStatement();
			rset = stat.executeQuery(query);

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
			query = " SELECT dcode, dname " + " FROM ur_district_tbl " + "  "
					+ " ORDER BY dcode,dname";

			// stat = conn.createStatement();
			// System.out.println("query in getDistricts is "+query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				dists.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return dists;
	}

	public ArrayList getConstituencies(String dcode) throws Exception {
		ArrayList constituencies = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT distinct constituency_code, constituency_name "
					+ " FROM rws_constituency_tbl " + " where dcode=? "
					+ " ORDER BY constituency_name";

			// stat = conn.createStatement();
			// System.out.println("query in getConstituencies is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);

			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				constituencies.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return constituencies;
	}

	// code added for employee
	public String[] getOfficeNames(String officeCode, boolean showOfficeType,
			DataSource dataSource) throws Exception {
		String officeName[] = new String[5];
		if (officeCode.equals("000000"))
			return null;
		try {
			// System.out.println("in getOffices"+officeCode);
			String headOfficeCode = officeCode.substring(0, 1);
			// System.out.println("122hoc"+headOfficeCode);
			String circleOfficeCode = officeCode.substring(1, 3);
			// System.out.println("222coc"+circleOfficeCode);
			String divisionOfficeCode = officeCode.substring(3, 4);
			// System.out.println("322doc"+divisionOfficeCode);
			String subdivisionOfficeCode = officeCode.substring(4, 6);
			// System.out.println("422sdoc"+subdivisionOfficeCode);

			String query = null;
			// String officeName = null;
			String officeType = null;

			conn = getConn();
			stat = conn.createStatement();

			if (!headOfficeCode.equals("0")) {
				query = " SELECT head_office_name FROM ur_head_office_tbl "
						+ " WHERE head_office_code = '" + headOfficeCode + "' ";
				// System.out.println("inside hoc");
				rset = stat.executeQuery(query);
				// System.out.println("offices HOC query"+query);
				while (rset.next()) {
					// officeName[0] = rset.getString(1)+" "+"Head Office\n";
					if (rset.getString(1) != null) {
						officeName[0] = rset.getString(1) + " "
								+ "Head Office\n";
					} else {
						officeName[0] = "null";
					}
				}

				if (!circleOfficeCode.equals("00")) {
					query = " SELECT circle_office_name FROM ur_circle_office_tbl "
							+ " WHERE head_office_code = '"
							+ headOfficeCode
							+ "' AND "
							+ " circle_office_code = '"
							+ circleOfficeCode + "' ";
					// officeType = "Circle";
					// System.out.println("inside coc");
					rset = stat.executeQuery(query);
					// System.out.println("offices COC query"+query);
					while (rset.next()) {
						// officeName[1] =
						// rset.getString(1)+" "+"Circle Office\n";
						if (rset.getString(1) != null) {
							officeName[1] = rset.getString(1) + " "
									+ "Circle Office\n";
						} else {
							officeName[1] = "null";
						}

					}

					if (!divisionOfficeCode.equals("0")) {
						query = " SELECT division_office_name FROM ur_division_office_tbl "
								+ " WHERE head_office_code = '"
								+ headOfficeCode
								+ "' AND "
								+ " circle_office_code = '"
								+ circleOfficeCode
								+ "' AND "
								+ " division_office_code = '"
								+ divisionOfficeCode + "' ";
						// officeType = "Division";
						// System.out.println("inside doc");
						rset = stat.executeQuery(query);
						// System.out.println("offices DOC query"+query);
						while (rset.next()) {

							if (rset.getString(1) != null) {
								officeName[2] = rset.getString(1) + " "
										+ "Division Office\n";
							} else {
								officeName[2] = "null";
							}
						}

						if (!subdivisionOfficeCode.equals("00")) {

							query = " SELECT subdivision_office_name FROM ur_subdivision_office_tbl "
									+ " WHERE head_office_code = '"
									+ headOfficeCode
									+ "' AND "
									+ " circle_office_code = '"
									+ circleOfficeCode
									+ "' AND "
									+ " division_office_code = '"
									+ divisionOfficeCode
									+ "' AND "
									+ " subdivision_office_code = '"
									+ subdivisionOfficeCode + "' ";
							// officeType = "Sub Division";
							// System.out.println("inside sdoc");
							rset = stat.executeQuery(query);
							// System.out.println("offices SDOC query"+query);
							while (rset.next()) {
								if (rset.getString(1) != null) {
									officeName[3] = rset.getString(1) + " "
											+ "SubDivision Office";
								} else {
									officeName[3] = "null";
								}

							}

						}
					}
				}
			}

		} catch (Exception e) {
			// System.out.println("error in getHeadOfficeNames "+e);
		}

		finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in Office Names");}
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
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM ur_circle_office_tbl ORDER BY circle_office_name";

			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			// System.out.println("circle offices in rwsmasterdata"+query);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
			query = " SELECT dcode,dname " + " FROM urban_district_tbl "
					+ " ORDER BY dname";

			// stat = conn.createStatement();
			// System.out.println("query in getDistricts is "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				districts.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return districts;
	}

	public static String getDivisions(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode) throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			String query = " SELECT division_office_name, division_office_code "
					+ " FROM ur_division_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' "
					+ " AND circle_office_code = '"
					+ circleOfficeCode
					+ "' "
					+ " ORDER BY division_office_name ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			// System.out.println("query is:**"+query );
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

				query = "SELECT DNAME,DCODE FROM urban_DISTRICT_TBL WHERE DCODE='"
						+ circleOfficeCode + "'";
				// System.out.println("query is:**"+query );

				PreparedStatement ps1 = conn.prepareStatement(query);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}
				buffer.append("<//>");

				query = "SELECT MNAME,MCODE FROM urban_MANDAL_TBL WHERE DCODE='"
						+ circleOfficeCode + "' order by MNAME";
				// System.out.println("query is:**"+query );
				PreparedStatement ps2 = conn.prepareStatement(query);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					buffer.append(rs2.getString(1) + "<>");
					buffer.append(rs2.getString(2) + "</>");
				}

			}

		} catch (Exception e) {
			// System.out.println("Exception ..while getting divisions:"+e);
		}

		finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// System.out.println("Exception "+e);
			}
		}
		return buffer.toString();

	}

	/*
	 * public ArrayList getCircles(String headOfficeCode) throws Exception {
	 * //System.out.println("in getCircles"); ArrayList circles = new
	 * ArrayList(); try { conn = getConn(); query =
	 * " SELECT circle_office_code, circle_office_name " +
	 * " FROM ur_circle_office_tbl " + " WHERE head_office_code = ? " +
	 * " ORDER BY circle_office_name";
	 * 
	 * //stat = conn.createStatement();
	 * //System.out.println("query in getCircles is "+query); ps =
	 * conn.prepareStatement(query); ps.setString(1,headOfficeCode); rset =
	 * ps.executeQuery(); //rset = stat.executeQuery(query);
	 * 
	 * while(rset.next()) { labelValueBean = new LabelValueBean();
	 * labelValueBean.setValue(rset.getString(1));
	 * labelValueBean.setLabel(rset.getString(2));
	 * labelValueBean.setLabelValue(rset.getString(2)+" - " +
	 * rset.getString(1)); circles.add(labelValueBean); } } catch(Exception
	 * e){//System.out.println("Exception in getCircles is "+e);} finally {
	 * closeAll(); }
	 * 
	 * return circles; }
	 */
	public static String getOffices(DataSource dataSource, String officeCode)
			throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			// query = " SELECT circle_office_code, circle_office_name "
			// + " FROM ur_circle_office_tbl ORDER BY circle_office_name";

			String query = " SELECT division_office_name, division_office_code "
					+ " FROM ur_division_office_tbl "
					+ " WHERE head_office_code = '"
					+ officeCode
					+ "' "
					+ " ORDER BY division_office_name ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			// System.out.println("query using officecode:**"+query );
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

				// query="SELECT DNAME,DCODE FROM ur_district_tbl WHERE DCODE='"+circleOfficeCode+"'";
				// System.out.println("query is:**"+query );

				PreparedStatement ps1 = conn.prepareStatement(query);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}
				buffer.append("<//>");

				// query="SELECT MNAME,MCODE FROM urban_MANDAL_TBL WHERE DCODE='"+circleOfficeCode+"' order by MNAME";
				// System.out.println("query is:**"+query );
				PreparedStatement ps2 = conn.prepareStatement(query);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					buffer.append(rs2.getString(1) + "<>");
					buffer.append(rs2.getString(2) + "</>");
				}

			}

		} catch (Exception e) {
			// System.out.println("Exception ..while getting divisions:"+e);
		}

		finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// System.out.println("Exception "+e);
			}
		}
		return buffer.toString();

	}

	public static String getSubDivisions(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = getConn();
			String query = "SELECT subdivision_office_name, subdivision_office_code "
					+ " FROM ur_subdivision_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' "
					+ " AND circle_office_code = '"
					+ circleOfficeCode
					+ "' "
					+ " AND division_office_code = '"
					+ divisionOfficeCode
					+ "' " + " ORDER BY subdivision_office_name ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			// System.out.println("query is:**"+query );
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

				query = "SELECT M.MNAME ,M.MCODE FROM urban_MANDAL_TBL M, urban_MANDAL_SUBDIVISION_TBL MM  "
						+ "WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND MM.CIRCLE_OFFICE_CODE='"
						+ circleOfficeCode
						+ "' "
						+ "AND MM.DIVISION_OFFICE_CODE='"
						+ divisionOfficeCode
						+ "' ORDER BY MNAME";
				// System.out.println("query is:***m"+query );
				PreparedStatement ps1 = conn.prepareStatement(query);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}

				rs1.close();
				ps1.close();
			}
		} catch (Exception e) {
			// System.out.println("Exception ..@@"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// System.out.println("Exception "+e);
			}
		}
		return buffer.toString();
	}

	// endf of code

	public ArrayList getDistrictMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT mcode, mname " + " FROM urban_mandal_tbl "
					+ " where dcode=? " + " ORDER BY mname";

			// stat = conn.createStatement();
			// System.out.println("query in getCircles is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
		// System.out.println("Exception in getCircles is "+e);	}
		} finally {
			closeAll();
		}

		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT pcode, pname " + " FROM rws_panchayat_tbl "
					+ " where dcode=? and mcode=?" + " ORDER BY pname";

			// stat = conn.createStatement();
			// System.out.println("query in getCircles is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				panchayats.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return panchayats;
	}

	// /

	// added by swapna on 26-08-2011 for mandal subdivision
	public String getDivname(String dcode, String mcode) throws Exception {
		Debug.println("in division:" + dcode + "mcode" + mcode);
		String query = null;
		String dname = "";
		try {
			conn = getConn();
			query = "select division_office_name,b.division_office_code from urban_mandal_subdivision_tbl a, ur_division_office_tbl b  where dcode='"
					+ dcode
					+ "' and mcode='"
					+ mcode
					+ "' and a.division_office_code=b.division_office_code and a.circle_office_code=b.circle_office_code";
			Debug.println("divname11 :::::::::" + query);
			Statement stmt = conn.createStatement();
			Debug.println("divname222 :::::::::" + query);
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				Debug.println("in rs.next:::::::::");
				dname = rs.getString(1) + "-" + rs.getString(2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out
					.println("The error in getdivision name === RwsLocations "
							+ e);
		} finally {
			closeAll();
		}
		Debug.println("in rs.next::::2222:::::" + dname);
		return dname;
	}

	// added by swapna on 02-09-2011 for mandal subdivision

	public String getSubDivname1(String dcode, String divcode, String sdcode)
			throws Exception {
		String query = null;
		String sdname1 = "";
		try {
			conn = getConn();
			query = "select subdivision_office_name  from ur_subdivision_office_tbl   where CIRCLE_OFFICE_CODE ='"
					+ dcode
					+ "' and DIVISION_OFFICE_CODE='"
					+ divcode
					+ "' and SUBDIVISION_OFFICE_CODE ='" + sdcode + "'";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			System.out.println("subdivname222 :::::::::" + query);

			while (rs.next()) {
				sdname1 = rs.getString(1);

			}
		} catch (Exception e) {
			System.out
					.println("The error in getMandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		System.out.println("subdivname3333 :::::::::" + sdname1);
		return sdname1;
	}

	// added by swapna on 26-08-2011 for mandal subdivision
	public String getSubDivname(String dcode, String mcode, String div)
			throws Exception {

		String query = null;
		String sdname = "";
		try {
			conn = getConn();
			query = "select subdivision_office_name,b.subdivision_office_code from urban_mandal_subdivision_tbl a, ur_subdivision_office_tbl b  where dcode='"
					+ dcode
					+ "' and mcode='"
					+ mcode
					+ "' and b.division_office_code='"
					+ div
					+ "' and a.division_office_code=b.division_office_code and a.circle_office_code=b.circle_office_code and a.subdivision_office_code=b.subdivision_office_code";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			System.out.println("subdivname :::::::::" + query);

			while (rs.next()) {
				sdname = rs.getString(1) + "@" + rs.getString(2);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return sdname;
	}

	//
	// //
	public ArrayList getVillages(String dcode, String mcode, String pcode)
			throws Exception {
		ArrayList villages = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT vcode, vname " + " FROM rws_village_tbl "
					+ " where dcode=? and mcode=? and pcode=? "
					+ " ORDER BY vname";

			// stat = conn.createStatement();
			// System.out.println("query in getVillages is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);

			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getVillages is "+e);}
		} finally {
			closeAll();
		}

		return villages;
	}

	public ArrayList getCircles(String headOfficeCode) throws Exception {
		// Debug.println("in getCircles with HOD:"+headOfficeCode);
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM ur_circle_office_tbl "
					+ " WHERE head_office_code = ? "
					+ " ORDER BY circle_office_name";

			// stat = conn.createStatement();
			// Debug.println("query in getCircles is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return circles;
	}

	// added by jyothi to get status date of hab dir table
	public String getHabStatusDate() throws Exception {
		Debug.println("in get hab status date......");
		String hbdt = "";
		try {
			conn = getConn();
			query = "SELECT distinct to_char(Status_date,'dd/mm/yyyy') from rws_habitation_directory_tbl where status_date is not null";
			Statement ps1 = conn.createStatement();
			ResultSet rs1 = ps1.executeQuery(query);
			if (rs1.next()) {
				hbdt = rs1.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return hbdt;
	}

	// end
	public ArrayList getAllCirclesWithOfficeCode(String headOfficeCode)
			throws Exception {
		// System.out.println("in getCircles");
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM ur_circle_office_tbl "
					+ " WHERE head_office_code = ? "
					+ " ORDER BY circle_office_name";

			// stat = conn.createStatement();
			// System.out.println("query in getCircles is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1) + "000");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + "1"
						+ rset.getString(1) + "000");
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getCircles is "+e);}
		} finally {
			closeAll();
		}

		return circles;
	}

	/**
	 * Gets the various RWS Division Offices based on
	 * 
	 * @param headOfficeCode
	 * @param circleOfficeCode
	 */
	public ArrayList getDivisions(String headOfficeCode, String circleOfficeCode)
			throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT division_office_code, division_office_name "
					+ " FROM ur_division_office_tbl "
					+ " WHERE head_office_code ='" + headOfficeCode + "' "
					+ " AND circle_office_code = '" + circleOfficeCode + "'"
					+ " ORDER BY division_office_name ";
			// Debug.println("query in getDivisions "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getCensusVillage(String dcode, String mcode, String pcode,
			String vcode) throws Exception {
		ArrayList mandals = null;
		String query = null;
		Debug.println("dcode:" + dcode);
		Debug.println("mcode:" + mcode);
		Debug.println("pcode:" + pcode);
		Debug.println("vcode:" + vcode);
		try {
			conn = getConn();
			query = "select * from rws_hab_vill_census_code_tbl where DISTRICT_CODE = 02"
					+ dcode;
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			Debug.println("sub dists query:" + query);
			ps = conn.prepareStatement(query);
			// ps.setString(1,dcode);
			// ps.setString(2,mcode);
			rset = ps.executeQuery();
			String dist = "", mand = "", dist1 = "", mand1 = "", panch1 = "", panch = "", vill = "", vill1 = "", hab = "", hab1 = "", cvcode = "", cvname = "";
			while (rset.next()) {
				/*
				 * //Debug.println("in rset with hab:"+rset.getString(10));
				 * labelValueBean = new LabelValueBean();
				 * labelValueBean.setValue(rset.getString(1));
				 * labelValueBean.setLabel(rset.getString(2));
				 * labelValueBean.setLabelValue(rset.getString(2)+" - " +
				 * rset.getString(1)); mandals.add(labelValueBean);
				 */
				dist = rset.getString("DISTRICT_NAME");
				// Debug.println("1:"+dist);
				int posdist = dist.indexOf("(");
				dist1 = dist.substring(posdist + 1, posdist + 3);
				// Debug.println("1.1:"+dist1);

				mand = rset.getString("BLOCK_NAME");
				// Debug.println("2:"+mand);
				int posmand = mand.indexOf("(");
				mand1 = mand.substring(posmand + 1, posmand + 3);
				// Debug.println("2.1:"+mand1);
				panch = rset.getString("GRAM_PANCHAYAT_NAME");
				// Debug.println("3:"+panch);
				int pospanch = panch.indexOf("(");
				panch1 = panch.substring(pospanch + 1, pospanch + 3);
				// Debug.println("3.1:"+panch1);
				vill = rset.getString("VILLAGE_NAME");
				// Debug.println("4:"+vill);
				int posvill = vill.indexOf("(");
				vill1 = vill.substring(posvill + 1, posvill + 4);
				// Debug.println("4.1:"+vill1);
				if (dist1.equals(dcode) && mand1.equals(mcode)
						&& panch1.equals(pcode) && vill1.equals(vcode)) {
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
			Debug.println("census dist code in  method:" + dcode);
			query = "select distinct Census_SubDistrict_Code,Census_SubDistrict_Name from rws_census2001_villages_tbl where Census_District_Code="
					+ dcode;
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			Debug.println("sub dist query:" + query);
			ps = conn.prepareStatement(query);
			// ps.setString(1,dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
			query = "select distinct Census_District_Code,Census_District_Name from rws_census2001_villages_tbl";
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			// System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
		// Debug.println("dcode:"+dcode);
		// Debug.println("mcode:"+mcode);
		try {
			conn = getConn();
			query = "select distinct Census_Village_Code,Census_Village_Name from rws_census2001_villages_tbl where Census_District_Code="
					+ dcode + " and Census_SubDistrict_Code=" + mcode;
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			Debug.println("sub dists query:" + query);
			ps = conn.prepareStatement(query);
			// ps.setString(1,dcode);
			// ps.setString(2,mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				// Debug.println("in rset with hab:"+rset.getString(10));
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("The error in getMandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getCensusHabData(String dcode, String mcode, String pcode,
			String vcode) throws Exception {
		ArrayList habsData = new ArrayList();
		String query = null;
		tenderMemo tenderMemoObj = new tenderMemo();
		Debug.println("dcode:" + dcode);
		Debug.println("mcode:" + mcode);
		Debug.println("pcode:" + pcode);
		Debug.println("vcode:" + vcode);
		ArrayList wqlist = new ArrayList();
		try {
			conn = getConn();
			// query =
			// "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0),nvl(hd.CENSUS_PLAIN_POPU,0),nvl(hd.SC_POP_COVERED,0),nvl(hd.ST_POP_COVERED,0),nvl(hd.PLAIN_POPU_COVERED,0) from ur_district_tbl d,urban_MANDAL_TBL m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? and p.pcode=? and v.vcode=? order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
			query = "select distinct d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0),nvl(hd.CENSUS_PLAIN_POPU,0),nvl(hd.SC_POP_COVERED,0),nvl(hd.ST_POP_COVERED,0),nvl(hd.PLAIN_POPU_COVERED,0),nvl(hq.INADEQUATE_QTY,'N'),nvl(hq.ARSENIC,'N'),nvl(hq.IRON,'N'),nvl(hq.FLUORIDE,'N'),nvl(hq.SALINITY,'N'),nvl(hq.SOURCE_FOR_NC_POP,'0') from ur_district_tbl d,urban_MANDAL_TBL m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_hab_quan_qual_stat_tbl hq where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.hab_code = hq.hab_code(+) and d.dcode=? and m.mcode=? and p.pcode=? and v.vcode=? order by d.dcode,m.mcode,p.pcode,v.vcode,h.panch_code";
			// stmt = conn.createStatement();
			// rs
			// =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM urban_MANDAL_TBL WHERE"
			// + " DCODE=? ORDER BY MNAME");
			// System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			ps.setString(4, vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				Debug.println("add one tender memo");
				tenderMemoObj = new tenderMemo();
				tenderMemoObj.setHabCode(rset.getString(9));
				tenderMemoObj.setHabName(rset.getString(10));
				tenderMemoObj.setScPop(rset.getString(11));
				tenderMemoObj.setStPop(rset.getString(12));
				tenderMemoObj.setPlainPop(rset.getString(13));
				tenderMemoObj
						.setTotalPop(""
								+ (rset.getInt(11) + rset.getInt(12) + rset
										.getInt(13)));
				tenderMemoObj.setScCov(rset.getString(14));
				tenderMemoObj.setStCov(rset.getString(15));
				tenderMemoObj.setPlainCov(rset.getString(16));
				tenderMemoObj
						.setTotalCov(""
								+ (rset.getInt(14) + rset.getInt(15) + rset
										.getInt(16)));
				tenderMemoObj.setChecks(rset.getString(9));
				if (rset.getString(17) == null
						|| (rset.getString(17) != null && rset.getString(17)
								.equals("N"))) {
					tenderMemoObj.setInQua("null");
				} else if (rset.getString(17) != null
						&& rset.getString(17).equals("Y")) {
					tenderMemoObj.setInQua("on");
				}
				if (rset.getString(18) == null
						|| (rset.getString(18) != null && rset.getString(18)
								.equals("N"))) {
					tenderMemoObj.setQp1("null");
				} else if (rset.getString(18) != null
						&& rset.getString(18).equals("Y")) {
					tenderMemoObj.setQp1("on");
				}
				if (rset.getString(19) == null
						|| (rset.getString(19) != null && rset.getString(19)
								.equals("N"))) {
					tenderMemoObj.setQp2("null");
				} else if (rset.getString(19) != null
						&& rset.getString(19).equals("Y")) {
					tenderMemoObj.setQp2("on");
				}
				if (rset.getString(20) == null
						|| (rset.getString(20) != null && rset.getString(20)
								.equals("N"))) {
					tenderMemoObj.setQp3("null");
				} else if (rset.getString(20) != null
						&& rset.getString(20).equals("Y")) {
					tenderMemoObj.setQp3("on");
				}
				if (rset.getString(21) == null
						|| (rset.getString(21) != null && rset.getString(21)
								.equals("N"))) {
					tenderMemoObj.setQp4("null");
				} else if (rset.getString(21) != null
						&& rset.getString(21).equals("Y")) {
					tenderMemoObj.setQp4("on");
				}
				// tenderMemoObj.setInQua(rset.getString(17));
				// tenderMemoObj.setQp1(rset.getString(18));
				// tenderMemoObj.setQp2(rset.getString(19));
				// tenderMemoObj.setQp3(rset.getString(20));
				// tenderMemoObj.setQp4(rset.getString(21));
				Debug.println("source for nc pop in method:"
						+ rset.getString(22));
				tenderMemoObj.setSfncpop(rset.getString(22));
				Debug.println("source for nc pop in method1:"
						+ tenderMemoObj.getSfncpop());
				habsData.add(tenderMemoObj);
			}
		} catch (Exception e) {
			System.out.println("The error in getCensusHabData():"
					+ e.getMessage());
		} finally {
			closeAll();
		}
		return habsData;
	}

	public ArrayList getHabitations(String dcode, String mcode, String pcode,
			String vcode) throws Exception {
		ArrayList habs = new ArrayList();

		String query = "";
		try {
			conn = getConn();
			Statement stmt1 = conn.createStatement();
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)='"
					+ dcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,6,2)='"
					+ mcode
					+ "' AND "
					+ "SUBSTR(RAJ.HAB_CODE,13,2)='"
					+ pcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,8,3)='"
					+ vcode
					+ "' AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
			 System.out.println("query in getHabitations is "+query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - "
						+ rset.getString(2));
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
			query = "select * from rws_hab_vill_census_code_tbl where DISTRICT_CODE = 02"
					+ dcode;
			Debug.println("sub dists query:" + query);
			ps = conn.prepareStatement(query);
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

				/*
				 * Debug.println("dist:"+dist1); Debug.println("dist1:"+dcode);
				 * Debug.println("mand:"+mand1); Debug.println("mand1:"+mcode);
				 * Debug.println("panch:"+panch1);
				 * Debug.println("panch1:"+pcode); Debug.println("vill:"+vill1);
				 * Debug.println("vill1:"+vcode);
				 */
				if (dist1.equals(dcode) && mand1.equals(mcode)
						&& panch1.equals(pcode)) {
					Debug.println("in map");
					String countQuery = "select * from rws_hab_vill_census_code_tbl "
							+ "where DISTRICT_CODE = '"
							+ rset.getString(4)
							+ "' and "
							+ "BLOCK_CODE  = '"
							+ rset.getString(7)
							+ "'"
							+ "and GRAM_PANCHAYAT_CODE  =  '"
							+ rset.getString(10) + "'";
					// "VILLAGE_CODE = '"+rset.getString(13)+"'";
					Debug.println("disable Staus Query:" + countQuery);
					stat = conn.createStatement();
					ResultSet rs = stat.executeQuery(countQuery);
					int villageCount = 0;
					boolean alreadyMain = false, actVillage = false;
					while (rs.next()) {
						villageCount++;
						if (rs.getString("MAIN_VILL_OR_NOT") != null
								&& rs.getString("MAIN_VILL_OR_NOT").equals("Y")) {
							alreadyMain = true;
							String vill2 = rs.getString("VILLAGE_NAME");
							int posvill2 = vill2.indexOf("(");
							vill2 = vill2.substring(posvill2 + 1, posvill2 + 4);
							if (vill2.equals(vcode)) {
								actVillage = true;
							}
						}
					}
					// if(rs!=null) rs.close();
					// rs = stat.executeQuery(countQuery);
					if (villageCount > 1 && alreadyMain && !actVillage) {
						/*
						 * while(rs.next()) {
						 * 
						 * if(vill2.equals(vcode)) {
						 * 
						 * } } if(rs.getString("MAIN_OR_NOT") != null &&
						 * rs.getString("MAIN_OR_NOT").equals("y")) {
						 * 
						 * }
						 */
						disableStatus = "true";
					} else
						disableStatus = "false";
					Debug.println("disableStauts:" + disableStatus);
					continue;
				}
			}
		} catch (Exception e) {
			Debug.println("The error in rwsMasterData get census status="
					+ e.getMessage());
		} finally {
			closeAll();
		}
		return disableStatus;
	}

	public ArrayList getAllDivisionsWithOfficeCode() throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT circle_office_code,division_office_code, division_office_name "
					+ " FROM ur_division_office_tbl "
					+ " ORDER BY division_office_name ";
			// System.out.println("query in getDivisions "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1)
						+ rset.getString(2) + "00");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + "1"
						+ rset.getString(1) + rset.getString(2) + "00");
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;

	}

	/**
	 * Gets the various RWS Sub Division Offices based on
	 * 
	 * @param headOfficeCode
	 * @param circleOfficeCode
	 * @param divisionOfficeCode
	 */
	public ArrayList getSubdivisions(String headOfficeCode,
			String circleOfficeCode, String divisionOfficeCode)
			throws Exception {

		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT subdivision_office_code, subdivision_office_name "
					+ " FROM ur_subdivision_office_tbl "
					+ " WHERE head_office_code = '" + headOfficeCode + "' "
					+ " AND circle_office_code = '" + circleOfficeCode + "' "
					+ " AND division_office_code = '" + divisionOfficeCode
					+ "'" + " ORDER BY subdivision_office_name ";
			// System.out.println("query in SUBDIVISION:"+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
				lowerOfficeCode = headOfficeCode + circleOfficeCode
						+ divisionOfficeCode + "00";
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
				higherOfficeCode = headOfficeCode + circleOfficeCode
						+ divisionOfficeCode + "00";
			else if (!divisionOfficeCode.equals("0"))
				higherOfficeCode = headOfficeCode + circleOfficeCode + "000";
			else if (!circleOfficeCode.equals("00"))
				higherOfficeCode = headOfficeCode + "00000";
			else
				higherOfficeCode = "000000";
		}
		return higherOfficeCode;
	}

	public String getOfficeName(String officeCode, boolean showOfficeType)
			throws Exception {
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
		Statement stat = null;
		ResultSet rset = null;

		if (!subdivisionOfficeCode.equals("00")) {
			query = " SELECT subdivision_office_name FROM ur_subdivision_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' AND "
					+ " division_office_code = '"
					+ divisionOfficeCode
					+ "' AND "
					+ " subdivision_office_code = '"
					+ subdivisionOfficeCode + "' ";
			officeType = "Sub Division";
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT division_office_name FROM ur_division_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' AND "
					+ " division_office_code = '" + divisionOfficeCode + "' ";
			officeType = "Division";
		} else if (!circleOfficeCode.equals("00")) {
			query = " SELECT circle_office_name FROM ur_circle_office_tbl "
					+ " WHERE head_office_code = '" + headOfficeCode + "' AND "
					+ " circle_office_code = '" + circleOfficeCode + "' ";
			officeType = "Circle";
		} else if (!headOfficeCode.equals("0")) {
			query = " SELECT head_office_name FROM ur_head_office_tbl "
					+ " WHERE head_office_code = '" + headOfficeCode + "' ";
			officeType = "";
		}

		try {
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
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

	public String getOfficeName(String officeCode, boolean showOfficeType,
			Connection conn) throws Exception {
		if (officeCode.equals("000000"))
			return "";

		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);

		String query = null;
		String officeName = null;
		String officeType = null;

		Statement stat = null;
		ResultSet rset = null;

		if (!subdivisionOfficeCode.equals("00")) {
			query = " SELECT subdivision_office_name FROM ur_subdivision_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' AND "
					+ " division_office_code = '"
					+ divisionOfficeCode
					+ "' AND "
					+ " subdivision_office_code = '"
					+ subdivisionOfficeCode + "' ";
			officeType = "Sub Division";
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT division_office_name FROM ur_division_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' AND "
					+ " division_office_code = '" + divisionOfficeCode + "' ";
			officeType = "Division";
		} else if (!circleOfficeCode.equals("00")) {
			query = " SELECT circle_office_name FROM ur_circle_office_tbl "
					+ " WHERE head_office_code = '" + headOfficeCode + "' AND "
					+ " circle_office_code = '" + circleOfficeCode + "' ";
			officeType = "Circle";
		} else if (!headOfficeCode.equals("0")) {
			query = " SELECT head_office_name FROM ur_head_office_tbl "
					+ " WHERE head_office_code = '" + headOfficeCode + "' ";
			officeType = "";
		}

		try {
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
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

	/**
	*
	*
	*/
	public ArrayList getLowerOffices(String officeCode) throws Exception {
		String headOfficeCode = officeCode.substring(0, 1);
		String circleOfficeCode = officeCode.substring(1, 3);
		String divisionOfficeCode = officeCode.substring(3, 4);
		String subdivisionOfficeCode = officeCode.substring(4, 6);

		if (!subdivisionOfficeCode.equals("00")) {
		} else if (!divisionOfficeCode.equals("0")) {
			query = " SELECT (head_office_code||circle_office_code||division_office_code|| "
					+ " subdivision_office_code) as office_code, "
					+ " subdivision_office_name "
					+ " FROM ur_subdivision_office_tbl WHERE "
					+ " head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' AND "
					+ " division_office_code = '"
					+ divisionOfficeCode
					+ "' "
					+ " ORDER BY subdivision_office_name ";
		} else if (!circleOfficeCode.equals("00")) {
			query = " SELECT (head_office_code||circle_office_code||division_office_code|| "
					+ " '00') AS office_code, "
					+ " division_office_name "
					+ " FROM ur_division_office_tbl WHERE "
					+ " head_office_code = '"
					+ headOfficeCode
					+ "' AND "
					+ " circle_office_code = '"
					+ circleOfficeCode
					+ "' "
					+ " ORDER BY division_office_name ";
		} else if (!headOfficeCode.equals("0")) {
			query = " SELECT (head_office_code||circle_office_code||'000') AS office_code, "
					+ " circle_office_name "
					+ " FROM ur_circle_office_tbl WHERE "
					+ " head_office_code = '"
					+ headOfficeCode
					+ "' "
					+ " ORDER BY circle_office_name ";
		}
		// System.out.println("query is "+query);
		conn = getConn();
		stat = conn.createStatement();
		rset = stat.executeQuery(query);
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

	public String getCircleOfficeName(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode) {
		try {
			conn = getConn();
			stat = conn.createStatement();
			query = " select circle_office_code,circle_office_name from "
					+ " ur_circle_office_tbl where head_office_code='"
					+ headOfficeCode + "'" + " and circle_office_code='"
					+ circleOfficeCode + "'";

			// System.out.println("query is "+query);
			rset = stat.executeQuery(query);
			while (rset.next())
				return rset.getString("circle_office_name");

		} catch (Exception e) {
			// System.out.println("exception in getCircleOfficeName()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDistrictName");}
			}
		}
		return "";
	}

	public String getDivisionOfficeName(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode) {
		try {
			conn = getConn();
			stat = conn.createStatement();
			query = " select division_office_code,division_office_name from "
					+ " ur_division_office_tbl where head_office_code='"
					+ headOfficeCode + "' and circle_office_code='"
					+ circleOfficeCode + "'" + " and division_office_code='"
					+ divisionOfficeCode + "'";

			rset = stat.executeQuery(query);
			while (rset.next())
				return rset.getString("division_office_name");

		} catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeName()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDistrictName");}
			}
		}
		return "";
	}

	public String getSubDivisionOfficeName(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode, String subDivisionOfficeCode) {
		try {
			try {
				conn = getConn();
			} catch (Exception e) {
				// System.out.println("exception in creating connection");}
			}
			stat = conn.createStatement();
			query = " select subdivision_office_code,subdivision_office_name from "
					+ " ur_subdivision_office_tbl where head_office_code='"
					+ headOfficeCode
					+ "'"
					+ " and circle_office_code='"
					+ circleOfficeCode
					+ "'"
					+ " and division_office_code='"
					+ divisionOfficeCode
					+ "'"
					+ " and subdivision_office_code='"
					+ subDivisionOfficeCode
					+ "'";

			rset = stat.executeQuery(query);
			while (rset.next())
				return rset.getString("subdivision_office_name");

		} catch (Exception e) {
			// System.out.println("exception in getSubdivisionOfficeName()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDistrictName");}
			}

		}
		return "";
	}

	public String getDivisionOfficeCode(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode) {
		String divisionOfficeCode = "";
		try {

			conn = getConn();
			stat = conn.createStatement();
			query = " select division_office_code from "
					+ " ur_division_office_tbl where head_office_code='"
					+ headOfficeCode + "'" + " and circle_office_code='"
					+ circleOfficeCode + "'";
			// System.out.println("query in getDivisionOfficeCode is "+query);
			rset = stat.executeQuery(query);
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

	public String getSubDivisionOfficeCode(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode) {
		String subDivisionOfficeCode = "";
		try {

			conn = getConn();

			stat = conn.createStatement();
			query = " select subdivision_office_code from "
					+ " ur_subdivision_office_tbl where head_office_code='"
					+ headOfficeCode + "'" + " and circle_office_code='"
					+ circleOfficeCode + "'" + " and division_office_code='"
					+ divisionOfficeCode + "'";
			// System.out.println("query in getSubDivisionOfficeCode is "+query);
			rset = stat.executeQuery(query);
			while (rset.next())
				subDivisionOfficeCode = rset
						.getString("subdivision_office_code");

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

	public String getSubDivisionOfficeCodeFromMandal(DataSource dataSource,
			String dcode, String mcode) {
		String subDivisionOfficeCode = "";
		try {

			conn = getConn();

			stat = conn.createStatement();
			query = " select SUBDIVISION_OFFICE_CODE  from "
					+ " urban_MANDAL_SUBDIVISION_TBL where dcode='" + dcode + "'"
					+ " and mcode='" + mcode + "'";

			// System.out.println("query in getSubDivisionOfficeCode is "+query);
			rset = stat.executeQuery(query);
			while (rset.next())
				subDivisionOfficeCode = rset
						.getString("subdivision_office_code");

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

	public String getDivisionOfficeCodeFromMandal(DataSource dataSource,
			String dcode, String mcode) {
		String divisionOfficeCode = "";
		try {

			conn = getConn();

			stat = conn.createStatement();
			query = " select DIVISION_OFFICE_CODE  from "
					+ " urban_MANDAL_SUBDIVISION_TBL where dcode='" + dcode + "'"
					+ " and mcode='" + mcode + "'";

			// System.out.println("query in getSubDivisionOfficeCode is "+query);
			rset = stat.executeQuery(query);
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

	public String getPanchayatName(DataSource dataSource, String dcode,
			String mcode, String pcode) {
		String pname = "";
		try {

			conn = getConn();

			stat = conn.createStatement();
			query = " select pname  from " + " rws_panchayat_tbl where dcode='"
					+ dcode + "'" + " and mcode='" + mcode + "' and pcode='"
					+ pcode + "'";

			// System.out.println("query in getPanchayatName is "+query);
			rset = stat.executeQuery(query);
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

			query = " select dname " + " FROM ur_district_tbl "
					+ " where dcode='" + dcode + "' " + " ";

			// stat = conn.createStatement();
			// System.out.println("query in getDistrictName is "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				districtName = rset.getString("dname");
			}
		} catch (Exception e) {
			// System.out.println("Exception in getDistrictName is "+e);}
		} finally {
			closeAll();
		}

		return districtName;
	}

	public String getDivisionName(String divcode) throws Exception {
		String divisionName = "";
		try {
			conn = getConn();

			query = " select division_office_name "
					+ " FROM ur_division_office_tbl "
					+ " where division_office_code='" + divcode + "' " + " ";

			// stat = conn.createStatement();
			// System.out.println("query in getDivisionName is "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

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

			query = " select mname " + " FROM urban_MANDAL_TBL "
					+ " where dcode=? and mcode=?" + " ";

			// stat = conn.createStatement();
			// System.out.println("query in getDistrictName is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				mandalName = rset.getString("mname");
			}
		} catch (Exception e) {
			// System.out.println("Exception in getMandalName is "+e);}
		} finally {
			closeAll();
		}

		return mandalName;
	}

	public String getPanchayatName(String dcode, String mcode, String pcode)
			throws Exception {
		String panchayatName = "";
		try {
			conn = getConn();

			query = " select pname " + " FROM rws_panchayat_tbl "
					+ " where dcode=? and mcode=? and pcode=?" + " ";

			// stat = conn.createStatement();
			// System.out.println("query in getDistrictName is "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

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

	public String getVillageName(DataSource dataSource, String dcode,
			String mcode, String pcode, String vcode) {
		String vname = "";
		try {

			conn = getConn();

			stat = conn.createStatement();
			query = " select vname  from " + " rws_village_tbl where dcode='"
					+ dcode + "'" + " and mcode='" + mcode + "' and pcode='"
					+ pcode + "' and vcode='" + vcode + "'";

			// System.out.println("query in getVillageName is "+query);
			rset = stat.executeQuery(query);
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

			stat = conn.createStatement();
			query = " select panch_name  from "
					+ " rws_panchayat_raj_tbl where panch_code='" + habCode
					+ "'";

			// System.out.println("query in getHabitationName is "+query);
			rset = stat.executeQuery(query);
			while (rset.next())
				habName = rset.getString("panch_name");

		} catch (Exception e) {
			// System.out.println("exception in getHabitationName()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getHabitationName");}
			}
		}
		return habName;
	}

	// code added by sita
	public ArrayList getPRCircles() throws Exception {
		// System.out.println("in getPRCircles");
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM RWS_PR_circle_office_tbl "
					+ " ORDER BY circle_office_name";

			// stat = conn.createStatement();
			// System.out.println("query in getPRCircles is "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			// System.out.println("Exception in getPRCircles is "+e);}
		} finally {
			closeAll();
		}

		return circles;
	}

	// ADDED ON SEPT 11
	public ArrayList getQCCircles() throws Exception {
		// System.out.println("in getQCCircles");
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT circle_office_code, circle_office_name "
					+ " FROM RWS_QC_circle_office_tbl "
					+ " ORDER BY circle_office_name";

			// stat = conn.createStatement();
			// System.out.println("query in getQCCircles is "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
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
			query = " SELECT division_office_code, division_office_name "
					+ " FROM rws_pr_division_office_tbl "
					+ " where circle_office_code = ?"
					+ " ORDER BY division_office_name ";
			// System.out.println("query in getPRDivisions "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;

	}

	// added on sept 11
	/**
	 * Gets the various QC Division Offices based on
	 * 
	 * @param circleOfficeCode
	 */
	public ArrayList getQCDivisions(String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT division_office_code, division_office_name "
					+ " FROM rws_qc_division_office_tbl "
					+ " where circle_office_code = ?"
					+ " ORDER BY division_office_name ";
			// System.out.println("query in getQCDivisions "+query);
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;

	}

	// end of code added by sita

	/*
	 * @author Manoj
	 */
	public ArrayList getProgrammes(String headOfficeCode,
			String circleOfficeCode, String divisionOfficeCode, String subdiv) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			// System.out.println(""+headOfficeCode+"_"+circleOfficeCode+"_"+divisionOfficeCode+"_"+subdiv);
			query = "select distinct wd.programme_code,p.programme_name "
					+ "from rws_work_admn_tbl wd, rws_programme_tbl p "
					+ "where p.programme_code=wd.programme_code "
					+ "and substr(wd.office_code,1,1)='" + headOfficeCode + "'"
					+ " and substr(wd.office_code,2,2)='" + circleOfficeCode
					+ "'";
			// System.out.println("GENERATING query"+query);
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals(""))
					&& !(divisionOfficeCode.equals("0")))
				query += " and substr(wd.office_code,4,1)='"
						+ divisionOfficeCode + "'";
			if (subdiv != null && !(subdiv.equals("")))
				query += " and substr(wd.office_code,5,2)='" + subdiv + "'";
			query += "order by wd.programme_code";
			// System.out.println("query in programmes:"+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				programmes.add(labelValueBean);
			}
			// System.out.println("NO.OF PROGRAMS RETURNED = "+programmes.size());
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

	public ArrayList getSubProgrammes(String circleOfficeCode,
			String divisionOfficeCode, String subdiv, String program) {
		ArrayList subprogrammes = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct sp.subprogramme_code,sp.subprogramme_name "
					+ " from rws_subprogramme_tbl sp,rws_work_admn_tbl w where sp.programme_code=w.programme_code and sp.subprogramme_code=w.subprogramme_code and sp.programme_code='"
					+ program
					+ "'"
					+ " and substr(w.office_code,2,2)='"
					+ circleOfficeCode + "'";
			if (divisionOfficeCode != null && !(divisionOfficeCode.equals(""))
					&& !divisionOfficeCode.equals("0"))
				query += " and substr(w.office_code,4,1)='"
						+ divisionOfficeCode + "'";
			if (subdiv != null && !(subdiv.equals("")))
				query += " and substr(w.office_code,5,2)='" + subdiv + "'";
			query += "order by sp.subprogramme_code";
			Debug.println("query in SUBprogrammes:" + query);
			ps = conn.prepareStatement(query);
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

	// end of code for programmes and subprogrammes

	// newly added by sita
	public ArrayList CircleCombo(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct substr(ne.office_code,2,2) as circleoffcode,circle_office_name  from rws_work_admn_tbl ne,"
					+ " ur_circle_office_tbl co where substr(ne.office_code,2,2)=co.circle_office_code and substr(ne.office_code,1,1)=? order by circle_office_name";
			Debug.println("query in getCircles is " + query);
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getCircles is " + e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing ");
			}
		}

		return circles;
	}

	public ArrayList DivisionCombo(String headOfficeCode, String circlecode)
			throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct substr(pp.office_code,4,1) as divisionoffcode,division_office_name  "
					+ " from rws_work_admn_tbl pp ,ur_division_office_tbl co where "
					+ " substr(pp.office_code,2,2)=co.circle_office_code and "
					+ " substr(pp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,1,1) = '"
					+ headOfficeCode
					+ "' AND substr(pp.office_code,2,2) = '"
					+ circlecode + "' order by division_office_name";

			// System.out.println("query in getDivisions "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getDivisions is " + e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				Debug.println("Get Divisions Exception in Closing ");
			}
		}
		return divisions;

	}

	public ArrayList SubDivisionCombo(String headOfficeCode,
			String circleOfficeCode, String divisionOfficeCode)
			throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct substr(pp.office_code,5,2) as subdivisionoffcode,subdivision_office_name  from rws_work_admn_tbl pp,ur_subdivision_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code  and substr(pp.office_code,4,1)=co.division_office_code  AND substr(pp.office_code,5,2)=co.subdivision_office_code and substr(pp.office_code,1,1) = ? and substr(pp.office_code,2,2) = ? and substr(pp.office_code,4,1) = ? order by subdivision_office_name";
			Debug.println("subdiv query:" + query);
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}

		return subdivisions;
	}

	public ArrayList getProgrammes1(String headOfficeCode,
			String circleOfficeCode, String divisionOfficeCode, String subdiv) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			Debug.println("" + headOfficeCode + "_" + circleOfficeCode + "_"
					+ divisionOfficeCode + "_" + subdiv);

			if (divisionOfficeCode != null && !(divisionOfficeCode.equals(""))
					&& !(divisionOfficeCode.equals("0")) && subdiv.equals("")) {
				query = "select distinct wd.programme_code,p.programme_name "
						+ "from rws_work_admn_tbl wd, rws_programme_tbl p "
						+ "where p.programme_code=wd.programme_code "
						+ "and substr(wd.office_code,1,1)='" + headOfficeCode
						+ "'" + " and substr(wd.office_code,2,2)='"
						+ circleOfficeCode
						+ "' and substr(wd.office_code,4,1)='"
						+ divisionOfficeCode + "'  order by wd.programme_code";
				ps = conn.prepareStatement(query);
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - "
							+ rset.getString(1));
					programmes.add(labelValueBean);
				}
				Debug.println("NO.OF PROGRAMS RETURNED = " + programmes.size());
			}
			// query+=" and substr(wd.office_code,4,1)='"+divisionOfficeCode+"'";
			else if (divisionOfficeCode != null
					&& !(divisionOfficeCode.equals(""))
					&& !(divisionOfficeCode.equals("0")) && subdiv != null
					&& !(subdiv.equals(""))) {
				query = "select distinct wd.programme_code,p.programme_name "
						+ "from rws_work_admn_tbl wd, rws_programme_tbl p "
						+ "where p.programme_code=wd.programme_code "
						+ "and substr(wd.office_code,1,1)='" + headOfficeCode
						+ "'" + " and substr(wd.office_code,2,2)='"
						+ circleOfficeCode
						+ "' and substr(wd.office_code,4,1)='"
						+ divisionOfficeCode
						+ "' and substr(wd.office_code,5,2)='" + subdiv
						+ "' order by wd.programme_code";
				ps = conn.prepareStatement(query);
				rset = ps.executeQuery();
				while (rset.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean.setLabelValue(rset.getString(2) + " - "
							+ rset.getString(1));
					programmes.add(labelValueBean);
				}
				Debug.println("NO.OF PROGRAMS RETURNED = " + programmes.size());
			}

			// if( subdiv!=null && !(subdiv.equals("")) )
			// query+=" and substr(wd.office_code,5,2)='"+subdiv+"'";
			// query+="order by wd.programme_code";
			// Debug.println("query in programmes:"+query);

		} catch (Exception e) {
			Debug.println("Exceptiong in Getting Programmes" + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				Debug.println("Get Programmes Exception in Closing ");
			}
		}
		return programmes;
	}

	public ArrayList getProgrammes1(String planCode, String wrkType,
			String workCat) {
		ArrayList programmes = new ArrayList();
		try {
			conn = getConn();
			query = " select distinct w.programme_code,p.programme_name from rws_programme_tbl p,rws_work_prog_lnk_tbl w,rws_work_admn_tbl ad  "
					+ " where w.programme_code=p.programme_code and w.plan_code='"
					+ planCode
					+ "' and w.aug_new_code='"
					+ wrkType
					+ "' "
					+ " and w.category_code='"
					+ workCat
					+ "' and w.programme_code=ad.programme_code and p.programme_code=ad.programme_code order by p.programme_name";
			ps = conn.prepareStatement(query);
			Debug.println("QUERY TO GET PROGRAMMES:" + query);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				programmes.add(labelValueBean);
			}
			Debug.println("NO.OF PROGRAMS RETURNED = " + programmes.size());
		} catch (Exception e) {
			Debug.println("Exceptiong in Getting Programmes" + e.getMessage());
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				Debug.println("Get Programmes Exception in Closing ");
			}
		}
		return programmes;
	}

	public ArrayList getSubProgrammes(String program) {
		ArrayList subprogrammes = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct sp.subprogramme_code,sp.subprogramme_name  from "
					+ " rws_subprogramme_tbl sp,rws_work_admn_tbl w where "
					+ " sp.programme_code=w.programme_code and sp.programme_code='"
					+ program + "' order by sp.subprogramme_code";
			Debug.println("query in SUBprogrammes:" + query);
			ps = conn.prepareStatement(query);
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

	// end of code for programmes and subprogrammes
	public ArrayList getSlippageReasons() {
		ArrayList slipReasons = new ArrayList();
		try {
			conn = getConn();
			String qry = "select * from  rws_slippage_reason_tbl";
			stat = conn.createStatement();
			rset = stat.executeQuery(qry);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				slipReasons.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("EXCEPTION IN GETTING SLIPPAGE REASONS"
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					rset.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING RESULTSET");
				}
			}
			if (stat != null) {
				try {
					stat.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING STATEMENT");
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING CONNECTION");
				}
			}
		}
		return slipReasons;
	}

	/*
	 * 
	 * @author ramesh starts here
	 */

	public String getCircleName(String dcode) throws Exception {
		String circleName = "";
		try {
			conn = getConn();

			query = " select circle_office_name FROM ur_circle_office_tbl where circle_office_code='"
					+ dcode + "'";

			// stat = conn.createStatement();
			nic.watersoft.commons.Debug.println("query in getcircle name is "
					+ query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				circleName = rset.getString("circle_office_name");
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug
					.println("Exception in getDistrictName is " + e);
		} finally {
			closeAll();
		}

		return circleName;
	}

	public ArrayList getAssetTypes(String workcat, String plancode)
			throws Exception {
		ArrayList assetTypes = new ArrayList();
		Debug.println("work category is" + workcat);
		try {
			query = " SELECT type_of_asset_code , UPPER(type_of_asset_name)  "
					+ " FROM rws_asset_type_tbl where type_of_asset_name in";
			if (workcat.equals("1") && plancode.equals("1")) {
				// query+="('CPWS','OTHERS') order by type_of_asset_code";
				query += "('CPWS') order by type_of_asset_code";
			}
			if (workcat.equals("1") && plancode.equals("2")) {
				// query+="('CPWS','OTHERS') order by type_of_asset_code";
				query += "('CPWS') order by type_of_asset_code";
			}
			if (workcat.equals("2") && plancode.equals("1")) {
				// query+="('PWS','OTHERS') order by type_of_asset_code";
				// query+="('PWS','SUSTAINABILITY') order by type_of_asset_code";
				// added by swapna 0n 6-04-2011 for adding the
				// buildings,labs,schools
				query += "('PWS','SUSTAINABILITY','SCHOOLS') order by type_of_asset_code";
			}
			// added by swapna on 06-04-2011 for adding labs in non-plan Normal
			if (workcat.equals("2") && plancode.equals("2")) {

				query += "('PWS','SUSTAINABILITY','LAB') order by type_of_asset_code";
			}
			//
			if (workcat.equals("3") && plancode.equals("1")) {
				// added by swapna 0n 6-04-2011 for adding the
				// schools,openwells,borewells
				query += "('PWS','HANDPUMPS','SCHOOLS','OPEN WELLS') order by type_of_asset_code";
			}
			if (workcat.equals("3") && plancode.equals("2")) {

				query += "('PWS','HANDPUMPS') order by type_of_asset_code";
			} else if (workcat.equals("")) {
				query += "('') order by type_of_asset_code";
			}

			Debug.println("query to get assettypesswapnaaaa:" + query);
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return assetTypes;
	}

	public ArrayList getAssetTypes(String workcat) throws Exception {
		ArrayList assetTypes = new ArrayList();
		Debug.println("work category is" + workcat);
		try {
			query = " SELECT type_of_asset_code , UPPER(type_of_asset_name)  "
					+ " FROM rws_asset_type_tbl where type_of_asset_name in";
			if (workcat.equals("1")) {
				// query+="('CPWS','OTHERS') order by type_of_asset_code";
				query += "('CPWS') order by type_of_asset_code";
			}
			if (workcat.equals("2")) {
				query += "('PWS','SUSTAINABILITY','SCHOOLS','LAB') order by type_of_asset_code";
			}
			if (workcat.equals("3")) {
				query += "('PWS','HANDPUMPS','SCHOOLS','OPEN WELLS') order by type_of_asset_code";
			} else if (workcat.equals("")) {
				query += "('') order by type_of_asset_code";
			}

			Debug.println("query to get assettypesswapnaaaa:" + query);
			conn = getConn();
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assetTypes.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return assetTypes;
	}

	//

	public ArrayList getDivisions1(String ccode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = " SELECT division_office_code, division_office_name"
					+ " FROM ur_division_office_tbl "
					+ " where circle_office_code=? "
					+ " ORDER BY division_office_name";

			// stat = conn.createStatement();
			nic.watersoft.commons.Debug.println("query in getDivisions is "
					+ query);
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in getCircles is "
					+ e);
		} finally {
			closeAll();
		}

		return divisions;
	}

	public ArrayList getSubDivisions1(String ccode, String divcode)
			throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = " select subdivision_office_code,subdivision_office_name from ur_subdivision_office_tbl WHERE circle_office_code=? and division_office_code=? ORDER BY subdivision_office_name";

			// stat = conn.createStatement();
			nic.watersoft.commons.Debug.println("query in getSubDivisions is "
					+ query);
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			ps.setString(2, divcode);
			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in getCircles is "
					+ e);
		} finally {
			closeAll();
		}

		return subdivisions;
	}

	public ArrayList getPrograms(String workcategory, String plan, String augnew)
			throws Exception {
		ArrayList programs = new ArrayList();
		try {
			conn = getConn();
			String qq = "select programme_code from rws_work_prog_lnk_tbl where category_code='"
					+ workcategory
					+ "' and plan_code='"
					+ plan
					+ "' and aug_new_code='"
					+ augnew
					+ "' order by programme_code";
			qq = "select w.programme_code,p.programme_name from rws_programme_tbl p,rws_work_prog_lnk_tbl w where w.programme_code=p.programme_code and category_code='"
					+ workcategory
					+ "' and plan_code='"
					+ plan
					+ "' and aug_new_code='"
					+ augnew
					+ "' order by p.programme_code,p.programme_name";
			Debug.println("query in get programms for total:" + qq);
			Statement sts = conn.createStatement();
			ResultSet rs = sts.executeQuery(qq);
			while (rs.next()) {
				/*
				 * query =
				 * "select programme_code,programme_name from rws_programme_tbl where programme_code='"
				 * +rs.getString(1)+"'";
				 * Debug.println("query in getprograms:"+query); Statement st =
				 * conn.createStatement(); rset = st.executeQuery(query);
				 * 
				 * while(rset.next()) {
				 */
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				programs.add(labelValueBean);
				// }
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in getPrograms is "
					+ e);
		} finally {
			closeAll();
		}

		return programs;
	}

	public ArrayList getSubprograms(String program) throws Exception {
		ArrayList subprograms = new ArrayList();
		try {
			conn = getConn();
			query = "select subprogramme_code,subprogramme_name from rws_subprogramme_tbl where programme_code='"
					+ program + "' order by subprogramme_name";

			// stat = conn.createStatement();
			nic.watersoft.commons.Debug.println("query in get Sub Programs is "
					+ query);
			Statement st = conn.createStatement();
			rset = st.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subprograms.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug
					.println("Exception in get sub Programs is " + e);
		} finally {
			closeAll();
		}

		return subprograms;
	}

	public ArrayList getWorkCategory() throws Exception {
		ArrayList subprograms = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT category_code,CATEGORY_NAME FROM rws_work_category_tbl";

			// stat = conn.createStatement();
			nic.watersoft.commons.Debug
					.println("query in get work categories is " + query);
			Statement st = conn.createStatement();
			rset = st.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subprograms.add(labelValueBean);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug
					.println("Exception in get Work categories is " + e);
		} finally {
			closeAll();
		}

		return subprograms;
	}

	public ArrayList getExpYears() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentYear = dateFormat.format(currentDate).substring(0, 4);
		int currentYears = Integer.parseInt(currentYear);
		try {
			for (int i = currentYears; i >= 2000; i--) {
				int j = i;
				j++;
				// nic.watersoft.commons.Debug.println(i+" - "+j);

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
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentYear = dateFormat.format(currentDate).substring(0, 4);
		int currentYears = Integer.parseInt(currentYear);
		try {
			for (int i = currentYears; i >= 1970; i--) {
				int j = i;
				j++;
				// nic.watersoft.commons.Debug.println(i+" - "+j);

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
			stat = conn.createStatement();
			rset = stat
					.executeQuery("select * from rws_asset_type_tbl order by type_of_asset_code");
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				assets.add(labelValueBean);
			}

		} catch (Exception e) {
			nic.watersoft.commons.Debug
					.println("Exception in get all assets is " + e);
		} finally {
			closeAll();
		}
		return assets;
	}

	public ArrayList getWorksList(String dcode, String expyear, String scheme,
			RepresentativeProposalForm myForm, String divCode, String subDivCode)
			throws Exception {

		ArrayList works = new ArrayList();
		try {
			Debug.println("in get works with exp year:" + expyear);
			conn = getConn();
			stat = conn.createStatement();
			int ey = 0;
			/*
			 * if(expyear!=null || !expyear.equals("")) { ey =
			 * Integer.parseInt(expyear);}
			 */
			String qry = "";
			if (!expyear.equals("<1970") && !expyear.equals("ALL")) {
				qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,ur_division_office_tbl d,ur_subdivision_office_tbl sd where d.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)='"
						+ dcode
						+ "' and substr(work_id,7,2)='"
						+ scheme
						+ "'  and to_char(admin_date,'yyyy')='"
						+ expyear
						+ "' and admin_date is not null";
			} else if (!expyear.equals("ALL")) {
				qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,ur_division_office_tbl d,ur_subdivision_office_tbl sd where d.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)='"
						+ dcode
						+ "' and substr(work_id,7,2)='"
						+ scheme
						+ "'  and to_char(admin_date,'yyyy')<'1970' and admin_date is not null";
			} else {
				qry = "select work_id,division_office_name,subdivision_office_name,work_name,admin_no,sanction_amount,to_char(admin_date,'dd/mm/yy') as admin_date,LEAD_HABITATION from rws_work_admn_tbl w,ur_division_office_tbl d,ur_subdivision_office_tbl sd where d.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and substr(office_code,4,1)=d.division_office_code and substr(office_code,5,2)=sd.subdivision_office_code and substr(work_id,5,2)='"
						+ dcode
						+ "' and substr(work_id,7,2)='"
						+ scheme
						+ "' and admin_date is not null";
			}
			qry += " and aug_new_code='1' order by division_office_name,subdivision_office_name";
			Debug.println("get work list for aug:" + qry);
			rset = stat.executeQuery(qry);
			Statement stata = conn.createStatement();
			while (rset.next()) {
				myForm = new RepresentativeProposalForm();
				myForm.setWorkid(rset.getString("work_id"));
				myForm.setTypeOfAsset("WORK");
				myForm.setDivisionOfficeName(rset
						.getString("division_office_name"));
				myForm.setSubdivisionOfficeName(rset
						.getString("subdivision_office_name"));
				myForm.setWorkname(rset.getString("work_name"));
				myForm.setAdmin_no(rset.getString("ADMIN_NO"));
				myForm.setAdmin_amount(rset.getString("SANCTION_AMOUNT"));
				myForm.setLocation("-");
				myForm.setAdmin_date(rset.getString("ADMIN_DATE"));

				String[] list = getWorkLeadHabMandalName(
						rset.getString("LEAD_HABITATION"), stata);
				// String[] list =
				// getWorkLeadHabMandalName(rset.getString("LEAD_HABITATION"),conn);
				myForm.setMandal(list[0]);
				myForm.setHabCode(list[1]);
				myForm.setRepAddress(list[2]);
				myForm.setRepName(list[3]);
				works.add(myForm);
			}
			/*
			 * if(!expyear.equals("<1970")) qry =
			 * "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost from rws_asset_mast_tbl a,ur_division_office_tbl d,ur_subdivision_office_tbl sd where   a.circle_office_code='"
			 * +dcode+
			 * "' and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code='"
			 * +scheme+"'  and to_char(a.date_creation,'yyyy')='"+expyear+
			 * "'  and a.date_creation  is not null"; else qry =
			 * "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost from rws_asset_mast_tbl a,ur_division_office_tbl d,ur_subdivision_office_tbl sd where   a.circle_office_code='"
			 * +dcode+
			 * "' and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code='"
			 * +scheme+
			 * "'  and to_char(a.date_creation,'yyyy')< '1970'  and a.date_creation  is not null"
			 * ;
			 */
			if (!expyear.equals("<1970") && !expyear.equals("ALL")) {
				qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,ur_division_office_tbl d,ur_subdivision_office_tbl sd where   a.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code='"
						+ scheme
						+ "'  and to_char(a.date_creation,'yyyy')='"
						+ expyear + "'  and a.date_creation  is not null";
			} else if (!expyear.equals("ALL")) {
				qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,ur_division_office_tbl d,ur_subdivision_office_tbl sd where   a.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code='"
						+ scheme
						+ "'  and to_char(a.date_creation,'yyyy') <1970 and a.date_creation  is not null";
			} else {
				qry = "select a.asset_code,division_office_name,subdivision_office_name,to_char(a.date_creation,'dd/mm/yy') as date_creation,nvl(a.start_year,'-') as start_year,nvl(a.asset_name,'-') as asset_name,nvl(a.asset_cost,'0') as asset_cost,HAB_CODE,nvl(location,'-') as location from rws_asset_mast_tbl a,ur_division_office_tbl d,ur_subdivision_office_tbl sd where   a.circle_office_code='"
						+ dcode + "'";
				if (divCode != null && !divCode.equals(""))
					qry += " and d.division_office_code='" + divCode + "'";
				if (subDivCode != null && !subDivCode.equals(""))
					qry += " and sd.subdivision_office_code='" + subDivCode
							+ "'";
				qry += " and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.subdivision_office_code=sd.subdivision_office_code and  a.type_of_asset_code='"
						+ scheme + "' and a.date_creation  is not null";
			}
			qry += " order by division_office_name,subdivision_office_name";
			Debug.println("Qry1Asset:" + qry);
			rset.close();
			stat.close();
			stat = conn.createStatement();
			Statement statb = conn.createStatement();
			rset = stat.executeQuery(qry);
			while (rset.next()) {
				Debug.println("==========asset==============");
				myForm = new RepresentativeProposalForm();
				myForm.setWorkid(rset.getString("asset_code"));
				myForm.setTypeOfAsset("ASSET");
				myForm.setDivisionOfficeName(rset
						.getString("division_office_name"));
				myForm.setSubdivisionOfficeName(rset
						.getString("subdivision_office_name"));
				myForm.setWorkname(rset.getString("asset_name"));
				myForm.setAdmin_no(rset.getString("start_year"));
				myForm.setAdmin_date(rset.getString("date_creation"));
				myForm.setAdmin_amount(rset.getString("asset_cost"));
				myForm.setLocation(rset.getString("location"));
				try {
					String[] list = getWorkLeadHabMandalName(
							rset.getString("HAB_CODE"), statb);
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

	public String[] getWorkLeadHabMandalName(String leadHabCode, Statement stats) {
		String[] list = new String[4];
		ResultSet rss = null;
		try {
			// String qry =
			// "select mname,panch_code,panch_name from urban_MANDAL_TBL a,rws_panchayat_raj_tbl b where substr(b.hab_code,1,2)=a.dcode  and substr(b.hab_code,6,2)=a.mcode and b.panch_code='"+leadHabCode+"'";
			String qry = "select mname,pname,panch_code,panch_name from urban_MANDAL_TBL a,rws_panchayat_tbl p,rws_panchayat_raj_tbl b where substr(b.hab_code,1,2)=a.dcode  and substr(b.hab_code,6,2)=a.mcode and a.mcode=p.mcode and substr(b.hab_code,13,2)=p.pcode and a.dcode=p.dcode and b.panch_code='"
					+ leadHabCode + "'";
			Debug.println("qry:" + qry);
			rss = stats.executeQuery(qry);
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
			Debug.println("ERROR IN GETTING getWorkLeadHabMandalName:"
					+ e.getMessage());
		} finally {
			try {
				// if(rss!=null)rss.close();
				// if(stats!=null)stats.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION WHILE CLOSING CONNECTION IN getWorkLeadHabMandalName");
			}
		}
		return list;
	}

	/*
	 * 
	 * @author ramesh ended
	 */
	public ArrayList getContractorList() {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			stat = conn.createStatement();
			rset = stat
					.executeQuery("select DISTINCT CONTRACTOR_CODE,CONTRACTOR_NAME_COMPANY from RWS_CONTRACTOR_TBL order by CONTRACTOR_NAME_COMPANY");
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("ERROR IN GETTING CONTRACTOR NAMES IN RWSOFFICES"
					+ e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION WHILE CLOSING CONNECTION IN GETCONTRACTOR");
			}
		}
		return contList;
	}

	/*
	 * added by ramesh on 281009
	 */
	public ArrayList getContractorList(String work_id, String category_code) {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			stat = conn.createStatement();
			String qry = "";
			if (category_code.equals("1")) {
				qry = "select * from rws_proj_contractor_view order by contractor_name_company";
			} else {
				qry = "select distinct a.contractor_code,contractor_name_company from rws_non_proj_contractor_view a,rws_contractor_selection_tbl b where a.contractor_code=b.contractor_code and substr(b.work_id,5,2)='"
						+ work_id.substring(4, 6)
						+ "'  order by contractor_name_company";
			}
			qry = "select distinct contractor_code,contractor_name_company from rws_contractor_tbl order by upper(contractor_name_company)";
			Debug.println("finally get contractors qry:" + qry);
			rset = stat.executeQuery(qry);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2) + " - "
						+ rset.getString(1));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("ERROR IN GETTING CONTRACTOR NAMES IN RWSOFFICES"
					+ e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION WHILE CLOSING CONNECTION IN GETCONTRACTOR");
			}
		}
		return contList;
	}

	public ArrayList getContractorList(String contCode) {
		ArrayList contList = new ArrayList();
		try {
			conn = getConn();
			stat = conn.createStatement();
			String qry = "";
			qry = "select distinct contractor_code,contractor_name_company from rws_contractor_tbl where contractor_code = '"
					+ contCode + "'";
			Debug.println("finally get contractors qry:" + qry);
			rset = stat.executeQuery(qry);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2) + " - "
						+ rset.getString(1));
				contList.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("ERROR IN GETTING CONTRACTOR NAMES IN RWSOFFICES"
					+ e.getMessage());
		} finally {
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION WHILE CLOSING CONNECTION IN GETCONTRACTOR");
			}
		}
		return contList;
	}

	public ArrayList getCircles4EOAT() throws Exception {
		// System.out.println("in getCircles");
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			// query =
			// " SELECT distinct c.circle_office_code,c.circle_office_name "
			// + " FROM ur_circle_office_tbl c,rws_eoat_tbl e "
			// +
			// " WHERE c.head_office_code ='"+headOfficeCode+"' and c.circle_office_code=e.circle_office_code "
			// + " ORDER BY c.circle_office_name";
			query = "select distinct circle_office_code, circle_office_name from ur_circle_office_tbl order by circle_office_name ";
			stat = conn.createStatement();
			Debug.println("getCircles is" + query);
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getCircles is " + e);
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getDivisions4EOAT(String circleOfficeCode)
			throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			// query =
			// " SELECT distinct d.division_office_code, d.division_office_name "
			// + " FROM ur_division_office_tbl d,rws_eoat_tbl e"
			// + " WHERE d.head_office_code ='"+headOfficeCode+"' "
			// + " AND d.circle_office_code = '"+circleOfficeCode+"'"
			// + " AND d.circle_office_code=e.circle_office_code and " +
			// " d.division_office_code=e.division_office_code ORDER BY d.division_office_name ";
			query = "select distinct division_office_code,division_office_name from  ur_division_office_tbl where circle_office_code='"
					+ circleOfficeCode + "' ";
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getSubdivisions4EOAT(String circleOfficeCode,
			String divisionOfficeCode) throws Exception {

		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			// query =
			// " SELECT distinct s.subdivision_office_code, s.subdivision_office_name "
			// + " FROM ur_subdivision_office_tbl s,rws_eoat_tbl e "
			// + " WHERE s.head_office_code = '"+headOfficeCode+"' "
			// + " AND s.circle_office_code = '"+circleOfficeCode+"' "
			// + " AND s.division_office_code = '"+divisionOfficeCode+"'"
			// +
			// " AND s.circle_office_code=e.circle_office_code and s.division_office_code=e.division_office_code and s.subdivision_office_code=e.subdivision_office_code"
			// + " ORDER BY s.subdivision_office_name ";
			query = "SELECT distinct subdivision_office_code,subdivision_office_name FROM ur_subdivision_office_tbl where circle_office_code = '"
					+ circleOfficeCode
					+ "' and division_office_code = '"
					+ divisionOfficeCode + "' ORDER BY subdivision_office_name";
			Debug.println(query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}

		return subdivisions;
	}

	public ArrayList getCircles4Employee(String headOfficeCode)
			throws Exception {
		ArrayList circles = new ArrayList();
		try {
			conn = getConn();
			query = "select distinct c.circle_office_code,c.circle_office_name from "
					+ "ur_circle_office_tbl c,rws_employee_tbl e where "
					+ "substr (e.office_code,2,2)=c.circle_office_code"
					+ " and c.head_office_code='"
					+ headOfficeCode
					+ "' order by c.circle_office_name";
			Debug.println(query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getCircles4Employee:" + e.getMessage());
		} finally {
			closeAll();
		}
		return circles;
	}

	public ArrayList getDivisions4Employee(String headOfficeCode,
			String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT distinct d.division_office_code,d.division_office_name FROM "
					+ "ur_division_office_tbl d,rws_employee_tbl e WHERE d.head_office_code ='"
					+ headOfficeCode
					+ "'"
					+ " AND d.circle_office_code ='"
					+ circleOfficeCode
					+ "' and substr(e.office_code,2,2)=d.circle_office_code "
					+ "and substr (e.office_code,4,1)=d.division_office_code ORDER BY division_office_name";
			Debug.println("query in getDivisions4Employee " + query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}
		return divisions;
	}

	public ArrayList getSubdivisions4Employee(String headOfficeCode,
			String circleOfficeCode, String divisionOfficeCode)
			throws Exception {
		ArrayList subdivisions = new ArrayList();
		try {
			conn = getConn();
			query = "SELECT distinct s.subdivision_office_code,s.subdivision_office_name FROM "
					+ "ur_subdivision_office_tbl s,rws_employee_tbl e WHERE"
					+ " s.head_office_code ='"
					+ headOfficeCode
					+ "' AND s.circle_office_code = '"
					+ circleOfficeCode
					+ "' "
					+ "AND s.division_office_code = '"
					+ divisionOfficeCode
					+ "' and "
					+ "substr (e.office_code,2,2) =s.circle_office_code and"
					+ " substr(e.office_code,4,1)=s.division_office_code and"
					+ " substr(e.office_code,5,2) =s.subdivision_office_code"
					+ " ORDER BY subdivision_office_name";
			Debug.println("query in SUBDIVISION:" + query);
			stat = conn.createStatement();
			rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		} finally {
			closeAll();
		}

		return subdivisions;
	}

	/*
	 * added by ramesh for LOC on 30/11/08
	 * 
	 * @author nic
	 * 
	 * TODO To change the template for this generated type comment go to Window
	 * - Preferences - Java - Code Style - Code Templates
	 */
	public ArrayList getAllDivisionsWithOfficeCode1(String district)
			throws Exception {
		ArrayList divisions = new ArrayList();
		try {
			conn = getConn();

			query = " SELECT circle_office_code,division_office_code, division_office_name FROM ur_division_office_tbl where CIRCLE_OFFICE_CODE ='"
					+ district + "' ORDER BY division_office_name ";
			// System.out.println("query in getDivisions*** "+query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			// stat = conn.createStatement();
			// rset = stat.executeQuery(query);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1" + rset.getString(1)
						+ rset.getString(2) + "00");
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + "1"
						+ rset.getString(1) + rset.getString(2) + "00");
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return divisions;

	}

	public String getAdminDate(String workId) throws Exception {
		String year = "";
		try {
			conn = getConn();

			query = "select to_char(admin_date,'yyyy') as fromDate FROM rws_work_admn_tbl where work_id = '"
					+ workId + "'";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();

			if (rset.next()) {
				String yearStart = rset.getString("fromDate");
				int yearTos = Integer.parseInt(yearStart);
				yearTos++;
				String yearTo = "" + yearTos;
				year = yearStart + "-" + yearTo;
			}
			// System.out.println("year::"+year);
		} catch (Exception e) {
			System.out.println("Exception in getAdmin Year is " + e);
		} finally {
			closeAll();
		}
		return year;
	}

	public ArrayList getDistrictsCodesNames() throws Exception {

		ArrayList dists = new ArrayList();
		try {
			conn = getConn();
			// System.out.println("conn OK");
			query = " SELECT dcode, dname " + " FROM ur_district_tbl " + "  "
					+ " ORDER BY dname";

			// stat = conn.createStatement();
			// System.out.println("query in getDistricts is "+query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			// rset = stat.executeQuery(query);
			int i = 0;
			while (rset.next()) {
				dists.add(i++, rset.getString(1) + rset.getString(2));
			}
		} catch (Exception e) {
			System.out
					.println("Exception in getDistricts with codes and names is: "
							+ e);
		} finally {
			closeAll();
		}

		return dists;
	}

	// code added on 29-03-2010 -by sridhar to retrieve mandals
	//

	public ArrayList getDivmandals(String circode, String divcode, String sdoc)
			throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = getConn();

			// Debug.println(" in if cir:" +circode+ "div:"+divcode+ " sdoc:"
			// +sdoc);

			query = "SELECT M.MNAME ,M.MCODE FROM urban_MANDAL_TBL M, urban_MANDAL_SUBDIVISION_TBL MM WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND ";
			if (circode != null && !circode.equals("")) {
				query += "MM.CIRCLE_OFFICE_CODE='" + circode + "'";
			}
			if (divcode != null && !divcode.equals("")) {
				query += " AND MM.DIVISION_OFFICE_CODE='" + divcode + "'";
			}
			if (sdoc != null && !sdoc.equals("") && !sdoc.equals("00")) {
				query += "AND MM.SUBDIVISION_OFFICE_CODE='" + sdoc + "'";
			}
			query += " ORDER BY M.MNAME";

			stat = conn.createStatement();
			Debug.println("query:" + query);
			rset = stat.executeQuery(query);
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - "
						+ rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("The error in getDivmandals()=== RwsLocations " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public static Connection getConn() {

		Connection conn2 = null;
		try {
			DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			/*	conn2 = DriverManager.getConnection(
				"jdbc:oracle:thin:@10.160.2.137:1521:wsoft", "aprwssuser",
				"aprwssuser");*/
			 conn2 = DriverManager.getConnection(
	 "jdbc:oracle:thin:@10.160.2.140:1521:wsoft", "aprwssuser",
	"aprwssuser");
			
//			conn2 = DriverManager.getConnection(
//					 "jdbc:oracle:thin:@10.160.0.20:1521:wsoft", "aprwssuser",
//					"aprwssuser");
			
		/*conn2 = DriverManager.getConnection(
				"jdbc:oracle:thin:@10.160.19.167:1521:orastg", "aprwssuser",
					"aprwssuser");*/
			
			
			
		} catch (SQLException e) {
			Debug.print(e.getMessage());
		}

		return conn2;

	}

	// code added by sridhar for displaying Indian Lakhs fromat
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
			// Debug.println("value1.1:"+stringValue);
			if (stringActValue.substring(0, 1).equals("-")) {
				stringValue = stringValue.substring(1, stringValue.length());
			}
			// Debug.println("value1:"+stringValue);
			// Seperating Integral and Fractional parts
			// Logic to insert comma(s)
			// Debug.println("value2:"+stringValue);
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
				// sb.insert(i+6, ',');
			}
			if (integralPart.length() > 8) {
				sb.insert(i, ',');
				sb.insert(i + 3, ',');
				sb.insert(i + 6, ',');
			}

			// Debug.println("value4:"+stringValue);
			sb = sb.reverse();
			integralPart = sb.toString();
			// Debug.println("integralPart:"+integralPart);
			if (integralPart.startsWith(",")) {
				integralPart = integralPart.substring(1);
			}
			// Combining Integral and Fractional parts
			stringValue = integralPart + "." + fractionalPart;
			if (stringActValue.substring(0, 1).equals("-")) {
				stringValue = "-" + stringValue;
			}
			// Returning the result
		} catch (Exception e) {
			e.printStackTrace();
		}
		// Debug.println("value2:"+stringValue);
		return stringValue;
	}

	/*
	 * static Connection conn2=null; public static Connection
	 * getConn(JDBCConnectionPool jc) { try {Debug.println(
	 * "in methodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"
	 * ); //Debug.println("JC in getconn:"+jcc); conn2 =
	 * (Connection)jc.checkOut();
	 * Debug.println("connection in get conn:"+conn2); } catch (Exception e) {
	 * // TODO Auto-generated catch block
	 * Debug.println("error in getConn() in RWSOffices:"+e.getMessage()); }
	 * return conn2; } public static void releaseConn(JDBCConnectionPool
	 * jcc1,Connection conns) { //Debug.println("JC in release conn:"+jcc1);
	 * Debug.println("conn2 in release connection:"+conns); jcc1.checkIn(conns);
	 * 
	 * }
	 */

	/*
	 * upto here added by ramesh
	 * 
	 * @author nic
	 * 
	 * TODO To change the template for this generated type co mment go to Window
	 * - Preferences - Java - Code Style - Code Templates
	 */
	public boolean encryptData(String passWord, String dataToBeEncrypt,
			String path, String dataFileName, String sigFileName,
			String pubKeyFileName) throws Exception {

		String configName = "C:\\a.cfg";
		boolean flag = false;
		try {
			// this.pkcs11Provider = new
			// sun.security.pkcs11.SunPKCS11(configName);
			// Security.addProvider(this.pkcs11Provider);

			char[] pinn = passWord.toCharArray();
			KeyStore ks = KeyStore.getInstance("PKCS11");
			try {
				ks.load(null, pinn);
			} catch (Exception e) {
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

			ObjectOutputStream os = new ObjectOutputStream(
					new FileOutputStream(path + "/" + sigFileName));
			os.writeObject(signature);
			os.flush();
			os.close();

			os = new ObjectOutputStream(new FileOutputStream(path + "/"
					+ pubKeyFileName));
			os.writeObject(publicKey);
			os.flush();
			os.close();

			Debug.println("data file path:" + path + dataFileName);
			Writer output = new BufferedWriter(new FileWriter(path + "/"
					+ dataFileName));
			Debug.println("dataToBeEncrypt:" + dataToBeEncrypt);
			output.write(dataToBeEncrypt);
			output.close();

			flag = true;
		} catch (Exception e) {
			flag = false;
			Debug.println("Exception Occured While Encrypting the Data:"
					+ e.getMessage());
			e.printStackTrace();
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

			}
		}
		return flag;
	}

	public boolean decryptData(String passWord, String path,
			String dataFileName, String sigFileName, String pubKeyFileName)
			throws Exception {

		String configName = "C:\\a.cfg";
		boolean flag = false;
		try {
			System.out.println("1");
			// this.pkcs11Provider = new
			// sun.security.pkcs11.SunPKCS11(configName);
			// Security.addProvider(this.pkcs11Provider);
			System.out.println("2");
			char[] pinn = passWord.toCharArray();
			KeyStore ks = KeyStore.getInstance("PKCS11");
			try {
				ks.load(null, pinn);
				System.out.println("3");
			} catch (Exception e) {
				System.out.println("Error:" + e.getMessage());
				return false;
			}
			System.out.println("4");
			KeyStore ks1 = KeyStore.getInstance("PKCS11");

			Provider p1 = ks1.getProvider();
			Signature sig1 = Signature.getInstance("SHA1withRSA", p1);
			System.out.println("5");
			BufferedReader br = new BufferedReader(new FileReader(path + "/"
					+ dataFileName));
			String strLine = "", strLine1 = "";
			String newLine = "\r\n";
			while ((strLine = br.readLine()) != null) {
				strLine1 += strLine;// .substring(0,strLine.length()-1);
				strLine1 += newLine;
			}
			System.out.println("6");
			strLine1 = strLine1.substring(0, strLine1.length() - 2);
			Debug.println("data:" + strLine1);
			byte[] data = strLine1.getBytes();

			ObjectInputStream is = new ObjectInputStream(new FileInputStream(
					path + "/" + sigFileName));
			byte[] readObj = (byte[]) is.readObject();

			ObjectInputStream is1 = new ObjectInputStream(new FileInputStream(
					path + "/" + pubKeyFileName));
			PublicKey pubbkey = (PublicKey) is1.readObject();

			System.out.println("7");
			sig1.initVerify(pubbkey);
			sig1.update(data);
			if (!sig1.verify(readObj)) {
				System.out.println("Signature verification failed.");
				flag = false;
			} else {
				System.out.println("Signature verification Sucesss");
				flag = true;
			}
			System.out.println("8");
		} catch (Exception e) {
			flag = false;
			Debug.println("Exception Occured While Encrypting the Data:"
					+ e.getMessage());
			e.printStackTrace();
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

			}
		}
		return flag;
	}

	public ArrayList getAllDivisions() {
		// TODO Auto-generated method stub
		return null;
	}

}
