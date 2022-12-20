package nic.watersoft.BaseLineSurvey;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_bls_orgAction extends Action{
	ArrayList dists=new ArrayList();
	ArrayList mandalnames=new ArrayList();
	ArrayList panchayaths=new ArrayList();
	ArrayList villages=new ArrayList();
	ArrayList habs=new ArrayList();
	
@Override
public ActionForward execute(ActionMapping mapping, ActionForm form,
		HttpServletRequest request, HttpServletResponse response)
		throws Exception {
	HttpSession ses=request.getSession();
	RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
	baselineSurveyDAO blsdao=new baselineSurveyDAO(getDataSource(request));
	
	String district="";
	String mandalname="";
	String panchayath="";
	String village="";
	String hab="";
	blsOrgForm blsorgfrm=(blsOrgForm)form;
	String mode=blsorgfrm.getMode();
	System.out.println("mode is "+mode);
	
	
	if(mode.equals("data")){
		
		dists= rwsoffice.getDistricts();
		ses.setAttribute("districts", dists);
		blsorgfrm.setMandal("");
		blsorgfrm.setPanchayat("");
		blsorgfrm.setVillage("");
		blsorgfrm.setHabCode("");
		reset(blsorgfrm, ses);
		
	}

		
	if(mode.equals("getmandal")){
		System.out.println("districts size is "+dists.size());
		district=blsorgfrm.getDistrict();
		mandalnames=rwsoffice.getDistrictMandals(district);
		ses.setAttribute("mandalcodes", mandalnames);
		blsorgfrm.setPanchayat("");
		blsorgfrm.setVillage("");
		blsorgfrm.setHabCode("");
		reset(blsorgfrm, ses);
	}
	
	if(mode.equals("getpanchayath")){
		blsorgfrm.setVillage("");
		blsorgfrm.setHabCode("");
				district=blsorgfrm.getDistrict();
		mandalname=blsorgfrm.getMandal();
				panchayaths=rwsoffice.getPanchayats(district,mandalname);
				ses.setAttribute("panchayaths", panchayaths);
		reset(blsorgfrm, ses);
	}
	
	if(mode.equals("getvillage")){
		
		blsorgfrm.setHabCode("");
		district=blsorgfrm.getDistrict();
		mandalname=blsorgfrm.getMandal();
		
		panchayath=blsorgfrm.getPanchayat();
		villages=rwsoffice.getVillages(district,mandalname,panchayath);
		ses.setAttribute("villages", villages);
		reset(blsorgfrm, ses);
	}
	
	if(mode.equals("gethab")){
		district=blsorgfrm.getDistrict();
	
		mandalname=blsorgfrm.getMandal();
		panchayath=blsorgfrm.getPanchayat();
		village=blsorgfrm.getVillage();
		habs=RwsMasterData.getHabitations(district, mandalname,panchayath,village, getDataSource(request));
		ses.setAttribute("habitations", habs);
		reset(blsorgfrm, ses);
	}
	
	if(mode.equals("view")){
		
		hab=blsorgfrm.getHabCode();
		blsdao.getHabDetails(hab, blsorgfrm);
		
		
	}
	
	

	

	if(mode.equals("save")){
		
		int i=blsdao.updatedata(blsorgfrm);
		if(i>0){
			request.setAttribute("message", "other organization in GP details updated successfully");
			
		}else{
			request.setAttribute("message", "other organization in GP details updation failed");
			
		}
		
		blsorgfrm.reset(mapping, request);
		
	}
	
	
	
	
	return mapping.findForward(mode);
}
private void reset(blsOrgForm blsorgfrm, HttpSession session) {
	blsorgfrm.setNgos("");
	blsorgfrm.setShgs("");
	blsorgfrm.setWmngrps("");
	blsorgfrm.setOthergrps("");
	blsorgfrm.setSurveydt("");

}
}
