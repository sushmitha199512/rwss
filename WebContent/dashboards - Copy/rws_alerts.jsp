<%	

	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String theAlertMessage = "";
	String ad=(String)session.getAttribute("userId");
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
		Object NOOFRCS = request.getAttribute("NO_OF_RCS");
		Object NOOFDFS = request.getAttribute("NO_OF_DFS");
		Object NOOFDRS = request.getAttribute("NO_OF_DRS");
		Object NOOFOHS = request.getAttribute("NO_OF_OHS");
		Object NOOFGLS = request.getAttribute("NO_OF_GLS");

        Object bank_process = request.getAttribute("bank_process");
        Object sec_alert = request.getAttribute("sec_alerts");
       


		String no_of_proposals_c = null;
		String no_of_proposals_a = null;
		String no_of_proposals_om_c = null;
		String no_of_proposals_om_a = null;
		String no_of_estimates = null;
		String no_of_estimates_om = null;
		
		String bank_status=null;
        String sec_msg=null;
	
		
		String no_of_rcs=null;
        String no_of_dfs=null;
        String no_of_drs=null;
        String no_of_ohs=null;
        String no_of_gls=null;

        if(ad.equals("admin") || ad.equals("100000") || ad.equals("secrwss") || ad.equals("minrwss")  ){
    		if(NOOFRCS != null)
    		{
    			no_of_rcs = String.valueOf(NOOFRCS);
    			theAlertMessage += "<font color=red><b><li>"
    							+ no_of_rcs + " Residual Chlorine Cases Pendings<br></li></b></font>";
    		}
    		if(NOOFDFS != null)
    		{
    			no_of_dfs = String.valueOf(NOOFDFS);
    			theAlertMessage += "<font color=red><b><li>"
    							+ no_of_dfs + " Scheme Cases Pendings<br></li></b></font>";
    		}
    		if(NOOFDRS != null)
    		{
    			no_of_drs = String.valueOf(NOOFDRS);
    			theAlertMessage += "<font color=red><b><li>"
    							+ no_of_drs + " Drought Cases Pendings<br></li></b></font>";
    		}
    		if(NOOFOHS != null)
    		{
    			no_of_ohs = String.valueOf(NOOFOHS);
    			theAlertMessage += "<font color=red><b><li>"
    							+ no_of_ohs + " OHSR Cases Pendings<br></li></b></font>";
    		}
    		if(NOOFGLS != null)
    		{
    			no_of_gls = String.valueOf(NOOFGLS);
    			theAlertMessage += "<font color=red><b><li>"
    							+ no_of_gls + " GLSR Cases Pendings<br></li></b></font>";
    		}
    		
    	}
    	else{
    		if(NOOFRCS != null)
    		{
    			no_of_rcs = String.valueOf(NOOFRCS);
    			theAlertMessage += "<li><a href=switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=get><font color=red><b>"
    							 + no_of_rcs + " Residual Chlorine Cases Pending</b></font></a><br></li>";
    		}
    		if(NOOFDFS != null)
    		{
    			no_of_dfs = String.valueOf(NOOFDFS);
    			theAlertMessage += "<li><a href=switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=get><font color=red><b>"
    							 + no_of_dfs + " Scheme Cases Pending</b></font></a><br></li>";
    		}
    		if(NOOFDRS != null)
    		{
    			no_of_drs = String.valueOf(NOOFDRS);
    			theAlertMessage += "<li><a href=switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=get><font color=red><b>"
    							+ no_of_drs + " Drought Cases Pending</b></font></a><br></li>";
    		}
    		if(NOOFOHS != null)
    		{
    			no_of_ohs = String.valueOf(NOOFOHS);
    			theAlertMessage += "<li><a href=switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=get><font color=red><b>"
						+ no_of_ohs + " OHSR Cases Pending</b></font></a><br></li>";
    		}
    		if(NOOFGLS != null)
    		{
    			no_of_gls = String.valueOf(NOOFGLS);
    			theAlertMessage += "<li><a href=switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=get><font color=red><b>"
						+ no_of_gls + " GLSR Cases Pending</b></font></a><br></li>";
    		}
    	}
	//theAlertMessage+="<img src='images/new1.gif'><a href='/pred/help/Final PPT Dec-2013-Submitted.ppt' target='_blank' ><b>SE' S Conference Dated:18-12-2013-Presentation.</b></a> <br><br>";
	
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
			theAlertMessage += "<a href=./works/rws_tobe_fwd_bills_frm.jsp?target=_self><font color=red><b>"+ "You have " + no_of_bills + " Pending Bill(s)</b></font></a><br>";
		}

		if(bank_process != null && (userid!=null && userid.indexOf("EE")>0))
		{
			bank_status =(String)request.getAttribute("bank_process");
			theAlertMessage += "<font color=red><b>"+ "Pending Process at Bank   " + bank_status + " </b></font></a><br>";
		}
       if(bank_process != null && (userid!=null && userid.equals("admin") || userid.equals("100000")))
		{
			bank_status =(String)request.getAttribute("bank_process");
			theAlertMessage += "<img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ " Pending Process at Bank   " + bank_status + " </b></font></a><br>&nbsp;";
		}

       if(sec_alert!=null && !sec_alert.equals(""))
		{
			sec_msg =(String)request.getAttribute("sec_alerts");            
            theAlertMessage += "<DIV> <img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ "RWSS  &nbsp;" + sec_msg + " </b></font><a href=./reports/rws_secrep_message_rpt.jsp target=_NEW>Read More>></a></DIV><br>";
		    
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