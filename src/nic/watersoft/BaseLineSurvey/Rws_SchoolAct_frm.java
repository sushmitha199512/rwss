package nic.watersoft.BaseLineSurvey;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import nic.watersoft.commons.Debug;
public class Rws_SchoolAct_frm extends Action {
	public Rws_SchoolAct_frm() {
	}
//
	protected ActionForm buildSchoolForm(String habCode,String schoolCode,HttpServletRequest request) throws Exception 
	{
		BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
		BaseLineForm baseLineForm=null;
		BaseLineBean baseLineBean=BaseLineMasterData.getSchooledit(habCode,schoolCode);
			if(baseLineBean != null)
			{
				baseLineForm = new BaseLineForm();
				baseLineForm.setSchoolName(baseLineBean.getSchoolName());
				baseLineForm.setDiseCode(baseLineBean.getDiseCode());
				baseLineForm.setLocality(baseLineBean.getLocality());
				baseLineForm.setSchoolType(baseLineBean.getSchoolType());
				baseLineForm.setSchoolCategory(baseLineBean.getSchoolCategory());
				baseLineForm.setSchoolEstablieshed2007(baseLineBean.getSchoolEstablieshed2007());
				baseLineForm.setSanitaryBuildingdept(baseLineBean.getSanitaryBuildingdept());
				baseLineForm.setBoysCount(baseLineBean.getBoysCount());
				baseLineForm.setGirlsCount(baseLineBean.getGirlsCount());
				baseLineForm.setSanitaryExist(baseLineBean.getSanitaryExist());
				ArrayList expyears=new ArrayList();
				expyears=baseLineMasterData.getExpYears();
				baseLineForm.setYearofBuilt(baseLineBean.getYearofBuilt());
				baseLineForm.setBoystoiletCount(baseLineBean.getBoystoiletCount());
				baseLineForm.setGirlstoiletCount(baseLineBean.getGirlstoiletCount());
				baseLineForm.setIsWaterExist(baseLineBean.getIsWaterExist());
				baseLineForm.setSanitaryUse(baseLineBean.getSanitaryUse());
				baseLineForm.setDrinkingwaterFacilityAvailable(baseLineBean.getDrinkingwaterFacilityAvailable());
				baseLineForm.setBinExist(baseLineBean.getBinExist());
				baseLineForm.setPitExist(baseLineBean.getPitExist());
				baseLineForm.setSurveyDate(baseLineBean.getSurveyDate());
				baseLineForm.setDist(baseLineBean.getDist());
				baseLineForm.setdName(baseLineBean.getdName());
				baseLineForm.setmName(baseLineBean.getmName());
				baseLineForm.setpName(baseLineBean.getpName());
				baseLineForm.setvName(baseLineBean.getvName());
				baseLineForm.setHabCode(baseLineBean.getHabCode());
				baseLineForm.setPanchName(baseLineBean.getPanchName());
				baseLineForm.setSchoolCode(baseLineBean.getSchoolCode());
				
				
				
				
				
				
			}
			return baseLineForm;
	}

	//
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page_to_be_displayed = " ";
		
