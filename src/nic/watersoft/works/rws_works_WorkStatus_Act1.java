
package nic.watersoft.works;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;

public class rws_works_WorkStatus_Act1 extends Action 
{
    public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
    	System.gc();
    	DataSource ds=null;
    	ArrayList circles=null;
    	ArrayList divisions=null;
    	ArrayList subdivs=null;
    	ArrayList programmes=null;
    	ArrayList subprogrammes=null;
    	ArrayList workCategory=null;
    	
    	Runtime s_runtime = Runtime.getRuntime ();
    	long Used_memory = s_runtime.totalMemory () - s_runtime.freeMemory ();
    	System.gc();
		String SUCCESS = "success";
		Used_memory = s_runtime.totalMemory () - s_runtime.freeMemory ();
		System.gc();
		HttpSession session = request.getSession();
		RwsUser user=null;
		user=(RwsUser)session.getAttribute("RWS_USER");
		
		if(user==null)return mapping.findForward("expire");
		
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
						|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		
        String headOfficeCode=user.getHeadOfficeCode();
        rws_works_WorkStatus_form fb=(rws_works_WorkStatus_form)form;
        fb.setPreparedBy(user.getUserId());
        fb.setOfficeCode(user.getOfficeCode());
        rws_works_WorkStatus_bean  bean=null;
        WorksDAO dao=null;
       	try{
			    ds=getDataSource(request);
			    RwsOffices offices=new RwsOffices(ds);
		        String mode=fb.getMode();
		        String spmode = "";
		        String workStage=fb.getWorkStage();
		        if(workStage!=null && workStage.equals(""))
		        {
		        	if(mode.equals("circles"))
			        {
			        	session.removeAttribute("divs");
			        	session.removeAttribute("subdivs");
			        	session.removeAttribute("workCategory");
			        	session.removeAttribute("programmes");
			        	session.removeAttribute("subprogrammes");
			        	session.removeAttribute("rwsWorks");
			        	circles=offices.CircleCombo(headOfficeCode);
			            if(circles!=null)
			        	session.setAttribute("circles",circles);
			        	if(user.getUserId().equals("admin")||user.getUserId().equals("100000"))
			        	{
		        		    session.setAttribute("fixcircle",null);
		        		    fb.setDivCode("");
	 	        		    fb.setSubdivisioncode("");
	 	        		    fb.setProgram("");
	 	        		    fb.setSubprogram("");
			        	   	fb.setScheme(""); 
				        	fb.setWorkName("");
			        	}
			        	
			            if(!(user.getUserId().equals("admin")||user.getUserId().equals("100000")))
			        	{
			        		mode="div";
			        		fb.setCircleCode(user.getUserId().substring(1,3));
			        		session.setAttribute("fixcircle","yes");
			        		fb.setDivCode("");
			        		fb.setProgram("");
		 	        		fb.setSubprogram("");
			        		fb.setScheme(""); 
			        	}
			        }
		        	
			        if(mode.equals("div"))
			        {
			        	session.removeAttribute("divs");
			         	divisions=offices.DivisionCombo(headOfficeCode,fb.getCircleCode());
			        	session.setAttribute("divs",divisions);
			        	session.removeAttribute("workCategory");
			        	session.removeAttribute("subdivs");
			        	session.removeAttribute("programmes");
			        	session.removeAttribute("subprogrammes");
			        	session.removeAttribute("rwsWorks");
			        	fb.setScheme(null);
			        	fb.setWorkCat("");
			        	fb.setDivCode("");
			        	fb.setSubDivCode("");
			        	fb.setProgCode("");
			        	fb.setSubProgCode("");
			        	
			        	workCategory=offices.getWorkCategory();
			        	session.setAttribute("workCategory",workCategory);
			        	
			        }
			        if(mode.equals("subdiv"))
					{
			        	session.removeAttribute("workCategory");
			        	offices = null;
			        	offices = new RwsOffices(ds);
			        	subdivs=offices.SubDivisionCombo(headOfficeCode,fb.getCircleCode(),fb.getDivCode());
			        	fb.setWorkCat("");
			        	fb.setProgCode("");
			        	fb.setSubProgCode("");
			        	if(subdivs!=null)
			        	{
				        	session.setAttribute("subdivs",subdivs);
				        	session.removeAttribute("programmes");
				        	session.removeAttribute("subprogrammes");
				        	session.removeAttribute("rwsWorks");
				        	fb.setScheme(null);
			        	}
			        	workCategory=offices.getWorkCategory();
			        	session.setAttribute("workCategory",workCategory);
			        	
			        	dao = rws_works_factory.createWorksDAO(ds);
				        ArrayList worksList = new ArrayList();
				        worksList = dao.getCommWorkDetails(fb);
				        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
				        if(worksList!=null)
				        {
				         session.setAttribute("rwsWorks",worksList);
				        fb.setScheme(null);
				        }
			        }
			        if(mode.equals("subdiv1"))
					{
			        	workCategory=offices.getWorkCategory();
			        	session.setAttribute("workCategory",workCategory);
			        	fb.setWorkCat("");
			        	fb.setProgCode("");
			        	fb.setSubProgCode("");
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
			        	session.removeAttribute("rwsWorks");
			        	session.removeAttribute("programmes");
			         	programmes=offices.getProgrammes1(fb.getPlan(),fb.getWrktype(),fb.getWorkCat());
			        	if(programmes.size()!=0)
			        	{
				        session.setAttribute("programmes",programmes);
			        	fb.setScheme(null);
			        	}
			        	fb.setProgram("");
			        	fb.setProgCode("");
			        	fb.setSubProgCode("");
			        	
			        	

			        	bean=new rws_works_WorkStatus_bean();
			        	dao = rws_works_factory.createWorksDAO(ds);
				        ArrayList worksList = new ArrayList();
				        worksList = dao.getCommWorkDetails(fb);
				        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
				        if(worksList!=null)
				        {
				         session.setAttribute("rwsWorks",worksList);
				        fb.setScheme(null);
				        }
			        
				        
			        }
			        if(mode.equals("subprogram"))
					{
			        	session.removeAttribute("subprogrammes");
			            subprogrammes=offices.getSubProgrammes(fb.getProgram());
			        	if(subprogrammes!=null)
			        	{
			        	session.setAttribute("subprogrammes",subprogrammes);
			        	session.removeAttribute("rwsWorks");
			        	fb.setScheme(null);
			        	}
			         	fb.setSubprogram("");
			        	fb.setSubProgCode("");
			        	
			        	dao = rws_works_factory.createWorksDAO(ds);
				        ArrayList worksList = new ArrayList();
				        worksList = dao.getCommWorkDetails(fb);
				        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
				        if(worksList!=null)
				        {
				         session.setAttribute("rwsWorks",worksList);
				        fb.setScheme(null);
				        }
			        }
			        if (mode.equals("workcombo"))
			        {
			        	bean=new rws_works_WorkStatus_bean();
			        	dao = rws_works_factory.createWorksDAO(ds);
				        ArrayList worksList = new ArrayList();
				        worksList = dao.getCommWorkDetails(fb);
				        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
				        if(worksList!=null)
				        {
				         session.setAttribute("rwsWorks",worksList);
				        fb.setScheme(null);
				        }
			        }
			       if(mode.equals("circles1"))
			        {
			        	circles=offices.CircleCombo(headOfficeCode);
			        	if(circles!=null)
			        	session.setAttribute("circles",circles);
			        	
		        		    fb.setCircleCode(request.getParameter("circleCode"));
		        	
		        		    divisions=offices.DivisionCombo(headOfficeCode,fb.getCircleCode());
		        		    if(divisions!=null)
		    		        session.setAttribute("divs",divisions);
		        		    fb.setDivCode(request.getParameter("divCode"));
		        		    subdivs=offices.SubDivisionCombo(headOfficeCode,fb.getCircleCode(),fb.getDivCode());
		        		    if(subdivs!=null)
		    		        session.setAttribute("subdivs",subdivs);
		        		    
				        	bean=new rws_works_WorkStatus_bean();
				        	dao = rws_works_factory.createWorksDAO(ds);
					        ArrayList worksList = new ArrayList();
					        worksList = dao.getCommWorkDetails(fb);
					        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
					        if(worksList!=null)
					        {
					         session.setAttribute("rwsWorks",worksList);
					        
					        }
		        		    fb.setWorkId(request.getParameter("workId"));//added
			        		
			        		
			        }
			        if((mode!=null && mode.equals("works"))||(request.getParameter("wMode")!=null&&request.getParameter("wMode").equals("works")))
			        { 
			        	String divcode=fb.getSubdivisioncode();
			        	
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	bean=new rws_works_WorkStatus_bean(); 
			        	rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
				        fb.setProgName(fb1.getProgName());
				        fb.setSubProgName(fb1.getSubProgName());
				        fb.setScheme(fb1.getScheme());
				        fb.setSchemeCode(fb1.getSchemeCode());
				        fb.setProgCode(fb1.getProgCode());
				        fb.setSubProgCode(fb1.getSubProgCode());
			        	  
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	bean=new rws_works_WorkStatus_bean();
			        	bean=dao.getPopulationDetails(fb.getWorkId(),"RWS_ADMN_HAB_LNK_TBL");
			        	fb.setAdminPlainPopu(bean.getAdminPlainPopu());
			        	fb.setAdminScPopu(bean.getAdminScPopu());
			        	fb.setAdminSTPopu(bean.getAdminSTPopu());
			        	fb.setAdminTotpopu(bean.getAdminTotpopu());
			        	
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	bean=new rws_works_WorkStatus_bean();
			        	bean=dao.getPopulationDetails(fb.getWorkId(),"RWS_REV_ADM_SANC_HAB_LNK_TBL");
			        	fb.setRevPlainPopu(bean.getAdminPlainPopu());
			        	fb.setRevScPopu(bean.getAdminScPopu());
			        	fb.setRevSTPopu(bean.getAdminSTPopu());
			        	fb.setRevTotpopu(bean.getAdminTotpopu());
			        	fb.setSubdivisioncode(bean.getSubdivisioncode());
			        	
			        	bean=new rws_works_WorkStatus_bean();
			        	fb.setSubdivisioncode(divcode);
			        	bean.setSubdivisioncode(divcode);
			        	dao = rws_works_factory.createWorksDAO(ds);
				        ArrayList worksList = new ArrayList();
				        worksList = dao.getCommWorkDetails(fb);
				        if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))request.setAttribute("Includepage","01");
				        if(worksList!=null)
				        session.setAttribute("rwsWorks",worksList);
			        }
			        
