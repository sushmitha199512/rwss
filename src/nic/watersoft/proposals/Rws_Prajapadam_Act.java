package nic.watersoft.proposals;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
//import nic.watersoft.commons.Debug;

public class Rws_Prajapadam_Act extends Action
{
	ArrayList districts = null;
	ArrayList mandals = null;
	ArrayList programs = null;
	ArrayList subPrograms = null;
	ArrayList habitations = null;
	ArrayList list=null;
	ArrayList typeOfAssets=null;
	ArrayList prajaPadamList=null;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
	{
		String mode = request.getParameter("mode");
		Rws_Prajapadam_FormBean praja =(Rws_Prajapadam_FormBean)form;
		
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		DataSource dataSource = getDataSource(request);
		
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		RwsLocations locations=new RwsLocations(dataSource);
		CommonLists commons=new CommonLists(dataSource);
		
		String headOfficeCode = praja.getHeadOfficeCode();
		String district = praja.getDistrictCode();
		
		if(headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if(district == null)
			district = user.getCircleOfficeCode();
		if(!district.equals("00"))
		{
			praja.setDistrictCode(district);
		}
		try
 		{
			//System.out.println("in try"+mode+"555555555555"+district);
			Date today = new Date();
			 
		 	
			if(mode.equals("data"))
			{   
	 				 districts = locations.getDistricts();
	 				 typeOfAssets=commons.getAssetTypes();
	 				 programs=commons.getProgrammes();
					 session.setAttribute("districts",districts);
					 session.setAttribute("programs",programs);
					 session.setAttribute("TypeOFAsset",typeOfAssets);
					 if(!district.equals("00"))
					 {
					 	 mandals = locations.getMandals(praja.getDistrictCode());
						 session.setAttribute("mandals",mandals);
					 }
					    
	  		}
			
				if(mode.equals("man") )
				{
				 		 mandals = locations.getMandals(praja.getDistrictCode());
						 session.setAttribute("mandals",mandals);
						 mode="data";
						    praja.setConName("");
			 				praja.setConCode("");
			 				praja.setStatusAsOn("");
			 				praja.setCpws("");
			 				praja.setPws("");
			 				praja.setDirectPump("");
			 				praja.setBoreWells("");
			 				praja.setOthers("");
			 				praja.setOthersValue("");
			 				//System.out.println("Sanction at"+praja.getSanctionAt());
		  		}
			 
			if(mode.equals("prog"))
			{
		 			 subPrograms = commons.getSubprogrammes(praja.getProgramme());
					 session.setAttribute("subPrograms",subPrograms);
					 mode="data";
	  		}
			if(mode.equals("habs"))
			{
		 			 habitations = locations.getHabsForPraja(praja.getDistrictCode(),praja.getMandalCode());
					 session.setAttribute("Habitations",habitations);
					 mode="data";
					    praja.setConName("");
		 				praja.setConCode("");
		 				praja.setStatusAsOn("");
		 				praja.setCpws("");
		 				praja.setPws("");
		 				praja.setDirectPump("");
		 				praja.setBoreWells("");
		 				praja.setOthers("");
		 				praja.setOthersValue("");
	  		}
			if(mode.equals("cons"))
			{
		 			 String habCode=praja.getHabCode();
		 			list=new ArrayList();
		 			list=(ArrayList)locations.getConstituency(habCode,getDataSource(request));
		 			//System.out.println("ArraySize"+list.size());
		 			if(list.size()>0)
		 			{ 
		 				try{
		 				praja.setConName((String)list.get(0));
		 				praja.setConCode((String)list.get(1));
		 				praja.setStatusAsOn((String)list.get(2));
		 		 		}
		 				catch(Exception e)
						{
		 					//System.out.println("Excpetion e"+e);
						}
		 			}
		 			try{
		 			ProposalDAO dao=new ProposalDAO(getDataSource(request));
		 			Rws_Prajapadam_Bean  bean=new Rws_Prajapadam_Bean ();
		 			bean=dao.getHabDetils(praja.getHabCode());
		 			//System.out.println("$$$$$"+bean.getDirectPump());
		 			praja.setCpws(bean.getCpws());
		 			praja.setPws(bean.getPws());
		 			praja.setDirectPump(bean.getDirectPump());
		 			praja.setBoreWells(bean.getBoreWells());
		 			praja.setOthers(bean.getOthers());
		 			praja.setOthersValue(bean.getOthersValue());
		 			}
		 			catch(Exception e)
					{
		 				//System.out.println("Exception exist value:"+e);
					}
	 				 mode="data";
	  		}
			
			
			if(mode.equalsIgnoreCase("save"))
			{
				ProposalDAO dao=new ProposalDAO(getDataSource(request));
				String workId=dao.getNextWorkIdForPrajapadam(praja.getHeadOfficeCode(),
						praja.getDistrictCode(),praja.getTypeOfAssetCode(),
						praja.getProgramme(),praja.getSubProgramme()
						);
				//System.out.println("work id is "+workId);
				
			 String query1="INSERT INTO RWS_PRAJAPADAM_TBL (DCODE ,MCODE,HAB_CODE,WORK_ID,WORK_NAME ,ESTIMATE_COST ," +
			 		"PROGRAMME_CODE,SUBPROGRAMME_CODE,ADMN_SANC_NO,ADMN_SANC_DATE,GROUND_DATE ,COMPLETION_DATE," +
			 		"EXP_UPTO_THE_PRE_MONTH,EXP_DUR_THE_MONTH ,EXP_TO_BE_INCURRED ,PHY_STAGE_OF_WORK,REMARKS,SANCTIONED_AT)VALUEs(" +
			 		"'"+praja.getDistrictCode()+"',"
			       +"'"+praja.getMandalCode()+"',"
			       +"'"+praja.getHabCode()+"',"
			       +"'"+workId+"',"
			       +"'"+praja.getWorkName()+"',"
			       +"'"+praja.getEstCost()+"',"
			       +"'"+praja.getProgramme()+"',"
			       +"'"+praja.getSubProgramme()+"',"
			       +"'"+praja.getAdminSancRefNo()+"',"
			       +"to_date('"+praja.getAdminSancDate()+"','dd/mm/yyyy'),"
			       +"to_date('"+praja.getDateOfGrounding()+"','dd/mm/yyyy'),"
			       +"to_date('"+praja.getDateOfComple()+"','dd/mm/yyyy'),"
			       +"'"+praja.getExpendetureUpTotheMonth()+"',"
			       +"'"+praja.getExpendetureDuringMon()+"',"
			       +"'"+praja.getExpendetureToBeIncurred()+"',"
			       +"'"+praja.getPhysycalStageOFWork()+"',"
			       +"'"+praja.getRemarks()+"','"+praja.getSanctionAt()+"')";
				//System.out.println("Query is:"+query1) ;  
				String query2="";
               boolean status1=dao.getHabExistence(praja.getHabCode()); 
               if(status1)
               {
                	/* query1="update RWS_PRAJAPADAM_TBL set " +
               	 		"WORK_NAME='"+praja.getWorkName()+"'," +
               	 		"ESTIMATE_COST='"+praja.getEstCost()+"'," +
               	 		"PROGRAMME_CODE='"+praja.getProgramme()+"'," +
               	 	    "SUBPROGRAMME_CODE='"+praja.getSubProgramme()+"'," +
               	 	    "ADMN_SANC_NO='"+praja.getAdminSancRefNo()+"'," +
               	 	    "ADMN_SANC_DATE=to_date('"+praja.getAdminSancDate()+"','dd/mm/yyyy')," +
               	 	    "GROUND_DATE=to_date('"+praja.getDateOfGrounding()+"','dd/mm/yyyy')," +
               	 	    "COMPLETION_DATE=to_date('"+praja.getDateOfComple()+"','dd/mm/yyyy')," +
               	 	    "EXPENDITURE_INCURRED='"+praja.getExpendetureInncu()+"'," +
               	 	    "PHY_STAGE_OF_WORK='"+praja.getPhysycalStageOFWork()+"'," +
               	 	    "remarks='"+praja.getRemarks()+"' where hab_code='"+praja.getHabCode()+"'";*/
               	 
               	 //System.out.println("Query is:"+query1) ;
               	query2="update  RWS_PRAJAPADAM_EXIST_SCH_TBL set EXIST_CPWS=Decode('"+praja.getCpws()+"','on','Y')" +
               			",EXIST_PWS=DECODE('"+praja.getPws()+"','on','Y')," +
		 		"EXIST_DIRECT_PUMPING=DECODE('"+praja.getDirectPump()+"','on','Y')" +
		 		", EXIST_BOREWELLS=DECODE('"+praja.getBoreWells()+"','on','Y')" +
		 		",EXIST_OTHERS=DECODE('"+praja.getOthers()+"','on','Y')" +
		 		",OTHER_DETAILS='"+praja.getOthersValue()+"'  where hab_code='"+praja.getHabCode()+"'"  ;
		 		 
           	 //System.out.println("Query is:"+query2) ;  
		 	 
               }
               else
               {
			     query2="INSERT INTO RWS_PRAJAPADAM_EXIST_SCH_TBL (HAB_CODE , EXIST_CPWS,EXIST_PWS," +
			 		"EXIST_DIRECT_PUMPING, EXIST_BOREWELLS,EXIST_OTHERS,OTHER_DETAILS)VALUES("  
			 		+"'"+praja.getHabCode()+"',"
			 		+"Decode('"+praja.getCpws()+"','on','Y'),"
			 		+"DECODE('"+praja.getPws()+"','on','Y'),"
			 		+"DECODE('"+praja.getDirectPump()+"','on','Y'),"
			 		+"DECODE('"+praja.getBoreWells()+"','on','Y'),"
			 		+"DECODE('"+praja.getOthers()+"','on','Y'),"
			 		+"'"+praja.getOthersValue()+"')";
				 //System.out.println("Query is:"+query2) ;  
               }
			 boolean status=dao.insertPrajaPadamDetails(query1,query2);
			 if(status)
			 {
			 	request.setAttribute("message","Saved Successfully");
			 	praja.setWorkName("");
			 	praja.setEstCost("");
			 	praja.setAdminSancRefNo("");
			 	praja.setAdminSancDate("");
			 	praja.setDateOfComple("");
			 	praja.setDateOfGrounding("");
			 	praja.setPhysycalStageOFWork("");
			 	praja.setRemarks("");
			 }
			 else
			 {
			 	request.setAttribute("message","Failed to save");
			 }
			    mode="data";
			 //System.out.println("Query is:"+query2) ;  
			}
			
			
			if(mode.equalsIgnoreCase("delete"))
			{
				//System.out.println("in delete mode"+request.getParameter("workId"));
				ProposalDAO dao=new ProposalDAO(getDataSource(request));
				boolean flag=dao.deletePrajapadamDetails(request.getParameter("workId"),request.getParameter("habCode"));
				if(flag)
				{
					request.setAttribute("message","Deleted success fully");
					praja.setDistrictCode(request.getParameter("districtCode"));
					praja.setMandalCode(request.getParameter("mandalCode"));
					praja.setHabCode(request.getParameter("habCode"));
					praja.setWorkId("");
				}
				else
				{
					request.setAttribute("message","Failed to delete");
				}
				mode="view";
			}
			if(mode.equalsIgnoreCase("view"))
			{
				ProposalDAO dao=new ProposalDAO(getDataSource(request));
			    prajaPadamList=dao.getPrajapadamList(praja.getDistrictCode(),praja.getMandalCode(),praja.getHabCode(),praja.getWorkId());
			    if(prajaPadamList.size()>=1)
			    {
			    	request.setAttribute("prajapadamList",prajaPadamList);
			    }
			}
			
			if(mode.equalsIgnoreCase("edit"))
			{
				praja.setDistrictCode(request.getParameter("districtCode"));
				praja.setMandalCode(request.getParameter("mandalCode"));
				praja.setHabCode(request.getParameter("habCode"));
				praja.setWorkId(request.getParameter("workId"));
				ProposalDAO dao=new ProposalDAO(getDataSource(request));
			    prajaPadamList=dao.getPrajapadamList(praja.getDistrictCode(),praja.getMandalCode(),praja.getHabCode(),praja.getWorkId());
			    praja.setPrajaBean((Rws_Prajapadam_Bean)prajaPadamList.get(0));
	 	    }
			
			if(mode.equalsIgnoreCase("editSave"))
			{
				
				praja.setDistrictCode(request.getParameter("districtCode"));
				praja.setMandalCode(request.getParameter("mandalCode"));
				praja.setHabCode(request.getParameter("habCode"));
				praja.setWorkId(request.getParameter("workId"));
				
				String query1="update RWS_PRAJAPADAM_TBL set " +
       	 		"WORK_NAME='"+praja.getWorkName()+"'," +
       	 		"ESTIMATE_COST='"+praja.getEstCost()+"'," +
       	 	    "ADMN_SANC_NO='"+praja.getAdminSancRefNo()+"'," +
       	 	    "ADMN_SANC_DATE=to_date('"+praja.getAdminSancDate()+"','dd/mm/yyyy')," +
       	 	    "GROUND_DATE=to_date('"+praja.getDateOfGrounding()+"','dd/mm/yyyy')," +
       	 	    "COMPLETION_DATE=to_date('"+praja.getDateOfComple()+"','dd/mm/yyyy')," +
       	 	    "EXP_UPTO_THE_PRE_MONTH ='"+praja.getExpendetureUpTotheMonth()+"'," +
       	 	    "EXP_TO_BE_INCURRED='"+praja.getExpendetureToBeIncurred()+"'," +
       	        "EXP_DUR_THE_MONTH ='"+praja.getExpendetureDuringMon()+"'," +
       	 	    "PHY_STAGE_OF_WORK='"+praja.getPhysycalStageOFWork()+"'," +
       	 	    "remarks='"+praja.getRemarks()+"'," +
       	 	    "SANCTIONED_AT='"+praja.getSanctionAt()+"' where hab_code='"+praja.getHabCode()+"' and work_Id='"+praja.getWorkId()+"'";
				//System.out.println("Query is"+query1);
				
				String query2="update  RWS_PRAJAPADAM_EXIST_SCH_TBL set EXIST_CPWS=Decode('"+praja.getCpws()+"','on','Y')" +
       			              ",EXIST_PWS=DECODE('"+praja.getPws()+"','on','Y')," +
 		                     "EXIST_DIRECT_PUMPING=DECODE('"+praja.getDirectPump()+"','on','Y')" +
 		                     ", EXIST_BOREWELLS=DECODE('"+praja.getBoreWells()+"','on','Y')" +
 		                     ",EXIST_OTHERS=DECODE('"+praja.getOthers()+"','on','Y')" +
 		                     ",OTHER_DETAILS='"+praja.getOthersValue()+"'  where hab_code='"+praja.getHabCode()+"'"  ;
				 ProposalDAO dao=new ProposalDAO(getDataSource(request));
				 boolean status=dao.insertPrajaPadamDetails(query1,query2);
				 if(status)
				 {
				 	request.setAttribute("message","Saved Successfully");
				 	
				 }
				 else
				 {
				 	request.setAttribute("message","Failed to save");
				 }
				    praja.setWorkName("");
				 	praja.setEstCost("");
				 	praja.setAdminSancRefNo("");
				 	praja.setAdminSancDate("");
				 	praja.setDateOfComple("");
				 	praja.setDateOfGrounding("");
				 	praja.setPhysycalStageOFWork("");
					praja.setExpendetureDuringMon("");
					praja.setExpendetureToBeIncurred("");
					praja.setExpendetureUpTotheMonth("");
				 	praja.setRemarks("");
				    mode="data";
				 //System.out.println("Query is:"+query2) ;  
				
	 	       }
			
			if(mode.equals("refresProg"))
			{
				 programs=commons.getProgrammes();
		 		 session.setAttribute("programs",programs);
			}
			if(mode.equals("addProg"))
			{
				  String programme=praja.getProgramme();
				  ProposalDAO dao=new ProposalDAO(getDataSource(request));
				  boolean status=dao.insertProgrammes(programme);
				  if(status==true)
				  {
				  	request.setAttribute("message","Programme Added Successfully");
				  }
				  else
				  {
				  	request.setAttribute("message","Failed To Add A Programme");
				  }
	 		}
		}
		catch(Exception e)
		{
		 //System.out.println("Exception "+e);
		}
		return mapping.findForward(mode);
	}
}
