package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Mandal_SubDivisionAct_frm extends Action
{
	protected ActionForm buildMandalSubDivisionForm(String coc,String doc,String sdoc,String dcode,String mcode,HttpServletRequest request) throws Exception 
	{
		MandalSubDivisionForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getMandalSubdivision(coc,doc,sdoc,dcode,mcode,getDataSource(request));
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc+"dcode="+dcode+"mcode="+mcode);
			if(rwsMaster!=null)
			{
				form = new MandalSubDivisionForm();
                //System.out.println("con="+rwsMaster.getCon()+"don="+rwsMaster.getDon()+"sdon="+rwsMaster.getSdon()+"dname="+rwsMaster.getDname()+"mname="+rwsMaster.getMandalName());
				form.setCoc(rwsMaster.getCoc());
				form.setDoc(rwsMaster.getDoc());
				form.setSdoc(rwsMaster.getSdoc());
				form.setDistrict(rwsMaster.getDcode());
				form.setMandal(rwsMaster.getMandalCode());
				form.setCon(rwsMaster.getCon());
				form.setDon(rwsMaster.getDon());
				form.setSdon(rwsMaster.getSdon());
				form.setDname(rwsMaster.getDname());
				form.setMandalName(rwsMaster.getMandalName());
								
			}
			return form;
	}
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			
			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}	
		
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList mandalSubdivisions=new ArrayList();
		ArrayList subdivisions=new ArrayList();
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList dists= new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList<LabelValueBean> panchayats = new ArrayList<LabelValueBean>();
		ArrayList<LabelValueBean> villages = new ArrayList<LabelValueBean>();
		ArrayList<LabelValueBean> habs = new ArrayList<LabelValueBean>();
		ArrayList<LabelValueBean> censusDistricts = new ArrayList<LabelValueBean>();
		ArrayList<LabelValueBean> censusSubDistricts = new ArrayList<LabelValueBean>();
		ArrayList<LabelValueBean> censusVillages = new ArrayList<LabelValueBean>();				
			
		MandalSubDivisionForm mandalSubDivisionForm=(MandalSubDivisionForm) form;
		String mode=mandalSubDivisionForm.getMode();
		//Debug.println("mode="+mode);
		// String mode=request.getParameter("mode");
		RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsMaster rwsMaster = new RwsMaster();
		//Debug.println("1");
		if(mode.equalsIgnoreCase("data")|| mode.equalsIgnoreCase("disp"))
		{
			try
			{
				dists=rwsLocation.getDistricts();
				circles=rwsOffices.getCircles("1");
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equals(""))
					{
						divisions = rwsOffices.getDivisions("1",request.getParameter("coc"));
						mandalSubDivisionForm.setDistrict(request.getParameter("coc"));
						mandalSubDivisionForm.setDname(rwsLocation.getDname(request.getParameter("coc")));
						mandals=rwsLocation.getMandals(request.getParameter("coc"));						
					}
					else{
						mandalSubDivisionForm.setDname("");
						mandalSubDivisionForm.setDistrict("");
					}					
				}
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equals(""))
					{
						subdivisions = rwsOffices.getSubdivisions("1",request.getParameter("coc"),request.getParameter("doc"));
						
					}
				}				
				dists=rwsLocation.getDistricts();
				session.setAttribute("dists",dists);
				session.setAttribute("mandals",mandals);
				session.setAttribute("circles",circles);
				session.setAttribute("divisions",divisions);
				session.setAttribute("subdivisions",subdivisions);
			}
			catch(Exception e)
			{
				//System.out.println("The code in SubDivision action data "+e);
			}
		}
		if(mode.equalsIgnoreCase("data1"))
		{
			try
			{
				session.removeAttribute("habss");
				dists=rwsLocation.getDistricts();
				circles=rwsOffices.getDistricts();
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equals(""))
					{
						mandals = rwsOffices.getMandals(request.getParameter("coc"));
					}
				}
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equals(""))
					{
						panchayats = rwsOffices.getPanchayats(request.getParameter("coc"),request.getParameter("doc"));
					}
				}
				if(request.getParameter("sdoc")!=null)
				{
					if(!(request.getParameter("sdoc")).equals(""))
					{
						villages = rwsOffices.getVillages(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"));
					}
				}
				if(request.getParameter("doc")!=null)
				{
					if(!(request.getParameter("doc")).equals(""))
					{
						subdivisions = rwsOffices.getSubdivisions("1",request.getParameter("coc"),request.getParameter("doc"));
						
					}
				}				
				dists=rwsLocation.getDistricts();
				session.setAttribute("dists",dists);
				session.setAttribute("mandals",mandals);
				session.setAttribute("circles",circles);
				session.setAttribute("divisions",divisions);
				session.setAttribute("subdivisions",subdivisions);
				session.setAttribute("panchayats",panchayats);
				session.setAttribute("villages",villages);
			}
			catch(Exception e)
			{
				//System.out.println("The code in SubDivision action data "+e);
			}
		}
		if(mode.equalsIgnoreCase("showData"))
		{
			try
			{
				mandals = rwsOffices.getMandals(request.getParameter("coc"));
				habs = rwsOffices.getHabitations(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"));
				session.setAttribute("mandals",mandals);
				session.setAttribute("habss",habs);
				String disableStatus = rwsOffices.getCensusVillageDisableStatus(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"));
				session.setAttribute("disableStatus",disableStatus);
				request.setAttribute("showDiv","true");
				//Debug.println("going");
				ArrayList habsData = rwsOffices.getCensusHabData(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"));
				//Debug.println("hhhhhhhhhhhhhhhh8888888888888:"+habsData.size());
				ArrayList censusVillageDetails = rwsOffices.getCensusVillage(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"));
				if(censusVillageDetails != null)
				{
					String vname = (String)censusVillageDetails.get(1);
					//Debug.println("1:"+vname);
					if(vname==null)vname="";
					mandalSubDivisionForm.setVcode(""+censusVillageDetails.get(0));
					//Debug.println("2:"+censusVillageDetails.get(0));
					//Debug.println("3 MAIN OR NOT:"+censusVillageDetails.get(2));
					if(censusVillageDetails.get(2)==null || (censusVillageDetails.get(2)!=null && censusVillageDetails.get(2).equals("N")))
					{
						mandalSubDivisionForm.setMain("null");
					}
					else if(censusVillageDetails.get(2)!=null && censusVillageDetails.get(2).equals("Y"))
					{
						mandalSubDivisionForm.setMain("on");
					}
					mandalSubDivisionForm.setVname(vname.toUpperCase());
				}
				else
				{
					mandalSubDivisionForm.setVcode("");
					mandalSubDivisionForm.setVname("");
					}
				//Debug.println("come out");
				session.setAttribute("habsData",habsData);
			}
			catch(Exception e)
			{
				Debug.println("error at show data in Rws_mandal_SubDivisionAct_frm:"+e.getMessage());
			}
		}
		if(mode.equalsIgnoreCase("showMandals"))
		{
			//Debug.println("in showMandals");
			try
			{ 
				censusDistricts = rwsOffices.getCensusDistricts();
				//Debug.println("in showMandals witrh dist code:"+request.getParameter("censusDistt"));
				//Debug.println("in showMandals witrh dist codeeeee:"+mandalSubDivisionForm.getCensusDistt());
				if(request.getParameter("censusDistt")!=null)
				{
					if(!(request.getParameter("censusDistt")).equals(""))
					{
						//Debug.println("census dists");
						censusSubDistricts = rwsOffices.getCensusSubDistricts(request.getParameter("censusDistt"));
						//Debug.println("sub dists size:"+censusSubDistricts.size());
					}
				}
				if(request.getParameter("censusSubDist")!=null)
				{
				//	Debug.println("in sub dists");
					if(!(request.getParameter("censusSubDist")).equals(""))
					{
						//Debug.println("in sub dists1");
						censusVillages = rwsOffices.getCensusVillages(request.getParameter("censusDistt"),request.getParameter("censusSubDist"));
						//Debug.println("Villages size:"+censusSubDistricts.size());
					}
				}
				
				//habs = rwsOffices.getCensusVillageInDistrict(request.getParameter("coc"),request.getParameter("doc"));
				//session.setAttribute("habs",habs);
				session.setAttribute("censusDistricts",censusDistricts);
				session.setAttribute("censusSubDistricts",censusSubDistricts);
				request.setAttribute("censusVillages",censusVillages);
				//Debug.println("in showMandals witrh dist at end codeeeee:"+mandalSubDivisionForm.getCensusDistt());
			}
			catch(Exception e)
			{
				Debug.println("error at showMandals in rws_madal_SubDivisionAct_frm:"+e.getMessage());
			}
		}
		if(mode.equalsIgnoreCase("populateVillage"))
		{
			try
			{
				mandals = rwsOffices.getMandals(request.getParameter("coc"));
				session.setAttribute("mandals",mandals);
				request.setAttribute("showDiv","true");
			}
			catch(Exception e)
			{
				Debug.println("error in show data:"+e.getMessage());
			}
		}
		if(mode.equalsIgnoreCase("saveHabData"))
		{
			try
			{

				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
				ArrayList habsss=(ArrayList)mandalSubDivisionForm.getHabsData();
				int recno=Integer.parseInt(request.getParameter("resultCount"));
				
				//Debug.println("census village code:"+mandalSubDivisionForm.getVcode());
				//Debug.println("census village name:"+mandalSubDivisionForm.getVname());
				String mainVillage = "";
				if(mandalSubDivisionForm.getMain() !=null && mandalSubDivisionForm.getMain().equals("on"))
					mainVillage = "Y";
				else
					mainVillage = "N";
				
				ans=RwsMasterData.saveCensusHab(getDataSource(request),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"),mandalSubDivisionForm.getVcode(),mandalSubDivisionForm.getVname(),mainVillage);
				if(ans>0)
				{
					request.setAttribute("message","Record(s) Inserted Successfully");
				}
				else
				{
					request.setAttribute("message","The Record(s) Cannot be inserted");
				}
				
				 /*for(int i = 1,j=0; i < recno+1; i++,j++)
				 {
				    if(request.getParameter("checks"+i)!=null)
					  {
				    	Debug.println("@@@@@@@@@@@@:"+request.getParameter("checks"+i));
				    	td = (tenderMemo)habsss.get(j);
				    	Debug.println("saved qp1 value:"+td.getQp1());
				    	Debug.println("saved qp2 value:"+td.getQp2());
				    	Debug.println("saved qp3 value:"+td.getQp3());
				    	Debug.println("saved qp4 value:"+td.getQp4());
				    	
						Debug.println("saved sc pop:"+td.getScPop());
						Debug.println("saved st pop:"+td.getStPop());
						Debug.println("saved plain pop:"+td.getPlainPop());
						Debug.println("saved sc cov:"+td.getScCov());
						Debug.println("Main:"+mandalSubDivisionForm.getMain());
						Debug.println("census village code:"+mandalSubDivisionForm.getVcode());
						Debug.println("census village name:"+mandalSubDivisionForm.getVname());
						
						tenderMemo td1 = new tenderMemo();
							td1.setHabCode(td.getHabCode());
							td1.setHabName(td.getHabName());
							if(td.getInQua() != null && td.getInQua().equals("on"))
								td1.setInQua("Y");
							else
								td1.setInQua("N");
							if(td.getQp1() !=null && td.getQp1().equals("on"))
								td1.setQp1("Y");
							else
								td1.setQp1("N");
							if(td.getQp2() !=null && td.getQp2().equals("on"))
								td1.setQp2("Y");
							else
								td1.setQp2("N");
							if(td.getQp3() !=null && td.getQp3().equals("on"))
								td1.setQp3("Y");
							else
								td1.setQp3("N");
							if(td.getQp4() !=null && td.getQp4().equals("on"))
								td1.setQp4("Y");
							else
								td1.setQp4("N");
							td1.setSfncpop(td.getSfncpop());
							td1.setScPop(td.getScPop());
							td1.setStPop(td.getStPop());
							td1.setPlainPop(td.getPlainPop());
							td1.setScCov(td.getScCov());
							td1.setStCov(td.getStCov());
							td1.setPlainCov(td.getPlainCov());
							td1.setVcode(mandalSubDivisionForm.getVcode());
							td1.setVname(mandalSubDivisionForm.getVname());
							if(mandalSubDivisionForm.getMain() !=null && mandalSubDivisionForm.getMain().equals("on"))
								td1.setMain("Y");
							else
								td1.setMain("N");
						ans=RwsMasterData.saveCensusHab(td1,getDataSource(request),request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("mandal"));
						if(ans>0)
						{
							request.setAttribute("message","Record(s) Inserted Successfully");
						}
						else
						{
							request.setAttribute("message","The Record(s) Cannot be inserted");
						}
					  }
				 }*/
				//ans=RwsMasterData.insertMandalSubDivision(rwsMaster,getDataSource(request));
				mandals = rwsOffices.getMandals(request.getParameter("coc"));
				session.setAttribute("mandals",mandals);
				request.setAttribute("showDiv","true");
				session.setAttribute("habsData",habsss);
			     }
			}catch(Exception e)	{
				Debug.println("error in show data:"+e.getMessage());
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			 session = request.getSession();
		     String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {						
					try
					{
						//System.out.println("coc="+mandalSubDivisionForm.getCoc()+"doc="+mandalSubDivisionForm.getDoc()+"sdoc="+mandalSubDivisionForm.getSdoc()+"dcode="+mandalSubDivisionForm.getDistrict()+"mcode="+mandalSubDivisionForm.getMandal());
								
						rwsMaster.setCoc(mandalSubDivisionForm.getCoc());
						rwsMaster.setDoc(mandalSubDivisionForm.getDoc());
						rwsMaster.setSdoc(mandalSubDivisionForm.getSdoc());						
						rwsMaster.setDistrict(mandalSubDivisionForm.getDistrict());
						rwsMaster.setMandal(mandalSubDivisionForm.getMandal());
						ans=RwsMasterData.insertMandalSubDivision(rwsMaster,getDataSource(request));
						 //System.out.println("ans="+ans);
						mandalSubDivisionForm.reset(mapping,request);
					}
					catch(Exception e)
					{
						//System.out.println("the error in SubDivision Insert is "+e);
					}
		     }
			if(ans <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be inserted";
			 				
			}
			else
			{
				message="Record Inserted Successfully";
				 
			}
			
			request.setAttribute("message",message);
	}
	
	if(mode.equalsIgnoreCase("view"))
	{
		try
		{ //System.out.println("In View dcode="+(String)request.getAttribute("dcode"));
		    
		    if(mandalSubDivisionForm.getDistrict()!=null && !mandalSubDivisionForm.getDistrict().equals("")){	
		    	//System.out.println("dcode in mandalget="+mandalSubDivisionForm.getDistrict());
		       mandalSubdivisions=RwsMasterData.getMandalSubDivisions(getDataSource(request),mandalSubDivisionForm.getDistrict());
		    }else{
		    	//System.out.println("request dcode="+request.getParameter("dcode"));
		    	if(request.getParameter("dcode")!=null && !request.getParameter("dcode").equals(""))
		    		mandalSubdivisions=RwsMasterData.getMandalSubDivisions(getDataSource(request),request.getParameter("dcode"));
		    	else 
		    		mandalSubdivisions=RwsMasterData.getMandalSubDivisions(getDataSource(request),(String)request.getAttribute("dcode"));
		    }	
			session.setAttribute("mandalSubdivisions",mandalSubdivisions);
			 
		}
		catch(Exception e)
		{
			//System.out.println(e);
		}
		
	}
	if(mode.equalsIgnoreCase("get"))
	{
		try 
		{   //System.out.println("fdd");
		    if(request.getParameter("dcode")==null)
		    	form = buildMandalSubDivisionForm(mandalSubDivisionForm.getCoc(),mandalSubDivisionForm.getDoc(),mandalSubDivisionForm.getSdoc(),mandalSubDivisionForm.getDistrict(),mandalSubDivisionForm.getMandal(),request);
		    else	
		    	form = buildMandalSubDivisionForm(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("dcode"),request.getParameter("mandalCode"),request);
			if(request.getParameter("dcode")!=null)
			{
				if((request.getParameter("dcode")).length() != 0)
				{
					mandals=rwsLocation.getMandals(request.getParameter("dcode"));
				}
			 session.setAttribute("mandal",request.getParameter("mandalCode"));
			}
			else{
				mandals=rwsLocation.getMandals(mandalSubDivisionForm.getDistrict());
				session.setAttribute("mandal",mandalSubDivisionForm.getMandal());
			}	
			session.setAttribute("mandals",mandals);
			circles=rwsOffices.getCircles("1");
			session.setAttribute("coc",request.getParameter("coc"));
			if(request.getParameter("coc")!=null)
			{
				if(!(request.getParameter("coc")).equals("00"))
				{
					divisions = rwsOffices.getDivisions("1",request.getParameter("coc"));
					
				}
				 session.setAttribute("doc",request.getParameter("doc"));
			}
			session.setAttribute("divisions",divisions);
			if(request.getParameter("doc")!=null)
			{
				if(!(request.getParameter("doc")).equals("0"))
				{
					subdivisions = rwsOffices.getSubdivisions("1",request.getParameter("coc"),request.getParameter("doc"));
					
				}
				 session.setAttribute("sdoc",request.getParameter("sdoc"));
			}
			session.setAttribute("subdivisions",subdivisions);
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
			//System.out.println("the error in rws_MandalSubDivisionAccEntryAct_frm in get is= "+e);
		}
	}
	if(mode.equalsIgnoreCase("edit"))
	{
		session = request.getSession();
	     String storedToken = (String)session.getAttribute("csrfToken");
	     String token = request.getParameter("token");
	     if (storedToken.equals(token))
	     {		
			try
				{    
	                 rwsMaster.setCoc(mandalSubDivisionForm.getCoc());
	                 rwsMaster.setDoc(mandalSubDivisionForm.getDoc());
	                 rwsMaster.setSdoc(mandalSubDivisionForm.getSdoc());
	                 rwsMaster.setDistrict(mandalSubDivisionForm.getDistrict());
	                 rwsMaster.setMandalCode(mandalSubDivisionForm.getMandal());
	                 ans=RwsMasterData.updateMandalSubDivision((String)session.getAttribute("mandal"),(String)session.getAttribute("sdoc"),(String)session.getAttribute("doc"),(String)session.getAttribute("coc"),rwsMaster,getDataSource(request));
				}				 
				catch (Exception e) 
				{
					//System.out.println("the error in rws_MandalSubDivisionEntryAct_frm in edit is= "+e);
				}
	     }
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
			    mode = "get";
 		 }
			else
			{
				message="Record Updated Successfully";
			
			}
			try{
			    mandals=rwsLocation.getMandals(mandalSubDivisionForm.getDistrict());
			    //System.out.println("coc="+mandalSubDivisionForm.getCoc()+"doc="+mandalSubDivisionForm.getDoc());
				divisions = rwsOffices.getDivisions("1",mandalSubDivisionForm.getCoc());
			    subdivisions = rwsOffices.getSubdivisions("1",mandalSubDivisionForm.getCoc(),mandalSubDivisionForm.getDoc());
				session.setAttribute("mandals",mandals);
				session.setAttribute("divisions",divisions);
			    session.setAttribute("subdivisions",subdivisions);
			}catch(Exception e){
			  	//System.out.println("error in edit="+e.getMessage());
		   }
		   request.setAttribute("message",message);
			 
		 
	}
	if(mode.equalsIgnoreCase("delete"))
	{	
		try 
			{
				//System.out.println("district="+request.getParameter("dcode"));
				request.setAttribute("dcode",request.getParameter("dcode"));
				int del=RwsMasterData.removeMandalSubDivision(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("dcode"),request.getParameter("mandalCode"),getDataSource(request));
				if(del>0)
				{
					displaymess = "Data deleted Succesfully";
				}else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				//System.out.println("the outor is"+e);
			}
	  }	
	if(mode != null && mode.equalsIgnoreCase("resetForm"))
	{
		//System.out.println("it is in resetForm");
		try{
			mandalSubDivisionForm.reset(mapping,request);
			 dists.clear();
			 mandalSubdivisions.clear();
			 subdivisions.clear();			
			 divisions.clear();
			 dists.clear();
			 mandals.clear();	
		}
		catch(Exception e)
		{
			//System.out.println("error="+e.getMessage());
		}
	}
	return(mapping.findForward(mode));
}

	

}
