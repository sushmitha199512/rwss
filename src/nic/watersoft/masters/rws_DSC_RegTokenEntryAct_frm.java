package nic.watersoft.masters;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import nic.watersoft.masters.DSCRegTokenAction.DocumentSignException;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_DSC_RegTokenEntryAct_frm extends Action {

	private static final long serialVersionUID = 1L;
	private HttpServletRequest request;

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DSCRegToken token = (DSCRegToken) form;
		String mode = token.getMode();

		if (!mode.isEmpty() && mode.equalsIgnoreCase("processCertificate")) {
			// System.out.println("Certificate:123343" +
			// token.getCertificate());

			try {
				prepareX509Certificate(token.getCertificate(), token);
			} catch (CertificateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			mode = "load";
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("Save")) {
			try {
				processRequest(request, response);
			} catch (DocumentSignException e) {

				e.printStackTrace();
			}
		} else {
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("eepao")) {
			try {
				reset(request, token);
				loadEEDSRegFormDetails(token, request);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("sign")) {

			try {
				if (isCertificateExists(token, request)) {
					request.setAttribute("message", "User Already Register.");
				} else {
					saveEEDSCTokenCertificate(token, request);
				}
			} catch (Exception e) {

				e.printStackTrace();

			}
		}
		if (!mode.isEmpty() && mode.equalsIgnoreCase("view")) {
			try {
				existsRegTokenDetails(token, request);
			} catch (CertificateException e) {
				e.printStackTrace();
			}
		} else {
		}
		if (!mode.isEmpty() && mode.equalsIgnoreCase("load")) {
			try {
				existsRegTokenDetails(token, request);
			} catch (CertificateException e) {
				e.printStackTrace();
			}
		} else {
		}
		if (!mode.isEmpty() && mode.equalsIgnoreCase("encRegToken")) {
			try {
				/*
				 * if(){ } else{ existsEncRegTokenDetails(token, request); }
				 */
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("encsign")) {
			try {
				if (isEncCertificateExists(token)) {
					request.setAttribute("message",
							"User Already Register.See your details.!");
				} else {
					processRequest(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();

			}
		} else {
		}

		if (!mode.isEmpty() && mode.equalsIgnoreCase("viewEnc")) {
			try {
				existsEncRegTokenDetails(token);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
		}

		return mapping.findForward(mode);

	}

	private void reset(HttpServletRequest request2, DSCRegToken token) {
		token.setValidFrom("");
		token.setValidTo("");
		token.setIssuer("");
		token.setIssuerName("");
		token.setCertificate("");
		token.setIsRegistered("");
		token.setCircleName("");
		token.setCircleOffice("");
		token.setDivisionName("");
		token.setDivisionOffice("");
	}

	private void prepareX509Certificate(String base64value, DSCRegToken token)
			throws ParseException, IOException, CertificateException {

		byte[] certCont = new sun.misc.BASE64Decoder().decodeBuffer(base64value
				.trim());
		InputStream inStream = new ByteArrayInputStream(certCont);
		CertificateFactory cf = CertificateFactory.getInstance("X.509");

		java.security.cert.Certificate cert = cf.generateCertificate(inStream);
		X509Certificate xCert = (X509Certificate) cert;
		// System.out.println("Certificate Type: " + cf.getType());
		// System.out.println("Public Key: \n" + cert.getPublicKey());
		try {
			// System.out.println("Signature Algorithm -- >"+
			// xCert.getSigAlgName());
			// System.out.println("IssuerDN :---> " + xCert.getIssuerDN());
			// System.out.println("Serial Number : --> "+
			// xCert.getSerialNumber());
			// System.out.println("SubjectDN : " + xCert.getSubjectDN());
			// System.out.println("Validity  To - - ->"+ xCert.getNotAfter());
			// System.out.println("Validity FROM  - - ->"+
			// xCert.getNotBefore());
		} catch (Exception exp) {
			exp.printStackTrace();
		}

		Date todate = xCert.getNotAfter();
		Date fromdate = xCert.getNotBefore();

		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String validFrom = dateFormatter.format(fromdate);
		String validTo = dateFormatter.format(todate);

		token.setValidFrom(validFrom);

		token.setValidTo(validTo);
		token.setIssuer(xCert.getIssuerDN().toString());
		token.setIssuerName(xCert.getSubjectDN().toString());
		token.setSerialNumber(xCert.getSerialNumber());

		inStream.close();

	}

	public int saveEEDSCTokenCertificate(DSCRegToken token,
			HttpServletRequest request) {

		int rcount = 0;
		try {
			Connection conn = null;
			Statement stmt = null;
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String EECode = request.getParameter("paoCode");
			String cert = token.getCertificate();
			// cert=cert.trim();
			// cert=cert.replace("\n", "");
			// cert=cert.replace("\r", "");

			String query = "";

			query = "insert into RWS_EE_DS_REG_TBL values(1,'"
					+ token.getCircleName() + "','" + token.getDivisionName()
					+ "','" + EECode + "','" + cert + "',sysdate,'','"
					+ token.getSerialNumber() + "')";

			Debug.println("query is " + query);
			rcount = stmt.executeUpdate(query);
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("exxxxx- - ->" + e);
		}
		request.setAttribute("message", "Saved Successfully");

		return 1;

	}

	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException,

	IOException, DocumentSignException {

		PrintWriter out = response.getWriter();
		try {
			String pinValue = request.getParameter("tokenPwd");
			String circleOffice = request.getParameter("circleOffice");
			String divisionOffice = request.getParameter("divisionOffice");
			String paoCode = request.getParameter("paoCode");
			String eeName = request.getParameter("eeName");
			String encName = request.getParameter("encName");
			String dateofPresent = request.getParameter("dateofPresent");
			String input = circleOffice + divisionOffice + paoCode + encName
					+ dateofPresent;

			// System.out.println("ee - - ->" + encName);
			// System.out.println("pin value :" + pinValue);

			DSCRegTokenAction ds = new DSCRegTokenAction();
			ds.init();
			ds.start();
			String data = ds.signFilefromJS(pinValue, input, request, paoCode);

			if (data != null) {
				// out.println("success");
				request.setAttribute("message", "Saved Successfully");
			} else {
				// out.println("failure");
				request.setAttribute("message", "Failed Operation.");
			}

		} catch (IOException ex) {
			System.out.println("error 11:" + ex.getMessage());
		}

		catch (DocumentSignException e) {
			e.printStackTrace();
		}

	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside get method servlet");
		try {
			processRequest(request, response);
		} catch (DocumentSignException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside post");
		try {
			processRequest(request, response);
		} catch (DocumentSignException e) {
			e.printStackTrace();
		}
	}

	public String getServletInfo() {
		return "Short description";
	}

	public void existsRegTokenDetails(DSCRegToken frm,
			HttpServletRequest request) throws IOException,
			CertificateException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String userId = (String) request.getSession()
					.getAttribute("userId");
			String circle = userId.substring(1, 3);
			String divCode = userId.substring(3, 4);

			query = "select certificate from rws_ee_ds_reg_tbl where pao_code='"
					+ frm.getPaoCode()
					+ "' and CIRCLE_OFFICE_CODE='"
					+ circle
					+ "' and DIVISION_OFFICE_CODE='" + divCode + "'";

			rs = stmt.executeQuery(query);
			while (rs.next()) {

				String certi = rs.getString(1);
				byte[] certCont = new sun.misc.BASE64Decoder()
						.decodeBuffer(certi.trim());
				InputStream inStream = new ByteArrayInputStream(certCont);
				CertificateFactory cf = CertificateFactory.getInstance("X.509");

				java.security.cert.Certificate cert = cf
						.generateCertificate(inStream);
				X509Certificate xCert = (X509Certificate) cert;
				// System.out.println("Certificate Type: " + cf.getType());
				// System.out.println("Public Key: \n" + cert.getPublicKey());
				try {
					// System.out.println("Signature Algorithm -- >"
					// + xCert.getSigAlgName());
					// System.out.println("IssuerDN :---> " +
					// xCert.getIssuerDN());
					// System.out.println("Serial Number : --> "
					// + xCert.getSerialNumber());
					// System.out.println("SubjectDN : " +
					// xCert.getSubjectDN());
					// System.out.println("Validity  To - - ->"
					// + xCert.getNotAfter());
					// System.out.println("Validity FROM  - - ->"
					// + xCert.getNotBefore());
				} catch (Exception exp) {
					exp.printStackTrace();
				}
				frm.setIssuer(xCert.getIssuerDN().toString());
				frm.setIssuerName(xCert.getSubjectDN().toString());
				frm.setSerialNumber(xCert.getSerialNumber());
				frm.setValidFrom(xCert.getNotBefore().toString());
				frm.setValidTo(xCert.getNotAfter().toString());
				inStream.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void loadEEDSRegFormDetails(DSCRegToken bean,
			HttpServletRequest request) throws SQLException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String userId = (String) request.getSession()
					.getAttribute("userId");
			String circle = userId.substring(1, 3);
			String divCode = userId.substring(3, 4);

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "select CIRCLE_OFFICE_NAME , DIVISION_OFFICE_NAME , PAO_CODE , EE_NAME , DOJ_IN_PRESENT_POST , a.circle_office_code , c.division_office_code from "
					+ " rws_division_office_tbl b , rws_circle_office_tbl a , rws_ee_ds_tbl c where "
					+ " a.circle_office_code=b.circle_office_code and c.circle_office_code=a.circle_office_code "
					+ " and c.division_office_code=b.division_office_code  and c.circle_office_code='"
					+ circle + "' and c.division_office_code='" + divCode + "'";

			rs = stmt.executeQuery(query);
			while (rs.next()) {
				bean.setCircleOffice(rs.getString(1));
				bean.setDivisionOffice(rs.getString(2));
				bean.setPaoCode(rs.getString(3));
				bean.setEeName(rs.getString(4));
				bean.setDateofPresent(rs.getString(5));
				bean.setCircleName(rs.getString(6));
				bean.setDivisionName(rs.getString(7));

			}
			try {
				existsEncRegTokenDetails(bean);
			} catch (CertificateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		finally {
			conn.close();
		}

	}

	public boolean isCertificateExists(DSCRegToken bean,
			HttpServletRequest request) throws SQLException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String userId = (String) request.getSession()
					.getAttribute("userId");
			String circle = userId.substring(1, 3);
			String divCode = userId.substring(3, 4);
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select certificate from rws_ee_ds_reg_tbl where pao_code='"
					+ bean.getPaoCode()
					+ "' and CIRCLE_OFFICE_CODE='"
					+ circle
					+ "' and DIVISION_OFFICE_CODE='" + divCode + "'";

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

	public boolean isEncCertificateExists(DSCRegToken bean) throws SQLException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			System.out.println("bean.getPaoCode()---- " + bean.getPaoCode());
			query = "select certificate from rws_enc_ds_reg_tbl where pao_code='"
					+ bean.getPaoCode() + "'";

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

	public void existsEncRegTokenDetails(DSCRegToken frm) throws IOException,
			CertificateException {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select certificate from rws_ee_ds_reg_tbl where pao_code='"
					+ frm.getPaoCode() + "'";
			System.out.println("query  " + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				frm.setIsRegistered("yes");
				// String encName = rs.getString(1);
				// String paoCode = rs.getString(2);
				String certi = rs.getString(1);
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
				// frm.setEncName(encName);
				// frm.setPaoCode(paoCode);
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

	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}