function subItemsList()
{
alert("hai");
}
function init()
{
	//Main Menu items:
	menus[0] = new menu(22, "horizontal", 0, 100, -2, -2, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, 
		"bold", "bold", "black", "white", 1, "gray", 2, "rollover:/pred/images/tri-down1.gif:images/tri-down2.gif", false, true, true, true, 12, true, 4, 4, "#cccccc");
	menus[0].addItem("#", "", 130, "center", "Forms", 1);
	menus[0].addItem("#", "", 120, "center", "Reports", 2);
	menus[0].addItem("/pred/help/Prajapatham.doc?loginMode=prajapatham", "", 100, "center", "Help", 0);
	menus[0].addItem("/pred/Logout.do?loginMode=prajapatham", "", 110, "center", "Logout", 0);
	

//Sub Menu for 1nd Main Menu Item ("Entry Sheets"):
	menus[1] = new menu(158, "vertical", 0, 0, -5, -5, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, 62, false, true, false, true, 6, true, 4, 4, "#cccccc");
	menus[1].addItem("switch.do?prefix=/proposals&page=/prajapadam.do&loginMode=prajapatham&mode=data", "", 22, "left", "Prajapatham", 0);
	
    // to open a new window menus[1].addItem("#", "NEWWIN", 22, "left", "Example", 0);

//Sub Menus for 2rd Main Menu Item ("Masters"):
	menus[2] = new menu(160, "vertical", 0, 0, 0, 0, "#DEE3E0", "#8A9FCD", "Verdana,Helvetica", 9, "bold", 
		"bold", "black", "white", 1, "gray", 2, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, false, false, 0, true, 4, 4, "#cccccc");
 
	menus[2].addItem("switch.do?prefix=/reports&page=/rws_prajapatham_selectHab_frm.jsp&loginMode=prajapatham", "", 35, "left", "Consolidated - Drill Down", 0);   
	menus[2].addItem("switch.do?prefix=/reports&page=/rws_selectHabitation_frm.jsp&loginMode=prajapatham", "", 35, "left", "Habitation Wise", 0);   
	menus[2].addItem("switch.do?prefix=/reports&page=/rws_praja_select_byProg.jsp&loginMode=prajapatham", "", 35, "left", "Sanction Scope", 0);   
	menus[2].addItem("switch.do?prefix=/reports&page=/rws_programmes_frm.jsp&loginMode=prajapatham", "", 35, "left", "Programme Wise", 0);   
    

			
			
				
			    
} //OUTER CLOSING BRACKET. EVERYTHING ADDED MUST BE ABOVE THIS LINE.