		String message = null;
		BaseLineForm frm = (BaseLineForm) form;
		int i = 0;

		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList schools=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList expyears=new ArrayList();
		int count=0;
		BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
		
		
		
		

		
		if (mode != null && mode.equalsIgnoreCase("data")) {
			
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset"))
			{
				reset(frm);
				
			}
						
			try {
				
				Debug.println("dataingp^^^^^^^^*******************"+mode);
			 
			
			districts=baseLineMasterData.getDistricts(getDataSource(request));
			session.setAttribute("districts",districts);
			Debug.println("*****************"+districts.size());
			if(frm.getDist()!=null && !frm.getDist().equals(""))
			{
				mandals=baseLineMasterData.getMandalsgovt(getDataSource(request),frm.getDist());
				session.setAttribute("mandals",mandals);
			}
			else
			{
				session.setAttribute("mandals", new ArrayList());
			}
			if(frm.getDist()!=null && !frm.getDist().equals("") && frm.getMcode() !=null && !frm.getMcode().equals(""))
			{
				panchayats=baseLineMasterData.getPanchayatsgovt(getDataSource(request),frm.getDist(),frm.getMcode());
				session.setAttribute("panchayats",panchayats);
			}
			else
			{
				session.setAttribute("panchayats", new ArrayList());
			}
			
			if(frm.getDist()!=null && !frm.getDist().equals("") && frm.getMcode() !=null && !frm.getMcode().equals("") && frm.getPcode() != null && !frm.getPcode().equals(""))
			{
			villages=baseLineMasterData.getVillagesgovt(getDataSource(request),frm.getDist(),frm.getMcode(),frm.getPcode());
			session.setAttribute("villages",villages);
			}
			else
			{
				session.setAttribute("villages", new ArrayList());
			}
			if(frm.getDist()!=null && !frm.getDist().equals("") && frm.getMcode() !=null && !frm.getMcode().equals("") && frm.getPcode() != null && !frm.getPcode().equals("") && frm.getVcode() !=null && !frm.getVcode().equals(""))
			{
			habitations=baseLineMasterData.getHabs(getDataSource(request),frm.getDist(),frm.getMcode(),frm.getPcode(),frm.getVcode());
			session.setAttribute("habitations",habitations);
			expyears=baseLineMasterData.getExpYears();
			session.setAttribute("expyears",expyears);
			}
			else
			{
				session.setAttribute("habitations", new ArrayList());
			}
			
			
				
				
			
                 
								
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="data";
		}
		//
		if (mode != null && mode.equalsIgnoreCase("edit"))
		{
			try
			{
			
			
			
			count=baseLineMasterData.updateSchools(frm);
			if(count>0)
			{
				message="BaseLine Survey Schools are Updated Successfully";
			}
			else
			{
				message="BaseLine Survey Schools are ( Not ) Updated";
			}
			request.setAttribute("message",message);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			page_to_be_displayed="closeWithMessage";
		}
		
		//
		if (mode != null && mode.equalsIgnoreCase("cview"))
		{
			try
			{
				
				schools=baseLineMasterData.getListSchooldetails(frm);
				session.setAttribute("schools",schools);
			}
			catch(Exception e)
			{
				e.printStackTrace();
				
				
				
			}
			page_to_be_displayed="cview";
		}
		//
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildSchoolForm(request.getParameter("habCode"),request.getParameter("schoolCode"),request);
				
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				e.printStackTrace();
				
			}
			page_to_be_displayed="get";
			
		}


		//
		//
		if (mode != null && mode.equalsIgnoreCase("delete"))
		{
			try
			{
				String schoolcode=request.getParameter("schoolCode");
				String habcode=request.getParameter("habCode");
				count=baseLineMasterData.GovtSchooldel(habcode,schoolcode);
				if(count>0)
				{
					message="BaseLine Survey School Details are are Deleted Successfully";
				}
				else
				{
					message="BaseLine Survey School Details are ( Not ) Deleted";
				}
				request.setAttribute("message",message);
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			try
			{
                schools=baseLineMasterData.getListSchooldetails(frm);
				session.setAttribute("schools",schools);
				
				
				
			}
			catch(Exception x)
			{
				x.printStackTrace();
			}
			
			page_to_be_displayed="cview";
		
		}
		//
		//
		if (mode != null && mode.equalsIgnoreCase("save")) 
		{
			try
			{
				
				
				count=baseLineMasterData.saveSchools(frm);
				if(count>0)
				{
					message="BaseLine Survey Schools are Inserted Successfully";
				}
				else
				{
					message="BaseLine Survey Schools ( Not ) Inserted";
					
				}
				request.setAttribute("message",message);
				reset1(frm);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="save";
		}
		//
		
		
			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(BaseLineForm frm) {
		frm.setDist("");
		frm.setMcode("");
		frm.setPcode("");
		frm.setVcode("");
		frm.setHabCode("");
		frm.setSchoolName("");
		frm.setDiseCode("");
		frm.setLocality("");
		frm.setSchoolType("");
		frm.setSchoolCategory("");
		frm.setSchoolEstablieshed2007("");
		frm.setBoysCount("");
		frm.setGirlsCount("");
		frm.setSanitaryExist("");
		frm.setYearofBuilt("");
		frm.setBoystoiletCount("");
		frm.setGirlstoiletCount("");
		frm.setIsWaterExist("");
		frm.setSanitaryUse("");
		frm.setDrinkingwaterFacilityAvailable("");
		frm.setBinExist("");
		frm.setPitExist("");
		frm.setSurveyDate("");
		frm.setSanitaryBuildingdept("");
		
		
		
		
	}
	public void reset1(BaseLineForm frm)
	{
		frm.setSchoolName("");
		frm.setDiseCode("");
		frm.setLocality("");
		frm.setSchoolType("");
		frm.setSchoolCategory("");
		frm.setSchoolEstablieshed2007("");
		frm.setBoysCount("");
		frm.setGirlsCount("");
		frm.setSanitaryExist("");
		frm.setYearofBuilt("");
		frm.setBoystoiletCount("");
		frm.setGirlstoiletCount("");
		frm.setIsWaterExist("");
		frm.setSanitaryUse("");
		frm.setDrinkingwaterFacilityAvailable("");
		frm.setBinExist("");
		frm.setPitExist("");
		frm.setSurveyDate("");
		frm.setSanitaryBuildingdept("");
		
		
	}

	

}

