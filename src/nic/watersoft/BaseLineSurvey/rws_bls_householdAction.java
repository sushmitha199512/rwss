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

public class rws_bls_householdAction extends  Action{
	ArrayList dists=new ArrayList();
	ArrayList mandalnames=new ArrayList();
	ArrayList panchayaths=new ArrayList();
	ArrayList villages=new ArrayList();
	ArrayList habs=new ArrayList();
	ArrayList habdetails=new ArrayList();
@Override
public ActionForward execute(ActionMapping mapping, ActionForm form,
		HttpServletRequest request, HttpServletResponse response)
		throws Exception {
	HttpSession ses=request.getSession();
	RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
	baselineSurveyDAO blsdao=new baselineSurveyDAO();
	
	String district="";
	String mandalname="";
	String panchayath="";
	String village="";
	String hab="";
	blsHouseHoldForm blsorgfrm=(blsHouseHoldForm)form;
	String mode=request.getParameter("mode");
	System.out.println("mode is "+mode);
	
	
	if(mode.equals("data")){
		
		blsorgfrm.setHouseholdnum(Long.toString(blsdao.getHouseholdnumber()));
		dists= rwsoffice.getDistricts();
		ses.setAttribute("districts", dists);
		System.out.println("sno is "+blsdao.getHouseholdnumber());
		blsorgfrm.setMandal("");
		blsorgfrm.setPanchayat("");
		blsorgfrm.setVillage("");
		blsorgfrm.setHabCode("");
		
	}

		
	if(mode.equals("getmandal")){
		System.out.println("districts size is "+dists.size());
		district=blsorgfrm.getDistrict();
		mandalnames=rwsoffice.getDistrictMandals(district);
		ses.setAttribute("mandalcodes", mandalnames);
		blsorgfrm.setPanchayat("");
		blsorgfrm.setVillage("");
		blsorgfrm.setHabCode("");
	}
	
	if(mode.equals("getpanchayath")){
		villages=null;
		habs=null;
				district=blsorgfrm.getDistrict();
		mandalname=blsorgfrm.getMandal();
				panchayaths=rwsoffice.getPanchayats(district,mandalname);
				ses.setAttribute("panchayaths", panchayaths);
				blsorgfrm.setVillage("");
				blsorgfrm.setHabCode("");
	}
	
	if(mode.equals("getvillage")){
		
		habs=null;
		district=blsorgfrm.getDistrict();
		mandalname=blsorgfrm.getMandal();
		
		panchayath=blsorgfrm.getPanchayat();
		villages=rwsoffice.getVillages(district,mandalname,panchayath);
		ses.setAttribute("villages", villages);
		blsorgfrm.setHabCode("");
	}
	
	if(mode.equals("gethab")){
		district=blsorgfrm.getDistrict();
	
		mandalname=blsorgfrm.getMandal();
		panchayath=blsorgfrm.getPanchayat();
		village=blsorgfrm.getVillage();
		habs=RwsMasterData.getHabitations(district, mandalname,panchayath,village, getDataSource(request));
		ses.setAttribute("habitations", habs);
		
	}
if(mode.equals("view")){
	System.out.print("in the mode of view ");
		hab=blsorgfrm.getHabCode();
		habdetails=blsdao.gethouseholdHabDetails( hab);
		System.out.print("size of details is "+habdetails.size());
		ses.setAttribute("habdetails", habdetails);
	}
if(mode.equals("save")){
	int i=blsdao.inserthouseholddata(blsorgfrm);
	
	if(i>0){
		request.setAttribute("message", "hab details inserted successfully");
				
	}else{
		request.setAttribute("message", "hab details insertion failed");
		
	}
	reset(blsorgfrm);
	 blsorgfrm.setHouseholdnum(Long.toString(blsdao.getHouseholdnumber()));

	}
if(mode.equals("edit")){
		String householdnumber=request.getParameter("hsehdnum");
		System.out.print("house hold number is "+householdnumber);
		blsorgfrm=blsdao.getholddetails(Integer.parseInt(householdnumber));
		if ("request".equalsIgnoreCase(mapping.getScope())) {
			request.setAttribute(mapping.getAttribute(), blsorgfrm);
		} else {
			ses.setAttribute(mapping.getAttribute(), form);
		}
	}
if(mode.equals("update")){
int i=blsdao.updatehouseholddata(blsorgfrm);
	
	if(i>0){
		request.setAttribute("message", "hab details updated successfully");
		
	}else{
		request.setAttribute("message", "hab details updation failed");
		
	}	
	mode= "close";
}
if(mode.equals("delete")){
	String hhnum=request.getParameter("hsehdnum");
	int i=blsdao.deletehouseholddata(hhnum);
		
		if(i>0){
			request.setAttribute("message", "house hold details deleted successfully");
			
		}else{
			request.setAttribute("message", "house hold details deletion failed");
			
		}	
		mode= "close";
	}
System.out.println("mode at the end is="+mode);
return mapping.findForward(mode);
}
private void reset(blsHouseHoldForm frm) {
	System.out.println("in reset method");
	frm.setHabCode("");
	frm.setHedname("");
	frm.setFathername("");
	frm.setHedrelation("");
	frm.setCardtype("");
	frm.setCardnum("");
	frm.setJobcardnum("");
	frm.setFamilycount("");
	frm.setFemalecount("");
	frm.setMalecount("");
	frm.setBlsstatus("");
	frm.setCaste("");
	frm.setToilets("");
	frm.setDepartmentnm("");
	frm.setToilettype("");
	frm.setLatrineserviced("");
	frm.setToiletsuse("");
	frm.setToiletsnotusereason("");
	frm.setWateraviltoilets("");
	frm.setToiletfnstatus("");
	frm.setToiletsdefuntstatus("");
	frm.setToiletsdefuntstatus("");
	frm.setCommtoiletsuse("");
	frm.setWatersource("");
	frm.setUsagewaterpots("");
	frm.setPotcapacity("");
	frm.setDrinkwateravail("");
	frm.setWateravailmnths("");
	frm.setWaterquality("");
	frm.setSourcedistance("");
	frm.setPhonenum("");
	frm.setSurveydt("");
	frm.setMandal("");
	frm.setPanchayat("");
	frm.setVillage("");
	frm.setHabCode("");
	
}

}
