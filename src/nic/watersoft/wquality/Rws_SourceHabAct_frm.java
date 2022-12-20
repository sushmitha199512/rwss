
package nic.watersoft.wquality;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.*;

import nic.watersoft.commons.Debug;

public class Rws_SourceHabAct_frm extends Action {
	public Rws_SourceHabAct_frm() {}
	protected ActionForm buildIhhlForm(String habCode,String dist,HttpServletRequest request) throws Exception {		
		SourceHabMasterData sourceHabMasterData=new SourceHabMasterData();
		SourceHabForm sourceHabForm=null;
		SourceHabFormBean sourceHabFormBean=sourceHabMasterData.getIhhledit(habCode);
			if(sourceHabFormBean != null){
				sourceHabForm = new SourceHabForm();				
				sourceHabForm.setDist(sourceHabFormBean.getDist());
				sourceHabForm.setdName(sourceHabFormBean.getdName());
				sourceHabForm.setmName(sourceHabFormBean.getmName());
				sourceHabForm.setpName(sourceHabFormBean.getpName());
				sourceHabForm.setvName(sourceHabFormBean.getvName());
				sourceHabForm.setHabCode(sourceHabFormBean.getHabCode());
				sourceHabForm.setHead(sourceHabFormBean.getHead());
				sourceHabForm.setTypeid(sourceHabFormBean.getTypeid());
				sourceHabForm.setIdnumber(sourceHabFormBean.getIdnumber());
				sourceHabForm.setMbnum(sourceHabFormBean.getMbnum());
				sourceHabForm.setEsubsidy(sourceHabFormBean.getEsubsidy());
				sourceHabForm.setAmunteligible(sourceHabFormBean.getAmunteligible());
				sourceHabForm.setIhhlcon(sourceHabFormBean.getIhhlcon());
				sourceHabForm.setNotcon(sourceHabFormBean.getNotcon());				
			}
			return sourceHabForm;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page_to_be_displayed = "data";		
		String message = null;
		String district="";
		SourceHabForm frm = (SourceHabForm) form;
		int i = 0;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
		String token = request.getParameter("token");	   
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		if (rwsUser == null)
			return mapping.findForward("expire");	
		if(rwsUser.getUserId()!= null && !(rwsUser.getUserId().equals(Constants.ADMIN) || rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsWaterQualityUser(rwsUser.getUserId()) || Constants.IsUser(rwsUser.getUserId()) )) {
				return mapping.findForward("unAuthorise");	
			}		
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList ihhljb=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList expyears=new ArrayList();
		ArrayList sourcelist=new ArrayList();
		ArrayList habslist=new ArrayList();
		ArrayList addhabs=new ArrayList();
		int count=0;
		SourceHabMasterData sourceHabMasterData=new SourceHabMasterData();		
		if (mode != null && mode.equalsIgnoreCase("data")) {			
			if (request.getParameter("special") != null	&& request.getParameter("special").equals("reset")){
			    session.removeAttribute("districts");
				session.removeAttribute("mandals");
				session.removeAttribute("panchayats");
				session.removeAttribute("villages");
				session.removeAttribute("habitations");
				reset(frm);				
			}						
			try {				
				districts=sourceHabMasterData.getCircles(getDataSource(request));
				session.setAttribute("districts",districts);
				district=frm.getCircleOfficeCode();
				if(rwsUser.getCircleOfficeCode()!=null && !rwsUser.getCircleOfficeCode().equals("")){				
					mandals=sourceHabMasterData.getMandalsgovt(getDataSource(request),rwsUser.getCircleOfficeCode(),frm.getCircleOfficeCode());
					session.setAttribute("mandals",mandals);
				}
				else{
					session.setAttribute("mandals", new ArrayList());
				}
				if(rwsUser.getCircleOfficeCode()!=null && !rwsUser.getCircleOfficeCode().equals("") && frm.getMcode() !=null && !frm.getMcode().equals("")){
					panchayats=sourceHabMasterData.getPanchayatsgovt(getDataSource(request),rwsUser.getCircleOfficeCode(),frm.getCircleOfficeCode(),frm.getMcode());
					session.setAttribute("panchayats",panchayats);
				}
				else{
					session.setAttribute("panchayats", new ArrayList());
				}			
				if(rwsUser.getCircleOfficeCode()!=null && !rwsUser.getCircleOfficeCode().equals("") && frm.getMcode() !=null && !frm.getMcode().equals("") && frm.getPcode() != null && !frm.getPcode().equals("")){
					villages=sourceHabMasterData.getVillagesgovt(getDataSource(request),rwsUser.getCircleOfficeCode(),frm.getCircleOfficeCode(),frm.getMcode(),frm.getPcode());
					session.setAttribute("villages",villages);
				}
				else{
					session.setAttribute("villages", new ArrayList());
				}
				if(rwsUser.getCircleOfficeCode()!=null && !rwsUser.getCircleOfficeCode().equals("") && frm.getMcode() !=null && !frm.getMcode().equals("") && frm.getPcode() != null && !frm.getPcode().equals("") && frm.getVcode() !=null && !frm.getVcode().equals("")){
					habitations=sourceHabMasterData.getHabs(getDataSource(request),rwsUser.getCircleOfficeCode(),frm.getCircleOfficeCode(),frm.getMcode(),frm.getPcode(),frm.getVcode());
					session.setAttribute("habitations",habitations);			
				}			
				else{
					session.setAttribute("habitations", new ArrayList());
				}		
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_SourceHabAct_frm =  "+e.getMessage());
			}
			page_to_be_displayed="data";
		}
		
		if (mode != null && mode.equals("adminhabs")) {
		    String sourceCode =(String)session.getAttribute("sourceCode");
			ArrayList selectedHabCodes = sourceHabMasterData.getshowhabs(sourceCode);
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);
			reset1(frm);
			return mapping.findForward("adminhabs");
		}
			
