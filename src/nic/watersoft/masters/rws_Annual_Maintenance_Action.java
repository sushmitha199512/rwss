package nic.watersoft.masters;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Annual_Maintenance_Action extends Action
{
	

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList finyears=null;
		HttpSession session=request.getSession();
		AssetForm assetForm = (AssetForm) form;
		String mode=(String) request.getParameter("mode");
		String assetCode=(String) request.getParameter("assetCode");
		rws_Annual_Maintenance_DAO  dao=new  rws_Annual_Maintenance_DAO();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		
		try {
			if(mode.equalsIgnoreCase("init"))
			{
				reset(assetForm);
				finyears=dao.getFinancialYear((String)session.getAttribute("assetCode"));
				session.setAttribute("finyear", finyears);
				
				
			}
			if(mode.equalsIgnoreCase("get"))
			{
				dao.getAnnualMaintenanceDetails(assetForm);
			}
		if(mode.equalsIgnoreCase("save"))
		{
			System.out.println("assetCode-114551--"+assetForm.getAssetCode());
			
			
				message=dao.saveAnnualMaintenance(assetForm,user.getUserId());
				request.setAttribute("message", message);
			
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return(mapping.findForward(mode));
	}

	private void reset(AssetForm form) {
		
		form.setFinYear("");
		form.setPower("");
		form.setMeterial("");
		form.setSalaries("");
		form.setTotal("");
	}
	
}
