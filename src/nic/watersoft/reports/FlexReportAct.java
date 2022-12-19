package nic.watersoft.reports;
import java.util.ArrayList;
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

 public class FlexReportAct extends Action {
 		
 public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
 {
 	DynaActionForm flexDynaForm = (DynaActionForm)form;
 	HttpSession ses=request.getSession();
 	String mode,district,mandal1,panch1,village1,hab1,cp,csc,cst,ctot,habtype,habsubtype,category,tot_wat_supl,ext_wat_lvl,near_surf_source,near_ground_source,prop_year1,amnt_reqd1,flopop1,floreason,creport1,checkall,cp_condition,csc_condition,cst_condition,ctot_condition,flopop_condition,tot_wat_supl_condition,ext_wat_lvl_condition,near_surf_source_condition,near_ground_source_condition,amnt_reqd_condition; 
 	String compl_stat[]=(String[])flexDynaForm.get("compl_stat");
 	int checkflag=0,slipagecnt=0,prevcnt=0,presentcnt=0;
 	cp=(String)flexDynaForm.get("cp");
 	csc=(String)flexDynaForm.get("csc");
 	cst=(String)flexDynaForm.get("cst");
 	ctot=(String)flexDynaForm.get("ctot");
// 	added by swapna
 	habtype=(String)flexDynaForm.get("habType");
 	Debug.println("habtype*............."+habtype);
 	habsubtype=(String)flexDynaForm.getString("habSubType");
 	category=(String)flexDynaForm.getString("habCat");
	//
 	tot_wat_supl=(String)flexDynaForm.get("tot_wat_supl");
 	ext_wat_lvl=(String)flexDynaForm.get("ext_wat_lvl");
 	near_surf_source=(String)flexDynaForm.get("near_surf_source");
 	near_ground_source=(String)flexDynaForm.get("near_ground_source");
 	RwsUser user = (RwsUser)ses.getAttribute("RWS_USER");
 	if(user==null || ses==null)
 	{
 		return mapping.findForward("expire");
 	}
 	//System.out.println("CircleOfficeCOde="+user.getCircleOfficeCode());
 //	Debug.println("USER"+user);
 //Debug.println("DISTRICT"+user.getCircleOfficeCode()+"_"+user.getCircleOfficeName());
 	if(!(user.getCircleOfficeCode().equals("00")))//getting district name from login id 
 		district=user.getCircleOfficeCode();
 	else
 	district=(String)flexDynaForm.get("district");
  	mandal1=(String)flexDynaForm.get("mandal");
 	panch1 =(String)flexDynaForm.get("panchayat");
 	village1=(String)flexDynaForm.get("village");
 	hab1=(String)flexDynaForm.get("habCode");
// 	added by swapna
 	habtype=(String)flexDynaForm.get("habType");
 	Debug.println("habtype**"+habtype);
 	habsubtype=(String)flexDynaForm.getString("habSubType");
 	category=(String)flexDynaForm.getString("habCat");
	//
 	String prev_stat1[]=(String[])flexDynaForm.get("prev_stat");
 	prop_year1=(String)flexDynaForm.get("prop_year");
 	amnt_reqd1=(String)flexDynaForm.get("amnt_reqd");
 	flopop1=(String)flexDynaForm.get("flopop");
 	floreason=(String)flexDynaForm.get("freason");
 	creport1=(String)flexDynaForm.get("creport");
 	String fields[]=(String[])flexDynaForm.get("fields");
 	String popdet[]=(String[])flexDynaForm.get("popdet");
 	checkall=(String)flexDynaForm.get("checkall");
 	cp_condition=(String)flexDynaForm.get("cp_condition");
 	csc_condition=(String)flexDynaForm.get("csc_condition");
 	cst_condition=(String)flexDynaForm.get("cst_condition");
 	ctot_condition=(String)flexDynaForm.get("ctot_condition");
 	flopop_condition=(String)flexDynaForm.get("flopop_condition");
 	tot_wat_supl_condition=(String)flexDynaForm.get("tot_wat_supl_condition");
 	ext_wat_lvl_condition=(String)flexDynaForm.get("ext_wat_lvl_condition");
 	near_surf_source_condition=(String)flexDynaForm.get("near_surf_source_condition");
 	near_ground_source_condition=(String)flexDynaForm.get("near_ground_source_condition");
 	amnt_reqd_condition=(String)flexDynaForm.get("amnt_reqd_condition");
 	RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
 	String districtName=rwsOffices.getDistrictName(user.getCircleOfficeCode());
 	if(!(user.getUserId().equals("admin") || user.getUserId().equals("100000") || user.getUserId().equals("guest")))
 	{
 		flexDynaForm.set("district",user.getCircleOfficeCode());
 	 	flexDynaForm.set("districtName",districtName); 	
 	}
 	mode=request.getParameter("mode");
 	
 	//code to generate district details
 	RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
 	ArrayList dists = rwsoffice.getDistricts();
 	//System.out.println("district="+district);
 	ArrayList dmandal=rwsoffice.getDistrictMandals(district);
 	ArrayList mpanchyats=rwsoffice.getPanchayats(district,mandal1);
 	ArrayList pvillages=rwsoffice.getVillages(district,mandal1,panch1);
 	ArrayList vhabs=RwsMasterData.getHabitations(district, mandal1,panch1,village1, getDataSource(request));
 	
 	//sending district details in session
 	ses.setAttribute("districts",dists);
 	ses.setAttribute("mandals",dmandal);
 	ses.setAttribute("panchayats",mpanchyats);
 	ses.setAttribute("villages",pvillages);
 	ses.setAttribute("habitations",vhabs);
 		
 	
 	if (!(mode.equals("outFlex")))
 	{
 		//removing the session attributes.
 	//System.out.println("if loop for other than outflex mode");
 	ses.removeAttribute("cp");
	ses.removeAttribute("csc");
	ses.removeAttribute("cst");
	ses.removeAttribute("ctot");
	ses.removeAttribute("flopop");
	ses.removeAttribute("floreason");
	ses.removeAttribute("cstat");
	ses.removeAttribute("pstat");
	ses.removeAttribute("totwat");
	ses.removeAttribute("extwat");
	ses.removeAttribute("nearsurface");
	ses.removeAttribute("nearground");
	ses.removeAttribute("amntreqd");
	ses.removeAttribute("propyr");
	ses.removeAttribute("key");
	ses.removeAttribute("dlist1");
 	ses.removeAttribute("column");
 	ses.removeAttribute("dhead");
 	ses.removeAttribute("dmhead");
 	ses.removeAttribute("dmphead");
 	ses.removeAttribute("dmpvhead");
 	ses.removeAttribute("tot_wat_supl_condition");
 	
 	}
 	
 	//	By default for Consolidated Report
 	if (mode.equals("outFlex"))
 	{  
 	  //System.out.println("if loop for OutFlexMode");
 	  //printAll(flexDynaForm);
 	  ArrayList columns=new ArrayList();
 	  ArrayList form_fields=new ArrayList();
 	  RwsMaster rwsm=new RwsMaster();
 	  rwsm.setCompl_stat(compl_stat);
 	  rwsm.setPrev_stat1(prev_stat1);
 	  rwsm.setFloreason(floreason);
 	  rwsm.setCp(cp);
 	  rwsm.setCst(cst);
 	  rwsm.setCsc(csc);
 	  rwsm.setCtot(ctot);
 	  rwsm.setFlopop1(flopop1);
 	  rwsm.setTot_wat_supl(tot_wat_supl);
 	  rwsm.setExt_wat_lvl(ext_wat_lvl);
 	  rwsm.setNear_surf_source(near_surf_source);
 	  rwsm.setNear_ground_source(near_ground_source);
 	  rwsm.setProp_year1(prop_year1);
 	  rwsm.setAmnt_reqd1(amnt_reqd1);
 	  rwsm.setDistCode(district);
 	  rwsm.setMandalCode(mandal1);
 	  rwsm.setPanchCode(panch1);
 	  rwsm.setVillCode(village1);
 	  rwsm.setHabcode(hab1);
 	  //added by swapna
  	 rwsm.setHabType(habtype);
 	  rwsm.setHabSubType(habsubtype);
 	  rwsm.setHabCat(category);
 	  //
 	  rwsm.setCp_condition(cp_condition);
 	  rwsm.setCsc_condition(csc_condition);
 	  rwsm.setCst_condition(cst_condition);
 	  rwsm.setCtot_condition(ctot_condition);
 	  rwsm.setFlopop_condition(flopop_condition);
 	  rwsm.setTot_wat_supl_condition(tot_wat_supl_condition);
 	  rwsm.setExt_wat_lvl_condition(ext_wat_lvl_condition);
 	  rwsm.setNear_ground_source_condition(near_ground_source_condition);
 	  rwsm.setNear_surf_source_condition(near_surf_source_condition);
 	  rwsm.setAmnt_reqd_condition(amnt_reqd_condition);
 	  
 	  Debug.println("creport1"+creport1);
 	 if((creport1.equals("chlist") && !(mandal1.equals("")) && !(panch1.equals("")) && !(village1.equals(""))) &&  ( !(cp.equals("")) || !(csc.equals("")) || !(cst.equals("")) || !(ctot.equals("")) || (compl_stat.length!=0) || (prev_stat1.length!=0) || !(floreason.equals("null")) || !(flopop1.equals("")) || !(tot_wat_supl.equals("")) || !(ext_wat_lvl.equals("")) ||!(near_surf_source.equals("")) || !(near_ground_source.equals("")) || !(prop_year1.equals("")) || !(amnt_reqd1.equals("")) || !(flopop1.equals("")) || !(habsubtype.equals("")) || !(habtype.equals("")) || !(category.equals(""))))
	    {
 	 	Debug.println("First If Loop");
	 	columns.add("SL. NO.");
	 	columns.add("District Code");
	 	columns.add("District Name");
	 	columns.add("Constituency Code");
 	 	columns.add("Constituency Name");
	  	columns.add("Mandal Code");
	 	columns.add("Mandal Name");
	 	columns.add("Panchayat Code");
	 	columns.add("Panchayat Name");
	 	columns.add("Village Code");
	 	columns.add("Village Name");
	 	columns.add("No. Of Habitations");
	 	/*columns.add("LATITUDE");
	 	columns.add("LONGITUDE");
	 	columns.add("ELEVATION");
	 	columns.add("WAY_POINT");
	 	columns.add("LANDMARK");*/
	 	
	 	if(popdet.length != 0)
		{
				for (int i=0;i<popdet.length;i++)
				{
					columns.add(popdet[i]);
				}
			}
	 	FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 	ArrayList dlist1=frd.consolData1(columns,rwsm,district);
		    String pstat="";
 		    String cstat="";
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			}
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot);
 			}
// 			added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
 		ses.setAttribute("dlist1",dlist1);
	 	ses.setAttribute("column",columns);
	 	ses.setAttribute("key","chlist4");
	  	}
 	 else if ((creport1.equals("chlist") && !(mandal1.equals("")) && !(panch1.equals(""))) &&  ( !(cp.equals("")) || !(csc.equals("")) || !(cst.equals("")) || !(ctot.equals("")) || (compl_stat.length!=0) || (prev_stat1.length!=0) || !(floreason.equals("null")) || !(flopop1.equals("")) || !(tot_wat_supl.equals("")) || !(ext_wat_lvl.equals("")) ||!(near_surf_source.equals("")) || !(near_ground_source.equals("")) || !(prop_year1.equals("")) || !(amnt_reqd1.equals("")) || !(flopop1.equals("")) || !(habsubtype.equals("")) || !(habtype.equals("")) || !(category.equals("")) ))
	    {
 	 	Debug.println("Second If Loop");
	 	columns.add("SL. NO.");
	 	columns.add("District Code");
	 	columns.add("District Name");
	 	columns.add("Constituency Code");
 	 	columns.add("Constituency Name");
	 	columns.add("Mandal Code");
	 	columns.add("Mandal Name");
	 	columns.add("Panchayat Code");
	 	columns.add("Panchayat Name");
	 	columns.add("No. Of Habitations");
	 	if(popdet.length != 0)
		{
			for (int i=0;i<popdet.length;i++)
			{
				columns.add(popdet[i]);
			}
		}
	 	FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 	ArrayList dlist1=frd.consolData1(columns,rwsm,district);
		    String pstat="";
 		    String cstat="";
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			}
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot_condition);
 			}
