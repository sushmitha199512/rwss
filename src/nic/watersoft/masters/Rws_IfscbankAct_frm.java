package nic.watersoft.masters;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;


import org.apache.struts.action.*;

import nic.watersoft.commons.Debug;

public class Rws_IfscbankAct_frm extends Action {
	public Rws_IfscbankAct_frm() {
	}

	//

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page_to_be_displayed = " ";
		
		String message = null;
		
		
		
		
		
		
		
		
		
		
		
		

		IfscbankForm frm = (IfscbankForm) form;
		int i = 0;

		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String bankname="";
		String bankaddress="";
		String branchname="";
		String accountnumber="";
		int p=0;
		String name="";
		String address="";
		String personaccount="";
		

		
		if (mode != null && mode.equalsIgnoreCase("data")) {
			
			
				
						
			try {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset"))
			{
				
				Debug.println("data2");
				reset(frm);
				
			}
			
				
				
			
                 
								
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="data";
		}
		if (mode != null && mode.equalsIgnoreCase("view")) {
			try
			{
				
				IfscMasterData ifscMasterData=new IfscMasterData();
				bankname=IfscMasterData.getBankName(frm.getIfscCode(),frm);
				Debug.println("data"+bankname);
				
				IfscbankForm ifscbankForm=new IfscbankForm();
					accountnumber=ifscMasterData.getAccountNumber(frm.getIfscCode(),frm);
					
				
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="view";
		}
		if (mode != null && mode.equalsIgnoreCase("save")) {
			try
			{
				int no = 0;
				IfscMasterData ifscMasterData=new IfscMasterData();
				
				IfscbankForm ifscbankForm=new IfscbankForm();
				no=IfscMasterData.getExists(frm.getIfscCode());
				if(no==1)
				{
				message="IfSC Code Exists";	
				}
				else
				{
				p=ifscMasterData.saveifsc(ifscbankForm,frm.getIfscCode(),frm.getAccountNumber(),frm.getAccountholderName(),frm.getPersonAddress(),frm.getPersonAccount());
				Debug.println("p*******"+p);
				if(p==1)
				{
					message="Record Saved Successfully";
				}
				else
				{
					message="Record Not  Saved ";
				}
				}
				request.setAttribute("message",message);
				
				
				
				
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="save";
		}
		
			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(IfscbankForm frm) {
		frm.setIfscCode("");
		frm.setBankName("");
		frm.setBranchName("");
		frm.setAccountNumber("");
		frm.setBankAddress("");
		
		
		
		
		
	}
	

}