		if(mode!=null && mode.equalsIgnoreCase("addHabs")){
			try	{				
				addhabs=sourceHabMasterData.getAddHabs(frm);
				session.setAttribute("addhabs",addhabs);
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_SourceHabAct_frm =  "+e.getMessage());		
			}
			page_to_be_displayed="addhabs";			
		}
				
		if (mode != null && mode.equals("pickmandals")) {			
			String forwardName = "";			
			try{			
				ArrayList mandals1 = sourceHabMasterData.getMandals1(rwsUser.getCircleOfficeCode(),frm.getCircleOfficeCode());
				session.setAttribute("mandals1",mandals1);	
				forwardName = "pickmandals";
				return mapping.findForward(forwardName);
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_SourceHabAct_frm =  "+e.getMessage());
			}
			page_to_be_displayed="pickmandals";
		}
			
		if (mode != null && mode.equals("pickhabs")) {
				String sourceCode = (String)session.getAttribute("sourceCode");
				String temp = request.getParameter("selectedMcodes");
				String mcodes[] = temp.split("@@");				
				try	{
					ArrayList sanctionedHabs = sourceHabMasterData.getSanctionedHabs(sourceCode);
					ArrayList habitations21 = sourceHabMasterData.getHabsInMandals(sourceCode, sanctionedHabs, mcodes);
					if (habitations21 != null)
						request.setAttribute("habitations21", habitations21);				
						return mapping.findForward("pickhabs");					
				}				
				catch(Exception e){
					System.out.println("The Exception in Rws_SourceHabAct_frm =  "+e.getMessage());
				}			
			}			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(SourceHabForm frm) {		
		frm.setDist("");
		frm.setMcode("");
		frm.setPcode("");
		frm.setVcode("");
		frm.setHabCode("");
		frm.setSource("");
		frm.setSourcelist("");
	}
	public void reset1(SourceHabForm frm)
	{}
}

