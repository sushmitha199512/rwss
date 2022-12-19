<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/commons/rws_header1.jsp" %>


<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <link type="text/css" href="resources/javascript/menu.css" rel="stylesheet" />
    <script type="text/javascript" src="resources/javascript/jquery.js"></script>
    <script type="text/javascript" src="resources/javascript/menu.js"></script>
</head>





<style type="text/css">
* { margin:0;
    padding:0;
}

div#menu {
    margin-top:0.5cm;
    margin-left:5.5cm;
    width:100%;
}
body { background:#eeffee; }
</style>



<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId(); 
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
			theAlertMessage += "<a href=./works/rws_tobe_fwd_bills_frm.jsp target=_NEW><font color=red><b>"+ "You have " + no_of_bills + " Pending Bill(s)</b></font></a><br>";
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
System.out.println(theAlertMessage);
		}
}



%>

<script type="text/javascript">

function doBlink() {
  // Blink, Blink, Blink...
  var blink = document.all.tags("BLINK")
  for (var i=0; i < blink.length; i++)
    blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : "" 
}

function startBlink() {
  // Make sure it is IE4
  if (document.all)
    setInterval("doBlink()",100);
}


var description=new Array()
description[0]='<%= theAlertMessage%>';



//Do not edit below here

iens6=document.all||document.getElementById
ns4=document.layers

<!--GLOBAL VARIABLES-->
var thename
var theobj
var thetext
var winHeight
var winPositionFromTop
var winWidth
var startH=2
var openTimer
<!--END GLOBAL VARIABLES-->

function setObj(text,theswitch,inwidth,inheight) {

	thetext=text
	if(iens6){

		thename = "viewer"
		theobj=document.getElementById? document.getElementById(thename):document.all.thename
		winHeight=100
			if(iens6&&document.all) {

				winPositionFromTop=!window.opera? ietruebody().clientHeight : document.body.clientHeight
				winWidth=(ietruebody().clientWidth-ietruebody().leftMargin)
			}
			if(iens6&&!document.all) {
				winPositionFromTop=window.innerHeight
				winWidth=(window.innerWidth-(ietruebody().offsetLeft+30))
			}
			if(theswitch=="override") {
				winWidth=inwidth
				winHeight=inheight
			}
		theobj.style.width=winWidth+"px"
		theobj.style.height=startH+"px"
			if(iens6&&document.all) {
				theobj.style.top=ietruebody().scrollTop+winPositionFromTop+"px"
				//window.status=winPositionFromTop
				theobj.innerHTML = ""
				theobj.insertAdjacentHTML("BeforeEnd","<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2'	style='color:black;font-weight:normal'>"+thetext+"</font></td>	</tr></table>")
			}
			if(iens6&&!document.all) {
				theobj.style.top=window.pageYOffset+winPositionFromTop+"px"
				theobj.innerHTML = ""
				theobj.innerHTML="<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2' style='color:black;font-weight:normal'>"+thetext+"</font></td></tr></table>"}
	}
	if(ns4){
		thename = "nsviewer"
		theobj = eval("document."+thename)
		winPositionFromTop=window.innerHeight
		winWidth=window.innerWidth
		winHeight=100
			if(theswitch=="override") {
				winWidth=inwidth
				winHeight=inheight
			}
		theobj.moveTo(0,eval(window.pageYOffset+winPositionFromTop))
		theobj.width=winWidth
		theobj.clip.width=winWidth
		theobj.document.write("<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2' style='color:black;font-weight:normal'>"+thetext+"</font></td></tr></table>")
		theobj.document.close()
	}
	viewIt()
}

