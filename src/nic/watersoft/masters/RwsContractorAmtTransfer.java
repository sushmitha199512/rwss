/*
 * Created on 30-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author RWSS_DPT1 (Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContractorAmtTransfer extends Action {

	private static String VIEW_LIST = "view";
	private static String DIV_VIEW_LIST = "divview";

	private static String SAVE = "save";

	private static String VERIFY = "verifyToken";

	/*
	 * (non-Javadoc)
	 * 
	 * @seeorg.apache.struts.action.Action#execute(org.apache.struts.action.
	 * ActionMapping, org.apache.struts.action.ActionForm,
	 * javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		RwsContractorAmtTransferDAO amtTransferDAO = new RwsContractorAmtTransferDAO();
		RwsContractorAmtTransferBean amtTransferBean = (RwsContractorAmtTransferBean) form;
		HttpSession session = request.getSession(true);
		String mode = request.getParameter("mode");

		if (mode != null && mode.equals(DIV_VIEW_LIST)) {
			amtTransferBean.setIsDsValide("no");
			return mapping.findForward(DIV_VIEW_LIST);
		}
		if (mode != null && mode.equals(VIEW_LIST)) {

			amtTransferBean.setSourceBankDetails(amtTransferDAO
					.getSourcebankDetails());
			amtTransferBean.setAvailableGrant(amtTransferDAO.getTolAvailableGrant());
			
			if(amtTransferBean.getSourceBankDetails().size()==0){
				amtTransferBean.setIsSourcebankRegister("no");
			}
			session.setAttribute("sourceBankDetails", amtTransferBean
					.getSourceBankDetails());
			
			amtTransferBean.setIsDsValide("no");
			amtTransferBean.setTransfersList(amtTransferDAO
					.getTransfersList(amtTransferBean));
		}
		/**
		 * To Verify ENC DS Token Checking with Database
		 */
		if (mode != null && mode.equals(VERIFY)) {
			String subMode = request.getParameter("divmode");

			if (amtTransferDAO.isAudhorizetoProcessBill(amtTransferBean,
					request)) {
				amtTransferBean.setIsDsValide("yes");
			}
			if (subMode != null && subMode.equals("div")) {
				return mapping.findForward(DIV_VIEW_LIST);
			}

		}
		if (mode != null && mode.equals(SAVE)) {

			amtTransferDAO.processDB(amtTransferBean, request);
			amtTransferBean.setIsDsValide("no");
			System.out.println("Size:"
					+ amtTransferBean.getTransfersList().size());
		}

		return mapping.findForward(VIEW_LIST);

	}

}