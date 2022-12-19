package nic.watersoft.smsmobile;
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
import java.util.Arrays;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
public class Rws_TVM_Entry_Frm extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String storedToken,token;
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		//System.out.println(user.getCircleOfficeCode()+"$$$$$$$$$$");
		if (user == null)
			return mapping.findForward("expire");
		/*if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}*/		
		String mode="";
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList tankers=new ArrayList();
		ArrayList volunteers=new ArrayList();
		//=new List();
		ArrayList mappedtankers=new ArrayList();
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
		}
		else
			mode="tvmEntryFrm";
		Rws_TVM_Frm myForm=(Rws_TVM_Frm)form;
		boolean reset = true;
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		String district=myForm.getDistrict();
		Rws_tvm_DAO tvm_DAO=new Rws_tvm_DAO();
		try{
			if(reset)
			{
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
				session.setAttribute("villages",villages);
				session.setAttribute("habitations",habitations);
				session.setAttribute("tankers",tankers);
				session.setAttribute("volunteers",volunteers);
			}
			
			if(district == null || district.equals(""))
			{
				district = user.getCircleOfficeCode();
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}			
			
			if(mode!=null && mode.equals("mandals"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}
			if(mode!=null && mode.equals("panchayats"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				panchayats=tvm_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
			}
			if(mode!=null && mode.equals("villages"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=tvm_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=tvm_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				
			}
			if(mode!=null && mode.equals("habitations"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=tvm_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=tvm_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				habitations=tvm_DAO.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations",habitations);
				
			}
			if(mode!=null && mode.equals("volunteer"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=tvm_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=tvm_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				habitations=tvm_DAO.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations",habitations);
				volunteers=tvm_DAO.getVolunteers(myForm.getHabitation());
				
				if(!myForm.getHabitation().isEmpty()&&volunteers.isEmpty()){
					//System.out.println("............"+myForm.getHabitation());
					request.setAttribute("message","No Volunteers registered for  particular habitation.");
				}
				
				request.setAttribute("volunteers",volunteers);
				request.setAttribute("mode",mode);
			}
			
			
			if(mode!=null && mode.equals("tanker"))
			{
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=tvm_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=tvm_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				habitations=tvm_DAO.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations",habitations);
				volunteers=tvm_DAO.getVolunteers(myForm.getHabitation());
				request.setAttribute("volunteers",volunteers);

				if(!myForm.getVolunteer().equalsIgnoreCase("00")){
			    tankers=tvm_DAO.getRegTankers(myForm.getHabitation(),myForm.getVolunteer(),district,myForm.getMandal());
			    if(tankers.isEmpty()){
			    	//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@\n$$$$$$$$$$$$$$");
			    	 request.setAttribute("message","No tankers registered for  particular habitation.");
			    }
				}
				else
				{
					
					tankers=new ArrayList();
				}
				request.setAttribute("listfromAction", tankers);
				request.setAttribute("mode",mode);
			}

			if(mode!=null && mode.equals("view"))
			{
				ArrayList habitationDetails;
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=request.getParameter("mandalName");
				String panchayatName=request.getParameter("panchayatName");
				String villageName=request.getParameter("villageName");
				request.setAttribute("selectedDistrictCode",myForm.getDistrict());
				request.setAttribute("selectedDistrictName",districtName);
				request.setAttribute("selectedMandalCode",myForm.getMandal());
				request.setAttribute("selectedMandalName",mandalName);
				request.setAttribute("selectedPanchayatCode",myForm.getPanchayat());
				request.setAttribute("selectedPanchayatName",panchayatName);
				request.setAttribute("selectedVillageCode",myForm.getVillage());
				request.setAttribute("selectedVillageName",villageName);
				habitationDetails=tvm_DAO.getHabitationTVMDetails(myForm.getDistrict(),myForm.getMandal(),mandalName,myForm.getPanchayat(),panchayatName,myForm.getVillage(),villageName,myForm.getHabitation(),myForm.getVolunteer());
				session.setAttribute("habitationDetails",habitationDetails);
			}
			
			
			if(mode!=null && mode.equals("save"))
			{
				
			      storedToken = (String)session.getAttribute("csrfToken");
			      token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
                mappedtankers=tvm_DAO.getMappedTankers(myForm.getVolunteer());
				String msg="";
				String[] checkboxes = request.getParameterValues("mycheck");
				if(checkboxes!=null){
					ArrayList<String> list=new ArrayList( Arrays.asList( checkboxes ) );
				ArrayList<String> duplicatevalues = new ArrayList<String>(list);
				ArrayList<String> uniquevalues = new ArrayList<String>(mappedtankers);
				ArrayList<String> duplicatevalues1 = new ArrayList<String>(list);
				ArrayList<String> uniquevalues1 = new ArrayList<String>(mappedtankers);
				uniquevalues.removeAll(duplicatevalues);
		        duplicatevalues1.removeAll(uniquevalues1);
		        
		     // For Each Loop for iterating ArrayList 
		        /*for (String  i : uniquevalues) 
		            System.out.print(i + "To be deleted... ");
		        
		        for (String  i : duplicatevalues1) 
		            System.out.print(i + "To be saved... ");*/
		        msg=tvm_DAO.insertTVM(myForm.getVolunteer(),duplicatevalues1,"save");
			    if(msg!="")
			    request.setAttribute("message",msg);	
				msg=tvm_DAO.deleteTVM(myForm.getVolunteer(), uniquevalues,"save");	
				
				if(msg!="")
				    request.setAttribute("message",msg);
				else
					request.setAttribute("message","Saved Successfully."); 
				
		        mode = "mandals";
				request.setAttribute("mode","mandals");
				}else
				{
				msg=tvm_DAO.deleteAllTVM(myForm.getVolunteer(), "save");	
					if(msg!="")
					    request.setAttribute("message",msg);
					 mode = "mandals";
						request.setAttribute("mode","mandals");
					
				}
				
				
			}	
			     
			}
			
			
			
			if(mode!=null && mode.equals("saveedit"))
			{
				
			      storedToken = (String)session.getAttribute("csrfToken");
			      token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
				mandals=tvm_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
                mappedtankers=tvm_DAO.getMappedTankers(myForm.getVolunteer());
				String msg="";
				String[] checkboxes = request.getParameterValues("mycheck");
				if(checkboxes!=null)
				{
					
				ArrayList<String> list=new ArrayList( Arrays.asList( checkboxes ) );
				ArrayList<String> duplicatevalues = new ArrayList<String>(list);
				ArrayList<String> uniquevalues = new ArrayList<String>(mappedtankers);
				ArrayList<String> duplicatevalues1 = new ArrayList<String>(list);
				ArrayList<String> uniquevalues1 = new ArrayList<String>(mappedtankers);
				uniquevalues.removeAll(duplicatevalues);
		        duplicatevalues1.removeAll(uniquevalues1);
			    msg=tvm_DAO.insertTVM(myForm.getVolunteer(),duplicatevalues1,"saveedit");
			    if(msg!="")
			    request.setAttribute("message",msg);
			   msg=tvm_DAO.deleteTVM(myForm.getVolunteer(), uniquevalues,"saveedit");	
				
				if(msg!="")
				    request.setAttribute("message",msg);
				else
					request.setAttribute("message","Updated Successfully."); 
				
				mode = "close";
				request.setAttribute("mode","close");
				
			
				}else
				{
					
					msg=tvm_DAO.deleteAllTVM(myForm.getVolunteer(), "saveedit");	
					if(msg!="")
					    request.setAttribute("message",msg);
					mode = "close";
					request.setAttribute("mode","close");
					
				}
			}	
			     
			}
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList habitationDetails;	
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=request.getParameter("mname");
				String panchayatName=request.getParameter("pname");
				String villageName=request.getParameter("vname");
				request.setAttribute("selectedDistrictCode",request.getParameter("dcode"));
				request.setAttribute("selectedDistrictName",districtName);
				request.setAttribute("selectedMandalCode",request.getParameter("mcode"));
				request.setAttribute("selectedMandalName",mandalName);
				request.setAttribute("selectedPanchayatCode",request.getParameter("pcode"));
				request.setAttribute("selectedPanchayatName",panchayatName);
				request.setAttribute("selectedVillageCode",request.getParameter("vcode"));
				request.setAttribute("selectedVillageName",villageName);
				habitationDetails=tvm_DAO.getHabitationTVMDetails(request.getParameter("dcode"),request.getParameter("mcode"),mandalName,request.getParameter("pcode"),panchayatName,request.getParameter("vcode"),villageName,request.getParameter("habCode"),request.getParameter("volunteer"));
				session.setAttribute("habitationDetails",habitationDetails);
			}
			
			
			
			if(mode!=null && mode.equals("mobile"))
			{
				System.out.println("hello....");
			}
			
			
			
			
			
			
			
			if(mode!=null && mode.equals("edit"))
			{			
				
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				myForm.setPanchayat(request.getParameter("pcode"));
				myForm.setVillage(request.getParameter("vcode"));
				myForm.setHabitation(request.getParameter("habCode"));
				myForm.setVolunteer(request.getParameter("volunteer"));
			     mandals=tvm_DAO.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals",mandals);
				panchayats=tvm_DAO.getPanchayats(request.getParameter("dcode"),request.getParameter("mcode"));
				session.setAttribute("panchayats",panchayats);
				villages=tvm_DAO.getVillages(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				session.setAttribute("villages",villages);
				habitations=tvm_DAO.getHabitations(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"));
				session.setAttribute("habitations",habitations);
				volunteers=tvm_DAO.getVolunteers(request.getParameter("habCode"));
				request.setAttribute("volunteers",volunteers);
				if(!request.getParameter("volunteer").equalsIgnoreCase("00"))
				{
				    tankers=tvm_DAO.getRegTankers(request.getParameter("habCode"),request.getParameter("volunteer"),"","");
					}
					else
					{
						tankers=new ArrayList();
					}
					request.setAttribute("listfromAction", tankers);
					request.setAttribute("mode","edit");
			}
			
		}
		catch(Exception e)
		{
			Debug.println("Exception in rws_tvm_entry_frm is: "+e);
			
		}
		
		return mapping.findForward(mode);
		
	}
}

