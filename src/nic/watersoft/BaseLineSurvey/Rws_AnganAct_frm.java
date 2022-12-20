package nic.watersoft.BaseLineSurvey;
import java.io.IOException;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import nic.watersoft.commons.Debug;
public class Rws_AnganAct_frm extends Action {
	public Rws_AnganAct_frm() {
	}
//
	protected ActionForm buildAnganForm(String habCode,String anganNum,HttpServletRequest request) throws Exception 
	{
		BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
		BaseLineForm baseLineForm=null;
		BaseLineBean baseLineBean=BaseLineMasterData.getAnganedit(habCode,anganNum);
			if(baseLineBean != null)
			{
				baseLineForm = new BaseLineForm();
				//
				baseLineForm.setHabCode(baseLineBean.getHabCode());
				baseLineForm.setPanchName(baseLineBean.getPanchName());
				baseLineForm.setAnganwadiName(baseLineBean.getAnganwadiName());
				baseLineForm.setAnganCode(baseLineBean.getAnganCode());
				baseLineForm.setBuildingTypename(baseLineBean.getBuildingTypename());
				baseLineForm.setTotalEnrolment(baseLineBean.getTotalEnrolment());
				baseLineForm.setAvailabilityofToiletfacility(baseLineBean.getAvailabilityofToiletfacility());
				baseLineForm.setBuildingDept(baseLineBean.getBuildingDept());
				//String b1=baseLineBean.getYearofBuilt();
				//Debug.println("b1************"+b1);
				ArrayList expyears=new ArrayList();
				expyears=baseLineMasterData.getExpYears();
				
				baseLineForm.setYearofBuilt(baseLineBean.getYearofBuilt());
				baseLineForm.setSanitaryUse(baseLineBean.getSanitaryUse());
				baseLineForm.setFunctionalReason(baseLineBean.getFunctionalReason());
				baseLineForm.setReasonforDefunct(baseLineBean.getReasonforDefunct());
				baseLineForm.setToiletwaterFacilityavailable(baseLineBean.getToiletwaterFacilityavailable());
				baseLineForm.setDrinkingWaterexist(baseLineBean.getDrinkingWaterexist());
				baseLineForm.setBinExist(baseLineBean.getBinExist());
				baseLineForm.setPitExist(baseLineBean.getPitExist());
				baseLineForm.setSurveyDate(baseLineBean.getSurveyDate());
				baseLineForm.setAnganNum(baseLineBean.getAnganNum());
				baseLineForm.setdName(baseLineBean.getdName());
				baseLineForm.setmName(baseLineBean.getmName());
				baseLineForm.setpName(baseLineBean.getpName());
				baseLineForm.setvName(baseLineBean.getvName());
				baseLineForm.setAnganNum(baseLineBean.getAnganNum());
				
								
				
				
				
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
		ArrayList angans=new ArrayList();
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
			
			
			
			count=baseLineMasterData.updateAngans(frm);
			if(count>0)
			{
				message="BaseLine Survey Anganwadi details are Updated Successfully";
			}
			else
			{
				message="BaseLine Survey Anganwadi are ( Not ) Updated";
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
				
				angans=baseLineMasterData.getListAngandetails(frm);
				session.setAttribute("angans",angans);
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
				form = buildAnganForm(request.getParameter("habCode"),request.getParameter("anganNum"),request);
				
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
				String angancode=request.getParameter("angNum");
				String habcode=request.getParameter("habCode");
				count=baseLineMasterData.GovtAngandel(habcode,angancode);
				if(count>0)
				{
					message="BaseLine Survey Anganwadi Details are Deleted Successfully";
				}
				else
				{
					message="BaseLine Survey Anganwadi Details are ( Not ) Deleted";
				}
				request.setAttribute("message",message);
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			try
			{
                angans=baseLineMasterData.getListAngandetails(frm);
				session.setAttribute("angans",angans);
				
				
				
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
				
				Debug.println("data"+mode);
				count=baseLineMasterData.saveAngans(frm);
				Debug.println("countppppppppinsidesave***********"+count);
				
				if(count==1)
				{
					Debug.println("Inside if");
					
					message="BaseLine Survey Anganwadi's are Inserted Successfully";
					Debug.println("message"+message);
					request.setAttribute("message",message);
				}
				else
				{
					message="BaseLine Survey Anganwadi 's ( Not ) Inserted";
					request.setAttribute("message",message);
				}
				
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
		frm.setAnganwadiName("");
		frm.setAnganCode("");
		
		frm.setBuildingTypename("");
		frm.setTotalEnrolment("");
		frm.setAvailabilityofToiletfacility("");
		frm.setBuildingDept("");
		
		frm.setYearofBuilt("");
		
		frm.setSanitaryUse("");
		frm.setFunctionalReason("");
		frm.setReasonforDefunct("");
		frm.setToiletwaterFacilityavailable("");
		frm.setDrinkingWaterexist("");
		frm.setBinExist("");
		frm.setPitExist("");
		frm.setSurveyDate("");
		
		
		
		
		
	}
	public void reset1(BaseLineForm frm)
	{
		frm.setAnganwadiName("");
		frm.setAnganCode("");
		
		frm.setBuildingTypename("");
		frm.setTotalEnrolment("");
		frm.setAvailabilityofToiletfacility("");
		frm.setBuildingDept("");
		
		frm.setYearofBuilt("");
		
		frm.setSanitaryUse("");
		frm.setFunctionalReason("");
		frm.setReasonforDefunct("");
		frm.setToiletwaterFacilityavailable("");
		frm.setDrinkingWaterexist("");
		frm.setBinExist("");
		frm.setPitExist("");
		frm.setSurveyDate("");	
		
	}

	

}

