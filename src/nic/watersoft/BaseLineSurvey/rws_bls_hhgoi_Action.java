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

public class rws_bls_hhgoi_Action extends  Action{
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
		
		
		dists= rwsoffice.getDistricts();
		ses.setAttribute("districts", dists);
		
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
		habdetails=blsdao.gethouseholdHabDetails(hab);
		System.out.print("size of details is "+habdetails.size());
		request.setAttribute("habdetails", habdetails);
	}
if(mode.equals("save")){
	ArrayList resultData = new ArrayList();
	String h1 = request.getParameter("hab1");
	System.out.println("hhstr is "+h1);
	String h2 = h1.substring(1, h1.length());
	System.out.println("hhstr1 is "+h2);
	String[] records = h1.split(",");
	System.out.println("records size is "+(records.length-1));
	for (int i = 0; i < records.length-1; i++) {
		blsHouseHoldForm hhform=new blsHouseHoldForm();
		hhform.setHouseholdnum(records[i]);
		System.out.println("hhstr2 is "+records[i]);
		i++;
		hhform.setGender(records[i]);
		System.out.println("hhstr2 is "+records[i]);
		i++;
		hhform.setAdharcardnum(records[i]);
		System.out.println("hhstr2 is "+records[i]);
		resultData.add(hhform);
	}
	
	int i[]=blsdao.insertgiodata(resultData);
	
	if(i.length>0){
		request.setAttribute("message", "hab details inserted successfully");
				
	}else{
		request.setAttribute("message", "hab details insertion failed");
		
	}
	reset(blsorgfrm);
	

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
	
}

}
