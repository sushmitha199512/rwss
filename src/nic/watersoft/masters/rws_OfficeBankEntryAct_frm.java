/*
 * Created on Jan 12, 2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */


package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_OfficeBankEntryAct_frm extends Action {
		protected ActionForm buildBankaccountForm(String accno,String offcode,HttpServletRequest request) throws Exception {
			BankForm form = null;
			RwsMaster rwsMaster=RwsMasterData.getBankAcDetails(accno,offcode);			
				if(rwsMaster!=null)	{
					form = new BankForm();
					form.setCircleName(rwsMaster.getCircleName());
					form.setDivisionName(rwsMaster.getDivisionName());
					form.setCircleCode(rwsMaster.getCircleCode());
					form.setDivisionCode(rwsMaster.getDivisionCode());
					form.setBankName(rwsMaster.getBankName());
					form.setBranchName(rwsMaster.getBranchName());
					form.setBankCode(rwsMaster.getBankCode());
					form.setBranchCode(rwsMaster.getBranchCode());
					form.setAccNo(rwsMaster.getAccNo());
					form.setOffCode(rwsMaster.getOffCode());				
				}
				return form;
		}
		
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		ArrayList branches=null;
		ArrayList bankcode=null;
		ArrayList branchcode=null;
		ArrayList circlecode=null;
		ArrayList divisioncode=null;
		ArrayList bankdetails=null;
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
		if(mode!=null && mode.equalsIgnoreCase("data")) {
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			try	{
				RwsMasterData rwsMaster = new RwsMasterData();
				bankcode = rwsMaster.getBankcode();
				session.setAttribute("bankcode",bankcode);
				circlecode=rwsMaster.getCircleCode();
				session.setAttribute("circlecode",circlecode);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_officeBankEntryAct_frm in inc is "+e);
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save"))	{
			 if (storedToken.equals(token)) {
				try{
					RwsMaster rwsMaster = new RwsMaster();
		            rwsMaster.setCircleCode(frm.getCircleCode());
		            rwsMaster.setDivisionCode(frm.getDivisionCode());
					rwsMaster.setBankCode(frm.getBankCode());
					rwsMaster.setBranchCode(frm.getBranchCode());
					rwsMaster.setAccNo(frm.getAccNo());
					ans=RwsMasterData.insertAccountDetails(rwsMaster);
				}
				catch(Exception e){
					System.out.println("The Exception in rws_BranchEntryAct_frm in insert is "+e);
				}
				if(ans <1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0){
						message = RwsMasterData.errorMessage;
						reset(frm);
					}
					else {
						message="Already Exsists---Insertion Failed";
						reset(frm);
					} 
				}
				else {
					message="Account Details Inserted Successfully";
					reset(frm);
				}				
				request.setAttribute("message",message);
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("division"))	{
			try	{
				RwsMasterData rwsMaster = new RwsMasterData();
				divisioncode=rwsMaster.getDivisionCode(request.getParameter("circleCode"));
				session.setAttribute("divisioncode",divisioncode);
				bankcode = rwsMaster.getBankcode();
				session.setAttribute("bankcode",bankcode);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_OfficeEntryAct_frm in insert is "+e);
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("branch")){
			try	{
				RwsMasterData rwsMaster = new RwsMasterData();
				branchcode = rwsMaster.getBranchcode(request.getParameter("bankCode"),request.getParameter("circleCode"),request.getParameter("divisionCode"));
				session.setAttribute("branchcode",branchcode);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_OfficeEntryAct_frm in insert is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("view")){
			try {
				bankdetails=RwsMasterData.getBankAccountdetails();
				session.setAttribute("bankdetails",bankdetails);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_OfficeBankEntryAct_frm in view is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("get")) {
			try  {
				form = buildBankaccountForm(request.getParameter("accno"),request.getParameter("offcode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_OfficeBankEntryAct_frm in get is " + e);
			}
		}
		
		if(mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)) {
				try	{
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setCircleCode(frm.getCircleCode());
					rwsMaster.setDivisionCode(frm.getDivisionCode());
					rwsMaster.setBankCode(frm.getBankCode());
					rwsMaster.setBranchCode(frm.getBranchCode());
					rwsMaster.setAccNo(frm.getAccNo());
				    rwsMaster.setOffCode(frm.getOffCode());
					ans=RwsMasterData.updateAccDetails(rwsMaster);
				}
				catch (Exception e) {
					System.out.println("The Exception in rws_BranchEntryAct_frm in edit is "+e);
				}
				if(ans <1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						message = RwsMasterData.errorMessage;
					else
						message="Problem in Updating the Account Details ";
				}
				else {
						message="Account Details Updated Successfully";
				}			
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("delete")){
			try {
				ans=RwsMasterData.removeAccDetails(request.getParameter("accno"));
				if(ans<1){
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						displaymess = RwsMasterData.errorMessage;
					else
						displaymess = "Problem in Deleting the Account Details";
				}
				else {
						displaymess = "Account Details are Deleted Succesfully";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_OfficeBankEntryAct_frm in delete is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
	void reset(BankForm frm) {    
		frm.setCircleCode("");
		frm.setDivisionCode("");
		frm.setBranchCode("");
		frm.setBankCode("");
		frm.setAccNo("");
	}	
}
	