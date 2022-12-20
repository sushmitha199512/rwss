
function subItemsList()
{
//alert("hai"); 
}
function init()
{
	//Main Menu items:
	menus[0] = new menu(22, "horizontal", 0, 100, -2, -2, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, 
		"bold", "bold", "black", "white", 1, "gray", 2, "rollover:/pred/images/tri-down1.gif:images/tri-down2.gif", false, true, true, true, 12, true, 4, 4, "#cccccc");
	menus[0].addItem("#", "", 130, "center", "Administrator", 1);
	
	menus[0].addItem("#", "", 120, "center", "Masters", 2);
	menus[0].addItem("#", "", 100, "center", "WorkFlow", 12);
	menus[0].addItem("#", "", 110, "center", "Reports", 19);
	menus[0].addItem("#", "", 110, "center", "Graphs", 17);  
	menus[0].addItem("#", "", 110, "center", "Downloads", 45);
	menus[0].addItem("#", "", 80, "center", "Help", 28);
	menus[0].addItem("/pred/Logout.do", "", 80, "center", "LogOut", 0);

	//Sub Menu for 1nd Main Menu Item ("Administrator"):
	menus[1] = new menu(225, "vertical", 0, 0, -5, -5, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, 62, false, true, false, true, 6, true, 4, 4, "#cccccc");
	menus[1].addItem("switch.do?prefix=/admin&page=/UserManagementData.do", "", 22, "left", "User Management", 0);
	menus[1].addItem("switch.do?prefix=/admin&page=/rws_change_password_frm.jsp", "", 22, "left", "Change Password", 0);
	menus[1].addItem("switch.do?prefix=/masters&page=/UserAudit.do&mode=data2", "", 22, "left", "User Audit", 0);
	menus[1].addItem("./works/rws_works_mpr_frm.jsp", "", 22, "left", "Scheme MPR Generation", 0);	
	menus[1].addItem("/pred/reports/rws_udate_count_frm.jsp", "", 30, "left", "Data Entry Statistics", 0);
	menus[1].addItem("#", "", 22, "left", "General Admin", 0);
	menus[1].addItem("./admin/rws_pwd_search_frm.jsp", "", 22, "left", "Password Search Form", 0);	
	menus[1].addItem("./admin/rws_ee_budget_page.jsp", "", 22, "left", "EE Budget Page", 0);	
	menus[1].addItem("./admin/rws_ENC_budget_page.jsp", "", 22, "left", "ENC Page", 0);	
	menus[1].addItem("./admin/rws_HO_budget_page.jsp", "", 22, "left", "RWS HO Page", 0);	
	
	menus[1].addItem("switch.do?prefix=/admin&page=/myfreez.do&mode=display", "", 22, "left", "HabFreezUnfreez", 0);
    
	
	//menus[1].addItem("switch.do?prefix=/admin&page=/MonPhyFin.do&mode=init", "", 22, "left", "Monthly physical financial Status", 0);
	
	 
    // to open a new window menus[1].addItem("#", "NEWWIN", 22, "left", "Example", 0);

	//Sub Menus for 2rd Main Menu Item ("Masters"):
	menus[2] = new menu(210, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
 
	menus[2].addItem("#", "", 22, "left", "General", 3);
    menus[2].addItem("switch.do?prefix=/masters&page=/Panchayat.do", "", 22, "left", "Panchayat Entry", 0);
    menus[2].addItem("switch.do?prefix=/masters&page=/Village.do", "", 22, "left", "Village Entry", 0);
    menus[2].addItem("switch.do?prefix=/masters&page=/Habitation.do", "", 22, "left", "Habitation Entry", 0);
    menus[2].addItem("switch.do?prefix=/masters&page=/ContaminationDetails.do", "", 32, "left", "Quality Effected Habs Entry", 0);
    menus[2].addItem("#", "", 22, "left", "Habitation", 4);
    menus[2].addItem("switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data1", "", 22, "left", "Census Village Mapping", 0);
	menus[2].addItem("#", "", 22, "left", "Asset", 5);
    menus[2].addItem("#", "", 22, "left", "Source", 6);
    menus[2].addItem("#", "", 22, "left", "Programme", 7);
    menus[2].addItem("#", "", 22, "left", "Offices", 8);  
    menus[2].addItem("#", "", 22, "left", "Employee Details", 9);
	menus[2].addItem("#", "", 22, "left", "Head Of Accounts", 10);
	menus[2].addItem("#", "", 22, "left", "Contractor", 58);
    menus[2].addItem("#", "", 22, "left", "Water Quality", 11);
    menus[2].addItem("#", "", 22, "left", "Schools", 49);
    menus[2].addItem("switch.do?prefix=/masters&page=/workCategory.do&mode=data", "", 22, "left", "Program Linkage", 0);
    menus[2].addItem("#", "", 22, "left", "Bank", 65);
	menus[2].addItem("#", "", 22, "left", "Drought", 73);

		

			//  "General":
				menus[3] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[3].addItem("switch.do?prefix=/masters&page=/PublicRep.do&mode=data", "", 22, "left", "Public Representatives", 0);
				menus[3].addItem("switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data", "", 22, "left", "Mandal Subdivision", 0);
				menus[3].addItem("switch.do?prefix=/masters&page=/Tslimit.do&mode=data", "", 22, "left", "Technical Sanction Monetary Limit", 0);
				//Added on 03/01/2012 for mandal sub division conversion and moving assets and works
				menus[3].addItem("switch.do?prefix=/masters&page=/MandalSubdivisionCon.do?mode=data", "", 22, "left", "Mandal Subdivision Conversion", 0);
                //menus[3].addItem("switch.do?prefix=/masters&page=/MandalSubdivisionCon.do?mode=msName", "", 22, "left", " Subdivision Name Change", 0);

			//////////////////
    
			//  "Habitation":
				menus[4] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[4].addItem("switch.do?prefix=/masters&page=/PanchRaj.do&mode=data", "", 22, "left", "PanchayatRaj Habitations", 0);
				menus[4].addItem("switch.do?prefix=/masters&page=/Institute.do&mode=data", "", 22, "left", "Public Institutions", 0);
				menus[4].addItem("switch.do?prefix=/masters&page=/Priority.do&mode=data", "", 22, "left", "Priorities", 0);
				menus[4].addItem("masters/switch.do?prefix=/masters&page=/HabData.do", "", 22, "left", "Habitation Status", 0);
				menus[4].addItem("masters/switch.do?prefix=/masters&page=/HabConvert.do", "", 22, "left", "Habitation Convertion", 0);
				menus[4].addItem("masters/rws_Hab_SC_St_details_frm.jsp", "", 22, "left", "Habitation SC/ST/Minority Status", 0);				

			//////////////////

             //  "Asset":
				menus[5] = new menu(240, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetType.do&mode=data", "", 22, "left", "Asset Type", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetCompType.do&mode=data", "", 22, "left", "Asset Component", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/AssetSubCompType.do&mode=data", "", 22, "left", "Asset SubComponent", 0);
				
				//menus[5].addItem("switch.do?prefix=/masters&page=/AssetSubCompParam.do&mode=data", "", 22, "left", "Sub Component Parameters", 0);
				menus[5].addItem("switch.do?prefix=/masters&page=/Asset.do&mode=init", "", 22, "left", "Asset Master", 0);
			//////////////////
            
			 //  "Source":
				menus[6] = new menu(180, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[6].addItem("switch.do?prefix=/masters&page=/SourceType.do&mode=data", "", 22, "left", "Source Type", 0);
				menus[6].addItem("switch.do?prefix=/masters&page=/SubSourceType.do&mode=data", "", 22, "left", "Sub Source Type", 0);
				//menus[6].addItem("switch.do?prefix=/masters&page=/Source.do&mode=data", "", 22, "left", "Source Master", 0);
			//////////////////
			// "Programme":
				menus[7] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[7].addItem("switch.do?prefix=/masters&page=/Programme.do&mode=data", "", 22, "left", "Programme", 0);
				menus[7].addItem("switch.do?prefix=/masters&page=/SubProgramme.do&mode=data", "", 22, "left", "Sub Programme", 0);
			//////////////////
			//  "Offices":
				menus[8] = new menu(170, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[8].addItem("switch.do?prefix=/masters&page=/Head.do&mode=data", "", 22, "left", "Head Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Circle.do&mode=data", "", 22, "left", "Circle Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Division.do&mode=data", "", 22, "left", "Division Office", 0);
			    menus[8].addItem("switch.do?prefix=/masters&page=/SubDivision.do&mode=data", "", 22, "left", "Subdivision Office", 0);
				menus[8].addItem("switch.do?prefix=/masters&page=/Office.do&mode=data", "", 22, "left", "Rws Office Details", 0);
			    menus[8].addItem("switch.do?prefix=/masters&page=/Hoffice.do&mode=data", "", 22, "left", "Head Of Office", 0);
			//////////////////
			//  "Employee Details":
				menus[9] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[9].addItem("switch.do?prefix=/masters&page=/Qual.do&mode=data", "", 22, "left", "Qualification", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/Desgn.do&mode=data", "", 22, "left", "Designation", 0);
				menus[9].addItem("switch.do?prefix=/masters&page=/WorkSpecial.do&mode=data", "", 22, "left", "Work Specialization", 0);
			    menus[9].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=data", "", 22, "left", "Employee Master", 0);
			    menus[9].addItem("switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList&mode1=init", "", 22, "left", "Employee Search Form", 0);
				//newly added as Employees Report 
				
			//////////////////
			//  "Head Of Accounts":
				menus[10] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 2, 2, "#cccccc");
				menus[10].addItem("#", "", 18, "left", "Head Of Accounts", 47);
				menus[10].addItem("switch.do?prefix=/masters&page=/PaoAction.do&mode=data", "", 18, "left", "PAO Entry Form", 0);
           //////////////////
		   // "water Quality":
				menus[11] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterTest.do&mode=data", "", 22, "left", "Test Master", 0);
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterPTest.do&mode=data", "", 22, "left", "Parameter Master", 0);
				menus[11].addItem("switch.do?prefix=/masters&page=/WaterLab.do&mode=data", "", 22, "left", "Lab Master", 0);
			    menus[11].addItem("switch.do?prefix=/masters&page=/Contam.do&mode=data", "", 22, "left", "Contamination Master", 0);
		    //////////////////

	//Sub Menus for 3rd Main Menu Item ("workflow"):
	menus[12] = new menu(235, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
 
//	menus[12].addItem("#", "", 22, "left", "Proposals", 13);
   // menus[12].addItem("#", "", 22, "left", "Estimates", 14);
	
  //  menus[12].addItem("#", "", 22, "left", "Contractor Management", 16);
    menus[12].addItem("#", "", 22, "left", "Works Monitoring", 36);
    //menus[12].addItem("#", "", 22, "left", "Complaints Monitoring", 0);  //60
    menus[12].addItem("#", "", 22, "left", "Fund Accounting", 40);
	menus[12].addItem("#", "", 22, "left", "Water Quality Management", 15);
	menus[12].addItem("#", "", 22, "left", "Drought Monitoring", 71);
	
    //menus[12].addItem("#", "", 22, "left", "Fund Accounting", 0);
	//following line is commented to hide broken link stock management
	//menus[12].addItem("#", "", 22, "left", "Stock Management", 0);
	          
			   // "Proposals":
				menus[13] = new menu(140, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[13].addItem("#", "", 22, "left", "New Works", 29);
				menus[13].addItem("#", "", 22, "left", "O&M Works", 30);
			   //////////////////
			     // "Estimates":
				menus[14] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[14].addItem("#", "", 22, "left", "New Estimates", 31);
				//following line is commented to hide O&M Esitmates
				//menus[14].addItem("#", "", 22, "left", "O&M Estimates", 32);
			   //////////////////
			      // "Water Quality Management":
				//menus[15] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				//menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSample.do&mode=data", "", 22, "left", "Sample Collection", 0);
				//menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=data", "", 22, "left", "Quality Tests", 0);
				//menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data", "", 22, "left", "Sample Status", 0);
				  //menus[15].addItem("#", "", 22, "left", "Source Identification & Finalization", 0);
				 //menus[15].addItem("#", "", 22, "left", "Drilling Status", 0);
				//menus[15].addItem("switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=data", "", 22, "left", "Source Identification & Finalization", 0);
			   //menus[15].addItem("switch.do?prefix=/wquality&page=/DrillStatus.do&mode=data", "", 22, "left", "Drilling Status", 0);
		      
		      menus[15] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSample.do&mode=data", "", 22, "left", "Sample Collection Lab/FTK", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=data", "", 22, "left", "Quality Tests", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleFtkTest.do&mode=data", "", 22, "left", "FTK Sample Status", 0);
				menus[15].addItem("switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data", "", 22, "left", "Lab Sample Status", 0);
		       //////////////////
			   // "Contractor Management":
				menus[16] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
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
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
 
	menus[17].addItem("./reports/rws_coverage_graph_form.jsp", "", 22, "left", "Habitation Status", 0);
    menus[17].addItem("./reports/rws_graph_frm.jsp", "", 22, "left", "BoreWell Status", 0);
    menus[17].addItem("./reports/rws_graph_frm.jsp", "", 22, "left", "Assets", 42);
	menus[17].addItem("./reports/rws_graph_frm1.jsp", "", 22, "left", "FC-Proposed Year", 0);
    menus[17].addItem("./reports/rws_graph_frm2.jsp", "", 22, "left", "FC-Proposed Est.Cost", 0);
  //  menus[17].addItem("#", "", 22, "left", "Proposal", 18);
    
    
                
	// "Proposal":
	menus[18] = new menu(210, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[18].addItem("#", "", 22, "left", "Representative", 33);
	menus[18].addItem("#", "", 22, "left", "Work Proposal", 34);
	menus[18].addItem("#", "", 22, "left", "Comparative Statement", 35);

	//Sub Menus for 4rd Main Menu Item ("Reports"):
  	menus[19] = new menu(200, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	//menus[19].addItem("/pred/reports/rws_hab_status_forms.jsp", "", 40, "left", "Habitation Status CheckList", 0);
	menus[19].addItem("#", "", 22, "left", "Master Reports", 20);
    //menus[19].addItem("#", "", 22, "left", "New Proposals", 21);
	//menus[19].addItem("#", "", 22, "left", "O&M Proposals", 22);
    //menus[19].addItem("#", "", 22, "left", "Pendency Status", 23);
//	menus[19].addItem("#", "", 22, "left", "Estimates", 25);
	menus[19].addItem("#", "", 22, "left", "Contractor Mgmt", 62);
	menus[19].addItem("#", "", 22, "left", "Works Monitoring", 37);
    menus[19].addItem("#", "", 22, "left", "Water Quality", 24);
	menus[19].addItem("#", "", 22, "left", "Fund Accounting", 41);
	menus[19].addItem("#", "", 22, "left", "Drought Reports ", 72);
	menus[19].addItem("#", "", 22, "left", "DDWS Reports ", 53);
	//menus[19].addItem("#", "", 22, "left", "Bank Process", 67);
	 
                
	// "Master Reports":
	menus[20] = new menu(200, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[20].addItem("#", "", 22, "left", "Habitation", 26);
	//menus[20].addItem("#", "", 32, "left", "Employee CheckList", 41);
	menus[20].addItem("#", "", 22, "left", "Employee", 44);
	menus[20].addItem("#", "", 22, "left", "Asset", 27);
	menus[20].addItem("#", "", 22, "left", "Schools", 50);	
	menus[20].addItem("#", "", 22, "left", "Bank", 66);			
			    //////////////////

	 // "Habitation":
	//menus[26] = new menu(180, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 0, 0, "#cccccc");
	menus[26] = new menu(315, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[26].addItem("switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi", "", 18, "left", "Free Format Report", 0);
	menus[26].addItem("/pred/reports/rws_hab_status_forms.jsp", "", 18, "left", "CheckList Report", 0);
	menus[26].addItem("./reports/rws_coverage_status_frm1.jsp", "", 18, "left", "Coverage Status Directory Format-I", 0);
	menus[26].addItem("switch.do?prefix=/reports&page=/reportsDisplay.do&mode=data", "", 18, "left", "Coverage Status Directory Format-II" , 0);
	menus[26].addItem("./reports/rws_hab_status_resource_rpt.jsp", "", 18, "left", "Resources At a Glance", 0);
	menus[26].addItem("./reports/rws_const_coverage_status_frm.jsp", "", 18, "left", "Constituency Status", 0);
	menus[26].addItem("#", "", 18, "left", "Abstract Reports", 52);
	menus[26].addItem("#", "", 18, "left", "Population Reports",43);
	menus[26].addItem("#", "", 18, "left", "Planning Reports",54);
	menus[26].addItem("#", "", 18, "left", "Misc Reports", 46);
	menus[26].addItem("#", "", 18, "left", "Analysis Reports",61);
	menus[26].addItem("./reports/rws_HabPop_rpt.jsp", "", 18, "left", "Hab LPCD Population Report",0);
	menus[26].addItem("./reports/rws_habitation_Progresses_rpt.jsp", "", 18, "left", "Habitation progress Report",0);
	menus[26].addItem("./reports/rws_district_wise_gps_frm.jsp", "", 18, "left", "Gram panchayat Asset Coverage",0);
	menus[26].addItem("./reports/rws_district_wise_gps_status_frm.jsp", "", 18, "left", "Gram panchayat Coverage Status", 0);
	
	
   //////////////////

	 // "Asset":
	menus[27] = new menu(325, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[27].addItem("./reports/rws_asset_cpws_rpt.jsp", "", 18, "left", "Details Report", 0);
	menus[27].addItem("./reports/rws_asset_cpws_rpt1.jsp", "", 18, "left", "Checklist Report", 0);
	menus[27].addItem("switch.do?prefix=/reports&page=/CheckList.do?mode=data", "", 18, "left", "Components Abstract Drilldown", 0);
	menus[27].addItem("switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data", "", 18, "left", "Asset Free Format Report", 0);
	menus[27].addItem("./reports/rws_hab_asset_status_no_frm.jsp", "", 18, "left", "Sources in Habitation", 0);
	menus[27].addItem("#", "", 18, "left", "Abstract Reports", 55);
	menus[27].addItem("./reports/arws_assetcount_frm.jsp", "", 18, "left", "Schemes-Habs Benefitted", 0);
	menus[27].addItem("./reports/rws_hp_frm.jsp", "", 18, "left", "Handpumps Without Borwells", 0);
	menus[27].addItem("./reports/arws_schemes_frm.jsp", "", 18, "left", "Schemes Without Sources/Reservoirs", 0);
	menus[27].addItem("./reports/rws_source_hab_asset_frm.jsp", "", 18, "left", "Source - Assets Coverage ", 0);
	menus[27].addItem("./reports/rws_cpws_pws_cov_ass_frm.jsp", "", 18, "left", "Assets Priority Report", 0);
	menus[27].addItem("./reports/rws_asurfaceohsr_frm.jsp","", 22, "left", "GIS Information Reports", 0);
	menus[27].addItem("./reports/rws_Scheme_Pop_frm.jsp", "", 18, "left", "SchemesWise Habs&Population Details",0);
	//	menus[27].addItem("./reports/rws_district_rpt.jsp", "", 22, "left", "BoreWell Status", 0);

	//the following line is commented to remove it as the tables used in the report were changed and the same type of report is present is checklist report(asset).
	//menus[27].addItem("./reports/arws_asset_new_subcomp_frm.jsp", "", 22, "left", "Asset Sub Components", 0);
					

		//////////////////

	// "New Proposals":
	menus[21] = new menu(160, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[21].addItem("./reports/rws_rep_proposal_frm.jsp", "", 22, "left", "Representative", 0);
	menus[21].addItem("./reports/rws_work_propo_det_frm.jsp", "", 22, "left", "Work Proposal", 0);
	menus[21].addItem("switch.do?prefix=/proposals&page=/NewProposalTrackingData.do", "", 22, "left", "Proposal History", 0);
   //////////////////
	 // "O&M Proposals":
	menus[22] = new menu(200, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[22].addItem("./reports/rws_om_proposal_det_frm.jsp", "", 22, "left", "O&M Proposals", 0);
	menus[22].addItem("switch.do?prefix=/proposals&page=/OMProposalTrackingData.do", "", 22, "left", "Proposal History", 0);
   //////////////////
	 // "Pendency Status":
	menus[23] = new menu(200, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[23].addItem("./reports/rws_proposal_pendency_rep_frm.jsp", "", 22, "left", "Representative Wise", 0);
	menus[23].addItem("./reports/rws_proposal_pendency_consti_frm.jsp", "", 22, "left", "Constituency Wise", 0);
   //////////////////
	 // "Water Quality":
	menus[24] = new menu(320, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[24].addItem("./reports/rws_lab_test_frm.jsp", "", 22, "left", "Test Results", 0);
	 // code added  by sridhar
	 menus[24].addItem("./reports/rws_ftk_test_result_frm.jsp", "", 22, "left", "Ftk Test Results", 0); 
	 menus[24].addItem("./reports/rws_wq_sam_res_loc_frm.jsp", "", 22, "left", "Water Quality Statuts Report/District", 0); 
	 menus[24].addItem("./reports/rws_water_sample_abstract_frm.jsp", "", 22, "left", "Water Quality Entry Status", 0); 
	 menus[24].addItem("./reports/rws_water_nsshabs_frm_rpt.jsp", "", 22, "left", "Habitaion Vs Water Quality", 0); 
	 menus[24].addItem("./reports/rws_water_parameters_frm.jsp", "", 22, "left", "Water Quality Data Format", 0); 
	 menus[24].addItem("./reports/rws_Wq_Lab_rpt.jsp", "", 18, "left", "Water Quality Lab Tests  Report",0);
	 
   
   //////////////////
	 // "Estimates":
	menus[25] = new menu(200, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[25].addItem("./reports/rws_con_wise_est_cost_frm.jsp", "", 22, "left", "Constituency Wise", 0);
		      ///////////////////

	
	//Sub Menus for Main Menu Item ("Help"):
	menus[28] = new menu(220, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
 
	menus[28].addItem("#", "", 22, "left", "Online Help", 38);
	menus[28].addItem("FontDownloadHelp.html", "", 22, "left", "Rupee Font Download", 0);
    menus[28].addItem("./help/Data Input Sheets Layout.doc", "", 22, "left", "Data Input Sheets", 0);
	menus[28].addItem("./masters/goForm.jsp", "", 22, "left", "GO'S", 0);
    menus[28].addItem("./masters/leForm.jsp?mode=data", "", 22, "left", "Estimates", 0);
    menus[28].addItem("./help/SSR 2005-2006.doc", "", 22, "left", "SSR 2005-2006", 0);
    menus[28].addItem("ScreenshotHelp.html", "", 22, "left", "Screen Shot Help", 0);
	menus[28].addItem("#", "", 22, "left", "Rate Contact", 0);
menus[28].addItem("./help/drought.doc", "", 22, "left", "Drought", 0);


	//Sub menu items of work flow proposals-new work flow
   // "New Work Proposals":
	menus[29] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
	menus[29].addItem("switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=init", "", 22, "left", "Representation", 0);
	menus[29].addItem("switch.do?prefix=/proposals&page=/NewProposalData.do", "", 22, "left", "Manage Proposal", 0);
	menus[29].addItem("switch.do?prefix=/proposals&page=/NewAdminProposalData.do", "", 22, "left", "Administrative Sanction", 0);
	menus[29].addItem("switch.do?prefix=/proposals&page=/ListNewProposals.do", "", 22, "left", "List Proposals", 0);
   // "O&M Work Proposals":
		menus[30] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
		menus[30].addItem("switch.do?prefix=/proposals&page=/OMProposalData.do", "", 22, "left", "Proposal", 0);
		menus[30].addItem("switch.do?prefix=/proposals&page=/OMAdminProposalData.do", "", 22, "left", "Administrative Sanction", 0);
		menus[30].addItem("switch.do?prefix=/proposals&page=/ListOMProposals.do", "", 22, "left", "List Proposals", 0);		 
  // "Estimates-NEW ESTIMATES":
		//menus[31] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
		menus[31]=new menu(240, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[31].addItem("switch.do?prefix=/estimates&page=/NewEstimateData.do", "", 22, "left", "Preparation", 0);
		menus[31].addItem("switch.do?prefix=/estimates&page=/NewEstSanctionData.do", "", 22, "left", "Technical Sanction", 0);
		menus[31].addItem("switch.do?prefix=/estimates&page=/TsMileStone.do&mode=data", "", 22, "left", "Techinical Sanction Provisions ", 0);
  // "ESTIMATES 0&M ESTMATES":
		menus[32] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
		menus[32].addItem("switch.do?prefix=/estimates&page=/OMEstimateData.do", "", 22, "left", "Preparation", 0);
		menus[32].addItem("switch.do?prefix=/estimates&page=/OMEstSanctionData.do", "", 22, "left", "Technical Sanction", 0);
////su menu items of WORKFLOW-PROPOSAL
	   // "Representaive wise":
		menus[33] = new menu(140, "vertical", 0, 0, 0, 0, "#cccccc", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white",15, "#E1E1E1", 2, 62, false, true, false, false, 0, true, 0, 0, "#cccccc");
		menus[33].addItem("./reports/rws_circle_rep_proposal_graph_frm.jsp", "", 22, "left", "Office Wise", 0);
		menus[33].addItem("./reports/rws_scheme_rep_proposal_graph_frm.jsp", "", 22, "left", "SchemeWise", 0);
		menus[33].addItem("./reports/rws_repre_proposal_graph_frm.jsp", "", 22, "left", "Representaive Wise", 0);
	   
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

	   // "Works Monitoring":
		menus[36] = new menu(360, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[36].addItem("switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=null", "", 22, "left", "Administrative Sanction", 0);
		menus[36].addItem("switch.do?prefix=/proposals&page=/RevisedSanction.do&initial=true", "", 30, "left", "Revised Administrative Sanction", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/WorkStatus.do&mode=circles", "", 22, "left", "Work Progress", 0);
	//	menus[36].addItem("/pred/works/ProgressReportOBEntry.do?mode=openingBalanceFrm", "", 22, "left", "Opening Balance Entry Form", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/worksDelete.do&mode=data", "", 22, "left", "Works Deletion", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/Auglinkmain.do?mode=data1&mode1=circles", "", 22, "left", "Update Action Plan", 0); 
		menus[36].addItem("switch.do?prefix=/works&page=/Auglinkmain.do?mode=data", "", 22, "left", "Augmentation-MainScheme Linkage", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/SchemeAsset.do&mode=circles", "", 22, "left", "Scheme-Asset Integration", 0);				
		menus[36].addItem("switch.do?prefix=/works&page=/eoatFrm.do?mode=init", "", 22, "left", "Extension Of Agreement Time", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/worklocality.do&mode=data", "", 22, "left", "Works Locality from", 0);
		menus[36].addItem("switch.do?prefix=/works&page=/aap.do&mode=data&mode1=circles", "", 22, "left", "Annual Action Plan", 0);

		//menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenPhysicalProgressAction.do", "", 22, "left", "Physical Progress", 0);
		//menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenFinancialProgressAction.do", "", 22, "left", "Financial Progress", 0);
		//menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenFinancialProgressActiont.do", "", 22, "left", "EOAT", 0);
		//menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/GenWorksMonitoringAction.do", "", 22, "left", "Works Monitoring", 0);
	   // menus[36].addItem("switch.do?prefix=/worksMonitoring&page=/workStatus.do", "", 22, "left", "Work Status", 0);
			  
	   // "Works Monitoring Reports"
		menus[37] = new menu(380, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[37].addItem("switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi", "", 22, "left", "Free Format Report", 0);
		menus[37].addItem("#", "", 22, "left", "Abstract Reports", 51);
		menus[37].addItem("#", "", 22, "left", "Ongoing Works Reports", 56);
		menus[37].addItem("#", "", 22, "left", "Project Shelf", 63);
		menus[37].addItem("#", "", 22, "left", "Checklist", 39);      
		menus[37].addItem("#", "", 22, "left", "Detailed Reports", 64);
		//menus[37].addItem("./reports/rws_mnth_frm.jsp", "", 22, "left", "Monthly Progress Report", 0); 				
		menus[37].addItem("./reports/rws_spill_ncnsspc1habs_covered_10_11.jsp", "", 22, "left", "Coverage of Habs Under SpillOver Works", 0);           				
		menus[37].addItem("./reports/rws_districtwise_statuswise_work_rpt.jsp", "", 22, "left", " NRDWP-COV Works Abstract", 0);
	    menus[37].addItem("./reports/rws_work_admn_tech_frm.jsp", "", 22, "left", "Difference In Admn and Tech Habs", 0);
        menus[37].addItem("./reports/rws_work_pendency_frm.jsp", "", 22, "left", "Work Pendency  Status Report", 0);	
		menus[37].addItem("switch.do?prefix=/works&page=/workgap.do?mode=data", "", 22, "left", "Gap Report", 0);
		menus[37].addItem("./reports/rws_work_exp_frm.jsp", "", 22, "left", "Payment Status Report ", 0);
		menus[37].addItem("./reports/rws_work_vouchers_frm.jsp", "", 22, "left", "Voucher Payment Status Report ", 0);
		menus[37].addItem("./reports/rws_workid_search_frm.jsp", "", 22, "left", "Work ID Based -Work Details", 0);
		menus[37].addItem("./reports/rws_Pending_works_rpt.jsp", "", 22, "left", "Pending WorksMonitoring Report", 0);
		menus[37].addItem("./reports/rws_work_probdate_frm.jsp", "", 22, "left", "Works - Probable Completion date", 0);
		menus[37].addItem("./reports/rws_Canceled_works_rpt.jsp", "", 22, "left", "Canceled Works", 0);  
		menus[37].addItem("./reports/rws_PhyCom_FinNotCom_frm.jsp", "", 22, "left", "Physically Completed Financially notcompleted Works Details", 0);  
		
		
		 // "HELP DOCUMENTS"
		menus[38] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[38].addItem("./help/assethelp.doc", "", 22, "left", "Asset", 0);      
		menus[38].addItem("./help/HabitationStatushelp.doc", "", 22, "left", "Habitation Status", 0);      
		menus[38].addItem("./help/WorkFlow.doc", "", 22, "left", "Works Monitoring", 0); 
		menus[38].addItem("./help/FundAccounting.doc", "", 22, "left", "Fund Accounting", 0); 
		menus[38].addItem("./help/CommissionedworkAsset.doc", "", 22, "left", "Asset Scheme Integration", 0);           
		menus[38].addItem("./help/panchayat.doc", "", 22, "left", "Panchayat", 0);      
		menus[38].addItem("./help/village.doc", "", 22, "left", "Village", 0);      
		menus[38].addItem("./help/Hab.doc", "", 22, "left", "Habitation", 0); 
		menus[38].addItem("./help/QualityEffectedHabs.doc", "", 22, "left", "Quality Effected Habs", 0); 
		
		menus[38].addItem("./help/WaterQuality.doc", "", 22, "left", "Water Quality", 0); 
		menus[38].addItem("./help/Help For PRED.htm", "", 22, "left", "Complete Online Help", 0); 
		menus[38].addItem("./help/School.doc", "", 22, "left", "School Form", 0);          
		
		//works-monitoring checklist reports
		menus[39] = new menu(280, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[39].addItem("./reports/rws_admn_status_form.jsp", "", 18, "left", "Admin Sanction", 0);      
		menus[39].addItem("./reports/rws_tech_status_form.jsp", "", 18, "left", "Technical Sanction", 0);   
		menus[39].addItem("./reports/rws_contractor_frm.jsp", "", 18, "left", "Contractor Management", 0);         
		menus[39].addItem("./reports/rws_program_sched_frm.jsp", "", 18, "left", "Program Schedule", 0);         
		menus[39].addItem("./reports/rws_work_expenditure_frm.jsp", "", 18, "left", "Work Expenditure", 0);     
		menus[39].addItem("./reports/rws_work_completion_frm.jsp", "", 18, "left", "Work Completion", 0); 
		menus[39].addItem("./reports/rws_integrated_rpt.jsp", "", 18, "left", "Integrated Work Checklist ", 0);                         
		menus[39].addItem("./reports/rws_works_ALL_integrated_rpt.jsp", "", 18, "left", "All Works Integrated Checklist", 0);                         
		
		
		//Fund Accounting  Menu
		menus[40] = new menu(240, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[40].addItem("switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=data", "", 22, "left", "BRO Details", 0);      
		menus[40].addItem("switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=data", "", 22, "left", "LOC Details", 0);      
		menus[40].addItem("./fundAccounting/rws_op_cl_bal_frm.jsp", "", 18, "left", "Opening Balance", 0);                         
	//	menus[40].addItem("switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getBroList_frm", "", 22, "left", "List BRO", 0);      
		menus[40].addItem("./works/rws_work_bill_frm.jsp", "", 22, "left", "Bills", 0);
		menus[40].addItem("#", "", 22, "left", "Voucher Payments", 57);
		//menus[40].addItem("#", "", 22, "left", "Banking Process", 0);
		//menus[40].addItem("#", "", 22, "left", "PAO Process", 0);
//		menus[40].addItem("./fundAccounting/rws_push_bills_frm.jsp", "", 22, "left", "Push Bills", 0);
		
		//Reports Fund Accounting Menu
		menus[41] = new menu(260, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
//		menus[41].addItem("switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureWorkWise.do&mode=init", "", 18, "left", "Releases Vs Expenditure", 0);      
	//	menus[41].addItem("switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureSchemeWiseBetweenDates.do&mode=betweenDates", "", 18, "left", "Scheme Wise Releases Vs Expenditure", 0);      
		//menus[41].addItem("switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=init", "", 18, "left", "Programme Wise Releases Vs Expenditure", 0);      
		//menus[41].addItem("switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=ProgWiseDrillFrm", "", 18, "left", "Programme Wise Rpt2 Releases Vs Expenditure", 0);
		menus[41].addItem("./reports/rws_bro_release_frm.jsp", "", 22, "left", " BRO  Releases", 0);
		menus[41].addItem("switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getBroList_frm", "", 22, "left", "List BRO", 0);  
		menus[41].addItem("./reports/rws_payment_details_frm.jsp", "", 22, "left", "Payment Details Report ", 0);
		menus[41].addItem("#", "", 22, "left", "Financial Status Reports", 59);
		menus[41].addItem("./reports/rws_bill_history_frm.jsp", "", 22, "left", "Bill History Report ", 0);
		menus[41].addItem("./reports/rws_Recipents_Paymnets_frm.jsp", "", 22, "left", "Receipts Vs Payments ", 0);
		menus[41].addItem("./reports/rws_progwise_exp_rpt.jsp", "", 22, "left", "Expenditure Details Report", 0);
		menus[41].addItem("#", "", 22, "left", "Bank Process", 67);
		menus[41].addItem("./reports/rws_billvoucher_division_frm.jsp", "", 22, "left", "Bill-Voucher Details ", 0);
		menus[41].addItem("#", "", 22, "left", "Releases Analysis Reports",70);
		
		//menus[42].addItem("./reports/rws_billvoucher_division_frm.jsp", "", 22, "left", "Division Wise Bill-Voucher Details ", 0);
		
		//Asset Graph Reports
		menus[42] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[42].addItem("./reports/assetReports/rws_graph_frm1.jsp", "", 32, "left", "Asset Types", 0);      
		
		menus[43] = new menu(155, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[43].addItem("./reports/rws_dist_pop_frm.jsp", "", 22, "left", "Population Range", 0);  
		menus[43].addItem("./reports/rws_dist_pop_frm1.jsp", "",22, "left", "Status Wise", 0); 
		menus[43].addItem("./reports/rws_dist_pop_frm2.jsp", "",22, "left", "Category Wise", 0); 
				menus[43].addItem("./reports/rws_dist_pop_cons.jsp", "",22, "left", "Constituency Wise", 0); 
		
		
		menus[44] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[44].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=checklist", "",22, "left","Check List", 0);
		menus[44].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=StatusForms", "",22, "left","Status Forms", 0);
		menus[44].addItem("switch.do?prefix=/masters&page=/Employee.do&mode=DeptOptForms", "",22, "left","Department Opted ", 0);
		menus[44].addItem("switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList", "",22, "left","Employee Search ", 0);			
	 	menus[44].addItem("./reports/rws_employee_work_frm.jsp", "",22, "left","Employee Work Details ", 0);			
	 
	 menus[45] = new menu(200, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 1, 1, "#cccccc");
	 menus[45].addItem("switch.do?prefix=/reports&page=/offlinePatches.do", "",22, "left","Offline Patches", 0);
	 menus[45].addItem("./reports/rws_download_newfrm.jsp", "",22, "left","Data Download", 0);
	 
	 
	  //added by jyothi for gis data report display

	//menus[45].addItem("switch.do?prefix=/reports&page=/ListTables.do", "",22, "left","Tables Data Download", 0);
	 menus[45].addItem("switch.do?prefix=/reports&page=/GisTables.do", "",22, "left","GIS Tables Data", 0);
	
	 //end of gis data report display
	 
	menus[46] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");			
	menus[46].addItem("switch.do?prefix=/reports&page=/duplicates.do&mode=data", "", 22, "left", "Duplicates List", 0);
	menus[46].addItem("switch.do?prefix=/reports&page=/unidentified.do&mode=data", "", 22, "left", "UnIdentified Habitations", 0);
	menus[46].addItem("./reports/rws_hab_updates_frm.jsp", "", 18, "left", "Month Wise Updations", 0);
	menus[46].addItem("./reports/rws_hab_status_form.jsp", "", 18, "left", "Location Status", 0);
	menus[46].addItem("./reports/rws_goi_coverage_frm.jsp", "", 18, "left", "District Wise - GOI", 0);
	menus[46].addItem("switch.do?prefix=/reports&page=/PublicInst.do?mode=data", "", 18, "left", "Public Institutes", 0);
	menus[46].addItem("./reports/rws_slip_back_rpt.jsp", "", 18, "left", "Slipped Back Details", 0);
	menus[46].addItem("./reports/rws_pop_cat_detailed_rpt.jsp", "", 18, "left", "Population Category", 0);
	menus[46].addItem("./reports/rws_new_zero_pop_hab_rpt.jsp", "", 18, "left", "New/ Zero Population Habs", 0);
	 
	 
	menus[47] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[47].addItem("switch.do?prefix=/masters&page=/MajorHead.do&mode=data", "", 22, "left", "Major Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/SubMajorHead.do&mode=data", "", 22, "left", "Sub Major Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/MinorHead.do&mode=data", "", 22, "left", "Minor Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/GrpSubHead.do&mode=data", "", 22, "left", "Group Sub Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/SubHead.do&mode=data", "", 22, "left", "Sub Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/DetailHead.do&mode=data", "", 22, "left", "Detail Head", 0);
	menus[47].addItem("switch.do?prefix=/masters&page=/SubDetailHead.do&mode=data", "", 22, "left", "Sub Detail Head", 0);

	//fund accounting

	menus[48] = new menu(150, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[48].addItem("./reports/rws_pao_form.jsp", "", 22, "left", "PAO Details" , 0);
	menus[48].addItem("./reports/rws_head_of_acc_form.jsp", "", 22, "left", "Heads Details" , 0);				

	menus[49] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, 62, false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[49].addItem("switch.do?prefix=/masters&page=/school.do&mode=data", "", 22, "left", "School Form", 0);

	menus[50] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[50].addItem("switch.do?prefix=/masters&page=/schoolrep.do&mode=data", "", 22, "left", "Detailed Report", 0);
	menus[50].addItem("./reports/rws_school_abstract_rpt.jsp", "", 22, "left", "Abstract Report", 0);
	menus[50].addItem("./reports/rws_school_asset_rpt.jsp", "", 22, "left", "Asset/work Linkage Status", 0);
    menus[50].addItem("./reports/rws_school_detailed_rpt.jsp", "", 22, "left", "School & Anganwadies", 0);
	menus[50].addItem("./reports/rws_schools_abstract_frm.jsp", "", 22, "left", "School Coverage", 0);


	menus[51] = new menu(295, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");			
	menus[51].addItem("./reports/rws_work_general_abstract_rpt.jsp", "", 18, "left", "General Abstract", 0);      
	menus[51].addItem("./reports/rws_work_proj_abstract_rpt.jsp", "", 18, "left", "Project Works", 0);  
	menus[51].addItem("./reports/rws_work_normal_abstract_rpt.jsp", "", 18, "left", "Normal Works", 0);      
	menus[51].addItem("./reports/rws_work_dist_abstract_rpt.jsp", "", 18, "left", "District LevelWorks", 0);      
	menus[51].addItem("./reports/rws_work_program_abstract_rpt.jsp", "", 18, "left", "Programme Wise", 0);      
	menus[51].addItem("./reports/rws_works_frm.jsp", "", 22, "left", "Total Works Vs Habs ", 0);  
	menus[51].addItem("./reports/rws_work_valueofwork_notpaid_rpt.jsp?", "", 22, "left", "Value Of Work Done But Not Paid ", 0);           
	menus[51].addItem("./reports/rws_qa_habs_covered_31032010.jsp", "", 22, "left", "QA Habs Covered By 31.03.2010", 0);           
	//menus[51].addItem("./reports/rws_Aap_abstract_frm.jsp", "", 22, "left", "AAP 2011-12", 0);
	menus[51].addItem("./reports/rws_Aap_abstract_frm.jsp", "", 22, "left", "AAP Target 2011-12", 0);
	menus[51].addItem("./reports/rws_Aap_abstractAch_frm.jsp", "", 22, "left", "AAP Achievement 2011-12", 0);
	menus[51].addItem("./reports/rws_Aap_count_frm.jsp", "", 22, "left", "AAP Abstract List", 0);
	menus[51].addItem("./reports/rws_work_general_abstract_rpt_p.jsp", "", 18, "left", "Revised General Abstract Report", 0);  
	menus[51].addItem("./reports/rws_scheme_Details_frm.jsp", "", 18, "left", " Workwise Scheme Details Report ",0);

	menus[52] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");			
	menus[52].addItem("./reports/rws_habitation_abstract_rpt.jsp", "", 22, "left", "Status - Abstract Report", 0);
	menus[52].addItem("./reports/rws_habs_cov_schemes_rpt.jsp", "", 22, "left", "Covered by Schemes", 0);
	menus[52].addItem("./reports/rws_hab_cov_hps_rpt.jsp", "", 22, "left", "Covered by HPs", 0);
	menus[52].addItem("./reports/rws_asset_abstract_rpt.jsp", "", 22, "left", "Asset Abstract Report", 0);

	menus[53] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[53].addItem("./reports/rws_work_ddws_status_frm.jsp", "", 22, "left", "Project Shelf Reports ", 0);

	menus[54] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[54].addItem("./reports/rws_planning_format_frm.jsp", "", 18, "left", "Planning Report-I", 0);
	menus[54].addItem("./reports/rws_planning_format1_frm.jsp", "", 18, "left", "Planing-Format-II", 0);
	menus[54].addItem("./reports/rws_planning_format2_frm.jsp", "", 18, "left", "Planing-Format-III", 0);

	menus[55] = new menu(190, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[55].addItem("./reports/rws_AssetAbstract_report.jsp", "", 18, "left", "Abstract Report", 0);
	menus[55].addItem("./reports/rws_Hp_rpt.jsp", "", 18, "left", "HP Abstract", 0);
	menus[55].addItem("./reports/rws_Schemes_rpt.jsp", "", 18, "left", "Schemes Abstract", 0);
	menus[55].addItem("./reports/rws_asset_statement_rpt.jsp", "", 22, "left", "GOI Statement", 0);
	menus[55].addItem("./reports/rws_asset_wise_abstract_rpt.jsp", "", 22, "left", "Detailed Report", 0);	
	menus[55].addItem("./reports/rws_asset_priority_abstract_rpt.jsp", "", 22, "left", "Priority Based Report", 0);		
	
	menus[56] = new menu(250, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[56].addItem("./reports/rws_works_habtype_ongoing_rpt.jsp?", "", 22, "left", "SC/ST/PLAIN - Detailed", 0);      
	menus[56].addItem("./reports/rws_work_habsubtype_abstract_rpt.jsp?", "", 22, "left", "SC/ST/PLAIN - Abstract", 0);      
	menus[56].addItem("./reports/rws_ongoing_abstract.jsp", "", 22, "left", "Ongoing Works Abstract", 0);
	menus[56].addItem("./reports/rws_work_ongoing_frm.jsp", "", 22, "left", "Habitations Benefited Report", 0);

	menus[57] = new menu(320, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[57].addItem("./works/rws_work_exp_voucher_frm.jsp", "", 22, "left", "Direct Voucher Payments", 0);
	menus[57].addItem("./works/rws_work_voucher_frm.jsp", "", 22, "left", "Vouchers Payments For Bill", 0);

	menus[58] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	menus[58].addItem("switch.do?prefix=/masters&page=/Contractor.do&mode=data", "", 22, "left", "Contractor Entry", 0);
	menus[58].addItem("switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate", "", 22, "left", "Update Contractor", 0);
		
	menus[59] = new menu(220, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");		
	//menus[59].addItem("./reports/rws_bill_tobe_release_rpt.jsp", "", 22, "left", "Division Wise", 0);
	//menus[59].addItem("./reports/rws_bill_tobe_release_nrdwp_rpt.jsp", "", 22, "left", "NRDWP Related", 0);
	//menus[59].addItem("./reports/rws_biil_release_program_rpt.jsp", "", 22, "left", "Program Wise", 0);
	menus[59].addItem("./reports/rws_work_details_exp_frm.jsp", "", 22, "left", "Work Wise", 0);
    menus[59].addItem("./reports/rws_bill_tobe_release_mrpt.jsp", "", 22, "left", "Division Wise", 0);
	menus[59].addItem("./reports/rws_exp_voucher_prg_mrpt.jsp", "", 22, "left", "Programme Wise", 0);
	menus[59].addItem("./reports/rws_exp_voucher_nrdwpprg_mrpt.jsp", "", 22, "left", "NRDWP Related", 0);
	menus[59].addItem("./reports/rws_exp_voucher_tot_rpt.jsp", "", 22, "left", "Summarized Financial Report(All Years)", 0);
	
	
		
	 menus[60] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	 menus[60].addItem("switch.do?prefix=/complaints&page=/Complaints.do&mode=get2&special=reset", "", 22, "left", "Complaints Registration", 0);
	 menus[60].addItem("switch.do?prefix=/complaints&page=/Complaintstatus.do&mode=get2&special=reset", "", 22, "left", "Complaints Status", 0);      
	 menus[60].addItem("switch.do?prefix=/complaints&page=/Complaintattended.do&mode=get2&special=reset", "", 22, "left", "Complaints Attended", 0);
	 menus[60].addItem("switch.do?prefix=/complaints&page=/TotalComplaints.do&mode=get2&special=reset", "", 22, "left", "Complaints Report", 0);
	
	
 	 menus[61] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	// menus[61].addItem("./reports/rws_Slipage_hab_frm.jsp", "", 22, "left", "Slippage Report", 0);	
	 menus[61].addItem("./reports/rws_slippagetable_hab_frm.jsp", "", 22, "left", "Slipped Habitations", 0);
 	 menus[61].addItem("./reports/rws_Sources_hab_frm.jsp", "", 22, "left", "Source Details", 0);	
 	 menus[61].addItem("./reports/rws_Fc_schemes_frm.jsp", "", 22, "left", "Assets Report", 0);	
 	 
	 
	 
	  menus[62] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
      menus[62].addItem("switch.do?prefix=/masters&page=/Contractor.do&mode=getContractorlist&special=reset", "", 22, "left", "Contractor Details Report", 0);
	   
	  menus[63] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	  menus[63].addItem("./reports/rws_works_projectshelf_rpt.jsp", "", 22, "left", "To Be Sent 2010-11", 0);      
	  menus[63].addItem("./reports/rws_project_shelf_frm.jsp", "", 22, "left", "Districtwise Report", 0); 
  	  menus[63].addItem("./reports/rws_comp_probcomp_works.jsp", "", 22, "left", "Analysis Report", 0);
	 
 	  menus[64] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	  menus[64].addItem("switch.do?prefix=/proposals&page=/Workwise.do?mode=circles", "", 22, "left", "WorkWise Report", 0); 
	  menus[64].addItem("./reports/rws_sustainability_works.jsp", "", 22, "left", "Sustainability Works", 0);
	  menus[64].addItem("./reports/rws_Aap_frm.jsp", "", 22, "left", "AAP 2011-2012 Works ", 0);
	  //	  menus[64].addItem("./reports/rws_prajapatham_workstatus_select.jsp", "", 22, "left", "Work Status", 0);   
//added by swapna
        menus[65] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[65].addItem("switch.do?prefix=/masters&page=/bank.do&mode=data&special=Y", "", 22, "left", "Bank Master", 0);	
		menus[65].addItem("switch.do?prefix=/masters&page=/branch.do&mode=data&special=Y", "", 22, "left", "Branch Master", 0);	
		menus[65].addItem("switch.do?prefix=/masters&page=/office.do&mode=data&special=Y", "", 22, "left", " Bank Details Entry Form", 0);   
		menus[66] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[66].addItem("./reports/rws_bank_rpt.jsp","", 22, "left", "Account Details", 0);	
		
		menus[67] = new menu(280, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[67].addItem("./reports/rws_bank_rpt.jsp","", 22, "left", "GOI Bill Report", 0);	    
		menus[67].addItem("./reports/rws_bill_pao_rpt.jsp","", 22, "left", "State Bill Report", 0);	 
		menus[67].addItem("./reports/rws_bank_details_frm.jsp","", 22, "left", "Bills Vs Releases  Vs Vouchers", 0);     
		menus[67].addItem("./reports/rws_bank_process_frm.jsp","", 22, "left", "Bill Wise Central Releases", 0);	  
		menus[67].addItem("./reports/rws_bankwise_State_frm.jsp","", 22, "left", "Bill Wise State Releases", 0);	  
		menus[67].addItem("./reports/rws_Releases_bdates_frm.jsp","", 22, "left", "Releases Between Dates", 0);	  
	
		menus[67].addItem("./reports/rws_precedings_frm.jsp","", 22, "left", "Bank Proceedings", 0);
		

		menus[68] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[68].addItem("./masters/rws_bill_release_to_enc_login.jsp","", 22, "left", "Bill Selection", 0);	
		menus[68].addItem("./masters/rws_bill_release_to_bank_login.jsp","", 22, "left", "Bill Process", 0);	

		menus[69] = new menu(230, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[69].addItem("./masters/rws_bill_release_to_pao_login.jsp","", 22, "left", "State Bill Generartion", 0);
		menus[69].addItem("./masters/rws_bill_pao_login.jsp","", 22, "left", "State Bill Process", 0);		
		//menus[69].addItem("#","", 22, "left", "State Bill Generartion", 0);
		//menus[69].addItem("#","", 22, "left", "State Bill Process", 0);	
			menus[70] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
			menus[70].addItem("./reports/rws_payment_Excess_rpt.jsp","", 22, "left", "Bill Admissiable Amt > Bill Amt", 0);	
			menus[70].addItem("./reports/rws_BankPao_Payment_det_frm.jsp", "", 18, "left", "Bank-PAO Releases",0);
			menus[70].addItem("./reports/rws_Financial_rpt.jsp", "", 18, "left", "Financial Achievement ",0);
		menus[70].addItem("./reports/rws_Releases_Exp_frm.jsp", "", 18, "left", " Divisionwise Rel VS Exp  ",0);
		menus[70].addItem("./reports/rws_Exp_Rel_Pro_frm.jsp", "", 18, "left", " ProgrammeWise Rel VS Exp ",0);
		
		menus[71] = new menu(300, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
		menus[71].addItem("switch.do?prefix=/drought&page=/PowerTransport.do&mode=get2&special=reset", "", 22, "left", "Habitations For Drought", 0);
      // menus[71].addItem("switch.do?prefix=/drought&page=/DroughtCumulative.do&mode=get2", "", 22, "left", "Cumulative Expenditure", 0);
		menus[71].addItem("switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=get2", "", 22, "left", "Daily Entry(TRANS,HIRING)", 0);
		menus[71].addItem("switch.do?prefix=/drought&page=/FlushDeep.do&mode=data&special=reset", "", 22, "left", "Flushing Deepening of Borewells", 0);


     menus[72] = new menu(450, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	 menus[72].addItem("./reports/rws_drought_habitations_frm.jsp","", 22, "left", "Contingency Abstract Report", 0);
	 menus[72].addItem("./reports/rws_drought_frm.jsp","", 22, "left", "Drought Habitations Report", 0);
	 menus[72].addItem("switch.do?prefix=/drought&page=/DroughtReport.do&mode=get2", "", 22, "left", "Status report of drought Habitations ", 0);
	menus[72].addItem("./reports/rws_drought_deepen_frm.jsp","", 22, "left", "Abstract Flushing/Deepnening", 0);
	menus[72].addItem("./reports/rws_drought_daily_rpt.jsp","", 22, "left", "Daily Report", 0);
	 menus[72].addItem("./reports/rws_drought_daily_comparision_consolidate_rpt.jsp", "", 22, "left", "Daily Comparision ", 0);
     menus[72].addItem("./reports/rws_drought_ongoing_works_rpt.jsp", "", 22, "left", "On Going Works ", 0);





menus[73] = new menu(260, "vertical", 0, 0, 0, 0, "#E1E1E1", "#8A9FCD", "Verdana,Helvetica", 9, "bold", "bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
	    menus[73].addItem("switch.do?prefix=/drought&page=/Scarcity.do&mode=data", "", 22, "left", "Scarcity Master ", 0);
		//menus[73].addItem("switch.do?prefix=/drought&page=/FlushDeep.do&mode=data&special=reset", "", 22, "left", "Flushing Deepening of Borewells", 0);


} //OUTER CLOSING BRACKET. EVERYTHING ADDED MUST BE ABOVE THIS LINE.