
package nic.watersoft.masters;

import java.util.List;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
//import nic.watersoft.reports.rws_asset_CheckList_Bean;
//import nic.watersoft.reports.rws_asset_CheckList_Data;
//import nic.watersoft.reports.rws_asset_CheckList_FormBean;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_EmployeeEntryAct_frm extends Action
{
	ArrayList heads=new ArrayList();
	ArrayList circlecodes=new ArrayList();
	ArrayList divcodes=new ArrayList();
	ArrayList subdivcodes=new ArrayList();
	ArrayList addqualcodes=new ArrayList();
	ArrayList addqualcodes2=new ArrayList();
	ArrayList addqualcodes1=new ArrayList();
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	ArrayList zonecodes=new ArrayList();
	ArrayList desgns=new ArrayList();
	ArrayList SocialCodes=new ArrayList();
	ArrayList check=new ArrayList();
	ArrayList smandals=new ArrayList();
	ArrayList sectorcode=new ArrayList(200);
	
	ArrayList castes=new ArrayList();
	ArrayList religions=new ArrayList();
	ArrayList qualcodes=new ArrayList();
	ArrayList modes=new ArrayList();
	ArrayList catcodes=new ArrayList();
	ArrayList workSpecs=new ArrayList();
	
	//testing code for Ajax
	 ArrayList circles=null;
	 ArrayList divisions=null;
	 ArrayList subdivisions=null;
	 ArrayList counts=null;
	 String mode=null;
		
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int ans[] = null;		
		ArrayList desgns=new ArrayList();
		ArrayList posts=new ArrayList();
	    ArrayList districts=new ArrayList();
		ArrayList mandals=new  ArrayList();
		ArrayList zonecodes=new ArrayList();
		ArrayList designations=new ArrayList();		
		String payscale=null;
		ArrayList addqualcodes1=new ArrayList();
		ArrayList fromdates=new ArrayList();
		ArrayList todates=new ArrayList();	
		String message=null;
		String displaymess=null;
		ArrayList emps=null;
		ArrayList empsReport=null;		
		EmpMaster empMaster = new EmpMaster();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		EmpForm frm=(EmpForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");	
		if(user==null)
		  return mapping.findForward("expire");	
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		if(mode!=null && mode.equalsIgnoreCase("data"))
		{
		 try 
		   {
		 	   	workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
				session.setAttribute("workSpecs",workSpecs);
				desgns=EmpMasterData.getDesgns(frm.getDesig());
				session.setAttribute("desgns",desgns);
				
				if(request.getParameter("desgnCode")!=null)
				{
				payscale = EmpMasterData.getPayScales(request.getParameter("desgnCode"),getDataSource(request));
				}
				request.setAttribute("payscale",payscale);								
				modes=EmpMasterData.getModeOfAppt(getDataSource(request));
				session.setAttribute("modes",modes);				
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);									
				if(request.getParameter("ndist")!=null)
				{
					if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
					{				
					mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));					
					}		
				}
				session.setAttribute("mandals",mandals);			
										
				castes=EmpMasterData.getCastes();
				session.setAttribute("castes",castes);
				
				religions=EmpMasterData.getReligions();
				session.setAttribute("religions",religions);
				
				zonecodes=EmpMasterData.getZones();
				session.setAttribute("zonecodes",zonecodes);
				
				catcodes=EmpMasterData.getCatogs(getDataSource(request));
				session.setAttribute("catcodes",catcodes);
							
				qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
				session.setAttribute("qualcodes",qualcodes);
				if(request.getParameter("addqual1")!=null)
				{
					if(!(request.getParameter("addqual1")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual1"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes1",addqualcodes1);
				if(request.getParameter("addqual2")!=null)
				{
					if(!(request.getParameter("addqual2")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual2"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes2",addqualcodes2);
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				String ccode=frm.getCircleOfficeCode();
				String divcode=frm.getDivisionOfficeCode();
				String subcode=frm.getSubdivisionOfficeCode();
				
				ArrayList circles = rwsOffices.getCircles();
				session.setAttribute("circles", circles);
				
				ArrayList divisions = rwsOffices.getDivisions1(ccode);
				session.setAttribute("divisions", divisions);
				
				ArrayList subdivisions = rwsOffices.getSubDivisions1(ccode,divcode);
				session.setAttribute("subdivisions", subdivisions);
				if(request.getParameter("sdoc")!=null)
				{
					if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
					{
						request.setAttribute("hof",EmpMasterData.getEmployee("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
					}
				}
				session.setAttribute("subdivcodes",subdivcodes);
				if(request.getParameter("roc")!=null)
				{
					request.setAttribute("roc",request.getParameter("roc"));
				}
			
				if(request.getParameter("spouseworkdist")!=null)
				{
					if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
					{								
						smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));						
					}
				}
				session.setAttribute("smandals",smandals);
				if(request.getParameter("empcode")!=null)
				{
					request.setAttribute("empcode",request.getParameter("empcode"));
				}
				if(request.getParameter("surname")!=null)
				{
					request.setAttribute("surname",request.getParameter("surname"));
				}
				if(request.getParameter("empname")!=null)
				{
					request.setAttribute("empname",request.getParameter("empname"));
				}
				if(request.getParameter("relation")!=null)
				{
					request.setAttribute("relation",request.getParameter("relation"));
				}
				
				if(request.getParameter("dob")!=null)
				{
					request.setAttribute("dob",request.getParameter("dob"));
				}
				if(request.getParameter("appOrderRef")!=null)
				{
					request.setAttribute("appOrderRef",request.getParameter("appOrderRef"));
				}
				if(request.getParameter("appointdate")!=null)
				{
					request.setAttribute("appointdate",request.getParameter("appointdate"));
				}
				if(request.getParameter("doj")!=null)
				{
					request.setAttribute("doj",request.getParameter("doj"));
				}
				if(request.getParameter("currentpostdate")!=null)
				{
					request.setAttribute("currentpostdate",request.getParameter("currentpostdate"));
				}
													
				if(request.getParameter("updatedate")!=null)
				{
					request.setAttribute("updatedate",request.getParameter("updatedate"));
				}
				if(request.getParameter("depu")!=null)
				{
					request.setAttribute("depu",request.getParameter("depu"));
				}
				if(request.getParameter("depudept")!=null)
				{
					request.setAttribute("depudept",request.getParameter("depudept"));
				}
				if(request.getParameter("seniority")!=null)
				{
					request.setAttribute("seniority",request.getParameter("seniority"));
					
				}
				if(request.getParameter("DATE_OF_LEAVE")!=null)
				{
					request.setAttribute("leavedate",request.getParameter("leavedate"));
				}
				if(request.getParameter("LEAVE_SUSPENDED")!=null)
				{
					request.setAttribute("leavesuspend",request.getParameter("leavesuspend"));
				}				
		}
				catch(Exception e)
				{
					Debug.println("the error in empname:"+e);
				}

				}
		
		
		if(mode.equalsIgnoreCase("UpdateData"))
		{
			try
			{					
				posts=EmpMasterData.getEmps(getDataSource(request));
				session.setAttribute("posts",posts);
			
				workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
				session.setAttribute("workSpecs",workSpecs);
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
				session.setAttribute("desgns",desgns);
				
				if(request.getParameter("desgnCode")!=null)
				{
				payscale = EmpMasterData.getPayScales(request.getParameter("desgnCode"),getDataSource(request));
				}
				request.setAttribute("payscale",payscale);
								
				modes=EmpMasterData.getModeOfAppt(getDataSource(request));
				session.setAttribute("modes",modes);
				
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				if(request.getParameter("ndist")!=null)
				{
					if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
					{
						mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));
					}
					
				}
				session.setAttribute("mandals",mandals);
								
				castes=EmpMasterData.getCastes();
				session.setAttribute("castes",castes);
				
				religions=EmpMasterData.getReligions();
				session.setAttribute("religions",religions);
				
				zonecodes=EmpMasterData.getZones();
				session.setAttribute("zonecodes",zonecodes);
				
				catcodes=EmpMasterData.getCatogs(getDataSource(request));
				session.setAttribute("catcodes",catcodes);
							
				qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
				session.setAttribute("qualcodes",qualcodes);
													
				if(request.getParameter("addqual1")!=null)
				{
					if(!(request.getParameter("addqual1")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual1"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes1",addqualcodes1);
				if(request.getParameter("addqual2")!=null)
				{
					if(!(request.getParameter("addqual2")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual2"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes2",addqualcodes2);
				
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				if(request.getParameter("hoc")!=null)
				{
					if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
					{
						circlecodes=rwsOffices.getCircles("1");
						
					}
				}
				session.setAttribute("circlecodes",circlecodes);
				
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
					{
						divcodes = rwsOffices.getDivisions("1",request.getParameter("coc"));
						
					}
				}
				session.setAttribute("divcodes",divcodes);
				
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
					{
						subdivcodes = rwsOffices.getSubdivisions("1",request.getParameter("coc"),request.getParameter("doc"));
					}
				}
				
				if(request.getParameter("sdoc")!=null)
				{
					if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
					{
						request.setAttribute("hof",EmpMasterData.getEmployee("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
					}
				}
				session.setAttribute("subdivcodes",subdivcodes);
										
				if(request.getParameter("empcode")!=null)
				{
					
					request.setAttribute("empcode",request.getParameter("empcode"));
				}
				
				if(request.getParameter("surname")!=null)
				{
					request.setAttribute("surname",request.getParameter("surname"));
				}
				if(request.getParameter("empname")!=null)
				{
					request.setAttribute("empname",request.getParameter("empname"));
				}
				
				if(request.getParameter("relation")!=null)
				{
					request.setAttribute("relation",request.getParameter("relation"));
				}
				
				if(request.getParameter("dob")!=null)
				{
					request.setAttribute("dob",request.getParameter("dob"));
				}
			
				if(request.getParameter("appOrderRef")!=null)
				{
					request.setAttribute("appOrderRef",request.getParameter("appOrderRef"));
				}
				if(request.getParameter("appointdate")!=null)
				{
					request.setAttribute("appointdate",request.getParameter("appointdate"));
				}
				if(request.getParameter("doj")!=null)
				{
					request.setAttribute("doj",request.getParameter("doj"));
				}
				if(request.getParameter("currentpostdate")!=null)
				{
					request.setAttribute("currentpostdate",request.getParameter("currentpostdate"));
				}
				if(request.getParameter("roc")!=null)
				{
					request.setAttribute("roc",request.getParameter("roc"));
				}
													
				if(request.getParameter("updatedate")!=null)
				{
					request.setAttribute("updatedate",request.getParameter("updatedate"));
				}
				if(request.getParameter("depu")!=null)
				{
					request.setAttribute("depu",request.getParameter("depu"));
				}
				if(request.getParameter("depudept")!=null)
				{
					request.setAttribute("depudept",request.getParameter("depudept"));
				}
				if(request.getParameter("seniority")!=null)
				{
					request.setAttribute("seniority",request.getParameter("seniority"));
					
				}
				if(request.getParameter("DATE_OF_LEAVE")!=null)
				{
					request.setAttribute("leavedate",request.getParameter("leavedate"));
				}
				if(request.getParameter("LEAVE_SUSPENDED")!=null)
				{
					request.setAttribute("leavesuspend",request.getParameter("leavesuspend"));
				}
				
				if(request.getParameter("spouseworkdist")!=null)
				{
					if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
					{								
						smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
					}					
				}
				session.setAttribute("smandals",smandals);				
		}
			catch(Exception e)
			{
				Debug.println("the error in Mode UpdateData"+e);
			}
			}	
		if(mode.equalsIgnoreCase("checklist"))
		{
			try
			{
			heads = rwsOffices.getHeads();
			session.setAttribute("heads",heads);
			
			if(request.getParameter("hoc")!=null )
			{
				if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
				{
					circlecodes=rwsOffices.getCircles4Employee(request.getParameter("hoc"));					
				}
			}
			session.setAttribute("circlecodes",circlecodes);
			
			if(request.getParameter("coc")!=null)
			{
				if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions4Employee(request.getParameter("hoc"),request.getParameter("coc"));
				}
			}
			session.setAttribute("divcodes",divcodes);
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions4Employee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					
				}
			}
			
			if(request.getParameter("sdoc")!=null)
			{
				if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
				{
					request.setAttribute("hof",EmpMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
				}
			}
			session.setAttribute("subdivcodes",subdivcodes);
			
			if(request.getParameter("selection")!=null)
			{
				request.setAttribute("selection",request.getParameter("selection"));
			}
			
			fromdates=EmpMasterData.getFromDates1(getDataSource(request));
			session.setAttribute("fromdates",fromdates);
	
			if(request.getParameter("toDate")!=null)
			{
			todates=EmpMasterData.getToDates1(request.getParameter("fromDate"),getDataSource(request));
			session.setAttribute("todates",todates);
			}
				
			
		}	
		catch(Exception e)
		{
			Debug.println("error in employee checklist"+e);
		}
	}			

		if(mode.equalsIgnoreCase("dates"))
		{
			try
				{	
					 if(request.getParameter("fromDate")!=null)
					{
				    String frdt=request.getParameter("fromDate");	
					request.setAttribute("fromdates",EmpMasterData.getFromDates1(getDataSource(request)));
					frm.setFromDate(frdt);			
					
					request.setAttribute("todates",EmpMasterData.getToDates1(frdt,getDataSource(request)));
					mode="data1";
					 /*frm.setFromDate("fromDate"); */
					/*
					 ArrayList toDate=new ArrayList();
					 EmpMaster=(EmpMaster)toDate.get(0);
					 frm.setToDate(empMaster.getToDate()); */
					}
					else	   
					{ 
				
					request.setAttribute("fromdates",EmpMasterData.getFromDates1(getDataSource(request)));
					/*
					 ArrayList fromDate=new ArrayList();
					 EmpMaster = (EmpMaster)fromDate.get(0);
					 frm.setFromDate(empMaster.getFromDate());
					 */
				
					}
				}catch(Exception e)
				{
					Debug.println("Error in rws_UserAuditEntryAct_frm in data mode:"+e);
				}
		}//close dates
		
		if(mode.equalsIgnoreCase("viewCheckList"))
		{
			try
			{				
				emps=EmpMasterData.getEmps1(frm.getHoc(),frm.getCoc(),frm.getDoc(),frm.getSdoc(),request.getParameter("fromDate"),request.getParameter("toDate"),getDataSource(request));
				session.setAttribute("emps",emps);
			}
			catch(Exception e)
			{
				Debug.println("The error in Emp View is "+e);
			}
				
		}
		
		if(mode.equalsIgnoreCase("get1"))
		{
			try
			{
				if(request.getParameter("diststudied4")!=null)	
				{
					frm.setDiststudied4(request.getParameter("diststudied4"));
				}
				if(request.getParameter("diststudied5")!=null)	
				{
					frm.setDiststudied5(request.getParameter("diststudied5"));
					
				}
				if(request.getParameter("diststudied6")!=null)	
				{
					frm.setDiststudied6(request.getParameter("diststudied6"));
					
				}
				if(request.getParameter("diststudied7")!=null)	
				{
					frm.setDiststudied7(request.getParameter("diststudied7"));
					
				}
				if(request.getParameter("diststudied8")!=null)	
				{
					frm.setDiststudied8(request.getParameter("diststudied8"));
					
				}
				if(request.getParameter("diststudied9")!=null)	
				{
					frm.setDiststudied9(request.getParameter("diststudied9"));
					
				}
				if(request.getParameter("diststudied10")!=null)	
				{
					frm.setDiststudied10(request.getParameter("diststudied10"));
					
				}
				if(request.getParameter("localdist")!=null)	
				{
					frm.setLocaldist(request.getParameter("localdist"));
				}
				}
			catch(Exception e)
			{
				Debug.println("the error in Emp get1 is "+e);
			}
		}
		
	 if(mode.equalsIgnoreCase("get2"))
	 {
	 	try
		{
	 	districts = rwsOffices.getDistricts1();
		session.setAttribute("districts",districts);
		//Debug.println("Native Mandal  "+request.getParameter("nmand"));
	 	if(request.getParameter("ndist")!=null)
		{	 		
			if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
			{
				mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));
				frm.setDiststudied4(request.getParameter("ndist"));
				frm.setDiststudied5(request.getParameter("ndist"));
				frm.setDiststudied6(request.getParameter("ndist"));
				frm.setDiststudied7(request.getParameter("ndist"));
				frm.setDiststudied8(request.getParameter("ndist"));
				frm.setDiststudied9(request.getParameter("ndist"));
				frm.setDiststudied10(request.getParameter("ndist"));
				frm.setLocaldist(request.getParameter("ndist"));
			}
		}
	 	session.setAttribute("mandals",mandals);
	 	if(request.getParameter("spouseworkdist")!=null)
		{
			//Debug.println("spouse work dist "+request.getParameter("spouseworkdist"));
			if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
			{								
				smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
			}
			
		}
		session.setAttribute("smandals",smandals);
	 //	Debug.println("Mandals size after "+mandals.size());
		}
	 	catch(Exception e)
		{
			Debug.println("the error in Emp get2 is "+e);
		}
	 }
	
	 	
	 if(mode.equalsIgnoreCase("OfficeDetails") || mode.equalsIgnoreCase("OfficeDetailsEdit"))
	 {
	 //	Debug.println("Mode entred  ="+mode);
	 	try
		{
	 		
		heads = rwsOffices.getHeads();
		session.setAttribute("heads",heads);
		if(request.getParameter("hoc")!=null)
		{
			if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
			{
				circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
			}
		}
		session.setAttribute("circlecodes",circlecodes);
		
		if(request.getParameter("coc")!=null)
		{
			if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
			{
				divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
				//Debug.println(request.getParameter("coc"));
			}
		}
		session.setAttribute("divcodes",divcodes);
		
		if(request.getParameter("doc")!=null)
		{
			if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
			{
				subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
			}
		}
		
		if(request.getParameter("sdoc")!=null)
		{
			if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
			{
				request.setAttribute("hof",EmpMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
			}
		}
		session.setAttribute("subdivcodes",subdivcodes);
		if(request.getParameter("roc")!=null)
		{
			request.setAttribute("roc",request.getParameter("roc"));
		}
	
		if(request.getParameter("spouseworkdist")!=null)
		{
			//Debug.println("spouse work dist:=  "+request.getParameter("spouseworkdist"));
			if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
			{								
				smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
				//Debug.println("Mandal size in spouse "+mandals.size());
			}
		}
		session.setAttribute("smandals",smandals);
		
		}catch(Exception e){
			Debug.println("Error in the getOfficeDetails "+e);
		}
	 	
	 }
	 
	 
	 
	//for Edit Emp_Entry_frm
		
		if(mode.equalsIgnoreCase("getData1"))
		{
		//	Debug.println("Mode entred  ="+mode);
			try
			{
				if(request.getParameter("diststudied4")!=null)	
				{
					frm.setDiststudied4(request.getParameter("diststudied4"));
				}
				if(request.getParameter("diststudied5")!=null)	
				{
					frm.setDiststudied5(request.getParameter("diststudied5"));
					
				}
				if(request.getParameter("diststudied6")!=null)	
				{
					frm.setDiststudied6(request.getParameter("diststudied6"));
					
				}
				if(request.getParameter("diststudied7")!=null)	
				{
					frm.setDiststudied7(request.getParameter("diststudied7"));
					
				}
				if(request.getParameter("diststudied8")!=null)	
				{
					frm.setDiststudied8(request.getParameter("diststudied8"));
					
				}
				if(request.getParameter("diststudied9")!=null)	
				{
					frm.setDiststudied9(request.getParameter("diststudied9"));
					
				}
				if(request.getParameter("diststudied10")!=null)	
				{
					frm.setDiststudied10(request.getParameter("diststudied10"));
					
				}
				if(request.getParameter("localdist")!=null)	
				{
					frm.setLocaldist(request.getParameter("localdist"));
				}
				}
			catch(Exception e)
			{
				Debug.println("the error in Emp get1 is "+e);
			}
		}
		
	 if(mode.equalsIgnoreCase("getData2"))
	 {
	 //	Debug.println("Mode entred  ="+mode);
	 	try
		{
	 	districts = rwsOffices.getDistricts1();
		session.setAttribute("districts",districts);
	 	if(request.getParameter("ndist")!=null)
		{
			if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
			{
				mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));
				frm.setDiststudied4(request.getParameter("ndist"));
				frm.setDiststudied5(request.getParameter("ndist"));
				frm.setDiststudied6(request.getParameter("ndist"));
				frm.setDiststudied7(request.getParameter("ndist"));
				frm.setDiststudied8(request.getParameter("ndist"));
				frm.setDiststudied9(request.getParameter("ndist"));
				frm.setDiststudied10(request.getParameter("ndist"));
				frm.setLocaldist(request.getParameter("ndist"));
			}
			session.setAttribute("mandals",mandals);
		}
		if(request.getParameter("spouseworkdist")!=null)
		{
			//Debug.println("spouse work dist "+request.getParameter("spouseworkdist"));
			if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
			{								
				smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
			}
			
		}
		session.setAttribute("smandals",smandals);
	 //	Debug.println("Mandals size after "+mandals.size());
		}
	 	catch(Exception e)
		{
			Debug.println("the error in Emp get2 is "+e);
		}
	 }
	
	 
		if(mode.equalsIgnoreCase("view"))
		{			
			try{	
				emps=EmpMasterData.getEmps(frm.getHoc(),frm.getCircleOfficeCode(),frm.getDivisionOfficeCode(),frm.getSubdivisionOfficeCode(),getDataSource(request));
				session.setAttribute("emps",emps);				
			}
			catch(Exception e){
				Debug.println("The error in Emp View is "+e);
			}
		}
				
		if(mode.equalsIgnoreCase("ViewDetails"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
				emps=EmpMasterData.getEmpsView(getDataSource(request));
				request.setAttribute("emps",emps);
			}
			catch(Exception e)
			{
				Debug.println("The error in getEmps ViewDetails "+e);
			}
		}		
		
		//code Added 
		if(mode.equalsIgnoreCase("getSubDivisions"))
		{
		//	Debug.println("Mode entred  ="+mode);
			try
			{
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
				}
			}
			session.setAttribute("subdivcodes",subdivcodes);
			}
			catch(Exception e){
			Debug.println("the Subdivisions of View "+e);	
			}
		}
		
		if(mode.equalsIgnoreCase("getDivisions"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
					{
						divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
					}
				}
				session.setAttribute("divcodes",divcodes);
			}
			catch(Exception e){
			Debug.println("the Subdivisions of View "+e);	
			}
		}
		
		
		
		if(mode.equalsIgnoreCase("getCircles"))
		{
		//	Debug.println("Mode entred  ="+mode);
			try
			{
				if(request.getParameter("hoc")!=null)
				{
					if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
					{
						circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					}
				}
				session.setAttribute("circlecodes",circlecodes);
			}
			catch(Exception e){
				Debug.println("the Subdivisions of View "+e);	
				}
		}
			
		if(mode.equalsIgnoreCase("getDistricts"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				if(request.getParameter("ndist")!=null)
				{
					if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
					{
						mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));

					}
				}
				session.setAttribute("mandals",mandals);
				//Debug.println("the mandals in execute()"+mandals);
			}
			catch(Exception e)
			{
				Debug.println("in getDistricts"+e);
			}
		}
		
		if(mode.equalsIgnoreCase("getDesigs"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
				{
					desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
					session.setAttribute("desgns",desgns);
				}
				else
					session.setAttribute("desgns",new ArrayList());
	    
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
				{
					desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
					session.setAttribute("desgns1",desgns);
				}
				else
					session.setAttribute("desgns1",new ArrayList());
			}
			catch(Exception e)
			{
				Debug.println("Error in getDesigns"+e);
			}
		}
		
		
		//code modified by sridhar
		if(mode.equalsIgnoreCase("getDesignations"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
				session.setAttribute("desgns",desgns);
			}
			catch(Exception e)
			{
				Debug.println("Error in getDesignations"+e);
			}
		}
	
		if(mode.equalsIgnoreCase("getDesignationsEdit"))
		{
			//Debug.println("Mode entred  ="+mode);
			try
			{
			desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
			session.setAttribute("desgns",desgns);
			}
			catch(Exception e)
			{
				Debug.println("Error in getDesignations"+e);
			}
		}
		
		if(mode.equalsIgnoreCase("selectedOptions"))
		{
			//Debug.println("Mode entred  ="+mode);
			try{
			heads = rwsOffices.getHeads();
			request.setAttribute("heads",heads);
			//code for Ajax testing
		
			String optionSelected = request.getParameter("optionSelected");
		//	Debug.println("the value of selectedOptions"+optionSelected);
		    //Check of het soortId wel correct is
			if (request.getParameter("optionSelected")==null)
			{
			   // Debug.println("No selected option supplied");
			    //PrintWriter out = response.getWriter();
			    //out.print("803");
			}
			else
			{
			List options =rwsOffices.getCircles(request.getParameter("hoc"));// getSecondOptions(selectedOption);
			//Make a String representation where each option is seperated by '||' and a valua and a label by ';'
			//String outLine = makeOutputString(options);
			//out.print(outLine); 
			}			
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					Debug.println(request.getParameter("Doc"));
				}
			}

			if(request.getParameter("sdoc")!=null)
			{
				if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
				{
					request.setAttribute("hof",EmpMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
				}
			}
			request.setAttribute("subdivcodes",subdivcodes);
					
		    if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("01"))
			{
				designations=EmpMasterData.getDesgns1(getDataSource(request));
				session.setAttribute("designations",designations);
			}
			else if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("02"))
			{
				designations=EmpMasterData.getZones1(getDataSource(request));
				session.setAttribute("designations",designations);
			}
			/*else	session.setAttribute("designations",new ArrayList());*/
		}	
		catch(Exception e)
		{
			Debug.println("Error in selectedOptions");
		}    
			//end of code for Ajax
	}		
		if(mode.equalsIgnoreCase("getCircles1"))
		{
			try
			{
				circlecodes=rwsOffices.getCircles();
				session.setAttribute("circlecodes",circlecodes);
			}
			catch(Exception e){
				Debug.println("the circles of Action "+e);	
				}
		}
		
		
		// code added for Ajax implementation
		
		if(mode.equalsIgnoreCase("cir"))
	     {
				EmpForm check=(EmpForm)form;
	     	try
			{	      
	 	     session.setAttribute("cCode",check.getOfficeCode());	 	  
	 	     String div= RwsOffices.getOffices(getDataSource(request),request.getParameter("officeCode"));
	 	     response.setContentType("text/html/XML");
	 	     java.util.Date date=new java.util.Date();
             long now=date.getTime();
             mode=null;
             response.setHeader("Expires",(now-(1000*60*60))+"");
	 	     java.io.PrintWriter out=response.getWriter();
	 	     out.println(div);
	 	     out.flush();
	 	     
	     	}
	     	catch(Exception e){Debug.println("in geting Offices"+e);}
	     }
	  
		  if(mode.equalsIgnoreCase("div"))
		  {
		  
		  	EmpForm check=(EmpForm)form;
		     	try
				{		    
		 	     session.setAttribute("cCode",check.getCircleCode());		 	   
		 	     String div= RwsOffices.getDivisions(getDataSource(request),"1",request.getParameter("circleCode"));
		 	        response.setContentType("text/html/XML");
		 	     java.util.Date date=new java.util.Date();
	             long now=date.getTime();
	             mode=null;
	             response.setHeader("Expires",(now-(1000*60*60))+"");
		 	     java.io.PrintWriter out=response.getWriter();
		 	     out.println(div);
		 	     out.flush();
		 	     
		     	}
		     	catch(Exception e){Debug.println("in geting divisoins"+e);}
		     }
		  
		  
		  if(mode.equalsIgnoreCase("subDiv"))
		     {
		  	 try
			  {
		       String subdiv=RwsOffices.getSubDivisions(getDataSource(request),"1",request.getParameter("circleCode"),request.getParameter("divisionCode"));
			    response.setContentType("text/html/XML");
			   java.util.Date date=new java.util.Date();
	 	       long now=date.getTime();
	 	       mode=null;
	 	       response.setHeader("Expires",(now-(1000*60*60))+"");
			   java.io.PrintWriter out=response.getWriter();
			   out.println(subdiv);
			   out.flush();
		     }
		     catch(Exception e)
		     {
		    	Debug.println("in subDiv of Action"+e);
			 }
		  }
		  //end of code
			
		if(mode.equalsIgnoreCase("StatusForms"))
		{
			try
			{
			heads = rwsOffices.getHeads();
			request.setAttribute("heads",heads);
				
			if(request.getParameter("sector")==null)
			{
				sectorcode=rwsOffices.getHeads();
				request.setAttribute("sectorcode",sectorcode);
			}
			else if(request.getParameter("sector")!=null)
			{
				if(!(request.getParameter("sector")).equals("0"))
				{
							sectorcode=rwsOffices.getHeads();
				}
			}		
			request.setAttribute("sectorcode",sectorcode);
		
			if(request.getParameter("hoc")!=null )//&& request.getParameter("hoc")=="1"
			{
				if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
				{
					circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					}
			}
			request.setAttribute("circlecodes",circlecodes);
			
			if(request.getParameter("coc")!=null)
			{
				if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
				
				}
			}
			request.setAttribute("divcodes",divcodes);
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					
				}
			}
			
			if(request.getParameter("sdoc")!=null)
			{
				if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
				{
					request.setAttribute("hof",EmpMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));
					
				}
			}
			request.setAttribute("subdivcodes",subdivcodes);		
		    if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("01"))
			{
				designations=EmpMasterData.getDesgns1(getDataSource(request));
				session.setAttribute("designations",designations);
			}
			else if(request.getParameter("detailedWise")!=null && request.getParameter("detailedWise").equalsIgnoreCase("02"))
			{
				designations=EmpMasterData.getZones1(getDataSource(request));
				session.setAttribute("designations",designations);
			}
		}	
		catch(Exception e)
		{
			Debug.println("error in Emp Status Form"+e);
		}
	}
		
		
	if(mode.equalsIgnoreCase("ViewReport"))
	{
		try
		{	
			if(frm.getDetailedWise()!=null)
			{
			for(int i=0;i<frm.getSelectedItems().length;i++)
			{
				String select[]=frm.getSelectedItems();
				
			}
			}
			empsReport=EmpMasterData.getEmpsReport(frm.getHoc(),frm.getCoc(),frm.getDoc(),frm.getSdoc(),frm.getDetailedWise(),frm.getSelectedItems(),frm.getSector(),getDataSource(request));
			session.setAttribute("empsReport",empsReport);

			
		}
		catch(Exception e)
		{
			Debug.println("The error in Emp View is "+e);
		}
	}
		
