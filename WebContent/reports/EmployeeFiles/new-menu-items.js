function subItemsList()
{
alert("hai");
}
function init()
{
	//Main Menu items:
	menus[0] = new menu(22, "horizontal", 30, 100, -2, -2, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, 
		"bold", "bold", "black", "white", 1, "gray", 2, "rollover:/pred/images/tri-down1.gif:images/tri-down2.gif", false, true, true, true, 12, true, 2, 2, "#cccccc");
	menus[0].addItem("#", "", 130, "center", "Administrator", 1);
	menus[0].addItem("#", "", 120, "center", "Masters", 2);
	menus[0].addItem("#", "", 100, "center", "WorkFlow", 12);
	menus[0].addItem("#", "", 110, "center", "Graphs", 17);
	menus[0].addItem("#", "", 110, "center", "Reports", 19);
	menus[0].addItem("#", "", 80, "center", "Help", 28);
	menus[0].addItem("/pred/Logout.do", "", 80, "center", "LogOut", 0);

//Sub Menu for 1nd Main Menu Item ("Administrator"):
	menus[1] = new menu(158, "vertical", 0, 0, -5, -5, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, 62, false, true, false, true, 6, true, 2,  2, "#cccccc");
	menus[1].addItem("switch.do?prefix=/admin&page=/UserManagementData.do", "", 22, "left", "User Management", 0);
	menus[1].addItem("switch.do?prefix=/admin&page=/rws_change_password_frm.jsp", "", 22, "left", "Change Password", 0);
	menus[1].addItem("switch.do?prefix=/masters&page=/UserAudit.do&mode=data", "", 22, "left", "User Audit", 0);
	menus[1].addItem("#", "", 22, "left", "General Admin", 0);
    // to open a new window menus[1].addItem("#", "NEWWIN", 22, "left", "Example", 0);

//Sub Menus for 2rd Main Menu Item ("Masters"):
	menus[2] = new menu(160, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2, 2, "#cccccc");
 
	menus[2].addItem("#", "", 22, "left", "General", 3);
    menus[2].addItem("#", "", 22, "left", "Habitation", 4);
	menus[2].addItem("#", "", 22, "left", "Asset", 5);
    menus[2].addItem("#", "", 22, "left", "Source", 6);
    menus[2].addItem("#", "", 22, "left", "Programme", 7);
    menus[2].addItem("#", "", 22, "left", "Offices", 8);  
    menus[2].addItem("#", "", 22, "left", "Employee Details", 9);
	menus[2].addItem("#", "", 22, "left", "Head Of Accounts", 10);
	menus[2].addItem("#", "", 22, "left", "Contractor", 0);
    menus[2].addItem("#", "", 22, "left", "Water Quality", 11);
    menus[2].addItem("#", "", 22, "left", "PRED-OffLine", 38);

			//  "General":
				menus[3] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[3].addItem("switch.do?prefix=/masters&page=/PublicRep.do&mode=data", "", 22, "left", "Public Representatives", 0);
				menus[3].addItem("switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data", "", 22, "left", "Mandal Subdivision", 0);
				menus[3].addItem("switch.do?prefix=/masters&page=/Tslimit.do&mode=data", "", 22, "left", "Technical Sanction Monetary Limit", 0);
			//////////////////
    
			//  "Habitation":
				menus[4] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[4].addItem("switch.do?prefix=/masters&page=/PanchRaj.do&mode=data", "", 22, "left", "PanchayatRaj Habitations", 0);
				menus[4].addItem("switch.do?prefix=/masters&page=/Institute.do&mode=data", "", 22, "left", "Public Institutions", 0);
				menus[4].addItem("switch.do?prefix=/masters&page=/Priority.do&mode=data", "", 22, "left", "Priorities", 0);
				menus[4].addItem("masters/switch.do?prefix=/masters&page=/HabData.do", "", 22, "left", "Habitation Status", 0);
				
			//////////////////

             //  "Asset":
				menus[5] = new menu(240, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetType.do&mode=data", "", 22, "left", "Asset Type", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetCompType.do&mode=data", "", 22, "left", "Asset Component", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetSubCompType.do&mode=data", "", 22, "left", "Asset SubComponent", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetSubCompParam.do&mode=data", "", 22, "left", "Sub Component Parameters", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/Asset.do&mode=data", "", 22, "left", "Asset Master", 0);
			//////////////////
            
			 //  "Source":
				menus[6] = new menu(180, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[6].addItem("switch.do?prefix=/masters&page=/SourceType.do&mode=data", "", 22, "left", "Source Type", 0);
				menus[6].addItem("switch.do?prefix=/masters&page=/SubSourceType.do&mode=data", "", 22, "left", "Sub Source Type", 0);
				menus[6].addItem("switch.do?prefix=/masters&page=/Source.do&mode=data", "", 22, "left", "Source Master", 0);
			//////////////////
			 // "Programme":
				menus[7] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[7].addItem("switch.do?prefix=/masters&page=/Programme.do&mode=data", "", 22, "left", "Programme", 0);
				menus[7].addItem("switch.do?prefix=/masters&page=/SubProgramme.do&mode=data", "", 22, "left", "Sub Programme", 0);
			//////////////////
			 //  "Offices":
				menus[8] = new menu(170, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[8].addItem("switch.do?prefix=/masters&page=/Head.do&mode=data", "", 22, "left", "Head Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Circle.do&mode=data", "", 22, "left", "Circle Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Division.do&mode=data", "", 22, "left", "Division Office", 0);
			    menus[8].addItem("switch.do?prefix=/masters&page=/SubDivision.do&mode=data", "", 22, "left", "Subdivision Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Office.do&mode=data", "", 22, "left", "Rws Office Details", 0);
			    menus[8].addItem("switch.do?prefix=/masters&page=/Hoffice.do&mode=data", "", 22, "left", "Head Of Office", 0);
			//////////////////
			 //  "Employee Details":
				menus[9] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[9].addItem("switch.do?prefix=/masters&page=/Qual.do&mode=data", "", 22, "left", "Qualification", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/Desgn.do&mode=data", "", 22, "left", "Designation", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/WorkSpecial.do&mode=data", "", 22, "left", "Work Specialization", 0);
			    menus[9].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=data", "", 22, "left", "Employee Master", 0);
				//newly added as Employees Report 
				menus[9].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=checklist", "",22, "left","Check List", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=StatusForms", "",22, "left","Status Forms", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=DeptOptForms", "",22, "left","Department Opted Form", 0);
				
				

			//////////////////
			 //  "Head Of Accounts":
				menus[10] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[10].addItem("switch.do?prefix=/masters&page=/MajorHead.do&mode=data", "", 22, "left", "Major Head", 0);
				menus[10].addItem("switch.do?prefix=/masters&page=/SubMajorHead.do&mode=data", "", 22, "left", "Sub Major Head", 0);
				menus[10].addItem("switch.do?prefix=/masters&page=/MinorHead.do&mode=data", "", 22, "left", "Minor Head", 0);
			    menus[10].addItem("switch.do?prefix=/masters&page=/GrpSubHead.do&mode=data", "", 22, "left", "Group Sub Head", 0);
				menus[10].addItem("switch.do?prefix=/masters&page=/SubHead.do&mode=data", "", 22, "left", "Sub Head", 0);
				menus[10].addItem("switch.do?prefix=/masters&page=/DetailHead.do&mode=data", "", 22, "left", "Detail Head", 0);
				menus[10].addItem("switch.do?prefix=/masters&page=/SubDetailHead.do&mode=data", "", 22, "left", "Sub Detail Head", 0);
           //////////////////
		   // "water Quality":
				menus[11] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterTest.do&mode=data", "", 22, "left", "Test Master", 0);
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterPTest.do&mode=data", "", 22, "left", "Parameter Master", 0);
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterLab.do&mode=data", "", 22, "left", "Lab Master", 0);
			    menus[11].addItem("switch.do?prefix=/masters&page=/Contam.do&mode=data", "", 22, "left", "Contamination Master", 0);
   				menus[11].addItem("switch.do?prefix=/masters&page=/sampleTest.do&mode=sample1", "", 22, "left", "Sample Test Report", 0);
   				menus[11].addItem("switch.do?prefix=/masters&page=/sampleTest.do&mode=VariousTests","",22,"left","Tests On Single Source Report",0);
   				
   				
           
             				
			    
		    //////////////////

//Sub Menus for 3rd Main Menu Item ("workflow"):
  
	menus[12] = new menu(235, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2, 2, "#cccccc");
 
	menus[12].addItem("#", "", 22, "left", "Proposals", 13);
    menus[12].addItem("#", "", 22, "left", "Estimates", 14);
	menus[12].addItem("#", "", 22, "left", "Water Quality Management", 15);
    menus[12].addItem("#", "", 22, "left", "Contractor Management", 16);
    menus[12].addItem("#", "", 22, "left", "Works Monitoring", 36);
    menus[12].addItem("#", "", 22, "left", "Complaints Monitoring", 0);  
    menus[12].addItem("#", "", 22, "left", "Fund Accounting", 37);
	menus[12].addItem("#", "", 22, "left", "Stock Management", 0);
	          
			   // "Proposals":
				menus[13] = new menu(140, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,2, "#cccccc");
				menus[13].addItem("#", "", 22, "left", "New Works", 29);
				menus[13].addItem("#", "", 22, "left", "O&M Works", 30);
			   //////////////////
			     // "Estimates":
				menus[14] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[14].addItem("#", "", 22, "left", "New Estimates", 31);
				menus[14].addItem("#", "", 22, "left", "O&M Estimates", 32);
			   //////////////////
			      // "Water Quality Management":
				menus[15] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSample.do&mode=data", "", 22, "left", "Simple Collection", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data", "", 22, "left", "Sample Forwarded", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=data", "", 22, "left", "Quality Tests", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=data", "", 22, "left", "Source Identification & Finalization", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/DrillStatus.do&mode=data", "", 22, "left", "Drilling Status", 0);
		       //////////////////
			   // "Contractor Management":
				menus[16] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[16].addItem("switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=data", "", 22, "left", "Tender Schedule A", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/TenderNotification.do&mode=data", "", 22, "left", "Tender Notification", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/TenderApplication.do?mode=data", "", 22, "left", "Tender Application", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/TenderSubmit.do?mode=data", "", 22, "left", "Tender Submitted", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/TenderRegister.do&mode=data", "", 22, "left", "Tender Opening Register", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data", "", 22, "left", "Comparative Statement", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data", "", 22, "left", "Work Break Down Structure", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data", "", 22, "left", "Register Agreement", 0);
				menus[16].addItem("switch.do?prefix=/contractor&page=/DrillStatus.do&mode=data", "", 22, "left", "Work Management", 0);
			    //////////////////
//Sub Menus for 4rd Main Menu Item ("graphs"):
  
	menus[17] = new menu(200, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,  2, "#cccccc");
 
	menus[17].addItem("./reports/rws_coverage_graph_form.jsp", "", 22, "left", "Habitation Status", 0);
    menus[17].addItem("./reports/rws_graph_frm.jsp", "", 22, "left", "BoreWell Status", 0);
	menus[17].addItem("./reports/rws_graph_frm1.jsp", "", 22, "left", "FC-Proposed Year", 0);
    menus[17].addItem("./reports/rws_graph_frm2.jsp", "", 22, "left", "FC-Proposed Est.Cost", 0);
    menus[17].addItem("#", "", 22, "left", "Proposal", 18);
                
				  // "Proposal":
				menus[18] = new menu(210, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[18].addItem("#", "", 22, "left", "Representative", 33);
				menus[18].addItem("#", "", 22, "left", "Work Proposal", 34);
				menus[18].addItem("#", "", 22, "left", "Comparative Statement", 35);
			   //////////////////
	//Sub Menus for 4rd Main Menu Item ("Reports"):
  
	menus[19] = new menu(200, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,  2, "#cccccc");
 
	//menus[19].addItem("#", "", 22, "left", "Master Reports", 20);
    menus[19].addItem("#", "", 22, "left", "New Proposals", 21);
	menus[19].addItem("#", "", 22, "left", "O&M Proposals", 22);
    menus[19].addItem("#", "", 22, "left", "Pendency Status", 23);
    menus[19].addItem("#", "", 22, "left", "Water Quality", 24);
	menus[19].addItem("#", "", 22, "left", "Estimates", 25);
	 
                
				  // "Master Reports":
				menus[20] = new menu(130, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[20].addItem("#", "", 22, "left", "Habitation", 26);
				menus[20].addItem("#", "", 22, "left", "Asset", 27);
			   //////////////////

			                 // "Habitation":
							menus[26] = new menu(150, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
							menus[26].addItem("./reports/rws_hab_update_frm.jsp", "", 22, "left", "Habitations Last Updated", 0);
							menus[26].addItem("./reports/rws_hab_dist_combo.jsp", "", 22, "left", "Habitations Not Updated", 0);
							menus[26].addItem("./reports/rws_hab_status_form.jsp", "", 22, "left", "Location Status", 0);
							menus[26].addItem("./reports/rws_const_coverage_status_frm.jsp", "", 22, "left", "Constituency Stauts", 0);
							menus[26].addItem("./reports/rws_office_coverage_frm.jsp", "", 22, "left", "Office Wise Status", 0);
							menus[26].addItem("./reports/rws_coverage_status_frm1.jsp", "", 22, "left", "District Wise", 0);
							menus[26].addItem("./reports/rws_planning_format1_frm.jsp", "", 22, "left", "RWS Planing-Format-I", 0);
							menus[26].addItem("./reports/rws_planning_format2_frm.jsp", "", 22, "left", "RWS Planing-Format-II", 0);
                            //////////////////
						     // "Asset":
							menus[27] = new menu(160, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
							menus[27].addItem("./reports/rws_district_rpt.jsp", "", 22, "left", "BoreWell Status", 0);
							menus[27].addItem("./reports/rws_asset_hab_off_frm.jsp", "", 22, "left", "Office -Asset/Hab", 0);
							menus[27].addItem("switch.do?prefix=/reports&page=/PublicInst.do?mode=data", "", 22, "left", "Public Institutions", 0);
							menus[27].addItem("switch.do?prefix=/reports&page=/CheckList.do?mode=data", "", 22, "left", "Check List Sub Components", 0);
						   //////////////////
			     // "New Proposals":
				menus[21] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[21].addItem("./reports/rws_rep_proposal_frm.jsp", "", 22, "left", "Representative", 0);
			    menus[21].addItem("./reports/rws_work_propo_det_frm.jsp", "", 22, "left", "Work Proposal", 0);
				menus[21].addItem("switch.do?prefix=/proposals&page=/NewProposalTrackingData.do", "", 22, "left", "Proposal History", 0);
			   //////////////////
			     // "O&M Proposals":
				menus[22] = new menu(160, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[22].addItem("./reports/rws_om_proposal_det_frm.jsp", "", 22, "left", "O&M Proposals", 0);
				menus[22].addItem("switch.do?prefix=/proposals&page=/OMProposalTrackingData.do", "", 22, "left", "Proposal History", 0);
			   //////////////////
			     // "Pendency Status":
				menus[23] = new menu(180, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[23].addItem("./reports/rws_proposal_pendency_rep_frm.jsp", "", 22, "left", "Representative Wise", 0);
				menus[23].addItem("./reports/rws_proposal_pendency_consti_frm.jsp", "", 22, "left", "Constituency Wise", 0);
			   //////////////////
			     // "Water Quality":
				menus[24] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[24].addItem("./reports/rws_source_loc_rpt_frm.jsp", "", 22, "left", "Source Details", 0);
				 
			   //////////////////
			     // "Estimates":
				menus[25] = new menu(170, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2,  2, "#cccccc");
				menus[25].addItem("./reports/rws_con_wise_est_cost_frm.jsp", "", 22, "left", "Constituency Wise", 0);
		      ///////////////////

	
//Sub Menus for Main Menu Item ("Help"):
	menus[28] = new menu(160, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 2,  2, "#cccccc");
 
	menus[28].addItem("./help/Help For PRED.htm", "", 22, "left", "Online Help", 0);
    menus[28].addItem("./help/Data Input Sheets Layout.doc", "", 22, "left", "Data Input Sheets", 0);
	menus[28].addItem("./masters/goForm.jsp", "", 22, "left", "GO'S", 0);
    menus[28].addItem("./masters/leForm.jsp?mode=data", "", 22, "left", "Estimates", 0);
    menus[28].addItem("./help/SSR 2005-2006.doc", "", 22, "left", "SSR 2005-2006", 0);
	menus[28].addItem("#", "", 22, "left", "Rate Contact", 0);

////Sub menu items of work flow proposals-new work flow
           // "New Work Proposals":
				menus[29] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[29].addItem("switch.do?prefix=/proposals&page=/RepresentativeProposalData.do", "", 22, "left", "Representation", 0);
				menus[29].addItem("switch.do?prefix=/proposals&page=/NewProposalData.do", "", 22, "left", "Manage Proposal", 0);
                menus[29].addItem("switch.do?prefix=/proposals&page=/NewAdminProposalData.do", "", 22, "left", "Administrative Sanction", 0);
		 		menus[29].addItem("switch.do?prefix=/proposals&page=/ListNewProposals.do", "", 22, "left", "List Proposals", 0);
			 ////////////////////
		   // "O&M Work Proposals":
				menus[30] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[30].addItem("switch.do?prefix=/proposals&page=/OMProposalData.do", "", 22, "left", "Proposal", 0);
                menus[30].addItem("switch.do?prefix=/proposals&page=/OMAdminProposalData.do", "", 22, "left", "Administrative Sanction", 0);
				menus[30].addItem("switch.do?prefix=/proposals&page=/ListOMProposals.do", "", 22, "left", "List Proposals", 0);		 
		  /////////////////////////
		  // "Estimates-NEW ESTIMATES":
				menus[31] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[31].addItem("switch.do?prefix=/estimates&page=/NewEstimateData.do", "", 22, "left", "Preparation", 0);
				menus[31].addItem("switch.do?prefix=/estimates&page=/NewEstSanctionData.do", "", 22, "left", "Technical Sanction", 0);
               	 ////////////////////
		  // "ESTIMATES 0&M ESTMATES":
				menus[32] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[32].addItem("switch.do?prefix=/estimates&page=/OMEstimateData.do", "", 22, "left", "Preparation", 0);
                menus[32].addItem("switch.do?prefix=/estimates&page=/OMEstSanctionData.do", "", 22, "left", "Technical Sanction", 0);
			/////////////////////////
	////su menu items of WORKFLOW-PROPOSAL
               // "Representaive wise":
				menus[33] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[33].addItem("./reports/rws_circle_rep_proposal_graph_frm.jsp", "", 22, "left", "Office Wise", 0);
				menus[33].addItem("./reports/rws_scheme_rep_proposal_graph_frm.jsp", "", 22, "left", "SchemeWise", 0);
				menus[33].addItem("./reports/rws_repre_proposal_graph_frm.jsp", "", 22, "left", "Representaive Wise", 0);
               
               	 ////////////////////
				 // "WOrk-Proposal":
				menus[34] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[34].addItem("./reports/rws_circle_work_proposal_graph_frm.jsp", "", 22, "left", "Office Wise", 0);
				menus[34].addItem("./reports/rws_scheme_work_proposal_graph_frm.jsp", "", 22, "left", "SchemeWise", 0);
               	 ////////////////////
				 // "Comparative Statement":
				menus[35] = new menu(160, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[35].addItem("./reports/rws_rep_proposal_cost_graph_frm.jsp", "", 22, "left", "Constituency & COst Wise", 0);
				menus[35].addItem("./reports/rws_proposal_consti_comp_graph_form.jsp", "", 22, "left", "Between Constituencies", 0);
				menus[35].addItem("./reports/rws_proposal_offices_comp_graph_form.jsp", "", 22, "left", "Offices & Year Wise", 0);
				menus[35].addItem("./reports/rws_work_status_different_stages_graph_frm.jsp", "", 22, "left", "Work Status", 0);

               	 ////////////////////
          ///////works Monitoring    	 
		        menus[36] = new menu(160, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[36].addItem("switch.do?prefix=/proposals&page=/AdminstrativeSanction.do", "", 22, "left", "Administrative Sanction", 0);
				menus[36].addItem("switch.do?prefix=/proposals&page=/RevisedSanction.do", "", 22, "left", "Revise Sanction", 0);
				menus[36].addItem("switch.do?prefix=/proposals&page=/Workwise.do?mode=circles", "", 22, "left", "Workwise Report", 0);
				menus[36].addItem("switch.do?prefix=/proposals&page=/prajapadam.do?mode=data", "", 22, "left", "Prajapadam", 0);
				menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenFinancialProgressActiont.do", "", 22, "left", "EOAT", 0);
				menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenWorksMonitoringAction.do", "", 22, "left", "Works Monitoring", 0);
				menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/workStatus.do", "", 22, "left", "Work Status", 0);
				menus[36].addItem("switch.do?prefix=/drought&page=/drought.do?mode=data", "", 22, "left", "Drought", 0);
				menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/workExpenditure.do","",22,"left","Works Expenditure",0);
					
 	    menus[37] = new menu(160, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
				menus[37].addItem("switch.do?prefix=/fund&page=/budgetEst.do?mode=data", "", 22, "left", "Budget Estimate", 0);
				menus[37].addItem("switch.do?prefix=/fund&page=/budgetRel.do?mode=data", "", 22, "left", "Budget Release Order", 0);
				
				//"PRED-OffLine Testing Code" 
            menus[38] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
			menus[38].addItem("switch.do?prefix=/masters&page=/offLine.do&mode=offline", "", 22, "left", "offline Delete", 0);
			//menus[40].addItem("./masters/rws_offline_delete_frm.jsp", "", 22, "left", "Deletion Form", 0);
			
				 		      	 
} //OUTER CLOSING BRACKET. EVERYTHING ADDED MUST BE ABOVE THIS LINE.