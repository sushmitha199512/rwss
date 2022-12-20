package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_functional_repair_action extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)  {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		session = request.getSession();
		if (user == null || session == null)
			return mapping.findForward("expire");

		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String username=user.getUserId();
		String page_to_be_displayed="";
		rws_functional_repair_frm funcRepFrm =(rws_functional_repair_frm)form;
		String mode = (String) request.getParameter("mode");
		RWS_HP_Yield_DAO dao=new RWS_HP_Yield_DAO();
		Rws_Functional_Status_Dao functionaldao=new Rws_Functional_Status_Dao();
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList asttypes = new ArrayList();
		ArrayList<rws_functional_repair_frm> sources=new ArrayList<rws_functional_repair_frm>();
		ArrayList repairTypes=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList astComps=new ArrayList();
		ArrayList astSubComps=new ArrayList();
		ArrayList souComps=new ArrayList();
		String type = (String) request.getParameter("type");
		if(type==null || type.equals(""))
			type="districts";
		try{
			if (mode != null && mode.equalsIgnoreCase("init")) {
				reset(funcRepFrm, session);
				mode="data";
			}
		if (mode != null && mode.equalsIgnoreCase("data")) {
			if(type != null && type.equals("districts")) {
				districts=dao.getCircles();
				session.setAttribute("districts", districts);
				session.removeAttribute("mandals");
				session.removeAttribute("panchayats");
				session.removeAttribute("villages");
				session.removeAttribute("asttypes");
				session.removeAttribute("astComps");
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setMcode("");
				funcRepFrm.setPanchayat("");
				funcRepFrm.setVcode("");
				funcRepFrm.setAsttype("");
				funcRepFrm.setAstComp("");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}else if(type != null && type.equals("mandals")) {	
				
				if(funcRepFrm.getDcode()!=null && !funcRepFrm.getDcode().equals("")){
					mandals=dao.getMandals(funcRepFrm.getDcode());					
				}
				session.setAttribute("mandals",mandals);
				session.removeAttribute("panchayats");
				session.removeAttribute("villages");
				session.removeAttribute("asttypes");
				session.removeAttribute("astComps");
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setPanchayat("");
				funcRepFrm.setVcode("");
				funcRepFrm.setAsttype("");
				funcRepFrm.setAstComp("");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}else if(type != null && type.equals("panchayats")) {		
				if(funcRepFrm.getDcode()!=null && !funcRepFrm.getDcode().equals("") && funcRepFrm.getMcode()!=null && !funcRepFrm.getMcode().equals("")){
					panchayats=dao.getPanchayats1(funcRepFrm.getDcode(),funcRepFrm.getMcode());
				}
				session.setAttribute("panchayats", panchayats);
				session.removeAttribute("villages");
				session.removeAttribute("asttypes");
				session.removeAttribute("astComps");
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setVcode("");
				funcRepFrm.setAsttype("");
				funcRepFrm.setAstComp("");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);			
			}
			else if(type != null && type.equals("villages")) {	
				if(funcRepFrm.getDcode()!=null && !funcRepFrm.getDcode().equals("") && funcRepFrm.getMcode()!=null && !funcRepFrm.getMcode().equals("") && funcRepFrm.getPanchayat()!=null && !funcRepFrm.getPanchayat().equals("")){
					villages=dao.getVillages(funcRepFrm.getDcode(),funcRepFrm.getMcode(),funcRepFrm.getPanchayat());
				}
				session.setAttribute("villages", villages);
				session.removeAttribute("asttypes");
				session.removeAttribute("astComps");
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setAsttype("");
				funcRepFrm.setAstComp("");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}
			
			asttypes=dao.getSpecAssetType();
			session.setAttribute("asttypes", asttypes);
			if(!funcRepFrm.getAsttype().equals("01")&&!funcRepFrm.getAsttype().equals("02")&&!funcRepFrm.getAsttype().equals("03")&&!funcRepFrm.getAsttype().equals("09")){
				session.removeAttribute("astComps");
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setAstComp("");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}
			
			if(type != null && type.equals("comps")) {	
				if(funcRepFrm.getAsttype()!=null && !funcRepFrm.getAsttype().equals("")){
					astComps=functionaldao.getAllAssetComps(funcRepFrm.getAsttype());
					session.setAttribute("astComps", astComps);
				}
				session.removeAttribute("astSubComps");
				session.removeAttribute("souComps");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}
			if(type != null && type.equals("subcomps")) {	
				if(funcRepFrm.getAsttype()!=null && !funcRepFrm.getAsttype().equals("") && funcRepFrm.getAstComp()!=null && !funcRepFrm.getAstComp().equals("") ){
					astSubComps=functionaldao.getAllAssetSubComps(funcRepFrm.getAsttype(),funcRepFrm.getAstComp());
					session.setAttribute("astSubComps", astSubComps);
				}
				session.removeAttribute("souComps");
				funcRepFrm.setAstSubComp("");
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}
			if(type != null && type.equals("soutypes")) {	
				if(funcRepFrm.getAsttype()!=null && !funcRepFrm.getAsttype().equals("") && funcRepFrm.getAstComp()!=null && !funcRepFrm.getAstComp().equals("") && funcRepFrm.getAstSubComp()!=null && !funcRepFrm.getAstSubComp().equals("")){
					souComps=functionaldao.getSubSourceTypes(funcRepFrm.getAstSubComp());
					session.setAttribute("souComps", souComps);
				}
				funcRepFrm.setSouType("");
				funcRepFrm.setSources(null);
			}
			page_to_be_displayed="data";
		}
		if (mode != null && mode.equalsIgnoreCase("submit")) {
			repairTypes=functionaldao.getRepairsFunctionalStatus(funcRepFrm);
			// funcRepFrm.setRepairTypes(repairTypes);
			session.setAttribute("repairTypes", repairTypes);
			if(funcRepFrm!=null){
				sources=functionaldao.getAssetCompListForFunctionalStatus(funcRepFrm);
			}
				funcRepFrm.setSources(sources);	
			if(sources.isEmpty()){
				request.setAttribute("message", "No data Found");
			}
			page_to_be_displayed="submit";
		}
		if (mode != null && mode.equalsIgnoreCase("save")) {		
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					if (funcRepFrm.getSources() == null) {
					} else {
						functionaldao.saveFunctionalSatus(funcRepFrm, request, username);
						sources = functionaldao.getAssetCompListForFunctionalStatus(funcRepFrm);
						funcRepFrm.setSources(sources);
					}
		    }
			page_to_be_displayed="submit";
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mapping.findForward(page_to_be_displayed);
	}
	private void reset(rws_functional_repair_frm myForm,HttpSession session) {
		myForm.setDcode("");
		myForm.setMcode("");
		myForm.setPanchayat("");
		myForm.setVcode("");
		myForm.setAsttype("");
		myForm.setAstComp("");
		myForm.setAstSubComp("");
		myForm.setSouType("");		
		myForm.setSources(null);
		session.removeAttribute("districts");
		session.removeAttribute("mandals");
		session.removeAttribute("panchayats");
		session.removeAttribute("villages");
		session.removeAttribute("asttypes");
		session.removeAttribute("astComps");
		session.removeAttribute("astSubComps");
		session.removeAttribute("souComps");		
	}
}