//end of Code Added

		
	//code for Emp Department Opted wise Report
	
	if(mode.equalsIgnoreCase("DeptOptForms"))
	{
		
		ArrayList DeptReport=new ArrayList();
		ArrayList fromdate=new ArrayList();
		ArrayList spouseworking=new ArrayList();
		ArrayList spouseemployd=new ArrayList();
		ArrayList desgns1=new ArrayList();
		
		/*if(request.getParameter("department")!=null && request.getParameter("department").equalsIgnoreCase("RWS"))
		{
			DeptReport=EmpMasterData.getEmpDeptOpt(request.getParameter("department"),getDataSource(request));
			Debug.println("employees1"+DeptReport);
			request.setAttribute("DeptReport",DeptReport);
		}
		else if(request.getParameter("department")!=null && request.getParameter("department").equalsIgnoreCase("PR"))
		{
			DeptReport=EmpMasterData.getEmpDeptOpt(request.getParameter("department"),getDataSource(request));
			Debug.println("employees2"+DeptReport);
			request.setAttribute("DeptReport",DeptReport);
		}
		
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("C"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			Debug.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("S"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			Debug.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("P"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			Debug.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseemployd")!=null && request.getParameter("spouseemployd").equalsIgnoreCase("N"))
		{
			spouseemployd=EmpMasterData.getSpousework(request.getParameter("spouseemployd"),getDataSource(request));
			Debug.println("spouseNotworking"+spouseemployd);
			request.setAttribute("spouseemployd",spouseemployd);
		}	
		
			if(request.getParameter("department")!=null)
			{
				request.setAttribute("DeptReport",request.getParameter("DeptReport"));
			}
			if(request.getParameter("spouseworking")!=null)
			{
				request.setAttribute("spouseworking",spouseworking);
			}*/
				
		try
		{
			
			
			fromdate=EmpMasterData.getFromDate(getDataSource(request));
			request.setAttribute("fromdate",fromdate);
			
			
			catcodes=EmpMasterData.getCatogs(getDataSource(request));
			session.setAttribute("catcodes",catcodes);
			
			qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
			session.setAttribute("qualcodes",qualcodes);
			
			
			
			desgns=EmpMasterData.getDesgns(request.getParameter("desig"));
			session.setAttribute("desgns",desgns);			
			
			desgns1=EmpMasterData.getDesgns("A");
			session.setAttribute("desgns1",desgns1);
						
		}
		catch(Exception e)
		{
			Debug.println("error in getting DeptOptForms mode:"+e);
		}
	
	}
	
	if(mode.equalsIgnoreCase("DeptReport"))
	{
		//Debug.println("Mode entred  ="+mode);
		try
		{			
		ArrayList DeptReport=new ArrayList();
		empMaster.setQual(request.getParameter("qual"));
		empMaster.setPresentdesig(request.getParameter("presentdesig"));
		DeptReport=EmpMasterData.getEmpDeptOpt(empMaster,request.getParameter("department"),request.getParameter("fromDate"),request.getParameter("spouseworking"),request.getParameter("apcatog"),request.getParameter("desgnCode"),request.getParameter("spouseemployd"),getDataSource(request));
		session.setAttribute("DeptReport",DeptReport);
		}
		catch(Exception e)
		{
			Debug.println("Error in Dept Report"+e);
		}
				
	}
	
	//end of Department opted code
	
		if(mode.equalsIgnoreCase("save"))
		{
		//	Debug.println("Mode entred  ="+mode);
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			try
			{
			//	Debug.println("in Save mode of printing ");
				empMaster.setEmpcode(frm.getEmpcode());
				empMaster.setSurname(frm.getSurname());
				empMaster.setEmpname(frm.getEmpname());
				empMaster.setGender(frm.getGender());
				empMaster.setRelation(frm.getRelation());
				empMaster.setDob(frm.getDob());
				empMaster.setReligion(frm.getReligion());
				empMaster.setSocial(frm.getSocial());
				empMaster.setNmand(frm.getNmand());
				empMaster.setNdist(frm.getNdist());
				empMaster.setNrevenue(frm.getNrevenue());
				empMaster.setQual(frm.getQual());
				empMaster.setHandicap(frm.getHandicap());
				empMaster.setDiststudied4(frm.getDiststudied4());
				empMaster.setDiststudied5(frm.getDiststudied5());
				empMaster.setDiststudied6(frm.getDiststudied6());
				empMaster.setDiststudied7(frm.getDiststudied7());
				empMaster.setDiststudied8(frm.getDiststudied8());
				empMaster.setDiststudied9(frm.getDiststudied9());
				empMaster.setDiststudied10(frm.getDiststudied10());
				empMaster.setLocaldist(frm.getLocaldist());
				empMaster.setLocalzone(frm.getLocalzone());
				empMaster.setNoofyrs(frm.getNoofyrs());
				empMaster.setNoofyrs1(frm.getNoofyrs1());
				empMaster.setPvtdist(frm.getPvtdist());
				empMaster.setPvtzone(frm.getPvtzone());
				empMaster.setSpouseemployd(frm.getSpouseemployd());
				empMaster.setSpouseworking(frm.getSpouseworking());
				empMaster.setSpouseworkdist(frm.getSpouseworkdist());
				empMaster.setSpouseworkdiv(frm.getSpouseworkdiv());
				empMaster.setSpouseworkmand(frm.getSpouseworkmand());
				empMaster.setDesig(frm.getDesig());
				empMaster.setDesgnCode(frm.getDesgnCode());
				empMaster.setAppointdate(frm.getAppointdate());
				empMaster.setApptcategory(frm.getApptcategory());
				empMaster.setDoj(frm.getDoj());
				empMaster.setMoap(frm.getMoap());
				empMaster.setZone(frm.getZone());
				empMaster.setNarecruit(frm.getNarecruit());
				empMaster.setApcatog(frm.getApcatog());
				empMaster.setDcommprob(frm.getDcommprob());
				empMaster.setDdeclprob(frm.getDdeclprob());
				empMaster.setCurrentpostdate(frm.getCurrentpostdate());
				empMaster.setPromotedate(frm.getPromotedate());
				empMaster.setTestpassed(frm.getTestpassed());
			//	Debug.println("TestPassed in Save frm "+frm.getTestpassed()+" in EmpMaster"+empMaster.getTestpassed());
				empMaster.setDacctest(frm.getDacctest());
				empMaster.setAddqual1(frm.getAddqual1());
				empMaster.setAddqual2(frm.getAddqual2());
				empMaster.setPresentdesig(frm.getPresentdesig());
			//	Debug.println("present DEsignatin in save   "+frm.getPresentdesig());
				empMaster.setWorkSpecial(frm.getWorkSpecial());
		//		Debug.println("work special in save  frm  "+frm.getWorkSpecial()+" EmpMaster"+empMaster.getWorkSpecial());				
				empMaster.setOtherDet(frm.getOtherDet());
				empMaster.setHoc(frm.getHoc());
				empMaster.setSection(frm.getSection());
				empMaster.setRoc(frm.getRoc());
				empMaster.setDept(frm.getDept());				
				empMaster.setDeputation(frm.getDeputation());
				empMaster.setDeputationDate(frm.getDeputationDate());
				empMaster.setSeniority(frm.getSeniority());
				empMaster.setDisciplinecase(frm.getDisciplinecase());
				empMaster.setDisciplinetype(frm.getDisciplinetype());
				empMaster.setPanno(frm.getPanno());  
				empMaster.setApgli(frm.getApgli());
				empMaster.setGpfno(frm.getGpfno());
				empMaster.setPayscale(frm.getPayscale());
				empMaster.setIncrementdate(frm.getIncrementdate());
				empMaster.setUpdatedate(frm.getUpdatedate());
				empMaster.setLeavesuspend(frm.getLeavesuspend());
				empMaster.setLeavedate(frm.getLeavedate());
				empMaster.setDepudept(frm.getDepudept());
				ans=EmpMasterData.insertEmp(empMaster,getDataSource(request),session);
			
				//request.setAttribute("ecode",EmpMasterData.getEmpCode(getDataSource(request)));
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				Debug.println("the error in Emp Insert is "+e);
			}
		    }
			if(session.getAttribute("var1")!=null)
			{
				message="Employee_code already Exists-Record Cannot be inserted";
			}
			else if(ans==null || ans.length <1 )
			{
				message="The Record Cannot be inserted ";
			}
			else
			{
				frm.reset(mapping,request);
				message="Record Inserted Successfully";				
			}			
			request.setAttribute("message",message);		
		}
		
		if(mode.equalsIgnoreCase("get"))
		{  		
			try 
			{ 								
				EmpForm frm1=null;
				frm1=EmpMasterData.getEmpEdit(frm.getEmpcode(),session);
				PropertyUtils.copyProperties(frm,frm1);
				/*if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				} 
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}*/
			} 
			catch (Exception e) 
			{
				//Debug.println("the error in Emp get is = "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("Update"))
		{
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {	
			try
			{
				empMaster.setEmpcode(frm.getEmpcode());
				//added on july 21
				empMaster.setSurname(frm.getSurname());
				empMaster.setEmpname(frm.getEmpname());
				empMaster.setGender(frm.getGender());
				empMaster.setRelation(frm.getRelation());
				empMaster.setDob(frm.getDob());
				empMaster.setReligion(frm.getReligion());
				empMaster.setSocial(frm.getSocial());
				empMaster.setNmand(frm.getNmand());
				empMaster.setNdist(frm.getNdist());
				empMaster.setNrevenue(frm.getNrevenue());
				empMaster.setQual(frm.getQual());
				empMaster.setHandicap(frm.getHandicap());
			
				empMaster.setDiststudied4(frm.getDiststudied4());
				empMaster.setDiststudied5(frm.getDiststudied5());
				empMaster.setDiststudied6(frm.getDiststudied6());
				empMaster.setDiststudied7(frm.getDiststudied7());
				empMaster.setDiststudied8(frm.getDiststudied8());
				empMaster.setDiststudied9(frm.getDiststudied9());
				empMaster.setDiststudied10(frm.getDiststudied10());
				empMaster.setLocaldist(frm.getLocaldist());
				empMaster.setLocalzone(frm.getLocalzone());
				empMaster.setNoofyrs(frm.getNoofyrs());
				empMaster.setNoofyrs1(frm.getNoofyrs1());
				empMaster.setPvtdist(frm.getPvtdist());
				empMaster.setPvtzone(frm.getPvtzone());
							
				empMaster.setSpouseemployd(frm.getSpouseemployd());
				empMaster.setSpouseworking(frm.getSpouseworking());
				empMaster.setSpouseworkdist(frm.getSpouseworkdist());
				empMaster.setSpouseworkdiv(frm.getSpouseworkdiv());
				empMaster.setSpouseworkmand(frm.getSpouseworkmand());
			
				empMaster.setDesig(frm.getDesig());
				if(empMaster.getDesig()!=null && empMaster.getDesig().equals("P"))
				{
					empMaster.setDesgnCode(frm.getDesgnCode());
					//Debug.println("DesgnCode"+frm.getDesgnCode());	
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("T"))
				{
					empMaster.setDesgnCode(frm.getDesgnCode());
					//Debug.println("DesgCode update"+frm.getDesgnCode());
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("W"))
				{
					empMaster.setDesgnCode(frm.getDesgnCode());
					//Debug.println("DesgCode update"+frm.getDesgnCode());
				}
				
				empMaster.setAppointdate(frm.getAppointdate());
				empMaster.setApptcategory(frm.getApptcategory());
				empMaster.setDoj(frm.getDoj());
				empMaster.setMoap(frm.getMoap());
				empMaster.setZone(frm.getZone());
				empMaster.setNarecruit(frm.getNarecruit());
				empMaster.setApcatog(frm.getApcatog());
				empMaster.setDcommprob(frm.getDcommprob());
				empMaster.setDdeclprob(frm.getDdeclprob());
				empMaster.setCurrentpostdate(frm.getCurrentpostdate());
			
				empMaster.setPromotedate(frm.getPromotedate());
				empMaster.setTestpassed(frm.getTestpassed());
				empMaster.setDacctest(frm.getDacctest());
				empMaster.setAddqual1(frm.getAddqual1());
				empMaster.setAddqual2(frm.getAddqual2());
				empMaster.setPresentdesig(frm.getPresentdesig());
				//Debug.println("present DEsignatin in save   "+frm.getPresentdesig());
				empMaster.setWorkSpecial(frm.getWorkSpecial());
				//Debug.println("work special in save     "+frm.getWorkSpecial());				
				empMaster.setOtherDet(frm.getOtherDet());
			
				empMaster.setHoc("1");
				empMaster.setSection(frm.getSection());
				empMaster.setRoc(frm.getRoc());
				
				empMaster.setDept(frm.getDept());
				empMaster.setDeputation(frm.getDeputation());
				empMaster.setDeputationDate(frm.getDeputationDate());
				
				empMaster.setDepudept(frm.getDepudept());
				//Debug.println("DepuDept  "+empMaster.getDepudept());
				empMaster.setLeavedate(frm.getLeavedate());
				//Debug.println("Leavedate  "+empMaster.getLeavedate());
				empMaster.setLeavesuspend(frm.getLeavesuspend());
				//Debug.println("Leavesuspend  "+empMaster.getLeavesuspend());
				
				empMaster.setSeniority(frm.getSeniority());
				empMaster.setDisciplinecase(frm.getDisciplinecase());
				empMaster.setDisciplinetype(frm.getDisciplinetype());
				
				empMaster.setPanno(frm.getPanno());
				empMaster.setApgli(frm.getApgli());
				empMaster.setGpfno(frm.getGpfno());
				empMaster.setPayscale(frm.getPayscale());
				empMaster.setIncrementdate(frm.getIncrementdate());
				empMaster.setUpdatedate(frm.getUpdatedate());
								
				message=EmpMasterData.updateEmp(empMaster,getDataSource(request));
				request.setAttribute("message",message);
				mode="close";				
			}
			catch (Exception e) 
			{
				//Debug.println("the error in Emp edit is "+e);
			}
		    }
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{
			int del=0;
			try 
			{
				displaymess=EmpMasterData.removeEmp(request.getParameter("empcode"),getDataSource(request));	
		
				request.setAttribute("message",displaymess);
				mode="close";
			}
			catch (Exception e) 
			{
				Debug.println("the error in Emp delete is "+e);
			}
		}
		if(mode!=null && mode.equalsIgnoreCase("edit2Update"))
		{
		 try 
		   {		 	 
				workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
				session.setAttribute("workSpecs",workSpecs);
				desgns=EmpMasterData.getDesgns(frm.getDesig());
				session.setAttribute("desgns",desgns);
				
				if(request.getParameter("desgnCode")!=null)
				{
				payscale = EmpMasterData.getPayScales(request.getParameter("desgnCode"),getDataSource(request));
				}
				request.setAttribute("payscale",payscale);
								
				modes=EmpMasterData.getModeOfAppt(getDataSource(request));
				session.setAttribute("modes",modes);
				
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);							
		
									
				if(request.getParameter("ndist")!=null)
				{
					if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
					{				
					mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));					
					}		
				}
				session.setAttribute("mandals",mandals);				
										
				castes=EmpMasterData.getCastes();
				session.setAttribute("castes",castes);
				
				religions=EmpMasterData.getReligions();
				session.setAttribute("religions",religions);
				
				zonecodes=EmpMasterData.getZones();
				session.setAttribute("zonecodes",zonecodes);
				
				catcodes=EmpMasterData.getCatogs(getDataSource(request));
				session.setAttribute("catcodes",catcodes);
							
				qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
				session.setAttribute("qualcodes",qualcodes);
				
				if(request.getParameter("addqual1")!=null)
				{
					if(!(request.getParameter("addqual1")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual1"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes1",addqualcodes1);
				
				if(request.getParameter("addqual2")!=null)
				{
					if(!(request.getParameter("addqual2")).equalsIgnoreCase(""))
					{
						addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual2"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes2",addqualcodes2);
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				String ccode=frm.getCircleOfficeCode();
				String divcode=frm.getDivisionOfficeCode();
				String subcode=frm.getSubdivisionOfficeCode();
				
				ArrayList circles = rwsOffices.getCircles();
				session.setAttribute("circles", circles);
				
				ArrayList divisions = rwsOffices.getDivisions1(ccode);
				session.setAttribute("divisions", divisions);
				
				ArrayList subdivisions = rwsOffices.getSubDivisions1(ccode,divcode);
				session.setAttribute("subdivisions", subdivisions);
				if(request.getParameter("sdoc")!=null)
				{
					if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
					{
						request.setAttribute("hof",EmpMasterData.getEmployee("1",request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
					}
				}
				session.setAttribute("subdivcodes",subdivcodes);
				if(request.getParameter("roc")!=null)
				{
					request.setAttribute("roc",request.getParameter("roc"));
				}
			
				if(request.getParameter("spouseworkdist")!=null)
				{
					
					if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
					{								
						smandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
						
					}
				}
				session.setAttribute("smandals",smandals);
				
			
				if(request.getParameter("empcode")!=null)
				{				
					request.setAttribute("empcode",request.getParameter("empcode"));
				}
				//added on july 21
				if(request.getParameter("surname")!=null)
				{
					request.setAttribute("surname",request.getParameter("surname"));
				}
				if(request.getParameter("empname")!=null)
				{
					request.setAttribute("empname",request.getParameter("empname"));
				}
				//added on july 21
				if(request.getParameter("relation")!=null)
				{
					request.setAttribute("relation",request.getParameter("relation"));
				}				
				if(request.getParameter("dob")!=null)
				{
					request.setAttribute("dob",request.getParameter("dob"));
				}			
				if(request.getParameter("appOrderRef")!=null)
				{
					request.setAttribute("appOrderRef",request.getParameter("appOrderRef"));
				}
				if(request.getParameter("appointdate")!=null)
				{
					request.setAttribute("appointdate",request.getParameter("appointdate"));
				}
				if(request.getParameter("doj")!=null)
				{
					request.setAttribute("doj",request.getParameter("doj"));
				}
				if(request.getParameter("currentpostdate")!=null)
				{
					request.setAttribute("currentpostdate",request.getParameter("currentpostdate"));
				}
													
				if(request.getParameter("updatedate")!=null)
				{
					request.setAttribute("updatedate",request.getParameter("updatedate"));
				}
				if(request.getParameter("depu")!=null)
				{
					request.setAttribute("depu",request.getParameter("depu"));
				}
				if(request.getParameter("depudept")!=null)
				{
					request.setAttribute("depudept",request.getParameter("depudept"));
				}
				if(request.getParameter("seniority")!=null)
				{
					request.setAttribute("seniority",request.getParameter("seniority"));
					
				}
				if(request.getParameter("DATE_OF_LEAVE")!=null)
				{
					request.setAttribute("leavedate",request.getParameter("leavedate"));
				}
				if(request.getParameter("LEAVE_SUSPENDED")!=null)
				{
					request.setAttribute("leavesuspend",request.getParameter("leavesuspend"));
				}				
		}
				catch(Exception e)
				{
					Debug.println("the error in empname:"+e);
				}
				}		
		return(mapping.findForward(mode));		
	}
	
}
