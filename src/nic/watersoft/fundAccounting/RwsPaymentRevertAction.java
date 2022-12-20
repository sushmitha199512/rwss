package nic.watersoft.fundAccounting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPaymentRevertAction extends Action {

	public static final String TX_BANK = "1";
	public static final String TX_PAO = "2";
	public static final String TX_FORWARD_PAO = "3"; // for central transactions paid through PAO and not bank
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expired");
		}
		if (user != null && !user.getUserId().equals("ENC")) {
			return mapping.findForward("invalid");
		}
		String ipAddress = request.getRemoteAddr();
		/*String reqFilePath = request.getRealPath("");*/

		session = request.getSession();
		RwsPaymentRevertActionForm rwsPaymentRevertActionForm = (RwsPaymentRevertActionForm) form;
		RwsPaymentRevertDAO rwsPaymentRevertDAO = new RwsPaymentRevertDAO();

		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("init")) {

		}
		if (mode != null && mode.equals("txDates")) {
			reset(rwsPaymentRevertActionForm, session);
			session.setAttribute("txDates",
					rwsPaymentRevertDAO.getTxDates(rwsPaymentRevertActionForm));
		}
		if (mode != null && mode.equals("txIds")) {
			reset(rwsPaymentRevertActionForm, session);
			session.setAttribute("txIds",
					rwsPaymentRevertDAO.getTxIds(rwsPaymentRevertActionForm));
		}
		if (mode != null && mode.equals("txDetails")) {
			reset(rwsPaymentRevertActionForm, session);
			rwsPaymentRevertDAO.getTxDetails(rwsPaymentRevertActionForm,
					request);
		}
		if (mode != null && mode.equals("revert")) {
			if (session.getAttribute("forgotkey") != null) {
				System.out.println("revaet action forgotkey");

				String key = (String) session.getAttribute("forgotkey");
				String enteredKey = request.getParameter("number");
				if (!key.equals(enteredKey)) {
					request.setAttribute("message",
							"You are Entered Wrong Security Code");
					return mapping.findForward("data");
				}

			}
			if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(TX_BANK)) {
				System.out.println("revaet ");
				rwsPaymentRevertDAO.processBankRevertion(
						rwsPaymentRevertActionForm, request, user.getUserId(),
						ipAddress);

			} else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(TX_PAO)) {
				rwsPaymentRevertDAO.processPAORevertion(
						rwsPaymentRevertActionForm, request, user.getUserId(),
						ipAddress);
			}
			else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(TX_FORWARD_PAO)) {
				System.out.println("txDateQueryin action");
				rwsPaymentRevertDAO.processFORWARDPAORevertion(
						rwsPaymentRevertActionForm, request, user.getUserId(),
						ipAddress);
			}
		

			reset(rwsPaymentRevertActionForm, session);
		}

		return mapping.findForward("data");
	}

	/**
	 * 
	 * @param rwsPaymentRevertActionForm
	 * @param session
	 */
	private void reset(RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			HttpSession session) {
		rwsPaymentRevertActionForm.setTotalBills("0");
		rwsPaymentRevertActionForm.setTotalProccessedAmount("0");
		rwsPaymentRevertActionForm.getTxBillsList().clear();
		rwsPaymentRevertActionForm.getTxDate();
		
		rwsPaymentRevertActionForm.getTxId();
		

	}

}
