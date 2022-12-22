package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

public class rws_TslimitEntryAct_frm extends Action
{
	/*
	protected ActionForm buildTslimitForm(String office,String desingation,HttpServletRequest request) throws Exception 
	{
		TslimitForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getTslimit(office,designation,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new TslimitForm();

				form.setOffice(rwsMaster.getOffice());
				form.setDesignation(rwsMaster.getDesignation());
				form.setLowerLimit(rwsMaster.getLowerLimit());
				form.setUpperLimit(rwsMaster.getUppetLimit());
				
			}
			return form;
	} */ 

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException,NumberFormatException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		//Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");
		
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList tslimits=null;
		TslimitForm frm=(TslimitForm) form;
		String mode=frm.getMode();		
		if(mode.equalsIgnoreCase("data"))
		{			
			try
			{
				request.setAttribute("designations",RwsMasterData.getDesignation(getDataSource(request)));				
				/*
				ArrayList designations=RwsMasterData.getDesignation(getDataSource(request));				
				for(int i=0;i<designations.size();i++)
				{	
					RwsMaster rwsMaster=null;
					rwsMaster = (rwsMaster)designations.get(i);
					//System.out.println("Designations :"+i);
					//System.out.println(rwsMaster.getDesgnCode());
					//System.out.println(rwsMaster.getDesgnName());
				}				*/ 

				request.setAttribute("offices",RwsMasterData.getOffice(getDataSource(request)));
				ArrayList datas = RwsMasterData.getTSData(getDataSource(request));
				RwsMaster rwsMaster = null;
				
				rwsMaster = (RwsMaster)datas.get(0);
				frm.setOffice1(rwsMaster.getOffice());
				frm.setDesignation1(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation1());
				frm.setLowerLimit1(rwsMaster.getLowerLimit());
				frm.setUpperLimit1(rwsMaster.getUpperLimit());
				
				
				rwsMaster = (RwsMaster)datas.get(1);
				frm.setOffice2(rwsMaster.getOffice());
				frm.setDesignation2(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation2());
				frm.setLowerLimit2(rwsMaster.getLowerLimit());
				frm.setUpperLimit2(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(2);
				frm.setOffice3(rwsMaster.getOffice());
				frm.setDesignation3(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation3());
				frm.setLowerLimit3(rwsMaster.getLowerLimit());
				frm.setUpperLimit3(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(3);
				frm.setOffice4(rwsMaster.getOffice());
				frm.setDesignation4(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation4());
				frm.setLowerLimit4(rwsMaster.getLowerLimit());
				frm.setUpperLimit4(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(4);
				frm.setOffice5(rwsMaster.getOffice());
				frm.setDesignation5(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation5());
				frm.setLowerLimit5(rwsMaster.getLowerLimit());
				frm.setUpperLimit5(rwsMaster.getUpperLimit());
				
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_TslimitEntryAct_frm in inc is "+e);
			}
			
		}
		

	/*
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			tslimits=RwsMasterData.getTslimits(getDataSource(request));
			session.setAttribute("tslimits",tslimits);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_TslimitEntryAct_frm in view is "+e);
			}
		}  */
		

		
		
if(mode.equalsIgnoreCase("Update"))
{
	session = request.getSession();
    String storedToken = (String)session.getAttribute("csrfToken");
    String token = request.getParameter("token");
    if (storedToken.equals(token))
    {
	ValidationUtils validator=new ValidationUtils();
	if(validator.numValidator(frm.getUpperLimit1())  && validator.numValidator(frm.getUpperLimit2()) && validator.numValidator(frm.getUpperLimit3()) && validator.numValidator(frm.getUpperLimit4()) && validator.numValidator(frm.getUpperLimit5())) {
		int ans1 = 0;
		int ans2 = 0;
		int ans3 = 0;
		int ans4 = 0;
		int ans5 = 0;	
				
		RwsMaster rwsMaster = new RwsMaster();
		String office1,office2,office3,office4,office5;
		//String designation1,designation2,designation3,designation4,designation5;
		int lowerLimit1,lowerLimit2,lowerLimit3,lowerLimit4,lowerLimit5;
		int upperLimit1,upperLimit2,upperLimit3,upperLimit4;
		try
		{	
		
			//System.out.println("entered into try block");
		
		office1=frm.getOffice1();
		office2=frm.getOffice2();
		office3=frm.getOffice3();
		office4=frm.getOffice4();
		office5=frm.getOffice5();
		
		/*
		designation1=Integer.parseInt(frm.getDesignation1());
		designation2=Integer.parseInt(frm.getDesignation2());
		designation3=Integer.parseInt(frm.getDesignation3());
		designation4=Integer.parseInt(frm.getDesignation4());
		designation5=Integer.parseInt(frm.getDesignation5()); */
		/*
		designtaion1=frm.getDesignation1();
		designtaion2=frm.getDesignation2();
		designtaion3=frm.getDesignation3();
		designtaion4=frm.getDesignation4();
		designtaion5=frm.getDesignation5();*/
		
		lowerLimit1=Integer.parseInt(frm.getLowerLimit1());
		lowerLimit2=Integer.parseInt(frm.getLowerLimit2());
		lowerLimit3=Integer.parseInt(frm.getLowerLimit3());
		lowerLimit4=Integer.parseInt(frm.getLowerLimit4());
		lowerLimit5=Integer.parseInt(frm.getLowerLimit5());
		
		
		
		
		upperLimit1=Integer.parseInt(frm.getUpperLimit1());
		upperLimit2=Integer.parseInt(frm.getUpperLimit2());
		upperLimit3=Integer.parseInt(frm.getUpperLimit3());
		upperLimit4=Integer.parseInt(frm.getUpperLimit4());
		//upperLimit5=Integer.parseInt(frm.getUpperLimit5());


		/*	((upperLimit1 >  upperLimit2 || upperLimit2 > upperLimit3 || upperLimit3 > upperLimit4 ) && (upperLimit5==0)) || 	
		*/
		//designations should not match
		
		/*
		if(designation1 == designation2 || designation1 == designation3 || designation1 == designation4 || designation1 == designation5 || designation2 == designation3 || designation2 == designation4 || designation2 == designation5 || designation3 == designation4 || designation3 == designation5 || designation4 == designation5)
		{
			//System.out.println("Designations are matched");
			if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length()>0)
				message = RwsMasterData.errorMessage;
			else
				message="The Designations should not match";


	   }//endif of designations match
	else
	 {   
		//System.out.println("Designations not are matched");
		//System.out.println("Designation1"+designation1);
		//System.out.println("Designation2"+designation2);
		//System.out.println("Designation3"+designation3);
		//System.out.println("Designation4"+designation4);
		//System.out.println("Designation5"+designation5); */
	
		if((upperLimit1 >  upperLimit2 || upperLimit2 > upperLimit3 || upperLimit3 > upperLimit4)) 
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
					message = RwsMasterData.errorMessage;
				else
				{
					message="The UpperLimit Must Greater than or eqal to the lower Limit";
				}
			} 
			else
			{	
				

	//1st
	
		rwsMaster.setOffice(office1);
		rwsMaster.setDesignation(frm.getDesignation1());
		rwsMaster.setLowerLimit(String.valueOf(lowerLimit1));
		rwsMaster.setUpperLimit(String.valueOf(upperLimit1));
		ans1=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

		
		//System.out.println("office1:"+rwsMaster.getOffice());
		//System.out.println("designation1:"+rwsMaster.getDesignation());
		//System.out.println("lowerLimit1:"+rwsMaster.getLowerLimit());
		//System.out.println("upperLimit1:"+rwsMaster.getUpperLimit());
		
		//System.out.println("ans1:"+ans1);

	

	//2nd
		rwsMaster.setOffice(office2);
		rwsMaster.setDesignation(frm.getDesignation2());
		upperLimit1=upperLimit1+1;
		rwsMaster.setLowerLimit(String.valueOf(upperLimit1));
		rwsMaster.setUpperLimit(String.valueOf(upperLimit2));
		ans2=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

		//System.out.println("office2:"+rwsMaster.getOffice());
		//System.out.println("designation2:"+rwsMaster.getDesignation());
		//System.out.println("lowerLimit2:"+rwsMaster.getLowerLimit());
		//System.out.println("upperLimit2:"+rwsMaster.getUpperLimit());
		//ans1=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
		//System.out.println("ans2:"+ans2);
	


	//3rd
		rwsMaster.setOffice(office3);
		rwsMaster.setDesignation(frm.getDesignation3());
		upperLimit2=upperLimit2+1;				rwsMaster.setLowerLimit(String.valueOf(upperLimit2));
		rwsMaster.setUpperLimit(String.valueOf(upperLimit3));
		ans3=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

		//System.out.println("office3:"+rwsMaster.getOffice());
		//System.out.println("designation3:"+rwsMaster.getDesignation());
		//System.out.println("lowerLimit3:"+rwsMaster.getLowerLimit());
		//System.out.println("upperLimit3:"+rwsMaster.getUpperLimit());
		//ans1=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
		//System.out.println("ans3:"+ans3);
	

	//4th
		rwsMaster.setOffice(office4);
		rwsMaster.setDesignation(frm.getDesignation4());
		upperLimit3=upperLimit3+1;				
		rwsMaster.setLowerLimit(String.valueOf(upperLimit3));
		rwsMaster.setUpperLimit(String.valueOf(upperLimit4));
		ans4=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

		//System.out.println("office4:"+rwsMaster.getOffice());
		//System.out.println("designation4:"+rwsMaster.getDesignation());
		//System.out.println("lowerLimit4:"+rwsMaster.getLowerLimit());
		//System.out.println("upperLimit4:"+rwsMaster.getUpperLimit());
		//ans1=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
		//System.out.println("ans4:"+ans4);
	


	//5th
		rwsMaster.setOffice(office5);
		rwsMaster.setDesignation(frm.getDesignation5());
		upperLimit4=upperLimit4+1;
		rwsMaster.setLowerLimit(String.valueOf(upperLimit4));
		rwsMaster.setUpperLimit(frm.getUpperLimit5());
		ans5=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

		//System.out.println("office5:"+rwsMaster.getOffice());
		//System.out.println("designation5:"+rwsMaster.getDesignation());
		//System.out.println("lowerLimit5:"+rwsMaster.getLowerLimit());
		//System.out.println("upperrLimit5:"+rwsMaster.getUpperLimit());
		//ans1=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
		////System.out.println("ans5:"+ans5);
		
	
		//System.out.println("ans1:"+ans1);
		//System.out.println("ans2:"+ans2);
		//System.out.println("ans3:"+ans3);
		//System.out.println("ans4:"+ans4);
		//System.out.println("ans5:"+ans5);



			if(ans1 <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
				message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			}
			else if(ans2 <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
				message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			}
			else if(ans3 <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
				message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			}
			else if(ans4 <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
				message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			}
		/*	else if(ans5<1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
				message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be Updated   ";
			} */
			else
			{
				message="Record Updated Successfully";
			}
		}//end else oflowerlimit > upperlimit
		
	
	
	//}//end else of designations match
	

		}
		catch(Exception e)
		{
			System.err.println("The error in rws_TslimitEntryAct_frm in Update is "+e);

		}	
			request.setAttribute("message",message);

			
			//to attach the designations,offices for setting data-mode
			try
			{	request.setAttribute("designations",RwsMasterData.getDesignation(getDataSource(request)));
				request.setAttribute("offices",RwsMasterData.getOffice(getDataSource(request)));
				ArrayList datas = RwsMasterData.getTSData(getDataSource(request));
				
					
				rwsMaster = (RwsMaster)datas.get(0);
				frm.setOffice1(rwsMaster.getOffice());
				frm.setDesignation1(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation1());
				frm.setLowerLimit1(rwsMaster.getLowerLimit());
				frm.setUpperLimit1(rwsMaster.getUpperLimit());
				
				rwsMaster = (RwsMaster)datas.get(1);
				frm.setOffice2(rwsMaster.getOffice());
				frm.setDesignation2(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation2());
				frm.setLowerLimit2(rwsMaster.getLowerLimit());
				frm.setUpperLimit2(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(2);
				frm.setOffice3(rwsMaster.getOffice());
				frm.setDesignation3(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation3());
				frm.setLowerLimit3(rwsMaster.getLowerLimit());
				frm.setUpperLimit3(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(3);
				frm.setOffice4(rwsMaster.getOffice());
				frm.setDesignation4(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation4());
				frm.setLowerLimit4(rwsMaster.getLowerLimit());
				frm.setUpperLimit4(rwsMaster.getUpperLimit());

				rwsMaster = (RwsMaster)datas.get(4);
				frm.setOffice5(rwsMaster.getOffice());
				frm.setDesignation5(rwsMaster.getDesignation());
				//System.out.println(frm.getDesignation5());
				frm.setLowerLimit5(rwsMaster.getLowerLimit());
				frm.setUpperLimit5(rwsMaster.getUpperLimit());
			}catch(Exception e)
			{
				//System.out.println("error in setting data mode in insert");
			}
				
			mode="data";
	}else {
		message="Fields Must be in Thousands";
		request.setAttribute("message",message);
		mode="data";
	}
	
    }
		
}



				// SUB DIVISION,DIVISION,CIRCLE,HEAD OFFICE 
				
				//for SUB DIVISION

				/*
				if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4)
				{
				
				if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4) 
				
				// to check all sub-division
				
				
				if(
					((office1=="SUB DIVISION" && office2="SUB DIVISION" && office3="SUB DIVISION" && office4="SUB DIVISION" office5=="SUB DIVISION") || (office1=="DIVISION" && office2="DIVISION" && office3="DIVISION" && office4="DIVISION" && office5="DIVISION") || (office1=="CIRCLE" && office2="CIRCLE" && office3="CIRCLE" && office4="CIRCLE" && office5="CIRCLE") || (office1=="HEAD OFFICE" && office2="HEAD OFFICE" && office3="HEAD OFFICE" && office4="HEAD OFFICE" && office5="HEAD OFFICE")) &&  (designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation1 != designation5 && designation2 != designation3 && designation2 != designation4 && designation2 != designation5&& designation3 != designation4 && designation3 != designation5 && designation4 != designation5))

					{

							//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//return mapping.findForward("data");
					}
					else
					{
						if(
							((office1=="SUB DIVISION" && office2="SUB DIVISION" && office3="SUB DIVISION" && office4="SUB DIVISION") || 
							(office1=="DIVISION" && office2="DIVISION" && office3="DIVISION" && office4="DIVISION") || (office1=="CIRCLE" && office2="CIRCLE" && office3="CIRCLE" && office4="CIRCLE") || (office1=="HEAD OFFICE" && office2="HEAD OFFICE" && office3="HEAD OFFICE" && office4="HEAD OFFICE")) && (designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4 && ))
						{

						//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
					else
				{
					if(
						((office2=="SUB DIVISION" && office3="SUB DIVISION" && office4="SUB DIVISION" && office5="SUB DIVISION") || 
							(office2=="DIVISION" && office3="DIVISION" && office4="DIVISION" && office5="DIVISION") || (office2=="CIRCLE" && office3="CIRCLE" && office4="CIRCLE" && office5="CIRCLE") || (office2=="HEAD OFFICE" && office3="HEAD OFFICE" && office4="HEAD OFFICE" && office5="HEAD OFFICE")) && (designation2 != designation3 && designation2 != designation4 && designation2 != designation5 && designation3 != designation4 && designation3 != designation5 && designation4 != designation5 && ))
					{
								//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
					else
				{
					if(
						((office3=="SUB DIVISION" && office4="SUB DIVISION" && office5="SUB DIVISION" && office1="SUB DIVISION") || 
							(office3=="DIVISION" && office4="DIVISION" && office5="DIVISION" && office1="DIVISION") || (office3=="CIRCLE" && office4="CIRCLE" && office5="CIRCLE" && office1="CIRCLE") || (office3=="HEAD OFFICE" && office4="HEAD OFFICE" && office5="HEAD OFFICE" && office1="HEAD OFFICE")) && (designation3 != designation4 && designation3 != designation5 && designation3 != designation1 && designation4 != designation5 && designation4 != designation1 && designation5 != designation1 && ))
					{
								//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
					else
				{
					if(
						((office1=="SUB DIVISION" && office2="SUB DIVISION" && office4="SUB DIVISION" && office5="SUB DIVISION") || 
							(office1=="DIVISION" && office2="DIVISION" && office4="DIVISION" && office5="DIVISION") || (office1=="CIRCLE" && office2="CIRCLE" && office4="CIRCLE" && office5="CIRCLE") || (office1=="HEAD OFFICE" && office2="HEAD OFFICE" && office4="HEAD OFFICE" && office5="HEAD OFFICE")) && (designation1 != designation2 && designation1 != designation4 && designation1 != designation5 && designation2 != designation4 && designation2 != designation5 && designation4 != designation5 && ))
					{
								//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
				else
				{
					if((office1=="SUB DIVISION" && office2="SUB DIVISION" && office3="SUB DIVISION" && office5="SUB DIVISION") || 
							(office1=="DIVISION" && office2="DIVISION" && office3="DIVISION" && office5="DIVISION") || (office1=="CIRCLE" && office2="CIRCLE" && office3="CIRCLE" && office5="CIRCLE") || (office1=="HEAD OFFICE" && office2="HEAD OFFICE" && office3="HEAD OFFICE" && office5="HEAD OFFICE")) && (designation1 != designation2 && designation1 != designation3 && designation1 != designation5 && designation2 != designation3 && designation2 != designation5 && designation3 != designation5 && ))
					{
								//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
				else
				{
					//FOR THREE 
					if((
						(office1=="SUB DIVISION" && office2=="SUB DIVISION" && office3=="SUB DIVISION" && ((office4=="DIVISION" && office5=="DIVISION") || (office4=="CIRCLE" && office5=="CIRCLE") || (office4=="HEAD OFFICE" && office5=="HEAD OFFICE"))) || (office1=="DIVISION" && office2=="DIVISION" && office3=="DIVISION" &&(
						(office4=="SUB DIVISION" && office5=="SUB DIVISION") || (office4=="CIRCLE" && office5=="CIRCLE") || (office4=="HEAD OFFICE" && office5=="HEAD OFFICE"))) || (office1=="CIRCLE" && office2=="CIRCLE" && office3=="CIRCLE" && ((office4=="SUB DIVISION" && office5=="SUB DIVISION") || (office4=="DIVISION" && office5=="DIVISION") || (office4=="HEAD OFFICE" && office5=="HEAD OFFICE"))) || ( office1=="HEAD OFFICE" && office2=="HEAD OFFICE" && office3=="HEAD OFFICE" &&  ((office4=="SUB DIVISION" && office5=="SUB DIVISION") || (office4=="DIVISION" && office5=="DIVISION") || (office4=="CIRCLE" && office5=="CIRCLE"))))
						&& (designation1 != designation2 && designation1 != designation3 && designation2 != designation3 && designation5 != designation5))
					{
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}
				else
				{
					if((
						(office2=="SUB DIVISION" && office3=="SUB DIVISION" && office4=="SUB DIVISION" && ((office5=="DIVISION" && office1=="DIVISION") || (office5=="CIRCLE" && office1=="CIRCLE") || (office5=="HEAD OFFICE" && office1=="HEAD OFFICE"))) || (office2=="DIVISION" && office3=="DIVISION" && office4=="DIVISION" &&(
						(office5=="SUB DIVISION" && office1=="SUB DIVISION") || (office5=="CIRCLE" && office1=="CIRCLE") || (office5=="HEAD OFFICE" && office1=="HEAD OFFICE"))) || (office2=="CIRCLE" && office3=="CIRCLE" && office4=="CIRCLE" && ((office5=="SUB DIVISION" && office1=="SUB DIVISION") || (office5=="DIVISION" && office1=="DIVISION") || (office5=="HEAD OFFICE" && office1=="HEAD OFFICE"))) || ( office2=="HEAD OFFICE" && office3=="HEAD OFFICE" && office4=="HEAD OFFICE" &&  ((office5=="SUB DIVISION" && office1=="SUB DIVISION") || (office5=="DIVISION" && office1=="DIVISION") || (office5=="CIRCLE" && office1=="CIRCLE"))))
						&& (designation2 != designation3 && designation2 != designation4 && designation3 != designation4 && designation5 != designation1))
					{
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
						}
					}





//partial three
				










						
					|| ((office1=="SUB DIVISION" && office2="SUB DIVISION" && office3="SUB DIVISION")
						&& (designation1 != designation2 && designation1 != designation3 && designation2 != designation3))
					|| (
						((office1=="SUB DIVISION" && office2=="SUB DIVISION") && (designation1 != designation2) && (office3=="DIVISION" && office4=="DIVISION") || (office3="CIRCLE" && office4="CIRCLE") || (office3="HEAD OFFICE" && office4="HEAD OFFICE") && (designation3 != designation4) 
							||

						((office1=="SUB DIVISION" && office2=="SUB DIVISION") && (designation1 != designation2)&&
						(office3=="" && office4=="DIVISION") && (designation3 != designation4))
						
						)
					|| 
				{
					if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4)
					{
						//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						return mapping.findForward("data");
					}
				}
		
				if(office1=="DIVISION" && office2="DIVISION" && office3="DIVISION" && office4="DIVISION")
				{
					if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4)
					{
						//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						return mapping.findForward("data");
					}
				}


				//for all circle
				if(office1=="CIRCLE" && office2="CIRCLE" && office3="CIRCLE" && office4="CIRCLE")
				{
					if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4)
					{
						//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						return mapping.findForward("data");
					}
				}


			//all head office
			if(office1=="HEAD OFFICE" && office2="HEAD OFFICE" && office3="HEAD OFFICE" && office4="HEAD OFFICE")
				{
					if(designation1 != designation2 && designation1 != designation3 && designation1 != designation4 && designation2 != designation3 && designation2 != designation4 && designation3 != designation4)
					{
						//Ist
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IInd
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IIIrd
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
						RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						//IVth
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);			RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));

						return mapping.findForward("data");
					}
				}

			















				if(office1=="SUB DIVISION")
				{
					if(lowerLimit1 < upperLimit1)
					{ 
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				
				if(office2=="SUB DIVISION")
				{
					if(lowerLimit2 < upperLimit2)
					{
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}

			    if(offie3=="SUB DIVISION")
				{
					if(lowerLimit3 < upperLimit3)
					{
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office4=="SUB DIVISION")
				{
					if(lowerLimit4 < upperLimit4)
					{
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office5=="SUB DIVIDION")
				{
					if(lowerLimit5 < upperLimit5)
					{
						rwsMaster.setOffice(office5);
						rwsMaster.setDesignation(designation5);
						rwsMaster.setLowerLimit(lowerLimit5);
						rwsMaster.setUpperLimit(upperLimit5);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}					
				}

				//for DIVISION
				if(office1=="DIVISION")
				{
					if(lowerLimit1 < upperLimit1)
					{
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				
				if(office2=="DIVISION")
				{
					if(lowerLimit2 < upperLimit2)
					{
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}

			    if(offie3=="DIVISION")
				{
					if(lowerLimit3 < upperLimit3)
					{
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office4=="DIVISION")
				{
					if(lowerLimit4 < upperLimit4)
					{
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office5=="DIVIDION")
				{
					if(lowerLimit5 < upperLimit5)
					{
						rwsMaster.setOffice(office5);
						rwsMaster.setDesignation(designation5);
						rwsMaster.setLowerLimit(lowerLimit5);
						rwsMaster.setUpperLimit(upperLimit5);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}					
				}

				//for CIRCLE
				if(office1=="CIRCLE")
				{
					if(lowerLimit1 < upperLimit1)
					{
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				
				if(office2=="CIRCLE")
				{
					if(lowerLimit2 < upperLimit2)
					{
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}

			    if(offie3=="CIRCLE")
				{
					if(lowerLimit3 < upperLimit3)
					{
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office4=="CIRCLE")
				{
					if(lowerLimit4 < upperLimit4)
					{
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office5=="CIRCLE")
				{
					if(lowerLimit5 < upperLimit5)
					{
						rwsMaster.setOffice(office5);
						rwsMaster.setDesignation(designation5);
						rwsMaster.setLowerLimit(lowerLimit5);
						rwsMaster.setUpperLimit(upperLimit5);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}					
				}

				//for HEAD OFFICE
				if(office1=="HEAD OFFICE")
				{
					if(lowerLimit1 < upperLimit1)
					{
						rwsMaster.setOffice(office1);
						rwsMaster.setDesignation(designation1);
						rwsMaster.setLowerLimit(lowerLimit1);
						rwsMaster.setUpperLimit(upperLimit1);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				
				if(office2=="HEAD OFFICE")
				{
					if(lowerLimit2 < upperLimit2)
					{
						rwsMaster.setOffice(office2);
						rwsMaster.setDesignation(designation2);
						rwsMaster.setLowerLimit(lowerLimit2);
						rwsMaster.setUpperLimit(upperLimit2);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}

			    if(offie3=="HEAD OFFICE")
				{
					if(lowerLimit3 < upperLimit3)
					{
						rwsMaster.setOffice(office3);
						rwsMaster.setDesignation(designation3);
						rwsMaster.setLowerLimit(lowerLimit3);
						rwsMaster.setUpperLimit(upperLimit3);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office4=="HEAD OFFICE")
				{
					if(lowerLimit4 < upperLimit4)
					{
						rwsMaster.setOffice(office4);
						rwsMaster.setDesignation(designation4);
						rwsMaster.setLowerLimit(lowerLimit4);
						rwsMaster.setUpperLimit(upperLimit4);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}
				}
				if(office5=="HEAD OFFICE")
				{
					if(lowerLimit5 < upperLimit5)
					{
						rwsMaster.setOffice(office5);
						rwsMaster.setDesignation(designation5);
						rwsMaster.setLowerLimit(lowerLimit5);
						rwsMaster.setUpperLimit(upperLimit5);
				        ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
					}					
				}

		
		




				

				// HEAD OFFICE   DIVIDION 	   CIRCLE    SUB DIVISION 	if(frm.getOffice1()==" && frm.getDesignation() //
				if(frm.getUpperLimit1() < frm.getUpperLimit2())
				{
					if(frm.getLowerLimit2() < frm.getUpperLimit2())
					{

					}else
					{
						//System.out.println("LowerLimit2 is greater than UpperLimit")
				}else
				{
					//System.out.println("LowerLimit1 is greater than UpperLimit1");
					return mapping.findForward("data");
				}

				rwsMaster.setOffice(frm.getOffice1());
				rwsMaster.setDesignation(frm.getDesignation1());
				rwsMaster.setLowerLimit(frm.getLowerLimit1());
				rwsMaster.setUpperLimit(frm.getUpperLimit1());
				
				rwsMaster.setOffice(frm.getOffice2());
				rwsMaster.setDesignation(frm.getDesignation2());
				rwsMaster.setLowerLimit(frm.getLowerLimit2());
				rwsMaster.setUpperLimit(frm.getUpperLimit2());

				rwsMaster.setOffice(frm.getOffice3());
				rwsMaster.setDesignation(frm.getDesignation3());
				rwsMaster.setLowerLimit(frm.getLowerLimit3());
				rwsMaster.setUpperLimit(frm.getUpperLimit3());
				
				rwsMaster.setOffice(frm.getOffice4());
				rwsMaster.setDesignation(frm.getDesignation4());
				rwsMaster.setLowerLimit(frm.getLowerLimit4());
				rwsMaster.setUpperLimit(frm.getUpperLimit4());

				
				ans=RwsMasterData.insertTslimit(rwsMaster,getDataSource(request));
				//request.setAttribute("office",RwsMasterData.getOffice(getDataSource(request)));
				request.setAttribute("designations",RwsMasterData.getDesignation(getDataSource(request)));
			}
			
			catch(Exception e)
			{
				System.err.println("The error in rws_TslimitEntryAct_frm in insert is "+e);

			}
			if(ans <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
					message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		
		}
		*/
		
		
		
		/*
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildTslimitForm(request.getParameter("office"),request.getParameter("designation"),request);
				
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
				System.err.println("The error in rws_TslimitEntryAct_frm in get is "+e);
			}
		}
		*/
		/*
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setOffice(frm.getOffice());
				rwsMaster.setDesignation(frm.getDesignation());
				rwsMaster.setLowerLimit(frm.getLowerLimit());
				rwsMaster.setUpperLimit(frm.getUpperLimit());
				
				ans=RwsMasterData.updateTslimit(rwsMaster,getDataSource(request));
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_TslimitEntryAct_frm in edit is "+e);
			}
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message);
			}
		} */ 
			/*
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsMasterData.removeTslimit(request.getParameter("Office"),request.getParameter("Designation"),getDataSource(request));
				if(ans>0)
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
				System.err.println("The error in ws_TslimitEntryAct_frm in delete is "+e);
			}
		}
		*/
		return(mapping.findForward(mode));
	}
}
