
package nic.watersoft.masters;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
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

public class Rws_Habitation_Safe_Suplly_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		HttpSession session = request.getSession();
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			session.setAttribute("status", "No");
			mode = "habSafeSuplyEntry";
		}
 
		Rws_Habitation_Safe_Suplly_Form myForm = (Rws_Habitation_Safe_Suplly_Form) form;
		ArrayList districts = new ArrayList();
		ArrayList mandals1 = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList villages = new ArrayList();
		ArrayList habitations = new ArrayList();
		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		
		final String userId = user.getUserId();
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(userId) ) )) {
			return mapping.findForward("unAuthorise");	
		}
		
		
		String circle=userId.substring(1,3);
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_Habitation_Safe_Suplly_DAO dao=new Rws_Habitation_Safe_Suplly_DAO();
		

		String district = myForm.getDistrict();

		try {

			
			if (mode != null && mode.equals("init")) {
				
				reset(myForm,session);
				mode="habSafeSuplyEntry";
			
			}
			
			if(userId.equals("admin") || userId.equals("100000") || userId.equals("1000DR") )
			{
			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			mandals1 = rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals1", mandals1);
			}
			
			else
			{
				String dname = rwsOffices.getDistrictName(circle);
				myForm.setDistrict(circle);
				myForm.setDistrictName(dname);
				mandals1 = rwsOffices.getDistrictMandals(circle);
				session.setAttribute("mandals1", mandals1);
			}
			
			
			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			mandals1 = rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals1", mandals1);
			panchayats = rwsOffices.getPanchayats(district, myForm
					.getMandal());
			session.setAttribute("panchayats", panchayats);
			villages = rwsOffices.getVillages(district, myForm.getMandal(), myForm.getPanchayat());
			
			session.setAttribute("villages", villages);
			habitations=dao.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
			session.setAttribute("habitations", habitations);

			if (district == null || district.equals("")) {
				district = user.getCircleOfficeCode();
				String dname = rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals1 = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals1", mandals1);
			}

			if (mode != null && mode.equals("mandals1")) {
				mandals1 = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals1", mandals1);

			}
			if (mode != null && mode.equals("panchayats")) {
				mandals1 = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals1", mandals1);
				panchayats = rwsOffices.getPanchayats(district, myForm
						.getMandal());
				session.setAttribute("panchayats", panchayats);

			}
			if (mode != null && mode.equals("villages")) {
				mandals1 = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals1", mandals1);
				panchayats = rwsOffices.getPanchayats(district, myForm
						.getMandal());
				session.setAttribute("panchayats", panchayats);
				villages = rwsOffices.getVillages(district, myForm.getMandal(), myForm.getPanchayat());
				
				session.setAttribute("villages", villages);

			}
			if (mode != null && mode.equals("habitations")) {
				mandals1 = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals1", mandals1);
				panchayats = rwsOffices.getPanchayats(district, myForm
						.getMandal());
				session.setAttribute("panchayats", panchayats);
				villages = rwsOffices.getVillages(district, myForm.getMandal(), myForm.getPanchayat());
				
				session.setAttribute("villages", villages);
				habitations = dao.getHabitations(myForm
						.getDistrict(),myForm.getMandal(),
						myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations", habitations);
				
				
			}
			if (mode != null && mode.equals("view")) {
				ArrayList pws=new ArrayList();
				ArrayList pwsLinks=new ArrayList();
				ArrayList cpws=new ArrayList();
				ArrayList cpwsLinks=new ArrayList();
				ArrayList mpws=new ArrayList();
				ArrayList mpwsLinks=new ArrayList();
				ArrayList hp=new ArrayList();
				ArrayList shp=new ArrayList();
				ArrayList others=new ArrayList();
				ArrayList reservoirs=new ArrayList();
				ArrayList dps=new ArrayList();
				ArrayList dpLinks=new ArrayList();
				ArrayList ppmValues=new ArrayList();
				ArrayList cpwsResLinks=new ArrayList();
				
				
				pws=dao.getHabitaionPWSSafeSupply(myForm,session);
				session.setAttribute("pws", pws);
				myForm.setPws(pws);
				
				pwsLinks=dao.getHabitaionPWSLinksSafeSupply(myForm,session);
				session.setAttribute("pwsLinks", pwsLinks);
				myForm.setPwsLinks(pwsLinks);
				
				cpws=dao.getHabitaionCPWSSafeSupply(myForm,session);
				session.setAttribute("cpws", cpws);
				myForm.setCpws(cpws);
				
				cpwsLinks=dao.getHabitaionCPWSLinksSafeSupply(myForm,session);
				session.setAttribute("cpwsLinks", cpwsLinks);
				myForm.setCpwsLinks(cpwsLinks);
				
				cpwsResLinks=dao.getHabitaionCPWSLinksResSafeSupply(myForm,session);
				session.setAttribute("cpwsResLinks", cpwsResLinks);
				myForm.setCpwsResLinks(cpwsResLinks);
				
				mpws=dao.getHabitaionMPWSSafeSupply(myForm,session);
				session.setAttribute("mpws", mpws);
				myForm.setMpws(mpws);
				
				mpwsLinks=dao.getHabitaionMPWSLinksSafeSupply(myForm,session);
				session.setAttribute("mpwsLinks", mpwsLinks);
				myForm.setMpwsLinks(mpwsLinks);
				
				dps=dao.getHabitaionDPSafeSupply(myForm,session);
				session.setAttribute("dps", dps);
				myForm.setDps(dps);
				
				dpLinks=dao.getHabitaionDPLinksSafeSupply(myForm,session);
				session.setAttribute("dpLinks", dpLinks);
				myForm.setDpLinks(dpLinks);
				
				hp=dao.getHabitaionHPSafeSupply(myForm,session);
				session.setAttribute("hp", hp);
				myForm.setHp(hp);
				
				shp=dao.getHabitaionSHPSafeSupply(myForm,session);
				session.setAttribute("shp", shp);
				myForm.setShp(shp);
				
				others=dao.getHabitaionOthersSafeSupply(myForm,session);
				session.setAttribute("others", others);
				myForm.setOthers(others);
				
				reservoirs=dao.getHabitaionReservoirsSafeSupply(myForm, session);
				session.setAttribute("reservoirs", reservoirs);
				myForm.setReservoirs(reservoirs);
				
				ppmValues=dao.getPpmValues(myForm, session);
				session.setAttribute("ppmValues", ppmValues);
				myForm.setPpmValues(ppmValues);
				
				
				
				String updateDate = dao.getHabitationUpdateDate(myForm, session);
				session.setAttribute("updateDate", updateDate);
				myForm.setUpdateDate(updateDate);
				
				//int twsSafe=myForm.getPwsHabLPCD()+myForm.getCpwsHabLPCD()+myForm.getMpwsHabLPCD()+myForm.getHpHabLPCD()+myForm.getShpHabLPCD()+myForm.getOthersHabLPCD();
				int twsSafe=myForm.getPwsHabLPCD()+myForm.getPwsHabLinkLPCD()+myForm.getCpwsHabLPCD()+myForm.getCpwsHabLinkLPCD()+myForm.getMpwsHabLPCD()+myForm.getMpwsHabLinkLPCD()+myForm.getHpHabLPCD()+myForm.getShpHabLPCD()+myForm.getOthersHabLPCD()+myForm.getDpHabLinkLPCD();
				int twsUnSafe=myForm.getPwsHabUnsafeLPCD()+myForm.getMpwsHabUnsafeLPCD()+myForm.getHpHabUnsafeLPCD()+myForm.getShpHabUnsafeLPCD()+myForm.getOthersHabUnsafeLPCD();
				
				myForm.setTotalWaterSupplySafeSource(twsSafe);
				myForm.setTotalWaterSupplyUnSafeSource(twsUnSafe);
				myForm.setTotalWaterSupplySafeUnSafe(twsSafe+twsUnSafe);
				Calendar rightNow = Calendar.getInstance();
				int year = rightNow.get(Calendar.YEAR);
				//double presentEstimatedpop = myForm.getNetPop()* Math.pow(1.01, Double.parseDouble(""+ (year - myForm.getcYear())));
				// commented 13/04/2020 // double presentEstimatedpop = myForm.getNetPop()* Math.pow(1.01, 6);
				double presentEstimatedpop = myForm.getNetPop()* Math.pow(1.01, 3);
				DecimalFormat decimalFormat=new DecimalFormat("####.##");
				//double presentEstimatedpop = myForm.getNetPop()* Math.pow(1.01, Double.parseDouble(""+ (year - myForm.getcYear())));
				myForm.setLevelOfWaterSupplyLPCD(Double.parseDouble(decimalFormat.format(twsSafe / presentEstimatedpop)));
				if(myForm.getActTotPop()>0){
					
					double presentActualPpo=myForm.getActTotPop();
					//removed ratio in LPCD as on 2020 -Nagendra 
					myForm.setNewLpcd(Double.parseDouble(decimalFormat.format(twsSafe / presentActualPpo)));
					}
					else
					{
						myForm.setNewLpcd(Double.parseDouble(decimalFormat.format(0.00)));
					}
				
			}
			
			if (mode != null && mode.equals("save")) {
				
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    
			    if (storedToken.equals(token))
			    {
				String message="";
				int pwsHablpd=0;
				int pwsSourcelpd=0;
				int mpwsHablpd=0;
				int mpwsSourcelpd=0;
				int dpHablpd=0;
				int dpSourcelpd=0;
				int cpwsHablpd=0;
				int cpwsSourcelpd=0;
				int hpHablpd=0;
				int hpSourcelpd=0;
				int shpHablpd=0;
				int shpSourcelpd=0;
				int othersHablpd=0;
				int othersSourcelpd=0;
				int pwsHablpdunsafe=0;
				int pwsSourcelpdunsafe=0;
				int mpwsHablpdunsafe=0;
				int mpwsSourcelpdunsafe=0;
				int dpHablpdunsafe=0;
				int dpSourcelpdunsafe=0;
				int hpHablpdunsafe=0;
				int hpSourcelpdunsafe=0;
				int shpHablpdunsafe=0;
				int shpSourcelpdunsafe=0;
				int othersHablpdunsafe=0;
				int othersSourcelpdunsafe=0;
				int pwsLinksHablpd=0;
				int pwsLinksSourcelpd=0;
				int pwsLinksHablpdunsafe=0;
				int pwsLinksSourcelpdunsafe=0;
				int mpwsLinksHablpd=0;
				int mpwsLinksSourcelpd=0;
				int mpwsLinksHablpdunsafe=0;
				int mpwsLinksSourcelpdunsafe=0;
				int dpLinksHablpd=0;
				int dpLinksSourcelpd=0;
				int dpLinksHablpdunsafe=0;
				int dpLinksSourcelpdunsafe=0;
				
				for (int i = 0; i < myForm.getPws().size(); i++) {					
					Rws_Habitation_Safe_Suplly_Form pwsRecord = myForm.getPws().get(i);
					pwsHablpd=myForm.getPwsHabLPCD();
					pwsHablpdunsafe=myForm.getPwsHabUnsafeLPCD();
					if(pwsRecord.getTableName().equals("source")){
					pwsSourcelpd+=pwsRecord.getPwsSafeLPCD();
					pwsSourcelpdunsafe+=pwsRecord.getPwsUnSafeLPCD();
					}
				}			
				
				for (int i = 0; i < myForm.getMpws().size(); i++) {	
					Rws_Habitation_Safe_Suplly_Form mpwsRecord = myForm.getMpws().get(i);
					mpwsHablpd=myForm.getMpwsHabLPCD();
					mpwsHablpdunsafe=myForm.getMpwsHabUnsafeLPCD();
					if(mpwsRecord.getTableName().equals("source")){
					mpwsSourcelpd+=mpwsRecord.getMpwsSafeLPCD();
					mpwsSourcelpdunsafe+=mpwsRecord.getMpwsUnSafeLPCD();
					}
				}
				
				for (int i = 0; i < myForm.getDps().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form dpRecord = myForm.getDps().get(i);
					dpHablpd=myForm.getDpHabLPCD();
					dpHablpdunsafe=myForm.getDpHabUnsafeLPCD();
					if(dpRecord.getTableName().equals("source")){
					dpSourcelpd+=dpRecord.getOthersSafeLPCD();
					dpSourcelpdunsafe+=dpRecord.getOthersUnSafeLPCD();
					}
				}
				
				for (int i = 0; i < myForm.getCpws().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form cpwsRecord = myForm.getCpws().get(i);
					cpwsHablpd=myForm.getCpwsHabLPCD();
					if(cpwsRecord.getTableName().equals("source")){
					cpwsSourcelpd+=cpwsRecord.getCpwsSafeLPCD();
					}
				}
				
				
				for (int i = 0; i < myForm.getHp().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form hpRecord = myForm.getHp().get(i);
					hpHablpd=myForm.getHpHabLPCD();
					hpSourcelpd+=hpRecord.getHpSafeLPCD();
					hpHablpdunsafe=myForm.getHpHabUnsafeLPCD();
					hpSourcelpdunsafe+=hpRecord.getHpUnSafeLPCD();
				}
				
				
				for (int i = 0; i < myForm.getShp().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form shpRecord = myForm.getShp().get(i);
					shpHablpd=myForm.getShpHabLPCD();
					shpSourcelpd+=shpRecord.getShpSafeLPCD();
					shpHablpdunsafe=myForm.getShpHabUnsafeLPCD();
					shpSourcelpdunsafe+=shpRecord.getShpUnSafeLPCD();
				}
					
				
				for (int i = 0; i < myForm.getOthers().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form othersRecord = myForm.getOthers().get(i);
					othersHablpd=myForm.getOthersHabLPCD();
					othersSourcelpd+=othersRecord.getOthersSafeLPCD();
					othersHablpdunsafe=myForm.getOthersHabUnsafeLPCD();
					othersSourcelpdunsafe+=othersRecord.getOthersUnSafeLPCD();
				}
				
				for (int i = 0; i < myForm.getPwsLinks().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form pwsLinksRecord = myForm.getPwsLinks().get(i);
					pwsLinksHablpd=myForm.getPwsHabLinkLPCD();
					pwsLinksHablpdunsafe=myForm.getPwsHabLinkUnsafeLPCD();
					if(pwsLinksRecord.getTableName().equals("source")) {
					pwsLinksSourcelpd+=pwsLinksRecord.getPwsLinksSafeLPCD();					
					pwsLinksSourcelpdunsafe+=pwsLinksRecord.getPwsLinksUnSafeLPCD();			
					}					
				}
				for (int i = 0; i < myForm.getMpwsLinks().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form mpwsLinksRecord = myForm.getMpwsLinks().get(i);
					mpwsLinksHablpd=myForm.getMpwsHabLinkLPCD();
					mpwsLinksHablpdunsafe=myForm.getMpwsHabLinkUnsafeLPCD();
					if(mpwsLinksRecord.getTableName().equals("source")) {
					mpwsLinksSourcelpd+=mpwsLinksRecord.getMpwsLinksSafeLPCD();				
					mpwsLinksSourcelpdunsafe+=mpwsLinksRecord.getMpwsLinksUnSafeLPCD();	
					}				
				}	
				for (int i = 0; i < myForm.getDpLinks().size(); i++) {
					Rws_Habitation_Safe_Suplly_Form dpLinksRecord = myForm.getDpLinks().get(i);
					dpLinksHablpd=myForm.getDpHabLinkLPCD();
					dpLinksSourcelpd+=dpLinksRecord.getDpLinksSafeLPCD();
					dpLinksHablpdunsafe=myForm.getDpHabLinkUnsafeLPCD();
					dpLinksSourcelpdunsafe+=dpLinksRecord.getDpLinksUnSafeLPCD();					
				}
				if(pwsHablpd!=pwsSourcelpd){
					message="PWS Total Sources LPD:"+pwsSourcelpd+" Should be equal to habitation PWS Supply LPD:"+pwsHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(pwsHablpdunsafe!=pwsSourcelpdunsafe){
					message="PWS Total Sources Unsafe LPD:"+pwsSourcelpdunsafe+" Should be equal to habitation PWS Supply Unsafe LPD:"+pwsHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(mpwsHablpd!=mpwsSourcelpd){
					message="MPWS Total Sources LPD:"+mpwsSourcelpd+" Should be equal to habitation MPWS Supply LPD:"+mpwsHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(mpwsHablpdunsafe!=mpwsSourcelpdunsafe){
					message="MPWS Total Sources Unsafe LPD:"+mpwsSourcelpdunsafe+" Should be equal to habitation MPWS Supply Unsafe LPD:"+mpwsHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(dpHablpd!=dpSourcelpd){
					message="Direct Pumping Total Sources LPD:"+dpSourcelpd+" Should be equal to habitation Direct Pumping Supply LPD:"+dpHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(dpHablpdunsafe!=dpSourcelpdunsafe){
					message="Direct Pumping Total Sources Unsafe LPD:"+dpSourcelpdunsafe+" Should be equal to habitation Direct Pumping Supply Unsafe LPD:"+dpHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(cpwsHablpd!=cpwsSourcelpd){
					message="CPWS Total Sources LPD:"+cpwsSourcelpd+" Should be equal to habitation CPWS Supply LPD:"+cpwsHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(hpHablpd!=hpSourcelpd){
					message="Hand Pumps Total Sources LPD:"+hpSourcelpd+" Should be equal to habitation Hand Pumps Supply LPD:"+hpHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(hpHablpdunsafe!=hpSourcelpdunsafe){
					message="Hand Pumps Total Sources Unsafe LPD:"+hpSourcelpdunsafe+" Should be equal to habitation Hand Pumps Supply Unsafe LPD:"+hpHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(shpHablpd!=shpSourcelpd){
					message="Shallow Hand Pumps Total Sources LPD:"+shpSourcelpd+" Should be equal to habitation Shallow Hand Pumps Supply LPD:"+shpHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(shpHablpdunsafe!=shpSourcelpdunsafe){
					message="Shallow Hand Pumps Total Sources Unsafe LPD:"+shpSourcelpdunsafe+" Should be equal to habitation Shallow Hand Pumps Supply Unsafe LPD:"+shpHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(othersHablpd!=othersSourcelpd){
					message="Others Total Sources LPD:"+othersSourcelpd+" Should be equal to habitation Others Supply LPD:"+othersHablpd;
					request.setAttribute("message", message);
					mode="view";
				}
				else if(othersHablpdunsafe!=othersSourcelpdunsafe){
					message="Others Total Sources Unsafe LPD:"+othersSourcelpdunsafe+" Should be equal to habitation Others Supply Unsafe LPD:"+othersHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}else if(pwsLinksHablpd!=pwsLinksSourcelpd){
					message="PWS Linked Total Sources Safe LPD:"+pwsLinksSourcelpd+" Should be equal to habitation PWS Linked Supply Safe LPD:"+pwsLinksHablpd;
					request.setAttribute("message", message);
					mode="view";
				}else if(pwsLinksHablpdunsafe!=pwsLinksSourcelpdunsafe){
					message="PWS Linked Total Sources Unsafe LPD:"+pwsLinksSourcelpdunsafe+" Should be equal to habitation PWS Linked Supply Unsafe LPD:"+pwsLinksHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}else if(mpwsLinksHablpd!=mpwsLinksSourcelpd){
					message="MPWS Linked Total Sources Safe LPD:"+mpwsLinksSourcelpd+" Should be equal to habitation MPWS Linked Supply Safe LPD:"+mpwsLinksHablpd;
					request.setAttribute("message", message);
					mode="view";
				}else if(mpwsLinksHablpdunsafe!=mpwsLinksSourcelpdunsafe){
					message="MPWS Linked Total Sources Unsafe LPD:"+mpwsLinksSourcelpdunsafe+" Should be equal to habitation MPWS Linked Supply Unsafe LPD:"+mpwsLinksHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}else if(dpLinksHablpd!=dpLinksSourcelpd){
					message="Direct Pumping Linked Total Sources Safe LPD:"+dpLinksSourcelpd+" Should be equal to habitation Direct Pumping Linked Supply Safe LPD:"+dpLinksHablpd;
					request.setAttribute("message", message);
					mode="view";
				}else if(dpLinksHablpdunsafe!=dpLinksSourcelpdunsafe){
					message="Direct Pumping Linked Total Sources Unsafe LPD:"+dpLinksSourcelpdunsafe+" Should be equal to habitation Direct Pumping Linked Supply Unsafe LPD:"+dpLinksHablpdunsafe;
					request.setAttribute("message", message);
					mode="view";
				}else{				
				dao.saveSchemes(myForm, request);
				reset(myForm, session);
				
				mode="view";
				
				
				}
			    }	
			}
			if (mode != null && mode.equals("savePS")) {
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				dao.savePlatFormsAndSoakPits(myForm, request);
				reset(myForm, session);
				mode="view";
			    }
			}
			

		} catch (Exception e) {
			Debug.println("Exception in Rws_Habitation_Safe_Suplly_Action is " + e);

		}
		return mapping.findForward(mode);

	}


	private void reset(Rws_Habitation_Safe_Suplly_Form myForm,HttpSession session) {
		session.setAttribute("status", "No");
				
	}

}