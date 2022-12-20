package nic.watersoft.Sanitation;

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


public class IhhlReportAct extends Action  {
	
	 public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
	 {

		 	DynaActionForm flexDynaForm = (DynaActionForm)form;
		 	HttpSession ses=request.getSession();
		 	String mode,district,mandal1,panch1,village1,hab1,subcat,gen,cardtype,cat,creport1,checkall,flopop1,floreason,CATEGORYCODE,cardtypeid,constituency; 
		 	String compl_stat[]=(String[])flexDynaForm.get("compl_stat");
		 	int checkflag=0,slipagecnt=0,prevcnt=0,presentcnt=0;
		 	subcat=(String)flexDynaForm.get("subcategory");
		 	gen=(String)flexDynaForm.get("gen");
		 	CATEGORYCODE=(String)flexDynaForm.get("category");
		 //	Debug.println("CATEGORYCODE*............."+CATEGORYCODE);
		 	cardtype=(String)flexDynaForm.getString("cardtype");
		 	cat=(String)flexDynaForm.get("category");
		 	cardtypeid=(String)flexDynaForm.getString("cardid");
		 	//Debug.println("cardtypeid*............."+cardtypeid);
		 	
		 	constituency=(String)flexDynaForm.getString("constituency");
		// 	Debug.println("constituency*............."+constituency);
		
		 	
		 	RwsUser user = (RwsUser)ses.getAttribute("RWS_USER");
		 	if(user==null || ses==null)
		 	{
		 		return mapping.findForward("expire");
		 	}
		 	
		 	if(!(user.getCircleOfficeCode().equals("00")))
		 		district=user.getCircleOfficeCode();
		 	else
		 	district=(String)flexDynaForm.get("district");
		  	mandal1=(String)flexDynaForm.get("mandal");
		 	panch1 =(String)flexDynaForm.get("panchayat");
		 	village1=(String)flexDynaForm.get("village");
		 	hab1=(String)flexDynaForm.get("habCode");
		 	CATEGORYCODE=(String)flexDynaForm.get("category");
		 	cardtypeid=(String)flexDynaForm.getString("cardid");
		 	

		 	gen=(String)flexDynaForm.get("gen");
		 //	Debug.println("habtype**"+gen);
		 	cardtype=(String)flexDynaForm.getString("cardtype");
		 	cat=(String)flexDynaForm.getString("category");
			//
		 	String prev_stat1[]=(String[])flexDynaForm.get("prev_stat");
		 	
		 	flopop1=(String)flexDynaForm.get("flopop");
		 	floreason=(String)flexDynaForm.get("freason");
		 	creport1=(String)flexDynaForm.get("creport");
		 	String fields[]=(String[])flexDynaForm.get("fields");
		 	String popdet[]=(String[])flexDynaForm.get("popdet");
		 	checkall=(String)flexDynaForm.get("checkall");
		 
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
		 	IhhlReportDAO ihhl=new IhhlReportDAO(getDataSource(request));
		 	ArrayList dists = rwsoffice.getDistricts();
		 	ArrayList cons = rwsoffice.getConstituencies(district);
		 	//System.out.println("district="+district);
		 	ArrayList dmandal=rwsoffice.getDistrictMandals(district);
		 	ArrayList mpanchyats=rwsoffice.getPanchayats(district,mandal1);
		 	ArrayList pvillages=rwsoffice.getVillages(district,mandal1,panch1);
		 	ArrayList vhabs=RwsMasterData.getHabitations(district, mandal1,panch1,village1, getDataSource(request));
		 	ArrayList cardtypes=ihhl.getCardType();
		 	ArrayList categories=ihhl.getCategory();
		 	System.out.println("categories:::"+categories);
		 	ArrayList subcategories=ihhl.getSubCategory(CATEGORYCODE);
		 	
		 	
		 	
		 
		 	
		 	
		 	//sending district details in session
		 	ses.setAttribute("districts",dists);
		 	ses.setAttribute("constituents",cons);
		 	ses.setAttribute("mandals",dmandal);
		 	ses.setAttribute("panchayats",mpanchyats);
		 	ses.setAttribute("villages",pvillages);
		 	ses.setAttribute("habitations",vhabs);
		 	ses.setAttribute("cardtypes",cardtypes);
		 	ses.setAttribute("categories", categories);
		 	ses.setAttribute("subcategories", subcategories);
		 		
		 	
		 	if (!(mode.equals("outFlex")))
		 	{
		 		ses.removeAttribute("flopop");
	
		 	ses.removeAttribute("cat");
		 	ses.removeAttribute("subcat");
		 	ses.removeAttribute("gen");
		 	ses.removeAttribute("cardtype");
		 	
		 	}
		 	
		 	//	By default for Consolidated Report
		 	if (mode.equals("outFlex"))
		 	{  
		 	
		 	  ArrayList columns=new ArrayList();
		 	  ArrayList form_fields=new ArrayList();
		 	  IhhlFormBean rwsm=new IhhlFormBean();
		 	
		   
		 	  rwsm.setDistCode(district);
		 	  rwsm.setMandalCode(mandal1);
		 	  rwsm.setPanchCode(panch1);
		 	  rwsm.setVillCode(village1);
		 	  rwsm.setHabcode(hab1);
		 	  rwsm.setCardid(cardtypeid);
		 	
		  	 rwsm.setGen(gen);
		 	  rwsm.setCardtype(cardtype);
		 	  rwsm.setCat(cat);
		 	  rwsm.setSubcat(subcat);
		 	 
		 	  //Debug.println("creport1"+creport1);
		 	  
		 	
		 	 // System.out.println("CATEGORYCODE"+CATEGORYCODE);
		 	  
		 	 if(((creport1.equals("chlist") && !(mandal1.equals("")) && !(panch1.equals("")) && !(village1.equals("")))))
			    {
		 		 //System.out.println("CATEGORYCODE"+CATEGORYCODE);
		 	 	//Debug.println("First If Loop");
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
			 	/*columns.add("Category Name");
			 	columns.add("No. Of Categories");
			 	columns.add("SubCategory Name");
			 	columns.add("No. Of SubCategories");*/
			 	
			 
			 	
			 	IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
			ArrayList dlist1=frd.consolData1(columns,rwsm,district);
				    String pstat="";
		 		    String cstat="";
		 		ses.setAttribute("dlist1",dlist1);
			 	ses.setAttribute("column",columns);
			 	ses.setAttribute("key","chlist4");
			  	}
		 	 
		 	
		 	 else if ((creport1.equals("chlist") && !(mandal1.equals("")) && !(panch1.equals("")) ))
			    {
		 	 	//Debug.println("Second If Loop");
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
			 	
			 	IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
			 	ArrayList dlist1=frd.consolData1(columns,rwsm,district);
				  
		 			
		 		 
			 	ses.setAttribute("dlist1",dlist1);
			 	ses.setAttribute("column",columns);
			 	ses.setAttribute("key","chlist3");
			  	}
		 	  
		 	 else if (creport1.equals("chlist") && !(mandal1.equals(""))  )
		 	    {
		 	  //	Debug.println("3 If Loop");
		 	  	
		 	 	columns.add("SL. NO.");
		 	 	columns.add("District Code");
		 	 	columns.add("District Name");
		 	 	columns.add("Constituency Code");
		 	 	columns.add("Constituency Name");
		 	 	columns.add("Mandal Code");
		 	 	columns.add("Mandal Name");
		 	 	columns.add("No. Of Habitations");
		 	 	
		 	 	IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 	 	ArrayList dlist1=frd.consolData1(columns,rwsm,district);
			 		 
		 	 	ses.setAttribute("dlist1",dlist1);
		 	 	ses.setAttribute("column",columns);
		 	 	ses.setAttribute("key","chlist2");
		 	 	}
		 	 
		 	
		 	 
		 	else if (creport1.equals("chlist") && !CATEGORYCODE.equals("") && !subcat.equals(""))
		 	   {
		 	 	System.out.println("5 If Loop");
		 	  	columns.add("SL. NO.");
		 	 	columns.add("District Code");
		 	 	columns.add("District Name");
		 	 	columns.add("No. Of Habitations");
		 	 	columns.add("Category Name");
		 		columns.add("No.Of APL/BPL Categories");
		 		columns.add("SubCategory Name");
		 		columns.add("No.Of SubCategories");
		 	 	
		 	 	
		 	 	IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 	 	ArrayList dlist1=frd.consolData2(columns,rwsm,district,CATEGORYCODE,subcat);
				   
		 		   
		 	 	ses.setAttribute("dlist1",dlist1);	
		  	    ses.setAttribute("column",columns);
		  	    ses.setAttribute("key","chlist7");
		 	   }
		 	 
		 	else if (creport1.equals("chlist") && !CATEGORYCODE.equals(""))
		 	   {
		 	 	System.out.println("4 If Loop");
		 	  	columns.add("SL. NO.");
		 	 	columns.add("District Code");
		 	 	columns.add("District Name");
		 	 	columns.add("No. Of Habitations");
		 	 	columns.add("Category Name");
		 		columns.add("No.Of APL/BPL Categories");
		 		
		 	 	
		 	 	
		 	 	IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 	 	ArrayList dlist1=frd.consolData(columns,rwsm,district,CATEGORYCODE);
				   
		 		   
		 	 	ses.setAttribute("dlist1",dlist1);	
		  	    ses.setAttribute("column",columns);
		  	    ses.setAttribute("key","chlist1");
		 	   }
		 	else if ( creport1.equals("chlist") && (!cardtypeid.equals("")) )
		 		{
		 		
		 	 	//System.out.println("5 If Loop");
		 	 	columns.add("SL. NO.");
		 		columns.add("District Code");
		 		columns.add("District Name");
		 		columns.add("No.Of Habitations");
		 		columns.add("Card Name");
		 		columns.add("No.Of cards");
		 		
		 		IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 		ArrayList dlist1=frd.cardType(columns,district,cardtypeid);
		 	    ses.setAttribute("dlist1",dlist1);	
		 	    ses.setAttribute("column",columns);
		 	    ses.setAttribute("key","chlist");
		 	    
		 	    }
		 	else if(creport1.equals("chlist") && (!gen.equals("")))
		 	{
		 	//	System.out.println("6 If Loop");
		 	 	columns.add("SL. NO.");
		 		columns.add("District Code");
		 		columns.add("District Name");
		 		columns.add("No.Of Habitations");
		 		columns.add("Gender");
		 		columns.add("No.Of Female/Male");
		 		
		 		IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 		ArrayList dlist1=frd.Gender(columns,district,gen);
		 	    ses.setAttribute("dlist1",dlist1);	
		 	    ses.setAttribute("column",columns);
		 	    ses.setAttribute("key","chlist6");
		 		
		 	}
		 		
		 	
		 	 
		 
		 		else if (creport1.equals("hlist") && (!(district.equals("")) || !(mandal1.equals("")) || !(panch1.equals("")) || !(village1.equals("")) || !(hab1.equals("")) || !(constituency.equals(""))  ))
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
		 				
		 			}
		 		
		 		
		 		
		            // to view the checked columns 
		 			//Debug.println("colums"+columns.size());
		 			for(int rec=0;rec<columns.size();rec++){
		 		
		 			
		 			}
		 			
		 			 			
		 			IhhlReportDAO frd=new IhhlReportDAO(getDataSource(request));
		 			String qry3=frd.queryGenerator(columns,rwsm,constituency);
		 			//Debug.println("Query Generator123anu"+qry3);
		 			ses.setAttribute("query",qry3);
		 			String check = "";
		 			
		 			ArrayList rows=new ArrayList();
		 			ses.setAttribute("check",check);
		 			rows = frd.detailReport(rwsm,qry3,check);
		 			
		 			ses.setAttribute("rows",rows);
		 			ses.setAttribute("column",columns);
		 		    ses.setAttribute("key","dreport");
		 		 //   Debug.println("-------------anu---------->"+frd.headerNames(district));
		 		    ses.setAttribute("dhead",frd.headerNames(district));
			 		ses.setAttribute("dmhead",frd.mheaderNames(district,mandal1));
			 		ses.setAttribute("dmphead",frd.mpheaderNames(district,mandal1,panch1));
			 		ses.setAttribute("dmpvhead",frd.mpvheaderNames(district,mandal1,panch1,village1));
			 	
			 		ses.setAttribute("dmphvhead",frd.mpvhheaderNames(district,mandal1,panch1,village1,hab1));
			 		ses.setAttribute("dchead", frd.masterMandal(district));
			 		//Debug.println("district::::::::::::::::::"+district);
			 		if(mode.equals("outFlex") && district.equals("ALL")){mode="excelView";}
			 		//Debug.println("Mode finally:"+mode);
			 		return mapping.findForward(mode);
		 		}
		 		
		 		
		 		
		 	
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
		 				
		 			
		 			}
		 			
		 		   
		 		 }
		 		
		
		 		
		 	}
		 	
		 	return mapping.findForward(mode);
		 
		 
	 
	 }
	
	

}
