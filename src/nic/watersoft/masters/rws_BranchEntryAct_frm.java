/*
 * Created on Jan 11, 2011
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

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_BranchEntryAct_frm extends Action {
		protected ActionForm buildBranchForm(String branchCode,String bankCode,HttpServletRequest request) throws Exception {
			BankForm form = null;
			RwsMaster rwsMaster=RwsMasterData.getbranch(branchCode,bankCode);
			HttpSession session=request.getSession();
				if(rwsMaster!=null)	{
					form = new BankForm();
					form.setBankName(rwsMaster.getBankName());
					form.setCircleCode(rwsMaster.getCircleCode());
					form.setDivisionCode(rwsMaster.getDivisionCode());
					form.setBranchCode(rwsMaster.getBranchCode());
					form.setBranchName(rwsMaster.getBranchName());
					form.setMicrCode(rwsMaster.getMicrCode());
					form.setBankCode(rwsMaster.getBankCode());
					RwsMasterData rwsMasterData = new RwsMasterData();
					ArrayList divisions =rwsMasterData.getDivisionCode(rwsMaster.getCircleCode());
					session.setAttribute("divisioncode",divisions);
				}
				return form;
		}
		
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {
		int ans = 0;
		String message=null;
		ArrayList branches=null;
		ArrayList bankcode=null;
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
		ArrayList circlecode=null;
		ArrayList divisioncode=null;
		String mode=frm.getMode();
		ValidationUtils validate = new ValidationUtils ();
		if(mode!=null && mode.equalsIgnoreCase("data")){
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			try	{
				request.setAttribute("branchcode",RwsMasterData.getBranchCode());
				RwsMasterData rwsMaster = new RwsMasterData();
				bankcode = rwsMaster.getBankcode();
				session.setAttribute("bankcode",bankcode);
				circlecode=rwsMaster.getCircleCode();
				session.setAttribute("circlecode",circlecode);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_BranchTypeEntryAct_frm in inc is "+e);
			}		
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save"))	{
			if (storedToken.equals(token)) {	
				try	{
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setBranchCode(frm.getBranchCode());
					rwsMaster.setBranchName(frm.getBranchName());
					rwsMaster.setMicrCode(frm.getMicrCode());
					rwsMaster.setCircleCode(frm.getCircleCode());
					rwsMaster.setDivisionCode(frm.getDivisionCode());
					rwsMaster.setBcode(frm.getBcode());
					ans=RwsMasterData.insertBranch(rwsMaster);
					request.setAttribute("branchcode",RwsMasterData.getBranchCode());				
				}
				catch(Exception e) {
					System.out.println("The Exception in rws_BranchEntryAct_frm in insert is "+e);
				}
				if(ans <1) {
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0) {
						message = RwsMasterData.errorMessage;
					}
					else {
						message="Branch Code Already Exsists---Insertion Failed";
						reset(frm);
					}
				}
				else {
					message="New Branch Inserted Successfully";
					reset(frm);
				}				
				request.setAttribute("message",message);
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("division")){
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
		
		if(mode!=null && mode.equalsIgnoreCase("division1")){
			try	{
				RwsMasterData rwsMaster = new RwsMasterData();
				divisioncode=rwsMaster.getDivisionCode(request.getParameter("circleCode"));
				session.setAttribute("divisioncode",divisioncode);
				mode="data";
			}
			catch(Exception e) {
				System.err.println("The error in rws_OfficeEntryAct_frm in insert is "+e);
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("division2")) {
			try	{
				RwsMasterData rwsMaster = new RwsMasterData();
				divisioncode=rwsMaster.getDivisionCode(request.getParameter("circleCode"));
				session.setAttribute("divisioncode",divisioncode);
				mode="branch";
			}
			catch(Exception e){
				System.out.println("The Exception in rws_OfficeEntryAct_frm in insert is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("view")) {
			try	{
				branches=RwsMasterData.getBranches();
				session.setAttribute("branches",branches);
			}
			catch(Exception e){
				System.out.println("The Exception in rws_BankEntryAct_frm in view is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("get")) {
			try {
				form = buildBranchForm(request.getParameter("branchCode"),request.getParameter("bankCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_BranchEntryAct_frm in get is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)) {	
				try	{
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setBcode(frm.getBcode());
					rwsMaster.setCircleCode(frm.getCircleCode());
					rwsMaster.setDivisionCode(frm.getDivisionCode());
					rwsMaster.setBranchCode(frm.getBranchCode());
					rwsMaster.setBranchName(frm.getBranchName());
					rwsMaster.setMicrCode(frm.getMicrCode());
					ans=RwsMasterData.updateBranch(rwsMaster);
				}
				catch (Exception e) {
					System.out.println("The Exception in rws_BranchEntryAct_frm in edit is "+e);
				}
				if(ans <1) {
					if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
						message = RwsMasterData.errorMessage;
					else
						message="Problem in Updating the Branch Details ";
				}
				else {
					message="Branch Details Updated Successfully";
				}			
				request.setAttribute("message",message);
			}
		}
		
		if(mode.equalsIgnoreCase("delete")){
			try {
				ans=RwsMasterData.removeBranch(request.getParameter("branchCode"),request.getParameter("bankCode"));
				if(ans>0){
					displaymess = "Branch '"+request.getParameter("branchName")+"' deleted Succesfully Under the Bank '"+request.getParameter("bankName")+"'";
				}
				else {
					displaymess = "Account(s) Exists Under this Branch '"+request.getParameter("branchName")+"' and the Bank '"+request.getParameter("bankName")+"' -- Deletion Failed ";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) {
				System.out.println("The Exception in rws_BranchEntryAct_frm in delete is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
	
	void reset(BankForm frm){
		frm.setBcode("");
		frm.setCircleCode("");
		frm.setDivisionCode("");
		frm.setBranchName("");
		frm.setMicrCode("");
	}	
}
	