function viewIt() {

	if(startH<=winHeight) {
		if(iens6) {
			theobj.style.visibility="visible"
				if(iens6&&document.all) {
					theobj.style.top=(ietruebody().scrollTop+winPositionFromTop)-startH+"px"
				}
				if(iens6&&!document.all) {
					theobj.style.top=(window.pageYOffset+winPositionFromTop)-startH+"px"
				}
			theobj.style.height=startH+"px"
			startH+=2
			openTimer=setTimeout("viewIt()",10)
		}
		if(ns4) {
			theobj.visibility = "visible"
			theobj.moveTo(0,(eval(window.pageYOffset+winPositionFromTop)-startH))
			theobj.height=startH
			theobj.clip.height=(startH)
			startH+=2
			openTimer=setTimeout("viewIt()",10)
		}
	}else{
		clearTimeout(openTimer)
	}
}

function stopIt() {
	if(iens6) {
		theobj.innerHTML = ""
		theobj.style.visibility="hidden"
		startH=2
	}
	if(ns4) {
		theobj.document.write("")
		theobj.document.close()
		theobj.visibility="hidden"
		theobj.width=0
		theobj.height=0
		theobj.clip.width=0
		theobj.clip.height=0
		startH=2
	}

}
</script>
<body onload="setObj(description[0],'override',300,100);">

<table border=0 width="100%" bgcolor="lightcyan" cellpadding=0 cellspacing=0>
	<!-- watersoft header begins here -->
	
	<tr>
		
		<td align=center class="pageHeading"><img src="./images/logo-1normal.jpg"></td>
	</tr>

	
<tr><td>


<div id="menu">
    <ul class="menu">
        <li><a href="#" class="parent"><span>Administrator</span></a>
            <div><ul>
                <li><a href="switch.do?prefix=/admin&page=/UserManagementData.do" ><span>User Management</span></a>
                  <li><a href="switch.do?prefix=/admin&page=/rws_change_password_frm.jsp"><span>Change Password</span></a></li>
                        <li><a href="switch.do?prefix=/masters&page=/UserAudit.do&mode=data2"><span>User Audit</span></a></li>
                     
<li><a href="works/rws_works_mpr_frm.jsp"><span>Scheme MPR Generation</span></a></li>
<li><a href="reports/rws_financial_exp_porting_frm.jsp"><span>Porting - Fin Progress(Excel)</span></a></li>
<li><a href="switch.do?prefix=/reports&page=/accessPorting.do"><span>MPR Porting(Access)</span></a></li>
<li><a href="switch.do?prefix=/reports&page=/PSExcel.do"><span>ProjectShelf Porting(Access)</span></a></li>



            </ul></div>
        </li>
        <li><a href="#" class="parent"><span>Masters</span></a>
            <div><ul>
                <li><a href="#" class="parent"><span>WorkFlow</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul></div>
                </li>
                <li><a href="#" class="parent"><span>Sub Item 2</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 2.1</span></a></li>
                        <li><a href="#"><span>Sub Item 2.2</span></a></li>
                    </ul></div>
                </li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
                <li><a href="#"><span>Sub Item 4</span></a></li>
                <li><a href="#"><span>Sub Item 5</span></a></li>
                <li><a href="#"><span>Sub Item 6</span></a></li>
                <li><a href="#"><span>Sub Item 7</span></a></li>
            </ul></div>
        </li>
<li class="last"><a href="#"><span>WorkFlow</span></a>
<div><ul>
                        <li><a href="#" class="parent"><span>Works Monitoring</span></a>


<div><ul>

    <li><a href="./works/rws_files_browse.jsp"><span>Download File</span></a></li>
                        <li><a href="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=null"><span>Administration Sanction</span></a></li>
                        <li><a href="switch.do?prefix=/proposals&page=/RevisedSanction.do&initial=true"><span>Revised Administrative Sanction</span></a></li>
                        <li><a href="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=clear"><span>DPR/Permission Status</span></a></li>
                        <li><a href="switch.do?prefix=/works&page=/WorkStatus.do&mode=circles"><span>Work Progress</span></a></li>


 <li><a href="switch.do?prefix=/works&page=/worksDelete.do&mode=data"><span>Works Deletion</span></a></li>

 <li><a href="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data&mode1=circles"><span>Update Action Plan</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data"><span>Augmentation-MainScheme Linkage</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/SchemeAsset.do&mode=circles"><span>Scheme-Asset Integration</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/eoatFrm.do?mode=init"><span>Extension Of Agreement Time</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/worklocality.do&mode=data"><span>Works Locality from</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=circles"><span>Annual Action Plan</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=circles"><span>Probable Date of Comp.</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/WorkLink.do&mode=data"><span>Work Link(Old/New)</span></a></li>
 <li><a href="switch.do?prefix=/works&page=/HabLink.do&mode=data"><span>Habs Link(Admin/Technical)</span></a></li>

                    </ul></div>

