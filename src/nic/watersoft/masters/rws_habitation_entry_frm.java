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
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

public class rws_habitation_entry_frm extends Action {
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
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList constituencies=new ArrayList();
		ArrayList hcodes=new ArrayList();
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
		}
		else
			mode="habitationEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean reset = true;
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));		
		final String userId=user.getOfficeCode();
		String district=myForm.getDistrict();
		Rws_Habitation_Dyna_DAO habitation_Dyna_DAO=new Rws_Habitation_Dyna_DAO();
		try{
			if(reset)
			{
				//Debug.println("Inside if(init)");
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
				session.setAttribute("villages",villages);
				session.setAttribute("habitations",habitations);
				session.setAttribute("constituencies",constituencies);
				session.setAttribute("hcodes",hcodes);
				myForm.setHabName("");				
			}
			
			if(district == null || district.equals("")){
				district = user.getCircleOfficeCode();
				//Debug.println("circleOfficeCode1  "+district);
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				constituencies=rwsOffices.getConstituencies(district);
				session.setAttribute("constituencies",constituencies);				
			}			
			
			if(mode!=null && mode.equals("mandals"))
			{
				mandals=rwsOffices.getDistrictMandals(district);
				constituencies=rwsOffices.getConstituencies(district);
				session.setAttribute("mandals",mandals);
				session.setAttribute("constituencies",constituencies);
				
			}
			if(mode!=null && mode.equals("panchayats"))
			{
				/*
				 mandals=rwsOffices.getDistrictMandals(district);
				 session.setAttribute("mandals",mandals);
				 */
				mandals=rwsOffices.getDistrictMandals(district);
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				constituencies=rwsOffices.getConstituencies(district);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
				session.setAttribute("constituencies",constituencies);
				request.setAttribute("mode","habitationEdit");
				
			}
			if(mode!=null && mode.equals("villages"))
			{
				
				constituencies=rwsOffices.getConstituencies(district);
				session.setAttribute("constituencies",constituencies);
				
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				
				villages=rwsOffices.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				request.setAttribute("mode","habitationEdit");
				
			}
			if(mode!=null && mode.equals("habitations"))
			{
				
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
				request.setAttribute("mode","habitationEdit");
				
			}
			if(mode!=null && mode.equals("habName"))
			{
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
				//Debug.println("habName is "+habName);
				myForm.setHabName(habName);
				request.setAttribute("mode","habitationEdit");
				
			}
			if(mode!=null && mode.equals("view"))
			{
				ArrayList habitationDetails;
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				//String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
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
				//Debug.println((myForm.getDistrict()+myForm.getMandal()+mandalName+myForm.getConstituency()+constituencyName+myForm.getPanchayat()+panchayatName+myForm.getVillage()+villageName+getDataSource(request)));
				habitationDetails=habitation_Dyna_DAO.getHabitationDetails(myForm.getDistrict(),myForm.getMandal(),mandalName,myForm.getConstituency(),constituencyName,myForm.getPanchayat(),panchayatName,myForm.getVillage(),villageName,getDataSource(request));
				
				//Debug.println("habitationDetails sizes is "+habitationDetails.size());
				session.setAttribute("habitationDetails",habitationDetails);
			}
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList habitationDetails;
							
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				//String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
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
				//Debug.println((request.getParameter("dcode")+request.getParameter("mcode")+mandalName+request.getParameter("acode")+constituencyName+request.getParameter("pcode")+panchayatName+request.getParameter("vcode")+villageName+getDataSource(request)));
				habitationDetails=habitation_Dyna_DAO.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),mandalName,request.getParameter("acode"),constituencyName,request.getParameter("pcode"),panchayatName,request.getParameter("vcode"),villageName,getDataSource(request));
				
				//Debug.println("habitationDetails sizes is "+habitationDetails.size());
				session.setAttribute("habitationDetails",habitationDetails);
			}
			
			if(mode!=null && mode.equals("habitationEdit"))
			{			
				
				panchayats=new ArrayList();
				villages=new ArrayList();
				habitations=new ArrayList();
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setConstituency(request.getParameter("acode"));
				myForm.setMandal(request.getParameter("mcode"));
				myForm.setPanchayat(request.getParameter("pcode"));
				myForm.setVillage(request.getParameter("vcode"));
				myForm.setHabitation(request.getParameter("habCode"));
				//Debug.println("habCode is "+request.getParameter("habCode"));
				
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
				
				//Debug.println("mandals sizse is "+mandals.size());
				//Debug.println("habitations sizse is "+habitations.size());
			//	Debug.println("pcode is "+request.getParameter("pcode"));
				request.setAttribute("pcode",request.getParameter("pcode"));
				//String habName=rwsOffices.getHabitationName(getDataSource(request),request.getParameter("habCode"));
				//Debug.println("habName is "+habName);
				//myForm.setHabName(request.getParameter("habName"));
				myForm.setHabName(rwsOffices.getHabitationName(getDataSource(request),request.getParameter("habCode")));
				//Debug.println("habName is "+request.getParameter("habName"));
				//request.setAttribute("pname",pname);
				request.setAttribute("mode","habitationEdit");
				
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
				    	if(!validator.aphaWithSpaceDotValidator(request.getParameter("habName"))) {
				    		flag2=false;
				    		request.setAttribute("message","Habitation Name Must be In Text format");		
				    		mode="close";		    		
				    		
				    	}else
				    		flag2=true;
				    	//System.out.println(flag2+"   flag2");
				    	if(flag2) {		
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
						//Debug.println("habName is "+habName);
						myForm.setHabName(habName);
						
						if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
						{
							
							int rcount=rwsHabStatusData.insertHabitation(getDataSource(request),myForm.getHabitation(),request.getParameter("habName"));
							if(rcount>0)
							{
								request.setAttribute("message","Record Updated Successfully");
								//mode added by swapna on 5-08-2011
								mode="close";
							}else
							{
								request.setAttribute("message","Record Cannot be Updated");
							request.setAttribute("mode","habitationEdit");
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
			    	 boolean flag3=false;
			    	ValidationUtils validator=new ValidationUtils();
			    	if(!validator.numValidator(myForm.getHcode()) && validator.maxLenghtValidator(myForm.getHcode(), 2)) {
			    		request.setAttribute("message","HCode Must be In Numbers and 2 digit length");					
						request.setAttribute("mode","data");	
						flag1=false;
			    	}else 
			    		flag1=true;
			    	if(!validator.numValidator(myForm.getPrcode()) && validator.maxLenghtValidator(myForm.getPrcode(), 2)) {
			    		request.setAttribute("message","PRCode Must be In Numbers and 2 digit length");					
						request.setAttribute("mode","data");	
						flag3=false;
			    	}else 
			    		flag3=true;
			    	if(!validator.aphaWithSpaceDotValidator(myForm.getPrHabName())) {
			    		request.setAttribute("message","Habitation Name Must be In Text format");					
						request.setAttribute("mode","data");
						flag2=false;
			    	}else
			    		flag2=true;
			    	
			    	if(flag1 && flag2 && flag3){
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
						
						if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
						{
							String msg=rwsHabStatusData.insertNewHabitation(getDataSource(request),myForm.getDistrict(),myForm.getConstituency(),myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage(),myForm.getHcode(),myForm.getPrcode(),myForm.getPrHabName());
							request.setAttribute("message",msg);					
							request.setAttribute("mode","habitationNew");
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
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				{
					int rcounts[]=rwsHabStatusData.deleteHabitation(request.getParameter("habCode"),getDataSource(request));
					//Debug.println(request.getParameter("dcode")+request.getParameter("mcode")+request.getParameter("mandalName")+request.getParameter("pcode")+request.getParameter("constituencyName")+request.getParameter("pcode")+request.getParameter("panchayatName")+request.getParameter("vcode")+request.getParameter("villageName")+getDataSource(request));
					//ArrayList habitationDetails=rwsHabStatusData.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),mandalName,request.getParameter("pcode"),request.getParameter("constituencyName"),request.getParameter("pcode"),request.getParameter("panchayatName"),request.getParameter("village"),request.getParameter("villageName"),getDataSource(request));
					ArrayList habitationDetails=rwsHabStatusData.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("mandalName"),request.getParameter("acode"),request.getParameter("constituencyName"),request.getParameter("pcode"),request.getParameter("panchayatname"),request.getParameter("vcode"),request.getParameter("villageName"),getDataSource(request));
					//Debug.println("habitationDetails sizes is "+habitationDetails.size());
					session.setAttribute("habitationDetails",habitationDetails);
					boolean inserted=true;
					String msg="";
					for(int i=0;i<rcounts.length;i++)
					{
						if(i==4 || i==5 || i==6)
						{
							if(rcounts[i]==0)
							{
								msg="Record Cannot Be Deleted";
								inserted=false;
							}
						}
					}
					if(inserted)
						msg="Record Deleted Successfully";
					request.setAttribute("message",msg);
				}
				else
				{
					request.setAttribute("message","Request cannot be processed as records have been freezed");					
				}
			}
			if(mode!=null && mode.equals("addNew"))
			{
				/*
				 Debug.println("in addNew mode");
				 myForm.setDistrict(request.getParameter("district"));
				 Debug.println("dcode is "+request.getParameter("district"));
				 myForm.setMandal(request.getParameter("mandal"));
				 mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				 session.setAttribute("mandals",mandals);
				 
				 Debug.println("mandals sizse is "+mandals.size());
				 //Debug.println("pcode is "+request.getParameter("pcode"));
				  request.setAttribute("pcode","");
				  //String pname=rwsOffices.getPanchayatName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				   //Debug.println("pname is "+pname);
				    myForm.setPname("");
				    //request.setAttribute("pname",pname);
				     request.setAttribute("mode","habitationNew");
				     */
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
				
			//	if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
			//	{
				//	String habName=rwsOffices.getHabitationName(getDataSource(request),myForm.getHabitation());
				//	Debug.println("habName is "+habName);
				//	myForm.setHabName(habName);
					request.setAttribute("mode","habitationNew");
				//}
				//else
				//{
				//	request.setAttribute("message","Request cannot be processed as records have been freezed");
					
			//	}
			}
			
		}
		catch(Exception e){
			Debug.println("Exception in rws_panchayat_entry_frm is "+e);
			
		}
		return mapping.findForward(mode);
		
	}
}
