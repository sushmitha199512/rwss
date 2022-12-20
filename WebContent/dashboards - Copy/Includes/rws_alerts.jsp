<%	

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String theAlertMessage = "";
	String ad=(String)session.getAttribute("userId");
	//Debug.out("ad is "+ad);
 System.out.println("123:"+request.getParameter("loginMode"));
	
	if(request.getParameter("loginMode")==null || (request.getParameter("loginMode")!=null && request.getParameter("loginMode").equals("watersoft")))
	{
		
		Object oNoOfProposalsC = request.getAttribute("NO_OF_PROPOSALS_C");
		Object oNoOfProposalsA = request.getAttribute("NO_OF_PROPOSALS_A");
		Object oNoOfProposalsOMC = request.getAttribute("NO_OF_PROPOSALS_OM_C");
		Object oNoOfProposalsOMA = request.getAttribute("NO_OF_PROPOSALS_OM_A");
		Object oNoOfEstimates = request.getAttribute("NO_OF_ESTIMATES");
		Object oNoOfEstimatesOM = request.getAttribute("NO_OF_ESTIMATES_OM");
		Object no_of_vouchers = request.getAttribute("no_of_vouchers");
		Object no_of_bills = request.getAttribute("no_of_bills");
//added by jyothi
        Object bank_process = request.getAttribute("bank_process");
        Object sec_alert = request.getAttribute("sec_alerts");
       //


		String no_of_proposals_c = null;
		String no_of_proposals_a = null;
		String no_of_proposals_om_c = null;
		String no_of_proposals_om_a = null;
		String no_of_estimates = null;
		String no_of_estimates_om = null;
		
		//added by jyothi
		String bank_status=null;
        String sec_msg=null;
	
	//	
		
		

		if(oNoOfProposalsC != null)
		{
			no_of_proposals_c = String.valueOf(oNoOfProposalsC);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/NewProposalData.do>"
							+ "You have " + no_of_proposals_c + " New proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsA != null)
		{
			no_of_proposals_a = String.valueOf(oNoOfProposalsA);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/NewAdminProposalData.do>"
							+ "You have " + no_of_proposals_a + " New sanctioned proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsOMC != null)
		{
			no_of_proposals_om_c = String.valueOf(oNoOfProposalsOMC);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/OMProposalData.do>"
							+ "You have " + no_of_proposals_om_c + " O&M proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsOMA != null)
		{
			no_of_proposals_om_a = String.valueOf(oNoOfProposalsOMA);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/OMAdminProposalData.do>"
							+ "You have " + no_of_proposals_om_a + " O&M sanctioned proposal(s)</a><br>";
		}
		
		if(oNoOfEstimates != null)
		{
			no_of_estimates = String.valueOf(oNoOfEstimates);
			theAlertMessage += "<a href=switch.do?prefix=/estimates&page=/NewEstSanctionData.do>"
							+ "You have " + no_of_estimates + " estimates(s)</a><br>";
		}
		
		if(oNoOfEstimatesOM != null)
		{
			no_of_estimates_om = String.valueOf(oNoOfEstimatesOM);
			theAlertMessage += "<a href=switch.do?prefix=/estimates&page=/OMEstSanctionData.do>"
							+ "You have " + no_of_estimates_om + " O&M estimates(s)</a><br>";
		}
		
		if(no_of_vouchers != null && (userid!=null && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=./reports/rws_work_voucher_pending_rpt.jsp?userIdd="+userid+" target=_NEW><font color=red><b>"+ "You have " + no_of_vouchers + " New Voucher(s)</b></font></a><br>";
		}

		if(no_of_bills != null && (userid!=null && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=switch.do?prefix=/works&page=/TokenVerify.do&mode=data target=_self><font color=red><b>"+ "You have " + no_of_bills + " Pending Bill(s)</b></font></a><br>";
		}

//added by jyothi
		if(bank_process != null && (userid!=null && userid.indexOf("EE")>0))
		{
			bank_status =(String)request.getAttribute("bank_process");
            System.out.println("bank_status is "+bank_status);
			theAlertMessage += "<font color=red><b>"+ "Pending Process at Bank   " + bank_status + " </b></font></a><br>";
		}
       if(bank_process != null && (userid!=null && userid.equals("admin") || userid.equals("100000")))
		{
			bank_status =(String)request.getAttribute("bank_process");
            System.out.println("bank_status is "+bank_status);
			theAlertMessage += "<img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ " Pending Process at Bank   " + bank_status + " </b></font></a><br>&nbsp;";
		}

       if(sec_alert!=null && !sec_alert.equals(""))
		{
			sec_msg =(String)request.getAttribute("sec_alerts");            
            System.out.println("sec_alert is "+sec_msg);
            theAlertMessage += "<DIV> <img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ "RWSS SECRETARY &nbsp;" + sec_msg + " </b></font><a href=./reports/rws_secrep_message_rpt.jsp target=_NEW>Read More>></a></DIV><br>";
		    
        }



		if(theAlertMessage != null && theAlertMessage.length()>0)
		{
			int indexOfBR = theAlertMessage.lastIndexOf("<br>");
			theAlertMessage = theAlertMessage.substring(0, indexOfBR);
		}
 if(theAlertMessage==null || theAlertMessage.equals("")){
theAlertMessage=(String)session.getAttribute("theAlertMessage");
}else {
  session.setAttribute("theAlertMessage",theAlertMessage);
}
}


%>