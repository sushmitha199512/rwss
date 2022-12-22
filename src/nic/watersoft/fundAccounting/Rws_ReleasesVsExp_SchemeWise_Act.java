/*
 * Created on Sep 21, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class Rws_ReleasesVsExp_SchemeWise_Act  extends Action 
{
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest 
			request,HttpServletResponse response)
	{
		HttpSession session=request.getSession();
		Rws_ReleasesVsExp_WorkWise_Form frm=(Rws_ReleasesVsExp_WorkWise_Form)form;
		Rws_BroData broData=new Rws_BroData(getDataSource(request));
		String mode=request.getParameter("mode");
		//String target="success";
		ArrayList emptyList=new ArrayList(0);
		//System.out.println("mode is "+mode);
		try
		{
			if(mode!=null && mode.equals("init"))
			{
				ArrayList releasesVsExpenditureSchemeWiseList=broData.getReleasesVsExpenditureSchemeWiseList();
				//System.out.println("releasesVsExpenditureSchemeWiseList size is "+releasesVsExpenditureSchemeWiseList.size());
				request.setAttribute("releasesVsExpenditureSchemeWiseList",releasesVsExpenditureSchemeWiseList);
				frm.setScheme("hello");
				
			}
			if(mode!=null && mode.equals("officeWiseInit"))
			{
				ArrayList releasesDetailsCircleOfficeWise=broData.getReleasesDetailsCircleOfficeWiseList();
				//System.out.println("releasesDetailsCircleOfficeWise size is "+releasesDetailsCircleOfficeWise.size());
				request.setAttribute("releasesDetailsCircleOfficeWise",releasesDetailsCircleOfficeWise);
				
				ArrayList releasesDetailsDivisionOfficeWiseList=broData.getReleasesDetailsDivisionOfficeWiseList();
				//System.out.println("releasesDetailsDivisionOfficeWiseList size is "+releasesDetailsDivisionOfficeWiseList.size());
				request.setAttribute("releasesDetailsDivisionOfficeWiseList",releasesDetailsDivisionOfficeWiseList);
				
				
			}
			if(mode!=null && mode.equals("betweenDates"))
			{
				CommonLists commonLists=new CommonLists(getDataSource(request));
				RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
				
				ArrayList circlesList=rwsOffices.getCircles("1");
				ArrayList schemesList=commonLists.getAssetTypes();
				ArrayList yearsList=broData.getDistinctYearsOfReleasesAndExpenditure(getDataSource(request));
				ArrayList monthsList=broData.getMonths();
				//System.out.println("schemesList size is "+schemesList.size());
				//System.out.println("yearslist size is "+yearsList.size());
				//System.out.println("monthslist size is "+monthsList.size());
				session.setAttribute("schemesList",schemesList);
				session.setAttribute("fromYearsList",yearsList);
				session.setAttribute("circlesList",circlesList);
				
				session.setAttribute("fromMonthsList",emptyList);
				session.setAttribute("toYearsList",emptyList);
				session.setAttribute("toMonthsList",emptyList);
				if(frm.getFromYear()!=null && !frm.getFromYear().equals(""))
				{
					session.setAttribute("fromMonthsList",monthsList);
					if(frm.getFromMonth()!=null && !frm.getFromMonth().equals(""))
					{
						session.setAttribute("toYearsList",yearsList);
						if(frm.getToYear()!=null && !frm.getToYear().equals(""))
						{
							session.setAttribute("toMonthsList",monthsList);
						}
					}
					
				}
				
				//code to get from years
				
			}
			if(mode!=null && mode.equals("betweenDatesView"))
			{
				ArrayList expenditureList=broData.getExpenditureListBetweenDates(getDataSource(request),frm.getFromYear(),frm.getFromMonth(),frm.getToYear(),frm.getToMonth(),frm.getCircle(),frm.getScheme());
				ArrayList releasesList=broData.getReleasesListBetweenDates(getDataSource(request),frm.getFromYear(),frm.getFromMonth(),frm.getToYear(),frm.getToMonth(),frm.getCircle(),frm.getScheme());
				ArrayList releasesVsExpList=combineExpAndReleasesLists(expenditureList,releasesList);
				if(!frm.getCircle().equals(""))
					sortReleasesVsExpenditureListBySchemeCode(releasesVsExpList);
				else
				{
					sortReleasesVsExpenditureListBySchemeCodeGroupByCircleOfficeCode(releasesVsExpList);
				}
				//displayReleasesVsExpenditureSchemeCodeValues(releasesVsExpList);
				request.setAttribute("releasesVsExpList",releasesVsExpList);
				String rptHeading=getRptHeading(getDataSource(request),frm);
				request.setAttribute("rptHeading",rptHeading);
				
				
				
			}
			
		}catch(Exception e){
			//System.out.println("Exception in Rws_ReleasesVsExp_WorkWise is "+e);}
		}
		
		
		
		return mapping.findForward(mode);
	}
	
	ArrayList combineExpAndReleasesLists(ArrayList expList,ArrayList releasesList)
	{
		ArrayList expVsReleasesList=new ArrayList();
		for(int i=0;i<releasesList.size();i++)
		{
			Rws_ReleasesVsExp_WorkWise_Bean releasesBean=(Rws_ReleasesVsExp_WorkWise_Bean)releasesList.get(i);
			boolean exists=false;
			//System.out.println("releasesBean.workName is "+releasesBean.getWorkName());
			for(int j=0;j<expList.size();j++)
			{
				Rws_ReleasesVsExp_WorkWise_Bean expBean=(Rws_ReleasesVsExp_WorkWise_Bean)expList.get(j);
				if(releasesBean.getWorkId().equals(expBean.getWorkId()))
				{
					expBean.setTotalReleases(releasesBean.getTotalReleases());
					expVsReleasesList.add(expBean);
					exists=true;
				}
			}
			if(!exists)
			{
				releasesBean.setTotalExpenditure("0");
				expVsReleasesList.add(releasesBean);
			}
		}
		for(int j=0;j<expList.size();j++)
		{
			Rws_ReleasesVsExp_WorkWise_Bean expBean=(Rws_ReleasesVsExp_WorkWise_Bean)expList.get(j);
			boolean exists=false;
			for(int i=0;i<expVsReleasesList.size();i++)
			{
				Rws_ReleasesVsExp_WorkWise_Bean expVsReleasesBean=(Rws_ReleasesVsExp_WorkWise_Bean)expVsReleasesList.get(i);
				if(expBean.getWorkId().equals(expVsReleasesBean.getWorkId()))
				{
					exists=true;
				}
				
			}
			//System.out.println("exists is "+exists);
			if(!exists)
			{
				expBean.setTotalReleases("0");
				expVsReleasesList.add(expBean);
			}
		}
		return expVsReleasesList;
	}
	
//	sorting releasesVsExpenditureList
	public void sortReleasesVsExpenditureListBySchemeCode(ArrayList releasesVsexpenditureList)
	{
		try{
		//	code to sort arrayList
			Collections.sort(releasesVsexpenditureList, new Comparator() {
			    public int compare(Object o1, Object o2)
			    {
			    	
			    	Rws_ReleasesVsExp_WorkWise_Bean d1=(Rws_ReleasesVsExp_WorkWise_Bean)o1;
			    	Rws_ReleasesVsExp_WorkWise_Bean d2=(Rws_ReleasesVsExp_WorkWise_Bean)o2;
			    	String schemeCode1=d1.getTypeOfAssetCode();
			    	String schemeCode2=d2.getTypeOfAssetCode();
			    	if(schemeCode1!=null && !schemeCode1.equals("") && schemeCode2!=null && !schemeCode2.equals("")  )
			    	{
			    		return Integer.parseInt(schemeCode1)-Integer.parseInt(schemeCode2);
			    		
			    	}
			    	else if(schemeCode1==null||schemeCode1.equals("")|| schemeCode2==null ||schemeCode2.equals(""))
			    	{
			    		return 1;
			    	}
			    	else
			    		return 0;
			    	
			    }
			});
		}
		catch(Exception e){
			//System.out.println("Exception in sorting is "+e);}
		}
	}
	
	
	public void sortReleasesVsExpenditureListByCircleCode(ArrayList releasesVsexpenditureList)
	{
		try{
		//	code to sort arrayList
			Collections.sort(releasesVsexpenditureList, new Comparator() {
			    public int compare(Object o1, Object o2)
			    {
			    	
			    	Rws_ReleasesVsExp_WorkWise_Bean d1=(Rws_ReleasesVsExp_WorkWise_Bean)o1;
			    	Rws_ReleasesVsExp_WorkWise_Bean d2=(Rws_ReleasesVsExp_WorkWise_Bean)o2;
			    	String circleCode1=d1.getCircleOfficeCode();
			    	String circleCode2=d2.getCircleOfficeCode();
			    	if(circleCode1!=null && !circleCode1.equals("") && circleCode2!=null && !circleCode2.equals("")  )
			    	{
			    		return Integer.parseInt(circleCode1)-Integer.parseInt(circleCode2);
			    		
			    	}
			    	else if(circleCode1==null||circleCode1.equals("")|| circleCode2==null ||circleCode2.equals(""))
			    	{
			    		return 1;
			    	}
			    	else
			    		return 0;
			    	
			    }
			});
		}
		catch(Exception e){
			//System.out.println("Exception in sorting is "+e);}
		}
	}
	
	public void sortReleasesVsExpenditureListBySchemeCodeGroupByCircleOfficeCode(ArrayList releasesVsexpenditureList)
	{
		try{
		//	code to sort arrayList
			sortReleasesVsExpenditureListByCircleCode(releasesVsexpenditureList);
			Collections.sort(releasesVsexpenditureList, new Comparator() {
			    public int compare(Object o1, Object o2)
			    {
			    	
			    	Rws_ReleasesVsExp_WorkWise_Bean d1=(Rws_ReleasesVsExp_WorkWise_Bean)o1;
			    	Rws_ReleasesVsExp_WorkWise_Bean d2=(Rws_ReleasesVsExp_WorkWise_Bean)o2;
			    	String schemeCode1=d1.getTypeOfAssetCode();
			    	String schemeCode2=d2.getTypeOfAssetCode();
			    	String circleOfficeCode1=d1.getCircleOfficeCode();
			    	String circleOfficeCode2=d2.getCircleOfficeCode();
			    	if(circleOfficeCode1.equals(circleOfficeCode2))
			    	{
			    		if(schemeCode1!=null && !schemeCode1.equals("") && schemeCode2!=null && !schemeCode2.equals("")  )
			    		{
			    			return Integer.parseInt(schemeCode1)-Integer.parseInt(schemeCode2);
			    		}
			    		else if(schemeCode1==null||schemeCode1.equals("")|| schemeCode2==null ||schemeCode2.equals(""))
			    		{
			    			return 1;
			    		}
			    		else
			    			return 0;
			    	}
			    	else
			    		return 0;
			    	
			    }
			});
		}
		catch(Exception e){
			//System.out.println("Exception in sorting is "+e);}
		}
	}
	
	void displayReleasesVsExpenditureSchemeCodeValues(ArrayList releasesVsExpenditureList)
	{
		for(int i=0;i<releasesVsExpenditureList.size();i++)
		{
			Rws_ReleasesVsExp_WorkWise_Bean bean=(Rws_ReleasesVsExp_WorkWise_Bean)releasesVsExpenditureList.get(i);
			//System.out.println("SchemeCode is "+bean.getTypeOfAssetCode());
		}
	}
	
	String getRptHeading(DataSource dataSource,Rws_ReleasesVsExp_WorkWise_Form frm)
	{
		String rptHeading="";
		RwsOffices rwsOffices=new RwsOffices();
		String months[]={"","January","February","March","April","May","June","July","August","September","October","November","December"};
		try{
		if(frm.getFromYear().equals(""))
			rptHeading="All Releases Vs Expenditure Details";
		if(!frm.getFromYear().equals(""))
		{
			rptHeading="Releases Vs Expenditure Details From ";
			if(!frm.getFromMonth().equals(""))
				rptHeading+=" "+months[Integer.parseInt(frm.getFromMonth())]+", ";
			rptHeading+=frm.getFromYear();
		}
		if(!frm.getToYear().equals(""))
		{
			rptHeading+=" To ";
			if(!frm.getToMonth().equals(""))
				rptHeading+=" "+months[Integer.parseInt(frm.getToMonth())]+", ";
			rptHeading+=frm.getToYear();
		}
		if(!frm.getScheme().equals(""))
			rptHeading+=" for Scheme "+nic.watersoft.masters.RwsMasterData.getAssetTypeName(dataSource,frm.getScheme());
		if(!frm.getCircle().equals(""))
			rptHeading+=" of Circle "+rwsOffices.getCircleOfficeName(dataSource,"1",frm.getCircle());
		}catch(Exception e){
			//System.out.println("Exception in getting rptHeader is "+e);}
		}
		
		return rptHeading;
	}
}

