/*
 * Created on May 11, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


import nic.watersoft.commons.RwsOffices;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;


/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class HabStatusEditFrm extends Action{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
		String target="getData";
		String headOfficeCode="1";
		String circleOfficeCode="";
		String divisionOfficeCode="";
		String subDivisionOfficeCode="";
		ArrayList circles=null;
		ArrayList divisions=null;
		ArrayList subDivisions=null;
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList habs=new ArrayList();
		HttpSession session=request.getSession();
		
		try{
		circleOfficeCode=request.getParameter("habCode").substring(0,2);
		//System.out.println("circleOfficeCode="+circleOfficeCode);
		divisionOfficeCode=rwsOffices.getDivisionOfficeCodeFromMandal(getDataSource(request),circleOfficeCode,request.getParameter("habCode").substring(5,7));
		//System.out.println("divisionOfficeCode="+divisionOfficeCode);
		subDivisionOfficeCode=rwsOffices.getSubDivisionOfficeCodeFromMandal(getDataSource(request),circleOfficeCode,request.getParameter("habCode").substring(5,7));
		//System.out.println("subDivisionOfficeCode="+subDivisionOfficeCode);
		HabStatusForm habForm = (HabStatusForm)form;
		//System.out.println("1");
		habForm.setCircleOfficeCode(circleOfficeCode);
		habForm.setDivisionOfficeCode(divisionOfficeCode);
		habForm.setSubdivisionOfficeCode(subDivisionOfficeCode);
		//System.out.println("2");
		request.setAttribute("distName",rwsHabStatusData.getDistName(getDataSource(request),circleOfficeCode));
		habForm.setDcode(circleOfficeCode);
		//System.out.println("a");
		habForm.setMandal(request.getParameter("habCode").substring(5,7));
		//System.out.println("b");
		habForm.setPcode(request.getParameter("habCode").substring(12,14));
		//System.out.println("c");
		habForm.setHabCode(request.getParameter("habCode").substring(10,12));
		//System.out.println("3");
		//circles = rwsOffices.getCircles("1");
		//System.out.println("4");
		//divisions=rwsOffices.getDivisions(headOfficeCode,circleOfficeCode);
		//System.out.println("5");
		//subDivisions=rwsOffices.getSubdivisions(headOfficeCode,circleOfficeCode,divisionOfficeCode);
		//System.out.println("6");
		//mandals = rwsLocations.getsubdivisionmandals2(circleOfficeCode,divisionOfficeCode,subDivisionOfficeCode,getDataSource(request));
		//System.out.println("7");
		panchayats=rwsLocations.getPanchayats(circleOfficeCode,request.getParameter("habCode").substring(5,7));
		//System.out.println("panchayats size is "+panchayats.size());
		habs = rwsLocations.getPanchayatHabitations(circleOfficeCode,request.getParameter("habCode").substring(5,7),request.getParameter("habCode").substring(12,14));
		//System.out.println("habs is "+habs.size());
		//session.setAttribute("circles",circles);
		//session.setAttribute("divisions", divisions);
		//session.setAttribute("subdivisions", subDivisions);
		
		//session.setAttribute("mandals",mandals);
		session.setAttribute("panchyats",panchayats);
		//session.setAttribute("villages",villages);
		session.setAttribute("habs",habs);
		}catch(Exception e){
			//System.out.println("Exception in HabStatusEditFrm is "+e);}
		}
		return mapping.findForward(target);
	}
	

}
