package nic.watersoft.works;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;
import nic.watersoft.commons.Debug;
import javax.servlet.http.HttpSession;
import javax.sql.*;

import java.util.*;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.proposals.ProposalHolder;
import nic.watersoft.works.WorksData1;
import nic.watersoft.works.WorksMonitoringActionBean;

import org.apache.commons.beanutils.BeanUtils;

public class rws_ddws_frm_act extends Action
{
	/* logic to get current system date*/
	String months[] = {"Jan", "Feb", "Mar", "Apr","May", "Jun", "Jul", "Aug","Sep", "Oct", "Nov", "Dec"};
	Calendar calendar = Calendar.getInstance();
	String date=calendar.get(Calendar.DATE)+"-"+months[calendar.get(Calendar.MONTH)]+"-"+calendar.get(Calendar.YEAR);

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
		DataSource ds=null;
    	ArrayList circles=null;
    	ArrayList divisions=null;
    	ArrayList subdivs=null;
    	ArrayList programmes=null;
    	ArrayList subprogrammes=null;
    	ArrayList workCategory=null;
    	HttpSession session = request.getSession();
    	String SUCCESS = "success",headOfficeCode="";
		rws_ddws_form fb = (rws_ddws_form) form;
		String mode=request.getParameter("mode");
		rws_works_WorkStatus_form  bean=null;
		System.out.println("mode:"+mode);
		WorksData1 worksData = new WorksData1(ds);
		WorksDAO dao=null;
		RwsUser user=null;
		user=(RwsUser)session.getAttribute("RWS_USER");
        headOfficeCode=user.getHeadOfficeCode();
		try
		{
		    ds=getDataSource(request);
		    RwsOffices offices=new RwsOffices(ds);
	        mode=fb.getMode();
	        String workStage=fb.getWorkStage();
	        Debug.println("work stage is"+workStage);
	        Debug.println("mode is "+mode);
	        Debug.println("conMode is "+fb.getConMode());
	       
			if(mode.equals("circles"))
	        {
	        	session.removeAttribute("divs");
	        	session.removeAttribute("subdivs");
	        	session.removeAttribute("workCategory");
	        	session.removeAttribute("programmes");
	        	session.removeAttribute("subprogrammes");
	        	session.removeAttribute("rwsWorks");
	        	Debug.println("divisions removed"+session.getAttribute("divs"));
	    		user=(RwsUser)session.getAttribute("RWS_USER");
	            headOfficeCode=user.getHeadOfficeCode();
	        	circles=offices.CircleCombo(headOfficeCode);
	            if(circles!=null)
	        	session.setAttribute("circles",circles);
	            fb.setDivCode("");
	            fb.setSubDivCode("");
	            fb.setWorkCat("");
	            fb.setProgCode("");
	            fb.setSubProgCode("");
	            fb.setWorkId("");
	            fb.setProoved("");
	        }
	        if(mode.equals("div"))
	        {
	        	session.removeAttribute("subdivs");
	        	session.removeAttribute("workCategory");
	        	session.removeAttribute("programmes");
	        	session.removeAttribute("subprogrammes");
	        	session.removeAttribute("rwsWorks");
	        	Debug.println("in div mode:"+fb.getCircleCode());
	        	user=(RwsUser)session.getAttribute("RWS_USER");
	            headOfficeCode=user.getHeadOfficeCode();
	        	//session.removeAttribute("divs");
	         	divisions=offices.DivisionCombo(headOfficeCode,fb.getCircleCode());
	         	Debug.println("in div mode"+divisions.size());
	        	workCategory=offices.getWorkCategory();
	        	session.setAttribute("divs",divisions);
	        	session.setAttribute("workCategory",workCategory);
	        	fb.setDivCode("");
	        	fb.setSubDivCode("");
	            fb.setWorkCat("");
	            fb.setProgCode("");
	            fb.setSubProgCode("");
	            fb.setWorkId("");
	            fb.setProoved("");
        	}
	        if(mode.equals("subdiv"))
			{
	        	session.removeAttribute("programmes");
	        	session.removeAttribute("subprogrammes");
	        	session.removeAttribute("rwsWorks");
	        	Debug.println("IN SUBDIVISION MODE");
	        	Debug.println("Head Office Code"+headOfficeCode);
	        	Debug.println("Circle Code"+fb.getCircleCode());
	        	Debug.println("Division Code"+fb.getDivCode());
	        	subdivs=offices.SubDivisionCombo(headOfficeCode,fb.getCircleCode(),fb.getDivCode());
	        	Debug.println("No. of Subdivisions:"+subdivs.size());
	        	fb.setSubDivCode("");
	        	fb.setWorkCat("");
	            fb.setProgCode("");
	            fb.setSubProgCode("");
	            fb.setWorkId("");
	            fb.setProoved("");
	        	if(subdivs!=null)
	        	{
		        	session.setAttribute("subdivs",subdivs);
		        	session.removeAttribute("programmes");
		        	session.removeAttribute("subprogrammes");
		        	session.removeAttribute("rwsWorks");
		        	fb.setScheme(null);
	        	}
	        }
	        if(mode.equals("program"))
			{
	        	session.removeAttribute("subprogrammes");
	        	Debug.println("IN PROGRAMME MODE");
	        	Debug.println("Head Office Code"+headOfficeCode);
	        	Debug.println("Circle Code"+fb.getCircleCode());
	        	Debug.println("Division Code"+fb.getDivCode());
	        	Debug.println("subDivision Code"+fb.getSubdivisioncode());
	        	session.removeAttribute("subprogrammes");
	        	session.removeAttribute("rwsWorks");
	        	session.removeAttribute("programmes");
	         	programmes=offices.getProgrammes1(fb.getPlan(),fb.getWrktype(),fb.getWorkCat());
	        	Debug.println("No. of PROGRAMMES :"+programmes.size());
	        	if(programmes.size()!=0)
	        	{
		        session.setAttribute("programmes",programmes);
	        	fb.setScheme(null);
	        	}
	        	fb.setProgCode("");
	            fb.setSubProgCode("");
	            fb.setWorkId("");
	            fb.setProoved("");
	        	// gettting works for workcombo
	        	

	        	Debug.println("GETTING WORKS 4 WORKS COMBO BOX");
	        	bean=new rws_works_WorkStatus_form();
	        	//BeanUtils.copyProperties(bean,fb);
	        	dao = rws_works_factory.createWorksDAO(ds);
		        ArrayList worksList = new ArrayList();
		        worksList = dao.getWorks22(bean,user.getUserId());
		       
		        if(worksList!=null)
		        {
		         session.setAttribute("rwsWorks",worksList);
		        fb.setScheme(null);
		        }
		        Debug.println("works size is"+worksList.size());
	        
		        
	        }
	        if(mode.equals("subprogram"))
			{
	        	session.removeAttribute("rwsWorks");
	        	Debug.println("IN SUBPROGRAMME MODE"+fb.getProgram());
	        	Debug.println("Head Office Code"+headOfficeCode);
	        	Debug.println("Circle Code"+fb.getCircleCode());
	        	Debug.println("Division Code"+fb.getDivCode());
	        	session.removeAttribute("subprogrammes");
	            subprogrammes=offices.getSubProgrammes(fb.getProgram());
	        	Debug.println("No. of SUBPROGRAMMES :"+subprogrammes.size());
	        	if(subprogrammes!=null)
	        	{
		        	session.setAttribute("subprogrammes",subprogrammes);
		        	session.removeAttribute("rwsWorks");
	        	}
	        	fb.setSubProgCode("");
	            fb.setWorkId("");
	            fb.setProoved("");
	        }
	        if (mode.equals("workcombo"))
	        {
	        	Debug.println("GETTING WORKS 4 WORKS COMBO BOX");
	        	bean=new rws_works_WorkStatus_form();
	        	//BeanUtils.copyProperties(bean,fb);
	        	dao = rws_works_factory.createWorksDAO(ds);
		        ArrayList worksList = new ArrayList();
		        worksList = dao.getWorks(bean);
		       
		        if(worksList!=null)
		        {
		         session.setAttribute("rwsWorks",worksList);
		        fb.setScheme(null);
		        }
		        Debug.println("works size is"+worksList.size());
		        fb.setWorkId("");
	            fb.setProoved("");
	        }
	        if(mode.equals("details"))
	        {
	        	Debug.println("Work Id:"+fb.getWorkId());
	        	//String approved = worksData.getApprovedDetails(fb.getWorkId(),ds);
	        	String approved = worksData.getApprovedDetails(fb.getWorkId(),ds);
	        	String estCost = "";
	        	estCost = worksData.getEstAmount(fb.getWorkId(),ds);
	        	rws_ddws_form fbean = worksData.getDdwsDetails(fb.getWorkId(),ds);
	        	divisions=offices.DivisionCombo(headOfficeCode,fb.getCircleCode());
	        	session.setAttribute("divs",divisions);
	        	subdivs=offices.SubDivisionCombo(headOfficeCode,fb.getCircleCode(),fb.getDivCode());
	        	session.setAttribute("subdivs",subdivs);
	        	programmes=offices.getProgrammes1(fb.getPlan(),fb.getWrktype(),fb.getWorkCat());
	        	session.setAttribute("programmes",programmes);
	        	subprogrammes=offices.getSubProgrammes(fb.getProgram());
	        	session.setAttribute("subprogrammes",subprogrammes);
	        	if(approved!=null && approved.equals("Submission(Water Quality)"))
	        	{
	        		ArrayList wqlist = worksData.getwqListDetails(fb.getWorkId(),ds);
	        		request.setAttribute("wqlist",wqlist);
	        	}
	        	request.setAttribute("proove",approved);
	        	request.setAttribute("goi",fbean.getGoi());
	        	request.setAttribute("state",fbean.getState());
	        	request.setAttribute("comm",fbean.getComm());
	        	fb.setProoved(approved);
	        	Debug.println("est cost before seting to form:"+estCost);
	        	fb.setEstCost(estCost);
	        	fb.setGoi(fbean.getGoi());
	        	fb.setState(fbean.getState());
	        	fb.setComm(fbean.getComm());
	        	Debug.println("GOI:"+fb.getGoi());
	        }
	        if(mode.equals("getData"))
	        {
	        	Debug.println("Work Id:"+fb.getWorkId());
	        	Debug.println("Approved Under:"+fb.getProoved());
	        	rws_ddws_form fbean = worksData.getDdwsDetails(fb.getWorkId(),ds);
	        	request.setAttribute("goi",fbean.getGoi());
	        	request.setAttribute("state",fbean.getState());
	        	request.setAttribute("comm",fbean.getComm());
	        	fb.setGoi(fbean.getGoi());
	        	fb.setState(fbean.getState());
	        	fb.setComm(fbean.getComm());
	        	Debug.println("GOI:"+fb.getGoi());
	        }
	        if(mode.equals("insert"))
	        {
	        	String[] physical = new String[1];
	        	String[] chemical = new String[17];
	        	String[] bacteriological = new String[1];
	        	String[] others = new String[1];
	        	
	        	physical = request.getParameterValues("phy");
	        	chemical = request.getParameterValues("che");
	        	bacteriological = request.getParameterValues("bac");
	        	others = request.getParameterValues("oth");
	        	int rvalue = -1;
	        	if(fb.getProoved().equals("Normal Coverage"))
	        	{
	        		rvalue = worksData.insertDdwsNormalWqDetails(fb,ds);
	        	}
	        	else if(fb.getProoved().equals("Submission(Water Quality)"))
	        	{
	        		rvalue = worksData.insertDdwsSubWqDetails(fb,ds,physical,chemical,bacteriological,others);
	        	}
	        	else if(fb.getProoved().equals("Sustainability"))
	        	{
	        		rvalue = worksData.insertDdwsNormalWqDetails(fb,ds);
	        	}
	        	
	        	if(rvalue==-1)
					request.setAttribute("message","Cannot Save");
				else
					request.setAttribute("message","Saved Successfully");
	        	String approved = worksData.getApprovedDetails(fb.getWorkId(),ds);
	        	request.setAttribute("proove",approved);
	        	fb.setProoved(approved);
	        	rws_ddws_form fbean = worksData.getDdwsDetails(fb.getWorkId(),ds);
	        	Debug.println("Approved Under:"+approved);
	        	request.setAttribute("proove",approved);
	        	request.setAttribute("goi",fbean.getGoi());
	        	request.setAttribute("state",fbean.getState());
	        	request.setAttribute("comm",fbean.getComm());
	        	if(approved.equals("Submission(Water Quality)"))
	        	{
	        		ArrayList wqlist = worksData.getwqListDetails(fb.getWorkId(),ds);
	        		request.setAttribute("wqlist",wqlist);
	        	}
	        }
		}
		catch(Exception e){}
		System.out.println("mode return:"+fb.getCircleCode());
		return mapping.findForward(SUCCESS);
	}
}