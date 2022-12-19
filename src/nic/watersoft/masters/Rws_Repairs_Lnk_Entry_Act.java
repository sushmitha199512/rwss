/*
 * Created on 30-10-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Repairs_Lnk_Entry_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message=null;
		ArrayList asttypes=new ArrayList();
		ArrayList astComps=new ArrayList();
		ArrayList repairTypes=new ArrayList();
		ArrayList assetCompRepairLnkList=new ArrayList();
		ArrayList sourceTypes=new ArrayList();
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		rws_functional_repair_frm frm=(rws_functional_repair_frm) form;
		String mode=frm.getMode();
		Rws_Functional_Status_Dao dao=new Rws_Functional_Status_Dao();
		try {
			if(mode!=null && mode.equalsIgnoreCase("data"))	{
				if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")) {
					reset(frm);				
				}			
				String mode1=request.getParameter("mode1");
				asttypes=dao.getAssetTypeList();
				session.setAttribute("asttypes", asttypes);
				if(frm.getAsttype()==null){}
				else{
					if(!frm.getAsttype().equals("01")&&!frm.getAsttype().equals("02")&&!frm.getAsttype().equals("03")&&!frm.getAsttype().equals("09")){
						session.removeAttribute("astComps");				
						session.removeAttribute("souComps");
						frm.setAstComp("");
						frm.setSouType("");	
						frm.setRepairType("");
					}		
				}
				if(frm.getAsttype()!=null && !frm.getAsttype().equals("") && mode1!=null && mode1.equals("comps")){
					astComps=dao.getAllAssetComps(frm.getAsttype());
					session.setAttribute("astComps", astComps);
					session.removeAttribute("sourceTypes");
					frm.setSouType("");	
					frm.setAstComp("");
					frm.setRepairType("");
				}				
				if(frm.getAsttype()!=null && !frm.getAsttype().equals("") && frm.getAstComp()!=null && frm.getAstComp().equals("01") && mode1!=null && mode1.equals("sourcTypes")){
					sourceTypes=dao.getSubSourceTypes();
					session.setAttribute("sourceTypes", sourceTypes);
					frm.setSouType("");	
					frm.setRepairType("");
				}			
				repairTypes=dao.getRepairCodeName();
				session.setAttribute("repairTypes", repairTypes);				
			}	
			
			if(mode!=null && mode.equalsIgnoreCase("save"))	{	
				 if (storedToken.equals(token)) {	
					message=dao.saveRepairAssetCompLink(frm.getAsttype(),frm.getAstComp(),frm.getRepairType(),frm.getSouType());
					request.setAttribute("message",message);
					mode="data";	
				 }
			}	
			
			if(mode!=null && mode.equalsIgnoreCase("View"))	{			
				assetCompRepairLnkList=dao.getAssetComponentRepairList(frm.getAsttype(),frm.getAstComp(),frm.getSouType(),frm.getRepairType());
				session.setAttribute("assetCompRepairLnkList",assetCompRepairLnkList);
			}
			
			if(mode!=null && mode.equalsIgnoreCase("delete")){
				message=dao.deleteRepairAssetCompLink(frm.getAsttype(),frm.getAstComp(),frm.getRepairType(),frm.getSouType());
				request.setAttribute("message",message);
				reset(frm);			
			}
		}catch(Exception e)	{
			System.out.println("The Exception is in Rws_Repairs_Lnk_Entry_Act : "+e.getMessage());
		}		
		return mapping.findForward(mode);
	}

	private void reset(rws_functional_repair_frm frm) {
		frm.setAsttype("");
		frm.setAstComp("");
		frm.setSouType("");
		frm.setRepairType("");	
	}
}