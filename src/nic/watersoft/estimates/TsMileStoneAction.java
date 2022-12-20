/*
 * Created on 04-Nov-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.estimates;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.fundAccounting.Rws_BroProgDetailsBean;
import nic.watersoft.masters.RwsHabStatusData;
import nic.watersoft.works.WorksDAO;
import nic.watersoft.works.rws_works_WorkStatus_bean;
import nic.watersoft.works.rws_works_WorkStatus_form;
import nic.watersoft.works.rws_works_factory;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author sridhar
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TsMileStoneAction extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{ 
		System.out.println("in my action class");	
		DataSource ds = null;
		String circleOfficeCode,divisionOfficeCode,subdivisionOfficeCode;
		CommonLists	commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		TsMileStoneForm frm=(TsMileStoneForm)form;
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		String headOfficeCode = user.getHeadOfficeCode();
		frm.setPreparedBy(user.getUserId());
		frm.setOfficeCode(user.getOfficeCode());
		
		RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
		EstimateDAO dao=new EstimateDAO(getDataSource(request));
		
		
		String mode=frm.getMode();
		String mode1=frm.getMode1();
		Debug.println("mode:"+mode);
		Debug.println("mode1:"+mode1);
		rws_works_WorkStatus_bean bean = null;
		if(mode!=null && mode.equals("data")){
		try{
		String ccode=frm.getCircleOfficeCode();
		String divcode=frm.getDivisionOfficeCode();
		String subcode=frm.getSubdivisionOfficeCode();
		String assetType=frm.getAssetType();
		Debug.println("user:"+user);
		if(user==null||user.getUserId()==null){
    		return mapping.findForward("expire");
    	 	}
		
		if(mode1==null)
		{ 
		Debug.println("in circles");
		session.removeAttribute("Milestones");
		frm.setMileStones(new ArrayList());
		ArrayList circles = rwsoffice.getCircles();
		session.setAttribute("circles", circles);
		session.removeAttribute("divisions");
		session.removeAttribute("subdivisions");
		session.removeAttribute("assetTypes");
		session.removeAttribute("workIds");
		session.removeAttribute("Milestones");
		frm.setDivisionOfficeCode("");
		frm.setSubdivisionOfficeCode("");
		frm.setAssetType("");
		frm.setWorkId("");
		}
		if(mode1!=null && mode1.equals("divisions")){
		Debug.println("in divisions");
		ArrayList divisions = rwsoffice.getDivisions1(ccode);
		session.setAttribute("divisions", divisions);
		session.removeAttribute("subdivisions");
		session.removeAttribute("assetTypes");
		session.removeAttribute("workIds");
		session.removeAttribute("Milestones");
		frm.setDivisionOfficeCode("");
		frm.setSubdivisionOfficeCode("");
		frm.setAssetType("");
		frm.setWorkId("");
		}
		if(mode1!=null &&  mode1.equals("subdivisions")){
			ArrayList subdivisions = rwsoffice.getSubDivisions1(ccode,divcode);
			session.setAttribute("subdivisions", subdivisions);
			session.removeAttribute("assetTypes");
			session.removeAttribute("workIds");
			session.removeAttribute("Milestones");
			frm.setSubdivisionOfficeCode("");
			frm.setAssetType("");
			frm.setWorkId("");
			}
		if(mode1!=null && mode1.equals("asttypes")){     
		
		ArrayList assetTypes = dao.getAssetTypesWork();
		session.setAttribute("assetTypes", assetTypes);
		session.removeAttribute("workIds");
		session.removeAttribute("Milestones");
		frm.setAssetType("");
		frm.setWorkId("");
		}
		if(mode1!=null && mode1.equals("works")){
			frm.setWorkId("");
			session.removeAttribute("Milestones");
			frm.setMileStones(new ArrayList());
			if((ccode!=null && !ccode.equals("")) && (divcode!=null && !divcode.equals("") && (assetType!=null && !assetType.equals(""))))
			{
				ArrayList workIds = dao.getWorkIds(ccode,divcode,subcode,assetType);
				session.setAttribute("workIds", workIds);
			}
		}
		if (session.getAttribute("MILESTONES") == null) {
			Debug.println("in get components");
			ArrayList Milestones = dao.getComponents();
			session.setAttribute("MILESTONES", Milestones);
		}
		if(mode1!=null && mode1.equals("save"))
		{  
			String index[] = request.getParameterValues("check");
			Debug.println("workid:"+frm.getWorkId());
			ArrayList mileStones = frm.getMileStones();
			int rvalue = 0;//dao.insertMistoneData(mileStones, frm.getWorkId(),bean);
			ArrayList habs =  (ArrayList) session.getAttribute("SanctionedHabs");
			ArrayList items = frm.getMileStones();
			rvalue = dao.insertTsDetails(frm,habs,items);
			 for (int i = 0; i < items.size(); i++) {
				bean = (rws_works_WorkStatus_bean) items.get(i);
				if(bean.getMileStone()!=null && !bean.getMileStone().equals(""))
				{
					bean.setStages(dao.getItems(bean.getMileStone()));
				}
			}
			Debug.println("rvalue is" + rvalue);
			if (rvalue == -1)
				request.setAttribute("message", "Cannot Save");
			else if (rvalue == 1)
				request.setAttribute("message", "Saved Successfully");
			else if (rvalue == 2)
				request.setAttribute("message", "Updated Successfully");
			for (int i = 0; i < mileStones.size(); i++) {
				bean = (rws_works_WorkStatus_bean) mileStones.get(i);
				
			}
			session.setAttribute("Milestones", mileStones);
			frm.setMileStones(mileStones);
			mode1 = "getMiles";

		}
		if(mode1!=null && mode1.equals("remove"))
		{
			ArrayList Milestones = new ArrayList(frm.getMileStones());
			Debug.println("Milestones size:"+Milestones.size());
			String index[] = request.getParameterValues("check");
			int removedMs = 0;
			/*for (int i = 0; i < index.length; i++) {
				int ndx = 0;
				if (index[i] != null) {
					try {
						ndx = Integer.parseInt(index[i]);
						bean = (rws_works_WorkStatus_bean) Milestones.get(Integer.parseInt(index[i]));
						Debug.println("code:"+bean.getMileStoneSno());
						);
					}
					catch(Exception e){e.printStackTrace();}
				}
			}*/
			int count = dao.RemoveItems(frm.getWorkId(),index,Milestones);
			Debug.println("coount:"+count);
			if(count>0)request.setAttribute("message","Selected Item(s) Deleted Successfully");
			else request.setAttribute("message","Deletion Failed");
			Debug.println("******************="+request.getAttribute("message"));
			mode1 = "getMiles";
		}
		if(mode1!=null && mode1.equals("items"))
		{
			//item logic goes here

			String index = request.getParameter("index");
			Debug.println("Index is :" + index);
			int ndx = 0;
			if (index != null) {
				try {
					ndx = Integer.parseInt(index);
				} catch (NumberFormatException nfe) {
					Debug.println("Error converting index to ndx "
							+ nfe);
				}
			}
			ArrayList Milestones = new ArrayList(frm.getMileStones());
			Debug.println("Milestones1111" + Milestones.get(ndx));
			Debug.println("Milestones2222" + Milestones.size());
			//bean=new rws_works_WorkStatus_bean();
			bean = (rws_works_WorkStatus_bean) Milestones.get(ndx);
			Debug.println("" + bean);
			String mileStoneCode = bean.getMileStone();
			//mileStoneCode=request.getParameter("MILES["+ndx+"].mileStone");
			Debug.println("mile code:3333" + bean.getMileStone());
			Debug.println("mileStoneCode[" + ndx + "] is 444:"+ mileStoneCode);
			ArrayList stages = dao.getItems(mileStoneCode);
			bean.setStages(stages);
			//Milestones.remove(ndx);
			Milestones.set(ndx, bean);
			for (int i = 0; i < Milestones.size(); i++) {
				bean = (rws_works_WorkStatus_bean) Milestones.get(i);
				if(bean.getMileStone()!=null && !bean.getMileStone().equals(""))
				{
					bean.setStages(dao.getItems(bean.getMileStone()));
				}
			}
			//Milestones.set(ndx, bean);
			Debug
					.println("mileStonesList size is 55555:"+ Milestones.size());
			session.setAttribute("Milestones", Milestones);
		
		}
		if(mode1!=null && mode1.equals("getMiles")){
			session.removeAttribute("officeName");
			if(frm.getWorkId()!=null && !frm.getWorkId().equals(""))
			{
				bean = new rws_works_WorkStatus_bean();
				//for(int i=0;i<5;i++)
				//{
				bean = new rws_works_WorkStatus_bean();

				//session.setAttribute("SanctionedRevHabs",(ArrayList)session.getAttribute("SanctionedHabs"));

				//}
				WorksDAO dao1 = rws_works_factory.createWorksDAO(ds);
				bean = dao1.getTsDetails(frm.getWorkId());
				String workAssignedTo = null;
				RwsOffices offices = new RwsOffices();
				if (bean != null) {

					Debug.println("in if%%%%%%%%%%%%%%%%%");
					frm.setTsAccBy(bean.getTsAccBy());
					frm.setTsAmnt(bean.getTsAmnt());
					frm.setTsDate(bean.getTsDate());
					frm.setTsNo(bean.getTsNo());
					//frm.setSsrYear(bean.getSsrYear());
					frm.setSyr(bean.getSyr());
					dao1 = rws_works_factory.createWorksDAO(ds);
					rws_works_WorkStatus_bean beanNew = new rws_works_WorkStatus_bean();
					Debug.println("CALLING GET POPULATION DETAILS");
					beanNew = dao1.getPopulationDetails(frm.getWorkId()," RWS_EST_NEW_HAB_LNK_TBL ");
					/** Tecnical sanction */
					frm.setTsPlainPop(beanNew.getAdminPlainPopu());
					frm.setTsScPop(beanNew.getAdminScPopu());
					frm.setTsStPop(beanNew.getAdminSTPopu());
					frm.setTsTotPop(beanNew.getAdminTotpopu());
					try {
						if (bean.getTsOffice() != null
								|| !bean.getTsOffice().equals("")) {
							Debug.println("bean.getTsOffice().length()"
									+ bean.getTsOffice().length());
							if (bean.getTsOffice().length() > 4)
								frm.setSubDivCode(bean.getTsOffice()
										.substring(4, 6));
						}
					} catch (Exception e) {
						Debug.println("Exception ::::" + e);
					}
					/** Admin Details */
					dao1 = rws_works_factory.createWorksDAO(ds);
					rws_works_WorkStatus_form fb1 = dao1.getAdminAndRevisedDetails(frm.getWorkId());
					Debug.println("fb1:" + fb1);
					Debug.println("fb1.getAdminNo():" + fb1.getAdminNo());
					frm.setAdminNo(fb1.getAdminNo());
					frm.setAdminDate(fb1.getAdminDate());
					workAssignedTo = fb1.getOfficeCode();

					long adminSancAmnt = (int) (Float.parseFloat(fb1
							.getAdminAmnt()) * 100000);
					/** To get the other grants amount for the same work */
					dao1 = rws_works_factory.createWorksDAO(ds);
					adminSancAmnt = adminSancAmnt+ dao1.getAdminOtherGrantsAmnt(frm.getWorkId());
					frm.setAdminAmnt(adminSancAmnt / 100000.00 + "");

					dao1 = rws_works_factory.createWorksDAO(ds);
					ArrayList SanctionedHabs = dao1.getTshabs(frm.getWorkId());
					Debug.println("ts habs size:" + SanctionedHabs.size());
					if (SanctionedHabs != null) {
						session.setAttribute("SanctionedHabs",
								SanctionedHabs);
						frm.setTsHabsBen(Integer.toString(SanctionedHabs
								.size()));
						// frm.setRevTsHabsBen(Integer.toString(SanctionedHabs.size()));
						request.setAttribute("UPDATE", "TS-DETAILS");
					}
				}

				else {
					/** To get the details of technical Sanction accored by */
					frm.setTsAccBy("");
					frm.setTsAmnt("");
					frm.setTsDate("");
					frm.setTsNo("");
					//frm.setSsrYear(bean.getSsrYear());
					frm.setSyr("");
					frm.setTsPlainPop("");
					frm.setTsScPop("");
					frm.setTsStPop("");
					frm.setTsTotPop("");
					session.removeAttribute("SanctionedHabs");
					Debug.println("in else with workid:" + frm.getWorkId());
					dao1 = rws_works_factory.createWorksDAO(ds);
					rws_works_WorkStatus_form fb1 = dao1 .getAdminAndRevisedDetails(frm.getWorkId());
					Debug.println("in else%%%%%%%%%%%%%%%%%:"
							+ fb1.getAdminAmnt());
					/////%%%%%%%%%the following line has been commented
					//dao = rws_works_factory.createWorksDAO(ds);
					if (fb1.getAdminAmnt() != null) {
						long adminSancAmnt = (int) (Float.parseFloat(fb1
								.getAdminAmnt()) * 100000);
						/** To get the other grants amount for the same work */
						dao1 = rws_works_factory.createWorksDAO(ds);
						adminSancAmnt = adminSancAmnt+ dao1.getAdminOtherGrantsAmnt(frm.getWorkId());
						/**
						 * To get the details of technical Sanction accored
						 * by
						 */
						dao1 = rws_works_factory.createWorksDAO(ds);
						String tcAccbY = dao1.getTsAccordedBy(Long.toString(adminSancAmnt));
						/**
						 * To give the information abt admin sanction in
						 * tecnical snaction
						 */

						dao1 = rws_works_factory.createWorksDAO(ds);
						rws_works_WorkStatus_form fb2 = dao1.getAdminAndRevisedDetails(frm.getWorkId());
						Debug.println("-------adminSancAmnt-----"
								+ adminSancAmnt);
						frm.setAdminAmnt(adminSancAmnt / 100000.00 + "");
						Debug.println("-------adminSancAmnt-----"
								+ frm.getAdminAmnt());
						frm.setAdminNo(fb2.getAdminNo());
						frm.setAdminDate(fb2.getAdminDate());
						frm.setTsHabsBen(fb2.getAdminHabsBen());
						//frm.setRevTsHabsBen(bean.getAdminHabsBen());
						frm.setTsAmnt(frm.getAdminAmnt());
						workAssignedTo = fb2.getOfficeCode();

						/** To show the list of habitions to add or remove */
						dao1 = rws_works_factory.createWorksDAO(ds);
						ArrayList SanctionedHabs = dao1.getAdminSanctionedHabs(frm.getWorkId());
						if (SanctionedHabs != null) {
							session.setAttribute("SanctionedHabs",SanctionedHabs);

						}
						frm.setTsAccBy(tcAccbY);

					}
				}
				if (frm.getTsAccBy().equals("AEE")
						|| frm.getTsAccBy().equals("DEE")) {
					ArrayList SubDivs = offices.SubDivisionCombo("1", workAssignedTo.substring(1, 3),
							workAssignedTo.substring(3, 4));
					if (SubDivs != null)
						session.setAttribute("SubDivs", SubDivs);
				}
				if (frm.getTsAccBy().equals("EE")) {
					String Divs = offices.getDivisionOfficeName(ds,
							"1", workAssignedTo.substring(1, 3),
							workAssignedTo.substring(3, 4));
					if (Divs != null)
						session.setAttribute("officeName", Divs);
				}
				if (frm.getTsAccBy().equals("SE")) {
					String cirlceName = offices.getCircleOfficeName(ds,
							"1", workAssignedTo.substring(1, 3));
					if (cirlceName != null)
						session.setAttribute("officeName", cirlceName);
				}
			ArrayList miles=dao.getMileStoneData(frm.getWorkId());
			for (int i = 0; i < miles.size(); i++) {
				bean = (rws_works_WorkStatus_bean) miles.get(i);
				if(bean.getMileStone()!=null && !bean.getMileStone().equals(""))
				{
					bean.setStages(dao.getItems(bean.getMileStone()));
				}
			}
			session.setAttribute("Milestones",miles);
			}
			else
			{
				session.removeAttribute("Milestones");
			}
		}
		}catch(Exception e){  
		 Debug.println("Exception in data mode:"+e);	
		}
		
		} 
		
		if(mode!=null && mode.equals("addNew"))
		{
		 try{
		 	//Debug.println("in addnew mode :"+frm.getMileStones());
		 	ArrayList Milestones = frm.getMileStones();
		 	
		 	if(Milestones==null || (Milestones!=null && Milestones.size()==0))//adding new row of first time 
    		{
    			Milestones=new ArrayList();
    		
    		}
		 	
		 	Debug.println("size of milestone:"+Milestones.size());
		 		int sno=1;
		 		if(Milestones.size()!=0)
				{
					bean = (rws_works_WorkStatus_bean)Milestones.get(Milestones.size()-1);
					sno = Integer.parseInt(bean.getMileStoneSno());
					//sno = Milestones.size();
					sno++;
				}
		 		
		 	  	Debug.println("4:"+sno);// adding rows to the existing rows
    			bean = new rws_works_WorkStatus_bean();
    			bean.setMileStoneSno(""+sno);
			    Milestones.add(bean);
			    for (int i = 0; i < Milestones.size(); i++) {
					bean = (rws_works_WorkStatus_bean) Milestones.get(i);
					if(bean.getMileStone()!=null && !bean.getMileStone().equals(""))
					{
						bean.setStages(dao.getItems(bean.getMileStone()));
					}
				}
    			Debug.println("size:"+Milestones.size());
    			session.setAttribute("Milestones",Milestones);
    			frm.setMileStones(Milestones);
   
		 }catch(Exception e){
		 	Debug.println("Exception in addNew Mode:"+e);
		 }
		}
		frm.setTsOffice(headOfficeCode + frm.getCircleOfficeCode()+ frm.getDivisionOfficeCode());
		if (frm.getSubdivisionOfficeCode() != null)
			frm.setTsOffice(frm.getTsOffice() + frm.getSubdivisionOfficeCode());
	 return mapping.findForward(mode);
	}

}
