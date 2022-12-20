package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_EmpEntryAct_frm extends Action
{
	ArrayList heads=new ArrayList();
	ArrayList circlecodes=new ArrayList();
	ArrayList divcodes=new ArrayList();
	ArrayList subdivcodes=new ArrayList();
	ArrayList addqualcodes=new ArrayList();
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	
	//added on aug232007
	ArrayList addqualcodes2=new ArrayList();
	ArrayList addqualcodes1=new ArrayList();
	ArrayList zonecodes=new ArrayList();
	ArrayList desgns=new ArrayList();
	ArrayList SocialCodes=new ArrayList();
	
	
	protected ActionForm buildEmpDesgnForm(String empcode,String mode,HttpServletRequest request) throws Exception 
	{
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		EmpForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getEmp(empcode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				// added on aug232007
				form = new EmpForm();
				String code=rwsMaster.getEmpcode();
				
				form.setRoc(rwsMaster.getRoc());//48				
				form.setEmpcode(rwsMaster.getEmpcode());//1
				////System.out.println("rwsMaster.getEmpname()"+rwsMaster.getEmpname());
				form.setSurname(rwsMaster.getSurname());//2
				form.setEmpname(rwsMaster.getEmpname());//3
				form.setGender(rwsMaster.getGender());//added on aug312007//4
				form.setRelation(rwsMaster.getRelation());//5
				form.setDob(rwsMaster.getDob());//6
				form.setSocial(rwsMaster.getSocial());//8
				form.setQual(rwsMaster.getQual());//12
				form.setNdist(rwsMaster.getNdist());//9
				form.setNmand(rwsMaster.getNmand());//10
				form.setNrevenue(rwsMaster.getNrevenue());//11
				form.setReligion(rwsMaster.getReligion());//7
				
				form.setDiststudied4(rwsMaster.getDiststudied4());//diststudied4//13
				form.setDiststudied5(rwsMaster.getDiststudied5());//14
				form.setDiststudied6(rwsMaster.getDiststudied6());//15
				form.setDiststudied7(rwsMaster.getDiststudied7());//16
				form.setDiststudied8(rwsMaster.getDiststudied8());//17
				form.setDiststudied9(rwsMaster.getDiststudied9());//18
				form.setDiststudied10(rwsMaster.getDiststudied10());//19
				form.setLocaldist(rwsMaster.getLocaldist());//20
				form.setNoofyrs(rwsMaster.getNoofyrs());//21
				form.setLocalzone(rwsMaster.getLocalzone());//22
				form.setNoofyrs1(rwsMaster.getNoofyrs1());//23
				form.setPvtdist(rwsMaster.getPvtdist());//24
				form.setPvtzone(rwsMaster.getPvtzone());//25
				form.setDesig(rwsMaster.getDesig());//26
				form.setDesgnCode(rwsMaster.getDesgnCode());//27
				//if(rwsMaster.getDesig()!=null && rwsMaster.getDesig().equals("P"))
				//{
					
					////System.out.println("DesgnCode"+form.getDesgnCode());	
				//}
				//else if(rwsMaster.getDesig()!=null && rwsMaster.getDesig().equals("T"))
				//{
					//form.setDesgnCode(rwsMaster.getDesgnCode());
					//form.setTempdesgCode(rwsMaster.getTempdesgCode());
					////System.out.println("TempDesgCode"+form.getTempdesgCode());
				//}
				form.setAppointdate(rwsMaster.getAppointdate());//28
				form.setDoj(rwsMaster.getDoj());//29
				form.setMoap(rwsMaster.getMoap());//30
				form.setZone(rwsMaster.getZone());//31
				form.setNarecruit(rwsMaster.getNarecruit());//32
				form.setApcatog(rwsMaster.getApcatog());//33
				
				form.setDcommprob(rwsMaster.getDcommprob());//34
				form.setDdeclprob(rwsMaster.getDdeclprob());//35
				form.setCurrentpostdate(rwsMaster.getCurrentpostdate());//36
				form.setDacctest(rwsMaster.getDacctest());//37
				//form.setPresentation(rwsMaster.getPresentation());
				form.setDeputation(rwsMaster.getDeputation());//38
				form.setAddqual1(rwsMaster.getAddqual1());//39
				form.setAddqual2(rwsMaster.getAddqual2());//40
				form.setPresentdesig(rwsMaster.getPresentdesig());//41
				form.setWorkSpecial(rwsMaster.getWorkSpecial());//42
				form.setOtherDet(rwsMaster.getOtherDet());//43
				
				form.setPanno(rwsMaster.getPanno());//44
				form.setApgli(rwsMaster.getApgli());//45
				form.setPayscale(rwsMaster.getPayscale());//46
				form.setIncrementdate(rwsMaster.getIncrementdate());//47
				//form.setUpdatedate(rwsMaster.getUpdatedate());
				form.setGpfno(rwsMaster.getGpfno());//49
				form.setTestpassed(rwsMaster.getTestpassed());//50
				
				
				if(form.getNdist()!=null && !form.getNdist().equalsIgnoreCase("00"))
				{
					mandals=rwsOffices.getDistrictMandals(form.getNdist());
				}
				session.setAttribute("mandals",mandals);
				////System.out.println("the manadals details");
								
				form.setHoc(rwsMaster.getRoc().substring(0,1));//49
				////System.out.println("the HOC value"+rwsMaster.getRoc().substring(0,1));
				try
				{
				if(!rwsMaster.getRoc().substring(0,1).equalsIgnoreCase("0"))
				{
					//circlecodes = RwsMasterData.getCircleCodes(rwsMaster.getRoc().substring(0,1),getDataSource(request));
					//circlecodes=rwsOffices.getCircles("1");
					circlecodes = rwsOffices.getCircles(rwsMaster.getRoc().substring(0,1));
					//circlecodes = rwsOffices.getCircles(rwsMaster.getRoc().substring(0,1),getDataSource(request));
				}
				session.setAttribute("circlecodes",circlecodes);
				////System.out.println("circlecodes"+circlecodes);
				
				form.setCoc(rwsMaster.getRoc().substring(1,3));
				if(!rwsMaster.getRoc().substring(1,3).equalsIgnoreCase("00"))
				{
					divcodes = rwsOffices.getDivisions(rwsMaster.getRoc().substring(0,1),rwsMaster.getRoc().substring(1,3));
				}
				session.setAttribute("divcodes",divcodes);
				////System.out.println("divcodes"+divcodes);
				
				form.setDoc(rwsMaster.getRoc().substring(3,4));
				if(!rwsMaster.getRoc().substring(3,4).equalsIgnoreCase("0"))
				{
					subdivcodes = rwsOffices.getSubdivisions(rwsMaster.getRoc().substring(0,1),rwsMaster.getRoc().substring(1,3),rwsMaster.getRoc().substring(3,4));
				}
				session.setAttribute("subdivcodes",subdivcodes);
				////System.out.println("subdivcodes"+subdivcodes);
				
				form.setSdoc(rwsMaster.getRoc().substring(4,6));
				////System.out.println("SDOC"+rwsMaster.getRoc().substring(4,6));
				}
				catch(Exception e)
				{
					////System.out.println("Exception in office codes"+e);
				}
				//added on Aug 4
				
				if(rwsMaster.getQual()!= null)
				{
					addqualcodes = RwsMasterData.getAddQualCodes(rwsMaster.getQual(),getDataSource(request));
				}
				session.setAttribute("addqualcodes",addqualcodes);
				
				
				/*if(rwsMaster.getAddqual2()!=null)
				{
					addqualcodes2 = RwsMasterData.getAddQualCodes(rwsMaster.getAddqual2(),getDataSource(request));
				}
				session.setAttribute("addqualcodes2",addqualcodes2);
				
			     if(rwsMaster.getAddqual1()!=null)
				{
					addqualcodes1 = RwsMasterData.getAddQualCodes(rwsMaster.getAddqual1(),getDataSource(request));
				}
				session.setAttribute("addqualcodes1",addqualcodes1);*/
				//added on aug302007
				
				//System.out.println("build desig form********************************** in the Edit Part");
			}
		return form;
	}
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		ArrayList desgns=new ArrayList();
		ArrayList qualcodes=new ArrayList();
		ArrayList workSpecs=new ArrayList();
		ArrayList posts=new ArrayList();
		ArrayList modes=new ArrayList();
		ArrayList castes=new ArrayList();
		ArrayList religions=new ArrayList();
		ArrayList zonecodes=new ArrayList();
		ArrayList catcodes=new ArrayList();
		String payscale=null;
		String message=null;
		String displaymess=null;
		ArrayList emps=null;
		RwsMasterData rwsMasterData = new RwsMasterData();
		RwsMaster rwsMaster = new RwsMaster();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		
		
		EmpForm frm=(EmpForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();

		if(mode.equalsIgnoreCase("data")||mode.equalsIgnoreCase("update"))
		{
			try
			{
				//System.out.println("in sdoc tell me ="+request.getParameter("sdoc"));
				//System.out.println("in desig tell me ="+request.getParameter("desig"));
				//request.setAttribute("ecode",RwsMasterData.getEmpCode(getDataSource(request)));
				//added on 21 july
				
				religions=RwsMasterData.getReligions(getDataSource(request));
				session.setAttribute("religions",religions);
				
				castes=RwsMasterData.getCastes(getDataSource(request));
				session.setAttribute("castes",castes);
				
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
				
				qualcodes=RwsMasterData.getQualNoName(getDataSource(request));
				session.setAttribute("qualcodes",qualcodes);
				
				zonecodes=RwsMasterData.getZones(getDataSource(request));
				session.setAttribute("zonecodes",zonecodes);
				
				modes=RwsMasterData.getModeOfAppt(getDataSource(request));
				session.setAttribute("modes",modes);
				
				catcodes=RwsMasterData.getCatogs(getDataSource(request));
				session.setAttribute("catcodes",catcodes);
				
				workSpecs=RwsMasterData.getWorkSpecs(getDataSource(request));
				session.setAttribute("workSpecs",workSpecs);
				
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				
				if(request.getParameter("hoc")!=null)
				{
					//if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
					    if(request.getParameter("hoc").equals("1"))
					    		{
					//{
						circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					    		}
					    else if(request.getParameter("hoc").equals("2"))
					    {
					    	circlecodes=rwsOffices.getPRCircles();
					    }
					    else if(request.getParameter("hoc").equals("3"))
					    {
					    	circlecodes=rwsOffices.getQCCircles();
					    }
					//}
				}
				session.setAttribute("circlecodes",circlecodes);
				
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00") && request.getParameter("hoc").equals("1"))
					{
						divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
					}
					else if(!(request.getParameter("coc")).equalsIgnoreCase("00") && request.getParameter("hoc").equals("2"))
					{
						divcodes = rwsOffices.getPRDivisions(request.getParameter("coc"));
					}
					else if(!(request.getParameter("coc")).equalsIgnoreCase("00") && request.getParameter("hoc").equals("3"))
					{
						divcodes = rwsOffices.getQCDivisions(request.getParameter("coc"));
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
				session.setAttribute("subdivcodes",subdivcodes);
				
			   if(request.getParameter("sdoc")!=null)
				{
					if(!(request.getParameter("sdoc")).equalsIgnoreCase("00"))
					{
						request.setAttribute("hof",RwsMasterData.getEmployee(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),getDataSource(request)));	
					}
						
				}
				
				if(request.getParameter("qual")!=null)
				{
					if(!(request.getParameter("qual")).equalsIgnoreCase(""))
					{
						addqualcodes = RwsMasterData.getAddQualCodes(request.getParameter("qual"),getDataSource(request));
					}
				}
				session.setAttribute("addqualcodes",addqualcodes);
				
				posts=RwsMasterData.getEmps(getDataSource(request));
				session.setAttribute("posts",posts);
			
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
				{
					//System.out.println("in t");
				desgns=RwsMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
				}
				
				else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
				{
					//System.out.println("in p");
					desgns=RwsMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					
				}
				else if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("W"))
				{
					//System.out.println("in w");
					desgns=RwsMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					
				}
				else
				{
					//System.out.println("in X");
					desgns=RwsMasterData.getDesgns("P",getDataSource(request));
				}
				session.setAttribute("desgns",desgns);
				
				if(request.getParameter("desgnCode")!=null)
				{
				payscale = RwsMasterData.getPayScales(request.getParameter("desgnCode"),getDataSource(request));
				}
				request.setAttribute("payscale",payscale);
				//added on july 21
				if(request.getParameter("empcode")!=null)
				{
					//System.out.println("in empcode");
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
					request.setAttribute("updatedate",request.getParameter("update"));
				}
				
		}
		catch(Exception e)
		{
			//System.out.println("the error in empname"+e);
		}

		}
		//code added on aug 23 2007
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{				
				emps=RwsMasterData.getEmps(frm.getHoc(),frm.getCoc(),frm.getDoc(),frm.getSdoc(),getDataSource(request));
				request.setAttribute("emps",emps);
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
				emps=RwsMasterData.getEmps(getDataSource(request));
				request.setAttribute("emps",emps);
			}
			catch(Exception e)
			{
				//System.out.println("The error in getEmps ViewDetails "+e);
			}
		}