// 			added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl_condition",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source_condition);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
	 	ses.setAttribute("dlist1",dlist1);
	 	ses.setAttribute("column",columns);
	 	ses.setAttribute("key","chlist3");
	  	}
 	  
 	 else if (creport1.equals("chlist") && !(mandal1.equals("")) &&( !(cp.equals("")) || !(csc.equals("")) || !(cst.equals("")) || !(ctot.equals("")) || (compl_stat.length!=0) || (prev_stat1.length!=0) || !(floreason.equals("null")) || !(flopop1.equals("")) || !(tot_wat_supl.equals("")) || !(ext_wat_lvl.equals("")) ||!(near_surf_source.equals("")) || !(near_ground_source.equals("")) || !(prop_year1.equals("")) || !(amnt_reqd1.equals("")) || !(flopop1.equals("")) || !(habsubtype.equals("")) || !(habtype.equals("")) || !(category.equals("")) ))
 	    {
 	  	Debug.println("3 If Loop");
 	  	////System.out.println("Panchayat:"+panch1+":");
 	  	////System.out.println("village:"+village1+":");
 	 	columns.add("SL. NO.");
 	 	columns.add("District Code");
 	 	columns.add("District Name");
 	 	columns.add("Constituency Code");
 	 	columns.add("Constituency Name");
 	 	columns.add("Mandal Code");
 	 	columns.add("Mandal Name");
 	 	columns.add("No. Of Habitations");
 	 	if(popdet.length != 0)
		{
			for (int i=0;i<popdet.length;i++)
			{
				columns.add(popdet[i]);
			}
		}
 	 	FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 	 	ArrayList dlist1=frd.consolData1(columns,rwsm,district);
		    String pstat="";
 		    String cstat="";
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]); 
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			}
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot_condition);
 			}
 			//added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl_condition",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source_condition);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
 	 	ses.setAttribute("dlist1",dlist1);
 	 	ses.setAttribute("column",columns);
 	 	ses.setAttribute("key","chlist2");
 	 	}
 	 
 	else if (creport1.equals("chlist") && ( !(cp.equals("")) || !(csc.equals("")) || !(cst.equals("")) || !(ctot.equals("")) || !(floreason.equals("")) || !(flopop1.equals("")) || (compl_stat.length!=0) || (prev_stat1.length!=0) || !(tot_wat_supl.equals("")) || !(ext_wat_lvl.equals("")) ||!(near_surf_source.equals("")) || !(near_ground_source.equals("")) || !(prop_year1.equals("")) || !(amnt_reqd1.equals("")) || !(flopop1.equals("")) || !(habsubtype.equals("")) || !(habtype.equals("")) || !(category.equals("")) ))
 	   {
 	 	//System.out.println("4 If Loop");
 	  	columns.add("SL. NO.");
 	 	columns.add("District Code");
 	 	columns.add("District Name");
 	 	columns.add("No. Of Habitations");
 	 	if(popdet.length != 0)
		{
			for (int i=0;i<popdet.length;i++)
			{
				columns.add(popdet[i]);
			}
		}
 	 	FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 	 	ArrayList dlist1=frd.consolData(columns,rwsm,district);
		    String pstat="";
 		    String cstat="";
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			}
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot_condition);
 			}
