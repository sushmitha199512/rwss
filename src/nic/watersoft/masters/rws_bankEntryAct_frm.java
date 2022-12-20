
package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_bankEntryAct_frm extends Action {
	protected ActionForm buildbankForm(String bankCode,HttpServletRequest request) throws Exception {
		BankForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getbank(bankCode);	
			if(rwsMaster!=null){
				form = new BankForm();
				form.setBankCode(rwsMaster.getBankCode());
				form.setBankName(rwsMaster.getBankName());
				form.setBankAbb(rwsMaster.getBankAbb());
			}
			return form;
	}
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		ArrayList banks=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		BankForm frm=(BankForm) form;
		String displaymess=null;
		String mode=frm.getMode();
		ValidationUtils validate = new ValidationUtils ();
		
		if(mode!=null && mode.equalsIgnoreCase("data")){
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			RwsMasterData.errorMessage=null;
			try {
				request.setAttribute("bankcode",RwsMasterData.getBankCode());
			}
			catch(Exception e) {
				System.out.println("The Exception in rws_bankEntryAct_frm in inc is : "+ e.getMessage());
			}
		}
		if(mode!=null && mode.equalsIgnoreCase("save")) {
			if (storedToken.equals(token)) {
				try	{
					RwsMaster rwsMaster = new RwsMaster();						
					rwsMaster.setBankCode(frm.getBankCode());
					rwsMaster.setBankName(frm.getBankName());
					rwsMaster.setBankAbb(frm.getBankAbb());
					if(frm.getBankCode() != null && validate.numValidator(frm.getBankCode()) != true){
						RwsMasterData.errorMessage="Bank Code Only Contain Numbers.";
					}
					else if(frm.getBankName() != null && validate.aphaWithSpaceValidator(frm.getBankName()) != true){
						RwsMasterData.errorMessage="Bank Name Only Contains Alphabets with Space";
					}
					else{
						ans=RwsMasterData.insertBank(rwsMaster);
					}
					request.setAttribute("bankcode", RwsMasterData.getBankCode());
				}
				catch(Exception e){
					System.out.println("The Exception in rws_bankEntryAct_frm in insert is : "+ e.getMessage());
				}
				if(ans <1) {
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						message = RwsMasterData.errorMessage;
					else
						message="Bank Code Already Exsists---Insertion Failed";
						reset(frm);
				}
				else{
					message="New Bank Inserted Successfully";
					reset(frm);
				}				
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("view")){
			try {
				banks=RwsMasterData.getBanks();
				session.setAttribute("banks",banks);
			}
			catch(Exception e){
				System.err.println("The Exception in rws_BankEntryAct_frm in view is : "+ e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("get")){
			try {
				form = buildbankForm(request.getParameter("bankCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e){
				System.out.println("The Exception in rws_BankEntryAct_frm in get is : "+ e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)) {
				try	{
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setBankCode(frm.getBankCode());
					rwsMaster.setBankName(frm.getBankName());
					rwsMaster.setBankAbb(frm.getBankAbb());
					ans=RwsMasterData.updateBank(rwsMaster);
				}
				catch (Exception e) {
					System.out.println("The Exception in rws_BankEntryAct_frm in edit is : "+ e.getMessage());
				}
				if(ans <1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						message = RwsMasterData.errorMessage;
					else
					message="Problem in Updating the Bank Details ";
				}
				else {
					message="Bank Details Updated Successfully";
				}			
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("delete")) {
			try {
				ans=RwsMasterData.removeBank(request.getParameter("bankCode"));
				if(ans>0) {
					displaymess = "'"+request.getParameter("bankName")+"'Bank deleted Succesfully ";
				}
				else {
					displaymess = "'"+request.getParameter("bankName")+"'Bank Has Branches--Deletion Failed";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_AssetTypeEntryAct_frm in delete is  : "+ e.getMessage());
			}
		}
		return(mapping.findForward(mode));
	}
	
	void reset(BankForm frm){
		frm.setBankName("");
		frm.setBankAbb("");
	}
}
	