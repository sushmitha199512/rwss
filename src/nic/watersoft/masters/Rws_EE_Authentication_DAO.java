/*
 * Created on 27-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import nic.watersoft.commons.RwsOffices;

/**
 * @author Sai Prasad N
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_EE_Authentication_DAO {

	public ArrayList getEEList() {
		ArrayList eeList = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String selectQuery = "select b.circle_office_name,c.division_office_name,a.CERTIFICATE,ee.ee_name,ee.PAO_CODE,to_char(EE_BUDGET_APPROVE_DATE,'dd/mm/yy')  from RWS_EE_DS_TBL ee,RWS_EE_DS_REG_TBL a,rws_circle_office_tbl b,rws_division_office_tbl c where a.circle_office_code=b.circle_office_code and c.circle_office_code=b.circle_office_code and c.division_office_code=a.division_office_code and ee.pao_code=a.pao_code";
			rs = stmt.executeQuery(selectQuery);
			while (rs.next()) {

				RwsEERecord record = new RwsEERecord();
				record.setCirlceName(rs.getString(1));
				record.setDivName(rs.getString(2));
				String certificate = rs.getString(3).trim();
				record.setEeName(rs.getString(4));
				record.setEePaoCode(rs.getString(5));
				if (rs.getString(6) != null && !rs.getString(6).equals("null") ) {
					record.setChecks("on");
					record.setApprovedOn(rs.getString(6));
				}
				
				byte[] certCont = new sun.misc.BASE64Decoder()
				.decodeBuffer(certificate.trim());
		InputStream inStream = new ByteArrayInputStream(certCont);
		CertificateFactory cf = CertificateFactory.getInstance("X.509");

		java.security.cert.Certificate cert = cf
				.generateCertificate(inStream);
		X509Certificate x509certificate = (X509Certificate) cert;
				
				Date todate = x509certificate.getNotAfter();
				Date fromdate = x509certificate.getNotBefore();

				SimpleDateFormat dateFormatter = new SimpleDateFormat(
						"dd/MM/yyyy");
				String validFrom = dateFormatter.format(fromdate);
				String validTo = dateFormatter.format(todate);

				record.setValidFrom(validFrom);

				record.setValidTo(validTo);
				record.setTokenSerailNo(x509certificate.getSerialNumber().toString());
				record.setTokenHolder(x509certificate.getSubjectDN().toString());

				//System.out.println("Certificate Type: " + cf.getType());
				System.out.println("Public Key: \n" + x509certificate.getPublicKey());
				record.setPublicKey(x509certificate.getPublicKey().toString());
				record.setAlgorithmType(x509certificate.getSigAlgName());
				record.setIssuer(x509certificate.getIssuerDN().toString());

				eeList.add(record);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return eeList;

	}

	public int[] saveAutheticatedEEs(String[] eeids,
			Rws_EE_Authentication_Form frm) throws Exception {
		int count[] = {};
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			Statement pstmt = conn.createStatement();
			int i = 0;
			System.out.println("Length:" + eeids.length);

			for (i = 0; i < eeids.length; i++) {
				pstmt
						.addBatch("update  RWS_EE_DS_REG_TBL set EE_BUDGET_APPROVE_DATE=sysdate where  pao_code='"
								+ eeids[i] + "'");
			}
			count = pstmt.executeBatch();
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;

	}

}