			        if(mode.equalsIgnoreCase("save"))
			        {
			        try {
					    
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	String message = dao.saveAsset(fb,request,ds);
			        	if(message.equals("Record inserted Successfully-Please Select Asset Code to Add SubComponents"))
			        	{
			        		request.setAttribute("message","Scheme Successfully Converted to Asset - Please Add SubComponents");
			        		request.setAttribute("Includepage1","01");
			        		dao = rws_works_factory.createWorksDAO(ds);
				        	String info = dao.getCompInfoAndYieldInfo(fb.getAssetCode(),fb.getAssetTypeCode());
				        	request.setAttribute("info",info);
			        		request.setAttribute("Includepage2","02");
			        		request.setAttribute("assetTypeCodde",fb.getAssetTypeCode());
			        	}
			        	else if(message.equals("Record Cannot be Inserted"))
			        	{
			        		request.setAttribute("message","Scheme Failed to Convert Asset");
			        		request.setAttribute("Includepage1","01");
			        	}
			        	mode = "getWorkStatus";
			        	mode = "showMsg";
			        	return mapping.findForward("showMsg");
			        
			        }
			        catch (Exception e) {
						System.out.println("exception in save mode of rws_works_workstatus_act1--"+e);
						
					}
			        }
			        if(mode.equals("getAugDetails"))
			        {
			        	if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))
			        	{
			        		dao = rws_works_factory.createWorksDAO(ds);
			        		String workIdd = dao.getMainSchemeWork(fb.getWorkId());
		        			if(workIdd.length()==14)
		        			{
		        				dao = rws_works_factory.createWorksDAO(ds);
				        		String stat = dao.getWorkStatus(fb.getWorkId());
				        		if(stat.equals(""))
				        			request.setAttribute("augConvertConfirm","Y");
				        		else
				        			mode ="getWorkStatus"; 
		        			}
		        			else
		        			{
		        				request.setAttribute("message","Unable to convert Scheme to Asset - Please Link this Augmentation Scheme to Main Scheme thru WorkFlow->WorksMonitoring->Augmentation-MainScheme Linkage - then Try Again to Covert Scheme to Asset");
		        			}
			        	}
			        	
	        		
	        		
			        }
			        if(mode.equals("getAugDetailsNextStep"))
			        {
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	String wId = dao.getMainSchemeWork(fb.getWorkId());
			        	
			        	if(!wId.equals(""))
			        	{
			        		fb.setWorkId(dao.getMainSchemeWork(fb.getWorkId()));
				        	spmode = mode;
		        			mode ="getWorkStatus";
			        	}
			        	else
			        	{
			        		request.setAttribute("message","Unable to convert Scheme to Asset - Please Link this Augmentation Scheme to Main Scheme thru WorkFlow->WorksMonitoring->Augmentation-MainScheme Linkage - then Try Again to Covert Scheme to Asset");
			        	}
			        }
			        if(mode.equals("changeAssetType"))
			        {
			        	//if(fb.getWorkId()!=null && !fb.getWorkId().substring(6,8).equals("03"))
			        	if(fb.getWorkId()!=null )
			        	{
				        	dao = rws_works_factory.createWorksDAO(ds);
				        	CommonLists commonLists = new CommonLists(getDataSource(request));
				        	ArrayList assetTypes = commonLists.getAssetTypes();
							session.setAttribute("assetTypes", assetTypes);
				        	return mapping.findForward(mode);
			        	}
			        	else
			        		mode = "getWorkStatus";
			        }
			        if(mode.equals("getWorkStatus"))
			        {
			        	if(fb.getWorkId()!=null && !fb.getWorkId().equals(""))
			        	{
			        		dao = rws_works_factory.createWorksDAO(ds);
			        		String stat = dao.getWorkStatus(fb.getWorkId());
			        		String hab = "";
					        if(stat.equals(""))
				        	{
					        	dao = rws_works_factory.createWorksDAO(ds);
					        	hab = dao.getLeadHab(fb.getWorkId());
					        	if(spmode!=null && spmode.equals("getAugDetailsNextStep"))
				        		{
				        			request.setAttribute("message","The MainScheme Work Not Yet Converted - Please Convert");
				        			fb.setWrktype("1");
				        			dao = rws_works_factory.createWorksDAO(ds);
							        ArrayList worksList = new ArrayList();
							        worksList = dao.getCommWorkDetails(fb);
							        session.setAttribute("rwsWorks",worksList);
				        		}
					        	if(hab.equals(""))
						        {
					        		if(spmode!=null && spmode.equals("getAugDetailsNextStep"))
					        		{
					        			request.setAttribute("message","Unable to convert Scheme - Please Select Lead Habitation for the Main Scheme Work");
					        		}
					        		else
					        			request.setAttribute("message","Unable to convert Scheme - Please Select Lead Habitation");
									    request.setAttribute("leadHab","Y");
						        }
						        else
						        {
						        	try
									{
						        		rws_works_WorkStatus_form fb1 =  null;
							        	dao = rws_works_factory.createWorksDAO(ds); 
							        	fb1 = dao.getWorkDetails(fb);
							        	String sName="";
							        	if(fb1.getSchemeCode()!=null ){
						        			String sCode=fb1.getSchemeCode();
						        			if(sCode.equals("01"))sName="PWS";
							        		else if(sCode.equals("02"))sName="MPWS";
							        		else if(sCode.equals("03"))sName="CPWS";
							        		else if(sCode.equals("04"))sName="HANDPUMPS";
							        		else if(sCode.equals("05"))sName="SHALLOW HAND PUMPS";
							        		else if(sCode.equals("09"))sName="DIRECT PUMPING";
							        		else if(sCode.equals("10"))sName="SUSTAINABILITY";
							        		else if(sCode.equals("06"))sName="OPEN WELLS";
							        		else if(sCode.equals("07"))sName="PONDS";
							        		else if(sCode.equals("08"))sName="OTHERS";
							        		
							        		session.setAttribute("type_of_asset", sName);
						        		}
							        	//if((fb1.getSchemeCode()!=null && !fb1.getSchemeCode().equals("03")) && (request.getParameter("schemeSpecial")==null))
							        	if( (request.getParameter("schemeSpecial")==null))
							        	{
							        		request.setAttribute("message","This ssScheme is under "+sName+" Scheme - Please Select Asset Type");
							        		request.setAttribute("pwsWork","Y");
							        		fb.setScheme("");
									        fb.setSchemeCode("");
							        	}
							        	else
							        	{
							        		request.removeAttribute("pwsWork");
							        	}
							        	
							        	//if((fb1.getSchemeCode()!=null && fb1.getSchemeCode().equals("03")) || (request.getParameter("schemeSpecial")!=null && !request.getParameter("schemeSpecial").equals("")))
							        		if((request.getParameter("schemeSpecial")!=null && !request.getParameter("schemeSpecial").equals("")))
							        	{
								        	fb.setHeadOfficeCode("1");
									        fb.setHeadOfficeName("CE RWS");
									        
							        		String habCode = hab;
							        		
							        		dao = rws_works_factory.createWorksDAO(ds);
							        		ArrayList officeDetails1 = dao.getOfficeDetails(habCode);
							        		
							        		ArrayList officeDetails = (ArrayList)officeDetails1.get(0);
							        		
									        fb.setCircleOfficeCode(""+officeDetails.get(0));
									        fb.setCircleOfficeName(""+officeDetails.get(1));
									        
									        fb.setDivisionOfficeCode(""+officeDetails.get(20));
									        fb.setDivisionOfficeName(""+officeDetails.get(21));
									        
									        fb.setSubdivisionOfficeCode(""+officeDetails.get(22));
									        fb.setSubdivisionOfficeName(""+officeDetails.get(23));
									        
									        fb.setDCode(habCode.substring(0,2));
									        fb.setDistrict(RwsMasterData.getDistName(ds,habCode.substring(0,2)));
									        
									        fb.setMandal(""+officeDetails.get(2));
									        fb.setMandalName(""+officeDetails.get(3));
									        
									        fb.setHabCode(""+officeDetails.get(8));
								        	fb.setHabName(""+officeDetails.get(9));
								        	String sCode="";
								        	if(request.getParameter("schemeSpecial")!=null && !request.getParameter("schemeSpecial").equals(""))
								        	{
								        		sCode=request.getParameter("schemeSpecial");
								        		if(sCode.equals("01"))sName="PWS";
								        		else if(sCode.equals("02"))sName="MPWS";
								        		else if(sCode.equals("03"))sName="CPWS";
								        		else if(sCode.equals("04"))sName="HANDPUMPS";
								        		else if(sCode.equals("05"))sName="SHALLOW HAND PUMPS";
								        		else if(sCode.equals("09"))sName="DIRECT PUMPING";
								        		else if(sCode.equals("10"))sName="SUSTAINABILITY";
								        		else if(sCode.equals("06"))sName="OPEN WELLS";
								        		else if(sCode.equals("07"))sName="PONDS";
								        	}
								        	else
								        	{
									        	sCode = fb1.getSchemeCode();
									        	sName=fb1.getScheme();
								        	}
								        	fb.setScheme(sName);
									        fb.setSchemeCode(sCode);
									        CommonLists commonLists = new CommonLists(getDataSource(request));
									        String pumpCode = commonLists.getPumpCode(sCode,sName,""+officeDetails.get(8));
									        fb.setPumpCode(pumpCode);
									        fb.setAssetTypeCode(sCode);
									        fb.setAssetTypeName(sName);
									        dao = rws_works_factory.createWorksDAO(ds);
									        fb.setAssetName(dao.getWorkName(fb.getWorkId()));
									        fb.setLocation(""+officeDetails.get(9));
									        fb.setAssetStatus("1");
											dao = rws_works_factory.createWorksDAO(ds);
									        ArrayList details = dao.getWorkExp(fb.getWorkId());
									        fb.setStartYear(""+details.get(0));
											fb.setDateofCreation(""+details.get(1));
											double sa = Double.parseDouble(fb1.getSamount());
											double exp = Double.parseDouble(""+details.get(2));
											if(exp==0)fb.setAssetCost(""+sa);
											else if(sa<exp)fb.setAssetCost(""+sa);
											else fb.setAssetCost(""+exp);
											
											fb.setAssetCode(fb.getWorkId());
	
											dao = rws_works_factory.createWorksDAO(ds);
									        ArrayList benhabs = dao.getWorkBenDetails(fb.getWorkId());
									        fb.setTotHabs(""+benhabs.get(0));
											fb.setTotPopBenfit(""+benhabs.get(1));
											session.setAttribute("tempSelectedHabs",benhabs.get(2));
											fb.setRemarks("");
							        		request.setAttribute("Includepage1","01");
							        		request.setAttribute("buttonDisableStatus","N");
							        		request.setAttribute("IncludeButton","01");
							        		request.setAttribute("leadHab","N");
							        	}
									}
						        	catch(Exception e)
									{
						        		request.setAttribute("message","Unable to convert Scheme to asset - The Lead Habitation may be UI (or) Please Check once Work Details in Work Progress");
										request.setAttribute("buttonDisableStatus","N");
										request.setAttribute("leadHab","N");
										fb.setMandal("");
								        fb.setAssetTypeCode("");
								        fb.setAssetTypeName("");
								        fb.setAssetName("");
								        fb.setLocation("");
								        fb.setStartYear("");
										fb.setDateofCreation("");
										fb.setAssetCost("");
										fb.setTotHabs("");
										fb.setTotPopBenfit("");
										fb.setPumpCode("");
										fb.setAssetCode("");
									}
						        }

				        	}
					        else
					        {
					        	fb.setHeadOfficeCode("1");
						        fb.setHeadOfficeName("CE RWS");
						        
						        dao = rws_works_factory.createWorksDAO(ds);
				        		RwsMaster rwsMaster = dao.getAssetDetails(stat);
				        		
				        		String habCode = rwsMaster.getHabCode();
				        		
						        fb.setCircleOfficeCode(habCode.substring(0,2));
						        fb.setCircleOfficeName(RwsMasterData.getCircleName(ds,habCode.substring(0,2)));
						        
						        fb.setDivisionOfficeCode(rwsMaster.getDivisionOfficeCode());
						        dao = rws_works_factory.createWorksDAO(ds);
						        fb.setDivisionOfficeName(dao.getDivisionOfficeName("1",habCode.substring(0,2),rwsMaster.getDivisionOfficeCode()));
						        
						        fb.setSubdivisionOfficeCode(rwsMaster.getSubdivisionOfficeCode());
						        dao = rws_works_factory.createWorksDAO(ds);
						        fb.setSubdivisionOfficeName(dao.getSubDivisionOfficeName("1",habCode.substring(0,2),rwsMaster.getDivisionOfficeCode(),rwsMaster.getSubdivisionOfficeCode()));
						        
						        fb.setDCode(habCode.substring(0,2));
						        fb.setDistrict(RwsMasterData.getDistName(ds,habCode.substring(0,2)));
						        
						        fb.setMandalCode(habCode.substring(5,7));
						        fb.setMandal(habCode.substring(5,7));
						        dao = rws_works_factory.createWorksDAO(ds);
						        String mandalAndHabName = dao.getHabName(habCode);
						        String[] mandalAndHabNames = mandalAndHabName.split("@"); 
						        
						        fb.setHabCode(habCode);
						        fb.setMandalName(mandalAndHabNames[0]);
					        	fb.setHabName(mandalAndHabNames[1]);
				        		
						        fb.setSchemeCode(rwsMaster.getSchemeCode());
						        fb.setScheme(rwsMaster.getAssetTypeName());
						        
						        fb.setAssetTypeCode(rwsMaster.getAssetTypeCode());
						        fb.setAssetTypeName(rwsMaster.getAssetTypeName());
						        
						        fb.setAssetName(rwsMaster.getAssetName());
						        fb.setLocation(rwsMaster.getLocation());
						        fb.setAssetStatus(rwsMaster.getAssetStatus());
						        fb.setStartYear(rwsMaster.getStartYear());
								fb.setDateofCreation(rwsMaster.getDateofCreation());
								fb.setAssetCost(rwsMaster.getAssetCost());

								fb.setPumpCode(rwsMaster.getPumpCode());
								fb.setAssetCode(rwsMaster.getAssetCode());
								
								dao = rws_works_factory.createWorksDAO(ds);
						        ArrayList benhabs = dao.getAssetBenDetails(fb.getWorkId(),fb.getAssetTypeCode());
						        fb.setTotHabs(""+benhabs.get(0));
								fb.setTotPopBenfit(""+benhabs.get(1));
								session.setAttribute("tempSelectedHabs",benhabs.get(2));
								
				        		request.setAttribute("Includepage1","01");
				        		
				        		dao = rws_works_factory.createWorksDAO(ds);
					        	String info = dao.getCompInfoAndYieldInfo(fb.getAssetCode(),fb.getAssetTypeCode());
					        	request.setAttribute("info",info);
					        	request.setAttribute("assetTypeCodde",fb.getAssetTypeCode());
					        	request.setAttribute("buttonDisableStatus","Y");
				        		request.setAttribute("Includepage2","02");
				        		request.setAttribute("leadHab","N");
				        		if(spmode!=null && spmode.equals("getAugDetailsNextStep"))
				        		{
				        			request.setAttribute("message","The MainScheme Work Already Converted - Please Add Sub Components");
				        			fb.setWrktype("1");
				        			dao = rws_works_factory.createWorksDAO(ds);
							        ArrayList worksList = new ArrayList();
							        worksList = dao.getCommWorkDetails(fb);
							        session.setAttribute("rwsWorks",worksList);
				        		}
					        }
			        	}
			        	else 
			        	{
			        		fb.setScheme("");
					        fb.setSchemeCode("");
			        		request.setAttribute("Includepage3","001");
			        	}
			        	
			        }
			        if(mode.equals("getCompInfoAndYieldInfo"))
			        {
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	String info = dao.getCompInfoAndYieldInfo(fb.getAssetCode(),fb.getAssetTypeCode());
			        	request.setAttribute("info",info);
			        	request.setAttribute("assetTypeCodde",fb.getAssetTypeCode());
			        }
			        if(mode.equals("saveCompAndYield"))
			        {
			        	String[] compValues = new String[26];
			        	String[] yieldHabs = new String[Integer.parseInt(request.getParameter("totalHabCount"))];
			        	String[] yieldValues = new String[Integer.parseInt(request.getParameter("totalHabCount"))];
			        	for(int i=0,j=1;i<26;i++,j++)
			        	{
			        		compValues[i]=request.getParameter(""+j);
			        	}
			        
			        	for(int i=0,j=1;i<Integer.parseInt(request.getParameter("totalHabCount"));i++,j++)
			        	{
			        		yieldHabs[i]=request.getParameter("habcode"+j);
			        		yieldValues[i]=request.getParameter("habYield"+j);
			        	}
			        	
			        	request.setAttribute("Includepage1","01");
		        		request.setAttribute("Includepage2","02");
			        }
			        
			        if(mode.equals("leadHab"))
			        {
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	ArrayList benhabs = dao.getWorkBenDetails(fb.getWorkId());
			        	session.setAttribute("tempSelectedHabs",benhabs .get(2));
			        	return mapping.findForward(mode);
			        }
			        if(mode.equals("addLeadHab"))
			        {
			        	dao = rws_works_factory.createWorksDAO(ds);
			        	int value = 0;
			        	if(request.getParameter("leadHab")!=null && !request.getParameter("leadHab").equals(""))
			        	{
			        		value = dao.addLeadHab(request.getParameter("workId"),request.getParameter("leadHab"));	
			        	}
			        	if(value==1)request.setAttribute("message","Selected Habitation Successfully added as a lead Habitation then Click RETRY Button");
			        	else request.setAttribute("message","Failed to added");
			        	return mapping.findForward("close");
			        }
		        }
		}
		catch(Exception e)
		{
			e.printStackTrace();
			Debug.println("Exception in action class rws_works_WorkStatus_Act1 -- "+e);
		}
		System.gc();
		return mapping.findForward(SUCCESS);
	}
 }