// 			added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl_condition",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source_condition);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
 	 	ses.setAttribute("dlist1",dlist1);	
  	    ses.setAttribute("column",columns);
  	    ses.setAttribute("key","chlist1");
 	   }
 	 else if (creport1.equals("chlist"))
 		{
 	 	//System.out.println("5 If Loop");
 	 	columns.add("SL. NO.");
 		columns.add("District Code");
 		columns.add("District Name");
 		columns.add("No.Of Habitations");
 		if(popdet.length != 0)
		{
			for (int i=0;i<popdet.length;i++)
			{
				columns.add(popdet[i]);
			}
		}
 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 		ArrayList dlist1=frd.defaultData(columns,district);
 	    ses.setAttribute("dlist1",dlist1);	
 	    ses.setAttribute("column",columns);
 	    ses.setAttribute("key","chlist");
 	    }
 		
 	else if(creport1.equals("masterd") && district.equals(""))
 		{
 		//System.out.println("6 If Loop");
 		    columns.add("SL. NO.");
 		    columns.add("District Code");
	 		columns.add("District Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterDist();
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterd");
 		}
 		
 		else if(creport1.equals("masterm") && !(district.equals("")))
 		{
 			//System.out.println("7 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Constituency Code");
	 		columns.add("Constituency Name");
 			columns.add("Mandal Code");
	 		columns.add("Mandal Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterMandal(district);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterm");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		
 		}
 		//panchayats under a mandal
 		else if(creport1.equals("masterp") && !(district.equals("")) && !(mandal1.equals("")))
 		{
 			Debug.println("8 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Panchayat Code");
	 		columns.add("Panchayat Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterPanchayat(district,mandal1);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterp");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("conhead",frd.constituencyheaderNames(district,mandal1));
 		}  
 		
 		//panchayat details under a district
 		else if(creport1.equals("masterp") && !(district.equals("")))
 		  {
 			Debug.println("9 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Constituency Code");
 			columns.add("Constituency Name");
 			columns.add("Mandal Code");
 			columns.add("Mandal Name");
 			columns.add("Panchayat Code");
	 		columns.add("Panchayat Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterPanchayat1(district,mandal1);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterp1");
	 		ses.setAttribute("dhead",frd.headerNames(district));
 		  }
 		
 		// vilages under a particular panchayat
 		else if(creport1.equals("masterv") && !(district.equals("")) && !(mandal1.equals("")) && !(panch1.equals("")))
 		{
 			//System.out.println("10 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Village Code");
	 		columns.add("Village Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterVillage(district,mandal1,panch1);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterv");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("conhead",frd.constituencyheaderNames(district,mandal1));
	 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
 		}
 		//villages under a mandal
 		else if(creport1.equals("masterv") && !(district.equals("")) && !(mandal1.equals("")))
 		{
 			//Debug.println("11 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Village Code");
	 		columns.add("Village Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterVillage1(district,mandal1);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterv1");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("conhead",frd.constituencyheaderNames(district,mandal1));
	 		
 		}
         //villages under a district
 		else if(creport1.equals("masterv") && !(district.equals("")))
 		{
 			Debug.println("12 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Constituency Code");
 			columns.add("Constituency Name");
 			columns.add("Mandal Code");
 			columns.add("Mandal Name");
 			columns.add("Panchayat Code");
 			columns.add("Panchayat Name");
 			columns.add("Village Code");
	 		columns.add("Village Name");
	 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	 		ArrayList dlist1=frd.masterVillage2(district);
	 		ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterv2");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 	}
 		
 		//Habitations under a village
 		else if (creport1.equals("masterh") && !(district.equals("")) && !(mandal1.equals("")) && !(panch1.equals("")) && !(village1.equals("")))
 			{
 			//System.out.println("13 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Habitation Code");
 			columns.add("Habitation Name");
 		/*	columns.add("LATITUDE");
 		 	columns.add("LONGITUDE");
 		 	columns.add("ELEVATION");
 		 	columns.add("WAY_POINT");
 		 	columns.add("LANDMARK");*/
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			ArrayList dlist1=frd.masterHabitation(district,mandal1,panch1,village1);
 			ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterh");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("conhead",frd.constituencyheaderNames(district,mandal1));
	 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
	 		ses.setAttribute("dmpvhead",frd.mpvheaderNames(district,mandal1,panch1,village1));
	 		//Debug.println("frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1):"+frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1));
	 		ses.setAttribute("dmpvhhead",frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1));
 			}
         //Habitations under a panchayat
 		else if (creport1.equals("masterh") && !(district.equals("")) && !(mandal1.equals("")) && !(panch1.equals("")))
 			{
 			//System.out.println("Habitations under a panchayat");
 			columns.add("SL. NO.");
 			columns.add("Habitation Code");
 			columns.add("Habitation Name");
 			/*columns.add("LATITUDE");
 		 	columns.add("LONGITUDE");
 		 	columns.add("ELEVATION");
 		 	columns.add("WAY_POINT");
 		 	columns.add("LANDMARK");*/
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			ArrayList dlist1=frd.masterHabitation1(district,mandal1,panch1);
 			ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterh1");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
	 		}
        //Habitations under a mandal
 		else if (creport1.equals("masterh") && !(district.equals("")) && !(mandal1.equals("")))
 			{
 			//System.out.println("14 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Habitation Code");
 			columns.add("Habitation Name");
 		/*	columns.add("LATITUDE");
 		 	columns.add("LONGITUDE");
 		 	columns.add("ELEVATION");
 		 	columns.add("WAY_POINT");
 		 	columns.add("LANDMARK");*/
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			ArrayList dlist1=frd.masterHabitation2(district,mandal1);
 			ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterh2");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("conhead",frd.constituencyheaderNames(district,mandal1));
	 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
	 		ses.setAttribute("dmpvhead",frd.mpvheaderNames(district,mandal1,panch1,village1));
 			}
        //Habitations under a district
 		else if (creport1.equals("masterh") && !(district.equals("")))
 			{
 			//System.out.println("15 If Loop");
 			columns.add("SL. NO.");
 			columns.add("Constituency Code");
 			columns.add("Constituency Name");
 			columns.add("Mandal Code");
 			columns.add("Mandal Name");
 			columns.add("Panchayat Code");
 			columns.add("Panchayat Name");
 			columns.add("Village Code");
 			columns.add("Village Name");
 			columns.add("Habitation Code");
 			columns.add("Habitation Name");
 		/*	columns.add("LATITUDE");
 		 	columns.add("LONGITUDE");
 		 	columns.add("ELEVATION");
 		 	columns.add("WAY_POINT");
 		 	columns.add("LANDMARK");*/
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			ArrayList dlist1=frd.masterHabitation3(district);
 			ses.setAttribute("dlist1",dlist1);
	 		ses.setAttribute("column",columns);
	 		ses.setAttribute("key","masterh3");
	 		ses.setAttribute("dhead",frd.headerNames(district));
	 		}
 		//DETAILED REPORT WHEN district or mandal or panchayat or village or habitation or all of them selected
 		else if (creport1.equals("hlist") && (!(district.equals("")) || !(mandal1.equals("")) || !(panch1.equals("")) || !(village1.equals("")) || !(hab1.equals("")) ))
 		{
 			//System.out.println("16 If Loop"+creport1);
 		    String pstat="";
 		    String cstat="";
 			columns.add("SL. NO.");
 			columns.add("District Code");
			columns.add("District Name");
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("District"))
 					columns.add("District Name");
 				if(fields[i].equals("Constituency"))
 					columns.add("Constituency Name");
 			    if(fields[i].equals("Mandal"))
 					columns.add("Mandal Name");
 			    if(fields[i].equals("Panchayat"))
 					columns.add("Panchayat Name");
 				if(fields[i].equals("Village"))
 					columns.add("Village Name");
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 				/*if(fields[i].equals("LATITUDE"))
 				columns.add("LATITUDE");
 				if(fields[i].equals("LONGITUDE"))
 			 	columns.add("LONGITUDE");
 			 	if(fields[i].equals("ELEVATION"))
 			 	columns.add("ELEVATION");
 			 	if(fields[i].equals("WAY_POINT"))
 			 	columns.add("WAY_POINT");
 			 	if(fields[i].equals("LANDMARK"))
 			 	columns.add("LANDMARK");*/
 			}
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot_condition);
 			}