//		code Added on aug 23 2007
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
			////System.out.println("the Subdivisions of View "+e);	
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
			////System.out.println("the Subdivisions of View "+e);	
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
				////System.out.println("the Subdivisions of View "+e);	
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
				////System.out.println("in getDistricts"+e);
			}
		}
		
		if(mode.equalsIgnoreCase("getDesigs"))
		{
			try
			{
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("T"))
				{
					desgns=RwsMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					session.setAttribute("desgns",desgns);
				}
				else
					session.setAttribute("desgns",new ArrayList());
	    
				if(request.getParameter("desig")!=null && request.getParameter("desig").equalsIgnoreCase("P"))
				{
					desgns=RwsMasterData.getDesgns(request.getParameter("desig"),getDataSource(request));
					session.setAttribute("desgns1",desgns);
				}
				else
					session.setAttribute("desgns1",new ArrayList());
			}
			catch(Exception e)
			{
				////System.out.println("Error in getDesigns"+e);
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
	 		districts = rwsOffices.getDistricts();
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
		}
		session.setAttribute("mandals",mandals);
		}
	 	catch(Exception e)
		{
			//System.out.println("the error in Emp get2 is "+e);
		}
	 }
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				rwsMaster.setHoc(frm.getHoc());//44
				//rwsMaster.setSector(frm.getSector());
				rwsMaster.setEmpcode(frm.getEmpcode());//1
				//added on july 21
				rwsMaster.setSurname(frm.getSurname());//2
				
				rwsMaster.setEmpname(frm.getEmpname());//3
				
				//added on july 21
				rwsMaster.setGender(frm.getGender());//4
				rwsMaster.setNrevenue(frm.getNrevenue());//11
				
				rwsMaster.setRelation(frm.getRelation());//5
				rwsMaster.setCasteCode(frm.getSocial());//8
				rwsMaster.setRelgCode(frm.getReligion());//7
				rwsMaster.setDob(frm.getDob());//6
				rwsMaster.setDistrict(frm.getNdist());//9
				rwsMaster.setMandal(frm.getNmand());//10
				rwsMaster.setAppointdate(frm.getAppointdate());//28
				rwsMaster.setDoj(frm.getDoj());//29
				rwsMaster.setMoapCode(frm.getMoap());//30
				rwsMaster.setQualCode(frm.getQual());//12
				rwsMaster.setZoneCode(frm.getZone());//31
				rwsMaster.setNarecruit(frm.getNarecruit());//32
				rwsMaster.setCatCode(frm.getApcatog());//33
				rwsMaster.setDacctest(frm.getDacctest());//38
				rwsMaster.setRoc(frm.getRoc());
				rwsMaster.setDesig(frm.getDesig());//26
				rwsMaster.setDesgnCode(frm.getDesgnCode());//27
				//rwsMaster.setTempdesgCode(frm.getDesgnCode());
				rwsMaster.setDcommprob(frm.getDcommprob());//34
				rwsMaster.setDdeclprob(frm.getDdeclprob());//35
				rwsMaster.setCurrentpostdate(frm.getCurrentpostdate());//36
				rwsMaster.setTestpassed(frm.getTestpassed());//37
				rwsMaster.setDeputation(frm.getDeputation());//45
				rwsMaster.setAddqual1(frm.getAddqual1());//39
				rwsMaster.setAddqual2(frm.getAddqual2());//40
				//rwsMaster.setPresentation(frm.getPresentation());//41
				rwsMaster.setWorkSpecCode(frm.getWorkSpecial());//42
				rwsMaster.setOtherDet(frm.getOtherDet());//43
				rwsMaster.setPanno(frm.getPanno());//46
				rwsMaster.setAplgi(frm.getApgli());//47
				rwsMaster.setPayscale(frm.getPayscale());//49
				rwsMaster.setIncrementdate(frm.getIncrementdate());//50
				rwsMaster.setPresentdesig(frm.getPresentdesig());//41
				
				
				//System.out.println("diststudied4"+frm.getDiststudied4());
				rwsMaster.setDiststudied4(frm.getDiststudied4());//13
				
				rwsMaster.setDiststudied5(frm.getDiststudied5());//14
				rwsMaster.setDiststudied6(frm.getDiststudied6());//15
				rwsMaster.setDiststudied7(frm.getDiststudied7());//16
				rwsMaster.setDiststudied8(frm.getDiststudied8());//17
				rwsMaster.setDiststudied9(frm.getDiststudied9());//18
				rwsMaster.setDiststudied10(frm.getDiststudied10());//19
				rwsMaster.setLocaldist(frm.getLocaldist());//20
				rwsMaster.setLocalzone(frm.getLocalzone());//21
				rwsMaster.setNoofyrs(frm.getNoofyrs());//22
				rwsMaster.setNoofyrs1(frm.getNoofyrs1());//23
				rwsMaster.setPvtdist(frm.getPvtdist());//24
				rwsMaster.setPvtzone(frm.getPvtzone());//25
				rwsMaster.setUpdatedate(frm.getUpdatedate());//51
				rwsMaster.setGpfno(frm.getGpfno());//48
				
				
				
				/*rwsMaster.setPhone(frm.getPhone());
				rwsMaster.setMobile(frm.getMobile());
				rwsMaster.setTotalworkscomp(frm.getTotalworkscomp());
				rwsMaster.setQual(frm.getQual());
				rwsMaster.setAddqual1(frm.getAddqual1());
			
				rwsMaster.setHof(frm.getHof());
				rwsMaster.setPresentation(frm.getPresentation());
				rwsMaster.setOtherDet(frm.getOtherDet());
				rwsMaster.setDesgnCode(frm.getDesgnCode());
				rwsMaster.setCheckType(frm.getCheckType());
				rwsMaster.setNoOfChecks(frm.getNoOfChecks());
				rwsMaster.setCheckPeriod(frm.getCheckPeriod());
				rwsMaster.setAppOrderRef(frm.getAppOrderRef());
				rwsMaster.setWorkSpecial(frm.getWorkSpecial());
				rwsMaster.setPostCode(frm.getPostCode());
				rwsMaster.setDesgnCode(frm.getDesgnCode());*/
				
				
				ans=RwsMasterData.insertEmp(rwsMaster,getDataSource(request));
				//System.out.println(" in anssssssssssssss"+ans);
				//request.setAttribute("ecode",RwsMasterData.getEmpCode(getDataSource(request)));
				
				
			}
			catch(Exception e)
			{
				//System.out.println("the error in Emp Insert is "+e);
			}
			if(ans <1)
			{
				message="The Record Cant be inserted  already code exists ";
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
				form =buildEmpDesgnForm(request.getParameter("empcode"),mode,request);
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
		// added on aug 23 2007
		if(mode.equalsIgnoreCase("update"))
		{
			try
			{
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setRoc(frm.getRoc());
				rwsMaster.setEmpcode(frm.getEmpcode());
				rwsMaster.setSurname(frm.getSurname());
				rwsMaster.setEmpname(frm.getEmpname());
				rwsMaster.setGender(frm.getGender());//added on sep 1st
				
				rwsMaster.setRelation(frm.getRelation());
				rwsMaster.setDob(frm.getDob());
				rwsMaster.setCasteCode(frm.getSocial());
				rwsMaster.setQual(frm.getQual());
				rwsMaster.setDistrict(frm.getNdist());
				rwsMaster.setMandal(frm.getNmand());
				rwsMaster.setNrevenue(frm.getNrevenue());
				rwsMaster.setRelgCode(frm.getReligion());
				
				
				//Added on Aug 3
				rwsMaster.setDiststudied4(frm.getDiststudied4());//diststudied4
				rwsMaster.setDiststudied5(frm.getDiststudied5());
				rwsMaster.setDiststudied6(frm.getDiststudied6());
				rwsMaster.setDiststudied7(frm.getDiststudied7());
				rwsMaster.setDiststudied8(frm.getDiststudied8());
				rwsMaster.setDiststudied9(frm.getDiststudied9());
				rwsMaster.setDiststudied10(frm.getDiststudied10());
				rwsMaster.setLocaldist(frm.getLocaldist());
				rwsMaster.setLocalzone(frm.getLocalzone());
				rwsMaster.setNoofyrs(frm.getNoofyrs());
				////System.out.println("no of yrs update()"+frm.getNoofyrs());
				rwsMaster.setNoofyrs1(frm.getNoofyrs1());
				////System.out.println("no of yrs1 update()"+frm.getNoofyrs1());
				rwsMaster.setPvtdist(frm.getPvtdist());
				rwsMaster.setPvtzone(frm.getPvtzone());
				
				rwsMaster.setDesig(frm.getDesig());
				////System.out.println("Desig"+frm.getDesig());
				if(rwsMaster.getDesig()!=null && rwsMaster.getDesig().equals("P"))
				{
					rwsMaster.setDesgnCode(frm.getDesgnCode());
					//System.out.println("DesgnCode"+frm.getDesgnCode());	
				}
				else if(rwsMaster.getDesig()!=null && rwsMaster.getDesig().equals("T"))
				{
					rwsMaster.setTempdesgCode(frm.getTempdesgCode());
					//System.out.println("TempDesgCode update"+frm.getTempdesgCode());
				}
				rwsMaster.setAppointdate(frm.getAppointdate());
				rwsMaster.setDoj(frm.getDoj());
				rwsMaster.setMoapCode(frm.getMoap());
				rwsMaster.setZoneCode(frm.getZone());
				rwsMaster.setNarecruit(frm.getNarecruit());
				rwsMaster.setApcatog(frm.getApcatog());
				
				rwsMaster.setDcommprob(frm.getDcommprob());
				rwsMaster.setDdeclprob(frm.getDdeclprob());
				rwsMaster.setCurrentpostdate(frm.getCurrentpostdate());
				rwsMaster.setDacctest(frm.getDacctest());
				rwsMaster.setPresentation(frm.getPresentation());
				rwsMaster.setDeputation(frm.getDeputation());//added on sep 1
				
				rwsMaster.setAddqual1(frm.getAddqual1());//added on sep 1st
				rwsMaster.setAddqual2(frm.getAddqual2());
				rwsMaster.setPresentdesig(frm.getPresentdesig());//added on sep 1st
				rwsMaster.setWorkSpecial(frm.getWorkSpecial());
				rwsMaster.setOtherDet(frm.getOtherDet());
				//ADDED ON SEP 1ST
			    rwsMaster.setPanno(frm.getPanno());
			    rwsMaster.setApgli(frm.getApgli());
			    rwsMaster.setPayscale(frm.getPayscale());
			    rwsMaster.setIncrementdate(frm.getIncrementdate());
			    
			    
			    
								
				message=RwsMasterData.updateEmp(rwsMaster,getDataSource(request));
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
				del=RwsMasterData.removeDesgn(request.getParameter("empcode"),getDataSource(request));	
				if(del>0)
				{
					displaymess = "Data deleted Succesfully";
				}
				else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Emp delete is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
