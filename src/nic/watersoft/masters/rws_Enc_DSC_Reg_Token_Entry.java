package nic.watersoft.masters;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Enc_DSC_Reg_Token_Entry extends Action {

	private static final long serialVersionUID = 1L;

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Rws_ENC_Digital_Sign_Form token = (Rws_ENC_Digital_Sign_Form) form;
		String mode = token.getMode();

		if (!mode.isEmpty() && mode.equalsIgnoreCase("data")) {

			try {
				isEncCertificateExists(token);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			// reset(token);

		} else {
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("processCertificate")) {

			String base64value = token.getCertificate();

			base64value = base64value.trim();

			try {
				prepareX509Certificate(base64value, token);
			} catch (CertificateException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}

			mode = "data";
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("saveCert")) {
			try {
				if (isEncCertificateExists(token)) {
					request.setAttribute("message", "User Already Register");
				} else {
					saveENCDSCTokenCertificate(token, request);
					request.setAttribute("message",
							"User Register Successfully.!");
				}
			} catch (Exception e) {
				e.printStackTrace();

			}
		}

		return mapping.findForward(mode);
	}

	private void reset(Rws_ENC_Digital_Sign_Form frm) {
		frm.setEncName("");
		frm.setDesignation("");
		frm.setEeid("");
		frm.setValidFrom("");
		frm.setValidTo("");
		frm.setIssuer("");
		frm.setIssuerName("");

	}

	private void prepareX509Certificate(String base64value,
			Rws_ENC_Digital_Sign_Form bean) throws ParseException, IOException,
			CertificateException {
		byte[] certCont = new sun.misc.BASE64Decoder().decodeBuffer(base64value
				.trim());
		InputStream inStream = new ByteArrayInputStream(certCont);
		CertificateFactory cf = CertificateFactory.getInstance("X.509");

		java.security.cert.Certificate cert = cf.generateCertificate(inStream);
		X509Certificate x509certificate = (X509Certificate) cert;

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

	public int saveENCDSCTokenCertificate(Rws_ENC_Digital_Sign_Form token,
			HttpServletRequest request) {

		int rcount = 0;
		try {
			Connection conn = null;
			Statement stmt = null;
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String eename = request.getParameter("encName");
			String EECode = request.getParameter("eeid");
			String desig = request.getParameter("designation");
			String cert = request.getParameter("certificate");

			String query = "";
			query = "insert into rws_enc_ds_reg_tbl values('" + eename + "','"
					+ desig + "','" + EECode + "','" + cert + "',sysdate,'"
					+ token.getSerialNumber() + "')";

			//Debug.println("query is " + query);
			rcount = stmt.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 1;

	}

	public boolean isEncCertificateExists(Rws_ENC_Digital_Sign_Form frm)
			throws SQLException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select * from rws_enc_ds_reg_tbl where OFFICER_DESIGNATION='ENC'";
			//System.out.println("query  " + query);
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
				frm.setEncName(eename);
				frm.setDesignation(designation);
				frm.setEeid(eeid);
				frm.setIssuer(xCert.getIssuerDN().toString());
				frm.setIssuerName(xCert.getSubjectDN().toString());
				frm.setSerialNumber(xCert.getSerialNumber());

				Date todate = xCert.getNotAfter();
				Date fromdate = xCert.getNotBefore();

				SimpleDateFormat dateFormatter = new SimpleDateFormat(
						"dd/MM/yyyy");
				String validFrom = dateFormatter.format(fromdate);
				String validTo = dateFormatter.format(todate);

				frm.setValidFrom(validFrom);

				frm.setValidTo(validTo);
				inStream.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
