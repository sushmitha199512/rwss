package nic.watersoft.masters;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;

import org.apache.commons.codec.binary.Base64;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsContractorHashDAO {

	public void getContractorsListAdded(ArrayList cList,
			String circleOfficeCode, String divOfficeCode, Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();

			String query = "select distinct a.CONTRACTOR_CODE,nvl(a.CONTRACTOR_NAME_COMPANY,' '),nvl(a.CONTRACTOR_COMPANY_NAME1,' '),nvl(a.CONTRACTOR_COMPANY_NAME2,' ') ,c.IFSC_CODE,c.ACCOUNT_NO,d.BANK,a.HASH_VALUE  from rws_contractor_tbl a,rws_work_contractor_map_tbl b,rws_contractor_bank_lnk_tbl c,rws_bank_ifsc_code_tbl d ,rws_work_admn_tbl e where   a.CONTRACTOR_CODE=b.CONTRACTOR_CODE and c.CONTRACTOR_CODE=a.CONTRACTOR_CODE and d.IFSC_CODE=c.IFSC_CODE and c.IFSC_CODE is not null and c.ACCOUNT_NO is not null and b.work_id=e.work_id  and substr(e.office_code,2,2)='"
					+ circleOfficeCode
					+ "' and substr(e.office_code,4,1)= '"
					+ divOfficeCode + "' order by 1";
			System.out.println("Query:" + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				RwsContractorRecord rwsContractorRecord = new RwsContractorRecord();

				rwsContractorRecord.setContractorCode(rs.getString(1));
				rwsContractorRecord.setContractorName(rs.getString(2)
						+ rs.getString(3) + rs.getString(4));
				rwsContractorRecord.setIfscCode(rs.getString(5));
				rwsContractorRecord.setAccountNo(rs.getString(6));
				rwsContractorRecord.setBankName(rs.getString(7));

				String contractorDetails = rwsContractorRecord
						.getContractorCode()
						+ rwsContractorRecord.getContractorName()
						+ rwsContractorRecord.getBankName()
						+ rwsContractorRecord.getIfscCode()
						+ rwsContractorRecord.getAccountNo();

				String cDetails = getContractorEncodedValue(contractorDetails);
				if (rs.getString(8) != null && cDetails != null
						&& !cDetails.equals(rs.getString(8))) {
					rwsContractorRecord.setRecordCorrupted("yes");
					System.out.println("Corrupted");
					cList.add(rwsContractorRecord);
					continue;

				} else if (cDetails.equals(rs.getString(8))) {
					rwsContractorRecord.setRecordCorrupted("no");
					System.out.println("No");
					continue;
				}

				cList.add(rwsContractorRecord);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	public ArrayList getContractorsList(String circleOfficeCode,
			String divOfficeCode) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList cList = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			String query = "select distinct a.CONTRACTOR_CODE,nvl(a.CONTRACTOR_NAME_COMPANY,' '),nvl(a.CONTRACTOR_COMPANY_NAME1,' '),nvl(a.CONTRACTOR_COMPANY_NAME2,' ') ,c.IFSC_CODE,c.ACCOUNT_NO,d.BANK,a.HASH_VALUE,b.work_id,e.work_name   from rws_contractor_tbl a,rws_contractor_selection_tbl b,rws_contractor_bank_lnk_tbl c,rws_bank_ifsc_code_tbl d ,rws_work_admn_tbl e where  a.CONTRACTOR_CODE=b.CONTRACTOR_CODE and c.CONTRACTOR_CODE=a.CONTRACTOR_CODE and d.IFSC_CODE=c.IFSC_CODE and c.IFSC_CODE is not null and c.ACCOUNT_NO is not null and b.work_id=e.work_id  and substr(e.office_code,2,2)='"
					+ circleOfficeCode
					+ "' and substr(e.office_code,4,1)= '"
					+ divOfficeCode + "' order by 1";
			System.out.println("Query:" + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				RwsContractorRecord rwsContractorRecord = new RwsContractorRecord();

				rwsContractorRecord.setContractorCode(rs.getString(1));
				rwsContractorRecord.setContractorName(rs.getString(2)
						+ rs.getString(3) + rs.getString(4));
				rwsContractorRecord.setIfscCode(rs.getString(5));
				rwsContractorRecord.setAccountNo(rs.getString(6));
				rwsContractorRecord.setBankName(rs.getString(7));

				String contractorDetails = rwsContractorRecord
						.getContractorCode()
						+ rwsContractorRecord.getContractorName()
						+ rwsContractorRecord.getBankName()
						+ rwsContractorRecord.getIfscCode()
						+ rwsContractorRecord.getAccountNo();

				String cDetails = getContractorEncodedValue(contractorDetails);
				if (rs.getString(8) != null && cDetails != null
						&& !cDetails.equals(rs.getString(8))) {
					rwsContractorRecord.setRecordCorrupted("yes");
					System.out.println("Corrupted");
					cList.add(rwsContractorRecord);
					continue;

				} else if (cDetails.equals(rs.getString(8))) {
					rwsContractorRecord.setRecordCorrupted("no");
					System.out.println("No");
					continue;
				}
				
				rwsContractorRecord.setWorkId(rs.getString(9));
				rwsContractorRecord.setWorkName(rs.getString(10));

				cList.add(rwsContractorRecord);

			}

			getContractorsListAdded(cList, circleOfficeCode, divOfficeCode,
					conn);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return cList;
	}

	public void approveContractor(RwsContractorHashActionForm rActionForm,
			HttpServletRequest request) {

		Connection conn = null;
		Statement stmt = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String query = "";
			int recordCount = 0;

			if (rActionForm.getcList() != null) {
				for (int i = 0; i < rActionForm.getcList().size(); i++) {
					RwsContractorRecord rwsContractorRecord = (RwsContractorRecord) rActionForm
							.getcList().get(i);

					if (rwsContractorRecord.getChecks() != null
							&& rwsContractorRecord.getChecks().equals("on")) {
						recordCount++;

						String contractorDetails = rwsContractorRecord
								.getContractorCode()
								+ rwsContractorRecord.getContractorName()
								+ rwsContractorRecord.getBankName()
								+ rwsContractorRecord.getIfscCode()
								+ rwsContractorRecord.getAccountNo();

						String hashValue = getContractorEncodedValue(contractorDetails);

						query = "update rws_contractor_tbl set HASH_VALUE='"
								+ hashValue + "' where contractor_code='"
								+ rwsContractorRecord.getContractorCode() + "'";
						System.out.println("query:" + query);
						stmt.addBatch(query);
					}

				} // end for loop

				int res[] = stmt.executeBatch();
				if (res.length == recordCount) {
					conn.commit();
					conn.setAutoCommit(true);
					request.setAttribute("message", "Approved Successfully");
				}

			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {

			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * Encoded the details of all contractors by Base64
	 * 
	 * @param contractorDetails
	 * @return
	 */
	public String getContractorEncodedValue(String contractorDetails) {

		byte[] encoded = Base64.encodeBase64(contractorDetails.getBytes());
		return new String(encoded);
	}

	/**
	 * Process the
	 * 
	 * @param contractorDetails
	 * @return
	 */
	public String getContractorDecodedValue(String contractorDetails) {

		byte[] decoded = Base64.decodeBase64(contractorDetails);
		return new String(decoded);
	}

	public static void main(String[] args) {
		String orig = "original String before base64 encoding in Java";

		// encoding byte array into base 64
		byte[] encoded = Base64.encodeBase64(orig.getBytes());

		System.out.println("Original String: " + orig);
		System.out.println("Base64 Encoded String : " + new String(encoded));

		// decoding byte array into base64
		byte[] decoded = Base64.decodeBase64(encoded);
		System.out.println("Base 64 Decoded  String : " + new String(decoded));

		BASE64Encoder base64Encoder = new BASE64Encoder();
		String res = base64Encoder.encode("sai prasad".getBytes());
		System.out.println("Result:" + res);
		BASE64Decoder base64Decoder = new BASE64Decoder();
		try {
			System.out.println("After:" + base64Decoder.decodeBuffer(res));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
