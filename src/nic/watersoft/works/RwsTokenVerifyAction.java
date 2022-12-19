package nic.watersoft.works;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.cert.CertificateException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsDigitalSignatureToken;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.works.RwsTokenVerifyApplet.DocumentSignException;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsTokenVerifyAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("anu in action");
		RwsTokenVerifyActionForm rwsTokenVerifyActionForm = (RwsTokenVerifyActionForm) form;
		String mode = request.getParameter("mode");
		System.out.println("anu in action mode"+mode);
		String mode1 = request.getParameter("mode1");
		System.out.println("anu in action mod1"+mode1);

		// if(mode1!=null && mode1.equals("init")){
		// reset(rwsTokenVerifyActionForm);
		// }

		if (mode != null && mode.equals("processToken")) {

			processRequest(request, response, rwsTokenVerifyActionForm);
			mode = "data";
		}
		if (mode != null && mode.equals("save")) {
			// mode = "data";

		}
		if (mode != null && mode.equals("init")) {
			reset(rwsTokenVerifyActionForm);

		}

		return mapping.findForward(mode);
	}

	private void reset(RwsTokenVerifyActionForm rwsTokenVerifyActionForm) {
		rwsTokenVerifyActionForm.setIsEEDSCSigned("no");
		rwsTokenVerifyActionForm.setErrorMesg("");
		rwsTokenVerifyActionForm.setCertificate("");

	}

	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response,
			RwsTokenVerifyActionForm rwsTokenVerifyActionForm)
			throws ServletException, IOException, DocumentSignException {

		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();

		nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session
				.getAttribute("RWS_USER");
		String userid = users.getUserId();
		System.out.println("userid"+userid);
		String ccode = userid.substring(1, 3);

		String divCode = userid.substring(3, 4);

		System.out.println("certificate:"
				+ rwsTokenVerifyActionForm.getCertificate());

		String data = verifyCertificate(rwsTokenVerifyActionForm
				.getCertificate(), ccode, divCode);
		if (data != null && data.equals("success")) {

			try {
				RwsDigitalSignatureToken rDigitalSignatureToken = new RwsDigitalSignatureToken();
				RwsUtils.prepareX509Certificate(rwsTokenVerifyActionForm
						.getCertificate(), rDigitalSignatureToken);

				rwsTokenVerifyActionForm.setTokenSLNO(rDigitalSignatureToken
						.getSerialNumber().toString());

			} catch (CertificateException e) {
				e.printStackTrace();
			} catch (ParseException e) {
				e.printStackTrace();
			}
			rwsTokenVerifyActionForm.setIsEEDSCSigned("yes");
			// out.println("success");
			request
					.setAttribute("message",
							"Authendicated Successfully.Now You can Continue to forward the bills.");

		} else {
			request.setAttribute("message", data);
			rwsTokenVerifyActionForm.setIsEEDSCSigned("no");
			// out.println("failure");
		}

	}

	private String verifyCertificate(String rcertificate, String ccode,
			String divCode) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = RwsOffices.getConn();
		try {
			stmt = conn.createStatement();

			String query = "select certificate from rws_ee_ds_reg_tbl  a, rws_ee_ds_tbl b where a.circle_office_code=b.circle_office_code and a.division_office_code=b.division_office_code and a.pao_code=b.pao_code and  b.circle_office_code='"
					+ ccode
					+ "' and b.DIVISION_OFFICE_CODE='"
					+ divCode
					+ "' and a.EE_BUDGET_APPROVE_DATE is not null";

			 System.out.println("Digitall Signed Query:" + query);
			rs = stmt.executeQuery(query);
			if (rs.next()) {
				String certificate = rs.getString(1);
				if (certificate != null && certificate.equals(rcertificate)) {
					return "success";
				} else {
					return "Audhendication Failed.";
				}

			} else {
				return "EE-Budget Not Approved Or EE Not Yet Register.";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside get method servlet");
		try {
			processRequest(request, response, null);
		} catch (DocumentSignException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("inside post");
		try {
			processRequest(request, response, null);
		} catch (DocumentSignException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getServletInfo() {
		return "Short description";
	}

}
