/*
 * Created by sridhar on Oct 22, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

import org.apache.struts.action.*;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.commons.Debug;

/**
 * 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AssetFreeFormatReport_Act extends Action {
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
	 {
	 	
		DynaActionForm AssetDynaForm = (DynaActionForm)form;
		HttpSession ses=request.getSession();
	 	String mode="",district="";
	 	String offices,division,subdivision,mandal,panchayat,village,habcode,assettype,assetstatus,assetname,location,
	 		   yrcreation,yrcreationcond,costasset,costassetcond,nofhab,nofhabcond,popben,popbencond,creport,creport1;
	 	try{
	 		//Debug.println("1:"+AssetDynaForm);
	 		
	 	offices = (String)AssetDynaForm.get("offices");
	 	division = (String)AssetDynaForm.get("division");
	 	subdivision = (String)AssetDynaForm.get("subdivision");
		
	 	RwsUser user = (RwsUser)ses.getAttribute("RWS_USER");
	 	if(user==null)return mapping.findForward("expire");
	 	//nic.watersoft.commons.Debug.println("CircleOfficeCOde="+user.getCircleOfficeCode());
	 	if(!(user.getCircleOfficeCode().equals("00")))//getting district name from login id 
	 		district=user.getCircleOfficeCode();
	 	else
	 		district=(String)AssetDynaForm.get("district");
	 	
	 	mandal=(String)AssetDynaForm.get("mandal");
	  	//Debug.println("Mandal::"+mandal);
	 	panchayat =(String)AssetDynaForm.get("panchayat");
	 	village=(String)AssetDynaForm.get("village");
	 	habcode=(String)AssetDynaForm.get("habCode");
	 	// Debug.println("execute method of habcode:"+habcode);
	 	assettype=(String)AssetDynaForm.get("assettype");
	 	//Debug.println(" asst type*********:"+assettype);
	 	assetstatus=(String)AssetDynaForm.get("assetstatus");
	 	assetname=(String)AssetDynaForm.get("assetname");
	 	location=(String)AssetDynaForm.get("location");
	 	yrcreationcond=(String)AssetDynaForm.get("yrcreationcond");
	 	yrcreation=(String)AssetDynaForm.get("yrcreation");
	 	costasset=(String)AssetDynaForm.get("costasset");
	 	nofhab=(String)AssetDynaForm.get("nofhab");
	 	popben=(String)AssetDynaForm.get("popben");
	 	costassetcond=(String)AssetDynaForm.get("costassetcond");
	 	nofhabcond=(String)AssetDynaForm.get("nofhabcond");
	 	popbencond=(String)AssetDynaForm.get("popbencond");
	 	
	 	RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
	 	CommonLists commonLists = new CommonLists(getDataSource(request));
	 	 FlexReportDAO flexdao=new FlexReportDAO();
	 	 
	 	 	String commonfields[]=(String[])AssetDynaForm.get("commonfields");
			String sourcefields[]=(String[])AssetDynaForm.get("sourcefields");
			String headworksfields[]=(String[])AssetDynaForm.get("headworksfields");
			String pipelinefields[]=(String[])AssetDynaForm.get("pipelinefields");
			String srreservoirsfields[]=(String[])AssetDynaForm.get("srreservoirsfields");
			String othersfields[]=(String[])AssetDynaForm.get("othersfields");
			String pumpingfields[]=(String[])AssetDynaForm.get("pumpingfields");
			String borewellfields[]=(String[])AssetDynaForm.get("borewellfields");
			String shpfields[]=(String[])AssetDynaForm.get("shpfields");
			String openwellfields[]=(String[])AssetDynaForm.get("openwellfields");
			String pondsfields[]=(String[])AssetDynaForm.get("pondsfields");
			String othercheckfields[]=(String[])AssetDynaForm.get("othercheckfields");
			
			String fields[] = (String[])AssetDynaForm.get("commonfields");
			
			String fields1[] = new String[50]; 
			int fieldsindex = 0;
			String selectedFields = "";
			boolean check=false;
			//Debug.println("4");
			if(commonfields.length != 0 )
			{
				for(int i = 0;i<commonfields.length;i++)
				{
					fields1[fieldsindex++] = commonfields[i];
				}
			}	
			//Debug.println("111");
			if(sourcefields.length != 0 )
			{
				selectedFields += "adminfields,";
				for(int i = 0;i<sourcefields.length;i++)
				{
					fields1[fieldsindex++] = sourcefields[i];
				}
			}	
			//Debug.println("222");
			if(headworksfields.length != 0 )
			{
				selectedFields += "headworksfields,";
				for(int i = 0;i<headworksfields.length;i++)
				{
					fields1[fieldsindex++] = headworksfields[i];
				}
			}
			//Debug.println("333"+fields1.length);
			if(pipelinefields.length != 0 )
			{
				selectedFields += "pipelinefields,";
				for(int i = 0;i<pipelinefields.length;i++)
				{
					fields1[fieldsindex++] = pipelinefields[i];
				}
			}
			//Debug.println("444"+fields1.length);
			if(srreservoirsfields.length != 0 )
			{
				selectedFields += "srreservoirsfields,";
				for(int i = 0;i<srreservoirsfields.length;i++)
				{
					fields1[fieldsindex++] = srreservoirsfields[i];
				}
			}
			//Debug.println("555");
			if(othersfields.length != 0 )
			{// Debug.println("555.1");
				selectedFields += "othersfields,";
				//Debug.println("555.2");
				for(int i = 0;i<othersfields.length;i++)
				{
				fields1[fieldsindex++] = othersfields[i];
					
			 }
			}//	Debug.println("666");
			if(pumpingfields.length != 0 )
			{
				selectedFields += "pumpingfields,";
				for(int i = 0;i<pumpingfields.length;i++)
				{
					fields1[fieldsindex++] = pumpingfields[i];
				}
			}
			
			if(borewellfields.length != 0 )
			{
				selectedFields += "borewellfields,";
				for(int i = 0;i<borewellfields.length;i++)
				{
					fields1[fieldsindex++] = borewellfields[i];
				}
			}
			if(shpfields.length != 0)
			{
				selectedFields += "shpfields,";
				for(int i = 0;i<shpfields.length;i++)
				{
					fields1[fieldsindex++] = shpfields[i];
				}
			}
			if(openwellfields.length != 0)
			{
				selectedFields += "openwellfields,";
				for(int i = 0;i<openwellfields.length;i++)
				{
					fields1[fieldsindex++] = openwellfields[i];
				}
			}
			if(pondsfields.length != 0 )
			{
				selectedFields += "pondsfields,";
				for(int i = 0;i<pondsfields.length;i++)
				{
					fields1[fieldsindex++] = pondsfields[i];
				}
			}
			if(othercheckfields.length != 0 )
			{
				selectedFields += "othercheckfields,";
				for(int i = 0;i<othercheckfields.length;i++)
				{
					fields1[fieldsindex++] = othercheckfields[i];
				}
			}
			
			//Debug.println("5");
			String[] selFields = selectedFields.split(",");
			ArrayList selfieldlist = new ArrayList(Arrays.asList(selFields));
			
			String[] fields2 = new String[fieldsindex];
			for(int i = 0;i<fieldsindex;i++)
			{
				fields2[i] = fields1[i];
				
			}
		 	creport = (String)AssetDynaForm.get("creport");
		 	creport1 =(String)AssetDynaForm.get("creport1");
	 	   //Debug.println("creport1.1" +creport1);
	 	mode=request.getParameter("mode");
	 	System.out.println("mode :"+mode);
	 	Debug.println("mode@@@@@@2:"+mode);
	    
	 	 if(mode.equals("data")) 
	    {
	    //Debug.println("5");
	    ArrayList circles = rwsoffice.getCircles(); 
	 	ArrayList divisions = rwsoffice.getDivisions1(offices);
	 	ArrayList subdivisions = rwsoffice.getSubDivisions1(offices,division);
	 	ArrayList dists = rwsoffice.getDistricts();
	 	//Debug.println("222222222222" +district );
 	 	ArrayList dmandal=rwsoffice.getDistrictMandals(district);
 	 	ArrayList mpanchyats=rwsoffice.getPanchayats(district,mandal);
 	 	//Debug.println("panchayats:" +mpanchyats.size());
 	 	ArrayList pvillages=rwsoffice.getVillages(district,mandal,panchayat);
 	 	ArrayList vhabs=RwsMasterData.getHabitations(district,mandal,panchayat,village, getDataSource(request));
 	 	//Debug.println("6:" +vhabs.size());
 	 	//Debug.println("7:" +vhabs);
 	 	ArrayList assettypes=commonLists.getAssetTypes();
 	 	//ArrayList assetnames=null;
 	 	//Debug.println("6.1:" +assettypes);
 	 	//ArrayList dateofcreation=flexdao.getDateofCreation();
	 	//Debug.println("doc:"+dateofcreation.size());
 	 	ses.setAttribute("circles",circles);
 	 	ses.setAttribute("divisions",divisions);
 	 	ses.setAttribute("subdivisions",subdivisions);
 	 	ses.setAttribute("districts",dists);
 	 	ses.setAttribute("mandals",dmandal);
 	 	ses.setAttribute("panchayats",mpanchyats);
 	 	ses.setAttribute("villages",pvillages);
 	 	//ses.removeAttribute("habitations");
 	 	ses.setAttribute("habitations",vhabs);
 	 	ses.setAttribute("assettype",assettypes);
 	 	// ses.setAttribute("yrcreations",dateofcreation);
 	 	
 		//Debug.println("8");
	    }
	 	if (!(mode.equals("data")))
	 	{
	 		//removing the session attributes.
			//Debug.println(" it is not in report mode");
	 		ses.removeAttribute("rows");
			ses.removeAttribute("column");
			ses.removeAttribute("dhead");
			ses.removeAttribute("cohead");
			ses.removeAttribute("dohead");
			ses.removeAttribute("sdohead");
			ses.removeAttribute("disthead");
			ses.removeAttribute("mandhead");
			ses.removeAttribute("panchhead");
			ses.removeAttribute("villagehead");
			ses.removeAttribute("habhead");
			ses.removeAttribute("assetname");
			ses.removeAttribute("assetstatus");
			ses.removeAttribute("yrcreation");
			ses.removeAttribute("yrcreationcond");
			ses.removeAttribute("assetcost");
			ses.removeAttribute("costassetcond");
			ses.removeAttribute("nofhabcond");
			ses.removeAttribute("Nofhabben");
			ses.removeAttribute("popbencond");
			ses.removeAttribute("popbenefited");
			ses.removeAttribute("selection1");ses.removeAttribute("selection2");ses.removeAttribute("selection3");
	 		ses.removeAttribute("selection4");ses.removeAttribute("selection5");ses.removeAttribute("selection6");
		
	 	}

	 	if (!(mode.equals("report")))
	 	{
	 		//removing the session attributes.
			//Debug.println(" it is not in report mode");
	 		ses.removeAttribute("rows");
			ses.removeAttribute("column");
			ses.removeAttribute("dhead");
			ses.removeAttribute("cohead");
			ses.removeAttribute("dohead");
			ses.removeAttribute("sdohead");
			ses.removeAttribute("disthead");
			ses.removeAttribute("mandhead");
			ses.removeAttribute("panchhead");
			ses.removeAttribute("villagehead");
			ses.removeAttribute("habhead");
			ses.removeAttribute("assetstatus");
			ses.removeAttribute("yrcreation");
			ses.removeAttribute("yrcreationcond");
			ses.removeAttribute("assetcost");
			ses.removeAttribute("costassetcond");
			ses.removeAttribute("nofhabcond");
			ses.removeAttribute("Nofhabben");
			ses.removeAttribute("popbencond");
			ses.removeAttribute("popbenefited");
		
	 	}
		
	    if(mode.equals("report"))
	    {
	    	
	    	//Debug.println(" In report mode");
	    	RwsMaster rwsm=new RwsMaster();
	    	 
	    	String qry = "",qry1 = "";
	 		//Debug.println("if loop for Report");
	 		rwsm.setMode(mode);
	 		rwsm.setDistrict(district);
	 		rwsm.setMandal(mandal);
	 		rwsm.setPanchayat(panchayat);
	 		rwsm.setVillage(village);
	 		rwsm.setHabcode(habcode);
	 		rwsm.setOffices(offices);
	 		rwsm.setDivision(division);
	 		rwsm.setSubdivision(subdivision);
	 		rwsm.setAssettype(assettype);
	 		rwsm.setAssetName(assetname);
	 		rwsm.setLocation(location);
	 		rwsm.setAssetstatus(assetstatus);
	 		rwsm.setYrcreation(yrcreation);
	 		rwsm.setYrcreationcond(yrcreationcond);
	 		rwsm.setCostassetcond(costassetcond);
	 		rwsm.setCostasset(costasset);
	 		rwsm.setNofhabcond(nofhabcond);
	 		rwsm.setNofhab(nofhab);
	 		rwsm.setPopbencond(popbencond);
	 		rwsm.setPopben(popben);
	 		//Debug.println("creport1.2" +creport1);	 		
	 		String selection1 = "",selection2 = "",selection3 = "",selection4 = "",selection5 = "",selection6 = "";
	 		if(!rwsm.getAssettype().equals(""))
	 		{
	 			selection1 +="asset type:"+rwsm.getAssettype()+"";
	 		}
	 		if(!rwsm.getAssetstatus().equals(""))
	 		{
	 			selection2 += " asset status:"+rwsm.getAssetstatus()+" Lakh.";
	 		}
	 		if(!rwsm.getYrcreation().equals(""))
	 		{
	 			selection3 += " Year Creation:"+rwsm.getYrcreation()+"";
	 		}
	 		if(!rwsm.getCostasset().equals(""))
	 		{
	 			selection4 += "Asset cost:"+rwsm.getCostasset()+" Lakh.";
	 		}
	 		if(!rwsm.getNofhab().equals(""))
	 		{
	 			selection5 += " No Of Habs Benefited:"+rwsm.getNofhab()+"";
	 		} 
	 		if(!rwsm.getPopben().equals(""))
	 		{
	 			selection6 += " No Of Population Benefited:"+rwsm.getPopben()+"";
	 		}
	 		ses.setAttribute("selection1",selection1);ses.setAttribute("selection2",selection2);
	 		ses.setAttribute("selection3",selection3);ses.setAttribute("selection4",selection4);
	 		ses.setAttribute("selection5",selection5);ses.setAttribute("selection6",selection6);
	 		String sessionId=ses.getId();
	 		//Debug.println("District before if::"+offices);
	 		//Debug.println("District before  rwsm if::"+rwsm.getOffices());
	 		String codeSeries = "";
			if(rwsm.getAssettype().equals("01"))codeSeries = "substr(s.scheme_code,17,3) like '6%'";
			else if(rwsm.getAssettype().equals("02"))codeSeries = "(substr(s.scheme_code,17,3) like '40%' or substr (s.scheme_code,17,3) like '41%' or substr(s.scheme_code,17,3) like '42%' or  substr(s.scheme_code,17,3) like '43%' or substr (s.scheme_code,17,3) like '44%')";
			else if(rwsm.getAssettype().equals("03"))codeSeries = "substr(s.scheme_code,17,3) like '8%'";
			else if(rwsm.getAssettype().equals("09"))codeSeries = "(substr(s.scheme_code,17,3) like '45%' or substr (s.scheme_code,17,3) like '46%' or substr(s.scheme_code,17,3) like '47%' or substr(s.scheme_code,17,3) like '48%' or substr (s.scheme_code,17,3) like '49%')";
			else if(rwsm.getAssettype().equals("04")) {codeSeries = "(substr(s.scheme_code,17,3) like '0%' or substr (s.scheme_code,17,3) like '1%' or substr(s.scheme_code,17,3) like '2%')";} 
			else if(rwsm.getAssettype().equals("05")) codeSeries = "substr(s.scheme_code,17,3) like '3%'";
			else if(rwsm.getAssettype().equals("06")) codeSeries = "substr(s.scheme_code,17,3) like '5%'";
			else if(rwsm.getAssettype().equals("07")) codeSeries = "substr(s.scheme_code,17,3) like '7%'";
			else if(rwsm.getAssettype().equals("08")) codeSeries = "substr(s.scheme_code,17,3) like '9%'";
			
	 		if(!offices.equals(""))
	 		{
		 		//Debug.println("First If Loop");
		 		FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
		 		String select = "";
		 	 	qry += "select a.*,s.SCHEME_CODE from  ";
		 	 	if(!offices.equals("") && division.equals("") && subdivision.equals(""))
				{
					if(offices.equals("all"))
					{
						qry+="rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code ";
						
					}
					else
					{
						qry+="rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and substr(a.hab_code,1,2)='"+rwsm.getOffices()+"'";
					}
					
					ses.setAttribute("cohead",frd.cheaderNames(offices));
				}
				else if(!offices.equals("") && !division.equals("") && subdivision.equals(""))
				{
					qry+="rws_asset_mast_tbl a ,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and  substr(a.hab_code,1,2)='"+rwsm.getOffices()+"' and division_office_code='"+rwsm.getDivision()+"'";
					
					ses.setAttribute("cohead",frd.cheaderNames(offices));
			    	ses.setAttribute("dohead",frd.dheaderNames(offices,division));
				}
				else if(!offices.equals("") && !division.equals("") && !subdivision.equals(""))
		 		{
					qry+="rws_asset_mast_tbl a ,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and substr(a.hab_code,1,2)='"+rwsm.getOffices()+"' and division_office_code='"+rwsm.getDivision()+"' and subdivision_office_code='"+rwsm.getSubdivision()+"'";
					ses.setAttribute("cohead",frd.cheaderNames(offices));
			    	ses.setAttribute("dohead",frd.dheaderNames(offices,division));			
					ses.setAttribute("sdohead",frd.sdheaderNames(offices,division,subdivision));
				}
				
		 		if(!rwsm.getAssettype().equals(""))
		 		{
		 		
		 			qry+=" and TYPE_OF_ASSET_CODE ='"+rwsm.getAssettype()+"'";
		 			ses.setAttribute("assetname",frd.schemeheaderNames(assettype));
		 		}
		 		if(!rwsm.getAssetName().equals(""))
		 		{
			 		
			 			qry+=" and asset_name like '%"+rwsm.getAssetName().toUpperCase()+"%'";
			 			//ses.setAttribute("assetname",assetname);
			 		}
		    	if(!rwsm.getLocation().equals("")) 
		 		{
			 		
			 			qry+=" and location like '%"+rwsm.getLocation().toUpperCase()+"%'";
			 			//ses.setAttribute("location",location);
			 		}
		 		//Debug.println(" before asset status");
		 		if(!rwsm.getAssetstatus().equals(""))
		 		{
		 			qry+=" and asset_status='"+rwsm.getAssetstatus()+"'";
		 			ses.setAttribute("assetstatus",assetstatus);
		 			
		 		}//Debug.println("after asset status");
		 		if(!rwsm.getYrcreationcond().equals("") && !rwsm.getYrcreation().equals(""))
		 		{
		 			qry+=" and to_char(DATE_CREATION,'YYYY') "+rwsm.getYrcreationcond()+" '"+rwsm.getYrcreation()+"' ";
		 			ses.setAttribute("yrcreationcond",yrcreationcond);
		 			ses.setAttribute("yrcreation",yrcreation);
		 		}//Debug.println("after asset status 11111111111"+rwsm.getCostassetcond());
		 		
		 		//Debug.println("after asset status22222222222222" +rwsm.getCostasset());
		 		if(!rwsm.getCostassetcond().equals("") &&  !rwsm.getCostasset().equals(""))
		 		{
		 			
		  			qry+=" and asset_cost "+rwsm.getCostassetcond()+" '"+rwsm.getCostasset()+"'";
		  			ses.setAttribute("costassetcond",costassetcond);
		  			ses.setAttribute("assetcost",rwsm.getCostasset()); 
		 		}
		 		//Debug.println("after asset status22222222222222");
		 		//Debug.println("after asset status33333333333333");
		 		
		 		if(!rwsm.getPopbencond().equals("")&& !rwsm.getPopben().equals(""))
		 		{
		 			qry+=" and POPU_BENEFITED "+rwsm.getPopbencond()+" '"+rwsm.getPopben()+"'";
		 			ses.setAttribute("popbencond",popbencond);
		 			ses.setAttribute("popbenefited",popben);
		 			
		 		}
		 		if(!rwsm.getNofhabcond().equals("")&& !rwsm.getNofhab().equals("")) 
		 		{
		 		ses.setAttribute("nofhabcond",nofhabcond);
	 			ses.setAttribute("Nofhabben",nofhab);
		 		}//Debug.println("after asset status444444444444444");
		 		ArrayList rows;
				ArrayList columns1 = new ArrayList();
				System.out.println("coumsize3"+columns1.size());
				// Debug.println("Qry ::"+qry+"fields length:"+fields2.length);
				
				 frd.createAssetview(qry,sessionId);   
				//  frd.getViewCreation(qry,fields2,creport,selectedFields)
				if(creport1.equals("abstract")){
					Debug.println(" in abstract report:" +qry);
				rows=frd.getAssetFormatData(qry,rwsm,select,fields2,creport,columns1,selectedFields,sessionId,request);
				//Debug.println("Rows Size:"+rows.size());
				if(rows.size() == 0 || rows == null)
				{
					mode = "data";
					request.setAttribute("message","No Record Matches with this Selection Criteria");
				}
				else
				{
					mode = "report";
					ses.setAttribute("rows",rows);
					Debug.println("coumsize"+columns1.size());
					System.out.println("coumsize4"+columns1.size());
					ses.setAttribute("column",columns1);
				   // ses.setAttribute("key","dreport");
			    }
				
				
			}
				else if(creport1.equals("detail"))
				{
					//Debug.println(" in Detail Mode&&&&&&&&&&&&&&$$$$$$$$$$$$$$$$$$$$$$$");
					rows=frd.getAssetFormatDatadetail(qry,rwsm,select,fields2,creport,columns1,selectedFields,ses.getId(),check,request);
					
					//Debug.println("Rows Size:"+rows.size());
					// Debug.println("CHECK:"+check);
					if(((String)request.getAttribute("checkvalue")).equals("false"))
					{
						mode = "data";
						request.setAttribute("message","No Record Matches with this Selection Criteria");
					}
					else  
					{
						mode = "detail";
						ses.setAttribute("rows",rows);
						ses.setAttribute("column",columns1);
						
						
				    }
					
				}
				
				
		 		
	    }else if(!district.equals(""))
	    {
	    	FlexReportDAO frd=new FlexReportDAO(getDataSource(request));
	    	String select = "";
	    	qry1+=" select a.*,s.SCHEME_CODE from ";
	    	if(!district.equals("") && mandal.equals("") && panchayat.equals("") && village.equals("") && habcode.equals(""))
	    	{
	    		if(district.equals("all")) 
	    		{
	    		 qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  ";	
	    		}
	    		else 
	    		{ 
	    		 qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code and substr(a.hab_code,1,2)='"+rwsm.getDistrict()+"'";
	    		 
	    		 Debug.println("qry1.1"+qry1);
	    		}
	    		ses.setAttribute("disthead",frd.distheaderNames(district));
	    	}
	    	else if(!district.equals("") && !mandal.equals("") && panchayat.equals("") && village.equals("") && habcode.equals(""))
	    	{ 
	    		 //Debug.println("rwsm.getMandalCode():"+rwsm.getMandal());
	    		qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and substr(a.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(hab_code,6,2)='"+rwsm.getMandal()+"'";
	    		ses.setAttribute("disthead",frd.cheaderNames(district));
		    	ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
		    	 Debug.println("qry1.2 anu"+qry1);
	    	}
	    	else if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && village.equals("") && habcode.equals(""))
	    	{
	    		//Debug.println("rwsm.getMandal():"+rwsm.getMandal());
	    		//Debug.println("rwsm.getPanchayat():"+rwsm.getPanchayat());
	    		qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and substr(a.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(hab_code,6,2)='"+rwsm.getMandal()+"'" +
	    				"and substr(hab_code,13,2)='"+rwsm.getPanchayat()+"'";
	    		// Debug.println("qry1.3"+qry1);
	    		ses.setAttribute("disthead",frd.cheaderNames(district));
		    	ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
		    	ses.setAttribute("panchhead",frd.panchheaderNames(district,mandal,panchayat));
	    	}
	    	else if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals("") && habcode.equals(""))
	    	{ 
	    		qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code and substr(a.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(hab_code,6,2)='"+rwsm.getMandal()+"'" +
				"and substr(hab_code,13,2)='"+rwsm.getPanchayat()+"' and substr(hab_code,8,3)='"+rwsm.getVillage()+"'";
	    		// Debug.println("qry1.4"+qry1);
	    		ses.setAttribute("disthead",frd.cheaderNames(district));
	    		ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
	    		ses.setAttribute("panchhead",frd.panchheaderNames(district,mandal,panchayat));
	    		ses.setAttribute("villagehead",frd.villheaderNames(district,mandal,panchayat,village));
	    	
	    	}
	    	else if(!district.equals("") && !mandal.equals("") && !panchayat.equals("") && !village.equals("") && !habcode.equals(""))
	    	{
	    		
	    		qry1+=" rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code = s.asset_code  and substr(a.hab_code,1,2)='"+rwsm.getDistrict()+"' and substr(hab_code,6,2)='"+rwsm.getMandal()+"'" +
				"and substr(hab_code,13,2)='"+rwsm.getPanchayat()+"' and substr(hab_code,8,3)='"+rwsm.getVillage()+"' and hab_code='"+rwsm.getHabcode()+"'";	
	    		ses.setAttribute("disthead",frd.cheaderNames(district));
	    		ses.setAttribute("mandhead",frd.mandheaderNames(district,mandal));
	    		ses.setAttribute("panchhead",frd.panchheaderNames(district,mandal,panchayat));
	    		ses.setAttribute("villagehead",frd.villheaderNames(district,mandal,panchayat,village));
	    		ses.setAttribute("habhead",frd.habheaderNames(district,mandal,panchayat,village,habcode));
	    	
	    	}
	    	//Debug.println("rwsm.getHabcode():"+rwsm.getHabcode());
	    	if(!rwsm.getAssettype().equals(""))
	 		{
	 		
	 			qry1+=" and TYPE_OF_ASSET_CODE ='"+rwsm.getAssettype()+"'";
	 			ses.setAttribute("assetname",frd.schemeheaderNames(assettype));
	 		}
	    	if(!rwsm.getAssetName().equals(""))
	 		{
		 		
		 			qry1+=" and asset_name like '%"+rwsm.getAssetName().toUpperCase()+"%'";
		 			//ses.setAttribute("assetname",assetname);
		 		}
	    	
	    	if(!rwsm.getLocation().equals("")) 
	 		{
		 		
		 			qry1+=" and location like '%"+rwsm.getLocation().toUpperCase()+"%'";
		 			//ses.setAttribute("location",location);
		 		}
	 		//Debug.println(" before asset status");
	 		if(!rwsm.getAssetstatus().equals(""))
	 		{
	 			qry1+=" and asset_status='"+rwsm.getAssetstatus()+"'"; 
	 			ses.setAttribute("assetstatus",assetstatus);
	 			 
	 		}//Debug.println("after asset status");
	 		if(!rwsm.getYrcreationcond().equals("") && !rwsm.getYrcreation().equals(""))
	 		{
	 			qry1+=" and to_char(DATE_CREATION,'YYYY') "+rwsm.getYrcreationcond()+" '"+rwsm.getYrcreation()+"' ";
	 			ses.setAttribute("yrcreationcond",yrcreationcond);
	 			ses.setAttribute("yrcreation",yrcreation);
	 		}//Debug.println("after asset status 11111111111"+rwsm.getCostassetcond());
	 		
	 		//Debug.println("after asset status22222222222222" +rwsm.getCostasset());
	 		if(!rwsm.getCostassetcond().equals("") &&  !rwsm.getCostasset().equals(""))
	 		{
	 			
	  			qry1+=" and asset_cost "+rwsm.getCostassetcond()+" '"+rwsm.getCostasset()+"'";
	  			ses.setAttribute("costassetcond",costassetcond);
	  			ses.setAttribute("assetcost",rwsm.getCostasset()); 
	 		}
	 		
	 		if(!rwsm.getPopbencond().equals("")&& !rwsm.getPopben().equals(""))
	 		{
	 			qry1+=" and POPU_BENEFITED "+rwsm.getPopbencond()+" '"+rwsm.getPopben()+"'";
	 			ses.setAttribute("popbencond",popbencond);
	 			ses.setAttribute("popbenefited",popben);
	 			
	 		}
	 		if(!rwsm.getNofhabcond().equals("")&& !rwsm.getNofhab().equals("")) 
	 		{
	 		ses.setAttribute("nofhabcond",nofhabcond);
 			ses.setAttribute("Nofhabben",nofhab);
	 		}
	 		//Debug.println("DMVPH$$$$$$$$$$$$$$$$$:"+qry1);
	 		ArrayList rows ;
			ArrayList columns1 = new ArrayList();
			System.out.println("coumsize2"+columns1.size());
			 //Debug.println("Qry ::"+qry1+"fields length:"+fields2.length);
			frd.createAssetview(qry1,sessionId); 
			// frd.getViewCreation(qry1,fields2,creport,selectedFields);
			//Debug.println("creport1:" +creport1);
			//Debug.println("after view creation");
			if(creport1.equals("abstract")){
				//Debug.println(" in abstract report ");
			rows=frd.getAssetFormatData(qry1,rwsm,select,fields2,creport,columns1,selectedFields,sessionId,request);
			//Debug.println("Rows Size:"+rows.size());
			if(rows.size() == 0 || rows == null)
			{
				mode = "data";
				request.setAttribute("message","No Record Matches with this Selection Criteria");
			}
			else
			{
				mode = "report";
				ses.setAttribute("rows",rows);
				//Debug.println("coumsize"+columns1.size());
				System.out.println("coumsize1"+columns1.size());
				ses.setAttribute("column",columns1);
			   // ses.setAttribute("key","dreport");
		    }
			
		}
			else if(creport1.equals("detail"))
			{
				rows=frd.getAssetFormatDatadetail(qry1,rwsm,select,fields2,creport,columns1,selectedFields,ses.getId(),check,request);
			
				//Debug.println("Rows Size:"+rows.size());
				//Debug.println("CHECK district:"+check);
				//Debug.println("CHECK district from request:"+request.getAttribute("checkvalue"));
				if(((String)request.getAttribute("checkvalue")).equals("false"))
				{
					mode = "data";
					request.setAttribute("message","No Record Matches with this Selection Criteria");
				}
				else
				{
					mode = "detail";
					ses.setAttribute("rows",rows);
					//Debug.println("coumsize in class"+columns1.size());
					ses.setAttribute("column",columns1);
				   // ses.setAttribute("key","dreport");
			    }	
			}
			
	      }	
	 		
	    }
	 	
	 	}catch(Exception e)
		{
	 		Debug.println("Error getting in Asset Free Format Act:"+e);
		}
	 	//Debug.println("mode:"+mode);
	 	return mapping.findForward(mode);
	 	}

}
