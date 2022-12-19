package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_progressReportAct extends Action
{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
		HttpSession session=request.getSession();
		Rws_progressReport_form frm=(Rws_progressReport_form)form;
		Rws_progressReportData progressReportData=new Rws_progressReportData(getDataSource(request));
		String mode=request.getParameter("mode");
		//String target="success";
		ArrayList emptyList=new ArrayList(0);
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		//System.out.println("mode is "+mode);
		
		try
		{
			if(mode !=null && mode.equals("getDivisions"))
			{
				RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				ArrayList divisions=rwsOffices.getDivisions("1",frm.getDistrict());
			    session.setAttribute("divisions",divisions);
				
			}
			if((mode!=null && mode.equals("progressRptSelect"))
					||(mode!=null && mode.equals("openingBalanceFrm"))
					||(mode!=null && mode.equals("saveOpeningBalance"))
					||(mode!=null && mode.equals("editOpeningBalance"))
					||(mode!=null && mode.equals("getOpeningBalance")))
			{
				String circleOfficeCode=user.getCircleOfficeCode();
				CommonLists commonLists=new CommonLists(getDataSource(request));
				RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				if(!circleOfficeCode.equals("00"))
				{
					frm.setDname(rwsOffices.getDistrictName(circleOfficeCode));
					frm.setDistrict(circleOfficeCode);
				}
				ArrayList districts=rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				ArrayList monthsList=commonLists.getMonths();
				session.setAttribute("monthsList",monthsList);
				ArrayList programmesList=commonLists.getProgrammes();
				session.setAttribute("programmesList",programmesList);
				if(frm.getFinancialYear()==null || frm.getFinancialYear().equals(""))
				{
					frm.setFinancialYear(progressReportData.getCurrentFinancialYear());
					ArrayList financialYearsList=progressReportData.getFinancialYearsBetween("2005-2006",progressReportData.getCurrentFinancialYear());
					//System.out.println("financialYearsList size is "+financialYearsList.size());
					session.setAttribute("financialYearsList",financialYearsList);
				}
				
				
				if(!mode.equals("openingBalanceFrm")&&!frm.getDistrict().equals("")&&!frm.getDivision().equals("")&&!frm.getFinancialYear().equals("")&&!frm.getProgramme().equals("")&&!mode.equals("saveOpeningBalance")&&!mode.equals("editOpeningBalance"))
				{
					boolean dataExists=progressReportData.isDataExists(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getProgramme());
					
					if(dataExists)
					{
						request.setAttribute("dataExists","true");
						request.setAttribute("message","Closing Balance is not updatable as data exists");
					}
				}
			}
			if((mode!=null && mode.equals("openingBalanceFrm")))
			{
				frm.setFinancialYear("2006-2007");
			}
			if((mode!=null && mode.equals("saveOpeningBalance")))
			{
				//System.out.println("SAVE Division Code:"+frm.getDivision());
				DAOMessage daoMessage=progressReportData.insertOpeningBalance(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getProgramme(),frm.getOpeningBalance(),frm.getClosingBalance());
				request.setAttribute("message",daoMessage.getMessage());
			}
			if(mode!=null && mode.equals("getOpeningBalance"))
			{
				String openingBalance=progressReportData.getOpeningBalance(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getProgramme());
				frm.setOpeningBalance(openingBalance);
			}
			
			if(mode!=null && mode.equals("viewOpeningBalance"))
			{
				ArrayList openingBalancesList=progressReportData.getOpeningBalances(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getProgramme(),frm.getOpeningBalance());
				session.setAttribute("openingBalancesList",openingBalancesList);
			}
			if(mode!=null && mode.equals("deleteOpeningBalance"))
			{
				//System.out.println("DELETE OPENING BALANCE");
				String message=progressReportData.deleteOpeningBalances(request.getParameter("district"),request.getParameter("division"),request.getParameter("financialYear"),request.getParameter("programme"));
				request.setAttribute("message",message);
				ArrayList openingBalancesList=(ArrayList)session.getAttribute("openingBalancesList");
				if(message.equals("Record Deleted Successfully"))
				{
				  for(int i=0;i<openingBalancesList.size();i++)
					{
						Rws_progressReport_bean bean=(Rws_progressReport_bean)openingBalancesList.get(i);
						if(bean.getDistrict().equals(request.getParameter("district"))&&bean.getDivision().equals(request.getParameter("division"))&&bean.getFinancialYear().equals(request.getParameter("financialYear"))&&bean.getProgrammeCode().equals(request.getParameter("programme")))
						{
							//System.out.println("removing from arraylis where division="+bean.getDivision());
							openingBalancesList.remove(i);
						}
					}
					session.setAttribute("openingBalancesList",openingBalancesList);
				}	
				
			}
			
			
			if(mode!=null && mode.equals("data"))
			{
				CommonLists commonLists=new CommonLists(getDataSource(request));
				RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				String months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
				ArrayList programmsList=commonLists.getProgrammes();
				session.setAttribute("programmsList",programmsList);
				ArrayList progressReportEntries=progressReportData.getProgressReport(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getMonth());
				ArrayList financialYearsList=progressReportData.getFinancialYearsBetween("2005-2006",progressReportData.getCurrentFinancialYear());
				//System.out.println("financialYearsList size is "+financialYearsList.size());
				session.setAttribute("financialYearsList",financialYearsList);
				if(progressReportEntries.size()!=0)
				{
					session.setAttribute("progressReportEntries",progressReportEntries);
					frm.setProgressReportEntries(progressReportEntries);
				}
				else
				{
					session.setAttribute("progressReportEntries",progressReportData.getInitialList(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getMonth()));
					frm.setProgressReportEntries(progressReportData.getInitialList(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),frm.getMonth()));
				}
				frm.setDname(rwsOffices.getDistrictName(frm.getDistrict()));
				if( !(request.getParameter("district").equals("")) || request.getParameter("district")!=null )
				{
					ArrayList divisionsList=rwsOffices.getDivisions("1",frm.getDistrict()); 
					// 01 is the headOfficeCode
					session.setAttribute( "divisionsList",divisionsList);
				}
				frm.setMonthName(months[Integer.parseInt(frm.getMonth())]);
				
			}
			if(mode!=null && mode.equals("addNewProgForPlanNormal"))
			{
				//ArrayList progressReportEntries=(ArrayList)session.getAttribute("progressReportEntries");
				ArrayList progressReportEntries=frm.getProgressReportEntries(); 
				Rws_progressReport_bean progressBean=new Rws_progressReport_bean ();
				progressReportEntries.add(progressBean);
				session.setAttribute("progressReportEntries",progressReportEntries);
				//displayProgressReportEntries(progressReportEntries);
				//frm.setProgressReportEntries(progressReportEntries);
			}
			if(mode!=null && mode.equals("removeProgForPlanNormal"))
			{
				String removeIds[]=request.getParameterValues("planNormal");
				ArrayList progressReportEntries=frm.getProgressReportEntries();
				session.setAttribute("progressReportEntries",progressReportEntries);
				//ArrayList progressReportEntries=(ArrayList)session.getAttribute("progressReportEntries");
				progressReportEntries=removeSelected(progressReportEntries,removeIds);
				//frm.setProgressReportEntries(progressReportEntries);
				session.setAttribute("progressReportEntries",progressReportEntries);
				//displayProgressReportEntries(progressReportEntries);
			}
			if(mode!=null && mode.equals("insertProgressReport"))
			{
				ArrayList progressReportEntries=frm.getProgressReportEntries();
				session.setAttribute("progressReportEntries",progressReportEntries);
				DAOMessage daoMessage=progressReportData.insertProgressReport(frm.getDistrict(),frm.getFinancialYear(),frm.getMonth(),progressReportEntries);
				displayProgressReportEntries(progressReportEntries);
				//System.out.println("message is "+daoMessage.getMessage());
				request.setAttribute("message",daoMessage.getMessage());
			}
			if(mode!=null && mode.equals("getCatagoryList"))
			{
				ArrayList progressReportEntries=frm.getProgressReportEntries();
				Rws_progressReport_bean progressBean=(Rws_progressReport_bean)progressReportEntries.get(Integer.parseInt(request.getParameter("index")));
				ArrayList catagoryList=progressReportData.getCatagoryList(progressBean.getPlanNonPlan());
				//System.out.println("catagoryList size is "+catagoryList.size());
				progressBean.setCatagoryList(catagoryList);
				progressReportEntries.set(Integer.parseInt(request.getParameter("index")),progressBean);
				frm.setProgressReportEntries(progressReportEntries);
				session.setAttribute("progressReportEntries",progressReportEntries);
				//session.setAttribute("catagoryList",catagoryList);
			}
			
			
			//executed when program is changed in progress report entry form
			if(mode!=null && mode.equals("getUptoTheMonth"))
			{
				int index=Integer.parseInt(request.getParameter("index"));
				//System.out.println("financialYear is "+frm.getFinancialYear());
				int startYear=Integer.parseInt(frm.getFinancialYear().substring(0,4));
				
				String actionToDo=progressReportData.getOperationToPerform(frm.getDistrict(),frm.getFinancialYear(),request.getParameter("programmeCode"));
				//System.out.println("actionToDo is "+actionToDo);
				
				if(actionToDo.equals("proceed"))
				{
					String expUptoTheMonth=progressReportData.getExpUptoTheMonth(frm.getDistrict(),frm.getDivision(),request.getParameter("programmeCode"),frm.getFinancialYear(),frm.getMonth());
					String releasesUptoTheMonth=progressReportData.getReleasesUptoTheMonth(frm.getDistrict(),frm.getDivision(),request.getParameter("programmeCode"),frm.getFinancialYear(),frm.getMonth());
					String openingBalance=progressReportData.getClosingBalance(frm.getDistrict(),request.getParameter("programmeCode"),(startYear-1)+"-"+(startYear),frm.getMonth());
					ArrayList progressReportEntries=frm.getProgressReportEntries();
					//Rws_progressReport_bean progressBean=(Rws_progressReport_bean)progressReportEntries.get(index);
					
					//ArrayList progressReportEntries=frm.getProgressReportEntries();
					Rws_progressReport_bean progressBeanTmp=(Rws_progressReport_bean)progressReportEntries.get(index);
					String programmeCode=progressBeanTmp.getProgrammeCode();
					Rws_progressReport_bean progressBean=progressReportData.getProgressReportEntry(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),programmeCode,frm.getMonth(),request.getParameter("planNonPlan"),request.getParameter("catagory"));
					//System.out.println("programmeCode is from got from DAO is "+progressBean.getProgrammeCode());
					
					if(progressBean.getProgrammeCode()!=null && !progressBean.getProgrammeCode().equals(""))
					{
						progressBean.setUptoTheMonth(expUptoTheMonth);
						progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
						progressBean.setOpeningBalance(openingBalance);
						progressReportEntries.set(index,progressBean);
					}
					else
					{
						progressBeanTmp.setUptoTheMonth(expUptoTheMonth);
						progressBeanTmp.setReleasesUptoTheMonth(releasesUptoTheMonth);
						progressBeanTmp.setOpeningBalance(openingBalance);
						progressReportEntries.set(index,progressBeanTmp);
					}
					
					frm.setProgressReportEntries(progressReportEntries);
					session.setAttribute("progressReportEntries",progressReportEntries);
				}
				else if(actionToDo.equals("insertClosingBalanceIntoBalanceTbl"))
				{
					DAOMessage daoMessage=progressReportData.insertClosingBalanceForPreviousYear(frm.getDistrict(),frm.getFinancialYear(),request.getParameter("programmeCode"));
					request.setAttribute("message",daoMessage.getMessage());
					if(daoMessage.isOperationSussess())
					{
						//get the progressReportEntry for the selected record from the database and set to the form
						String expUptoTheMonth=progressReportData.getExpUptoTheMonth(frm.getDistrict(),frm.getDivision(),request.getParameter("programmeCode"),frm.getFinancialYear(),frm.getMonth());
						String releasesUptoTheMonth=progressReportData.getReleasesUptoTheMonth(frm.getDistrict(),frm.getDivision(),request.getParameter("programmeCode"),frm.getFinancialYear(),frm.getMonth());
						String openingBalance=progressReportData.getClosingBalance(frm.getDistrict(),request.getParameter("programmeCode"),(startYear-1)+"-"+(startYear),frm.getMonth());
						ArrayList progressReportEntries=frm.getProgressReportEntries();
						Rws_progressReport_bean progressBean=(Rws_progressReport_bean)progressReportEntries.get(index);
						//code added
						String programmeCode=progressBean.getProgrammeCode();
						progressBean=progressReportData.getProgressReportEntry(frm.getDistrict(),frm.getDivision(),frm.getFinancialYear(),programmeCode,frm.getMonth());
						//end of code added
						progressBean.setUptoTheMonth(expUptoTheMonth);
						progressBean.setReleasesUptoTheMonth(releasesUptoTheMonth);
						progressBean.setOpeningBalance(openingBalance);
						progressReportEntries.set(index,progressBean);
						frm.setProgressReportEntries(progressReportEntries);
						session.setAttribute("progressReportEntries",progressReportEntries);
					}
					
				}
				else if(actionToDo.equals("taskCannotBeCompleted"))
				{
					request.setAttribute("message","Opening balance does not exists \\nfor the record with sno."+(index+1)+".\\nContact head office");
					ArrayList progressReportEntries=frm.getProgressReportEntries();
					/*
					Rws_progressReport_bean progressBean=(Rws_progressReport_bean)progressReportEntries.get(index);
					
					progressBean.setUptoTheMonth("");
					progressBean.setReleasesUptoTheMonth("");
					progressBean.setOpeningBalance("");
					*/
					//progressReportEntries.set(index,progressBean);
					progressReportEntries.set(index,new Rws_progressReport_bean());
					frm.setProgressReportEntries(progressReportEntries);
					session.setAttribute("progressReportEntries",progressReportEntries);
				}
			}
			
		}catch(Exception e){
			//System.out.println("Exception in Rws_progressReportAct is "+e.getMessage());}
		}
		return mapping.findForward(mode);
	}
	
	public ArrayList removeSelected(ArrayList sourceList,String[] selectedIds)
	{
		for(int i=0;i<selectedIds.length;i++)
		{
			for(int j=0;j<sourceList.size();j++)
			{
				Rws_progressReport_bean progressBean=(Rws_progressReport_bean)sourceList.get(j);
				if((selectedIds[i]).equals(j+""))
				{
					sourceList.set(j,null);
					
				}
			}
		}
		sourceList=removeNulls(sourceList);
		return sourceList;
	}
	public ArrayList removeNulls(ArrayList sourceList)
	{
		for(int i=0;i<sourceList.size();i++)
		{
			if(sourceList.get(i)==null)
			{
				sourceList.remove(i);
				i--;
			}
		}
		return sourceList;
	}
	public void displayProgressReportEntries(ArrayList sourceList)
	{
		for(int i=0;i<sourceList.size();i++)
		{
			Rws_progressReport_bean progressBean=(Rws_progressReport_bean)sourceList.get(i);
			//System.out.println("i is "+i);
			//System.out.println("programmecode is "+progressBean.getProgrammeCode());
			//System.out.println("openning balance is "+progressBean.getOpeningBalance());
		}
	}
	
}

   	
	 