</li>
                        <li><a href="#" class="parent"><span>Fund Accounting</span></a>


<div><ul>
                        <li><a href="./works/rws_work_parta_bill_frm.jsp"><span>Part-A Bills & Voucher Payments</span></a></li>
                        <li><a href="./works/rws_work_bill_frm.jsp"><span>Bills</span></a></li>
 <li><a href="#" class="parent"><span>Voucher Payments</span></a>

<div><ul>
                        <li><a href="./works/rws_work_exp_voucher_frm.jsp"><span>Direct Voucher Payments</span></a></li>
                        <li><a href="./works/rws_work_voucher_frm.jsp"><span>Vouchers Payments For Bill</span></a></li>
                    </ul></div>

</li>
                       </ul></div>

</li>
 <li><a href="#" class="parent"><span>WQ Management</span></a>

<div><ul>
                        <li><a href="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data"><span>Lab Testing</span></a></li>
                        <li><a href="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data"><span>FTK Testing</span></a></li>
              
                   </ul></div>
		
</li>
 <li><a href="#" class="parent"><span>Drought Monitoring</span></a>


<div><ul>
                        <li><a href="switch.do?prefix=/drought&page=/PowerTransport.do&mode=get2&special=reset"><span>Habitations For Drought</span></a></li>
                        <li><a href="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=districts"><span>Daily Entry(TRANS,HIRING)</span></a></li>
                        <li><a href="switch.do?prefix=/drought&page=/FlushDeep.do&mode=data&special=reset"><span>Flushing Deepening of Borewells</span></a></li>
<li><a href="switch.do?prefix=/drought&page=/sstank.do&mode=data&special=reset"><span>Drought SS Tanks</span></a></li>
<li><a href="switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=null"><span>Drought Works</span></a></li>
                    </ul></div>


</li>
                    </ul></div>
</li>
          <li><a href="#" class="parent"><span>Reports</span></a>
            <div><ul>
                <li><a href="#" class="parent"><span>Master Reports</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul></div>
                </li>
<li><a href="#" class="parent"><span>Contractot Management</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul></div>
                </li>
<li><a href="#" class="parent"><span>Works Monitoring</span></a>
                    <div><ul>
                        <li><a href="#"><span>Free Format Report</span></a></li>
                        <li><a href="#" class="parent"><span>RFD</span></a>


                    <div><ul>
                        <li><a href="./reports/RFDReports/rws_fin_phy_prg_ach_frm.jsp" ><span>Financial and Physical Achievements</span></a></li>
                        <li><a href="./reports/rws_work_dpr_fin_frm.jsp" ><span>DPR Status Progress Report</span></a></li>
                        <li><a href="./reports/rws_work_dpr_fin_StatusPermissions_frm.jsp" ><span>DPR Permission Status</span></a></li>



