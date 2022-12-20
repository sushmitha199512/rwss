package nic.watersoft.masters;
import java.io.IOException;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_PanchRajEntryAct_frm extends Action
{		
	int[] rcount;
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		Connection conn = null;
		Statement stmt = null;
		int ans = 0;
		String message=null;
		ArrayList dists=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchyats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList prhabs=new ArrayList();
		Collection panchRajs = new ArrayList();
		HttpSession session=request.getSession();
		RwsMaster rwsMaster = new RwsMaster();
		RwsLocationBean rwsLocationBean = new RwsLocationBean();
		PanchRaj panchRaj = new PanchRaj();
		PanchRajForm panchRajForm = (PanchRajForm) form;
		RwsLocations rwsLocations = new RwsLocations (getDataSource(request));
		String mode=panchRajForm.getMode();

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
				dists=rwsLocation.getDistricts();
				session.setAttribute("dists",dists);
				if(request.getParameter("district")!=null)
				{
					if(!(request.getParameter("district")).equalsIgnoreCase("0"))
					{
						mandals=rwsLocations.getMandals(request.getParameter("district"));
					}
				}
				session.setAttribute("mandals",mandals);
				if(request.getParameter("mandal")!=null)
				{
					if(!(request.getParameter("mandal")).equalsIgnoreCase("0"))
					{
						panchyats=rwsLocations.getPanchayats(request.getParameter("district"),request.getParameter("mandal"));
					}
				}
				session.setAttribute("panchyats",panchyats);
				if(request.getParameter("pcode")!=null)
				{
					if(!(request.getParameter("pcode")).equalsIgnoreCase("0"))
					{
						villages = rwsLocations.getVillages(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"));
					}
				}
				session.setAttribute("villages",villages);
				if(request.getParameter("pcode")!=null)
				{
					if(request.getParameter("vcode").length()!=0)
					{
						habitations = RwsMasterData.getHabitations(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"),request.getParameter("vcode"),getDataSource(request));
					}
				}
				session.setAttribute("habitations",habitations);
			}
			catch(Exception e)
			{
				//System.out.println("The data in rws_PanchRajEntryAct_frm data"+e);
			}
			
			try
			{
				if(request.getParameter("habCode")!=null)
				{
					if(request.getParameter("habCode").length()!=0)
					{
						prhabs = RwsMasterData.getPRHabitations(request.getParameter("habCode"),getDataSource(request));
						for (int i=0;i<prhabs.size();i++)
						{
							rwsMaster = (RwsMaster)prhabs.get(i);
							//System.out.println("######### panchRaj.getHabitation() : " + rwsMaster.getHabitation() + " ##########");		
							//System.out.println("######### panchRaj.getPanchRajCode111() : " + rwsMaster.getHabCode() + " ##########");
					 		//System.out.println("######### panchRaj.getPanchRajName111() : " + rwsMaster.getHabName() + " ##########");
							String habcode=rwsMaster.getHabCode();
							//System.out.println("jbcode="+habcode.substring(14,16));
							//System.out.println("panch code="+rwsMaster.getHabCode().substring(0,14));
							PanchRaj p=new PanchRaj(rwsMaster.getHabCode(),rwsMaster.getHabCode().substring(0,14),habcode.substring(14,16),rwsMaster.getHabName()); 
							panchRajs.add(p);
						}
						//System.out.println("prhabs.size() in rws_PanchRajEntryAct_frm=   "+panchRajs.size());
						panchRajForm.setPrHabs(panchRajs);
					}
				}
			}
			catch(Exception e)
			{
				//System.out.println("The data in rws_PanchRajEntryAct_frm data"+e);
			}
		}
		try
		{
			if(mode != null && mode.equalsIgnoreCase("Add new PRHab"))
			{
				prhabs = (ArrayList)panchRajForm.getPrHabs();
				String prhab="";
				String jb="";
				int size = prhabs.size();
				//System.out.println("size="+size);
				if(size == 0)
				{
				  jb="00";
				  prhab=request.getParameter("habCode");
				}
					 
				else{
				  panchRaj = (PanchRaj)prhabs.get(size-1);
				  //System.out.println("habitation="+panchRaj.getHabitation()+"habcode="+panchRaj.getHabCode()+"jbcode="+panchRaj.getJbCode());
			 	  prhab=panchRaj.getHabCode();
			  	  int jbcode=Integer.parseInt(panchRaj.getJbCode())+1;
				  jb="";
				  if(jbcode<10)
					jb="0"+jbcode;
				  else
					jb=""+jbcode;
				  
				} 
				//System.out.println("PrHab= "+prhab+"jb="+jb);
				panchRaj = new PanchRaj();
				panchRaj.setHabitation(prhab);
				panchRaj.setHabCode(prhab);
				panchRaj.setJbCode(jb);
				prhabs.add(panchRaj);
				panchRajForm.setPrHabs(prhabs);
				mode="Add";
			}
		}
		catch(Exception e)
		{
			//System.out.println("The add new Habitation in rws_PanchRajEntryAct_frm data"+e);
		}
		if(mode != null && mode.equalsIgnoreCase("Remove"))
		{
			String query="";
			try{
				  DataSource dataSource=getDataSource(request);
				  conn = dataSource.getConnection();
				  conn.setAutoCommit(false);
				  stmt = conn.createStatement();
				  ArrayList habs = (ArrayList)panchRajForm.getPrHabs();
				  //System.out.println("habs.size()="+habs.size());
				  int k=0;
				  for (int i=0;i<habs.size();i++)
				  {
				  	panchRaj = (PanchRaj)habs.get(i);
				  	if(panchRaj.getHabitation() != null)
				  	{
				  		if(panchRaj.getHabitation().equalsIgnoreCase("on"))
				  		{   k=k+1;	
				  			//System.out.println("habCode="+panchRaj.getHabCode()+"jbcode="+panchRaj.getJbCode()+"habitation="+panchRaj.getHabitation());
				  			String prHabCode=panchRaj.getHabCode()+panchRaj.getJbCode();
				  		    query="delete from RWS_PANCHAYAT_RAJ_TBL where hab_code='"+panchRaj.getHabCode()+"' and panch_code='"+prHabCode+"'";
				  		    //System.out.println("query="+query);
				  			stmt.addBatch(query);
				  		}
				  	}
				  }
					rcount = stmt.executeBatch();
					conn.commit();
					if(rcount.length>0)
						message=""+k+"PR Habitations Deleted Successfully";
					request.setAttribute("message",message);	
					panchRajForm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("error="+e.getMessage());
			}
			
			  
			
				
			
			
		}
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				DataSource dataSource=getDataSource(request);
				conn = dataSource.getConnection();
				conn.setAutoCommit(false);
				stmt = conn.createStatement();
				//System.out.println("habCode="+request.getParameter("habCode"));
				prhabs = RwsMasterData.getPRHabitations(request.getParameter("habCode"),getDataSource(request));
				//System.out.println("pr habs size="+prhabs.size());
				ArrayList habs = (ArrayList)panchRajForm.getPrHabs();
				
				 
				stmt.addBatch("delete from RWS_PANCHAYAT_RAJ_TBL where hab_code='"+request.getParameter("habCode")+"'");
				//System.out.println("habs size="+habs.size());
				 
				for (int i=0;i<habs.size();i++)
				{
					panchRaj = (PanchRaj)habs.get(i);
					//System.out.println("######### Record No : " + (i+1) + " ##########");
					//System.out.println("######### rwsMaster.getHabCode() : " + (panchRaj.getHabCode()) + " ##########");
					//System.out.println("######### panchRaj.getPanchRajCode() : " + (panchRaj.getHabCode()+panchRaj.getJbCode()) + " ##########");
					//System.out.println("######### panchRaj.getPanchRajName() : " + panchRaj.getHabName().toUpperCase() + " ##########");
					//System.out.println("insert into RWS_PANCHAYAT_RAJ_TBL values('"+(panchRaj.getHabCode())+"','"+(panchRaj.getHabCode()+panchRaj.getJbCode())+"','"+panchRaj.getHabName()+"')");
					stmt.addBatch("insert into RWS_PANCHAYAT_RAJ_TBL values('"+(panchRaj.getHabCode())+"','"+(panchRaj.getHabCode()+panchRaj.getJbCode())+"','"+panchRaj.getHabName().toUpperCase()+"')");
				}
				rcount = stmt.executeBatch();
				conn.commit();
				panchRajForm.reset(mapping,request);
				panchRajForm.setDistrict("");	
				mandals=(ArrayList)session.getAttribute("mandals");
				panchyats=(ArrayList)session.getAttribute("panchyats");
				villages=(ArrayList)session.getAttribute("villages");
				habitations=(ArrayList)session.getAttribute("habitations");
				if(session.getAttribute("mandals") != null)
				 {
					 mandals.clear();
					 panchyats.clear();
					 villages.clear();
					 habitations.clear();
				 }

			}
			catch(BatchUpdateException b) 
			{
				System.err.println("Update counts of successful commands: " +b);
			}
			catch(Exception e)
			{
				//System.out.println("The error in insert is "+e);
			}
			finally
			{
				if (conn != null) 
				{
					try 
					{
						conn.close();
					}
					catch (Exception e) 
					{
						//System.out.println("The error in rws_PanchRajEntryAct_frm"+e);
					}
				}
				if (stmt != null) 
				{
					try 
					{
						stmt.close();
					}
					catch (Exception e) 
					{
						//System.out.println("The error in rws_PanchRajEntryAct_frm"+e);
					}
				}

			}
			//System.out.println("dddddddddddddddd"+rcount.length);
			if(rcount.length <1)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
				//System.out.println("dddddddddddddddd"+rcount.length);
			}
			
			request.setAttribute("message",message);
		}
			
		if(mode != null && mode.equalsIgnoreCase("resetForm"))
		{
			//System.out.println("it is in resetForm");
			try{
				panchRajForm.reset(mapping,request);
				 dists.clear();
				 mandals.clear();
				 panchyats.clear();
				 villages.clear();
				 habitations.clear();
				 prhabs.clear();			
			}
			catch(Exception e)
			{
				//System.out.println("error="+e.getMessage());
			}
		}
		return(mapping.findForward(mode));
	}
}
