
package nic.watersoft.masters;

import java.util.List;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;
import nic.watersoft.reports.rws_asset_CheckList_Bean;
import nic.watersoft.reports.rws_asset_CheckList_Data;
import nic.watersoft.reports.rws_asset_CheckList_FormBean;

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
	ArrayList sectorcode=new ArrayList(200);	
		
		//testing code for Ajax
		 ArrayList circles=null;
		 ArrayList divisions=null;
		 ArrayList subdivisions=null;
		 ArrayList counts=null;
		 String mode=null;
	 	
		 
	
	protected ActionForm buildEmpDesgnForm(String empcode,String mode,HttpServletRequest request) throws Exception 
	{
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		EmpForm form = null;
		EmpMaster empMaster=EmpMasterData.getEmp(empcode,getDataSource(request));
		
			if(empMaster!=null)
			{
				try{
				form = new EmpForm();
				String code=empMaster.getEmpcode();
								
				form.setEmpcode(empMaster.getEmpcode());
				////System.out.println("empMaster.getEmpname()"+empMaster.getEmpname());
				form.setSurname(empMaster.getSurname());
				form.setEmpname(empMaster.getEmpname());
				form.setGender(empMaster.getGender());
				form.setRelation(empMaster.getRelation());
				form.setDob(empMaster.getDob());
				form.setReligion(empMaster.getReligion());
				form.setSocial(empMaster.getSocial());
				
				form.setNmand(empMaster.getNmand());
				////System.out.println("nmand"+empMaster.getNmand());			
				
				
				form.setNdist(empMaster.getNdist());
				////System.out.println("Native district"+empMaster.getNdist());
				
				if(empMaster.getNdist()!=null)
				{									
					////System.out.println("ndist in ACT"+empMaster.getNdist());
					mandals=rwsOffices.getDistrictMandals(empMaster.getNdist());
				}
				session.setAttribute("mandals",mandals);
				////System.out.println("the mandals in execute()"+mandals);
				
				form.setNrevenue(empMaster.getNrevenue());
				form.setQual(empMaster.getQual());
				if(empMaster.getQual()!= null)
				{
					addqualcodes = EmpMasterData.getAddQualCodes(empMaster.getQual(),getDataSource(request));
				}
				session.setAttribute("addqualcodes",addqualcodes);
				form.setHandicap(empMaster.getHandicap());
				////System.out.println("   PH   "+empMaster.getHandicap());
				
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
								
				form.setSpouseemployd(empMaster.getSpouseemployd());
				////System.out.println("spouse employeed act"+empMaster.getSpouseemployd());
				form.setSpouseworking(empMaster.getSpouseworking());
				form.setSpouseworkdist(empMaster.getSpouseworkdist());
				////System.out.println("SPOUSE Work dist act"+empMaster.getSpouseworkdist());
				form.setSpouseworkdiv(empMaster.getSpouseworkdiv());
				////System.out.println("SPOUSE Revenue Division "+empMaster.getSpouseworkdiv());
				form.setSpouseworkmand(empMaster.getSpouseworkmand());
				////System.out.println("SPOUSE  Mandal "+empMaster.getSpouseworkmand());
				
				form.setDiststudied4(empMaster.getDiststudied4());//diststudied4
				form.setDiststudied5(empMaster.getDiststudied5());
				form.setDiststudied6(empMaster.getDiststudied6());
				form.setDiststudied7(empMaster.getDiststudied7());
				form.setDiststudied8(empMaster.getDiststudied8());
				form.setDiststudied9(empMaster.getDiststudied9());
				form.setDiststudied10(empMaster.getDiststudied10());
				form.setLocaldist(empMaster.getLocaldist());
				form.setLocalzone(empMaster.getLocalzone());
				form.setNoofyrs(empMaster.getNoofyrs());
				////System.out.println("the value of the noofyrs builddesign() "+empMaster.getNoofyrs());
				form.setNoofyrs1(empMaster.getNoofyrs1());
				////System.out.println("the value of the noofyrs1 builddesign()"+empMaster.getNoofyrs1());
				form.setPvtdist(empMaster.getPvtdist());
				form.setPvtzone(empMaster.getPvtzone());
				////System.out.println("PVT ZONE IN Action()  "+empMaster.getPvtzone());
				try
				{
				if(Integer.parseInt(empMaster.getPvtzone())<10)
				{
					form.setPvtzone(empMaster.getPvtzone());
				}
				}catch(Exception e)
				{
					//System.out.println("Pvt Zone setting Error"+e);
				}
				form.setPvtzone(empMaster.getPvtzone());
				////System.out.println("PVT zone in Action "+empMaster.getPvtzone());
				
				form.setDesig(empMaster.getDesig());
				////System.out.println("Desig act "+empMaster.getDesig());
				/*form.setDesgnCode(empMaster.getDesgnCode());
				//System.out.println("Designation act "+empMaster.getDesgnCode());*/
				if(empMaster.getDesig()!=null && empMaster.getDesig().equals("P"))
				{
					form.setDesgnCode(empMaster.getDesgnCode());
					////System.out.println("DesgnCode"+form.getDesgnCode());	
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("T"))
				{
					form.setDesgnCode(empMaster.getDesgnCode());
					////System.out.println("TDesgCode"+form.getDesgnCode());
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("W"))
				{
					form.setDesgnCode(empMaster.getDesgnCode());
					////System.out.println("WDesgCode"+form.getDesgnCode());
				}
				desgns=EmpMasterData.getDesgns(empMaster.getDesig(),getDataSource(request));
				session.setAttribute("desgns",desgns);
								
				if(empMaster.getApptcategory()!=null)
				{
				form.setApptcategory(empMaster.getApptcategory().substring(0,1));
				}
				////System.out.println("ApptCategory in Action "+empMaster.getApptcategory());
				form.setAppointdate(empMaster.getAppointdate());
				form.setDoj(empMaster.getDoj());
				form.setMoap(empMaster.getMoap());
				////System.out.println("there appointdate doj moap");
				form.setZone(empMaster.getZone());
				form.setNarecruit(empMaster.getNarecruit());
				form.setApcatog(empMaster.getApcatog());
				////System.out.println("zone narecruit apcatog");
				
				form.setDcommprob(empMaster.getDcommprob());
				form.setDdeclprob(empMaster.getDdeclprob());
				form.setCurrentpostdate(empMaster.getCurrentpostdate());
				form.setPromotedate(empMaster.getPromotedate());
				form.setTestpassed(empMaster.getTestpassed());
				form.setDacctest(empMaster.getDacctest());
				/*
				form.setAddqual2(empMaster.getAddqual2());
				
				form.setAddqual1(empMaster.getAddqual1());
				;
				
				*/
				form.setAddqual2(empMaster.getAddqual2());
				if(form.getAddqual2()!=null)
				{
					addqualcodes2 = EmpMasterData.getAddQualCodes(form.getAddqual2(),getDataSource(request));
				}
				session.setAttribute("addqualcodes2",addqualcodes2);
				////System.out.println("addqual2 act "+empMaster.getAddqual2());
				
				form.setAddqual1(empMaster.getAddqual1());
				
				if(form.getAddqual1()!=null)
				{
					addqualcodes1 = EmpMasterData.getAddQualCodes(form.getAddqual1(),getDataSource(request));
				}
				session.setAttribute("addqualcodes1",addqualcodes1);
				////System.out.println("addqual1 act "+empMaster.getAddqual1());
				
				form.setPresentdesig(empMaster.getPresentdesig());
				////System.out.println("present Desig act "+empMaster.getPresentdesig());
				form.setWorkSpecial(empMaster.getWorkSpecial());
				////System.out.println("work special act"+empMaster.getWorkSpecial());
				form.setOtherDet(empMaster.getOtherDet());
								
		
				form.setHoc(empMaster.getRoc().substring(0,1));
				////System.out.println("the HOC value"+empMaster.getRoc().substring(0,1));
				try
				{
				if(!empMaster.getRoc().substring(0,1).equalsIgnoreCase("0"))
				{
					//circlecodes = EmpMasterData.getCircleCodes(empMaster.getRoc().substring(0,1),getDataSource(request));
					circlecodes=rwsOffices.getCircles("1");
				}
				session.setAttribute("circlecodes",circlecodes);
				////System.out.println("circlecodes"+circlecodes);
				
				form.setCoc(empMaster.getRoc().substring(1,3));
				if(!empMaster.getRoc().substring(1,3).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions(empMaster.getRoc().substring(0,1),empMaster.getRoc().substring(1,3));
				}
				session.setAttribute("divcodes",divcodes);
				////System.out.println("divcodes"+divcodes);
				
				form.setDoc(empMaster.getRoc().substring(3,4));
				if(!empMaster.getRoc().substring(3,4).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(empMaster.getRoc().substring(0,1),empMaster.getRoc().substring(1,3),empMaster.getRoc().substring(3,4));
				}
				session.setAttribute("subdivcodes",subdivcodes);
				////System.out.println("subdivcodes"+subdivcodes);
				
				form.setSdoc(empMaster.getRoc().substring(4,6));
				////System.out.println("SDOC"+empMaster.getRoc().substring(4,6));
				}
				catch(Exception e)
				{
					//System.out.println("Exception in office codes"+e);
				}
				form.setSection(empMaster.getSection());
				form.setDept(empMaster.getDept());
				form.setRoc(empMaster.getRoc());
				form.setDeputation(empMaster.getDeputation());
				form.setDeputationDate(empMaster.getDeputationDate());//deputation from date
				////System.out.println("DEPUtaion date act  "+empMaster.getDeputationDate());
				form.setSeniority(empMaster.getSeniority());
				////System.out.println("seniority act "+empMaster.getSeniority());
				form.setDisciplinecase(empMaster.getDisciplinecase());
				form.setDisciplinetype(empMaster.getDisciplinetype().substring(0,1));
				////System.out.println("dicipline type act"+empMaster.getDisciplinetype());
				form.setPanno(empMaster.getPanno());
				////System.out.println("panno act"+empMaster.getPanno());
				form.setApgli(empMaster.getApgli());
				form.setGpfno(empMaster.getGpfno());
				////System.out.println("gpfno act"+empMaster.getGpfno());
				form.setPayscale(empMaster.getPayscale());
				////System.out.println("payscale act"+empMaster.getPayscale());
				form.setUpdatedate(empMaster.getUpdateDate());
				form.setIncrementdate(empMaster.getIncrementdate());
				form.setLeavedate(empMaster.getLeavedate());
				////System.out.println("leave date in Action"+empMaster.getLeavedate());
				form.setLeavesuspend(empMaster.getLeavesuspend());
				////System.out.println("leave suspend in Action"+empMaster.getLeavesuspend());
				form.setDepudept(empMaster.getDepudept());
								
				//code added for EmpForm
				////System.out.println("build desig form********************************** in the Edit Part");
				}catch(Exception e){
					//System.out.println("Error in Edit part in Action class"+e);
				}
			}
		return form;
	}
		
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int ans[] = null;
		
		ArrayList desgns=new ArrayList();
		ArrayList workSpecs=new ArrayList();
		ArrayList qualcodes=new ArrayList();
		ArrayList posts=new ArrayList();
		ArrayList castes=new ArrayList();
		ArrayList religions=new ArrayList();
		ArrayList districts=new ArrayList();
		ArrayList mandals=new  ArrayList();
		ArrayList zonecodes=new ArrayList();
		ArrayList modes=new ArrayList();
		ArrayList catcodes=new ArrayList();
		ArrayList designations=new ArrayList();
		ArrayList mandal=new ArrayList();
		String payscale=null;
		ArrayList addqualcodes1=new ArrayList();
		
		//Added on Aug 10	
		ArrayList fromdates=new ArrayList();
		ArrayList todates=new ArrayList();
		ArrayList office=new ArrayList();
				
		ArrayList empsList=new ArrayList();
		String message=null;
		String displaymess=null;
		ArrayList emps=null;
		ArrayList empsReport=null;
		ArrayList emps1=null;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = new EmpMaster();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
					
		EmpForm frm=(EmpForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		
		//System.out.println("the mode in the empentyAct class     "+mode);
		
		if(mode.equalsIgnoreCase("data")||mode.equalsIgnoreCase("update"))
		{
			try
			{
						//System.out.println("in sdoc tell me ="+request.getParameter("sdoc"));
						
						//added on 21 july
						posts=EmpMasterData.getEmps(getDataSource(request));
						session.setAttribute("posts",posts);
					
						workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
						session.setAttribute("workSpecs",workSpecs);
						
					
						if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
						{
							//System.out.println("in t");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
						{
							//System.out.println("in p");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("W"))
						{
							//System.out.println("in w");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else
						{
							//System.out.println("in X");
							desgns=EmpMasterData.getDesgns("P",getDataSource(request));
						}
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
						////System.out.println("native District"+request.getParameter("ndist"));
						if(request.getParameter("ndist")!=null)
						{
							if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
							{
							////System.out.println("ndist in ACT"+request.getParameter("ndist"));
							mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));
							}
						}
						session.setAttribute("mandals",mandals);
						////System.out.println("the mandals in execute()"+mandals);
						
						castes=EmpMasterData.getCastes(getDataSource(request));
						session.setAttribute("castes",castes);
						
						religions=EmpMasterData.getReligions(getDataSource(request));
						session.setAttribute("religions",religions);
						
						zonecodes=EmpMasterData.getZones(getDataSource(request));
						session.setAttribute("zonecodes",zonecodes);
						
						catcodes=EmpMasterData.getCatogs(getDataSource(request));
						session.setAttribute("catcodes",catcodes);
									
						qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
						session.setAttribute("qualcodes",qualcodes);
						////System.out.println("qualcodes"+qualcodes);
															
						if(request.getParameter("addqual1")!=null)
						{
							if(!(request.getParameter("addqual1")).equalsIgnoreCase(""))
							{
								addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual1"),getDataSource(request));
							}
						}
						session.setAttribute("addqualcodes1",addqualcodes1);
						////System.out.println("addqualification vale  "+addqualcodes);
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
								circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
								////System.out.println(request.getParameter("hoc"));
							}
						}
						session.setAttribute("circlecodes",circlecodes);
						
						if(request.getParameter("coc")!=null)
						{
							if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
							{
								divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
								////System.out.println(request.getParameter("coc"));
							}
						}
						session.setAttribute("divcodes",divcodes);
						
						if(request.getParameter("doc")!=null)
						{
							if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
							{
								subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
								////System.out.println(request.getParameter("doc"));
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
						
						//added on july 21
						if(request.getParameter("empcode")!=null)
						{
							//System.out.println("empcode in execute()");
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
						//added on july 23
												
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
							////System.out.println("spouse work dist"+request.getParameter("spouseworkdist"));
							if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
							{								
								mandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
							}
						}
						session.setAttribute("mandals",mandals);
										
						
				}
				catch(Exception e)
				{
					//System.out.println("the error in empname"+e);
				}

				}
		
		
		if(mode.equalsIgnoreCase("UpdateData"))
		{
			try
			{
						//System.out.println("in sdoc tell me ="+request.getParameter("sdoc"));
						
						//added on 21 july
						posts=EmpMasterData.getEmps(getDataSource(request));
						session.setAttribute("posts",posts);
					
						workSpecs=EmpMasterData.getWorkSpecs(getDataSource(request));
						session.setAttribute("workSpecs",workSpecs);
						
						if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
						{
							//System.out.println("in t");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
						{
							//System.out.println("in p");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("W"))
						{
							//System.out.println("in w");
							desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
						}
						else
						{
							//System.out.println("in X");
							desgns=EmpMasterData.getDesgns("P",getDataSource(request));
						}
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
						////System.out.println("native District"+request.getParameter("ndist"));
						if(request.getParameter("ndist")!=null)
						{
							if(!(request.getParameter("ndist")).equalsIgnoreCase("00"))
							{
							////System.out.println("ndist in ACT"+request.getParameter("ndist"));
							mandals=rwsOffices.getDistrictMandals(request.getParameter("ndist"));
							}
						}
						session.setAttribute("mandals",mandals);
						////System.out.println("the mandals in execute()"+mandals);
						
						castes=EmpMasterData.getCastes(getDataSource(request));
						session.setAttribute("castes",castes);
						
						religions=EmpMasterData.getReligions(getDataSource(request));
						session.setAttribute("religions",religions);
						
						zonecodes=EmpMasterData.getZones(getDataSource(request));
						session.setAttribute("zonecodes",zonecodes);
						
						catcodes=EmpMasterData.getCatogs(getDataSource(request));
						session.setAttribute("catcodes",catcodes);
									
						qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
						session.setAttribute("qualcodes",qualcodes);
						////System.out.println("qualcodes"+qualcodes);
															
						if(request.getParameter("addqual1")!=null)
						{
							if(!(request.getParameter("addqual1")).equalsIgnoreCase(""))
							{
								addqualcodes1= EmpMasterData.getAddQualCodes(request.getParameter("addqual1"),getDataSource(request));
							}
						}
						session.setAttribute("addqualcodes1",addqualcodes1);
						////System.out.println("addqualification vale  "+addqualcodes);
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
								circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
								////System.out.println(request.getParameter("hoc"));
							}
						}
						session.setAttribute("circlecodes",circlecodes);
						
						if(request.getParameter("coc")!=null)
						{
							if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
							{
								divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
								////System.out.println(request.getParameter("coc"));
							}
						}
						session.setAttribute("divcodes",divcodes);
						
						if(request.getParameter("doc")!=null)
						{
							if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
							{
								subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
								////System.out.println(request.getParameter("doc"));
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
						
						//added on july 21
						if(request.getParameter("empcode")!=null)
						{
							//System.out.println("empcode in execute()");
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
						//added on july 23
												
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
							////System.out.println("spouse work dist"+request.getParameter("spouseworkdist"));
							if(!(request.getParameter("spouseworkdist")).equalsIgnoreCase("00"))
							{								
								mandals=rwsOffices.getDistrictMandals(request.getParameter("spouseworkdist"));
							}
						}
						session.setAttribute("mandals",mandals);
									
				}
				catch(Exception e)
				{
					//System.out.println("the error in Mode UpdateData"+e);
				}

				}
				
		//code added for employee checklist
		
		if(mode.equalsIgnoreCase("checklist"))
		{
			try
			{
			heads = rwsOffices.getHeads();
			session.setAttribute("heads",heads);
			
			if(request.getParameter("hoc")!=null )//&& request.getParameter("hoc")=="1"
			{
				if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
				{
					circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					////System.out.println(request.getParameter("hoc"));
				}
			}
			session.setAttribute("circlecodes",circlecodes);
			
			if(request.getParameter("coc")!=null)
			{
				if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
					////System.out.println(request.getParameter("coc"));
				}
			}
			session.setAttribute("divcodes",divcodes);
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					////System.out.println(request.getParameter("Doc"));
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
			//code for fromdates
			fromdates=EmpMasterData.getFromDates1(getDataSource(request));
			session.setAttribute("fromdates",fromdates);
			
			//String frdt=request.getParameter("fromDate");
			//frm.setFromDate(frdt);
			//////System.out.println(" to Date Value in act= "+request.getParameter("toDate"));
			if(request.getParameter("toDate")!=null)
			{
			todates=EmpMasterData.getToDates1(request.getParameter("fromDate"),getDataSource(request));
			session.setAttribute("todates",todates);
			}
				
			
		}	
		catch(Exception e)
		{
			//System.out.println("error in employee checklist"+e);
		}
	}			

		if(mode.equalsIgnoreCase("dates"))
		{
				try
				{	
					//System.out.println("in try block");
				   if(request.getParameter("fromDate")!=null)
					{
				    //System.out.println("from date"+request.getParameter("fromDate"));
				    String frdt=request.getParameter("fromDate");	
					request.setAttribute("fromdates",EmpMasterData.getFromDates1(getDataSource(request)));
					frm.setFromDate(frdt);
					//System.out.println(" value of the fromDate:"+frdt);
					
					request.setAttribute("todates",EmpMasterData.getToDates1(frdt,getDataSource(request)));
					////System.out.println("Ended the fromDate-->toDate in Action:");
					mode="data1";
					 /*frm.setFromDate("fromDate"); */
					/*
					 ArrayList toDate=new ArrayList();
					 EmpMaster=(EmpMaster)toDate.get(0);
					 frm.setToDate(empMaster.getToDate()); */
					}
					else	   
					{ 
					//System.out.println("Started the ----> fromDate in Action");  
					request.setAttribute("fromdates",EmpMasterData.getFromDates1(getDataSource(request)));
					/*
					 ArrayList fromDate=new ArrayList();
					 EmpMaster = (EmpMaster)fromDate.get(0);
					 frm.setFromDate(empMaster.getFromDate());
					 */
					 //System.out.println("Ended the ----> fromDate Action ");  
					}
				}catch(Exception e)
				{
					//System.out.println("Error in rws_UserAuditEntryAct_frm in data mode:"+e);
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
				//System.out.println("The error in Emp View is "+e);
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
				//System.out.println("the error in Emp get1 is "+e);
			}
		}
		
	 if(mode.equalsIgnoreCase("get2"))
	 {
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
			//System.out.println("Mandals Value in Action"+mandals);
		}
		
		}
	 	catch(Exception e)
		{
			//System.out.println("the error in Emp get2 is "+e);
		}
	 }
	

	//for Edit Emp_Entry_frm
		
		if(mode.equalsIgnoreCase("getData1"))
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
				//System.out.println("the error in Emp get1 is "+e);
			}
		}
		
	 if(mode.equalsIgnoreCase("getData2"))
	 {
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
		
		}
	 	catch(Exception e)
		{
			//System.out.println("the error in Emp get2 is "+e);
		}
	 }
	
	 
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{				
				emps=EmpMasterData.getEmps(frm.getHoc(),frm.getCoc(),frm.getDoc(),frm.getSdoc(),getDataSource(request));
				session.setAttribute("emps",emps);
				////System.out.println("EMPS "+emps);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Emp View is "+e);
			}
		}
				
		if(mode.equalsIgnoreCase("ViewDetails"))
		{
			try
			{
				emps=EmpMasterData.getEmpsView(getDataSource(request));
				request.setAttribute("emps",emps);
			}
			catch(Exception e)
			{
				//System.out.println("The error in getEmps ViewDetails "+e);
			}
		}
		
		
		//code Added 
		if(mode.equalsIgnoreCase("getSubDivisions"))
		{
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
			//System.out.println("the Subdivisions of View "+e);	
			}
		}
		
		if(mode.equalsIgnoreCase("getDivisions"))
		{
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
			//System.out.println("the Subdivisions of View "+e);	
			}
		}
		
		
		
		if(mode.equalsIgnoreCase("getCircles"))
		{
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
				//System.out.println("the Subdivisions of View "+e);	
				}
		}
			
		if(mode.equalsIgnoreCase("getDistricts"))
		{
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
				////System.out.println("the mandals in execute()"+mandals);
			}
			catch(Exception e)
			{
				//System.out.println("in getDistricts"+e);
			}
		}
		
		if(mode.equalsIgnoreCase("getDesigs"))
		{
			try
			{
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
				{
					desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					session.setAttribute("desgns",desgns);
				}
				else
					session.setAttribute("desgns",new ArrayList());
	    
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
				{
					desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					session.setAttribute("desgns1",desgns);
				}
				else
					session.setAttribute("desgns1",new ArrayList());
			}
			catch(Exception e)
			{
				//System.out.println("Error in getDesigns"+e);
			}
		}
		
		//end of code added
		
		
		//code added for the Emp Status Forms
		
		if(mode.equalsIgnoreCase("selectedOptions"))
		{
			try{
			heads = rwsOffices.getHeads();
			request.setAttribute("heads",heads);
			//code for Ajax testing
		
			String optionSelected = request.getParameter("optionSelected");
			////System.out.println("the value of selectedOptions"+optionSelected);
		    //Check of het soortId wel correct is
			if (request.getParameter("optionSelected")==null)
			{
			    ////System.out.println("No selected option supplied");
			    //PrintWriter out = response.getWriter();
			    //out.print("803");
			}
			else
			{
			List options =rwsOffices.getCircles(request.getParameter("hoc"));// getSecondOptions(selectedOption);
			//Make a String representation where each option is seperated by '||' and a valua and a label by ';'
			//System.out.println(options);
			////System.out.println(options);
			//String outLine = makeOutputString(options);
			//out.print(outLine); 
			}
			
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					////System.out.println(request.getParameter("Doc"));
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
			//System.out.println("Error in selectedOptions");
		}    
			//end of code for Ajax
	}
		
		if(mode.equalsIgnoreCase("getCircles1"))
		{
			try
			{
				////System.out.println("in getCircles1 of Action");
				circlecodes=rwsOffices.getCircles();
				session.setAttribute("circlecodes",circlecodes);
			}
			catch(Exception e){
				//System.out.println("the circles of Action "+e);	
				}
		}
		
		
		// code added for Ajax implementation
		
		if(mode.equalsIgnoreCase("cir"))
	     {
			//System.out.println("mode="+mode);
			EmpForm check=(EmpForm)form;
	     	try
			{	
	         //System.out.println("cirle code"+check.getOfficeCode());
	 	     //System.out.println("in Circle mode");
	 	     session.setAttribute("cCode",check.getOfficeCode());
	 	     //System.out.println(request.getParameter("officeCode"));
	 	     String div= RwsOffices.getOffices(getDataSource(request),request.getParameter("officeCode"));
	 	     ////System.out.println("div size is"+div);
	 	     
	 	     response.setContentType("text/html/XML");
	 	     java.util.Date date=new java.util.Date();
             long now=date.getTime();
             mode=null;
             response.setHeader("Expires",(now-(1000*60*60))+"");
	 	     java.io.PrintWriter out=response.getWriter();
	 	     out.println(div);
	 	     out.flush();
	 	     
	     	}
	     	catch(Exception e){//System.out.println("in geting Offices"+e);}
	     }
	  
		  if(mode.equalsIgnoreCase("div"))
		  {
		  	//System.out.println("mode="+mode);
		  	EmpForm check=(EmpForm)form;
		     	try
				{	
		         //System.out.println("cirle code"+check.getCircleCode());
		 	     //System.out.println("in division mode");
		 	     session.setAttribute("cCode",check.getCircleCode());
		 	      ////System.out.println(request.getParameter("divisionName"));
		 	     String div= RwsOffices.getDivisions(getDataSource(request),"1",request.getParameter("circleCode"));
		 	     ////System.out.println("div size is"+div);
		 	     
		 	     response.setContentType("text/html/XML");
		 	     java.util.Date date=new java.util.Date();
	             long now=date.getTime();
	             mode=null;
	             response.setHeader("Expires",(now-(1000*60*60))+"");
		 	     java.io.PrintWriter out=response.getWriter();
		 	     out.println(div);
		 	     out.flush();
		 	     
		     	}
		     	catch(Exception e){//System.out.println("in geting divisoins"+e);}
		     }
		  
		  
		  if(mode.equalsIgnoreCase("subDiv"))
		     {
		  	 try
			  {
		       String subdiv=RwsOffices.getSubDivisions(getDataSource(request),"1",request.getParameter("circleCode"),request.getParameter("divisionCode"));
			   //System.out.println("div size is"+subdiv.length());
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
		    	//System.out.println("in subDiv of Action"+e);
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
				////System.out.println("Without sector");
				sectorcode=rwsOffices.getHeads();
				request.setAttribute("sectorcode",sectorcode);
			}
			else if(request.getParameter("sector")!=null)
			{
				if(!(request.getParameter("sector")).equals("0"))
				{
					////System.out.println("with sector");
					sectorcode=rwsOffices.getHeads();
				}
			}		
			request.setAttribute("sectorcode",sectorcode);
			////System.out.println("sector value in Action"+request.getParameter("sector"));
			
			
			//code for Ajax		
			if(request.getParameter("hoc")!=null )//&& request.getParameter("hoc")=="1"
			{
				if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
				{
					circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					////System.out.println(request.getParameter("hoc"));
				}
			}
			request.setAttribute("circlecodes",circlecodes);
			
			if(request.getParameter("coc")!=null)
			{
				if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
					//System.out.println(request.getParameter("coc"));
				}
			}
			request.setAttribute("divcodes",divcodes);
			
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					////System.out.println(request.getParameter("Doc")+"DOC");
				}
			}
			
			if(request.getParameter("sdoc")!=null)
			{
				if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
				{
					request.setAttribute("hof",EmpMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));
					////System.out.println("hoc,coc,doc,sdoc"+request.getParameter("hoc")+request.getParameter("coc")+request.getParameter("doc")+request.getParameter("sdoc"));
				}
			}
			request.setAttribute("subdivcodes",subdivcodes);
			////System.out.println("detail wise"+request.getParameter("detailedWise"));		
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
			//System.out.println("error in Emp Status Form"+e);
		}
	}
		
		
	if(mode.equalsIgnoreCase("ViewReport"))
	{
		try
		{	
			////System.out.println("in side the View Report ");
			//frm.getSelectedItems();
			if(frm.getDetailedWise()!=null)
			{
			for(int i=0;i<frm.getSelectedItems().length;i++)
			{
				String select[]=frm.getSelectedItems();
				//System.out.println(select[i]);
			}
			}
			empsReport=EmpMasterData.getEmpsReport(frm.getHoc(),frm.getCoc(),frm.getDoc(),frm.getSdoc(),frm.getDetailedWise(),frm.getSelectedItems(),frm.getSector(),getDataSource(request));
			session.setAttribute("empsReport",empsReport);

			session.setAttribute("roc",empMaster.getRoc());
			session.setAttribute("hoc" ,empMaster.getHoc());
			session.setAttribute("coc",empMaster.getCoc());
			session.setAttribute("doc",empMaster.getDoc());
			session.setAttribute("sdoc",empMaster.getSdoc());
			

			session.setAttribute("empcode" ,empMaster.getEmpcode());
			session.setAttribute("surname" ,empMaster.getSurname());
			session.setAttribute("empname" ,empMaster.getEmpname());
			session.setAttribute("social" ,empMaster.getSocial());
			session.setAttribute("relation" ,empMaster.getRelation());
			session.setAttribute("gender" ,empMaster.getGender());
			session.setAttribute("religion" ,empMaster.getReligion());
			session.setAttribute("dob" ,empMaster.getDob());
			

			
			session.setAttribute("ndist" ,empMaster.getNdist());
			session.setAttribute("nmand" ,empMaster.getNmand());
			session.setAttribute("nrevenue" ,empMaster.getNrevenue());
			

			session.setAttribute("zone" ,empMaster.getZone());
		
			session.setAttribute("dept" ,empMaster.getDept());
			
			session.setAttribute("qualName" ,empMaster.getQualName());
			session.setAttribute("addqual1" ,empMaster.getQualName());
			session.setAttribute("addqual2" ,empMaster.getQualName());
			
			
			session.setAttribute("desgnCode" ,empMaster.getDesgnCode());
			session.setAttribute("desig" ,empMaster.getDesig());
			session.setAttribute("seniority" ,empMaster.getSeniority());
			session.setAttribute("workSpecial" ,empMaster.getWorkSpecial());
			session.setAttribute("section" ,empMaster.getSection());
		

		
			session.setAttribute("otherDet" ,empMaster.getOtherDet());
		
			
			
		}
		catch(Exception e)
		{
			//System.out.println("The error in Emp View is "+e);
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
		
		if(request.getParameter("department")!=null && request.getParameter("department").equalsIgnoreCase("RWS"))
		{
			DeptReport=EmpMasterData.getEmpDeptOpt(request.getParameter("department"),getDataSource(request));
			////System.out.println("employees1"+DeptReport);
			request.setAttribute("DeptReport",DeptReport);
		}
		else if(request.getParameter("department")!=null && request.getParameter("department").equalsIgnoreCase("PR"))
		{
			DeptReport=EmpMasterData.getEmpDeptOpt(request.getParameter("department"),getDataSource(request));
			////System.out.println("employees2"+DeptReport);
			request.setAttribute("DeptReport",DeptReport);
		}
		
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("C"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			////System.out.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("S"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			////System.out.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseworking")!=null && request.getParameter("spouseworking").equalsIgnoreCase("P"))
		{
			spouseworking=EmpMasterData.getSpousework(request.getParameter("spouseworking"),getDataSource(request));
			////System.out.println("spouseworking"+spouseworking);
			request.setAttribute("spouseworking",spouseworking);
		}
		if(request.getParameter("spouseemployd")!=null && request.getParameter("spouseemployd").equalsIgnoreCase("N"))
		{
			spouseemployd=EmpMasterData.getSpousework(request.getParameter("spouseemployd"),getDataSource(request));
			////System.out.println("spouseNotworking"+spouseemployd);
			request.setAttribute("spouseemployd",spouseemployd);
		}				
		try
		{
			fromdate=EmpMasterData.getFromDate(getDataSource(request));
			request.setAttribute("fromdate",fromdate);
			////System.out.println("fromdate values"+fromdate);
			
			catcodes=EmpMasterData.getCatogs(getDataSource(request));
			session.setAttribute("catcodes",catcodes);
			
			qualcodes=EmpMasterData.getQualNoName(getDataSource(request));
			session.setAttribute("qualcodes",qualcodes);
			
			if(request.getParameter("department")!=null)
			{
				request.setAttribute("DeptReport",request.getParameter("DeptReport"));
			}
			if(request.getParameter("spouseworking")!=null)
			{
				request.setAttribute("spouseworking",spouseworking);
			}
			
			if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
			{
				//System.out.println("in t");
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
			}
			else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
			{
				//System.out.println("in p");
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
			}
			else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("W"))
			{
				//System.out.println("in w");
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
			}
			else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("A"))
			{
				//System.out.println("in ALL");
				desgns=EmpMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
			}
			else
			{
				//System.out.println("in X");
				desgns=EmpMasterData.getDesgns("A",getDataSource(request));
			}
			session.setAttribute("desgns",desgns);
			
			//System.out.println("in ALL");
			desgns1=EmpMasterData.getDesgns("A",getDataSource(request));
			session.setAttribute("desgns1",desgns1);
						
		}
		catch(Exception e)
		{
			//System.out.println("error in getting date value"+e);
		}
	
	}
	
	if(mode.equalsIgnoreCase("DeptReport"))
	{
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
			//System.out.println("Error in Dept Report"+e);
		}
				
	}
	
	//end of Department opted code
	
		if(mode.equalsIgnoreCase("save"))
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
				empMaster.setDacctest(frm.getDacctest());
				empMaster.setAddqual1(frm.getAddqual1());
				empMaster.setAddqual2(frm.getAddqual2());
				empMaster.setPresentdesig(frm.getPresentdesig());
				////System.out.println("present DEsignatin in save   "+frm.getPresentdesig());
				empMaster.setWorkSpecial(frm.getWorkSpecial());
				////System.out.println("work special in save     "+frm.getWorkSpecial());				
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
				
							
				ans=EmpMasterData.insertEmp(empMaster,getDataSource(request));
				//System.out.println("inserted data into the table"+ans);
				//request.setAttribute("ecode",EmpMasterData.getEmpCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Emp Insert is "+e);
			}
			if(ans==null || ans.length <1 )
			{
				message="The Record Cant be inserted ";
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
				//System.out.println("empcode"+request.getParameter("empcode"));
				
				form =(EmpForm)buildEmpDesgnForm(request.getParameter("empcode"),mode,request);
				////System.out.println("spousewoek dist in GET"+((EmpForm)form).getSpouseworkdist());
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			} 
			catch (Exception e) 
			{
				//System.out.println("the error in Emp get is = "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("Update"))
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
					////System.out.println("DesgnCode"+frm.getDesgnCode());	
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("T"))
				{
					empMaster.setDesgnCode(frm.getDesgnCode());
					////System.out.println("DesgCode update"+frm.getDesgnCode());
				}
				else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("W"))
				{
					empMaster.setDesgnCode(frm.getDesgnCode());
					////System.out.println("DesgCode update"+frm.getDesgnCode());
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
				////System.out.println("present DEsignatin in save   "+frm.getPresentdesig());
				empMaster.setWorkSpecial(frm.getWorkSpecial());
				////System.out.println("work special in save     "+frm.getWorkSpecial());				
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
								
				message=EmpMasterData.updateEmp(empMaster,getDataSource(request));
				request.setAttribute("message",message);
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Emp edit is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{
			int del=0;
			try 
			{	
				
				
				del=EmpMasterData.removeEmp(request.getParameter("empcode"),getDataSource(request));	
				if(del>0)
				{
					displaymess = "Record Deleted Succesfully";
				}
				else
				{
					displaymess = "Record Cannot be Deleted";
					
				}
				request.setAttribute("displaymess",displaymess);
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Emp delete is "+e);
			}
		}
		//System.out.println(""+mode);
		return(mapping.findForward(mode));
	}
}
