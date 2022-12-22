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
import nic.watersoft.commons.RwsLocations;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class rws_habitation_code_change_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		//System.out.println("mode is "+mode);
		}
		else
		mode="habitationEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean reset = true;
		
		HttpSession session=request.getSession();
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String district=myForm.getDistrict();
		try{
		
			
			if(reset)
			{
				//System.out.println("Inside if(init)");
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
				district = user.getCircleOfficeCode();//System.out.println("circleOfficeCode1  "+district);
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				request.setAttribute("districtName",dname);
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
			//System.out.println("habName is "+habName);
			myForm.setHabName(habName);
			request.setAttribute("mode","habitationEdit");
			
		}
			if(mode!=null && mode.equals("view"))
			{
				ArrayList habitationDetails=null;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				//////habitationDetails=rwsHabStatusData.getHabitationDetails(myForm.getDistrict(),myForm.getMandal(),getDataSource(request));
				//System.out.println("habitationDetails sizes is "+habitationDetails.size());
				session.setAttribute("habitationDetails",habitationDetails);
			}
			/*
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				panchayatDetails=rwsHabStatusData.getPanchayatDetails(myForm.getDistrict(),myForm.getMandal(),getDataSource(request));
				//System.out.println("panchayatDetails sizes is "+panchayatDetails.size());
				session.setAttribute("panchayatDetails",panchayatDetails);
			}
			*/
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
				myForm.setHcode(request.getParameter("habCode").substring(10,12));
				myForm.setPrcode(request.getParameter("habCode").substring(14,16));
				myForm.setHabitation(request.getParameter("habCode"));
				myForm.setExistingHabCode(request.getParameter("habCode"));
				myForm.setHabCode(request.getParameter("habCode"));
				
				
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
				
				//System.out.println("mandals sizse is "+mandals.size());
				//System.out.println("habitations sizse is "+habitations.size());
				//System.out.println("pcode is "+request.getParameter("pcode"));
				request.setAttribute("pcode",request.getParameter("pcode"));
				String habName=rwsOffices.getHabitationName(getDataSource(request),request.getParameter("habCode"));
				//System.out.println("habName is "+habName);
				myForm.setPrHabName(habName);
				//request.setAttribute("pname",pname);
				request.setAttribute("mode","habitationEdit");
			}
			
			if(mode!=null && mode.equals("save"))
			{
				
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
				//System.out.println("habName is "+habName);
				myForm.setHabName(habName);
				
				
				
				int rcount=rwsHabStatusData.insertHabitation(getDataSource(request),myForm.getHabitation(),request.getParameter("habName"));
				if(rcount>0)
					request.setAttribute("message","Record Updated Successfully");
				else
					request.setAttribute("message","Record Cannot be Updated");
				request.setAttribute("mode","habitationEdit");
			}
			if(mode!=null && mode.equals("saveNew"))
			{
				
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
			
				
				//String msg=rwsHabStatusData.insertNewPanchayat(getDataSource(request),myForm.getDistrict(),myForm.getConstituency(),myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage(),myForm.getHcode(),myForm.getPrcode(),myForm.getPrHabName());
				
					//request.setAttribute("message",msg);
				
				request.setAttribute("mode","habitationNew");
			}
			if(mode!=null && mode.equals("delete"))
			{
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				
				int rcounts[]=rwsHabStatusData.deleteHabitation(request.getParameter("habCode"),getDataSource(request));
				ArrayList habitationDetails=null;
				//////////////ArrayList habitationDetails=rwsHabStatusData.getHabitationDetails(request.getParameter("dcode"),request.getParameter("mcode"),getDataSource(request));
				//System.out.println("habitationDetails sizes is "+habitationDetails.size());
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
			if(mode!=null && mode.equals("addNew"))
			{
				/*
				//System.out.println("in addNew mode");
				myForm.setDistrict(request.getParameter("district"));
				//System.out.println("dcode is "+request.getParameter("district"));
				myForm.setMandal(request.getParameter("mandal"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals",mandals);
				
				//System.out.println("mandals sizse is "+mandals.size());
				////System.out.println("pcode is "+request.getParameter("pcode"));
				request.setAttribute("pcode","");
				//String pname=rwsOffices.getPanchayatName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				////System.out.println("pname is "+pname);
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
				
				
				String habName=rwsOffices.getHabitationName(getDataSource(request),myForm.getHabitation());
				//System.out.println("habName is "+habName);
				myForm.setHabName(habName);
				request.setAttribute("mode","habitationNew");
				
			}
		
		}
		catch(Exception e){
			//System.out.println("Exception in rws_panchayat_entry_frm is "+e);
			
		}
		return mapping.findForward(mode);
		
	}
}
