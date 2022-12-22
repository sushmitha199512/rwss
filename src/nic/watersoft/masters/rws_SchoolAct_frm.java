/* Created on Dec 4, 2008
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates*/

package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;



public class rws_SchoolAct_frm extends Action 
{
	
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	ArrayList panchayats=new ArrayList();
	ArrayList villages=new ArrayList();
	ArrayList habitations=new ArrayList();
	
	protected ActionForm buildSchoolDesgnForm(String hab,String scode,String mode,HttpServletRequest request) throws Exception 
	{
		
		HttpSession session=request.getSession();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		SchoolForm frm1=null;
		SchoolForm frm=SchoolMasterData.getSchoolEdit(hab,scode,getDataSource(request));
			

		if(frm!=null)
		{
			frm1=new SchoolForm();
			
			frm1.setDistrict(frm.getDistrict());
			try{
			if(!frm.getDistrict().equalsIgnoreCase("-1"))
			{
			//	Debug.println("inside District");
				mandals=rwsOffices.getDistrictMandals(frm.getDistrict());
			}
			session.setAttribute("mandals",mandals);
			frm1.setMandal(frm.getMandal());
			
			if(!frm.getMandal().equalsIgnoreCase("-1"))
			{
			
				panchayats=rwsOffices.getPanchayats(frm.getDistrict(),frm.getMandal());
			}
			session.setAttribute("panchayats",panchayats);
			frm1.setPanchayat(frm.getPanchayat());
			
			if(!frm.getPanchayat().equalsIgnoreCase("-1"))
			{
			
				villages=rwsOffices.getVillages(frm.getDistrict(),frm.getMandal(),frm.getPanchayat());
			}
			session.setAttribute("villages",villages);
			frm1.setVillage(frm.getVillage());
			
			if(!frm.getVillage().equalsIgnoreCase("-1"))
			{
		
				habitations=rwsLocations.getHabs(frm.getDistrict(),frm.getMandal(),frm.getPanchayat(),frm.getVillage());
			}
			session.setAttribute("habitations",habitations);
			frm1.setHabitation(frm.getHabitation());
			}
			catch(Exception e)
			{
			System.out.println("Exception in district codes"+e.getMessage());
			}
			frm1.setCategory(frm.getCategory());
			request.setAttribute("category",frm1.getCategory());
			frm1.setClassify(frm.getClassify());
			frm1.setFacilities(frm.getFacilities());
			frm1.setNoStudents(frm.getNoStudents());
			frm1.setNoBoys(frm.getNoBoys());
			frm1.setNoGirls(frm.getNoGirls());
			frm1.setToilets(frm.getToilets());
			frm1.setUrinals(frm.getUrinals());
			frm1.setRunningwater(frm.getRunningwater());
			frm1.setDrkMonth(frm.getDrkMonth());
			frm1.setDrkYear(frm.getDrkYear());
			frm1.setSaniMonth(frm.getSaniMonth());
			frm1.setSaniYear(frm.getSaniYear());
			frm1.setSourceDrkFund(frm.getSourceDrkFund());
			frm1.setSourceSaniFund(frm.getSourceSaniFund());
			frm1.setSchoolName(frm.getSchoolName());
			frm1.setSchoolCode(frm.getSchoolCode());
			frm1.setNonDrink(frm.getNonDrink());
			frm1.setNonSani(frm.getNonSani());
			frm1.setHabName(frm.getHabName());
			frm1.setSchoolLoc(frm.getSchoolName());
			frm1.setSchoolLatitude(frm.getSchoolLatitude());
			frm1.setSchoolLongitude(frm.getSchoolLongitude());
			frm1.setSchoolElevation(frm.getSchoolElevation());
			frm1.setSchoolWaypoint(frm.getSchoolWaypoint());
		}
			return frm1;
	}
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		SchoolMasterForm schoolMasterForm=new SchoolMasterForm();
		SchoolMasterData schoolMasterData=new SchoolMasterData();
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		
		SchoolForm schoolForm=(SchoolForm)form;
		String mode=schoolForm.getMode();
		
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) ||Constants.IsEEUser(user.getUserId())|| Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		String district=schoolForm.getDistrict();
		
		String mandal=schoolForm.getMandal();
		String panchayat=schoolForm.getPanchayat();
		String village=schoolForm.getVillage();
		String hab=schoolForm.getHabitation();
		int ans=0;
		
		if(mode.equalsIgnoreCase("data"))
		{
		try{
			districts=rwsOffices.getDistricts();
			session.setAttribute("districts",districts);
			
			session.setAttribute("programs",schoolMasterData.getPrograms());
			
			mandals=rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals",mandals);
			
			panchayats=rwsOffices.getPanchayats(district,mandal);
			session.setAttribute("panchayats",panchayats);
			
			villages=rwsOffices.getVillages(district,mandal,panchayat);
			session.setAttribute("villages",villages);
			
			habitations=rwsLocations.getHabs(district,mandal,panchayat,village);
			session.setAttribute("habitations",habitations);
			
			
			}catch(Exception e)
			{
			System.out.println("Exception in rws_schoolact_frm data mode "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{	
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			SchoolForm frm=(SchoolForm)form;
			request.setAttribute("habCode",frm.getHabitation());
			try{
				ans=schoolMasterData.Save(getDataSource(request),frm);
				String message=null;
					if(ans==1)
					{
						message="Inserted Successfully";
					}
					if(ans==2)
					{
						message="School Record Exists";
					}
					if(ans==0)
					{
						message="Cannot Insert";
					}
					request.setAttribute("message",message);
				    reset1(frm);
					
			}catch(Exception e)
			{
				System.out.println("Exceptin in save"+e.getMessage());
			}
		}
		}
		
		if(mode.equalsIgnoreCase("View"))
		{
			
			String hab1=request.getParameter("habitation");
			ArrayList list=new ArrayList();
			SchoolMasterData schoolMasterData1=new SchoolMasterData();
			
			SchoolForm frm1=(SchoolForm)form;
			try
			{
			String dname=rwsOffices.getDistrictName(district);
			String mname=rwsOffices.getMandalName(district,mandal);
			String pname=rwsOffices.getPanchayatName(district,mandal,panchayat);
			String vname=rwsOffices.getVillageName(getDataSource(request),district,mandal,panchayat,village);
			
			
			request.setAttribute("dName",dname);
			request.setAttribute("mName",mname);
			request.setAttribute("pName",pname);
			request.setAttribute("vName",vname);

			
			list=SchoolMasterData.viewHabsList(getDataSource(request),frm1,request);
			request.setAttribute("list",list);
			
			
		
			}
			catch(Exception e)
			{
			System.out.println("Exception View"+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("get"))
		{
			try
			{
				form=(SchoolForm)buildSchoolDesgnForm(request.getParameter("hab_code"),request.getParameter("school_code"),mode,request);
				
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch(Exception e)
			{
				System.out.println("Exception in get "+e.getMessage());
			}
			return(mapping.findForward(mode));
		}
		
		if(mode.equalsIgnoreCase("update"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			String message=null;
			SchoolForm frm=(SchoolForm)form;
			SchoolMasterData sc=new SchoolMasterData();
			try
			{
				message=sc.UpdateSchoolDetails(request.getParameter("habitation"),request.getParameter("schoolCode"),frm,getDataSource(request));
				request.setAttribute("message",message);
				mode="deleteschool";
				reset1(frm);
			}
			catch(Exception e)
			{
				System.out.println("Exception in update mode "+e.getMessage());
			}
			
			return(mapping.findForward(mode));
		}
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{
			String message=null;
			SchoolForm frm=(SchoolForm)form;
			SchoolMasterData sc=new SchoolMasterData();
			try
			{
				message=sc.deleteSchoolDetails(request.getParameter("hab_code"),request.getParameter("school_code"),getDataSource(request));
				request.setAttribute("message",message);
				
			}
			catch(Exception e)
			{
				System.out.println("Exception in Delete mode "+e.getMessage());
			}
			mode="deleteschool";
		}	
		if(mode.equalsIgnoreCase("addAsset"))
		{
			String hab1=request.getParameter("habitation");
			ArrayList list=new ArrayList();
			SchoolMasterData schoolMasterData1=new SchoolMasterData();
			
			SchoolForm frm1=(SchoolForm)form;
			try
			{
				ArrayList assetList=SchoolMasterData.viewHabsList1(getDataSource(request),frm1,request);
				String dname=rwsOffices.getDistrictName(district);
				String mname=rwsOffices.getMandalName(district,mandal);
				String pname=rwsOffices.getPanchayatName(district,mandal,panchayat);
				String vname=rwsOffices.getVillageName(getDataSource(request),district,mandal,panchayat,village);
				request.setAttribute("dName",dname);
				request.setAttribute("mName",mname);
				request.setAttribute("pName",pname);
				request.setAttribute("vName",vname);
			
			session.setAttribute("list",assetList);
			frm1.setList(assetList);
			}
			catch(Exception e)
			{
				System.out.println("Exception addAsset"+e);
			}
		}


		if(mode.equalsIgnoreCase("getAssets"))
		{
		
		}
		if(mode.equalsIgnoreCase("getAssetsWorks"))
		{
			try {
			String[] assetTypes = {};
			String aTypes = request.getParameter("aTypes");
		
			String selATypes = "Asset Types:&nbsp;</font><font face=verdana size=2 color=blue>";
			if(aTypes!=null){
				assetTypes = aTypes.split(",");
			
				for(int i=0;i<assetTypes.length;i++)
				{
			
					if(assetTypes[i].equals("01"))selATypes+= " PWS &nbsp;";
					else if(assetTypes[i].equals("02"))selATypes+= " MPWS &nbsp;";
					else if(assetTypes[i].equals("03"))selATypes+= " CPWS &nbsp;";
					else if(assetTypes[i].equals("09"))selATypes+= " DIRECT PUMPING &nbsp;";
					else if(assetTypes[i].equals("04"))selATypes+= " HAND PUMPS &nbsp;";
					else if(assetTypes[i].equals("05"))selATypes+= " SHALLOW HAND PUMPS &nbsp;";
					else if(assetTypes[i].equals("06"))selATypes+= " OPEN WELLS &nbsp;";
					else if(assetTypes[i].equals("07"))selATypes+= " PONDS &nbsp;";
					else if(assetTypes[i].equals("08"))selATypes+= " OTHERS &nbsp;";
				}
			}
			request.setAttribute("selATypes",selATypes);
			CommonLists commonLists = new CommonLists(getDataSource(request));
			ArrayList assets = commonLists.getAssets(request.getParameter("habCode"),request.getParameter("schoolCode"),assetTypes);
			request.setAttribute("assets",assets);
			} catch (Exception e) {
			System.out.println("exception getAssetsWorks -- "+e);
			}
			mode="getAssets";
		}
		if(mode.equalsIgnoreCase("saveAssetsWorks")){
			
			int count = 0;
			try {
			String[] assets = {};
			String assetss = request.getParameter("assets");
			
			if(assetss!=null){
				assets = assetss.split(",");
			
				for(int i=0;i<assets.length;i++)
				{
					
				}
			}
			CommonLists commonLists = new CommonLists(getDataSource(request));
			count += commonLists.saveAssets(request.getParameter("habCode"),request.getParameter("schoolCode"),assets);
			if(count>0)
				request.setAttribute("message",count+" Asset(s) or Work(s) Added Successfully to the School With Sl. No:"+(Integer.parseInt(request.getParameter("rowid"))+1));
			} catch (Exception e) {
				System.out.println("exception saveAssetsWorks mode -- "+e);
			}
			mode="close";
			
		}
		return(mapping.findForward(mode));
	}
	public void reset1(SchoolForm frm)  
	{
		frm.setDistrict("");
		frm.setMandal("");
		frm.setVillage("");
		frm.setPanchayat("");
		frm.setHabitation("");
		//
		frm.setSchoolName("");
		frm.setCategory("");
		frm.setClassify("");
		frm.setDrkMonth("");
		frm.setDrkYear("");
		frm.setFacilities("");
		frm.setNoBoys("");
		frm.setNoGirls("");
		frm.setNoStudents("");
		frm.setSaniMonth("");
		frm.setUrinals("");
		frm.setToilets("");
		frm.setRunningwater("");
		frm.setSourceSaniFund("");
		frm.setSourceDrkFund("");
		//
		frm.setSaniYear("");
		frm.setSaniMonth("");
		frm.setNonDrink("");
		frm.setNonSani("");
		frm.setSchoolLatitude("");
		frm.setSchoolLongitude("");
		frm.setSchoolElevation("");
		frm.setSchoolWaypoint("");
		 
	
	}
	
}
