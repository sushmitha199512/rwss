package nic.watersoft.masters;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

public class rws_village_entry_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String mode="";
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
			//Debug.println("mode is "+mode);
		}
		else
			mode="villageEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean init = true;
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		
		final String userId=user.getOfficeCode();
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));		
		String district=myForm.getDistrict();	
		try{				
			if(init)
			{
				//Debug.println("Inside if(init)");
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);				
			}			
			if(district == null || district.equals("")){
				district = user.getCircleOfficeCode();
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}			
			if(mode!=null && mode.equals("mandals"))
			{
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);				
			}
			if(mode!=null && mode.equals("panchayats"))
			{
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				
			}
			if(mode!=null && mode.equals("view"))
			{
				ArrayList villageDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
				String panchayatName=rwsOffices.getPanchayatName(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat());
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				villageDetails=rwsHabStatusData.getVillageDetails(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat(),getDataSource(request));
				//Debug.println("villageDetails sizes is "+villageDetails.size());
				session.setAttribute("villageDetails",villageDetails);
			}
			
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList villageDetails;
				//Debug.println("dcode is "+request.getParameter("dcode"));
				//Debug.println("mcode is "+request.getParameter("mcode"));
				//Debug.println("pcode is "+request.getParameter("pcode"));
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				String panchayatName=rwsOffices.getPanchayatName(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				//Debug.println("districtName is "+districtName);
			//	Debug.println("mandalName is "+mandalName);
				//Debug.println("panchayatName is "+panchayatName);
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				villageDetails=rwsHabStatusData.getVillageDetails(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),getDataSource(request));
				//Debug.println("villageDetails sizes is "+villageDetails.size());
				session.setAttribute("villageDetails",villageDetails);
			}
			
			if(mode!=null && mode.equals("villageEdit"))
			{			
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals",mandals);
				myForm.setPanchayat(request.getParameter("pcode"));
				panchayats=rwsOffices.getPanchayats(request.getParameter("dcode"),request.getParameter("mcode"));
				session.setAttribute("panchayats",panchayats);
				
			//	Debug.println("mandals sizse is "+mandals.size());
			//	Debug.println("pcode is "+request.getParameter("pcode"));
				request.setAttribute("pcode",request.getParameter("pcode"));
				request.setAttribute("vcode",request.getParameter("vcode"));
				String vname=rwsOffices.getVillageName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"));
			//	Debug.println("vname is "+vname);
				myForm.setVname(vname);
				//request.setAttribute("pname",pname);
				request.setAttribute("mode","villageEdit");
				
			}
			
			if(mode!=null && mode.equals("save"))
			{
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
			    	 boolean flag2=false;
			    	ValidationUtils validator=new ValidationUtils();
			    	if(!validator.aphaWithSpaceDotValidator(myForm.getVname())) {
			    		flag2=false;
			    		request.setAttribute("message","Village Name Must be In Text format");		
			    		return mapping.findForward("view");			    		
			    		
			    	}else
			    		flag2=true;
			    	//System.out.println(flag2+"   flag2");
			    	if(flag2) {
				//Debug.println("district is "+myForm.getDistrict()+",mandal is "+myForm.getMandal()+", Panchayat is "+request.getParameter("pcode")+",village is "+myForm.getVcode()+", village name is "+myForm.getVname());
						RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
						mandals=rwsOffices.getDistrictMandals(district);
						session.setAttribute("mandals",mandals);
						
						panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
						session.setAttribute("panchayats",panchayats);
						if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
						{
							
							int rcount=rwsHabStatusData.insertVillage(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),request.getParameter("pcode"),myForm.getVcode(),myForm.getVname());
							if(rcount>0)
							{
								//Debug.println("in village update");
								request.setAttribute("message","Record Updated Successfully");
								// mode added by swapna on 5-08-2011
								//mode="close";
								//Debug.println("in village update"+mode);
							}
							else
							{
								request.setAttribute("message","Record Cannot be Updated");
								request.setAttribute("mode","villageEdit");
							}
						}
						else
						{
							request.setAttribute("message","Request cannot be processed as records have been freezed");
						}
			    	}
			     }
			}
			if(mode!=null && mode.equals("saveNew"))
			{				
				
				 session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
			    	 boolean flag1=false;
			    	 boolean flag2=false;
			    	ValidationUtils validator=new ValidationUtils();
			    	if(!validator.numValidator(myForm.getVcode())) {
			    		request.setAttribute("message","Village Code Must be In Numbers");					
						request.setAttribute("mode","data");						
			    	}else 
			    		flag1=true;
			    	if(!validator.aphaWithSpaceDotValidator(myForm.getVname())) {
			    		request.setAttribute("message","Village Name Must be In Text format");					
						request.setAttribute("mode","data");
						flag2=false;
			    	}else
			    		flag2=true;
			    	if(flag1 && flag2){
			    		RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();			    	
						myForm.setDistrict(request.getParameter("district"));
						myForm.setPanchayat(request.getParameter("pcode"));
						mandals=rwsOffices.getDistrictMandals(district);
						session.setAttribute("mandals",mandals);
						
						panchayats=rwsOffices.getPanchayats(request.getParameter("district"),request.getParameter("mandal"));
						session.setAttribute("panchayats",panchayats);
						myForm.setPanchayat(myForm.getPanchayat());
						if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
						{
							String msg=rwsHabStatusData.insertNewVillage(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPcode(),myForm.getVcode(),myForm.getVname());
							request.setAttribute("message",msg);					
							request.setAttribute("mode","villageNew");
						}
						else
						{
							request.setAttribute("message","Request cannot be processed as records have been freezed");
						}
			    	}
			     }
			}
			if(mode!=null && mode.equals("delete"))
			{
				
				ArrayList villageDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				String panchayatName=rwsOffices.getPanchayatName(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				{
					String msg=rwsHabStatusData.deleteVillage(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"));
					villageDetails=rwsHabStatusData.getVillageDetails(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),getDataSource(request));
					//Debug.println("villageDetails sizes is "+villageDetails.size());
					session.setAttribute("villageDetails",villageDetails);
					request.setAttribute("message",msg);
				}
				else
				{
					request.setAttribute("message","Request cannot be processed as records have been freezed");
					
				}
			}
			if(mode!=null && mode.equals("addNew"))
			{
				
				
				//Debug.println("in addNew mode");
				myForm.setDistrict(request.getParameter("district"));
				//Debug.println("dcode is "+request.getParameter("district"));
				
				myForm.setMandal(request.getParameter("mandal"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals",mandals);
				
				myForm.setPanchayat(request.getParameter("panchayat"));
				panchayats=rwsOffices.getPanchayats(district,request.getParameter("mandal"));
				session.setAttribute("panchayats",panchayats);
				
				//Debug.println("mandals sizse is "+mandals.size());
				//if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				//{
					//Debug.println("pcode is "+request.getParameter("pcode"));
					//request.setAttribute("vcode","");
					//String pname=rwsOffices.getPanchayatName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
					//Debug.println("pname is "+pname);
					//myForm.setVname("");
					//request.setAttribute("pname",pname);
					request.setAttribute("mode","villageNew");
					
				//}
				//else
				//{
					//request.setAttribute("message","Request cannot be processed as records have been freezed");
					
				//}
			}
			
			
		}
		catch(Exception e){
			Debug.println("Exception in rws_village_entry_frm is "+e);
			
		}
		return mapping.findForward(mode);
		
	}
	
	
}
