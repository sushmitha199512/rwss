package nic.watersoft.BaseLineSurvey;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import nic.watersoft.commons.Debug;
/**
 * 
 * @author N SREE LAXMI DEVI
 *
 */
public class rws_GovtGpAct_frm extends Action {
	public rws_GovtGpAct_frm() {
	}

	//
	protected ActionForm buildGovtForm(String habCode,String bldgCode,HttpServletRequest request) throws Exception 
	{
		BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
		BaseLineForm baseLineForm=null;
		BaseLineBean baseLineBean=BaseLineMasterData.getGovtedit(habCode,bldgCode);
			if(baseLineBean != null)
			{
				baseLineForm = new BaseLineForm();
				baseLineForm.setDist(baseLineBean.getDist());
				baseLineForm.setdName(baseLineBean.getdName());
				baseLineForm.setmName(baseLineBean.getmName());
				baseLineForm.setpName(baseLineBean.getpName());
				baseLineForm.setvName(baseLineBean.getvName());
				baseLineForm.setHabCode(baseLineBean.getHabCode());
				baseLineForm.setPanchName(baseLineBean.getPanchName());
				baseLineForm.setLatFacility(baseLineBean.getLatFacility());
				baseLineForm.setWatFacility(baseLineBean.getWatFacility());
				baseLineForm.setSurveyDate(baseLineBean.getSurveyDate());
				baseLineForm.setBldgName(baseLineBean.getBldgName());
				baseLineForm.setBldgCode(baseLineBean.getBldgCode());
				
				
				
				
				
				
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
		ArrayList bldgs=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		BaseLineMasterData baseLineMasterData=new BaseLineMasterData();
		int count=0;
		
		
		
		

		
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
		if (mode != null && mode.equalsIgnoreCase("delete"))
		{
			try
			{
				String bldgcode=request.getParameter("bldgCode");
				String habcode=request.getParameter("habCode");
				count=baseLineMasterData.GovtBldgsdel(habcode,bldgcode);
				if(count>0)
				{
					message="BaseLine Survey Government Buildings Deleted Successfully";
				}
				else
				{
					message="BaseLine Survey Government Buildings ( Not ) Deleted";
				}
				request.setAttribute("message",message);
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			try
			{
                bldgs=baseLineMasterData.getListBldggpdetails(frm);
				
				session.setAttribute("bldgs",bldgs);
			}
			catch(Exception x)
			{
				x.printStackTrace();
			}
			
			page_to_be_displayed="cview";
		
		}
		if (mode != null && mode.equalsIgnoreCase("cview"))
		{
			try
			{
				
				
				
				//BaseLineMasterData.getGovtBldgdetails(frm);
				bldgs=baseLineMasterData.getListBldggpdetails(frm);
				
				session.setAttribute("bldgs",bldgs);
				
			   
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="cview";
		}
		
		
		//
		
		if (mode != null && mode.equalsIgnoreCase("save")) {
			Debug.println("data1*********"+mode);
			
			try {
				
				
				
				
				 count=baseLineMasterData.saveGovtBldgs(frm);
				if(count>0)
				{
					message="Buildings In Grampanchayats are Inserted Successfully";
					request.setAttribute("message",message);
				}
				else
				{
					message="Buildings In Grampanchayats are ( Not )" +
							"" +
							"" +
							"" +
							"" +
							" Inserted successfully";
					request.setAttribute("message",message);
				
				}
				reset1(frm);
                
                
				
							} catch (Exception z) {
				z.printStackTrace();
			}

			Debug.println("1" + page_to_be_displayed);
			page_to_be_displayed = "save";

		}

	

		////
		if (mode != null && mode.equalsIgnoreCase("edit")) {
			Debug.println("data1*********"+mode);
			
			try {
				
				
				
				
				 count=baseLineMasterData.updategovtBldgs(frm);
				if(count>0)
				{
					message="Buildings In Grampanchayats are Updated Successfully";
					request.setAttribute("message",message);
				}
				else
				{
					message="Buildings In Grampanchayats are ( Not )" +
							"" +
							"" +
							"" +
							"" +
							" Updated";
					request.setAttribute("message",message);
				
				}
				
                
                
				
							}
			catch (Exception z)
							{
				      z.printStackTrace();
			      }

			
			page_to_be_displayed = "closeWithMessage";

		}

		///
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildGovtForm(request.getParameter("habCode"),request.getParameter("bldgCode"),request);
				
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
		
		
			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(BaseLineForm frm) {
		frm.setDist("");
		frm.setMcode("");
		frm.setPcode("");
		frm.setVcode("");
		frm.setBldgName("");
		frm.setLatFacility("");
		frm.setWatFacility("");
		frm.setSurveyDate("");
		
		
		
		
		
	}
	public void reset1(BaseLineForm frm) {
		frm.setBldgName("");
		frm.setLatFacility("");
		frm.setWatFacility("");
		frm.setSurveyDate("");
		
		
		
		
		
	}

	

}