<li><a href="./reports/RFDReports/rws_rfd_schools_rpt.jsp"><span> Coverage of Schools/Anganwadis with Drinking Water Facilities</span></a></li>

   <li><a href="./reports/rws_svs_mvs_detail_rpt.jsp"><span></span></a></li>
   <li><a href="./reports/rws_svs_mvs_prevcomp_curr_update_rpt.jsp"><span>Work Completion Date Updation </span></a></li>
      <li><a href="./reports/rws_susworks_finphy_details_rpt.jsp"><span>Sustainbility Structures</span></a></li>
     <li><a href="./reports/RFDReports/rws_WQ_RFD_lab_frm.jsp"><span>Water Quality-Lab Abstract</span></a></li>
          <li><a href="./reports/rws_ftk_test_ftkuptomonth_frm.jsp"><span>Water Quality-FTK Abstract</span></a></li>
            <li><a href="./reports/RFDReports/rws_asset_habs_status_rpt.jsp"><span>Scheme(MVS)-Hab Status</span></a></li>
                     <li><a href="./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp"><span>Scheme(SVS)-Hab Status</span></a></li>
                     <li><a href="./reports/RFDReports/rws_drought_works_abstract_rpt.jsp"><span>Drought Works Status</span></a></li>
       
                  </ul>
</div>


</li>


<li><a href="#" class="parent"><span>RFD Secratory</span></a>


                    <div><ul>
                        <li><a href="./Secretary/rws_works_program_details_frm.jsp" ><span>Abstract Works Spill Over/ New</span></a></li>
            

</ul>
</div>

</li>



<li><a href="#" class="parent"><span>Performance</span></a>

    <div><ul>
                        <li><a href="./reports/rws_performance_sc_st_frm.jsp" ><span>SC,ST,Plain SVS-ABSTRACT</span></a></li>
                        <li><a href="./reports/rws_performance_mvs_scst_frm.jsp" ><span>SC,ST,Plain MVS-ABSTRACT</span></a></li>

</ul>
</div>




</li>
<li><a href="#"><span>Abstract</span></a></li>
                    </ul></div>
                </li>
</ul>
</div>



</li>



        <li class="last"><a href="#"><span>Graphs</span></a></li>
        <li class="last"><a href="#"><span>Downloads</span></a>

  <div><ul>
                        <li><a href="switch.do?prefix=/reports&page=/offlinePatches.do" ><span>Offline Patches</span></a></li>
 <li><a href="./reports/rws_download_newfrm.jsp" ><span>Data Download</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/accessPorting.do" ><span>MPR Porting(Access)</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/PSExcel.do" ><span>ProjectShelf Porting</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/ListTables.do" ><span>Tables Data Download</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/GisTables.do" ><span>GIS Tables Data</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/accessPorting.do" ><span>MPR Porting(Access)</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/PSExcel.do" ><span>ProjectShelf Porting</span></a></li>
     <li><a href="switch.do?prefix=/reports&page=/draccessPorting.do" ><span>Drought Porting(Access)</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/WQExcel.do" ><span>WQ LAB Porting</span></a></li>
 <li><a href="switch.do?prefix=/reports&page=/WQFTKACCESS.do" ><span>WQ FTK Porting</span></a></li>
        

</ul>
</div>

</li>
        <li><a href="#"><span>Help</span></a></li>
        <li><a href="#"><span>LogOut</span></a></li>


    </ul>
</div>
</td>
</tr>



<tr class="rptValue">
<font color="green">
				<td nowrap ><b> Welcome, <bean:write name="RWS_USER"
					property="userId" /> <font face="italic" size=1 color=#0000FF> <logic:notEqual
					name="RWS_USER" property="circleOfficeCode" value="00"> -- <bean:write
						name="RWS_USER" property="circleOfficeName" />
				</logic:notEqual> <logic:notEqual name="RWS_USER"
					property="divisionOfficeCode" value="00"> -- <bean:write
						name="RWS_USER" property="divisionOfficeName" />
				</logic:notEqual> <logic:notEqual name="RWS_USER"
					property="subdivisionOfficeCode" value="00"> -- <bean:write
						name="RWS_USER" property="subdivisionOfficeName" />
				</logic:notEqual> </font> [ <c:out
					value="${sessionScope.RWS_USER.officeName} User" /> ]</b></td>
				
	
				</font>
			
			</tr>
	</table>

 <table width="99%" border="0" cellspacing="0" cellpadding="0" >
<tr><td></td></tr>
</table>
</body>
</html>