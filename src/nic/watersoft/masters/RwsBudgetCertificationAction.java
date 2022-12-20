package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.RwsDigitalSignatureToken;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsBudgetCertificationAction extends Action {

	public static final String VIEW = "view";

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RwsBudgetCertificationBean rwsBudgetCertificationBean = (RwsBudgetCertificationBean) form;

		String mode = request.getParameter("mode");

		if (mode != null && mode.equals("init")) {
			reset(rwsBudgetCertificationBean);
		}

		if (mode != null && mode.equals("verify")) {

			verifyCertificate(rwsBudgetCertificationBean, request);

		}
		return mapping.findForward(VIEW);
	}

	private void reset(RwsBudgetCertificationBean rwsBudgetCertificationBean) {
		rwsBudgetCertificationBean.setIsAuthorize("");
		rwsBudgetCertificationBean.setCertificate("");

	}

	private void verifyCertificate(
			RwsBudgetCertificationBean rwsBudgetCertificationBean,
			HttpServletRequest request) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = RwsOffices.getConn();
		try {
			stmt = conn.createStatement();

			String query = "select certificate from rws_enc_ds_reg_tbl where OFFICER_DESIGNATION='EE-Budget'";

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				String certificate = rs.getString(1);
				if (certificate != null
						&& certificate.equals(rwsBudgetCertificationBean
								.getCertificate())) {
					rwsBudgetCertificationBean.setIsAuthorize("yes");
					RwsDigitalSignatureToken rDigitalSignatureToken = new RwsDigitalSignatureToken();
					RwsUtils.prepareX509Certificate(rwsBudgetCertificationBean
							.getCertificate(), rDigitalSignatureToken);
					rwsBudgetCertificationBean
							.setTokenSLNO(rDigitalSignatureToken
									.getSerialNumber().toString());

					request
							.setAttribute("message",
									"Audhendicated Successfully. Now you can Forward the Bills to ENC.");
				} else {
					request.setAttribute("message", "Audhendication Failed. ");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
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
}
