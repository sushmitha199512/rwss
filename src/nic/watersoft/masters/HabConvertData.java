package nic.watersoft.masters;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class HabConvertData extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode="";
		ArrayList districts=new ArrayList();		
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList constituencies=new ArrayList();
		ArrayList hcodes=new ArrayList();		
		ArrayList mandals1=new ArrayList();
		ArrayList panchayats1=new ArrayList();
		ArrayList villages1=new ArrayList();
		ArrayList habitations1=new ArrayList();
		ArrayList constituencies1=new ArrayList();
		ArrayList hcodes1=new ArrayList();		
		ArrayList districts1=new ArrayList();
		ArrayList mandals2=new ArrayList();
		ArrayList panchayats2=new ArrayList();
		ArrayList villages2=new ArrayList();
		ArrayList habitations2=new ArrayList();
		ArrayList constituencies2=new ArrayList();
		ArrayList hcodes2=new ArrayList();
		if(request.getParameter("mode")!=null){
			mode=request.getParameter("mode");
		}
		else
			mode="habitationEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean reset = true;
		
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		if(!(user.getUserId().equals("admin") || user.getUserId().equals("100000") || user.getUserId().substring(3,6).equals("000")))
			return mapping.findForward("unauthorize");		
		final String userId=user.getOfficeCode();
		String district=myForm.getDistrict();
		try{
			if(request.getParameter("mode")==null){
				if(userId.equals("admin") || userId.equals("100000")  )
				{
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);				
				session.setAttribute("mandals1",mandals1);
				session.setAttribute("mandals2",mandals2);
				/*session.setAttribute("panchayats1",panchayats1);
				session.setAttribute("villages1",villages1);
				session.setAttribute("habitations1",habitations1);
				session.setAttribute("constituencies1",constituencies1);
				session.setAttribute("hcodes1",hcodes1);				
				
				session.setAttribute("panchayats2",panchayats2);
				session.setAttribute("villages2",villages2);
				session.setAttribute("habitations2",habitations2);
				session.setAttribute("constituencies2",constituencies2);
				session.setAttribute("hcodes2",hcodes2);
				myForm.setHabName("");
				myForm.setHabName1("");	*/
				}else{
					String circle=userId.substring(1,3);
					String dname = rwsOffices.getDistrictName(circle);
					myForm.setDistrict(circle);
					myForm.setDistrict1(circle);
					myForm.setDistrictName(dname);
					mandals1=rwsOffices.getDistrictMandals(circle);
					session.setAttribute("mandals1",mandals1);
					session.setAttribute("mandals2",mandals1);
					
				}
				session.setAttribute("panchayats1",panchayats1);
				session.setAttribute("villages1",villages1);
				session.setAttribute("habitations1",habitations1);
				session.setAttribute("constituencies1",constituencies1);
				session.setAttribute("hcodes1",hcodes1);				
				
				session.setAttribute("panchayats2",panchayats2);
				session.setAttribute("villages2",villages2);
				session.setAttribute("habitations2",habitations2);
				session.setAttribute("constituencies2",constituencies2);
				session.setAttribute("hcodes2",hcodes2);
				myForm.setHabName("");
				myForm.setHabName1("");	
			}
			
			if(mode!=null && mode.equals("exist")){
				String spmode = request.getParameter("mode1");
				if(spmode!=null && spmode.equals("mandals")){
					mandals1=rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals1",mandals1);
				}
				if(spmode!=null && spmode.equals("panchayats")){
					panchayats1=rwsOffices.getPanchayats(district,myForm.getMandal());
					session.setAttribute("panchayats1",panchayats1);
				}
				if(spmode!=null && spmode.equals("villages")){
					villages1=rwsOffices.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
					session.setAttribute("villages1",villages1);
				}
				if(spmode!=null && spmode.equals("habitations")){
					habitations1=rwsLocations.getUIHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
					session.setAttribute("habitations1",habitations1);
				}
				if(spmode!=null && spmode.equals("habName")){
					myForm.setHabName(myForm.getHabitation());
				}
			}
			if(mode!=null && mode.equals("new")){
				String spmode = request.getParameter("mode1");
				if(spmode!=null && spmode.equals("mandals")){
					mandals2=rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals2",mandals2);
				}
				if(spmode!=null && spmode.equals("panchayats"))	{
					panchayats2=rwsOffices.getPanchayats(district,myForm.getMandal1());
					session.setAttribute("panchayats2",panchayats2);
				}
				if(spmode!=null && spmode.equals("villages")){
					villages2=rwsOffices.getVillages(district,myForm.getMandal1(),myForm.getPanchayat1());
					session.setAttribute("villages2",villages2);
				}
				if(spmode!=null && spmode.equals("habitations")){
					habitations2=rwsLocations.getNewHabitations(district,myForm.getMandal1(),myForm.getPanchayat1(),myForm.getVillage1());
					session.setAttribute("habitations2",habitations2);
				}
				if(spmode!=null && spmode.equals("habName")){
					myForm.setHabName1(myForm.getHabitation1());
				}
			}
			if(mode!=null && mode.equals("convert")){
				if (storedToken.equals(token)) {	
					String habCodeOld = myForm.getHabitation();
					String habCodeNew = myForm.getHabitation1();
					String coveredStatus = myForm.getCoveredStatus();
					ArrayList al = null;
					String msg = "";
					if(habCodeOld==null)
						habCodeOld = request.getParameter("oldCode");
					if(habCodeNew==null)
						habCodeNew = request.getParameter("newCode");
					if(coveredStatus==null)
						coveredStatus = request.getParameter("coveredStatus");
					try{
						HabConvertDao hd = new HabConvertDao();
						al = hd.covertOldHabToNewHab(habCodeOld,habCodeNew,coveredStatus);
						session.setAttribute("report",al.get(1));
						session.setAttribute("iter",al.get(2));
						msg = (String)al.get(0);
						mode = "showMsg";
					}
					catch(Exception e){
						msg = "Error Occured While Convertion - Please Contact Admin";
					}
					request.setAttribute("message",msg);
					return mapping.findForward(mode);
				}
			}
			if(mode!=null && mode.equals("view"))
			{
				ArrayList habitationDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=request.getParameter("mandalName");
				String constituencyName=request.getParameter("constituencyName");
				String panchayatName=request.getParameter("panchayatName");
				String villageName=request.getParameter("villageName");
				request.setAttribute("selectedDistrictCode",myForm.getDistrict());
				request.setAttribute("selectedDistrictName",districtName);
				request.setAttribute("selectedMandalCode",myForm.getMandal());
				request.setAttribute("selectedMandalName",mandalName);
				request.setAttribute("selectedConstituencyCode",myForm.getConstituency());
				request.setAttribute("selectedConstituencyName",constituencyName);
				request.setAttribute("selectedPanchayatCode",myForm.getPanchayat());
				request.setAttribute("selectedPanchayatName",panchayatName);
				request.setAttribute("selectedVillageCode",myForm.getVillage());
				request.setAttribute("selectedVillageName",villageName);
				habitationDetails=rwsHabStatusData.getHabitationDetails(myForm.getDistrict(),myForm.getMandal(),mandalName,myForm.getConstituency(),constituencyName,myForm.getPanchayat(),panchayatName,myForm.getVillage(),villageName,getDataSource(request));
				
				session.setAttribute("habitationDetails",habitationDetails);
			}
			if(mode!=null && mode.equals("excelView")){
				ArrayList habitationDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=request.getParameter("mname");
				String constituencyName=request.getParameter("aname");
				String panchayatName=request.getParameter("pname");
				String villageName=request.getParameter("vname");
				request.setAttribute("selectedDistrictCode",request.getParameter("dcode"));
				request.setAttribute("selectedDistrictName",districtName);
				request.setAttribute("selectedMandalCode",request.getParameter("mcode"));
				request.setAttribute("selectedMandalName",mandalName);
				request.setAttribute("selectedConstituencyCode",request.getParameter("acode"));
				request.setAttribute("selectedConstituencyName",constituencyName);
				request.setAttribute("selectedPanchayatCode",request.getParameter("pcode"));
				request.setAttribute("selectedPanchayatName",panchayatName);
				request.setAttribute("selectedVillageCode",request.getParameter("vcode"));
				request.setAttribute("selectedVillageName",villageName);
				habitationDetails=rwsHabStatusData.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),mandalName,request.getParameter("acode"),constituencyName,request.getParameter("pcode"),panchayatName,request.getParameter("vcode"),villageName,getDataSource(request));
				
				session.setAttribute("habitationDetails",habitationDetails);
			}
			
			if(mode!=null && mode.equals("habitationEdit")){				
				if (storedToken.equals(token)) {	
					panchayats=new ArrayList();
					villages=new ArrayList();
					habitations=new ArrayList();
					myForm.setDistrict(request.getParameter("dcode"));
					myForm.setConstituency(request.getParameter("acode"));
					myForm.setMandal(request.getParameter("mcode"));
					myForm.setPanchayat(request.getParameter("pcode"));
					myForm.setVillage(request.getParameter("vcode"));
					myForm.setHabitation(request.getParameter("habCode"));
					
					mandals=rwsOffices.getDistrictMandals(request.getParameter("dcode"));
					session.setAttribute("mandals",mandals);
					
					constituencies=rwsOffices.getConstituencies(request.getParameter("dcode"));
					session.setAttribute("constituencies",constituencies);
	
					panchayats=rwsOffices.getPanchayats(request.getParameter("dcode"),request.getParameter("mcode"));
					session.setAttribute("panchayats",panchayats);
					
					villages=rwsOffices.getVillages(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
					session.setAttribute("villages",villages);
					
					habitations=rwsLocations.getHabitations(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"));
					session.setAttribute("habitations",habitations);
					
					request.setAttribute("pcode",request.getParameter("pcode"));
					myForm.setHabName(rwsOffices.getHabitationName(getDataSource(request),request.getParameter("habCode")));
					request.setAttribute("mode","habitationEdit");
				}
					
			}
			
			if(mode!=null && mode.equals("save")){	
				if (storedToken.equals(token)) {				
					RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();				
					
					mandals=rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals",mandals);
					
					constituencies=rwsOffices.getConstituencies(district);
					session.setAttribute("constituencies",constituencies);
					
					panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
					session.setAttribute("panchayats",panchayats);
					
					villages=rwsOffices.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
					session.setAttribute("villages",villages);
					
					habitations=rwsLocations.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
					session.setAttribute("habitations",habitations);
									
					String habName=rwsOffices.getHabitationName(getDataSource(request),myForm.getHabitation());
					myForm.setHabName(habName);
					
					if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId)){					
						int rcount=rwsHabStatusData.insertHabitation(getDataSource(request),myForm.getHabitation(),request.getParameter("habName"));
						if(rcount>0)
							request.setAttribute("message","Record Updated Successfully");
						else
							request.setAttribute("message","Record Cannot be Updated");
						request.setAttribute("mode","habitationEdit");
					}
					else {
						request.setAttribute("message","Request cannot be processed as records have been freezed");
					}
				}
			}
			
			if(mode!=null && mode.equals("saveNew")){
				if (storedToken.equals(token)) {	
					RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
					myForm.setDistrict(request.getParameter("district"));
					
					mandals=rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals",mandals);
					
					constituencies=rwsOffices.getConstituencies(district);
					session.setAttribute("constituencies",constituencies);
					
					panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
					session.setAttribute("panchayats",panchayats);
					
					villages=rwsOffices.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
					session.setAttribute("villages",villages);
					
					if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId)){
						String msg=rwsHabStatusData.insertNewHabitation(getDataSource(request),myForm.getDistrict(),myForm.getConstituency(),myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage(),myForm.getHcode(),myForm.getPrcode(),myForm.getPrHabName());
						request.setAttribute("message",msg);
						request.setAttribute("mode","habitationNew");
					}
					else {
						request.setAttribute("message","Request cannot be processed as records have been freezed");
					}
				}
			}
			if(mode!=null && mode.equals("delete")){
				
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);				
				request.setAttribute("selectedDistrictCode",request.getParameter("dcode"));
				request.setAttribute("selectedDistrictName",districtName);
				request.setAttribute("selectedMandalCode",request.getParameter("mcode"));
				request.setAttribute("selectedMandalName",request.getParameter("mandalName"));
				request.setAttribute("selectedConstituencyCode",request.getParameter("acode"));
				request.setAttribute("selectedConstituencyName",request.getParameter("constituencyName"));
				request.setAttribute("selectedPanchayatCode",request.getParameter("pcode"));
				request.setAttribute("selectedPanchayatName",request.getParameter("panchayatName"));
				request.setAttribute("selectedVillageCode",request.getParameter("vcode"));
				request.setAttribute("selectedVillageName",request.getParameter("villageName"));
				
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId)){
					int rcounts[]=rwsHabStatusData.deleteHabitation(request.getParameter("habCode"),getDataSource(request));
					ArrayList habitationDetails=rwsHabStatusData.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("mandalName"),request.getParameter("acode"),request.getParameter("constituencyName"),request.getParameter("pcode"),request.getParameter("panchayatname"),request.getParameter("vcode"),request.getParameter("villageName"),getDataSource(request));
					session.setAttribute("habitationDetails",habitationDetails);
					boolean inserted=true;
					String msg="";
					for(int i=0;i<rcounts.length;i++){
						if(i==4 || i==5 || i==6){
							if(rcounts[i]==0){
								msg="Record Cannot Be Deleted";
								inserted=false;
							}
						}
					}
					if(inserted)
						msg="Record Deleted Successfully";
						request.setAttribute("message",msg);
					}
					else{
						request.setAttribute("message","Request cannot be processed as records have been freezed");					
					}
			}
			
			if(mode!=null && mode.equals("addNew")){
				
				constituencies=rwsOffices.getConstituencies(district);
				session.setAttribute("constituencies",constituencies);
				
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				
				villages=rwsOffices.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				
				habitations=rwsLocations.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations",habitations);
				
				request.setAttribute("mode","habitationNew");				
			}			
		}
		catch(Exception e){
			System.out.println("The Exceptiion in HabConvertData :"+e.getMessage());	
		}
		return mapping.findForward("success");		
	}
}