// 			added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	////System.out.println("TOTWATER If Loop");
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl_condition",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source_condition);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
 			
 		    
            // to view the checked columns 
 			//Debug.println("colums"+columns.size());
 			for(int rec=0;rec<columns.size();rec++){
 			//Debug.println("colums"+rec+""+columns.get(rec));
 			if(columns.get(rec).equals("Prev Yr Status") && checkflag==0){
 				//Debug.println("Prev Yr Status is checked------------->"+rec);
 				ses.setAttribute("prevstatuscount", rec+"");
 				checkflag=1;
 			}
 			if(columns.get(rec).equals("Present Yr Status") && checkflag==1){
 				//Debug.println("Present Yr Status is checked------------->"+rec);
 				ses.setAttribute("presstatuscount", rec+"");
 				checkflag=2;
 			}
 			if(columns.get(rec).equals("Reasons for Slippage") && checkflag==2){
 				//Debug.println("Slippage is checked------------->"+rec);
 				ses.setAttribute("slipcount", rec+"");
 				checkflag=3;
 			}
 			}
 			
 			 			
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			String qry3=frd.queryGenerator(columns,rwsm);
 			//Debug.println("Query Generator"+qry3);
 			ses.setAttribute("query",qry3);
 			String check = "";
 			if(columns.contains("Total Water Supply(Safe)(LPCD)"))check="true";else check="false";
 			ArrayList rows=new ArrayList();
 			ses.setAttribute("check",check);
 			rows = frd.detailReport(rwsm,qry3,check);
 			//System.out.println("rows "+rows);
 			ses.setAttribute("rows",rows);
 			ses.setAttribute("column",columns);
 		    ses.setAttribute("key","dreport");
 		    Debug.println("---------------------------------------->"+frd.headerNames(district));
 		    ses.setAttribute("dhead",frd.headerNames(district));
	 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
	 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
	 		ses.setAttribute("dmpvhead",frd.mpvheaderNames(district,mandal1,panch1,village1));
	 		//Debug.println("frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1):"+frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1));
	 		ses.setAttribute("dmphvhead",frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1));
	 		Debug.println("district::::::::::::::::::"+district);
	 		if(mode.equals("outFlex") && district.equals("ALL")){mode="excelView";}
	 		Debug.println("Mode finally:"+mode);
	 		return mapping.findForward(mode);
 		}
 		
 		
 		
 		//DETAILED REPORT WITHOUT DISTRICT DETAILS
 		else if (creport1.equals("hlist"))
 		{
 			//System.out.println("17 If Loop");
 			String cstat="";
 			String pstat="";
 			columns.add("SL. NO.");
 			//This for loop will add one extra column e.g. if habitation
 			//is selecte.Then Habitation Column will be added apart
 			//from that one more column Habitation Name will be added.
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("District"))
 					columns.add("District Name");
 			    if(fields[i].equals("Mandal"))
 					columns.add("Mandal Name");
 			    if(fields[i].equals("Panchayat"))
 					columns.add("Panchayat Name");
 				if(fields[i].equals("Village"))
 					columns.add("Village Name");
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			/*	if(fields[i].equals("LATITUDE"))
 	 				columns.add("LATITUDE");
 	 				if(fields[i].equals("LONGITUDE"))
 	 			 	columns.add("LONGITUDE");
 	 			 	if(fields[i].equals("ELEVATION"))
 	 			 	columns.add("ELEVATION");
 	 			 	if(fields[i].equals("WAY_POINT"))
 	 			 	columns.add("WAY_POINT");
 	 			 	if(fields[i].equals("LANDMARK"))
 	 			 	columns.add("LANDMARK");*/
 			}
 			//System.out.println("Second Query Generator");
 			if (!(cp.equals("")))
 			{
 				ses.setAttribute("cp",cp);
 				ses.setAttribute("cp_condition",cp_condition);
 			}
 			if (!(csc.equals("")))
 			{
 				ses.setAttribute("csc",csc);
 				ses.setAttribute("csc_condition",csc_condition);
 			}
			if (!(cst.equals("")))
			{
				ses.setAttribute("cst",cst);
				ses.setAttribute("cst_condition",cst_condition);
			}
 			if (!(ctot.equals("")))
 			{
 				ses.setAttribute("ctot",ctot);
 				ses.setAttribute("ctot_condition",ctot_condition);
 			}
