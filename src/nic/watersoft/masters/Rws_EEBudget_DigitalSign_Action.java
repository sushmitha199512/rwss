package nic.watersoft.masters;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_EEBudget_DigitalSign_Action extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		Rws_EE_Budget_DigitalSign_Form frm = (Rws_EE_Budget_DigitalSign_Form) form;
		String mode = frm.getMode();
		if (mode != null && mode.equals("certpage")) {
			System.out.println("EE Budget Page");
			reset(frm);
			existsEEBudgetDigitalDetails(frm);
		} else {
		}
		if (!mode.isEmpty() && mode.equalsIgnoreCase("processCertificate")) {
			String base64value = frm.getCertificate();

			try {
				prepareX509Certificate(base64value, frm);
				// request.setAttribute("message","Saved Successfully");
			} catch (CertificateException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			mode = "certpage";
		}
		if (mode != null && mode.equals("saveCert")) {
			try {
				if (isEEBudgetCertificateExists(frm, request)) {
					request.setAttribute("message", "User Already Register");
				} else {
					saveEEBudgetDigitalCertificate(frm, request);
					request.setAttribute("message", "Saved Successfully");
				}
			} catch (Exception e) {

				e.printStackTrace();

			}
		}

		Debug.println("Returning Mode:" + mode);
		return mapping.findForward(mode);

	}

	private void reset(Rws_EE_Budget_DigitalSign_Form frm) {
		frm.setEename("");
		frm.setDesignation("");
		frm.setEeid("");
		frm.setValidFrom("");
		frm.setValidTo("");
		frm.setIssuer("");
		frm.setIssuerName("");

	}

	private void prepareX509Certificate(String base64value,
			Rws_EE_Budget_DigitalSign_Form bean) throws ParseException,
			IOException, CertificateException {
		byte[] certCont = new sun.misc.BASE64Decoder().decodeBuffer(base64value
				.trim());
		InputStream inStream = new ByteArrayInputStream(certCont);
		CertificateFactory cf = CertificateFactory.getInstance("X.509");

		java.security.cert.Certificate cert = cf.generateCertificate(inStream);
		X509Certificate x509certificate = (X509Certificate) cert;
		System.out.println("Certificate Type: " + cf.getType());
		System.out.println("Public Key: \n" + cert.getPublicKey());
		try {
			System.out.println("Signature Algorithm -- >"
					+ x509certificate.getSigAlgName());
			System.out.println("IssuerDN :---> "
					+ x509certificate.getIssuerDN());
			System.out.println("Serial Number : --> "
					+ x509certificate.getSerialNumber());
			System.out.println("SubjectDN : " + x509certificate.getSubjectDN());
			System.out.println("Validity  To - - ->"
					+ x509certificate.getNotAfter());
			System.out.println("Validity FROM  - - ->"
					+ x509certificate.getNotBefore());
		} catch (Exception exp) {
			exp.printStackTrace();
		}
		bean.setIssuer(x509certificate.getIssuerDN().toString());
		bean.setIssuerName(x509certificate.getSubjectDN().toString());

		Date todate = x509certificate.getNotAfter();
		Date fromdate = x509certificate.getNotBefore();

		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String validFrom = dateFormatter.format(fromdate);
		String validTo = dateFormatter.format(todate);

		bean.setValidFrom(validFrom);
		bean.setSerialNumber(x509certificate.getSerialNumber());

		bean.setValidTo(validTo);
		inStream.close();

	}

	public int saveEEBudgetDigitalCertificate(
			Rws_EE_Budget_DigitalSign_Form token, HttpServletRequest request) {

		int rcount = 0;
		try {
			Connection conn = null;
			Statement stmt = null;
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String eename = request.getParameter("eename");
			String EECode = request.getParameter("eeid");
			String desig = request.getParameter("designation");
			String cert = request.getParameter("certificate");

			String query = "";
			query = "insert into rws_enc_ds_reg_tbl values(?,?,?,?,sysdate,?'"+token.getSerialNumber()+"')";

			Debug.println("query is " + query);
			PreparedStatement ps=conn.prepareStatement(query);
		    ps.setString(1,eename);
		    ps.setString(2, desig);
		    ps.setString(3, EECode);
		    ps.setString(4, cert);
			rcount = ps.executeUpdate();
			if (rcount > 0) {
				request.setAttribute("message", "Saved Successfully");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("exxxxx- - ->" + e);
		}
		return 1;

	}

	public boolean isEEBudgetCertificateExists(
			Rws_EE_Budget_DigitalSign_Form bean, HttpServletRequest request)
			throws SQLException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select certificate from rws_enc_ds_reg_tbl where pao_code='"
					+ bean.getEeid() + "'";

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		}

		finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}

	public void existsEEBudgetDigitalDetails(Rws_EE_Budget_DigitalSign_Form frm) {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select * from rws_enc_ds_reg_tbl where OFFICER_DESIGNATION='EE-Budget'";
			System.out.println("query  " + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				String eename = rs.getString(1);
				String designation = rs.getString(2);
				String eeid = rs.getString(3);
				String certi = rs.getString(4);

				byte[] certCont = new sun.misc.BASE64Decoder()
						.decodeBuffer(certi.trim());
				InputStream inStream = new ByteArrayInputStream(certCont);
				CertificateFactory cf = CertificateFactory.getInstance("X.509");

				java.security.cert.Certificate cert = cf
						.generateCertificate(inStream);
				X509Certificate xCert = (X509Certificate) cert;
				System.out.println("Certificate Type: " + cf.getType());
				System.out.println("Public Key: \n" + cert.getPublicKey());
				try {
					System.out.println("Signature Algorithm -- >"
							+ xCert.getSigAlgName());
					System.out.println("IssuerDN :---> " + xCert.getIssuerDN());
					System.out.println("Serial Number : --> "
							+ xCert.getSerialNumber());
					System.out.println("SubjectDN : " + xCert.getSubjectDN());
					System.out.println("Validity  To - - ->"
							+ xCert.getNotAfter());
					System.out.println("Validity FROM  - - ->"
							+ xCert.getNotBefore());
				} catch (Exception exp) {
					exp.printStackTrace();
				}
				frm.setEename(eename);
				frm.setDesignation(designation);
				frm.setEeid(eeid);
				frm.setIssuer(xCert.getIssuerDN().toString());
				frm.setIssuerName(xCert.getSubjectDN().toString());
				frm.setSerialNumber(xCert.getSerialNumber());
				
				
				Date todate = xCert.getNotAfter();
				Date fromdate = xCert.getNotBefore();

				SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
				String validFrom = dateFormatter.format(fromdate);
				String validTo = dateFormatter.format(todate);

				frm.setValidFrom(validFrom);

				frm.setValidTo(validTo);
				inStream.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
