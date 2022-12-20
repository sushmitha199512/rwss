package nic.watersoft.reports;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

import org.apache.struts.action.*;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.commons.Debug;

 public class FlexReportAct1 extends Action {
 	
	
 public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
 {
 	DynaActionForm flexDynaForm = (DynaActionForm)form;
 	HttpSession ses=request.getSession();
 	String mode,district,mandal,panchayat,village,habcode,offices,division,subdivision,program,subprogram,workcategory,schemes,expyear,noh_condition,nohabs,plan,augnew,addate_condition,adminSancDate,asa_condition,asa,tsa_condition,tsa,sid_condition,sidDate,sidhand_condition,sidhandDate,condate_condition,conDate,condur_condition,conDur,wrkexp_condition,wrkExp,wrkcompdt_condition,wrkcompDate,wrkcommdt_condition,wrkcommDate,creport,creport1,tsdate_condition,techSancDate,constituency; 
 	
 	
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    int currentYears = Integer.parseInt(currentYear);
    System.out.println("session id2:"+ses.getId());
 	RwsUser user = (RwsUser)ses.getAttribute("RWS_USER");
 	if(user==null)return mapping.findForward("expire");
 	nic.watersoft.commons.Debug.println("CircleOfficeCOde="+user.getCircleOfficeCode());
 	if(!(user.getCircleOfficeCode().equals("00")))//getting district name from login id 
 		district=user.getCircleOfficeCode();
 	else
 		district=(String)flexDynaForm.get("district");
 	
  	mandal=(String)flexDynaForm.get("mandal");
  	nic.watersoft.commons.Debug.println("Mandal::"+mandal);
 	panchayat =(String)flexDynaForm.get("panchayat");
 	village=(String)flexDynaForm.get("village");
 	habcode=(String)flexDynaForm.get("habCode");
 	offices = (String)flexDynaForm.get("offices");
	nic.watersoft.commons.Debug.println("office code::"+offices);
	constituency = (String)flexDynaForm.get("constituency");
  	nic.watersoft.commons.Debug.println("Constituency::"+constituency);
 	division = (String)flexDynaForm.get("division");
 	subdivision = (String)flexDynaForm.get("subdivision");
 	program = (String)flexDynaForm.get("program");
 	subprogram = (String)flexDynaForm.get("subprogram");
 	workcategory = (String)flexDynaForm.get("workcategory");
 	schemes = (String)flexDynaForm.get("scheme");
 	expyear = (String)flexDynaForm.get("expyear");
 	if(expyear.equals("-1"))expyear = "";
 	noh_condition = (String)flexDynaForm.get("noh_condition");
 	nohabs  = (String)flexDynaForm.get("nohabs");
	plan  = (String)flexDynaForm.get("plan");
	augnew  = (String)flexDynaForm.get("augnew");
	//if(plan.equals("1") && augnew.equals(""))augnew = "1";
	//if(plan.equals("2"))augnew = "3";
	addate_condition  = (String)flexDynaForm.get("addate_condition");
	adminSancDate  = (String)flexDynaForm.get("adminSancDate");
	asa_condition  = (String)flexDynaForm.get("asa_condition");
	asa  = (String)flexDynaForm.get("asa");
	tsdate_condition = (String)flexDynaForm.getString("tsdate_condition");
	techSancDate = (String)flexDynaForm.getString("techSancDate");
	tsa_condition  = (String)flexDynaForm.get("tsa_condition");
	tsa  = (String)flexDynaForm.get("tsa");
	sid_condition  = (String)flexDynaForm.get("sid_condition");
	sidDate  = (String)flexDynaForm.get("sidDate");
	sidhand_condition  = (String)flexDynaForm.get("sidhand_condition");
	sidhandDate  = (String)flexDynaForm.get("sidhandDate");
	condate_condition  = (String)flexDynaForm.get("condate_condition");
	conDate  = (String)flexDynaForm.get("conDate");
	condur_condition  = (String)flexDynaForm.get("condur_condition");
	conDur  = (String)flexDynaForm.get("conDur");
	wrkexp_condition  = (String)flexDynaForm.get("wrkexp_condition");
	wrkExp  = (String)flexDynaForm.get("wrkExp");
	wrkcompdt_condition  = (String)flexDynaForm.get("wrkcompdt_condition");
	wrkcompDate  = (String)flexDynaForm.get("wrkcompDate");
	wrkcommdt_condition  = (String)flexDynaForm.get("wrkcommdt_condition");
	wrkcommDate = (String)flexDynaForm.get("wrkcommDate");
	String commonfields[]=(String[])flexDynaForm.get("commonfields");
	String adminfields[]=(String[])flexDynaForm.get("adminfields");
	String techfields[]=(String[])flexDynaForm.get("techfields");
	String sourcefields[]=(String[])flexDynaForm.get("sourcefields");
	String confields[]=(String[])flexDynaForm.get("confields");
	String wrkexpfields[]=(String[])flexDynaForm.get("wrkexpfields");
	String wrkcompfields[]=(String[])flexDynaForm.get("wrkcompfields");	
	String fields[] = (String[])flexDynaForm.get("commonfields");
	String fields1[] = new String[100];
	int fieldsindex = 0;
	String selectedFields = "";
	if(commonfields.length != 0 )
	{
		for(int i = 0;i<commonfields.length;i++)
		{
			fields1[fieldsindex++] = commonfields[i];
		}
	}	
	if(adminfields.length != 0 )
	{
		selectedFields += "adminfields,";
		for(int i = 0;i<adminfields.length;i++)
		{
			fields1[fieldsindex++] = adminfields[i];
		}
	}	
	if(techfields.length != 0 )
	{
		selectedFields += "techfields,";
		for(int i = 0;i<techfields.length;i++)
		{
			fields1[fieldsindex++] = techfields[i];
		}
	}	
	if(sourcefields.length != 0 )
	{
		selectedFields += "sourcefields,";
		for(int i = 0;i<sourcefields.length;i++)
		{
			fields1[fieldsindex++] = sourcefields[i];
		}
	}	
	if(confields.length != 0 )
	{
		selectedFields += "confields,";
		for(int i = 0;i<confields.length;i++)
		{
			fields1[fieldsindex++] = confields[i];
		}
	}	
	if(wrkexpfields.length != 0 )
	{
		selectedFields += "wrkexpfields,";
		for(int i = 0;i<wrkexpfields.length;i++)
		{
			fields1[fieldsindex++] = wrkexpfields[i];
			if(wrkexpfields[i].equals("TOTAL_EXP"))
			{
			    request.setAttribute("totalexpfield","yes");
			}
			else
			   request.setAttribute("totalexpfield","no");
		}
	}	
	if(wrkcompfields.length != 0 )
	{
		selectedFields += "wrkcompfields,";
		Debug.println("length:"+wrkcompfields.length);
		for(int i = 0;i<wrkcompfields.length;i++)
		{
			fields1[fieldsindex++] = wrkcompfields[i];
			Debug.println("arrrrry:"+wrkcompfields[i]);
		}
	}	
	//System.out.println("Selected Fileds:"+selectedFields);
	String[] selFields = selectedFields.split(",");
	ArrayList selfieldlist = new ArrayList(Arrays.asList(selFields));
	
	String[] fields2 = new String[fieldsindex];
	for(int i = 0;i<fieldsindex;i++)
	{
		fields2[i] = fields1[i];
		
	}
 	creport = (String)flexDynaForm.get("creport");
 	creport1 = (String)flexDynaForm.get("creport1");
 	Debug.println("creport1 is:"+creport1);
 	RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
 	
 	String circleName=rwsOffices.getCircleName(district);
 	request.setAttribute("circlename",circleName);
 	flexDynaForm.set("districtName",circleName); 	
 	mode=request.getParameter("mode");
 	
 	//code to generate district details
 	RwsOffices rwsoffice=new RwsOffices(getDataSource(request));

 	if(!mode.equals("outFlex"))
 	{
 		ArrayList dists = rwsoffice.getDistricts();
 	 	ArrayList cons = rwsoffice.getConstituencies(district);
 	 	ArrayList dmandal=rwsoffice.getDistrictMandals(district);
 	 	ArrayList mpanchyats=rwsoffice.getPanchayats(district,mandal);
 	 	ArrayList pvillages=rwsoffice.getVillages(district,mandal,panchayat);
 	 	ArrayList vhabs=RwsMasterData.getHabitations(district, mandal,panchayat,village, getDataSource(request));
 	 	//updated by swapna added plan
 	 	ArrayList assetTypes = rwsoffice.getAssetTypes(workcategory);
 	 	//
 	 	ArrayList circles = rwsoffice.getCircles();
 	 	ArrayList divisions = rwsoffice.getDivisions1(offices);
 	 	ArrayList subdivisions = rwsoffice.getSubDivisions1(offices,division);
 	 	ArrayList programs = rwsoffice.getPrograms(workcategory,plan,augnew);
 	 	ArrayList subprograms = rwsoffice.getSubprograms(program);
 	 	ArrayList workcats = rwsoffice.getWorkCategory();
 	 	ArrayList expyears = rwsoffice.getExpYears();
 	    
 	 	//sending district details in session
 	 	ses.setAttribute("districts",dists);
 	 	ses.setAttribute("constituency",cons);
 	 	ses.setAttribute("mandals",dmandal);
 	 	ses.setAttribute("panchayats",mpanchyats);
 	 	ses.setAttribute("villages",pvillages);
 	 	ses.setAttribute("habitations",vhabs);
 	 	ses.setAttribute("assets",assetTypes);
 	 	ses.setAttribute("circles",circles);
 	 	ses.setAttribute("divisions",divisions);
 	 	ses.setAttribute("subdivisions",subdivisions);
 	 	ses.setAttribute("programs",programs);
 	 	ses.setAttribute("subprograms",subprograms);
 	 	ses.setAttribute("workcats",workcats);
 	 	ses.setAttribute("expyears",expyears);	
 	}
 	
 	
 	if (!(mode.equals("outFlex")))
 	{
 		//removing the session attributes.
		ses.removeAttribute("rows");
		ses.removeAttribute("column");
		ses.removeAttribute("key");
		ses.removeAttribute("dhead");
		ses.removeAttribute("cohead");
		ses.removeAttribute("dohead");
		ses.removeAttribute("sdohead");
		ses.removeAttribute("disthead");
		ses.removeAttribute("conhead");
		ses.removeAttribute("mandhead");
		ses.removeAttribute("dmhead");
		ses.removeAttribute("phead");
		ses.removeAttribute("sphead");
		ses.removeAttribute("wchead");
		ses.removeAttribute("schemehead");
		ses.removeAttribute("expyear");
		ses.removeAttribute("planhead");
		ses.removeAttribute("augnewhead");
 		ses.removeAttribute("noh_condition");
 		ses.removeAttribute("nohabs");
 		ses.removeAttribute("plan");
 		ses.removeAttribute("augnew");
 		ses.removeAttribute("addate_condition");
 		ses.removeAttribute("adminSancDate");
 		ses.removeAttribute("asa_condition");
 		ses.removeAttribute("asa");
 		ses.removeAttribute("tsa_condition");
 		ses.removeAttribute("tsa");
 		ses.removeAttribute("sid_condition");
 		ses.removeAttribute("sidDate");
 		ses.removeAttribute("sidhand_condition");
 		ses.removeAttribute("sidhandDate");
 		ses.removeAttribute("condate_condition");
 		ses.removeAttribute("conDate");
 		ses.removeAttribute("condur_condition");
 		ses.removeAttribute("conDur");
 		ses.removeAttribute("wrkexp_condition");
 		ses.removeAttribute("wrkExp");
 		ses.removeAttribute("wrkcompdt_condition");
 		ses.removeAttribute("wrkcompDate");
 		ses.removeAttribute("wrkcommdt_condition");
 		ses.removeAttribute("wrkcommDate");
 		ses.removeAttribute("creport");
 		ses.removeAttribute("creport1");
 		ses.removeAttribute("selection1");ses.removeAttribute("selection2");ses.removeAttribute("selection3");
 		ses.removeAttribute("selection4");ses.removeAttribute("selection5");ses.removeAttribute("selection6");
 		ses.removeAttribute("selection7");ses.removeAttribute("selection8");ses.removeAttribute("selection9");
 		ses.removeAttribute("selection10");ses.removeAttribute("selection11");
 		nic.watersoft.commons.Debug.println("if loop for other than outflex mode");
 	}

 	if (mode.equals("outFlex"))
 	{  
 		String qry3 = "",qry31 = "";
 		nic.watersoft.commons.Debug.println("if loop for OutFlexMode..............i am in outflex mode");
 		ArrayList columns=new ArrayList();
 		ArrayList form_fields=new ArrayList();
 		RwsMaster rwsm=new RwsMaster();
 		rwsm.setMode(mode);
 		rwsm.setDistrict(district);
 		rwsm.setConstituency(constituency);
 		rwsm.setMandal(mandal);
 		rwsm.setPanchayat(mode);
 		rwsm.setVillage(village);
 		rwsm.setHabcode(habcode);
 		rwsm.setOffices(offices);
 		rwsm.setDivision(division);
 		rwsm.setSubdivision(subdivision);
 		rwsm.setProgram(program);
 		rwsm.setSubprogram(subprogram);
 		rwsm.setWorkcategory(workcategory);
 		rwsm.setScheme(schemes);
 		rwsm.setExpyear(expyear);
 		rwsm.setNoh_condition(noh_condition);
 		rwsm.setNohabs(nohabs);
 		rwsm.setPlan(plan);
 		rwsm.setAugnew(augnew);
 		rwsm.setAddate_condition(addate_condition);
 		rwsm.setAdminSancDate(adminSancDate);
 		rwsm.setAsa_condition(asa_condition);
 		rwsm.setAsa(asa);
 		rwsm.setTsdate_condition(tsdate_condition);
 		rwsm.setTechSancDate(techSancDate);
 		rwsm.setTsa_condition(tsa_condition);
 		rwsm.setTsa(tsa);
 		rwsm.setSid_condition(sid_condition);
 		rwsm.setSidDate(sidDate);
 		rwsm.setSidhand_condition(sidhand_condition);
 		rwsm.setSidhandDate(sidhandDate);
 		rwsm.setCondate_condition(condate_condition);
 		rwsm.setConDate(conDate);
 		rwsm.setCondur_condition(condur_condition);
 		rwsm.setConDur(conDur);
 		rwsm.setWrkexp_condition(wrkexp_condition);
 		rwsm.setWrkExp(wrkExp);
 		rwsm.setWrkcompdt_condition(wrkcompdt_condition);
 		rwsm.setWrkcompDate(wrkcompDate);
 		rwsm.setWrkcommdt_condition(wrkcommdt_condition);
 		rwsm.setWrkcommDate(wrkcommDate);
 		nic.watersoft.commons.Debug.println("District before if::"+offices);
 		nic.watersoft.commons.Debug.println("District before  rwsm if::"+rwsm.getOffices());
 		String selection1 = "",selection2 = "",selection3 = "",selection4 = "",selection5 = "",selection6 = "",selection7 = "",selection8 = "",selection9 = "",selection10 = "",selection11 = "";
 		if(!rwsm.getAdminSancDate().equals(""))
 		{
 			selection1 +=" Admin Date:"+rwsm.getAdminSancDate()+"";
 		}
 		if(!rwsm.getAsa().equals(""))
 		{
 			selection2 += " Admn. Sanc. Amount:"+rwsm.getAsa()+" Lakh.";
 		}
 		if(!rwsm.getTechSancDate().equals(""))
 		{
 			selection3 += " Tech. Sanc. Date:"+rwsm.getTechSancDate()+"";
 		}
 		if(!rwsm.getTsa().equals(""))
 		{
 			selection4 += " Tech. Sanc. Amount:"+rwsm.getTsa()+" Lakh.";
 		}
 		if(!rwsm.getSidDate().equals(""))
 		{
 			selection5 += " Site Iden. Date:"+rwsm.getSidDate()+"";
 		}
 		if(!rwsm.getSidhandDate().equals(""))
 		{
 			selection6 += " Site Handover Date:"+rwsm.getSidhandDate()+"";
 		}
 		if(!rwsm.getConDate().equals(""))
 		{
 			selection7 += " Agmt. Date:"+rwsm.getConDate()+"";
 		}
 		if(!rwsm.getConDur().equals(""))
 		{
 			selection8 += " Agmt. Duration:"+rwsm.getConDur()+" Month(s )";
 		}
 		if(!rwsm.getWrkExp().equals(""))
 		{
 			selection9 += " Work Expenditure:"+rwsm.getWrkExp()+" Lakh.";
 		}
 		if(!rwsm.getWrkcompDate().equals(""))
 		{
 			selection10 += " Completion Date:"+rwsm.getWrkcompDate()+"";
 		}
 		if(!rwsm.getWrkcommDate().equals(""))
 		{
 			selection11 += " Commission Date:"+rwsm.getWrkcommDate()+"";
 		}
 		ses.setAttribute("selection1",selection1);ses.setAttribute("selection2",selection2);
 		ses.setAttribute("selection3",selection3);ses.setAttribute("selection4",selection4);
 		ses.setAttribute("selection5",selection5);ses.setAttribute("selection6",selection6);
 		ses.setAttribute("selection7",selection7);ses.setAttribute("selection8",selection8);
 		ses.setAttribute("selection9",selection9);ses.setAttribute("selection10",selection10);
 		ses.setAttribute("selection11",selection11);
 		
 		if(!offices.equals(""))
 		{
	 		nic.watersoft.commons.Debug.println("First If Loop");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		String [] mon = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
	 	 	qry3 += "select w.* from  ";
	 	 	String select = "";
	 		if(!offices.equals("") && division.equals("") && subdivision.equals(""))
			{
				if(offices.equals("all"))
				{
					qry3+="rws_work_admn_tbl w where w.work_id = w.work_id and  AND WORK_CANCEL_DT  IS  NULL";
				}
				else
				{
					qry3+="rws_work_admn_tbl w where substr(w.office_code,2,2)='"+rwsm.getOffices()+"' AND WORK_CANCEL_DT  IS  NULL";
				}
				if(creport1.equals("admin"))qry3 += " and work_id not in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("technical"))qry3 += " and work_id in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("contractor"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL)";
				if(creport1.equals("workcomp"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL) and work_id in (select work_id from rws_work_completion_tbl)";
				ses.setAttribute("cohead",frd.cheaderNames(offices));
			}
			else if(!offices.equals("") && !division.equals("") && subdivision.equals(""))
			{
				qry3+="rws_work_admn_tbl w where substr(w.office_code,2,2)='"+rwsm.getOffices()+"' and substr(w.office_code,4,1)='"+rwsm.getDivision()+"' AND WORK_CANCEL_DT  IS  NULL";
				if(creport1.equals("admin"))qry3 += " and work_id not in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("technical"))qry3 += " and work_id in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("contractor"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL)";
				if(creport1.equals("workcomp"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL) and work_id in (select work_id from rws_work_completion_tbl)";
				ses.setAttribute("cohead",frd.cheaderNames(offices));
		    	ses.setAttribute("dohead",frd.dheaderNames(offices,division));
			}
			else if(!offices.equals("") && !division.equals("") && !subdivision.equals(""))
			{
				qry3+="rws_work_admn_tbl w where substr(w.office_code,2,2)='"+rwsm.getOffices()+"' and substr(w.office_code,4,1)='"+rwsm.getDivision()+"' and substr(w.office_code,5,2)='"+rwsm.getSubdivision()+"' AND WORK_CANCEL_DT  IS  NULL";
				if(creport1.equals("admin"))qry3 += " and work_id not in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("technical"))qry3 += " and work_id in (select work_id from rws_new_est_tbl)";
				if(creport1.equals("contractor"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL)";
				if(creport1.equals("workcomp"))qry3 += " and work_id in (select work_id from rws_new_est_tbl) and work_id in (select work_id from RWS_WORK_COMMENCEMENT_TBL) and work_id in (select work_id from rws_work_completion_tbl)";
				ses.setAttribute("cohead",frd.cheaderNames(offices));
		    	ses.setAttribute("dohead",frd.dheaderNames(offices,division));			
				ses.setAttribute("sdohead",frd.sdheaderNames(offices,division,subdivision));
			}
			if(!program.equals("")){
				qry3+= " and substr(w.work_id,1,2) = '"+rwsm.getProgram()+"'";
				ses.setAttribute("phead",frd.progheaderNames(program));
				}
			if(!subprogram.equals("")){
				qry3+= " and substr(w.work_id,3,2) = '"+rwsm.getSubprogram()+"'";
				ses.setAttribute("sphead",frd.subprogheaderNames(program,subprogram));
				}
			if(!workcategory.equals("")){
				nic.watersoft.commons.Debug.println("Work Category Code::"+rwsm.getWorkcategory());
				qry3+= " and w.category_code = '"+rwsm.getWorkcategory()+"'";
				ses.setAttribute("wchead",frd.wcheaderNames(workcategory));
				}
			if(!schemes.equals("")){
				qry3+= " and substr(w.work_id,7,2) = '"+rwsm.getScheme()+"'";
				ses.setAttribute("schemehead",frd.schemeheaderNames(schemes));
				}
			if(!rwsm.getExpyear().equals(""))
			{
				int admin_date = Integer.parseInt(rwsm.getExpyear());
				int admin_date1 = 0;admin_date1 = admin_date + 1;
				//qry3+= " and w.admin_date >= '01-apr-"+admin_date+"' and w.admin_date <= '31-mar-"+admin_date1+"'";
				qry3+= " and (w.admin_date < '01-apr-"+admin_date+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-apr-"+admin_date+"') or w.admin_date >= '01-apr-"+admin_date+"')";
				int year = Integer.parseInt(rwsm.getExpyear());
				int year1 = year + 1;
				String expyear1 = ""+year+" - "+year1;
				//System.out.println("Exp year Period:"+expyear1);
				ses.setAttribute("expyear",expyear1);
			}
			if(!rwsm.getPlan().equals(""))
			{
				qry3 += " and w.PLAN_CODE= '"+rwsm.getPlan()+"'";
				ses.setAttribute("planhead",frd.planheaderNames(plan));
			}
			if(!rwsm.getAugnew().equals(""))
			{
				qry3 += " and w.AUG_NEW_CODE = '"+rwsm.getAugnew()+"'";
				ses.setAttribute("augnewhead",frd.augnewheaderNames(augnew));
			}
			if(!rwsm.getNohabs().equals("")){
				qry3+= " and w.no_of_habs "+rwsm.getNoh_condition()+" '"+rwsm.getNohabs()+"'";
				}
			if(!adminSancDate.equals("") || !rwsm.getAsa().equals("")){
				if(!rwsm.getAdminSancDate().equals("")){
			String month = adminSancDate.substring(3,5);
			String addate = adminSancDate.substring(0,2)+"-"+mon[Integer.parseInt(adminSancDate.substring(3,5))-1]+"-"+adminSancDate.substring(6,10);
			
				qry3+= " and w.admin_date "+rwsm.getAddate_condition()+" '"+addate+"'";
			}
			if(!rwsm.getAsa().equals(""))
			{
				qry3+= " and w.sanction_amount "+rwsm.getAsa_condition()+" '"+rwsm.getAsa()+"'";
			}
			}
			ArrayList rows ;
			ArrayList columns1 = new ArrayList();
			nic.watersoft.commons.Debug.println("Qry 3 ::"+qry3+"fields length:"+fields2.length);
			rows = frd.getData(qry3,rwsm,select,fields2,creport,creport1,columns1,selectedFields,ses.getId());
			nic.watersoft.commons.Debug.println("Rows Size:"+rows.size());
			if(rows.size() == 0 || rows == null)
			{
				mode = "inFlexi";
				request.setAttribute("message","No Record Matches with this Selection Criteria");
			}
			else
			{
				mode = "outFlex";
				ses.setAttribute("column",columns1);
				ses.setAttribute("rows",rows);
			    ses.setAttribute("key","dreport");
		    }
			
	 	}
 		else if(!district.equals(""))
 		{
	 		nic.watersoft.commons.Debug.println("Second If Loop");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		String [] mon = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
	 		String qqq = "select w.work_id from ";
	 	 	qry31 += "select w.* from  ";
	 	 	String select = "";
	 		if(!district.equals("") && constituency.equals("") && mandal.equals(""))
			{
	 			if(district.equals("all"))
				{
	 				qqq +="rws_work_admn_tbl w,rws_admn_hab_lnk_tbl h where h.work_id = w.work_id AND WORK_CANCEL_DT  IS  NULL";
	 				
				}
	 			else
	 			{
	 				qqq +="rws_work_admn_tbl w,rws_admn_hab_lnk_tbl h where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and w.work_id = h.work_id AND WORK_CANCEL_DT  IS  NULL";
	 			}
				ses.setAttribute("disthead",frd.distheaderNames(district));
			}
			else if(!district.equals("") && !constituency.equals("") && mandal.equals(""))
			{
				qqq +="rws_work_admn_tbl w,rws_admn_hab_lnk_tbl h where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(h.hab_code,3,3)='"+rwsm.getConstituency()+"' and w.work_id = h.work_id AND WORK_CANCEL_DT  IS  NULL";
				//qry31+="rws_work_admn_tbl w where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(w.hab_code,3,3)='"+rwsm.getConstituency()+"' and w.work_id = h.work_id";
				ses.setAttribute("disthead",frd.distheaderNames(district));
		    	ses.setAttribute("conhead",frd.conheaderNames(district,constituency));
			}
			else if(!district.equals("") && !constituency.equals("") && !mandal.equals(""))
			{
				qqq +="rws_work_admn_tbl w,rws_admn_hab_lnk_tbl h where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(h.hab_code,3,3)='"+rwsm.getConstituency()+"' and substr(h.hab_code,6,2)='"+rwsm.getMandal()+"' and w.work_id = h.work_id AND WORK_CANCEL_DT  IS  NULL";
				//qry31+="rws_work_admn_tbl w where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(w.hab_code,3,3)='"+rwsm.getConstituency()+"' and substr(w.hab_code,6,2)='"+rwsm.getMandal()+"' and w.work_id = h.work_id";
				ses.setAttribute("disthead",frd.cheaderNames(district));
		    	ses.setAttribute("conhead",frd.conheaderNames(district,constituency));			
				ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
			}
			else if(!district.equals("") && constituency.equals("") && !mandal.equals(""))
			{
				qqq +="rws_work_admn_tbl w,rws_admn_hab_lnk_tbl h where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"'  and substr(h.hab_code,6,2)='"+rwsm.getMandal()+"' and w.work_id = h.work_id AND WORK_CANCEL_DT  IS  NULL";
				//qry31+="rws_work_admn_tbl w where substr(h.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(w.hab_code,3,3)='"+rwsm.getConstituency()+"' and substr(w.hab_code,6,2)='"+rwsm.getMandal()+"' and w.work_id = h.work_id";
				ses.setAttribute("disthead",frd.cheaderNames(district));
		    	ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
			}
			nic.watersoft.commons.Debug.println("qqq333333333333333:"+qqq);
			frd.createViewWorks1(qqq);
			qqq = "select distinct w.* from work_selection_view1 a,rws_work_admn_tbl w where w.work_id = a.work_id AND WORK_CANCEL_DT  IS  NULL ";
			frd.createViewWorks2(qqq);
			qry31 += " work_selection_view2  w where w.work_id = w.work_id AND WORK_CANCEL_DT  IS  NULL ";
			if(!program.equals("")){
				qry31+= " and substr(w.work_id,1,2) = '"+rwsm.getProgram()+"'";
				ses.setAttribute("phead",frd.progheaderNames(program));
				}
			if(!subprogram.equals("")){
				qry31+= " and substr(w.work_id,3,2) = '"+rwsm.getSubprogram()+"'";
				ses.setAttribute("sphead",frd.subprogheaderNames(program,subprogram));
				}
			if(!workcategory.equals("")){
				nic.watersoft.commons.Debug.println("Work Category Code::"+rwsm.getWorkcategory());
				qry31+= " and w.category_code = '"+rwsm.getWorkcategory()+"'";
				ses.setAttribute("wchead",frd.wcheaderNames(workcategory));
				}
			if(!schemes.equals("")){
				qry31+= " and substr(w.work_id,7,2) = '"+rwsm.getScheme()+"'";
				ses.setAttribute("schemehead",frd.schemeheaderNames(schemes));
				}
			if(!rwsm.getExpyear().equals(""))
			{
				/*int admin_date = Integer.parseInt(rwsm.getExpyear());
				int admin_date1 = 0;admin_date1 = admin_date + 1;
				qry31+= " and w.admin_date >= '01-apr-"+admin_date+"' and w.admin_date <= '31-mar-"+admin_date1+"'";
				ses.setAttribute("expyear",rwsm.getExpyear());*/
				int admin_date = Integer.parseInt(rwsm.getExpyear());
				int admin_date1 = 0;admin_date1 = admin_date + 1;
				//qry3+= " and w.admin_date >= '01-apr-"+admin_date+"' and w.admin_date <= '31-mar-"+admin_date1+"'";
				qry31+= " and (w.admin_date < '01-apr-"+admin_date+"' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-apr-"+admin_date+"') or w.admin_date >= '01-apr-"+admin_date+"')";
				int year = Integer.parseInt(rwsm.getExpyear());
				int year1 = year + 1;
				String expyear1 = ""+year+" - "+year1;
				//System.out.println("Exp year Period:"+expyear1);
				ses.setAttribute("expyear",expyear1);
			}
			if(!rwsm.getPlan().equals(""))
			{
				qry31 += " and w.PLAN_CODE= '"+rwsm.getPlan()+"'";
				ses.setAttribute("planhead",frd.planheaderNames(plan));
			}
			if(!rwsm.getAugnew().equals(""))
			{
				qry31 += " and w.AUG_NEW_CODE = '"+rwsm.getAugnew()+"'";
				ses.setAttribute("augnewhead",frd.augnewheaderNames(augnew));
			}
			if(!rwsm.getNohabs().equals("")){
				qry31+= " and w.no_of_habs "+rwsm.getNoh_condition()+" '"+rwsm.getNohabs()+"'";
				qry31+= " and w.no_of_habs "+rwsm.getNoh_condition()+" '"+rwsm.getNohabs()+"'";
				}
			if(!adminSancDate.equals("") || !rwsm.getAsa().equals("")){
				if(!rwsm.getAdminSancDate().equals("")){String month = adminSancDate.substring(3,5);
			String addate = adminSancDate.substring(0,2)+"-"+mon[Integer.parseInt(adminSancDate.substring(3,5))-1]+"-"+adminSancDate.substring(6,10);
			qry31+= " and w.admin_date "+rwsm.getAddate_condition()+" '"+addate+"'";
			}
			if(!rwsm.getAsa().equals(""))
			{
				qry31+= " and w.sanction_amount "+rwsm.getAsa_condition()+" '"+rwsm.getAsa()+"'";
			}
			}
			ArrayList rows ;
			ArrayList columns1 = new ArrayList();
			nic.watersoft.commons.Debug.println("Qry3:"+qry3);
			nic.watersoft.commons.Debug.println("Qry31:"+qry31);
			nic.watersoft.commons.Debug.println("Qry 3 ::"+qry31+"fields length:"+fields2.length);
			rows = frd.getData(qry31,rwsm,select,fields2,creport,creport1,columns1,selectedFields,ses.getId());
			nic.watersoft.commons.Debug.println("Rows Size:"+rows.size());
			frd.dropViewWork1();
			frd.dropViewWork2();
			if(rows.size() == 0 || rows == null)
			{
				mode = "inFlexi";
				request.setAttribute("message","No Record Matches with this Selection Criteria");
			}
			else
			{
				mode = "outFlex";
				ses.setAttribute("rows",rows);
				ses.setAttribute("column",columns1);
			    ses.setAttribute("key","dreport");
		    }
			
	 	
 		}
 			
 	}
 	if(mode.equals("outFlex") && offices.equals("all")){mode="excel";}
 	return mapping.findForward(mode);
 }
 }
 