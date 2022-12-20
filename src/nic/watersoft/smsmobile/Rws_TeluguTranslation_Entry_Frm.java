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
public class Rws_TeluguTranslation_Entry_Frm extends Action 
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
		ArrayList<String> habcdeslist=new ArrayList();;
		ArrayList<String> habnamesintelugulist=new ArrayList();;
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
		}
		else
			mode="teluguEntryFrm";
		Rws_TeluguTranslation_Frm myForm=(Rws_TeluguTranslation_Frm)form;
		boolean reset = true;
		//RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		String district=myForm.getDistrict();
		Rws_Telugutranslation_DAO teluguTranslation_DAO=new Rws_Telugutranslation_DAO();
		try{
			if(reset)
			{
				districts = teluguTranslation_DAO.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
				session.setAttribute("villages",villages);
				session.setAttribute("habitations",habitations);
				
			}
			
			if(district == null || district.equals(""))
			{
				district = user.getCircleOfficeCode();
				String dname=teluguTranslation_DAO.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=teluguTranslation_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}			
			
			if(mode!=null && mode.equals("mandals"))
			{
				mandals=teluguTranslation_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}
			if(mode!=null && mode.equals("panchayats"))
			{
				mandals=teluguTranslation_DAO.getDistrictMandals(district);
				panchayats=teluguTranslation_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
			}
			if(mode!=null && mode.equals("villages"))
			{
				mandals=teluguTranslation_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=teluguTranslation_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=teluguTranslation_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				
			}
			if(mode!=null && mode.equals("habitations"))
			{
				mandals=teluguTranslation_DAO.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=teluguTranslation_DAO.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				villages=teluguTranslation_DAO.getVillages(district,myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages",villages);
				habitations=teluguTranslation_DAO.getHabitations(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				String distname_telugustr=teluguTranslation_DAO.getDistrictTelugunameStr(district);
				String mandalname_telugustr=teluguTranslation_DAO.getMandalTelugunameStr(district,myForm.getMandal());
				String panchayatname_telugustr=teluguTranslation_DAO.getPanchayatTelugunameStr(district,myForm.getMandal(),myForm.getPanchayat());
				String villagename_telugustr=teluguTranslation_DAO.getVillageTelugunameStr(district,myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				if(habitations!=null){
				request.setAttribute("listfromAction", habitations);
				request.setAttribute("dname_in_telugu", distname_telugustr);
				request.setAttribute("mname_in_telugu", mandalname_telugustr);
				request.setAttribute("pname_in_telugu", panchayatname_telugustr);
				request.setAttribute("vname_in_telugu", villagename_telugustr);
				}else{System.out.println("habitations null");}
			}
			
			if(mode!=null && mode.equals("save"))
			{
				String dname_in_telugu=request.getParameter("dname_in_telugu");
				String mname_in_telugu=request.getParameter("mname_in_telugu");
				String pname_in_telugu=request.getParameter("pname_in_telugu");
				String vname_in_telugu=request.getParameter("vname_in_telugu");
				String[] habcodes = request.getParameterValues("habCode");
				String[] habnamesinenglish = request.getParameterValues("habNameInEnglish");
				String[] habnamesintelugu = request.getParameterValues("habNameInTelugu");
				if(habcodes!=null){
					 habcdeslist=new ArrayList( Arrays.asList( habcodes ) );
				}
				
				if(habnamesintelugu!=null){
					 habnamesintelugulist=new ArrayList( Arrays.asList( habnamesintelugu ) );
				}
				
			      storedToken = (String)session.getAttribute("csrfToken");
			      token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
			    	 	 
			    	String msg= teluguTranslation_DAO.insertDetails(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage(),dname_in_telugu,mname_in_telugu,pname_in_telugu,vname_in_telugu,habcdeslist,habnamesintelugulist);
			    	 if(msg!=""){
						    request.setAttribute("message",msg);
			    	 }
						 
				
			}
			     mode = "mandals";
					request.setAttribute("mode","mandals");
			     
			}	
		}
		catch(Exception e)
		{
			Debug.println("Exception in rws_teluguentry_entry_frm is: "+e);
			
		}
		
		return mapping.findForward(mode);
		
	}
}