// 			added by swapna
 			if (!(habtype.equals("")))
 			{
 				ses.setAttribute("habtype",habtype);
 				ses.setAttribute("habType",habtype);
 			}
 			if (!(habsubtype.equals("")))
 			{
 				ses.setAttribute("habsubtype",habsubtype);
 				ses.setAttribute("habSubType",habsubtype);
 			}
 			if (!(category.equals("")))
 			{
 				ses.setAttribute("category",category);
 				ses.setAttribute("habCat",category);
 			}
			//
 			if (!(flopop1.equals("")))
 			{
 				ses.setAttribute("flopop",flopop1);
 				ses.setAttribute("flopop_condition",flopop_condition);
 			}
 			if (!(floreason.equals("")))
 				ses.setAttribute("floreason",floreason.toUpperCase());
 			if(compl_stat.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<compl_stat.length;i++)
 				{
 					if(add)
 				    cstat+=",";
 					cstat+=compl_stat[i];
 					add=true;
 				}
 				ses.setAttribute("cstat",cstat);
 			}
 			if(prev_stat1.length!=0)
 			{
 				boolean add=false;
 				for (int i=0;i<prev_stat1.length;i++)
 				{
 					if(add)
 				    pstat+=",";
 					pstat+=prev_stat1[i];
 					add=true;
 				}
 				ses.setAttribute("pstat",pstat);
 			}
 			
 		    if (!(tot_wat_supl.equals("")))
 		    {
 		    	ses.setAttribute("totwat",tot_wat_supl);
 		    	ses.setAttribute("tot_wat_supl",tot_wat_supl_condition);
 		    }
 		    if (!(ext_wat_lvl.equals("")))
 		    {
		    	ses.setAttribute("extwat",ext_wat_lvl);
		    	ses.setAttribute("ext_wat_lvl_condition",ext_wat_lvl_condition);
 		    }
 		    if (!(near_surf_source.equals("")))
 		    {
		    	ses.setAttribute("nearsurface",near_surf_source);
		    	ses.setAttribute("near_surf_source_condition",near_surf_source_condition);
 		    }
 		    if (!(near_ground_source.equals("")))
 		    {
		    	ses.setAttribute("nearground",near_ground_source);
		    	ses.setAttribute("near_ground_source_condition",near_ground_source_condition);
 		    }
 		    if (!(amnt_reqd1.equals("")))
 		    {
	    	    ses.setAttribute("amntreqd",amnt_reqd1);
	    	    ses.setAttribute("amnt_reqd_condition",amnt_reqd_condition);
 		    }
 		    if (!(prop_year1.equals("")))
	    	    ses.setAttribute("propyr",prop_year1);
 			
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			String qry3=frd.queryGenerator1(columns,rwsm);
 		    ses.setAttribute("query",qry3);
 			//vikas error occured to add lpcd
 		    ArrayList rows=frd.detailReport(rwsm,qry3,"");
 			ses.setAttribute("rows",rows);
 			ses.setAttribute("column",columns);
 		    ses.setAttribute("key","dreport");
 		    ses.setAttribute("cstat",cstat);
 		    ses.setAttribute("pstat",pstat);
 		    if(mode.equals("outFlex") && district.equals("ALL")){mode="excel";}
 		 	return mapping.findForward(mode);
 		 }
 		
 /*		else if(creport1.equals("hlist"))
 		{
 			columns.add("SL. NO.");
 			for (int i=0;i<fields.length;i++)
 			{
 				columns.add(fields[i]);
 				if(fields[i].equals("Habitation"))
 					columns.add("Habitation Name");
 			}
 			FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 			String qry3=frd.queryGenerator(columns,rwsm);
 		    ses.setAttribute("query",qry3);
 			ArrayList rows=frd.detailReport(qry3);
 			request.setAttribute("rows",rows);
 			ses.setAttribute("column",columns);
 		    request.setAttribute("key","dreport");
 	    }*/
 		
 		
 	}
 	/*if(mode.equals("excelView"))
 	{
 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
 		String query=(String)ses.getAttribute("query");
 		ArrayList rows=frd.detailReport(rwsm,query);
		request.setAttribute("rows",rows);
		request.setAttribute("key",request.getParameter("key"));
 		
 	}*/
 	return mapping.findForward(mode);
 }
 public void printAll(DynaActionForm flexDynaForm)
 {
 	//System.out.println("PRINTLLLLL");
 	////System.out.println("1"+flexDynaForm.get("cp"));
 	////System.out.println("2"+flexDynaForm.get("district"));
 	////System.out.println("3"+flexDynaForm.get("mandal"));
 	////System.out.println("4"+flexDynaForm.get("panchayat"));
 	////System.out.println("5"+flexDynaForm.get("village"));
 	////System.out.println("6"+flexDynaForm.get("habCode"));
 	////System.out.println("7"+flexDynaForm.get("csc"));
 	////System.out.println("8"+flexDynaForm.get("cst"));
 	////System.out.println("9"+flexDynaForm.get("ctot"));
 	////System.out.println("10"+flexDynaForm.get("tot_wat_supl"));
 	////System.out.println("11"+flexDynaForm.get("ext_wat_lvl"));
 	////System.out.println("12"+flexDynaForm.get("near_surf_source"));
 	////System.out.println("13"+flexDynaForm.get("near_ground_source"));
 	////System.out.println("14"+flexDynaForm.get("prop_year"));
 	////System.out.println("15"+flexDynaForm.get("amnt_reqd"));
 	////System.out.println("16"+flexDynaForm.get("flopop"));
 	////System.out.println("17"+flexDynaForm.get("freason"));
 	
 	
 	
 }
 
}