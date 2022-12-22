 <%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
	int count = 0;
	 nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String userid = users.getUserId(); 
	String status=session.getAttribute("status").toString();
	
	Calendar rightNow = Calendar.getInstance();
	int year = rightNow.get(Calendar.YEAR);
%>

<style>
.readonlyfield {
	background-color: #EEEEEE !important;
}
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</STYLE>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>

<script language="JavaScript">

	function updateSafeSupply()
	{
		var zURL = "./switch.do?prefix=/masters&page=/HabData.do";
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();	
	}	
	
	function functionDistrictChanged()
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=mandals";
		document.forms[0].submit();	
	}
	
	function functionMandalChanged()
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=panchayats";
		document.forms[0].submit();
	}
	
	function functionPanchayatChanged()
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=villages";
		document.forms[0].submit();	
	}
	
	function functionVillageChanged()
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=habitations";
		document.forms[0].submit();
	
	
	}
	function functionHabitationChanged(){
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=view";
		document.forms[0].submit();
	}	

function	fnSavePS(){
		if(document.getElementById("district").value=="")
		{
				alert("Please Select District");
				return false;
		}
		if(document.getElementById("mandal").value=="")
		{
				alert("Please Select Mandal");
				return false;
		}
		if(document.getElementById("panchayat").value=="")
		{
				alert("Please Select Panchayat");
				return false;
		}
		if(document.getElementById("village").value=="")
		{
				alert("Please Select Village");
				return false;
		}
		if(document.getElementById("habitation").value=="")
		{
				alert("Please Select Habitation");
				return false;
		}
	var hp=document.getElementById('hpCount').value;
		
		for( var i=0;i<hp;i++)
		{
			
			if(document.forms[0].elements["hp["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select HP Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["hp["+i+"].soakPit"].value=="" )
			{
				alert("Please Select HP Saok Pits");
				return false;
				
			}
			
		}
		var shp=document.getElementById('shpCount').value;
		
		for( var i=0;i<shp;i++)
		{
			
			
			if(document.forms[0].elements["shp["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select SHP Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["shp["+i+"].soakPit"].value=="" )
			{
				alert("Please Select SHP Saok Pits");
				return false;
				
			}
			
		}

		var others=document.getElementById('othersCount').value;
		
		for( var i=0;i<others;i++)
		{
			
			if(document.forms[0].elements["others["+i+"].tableName"].value!="spring" ){
				
			if(document.forms[0].elements["others["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select Others Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["others["+i+"].soakPit"].value=="" )
			{
				alert("Please Select Others Saok Pits");
				return false;
				
			}
			}
		}
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=savePS";	
		document.forms[0].submit();
	}
	
	
	function ohsrglsrrelated(){
		var ohsrCount=0;
		var glsrCount=0;
		var ohsrCapacity=0;
		var glsrCapacity=0;
        
		var pws=document.getElementById('pwsCount').value;
		for( var i=0;i<pws;i++)
		{
			
			
			if(document.forms[0].elements["pws["+i+"].tableName"].value=="ohsr")
			{
				
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("pws["+i+"].pwsSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["pws["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("pws["+i+"].pwsSafeLPCD").value);
				glsrCount++;			
					
			}
			
		}
		
		var mpws=document.getElementById('mpwsCount').value;
		
		for( var i=0;i<mpws;i++)
		{
			
			
			if(document.forms[0].elements["mpws["+i+"].tableName"].value=="ohsr")
			{
				
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("mpws["+i+"].mpwsSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["mpws["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("mpws["+i+"].mpwsSafeLPCD").value);
				glsrCount++;			
					
			}
		}
			var dp=document.getElementById('dpCount').value;
		for( var i=0;i<dp;i++)
		{
			if(document.forms[0].elements["dps["+i+"].tableName"].value=="ohsr")
			{
				
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("dps["+i+"].othersSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["dps["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("dps["+i+"].othersSafeLPCD").value);
				glsrCount++;			
					
			}
			
		}
		var cpws=document.getElementById('cpwsCount').value;
		for( var i=0;i<cpws;i++)
		{		
			if(document.forms[0].elements["cpws["+i+"].tableName"].value=="ohsr")
			{
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("cpws["+i+"].cpwsSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["cpws["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("cpws["+i+"].cpwsSafeLPCD").value);
				glsrCount++;			
					
			}
		}
		var cpwsLinksResCount=document.getElementById('cpwsLinksResCount').value;
		for( var i=0;i<cpwsLinksResCount;i++)
		{		
			if(document.forms[0].elements["cpwsResLinks["+i+"].tableName"].value=="ohsr")
			{
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("cpwsResLinks["+i+"].cpwsLinksSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["cpwsResLinks["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("cpwsResLinks["+i+"].cpwsLinksSafeLPCD").value);
				glsrCount++;								
			}			
		}
	   var pwsLinksCount=document.getElementById('pwsLinksCount').value;
		for( var i=0;i<pwsLinksCount;i++)
		{			
			if(document.forms[0].elements["pwsLinks["+i+"].tableName"].value=="ohsr")
			{				
				ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("pwsLinks["+i+"].pwsLinksSafeLPCD").value);
				ohsrCount++;
			}
			else if(document.forms[0].elements["pwsLinks["+i+"].tableName"].value=="glsr")
			{
				glsrCapacity=glsrCapacity+parseInt(document.getElementById("pwsLinks["+i+"].pwsLinksSafeLPCD").value);
				glsrCount++;							
			}			
		}	
		  var mpwsLinksCount=document.getElementById('mpwsLinksCount').value;
			for( var i=0;i<mpwsLinksCount;i++)
			{			
				if(document.forms[0].elements["mpwsLinks["+i+"].tableName"].value=="ohsr")
				{				
					ohsrCapacity=ohsrCapacity+parseInt(document.getElementById("mpwsLinks["+i+"].mpwsLinksSafeLPCD").value);
					ohsrCount++;
				}
				else if(document.forms[0].elements["mpwsLinks["+i+"].tableName"].value=="glsr")
				{
					glsrCapacity=glsrCapacity+parseInt(document.getElementById("mpwsLinks["+i+"].mpwsLinksSafeLPCD").value);
					glsrCount++;							
				}			
			}
		document.getElementById('ohsrNo').value=ohsrCount;
		document.getElementById("ohsrQty").value=ohsrCapacity;
		document.getElementById("glsrNo").value=glsrCount;
		document.getElementById("glsrQty").value=glsrCapacity;
		wqTest();
	}
	
function fnSave(){
	var user='<%=userid%>';
	
	
		if(document.getElementById("district").value=="")
		{
				alert("Please Select District");
				return false;
		}
		if(document.getElementById("mandal").value=="")
		{
				alert("Please Select Mandal");
				return false;
		}
		if(document.getElementById("panchayat").value=="")
		{
				alert("Please Select Panchayat");
				return false;
		}
		if(document.getElementById("village").value=="")
		{
				alert("Please Select Village");
				return false;
		}
		if(document.getElementById("habitation").value=="")
		{
				alert("Please Select Habitation");
				return false;
		}
		var actualPopValue=document.getElementById('actTotPop').value;
		if(actualPopValue<=0){
			alert("Please update actual population details.");
			return false;
		}
		 /* var newLpcd=document.getElementById('newLpcd').value;
			if(newLpcd<=0){
				
				alert("Safe LPCD as on 01-04-2020 should be more than 0.");
				return false;	
			}  */
var cpwsLinks=document.getElementById('cpwsLinksCount').value;
		
		for( var i=0;i<cpwsLinks;i++)
		{
			if(document.forms[0].elements["cpwsLinks["+i+"].waterBeingSupplied"].value=="")
			{				
					alert("Please Select CPWS Linkage Water Being Supplied");
					return false;					
			}			
		}		
		var cpws=document.getElementById('cpwsCount').value;
		for( var i=0;i<cpws;i++)
		{			
			if(document.forms[0].elements["cpws["+i+"].tableName"].value=="source" && document.forms[0].elements["cpws["+i+"].sourceStatus"].value=="" )
			{
				alert("Please Select CPWS Source Status");
				return false;
			}
			if(document.forms[0].elements["cpws["+i+"].tableName"].value=="source" && document.forms[0].elements["cpws["+i+"].waterBeingSupplied"].value=="")
			{				
					alert("Please Select CPWS Water Being Supplied");
					return false;					
			}			
		}		
		var pwsLinks=document.getElementById('pwsLinksCount').value;
		
		for( var i=0;i<pwsLinks;i++)
		{			
			if(document.forms[0].elements["pwsLinks["+i+"].tableName"].value=="source"){
				if(document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value=="-" || document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value=="")
				{				
						alert("Please link the Source aginst to this habitation for the Asset"+document.forms[0].elements["pwsLinks["+i+"].pwsLinksAssetCode"].value+ " in WQty --> 4.Single Source Multiple Habitation Form ");
						return false;					
				}	
				if(document.forms[0].elements["pwsLinks["+i+"].waterBeingSupplied"].value=="")
				{				
						alert("Please Select PWS Linkage Water Being Supplied");
						return false;					
				}
			}
		}
				
		var pws=document.getElementById('pwsCount').value;		
		for( var i=0;i<pws;i++)
		{		
			
			if(document.forms[0].elements["pws["+i+"].tableName"].value=="source" && document.forms[0].elements["pws["+i+"].sourceStatus"].value=="")
			{				
					alert("Please Select PWS Source Status");
					return false;					
			}
			if(document.forms[0].elements["pws["+i+"].tableName"].value=="source" && document.forms[0].elements["pws["+i+"].sourceType"].value=="")
			{				
					alert("Please Select PWS Source Type");
					return false;					
			}
			if(document.forms[0].elements["pws["+i+"].tableName"].value=="source" && document.forms[0].elements["pws["+i+"].waterBeingSupplied"].value=="")
			{				
					alert("Please Select PWS Water Being Supplied");
					return false;					
			}
		}
		
		var mpwsLinks=document.getElementById('mpwsLinksCount').value;
		
		for( var i=0;i<mpwsLinks;i++)
		{
			if(document.forms[0].elements["mpwsLinks["+i+"].tableName"].value=="source"){
				if(document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value=="-" || document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value=="")
				{				
						alert("Please link the Source aginst to this habitation for the Asset"+document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksAssetCode"].value+ "in WQty --> 4.Single Source Multiple Habitation Form ");
						return false;					
				}			
				if(document.forms[0].elements["mpwsLinks["+i+"].waterBeingSupplied"].value=="")
				{				
						alert("Please Select MPWS Linkage Water Being Supplied");
						return false;					
				}	
			}
		}
		
		var mpws=document.getElementById('mpwsCount').value;
		
		for( var i=0;i<mpws;i++)
		{			
			if(document.forms[0].elements["mpws["+i+"].tableName"].value=="source" && document.forms[0].elements["mpws["+i+"].sourceStatus"].value=="" )
			{
				alert("Please Select MPWS Source Status");
				return false;				
			}
			if(document.forms[0].elements["mpws["+i+"].tableName"].value=="source" && document.forms[0].elements["mpws["+i+"].sourceType"].value=="")
			{				
					alert("Please Select MPWS Source Type");
					return false;					
			}
			if(document.forms[0].elements["mpws["+i+"].tableName"].value=="source" && document.forms[0].elements["mpws["+i+"].waterBeingSupplied"].value=="")
			{				
					alert("Please Select MPWS Water Being Supplied");
					return false;					
			}
		}
		
		var dpLinks=document.getElementById('dpLinksCount').value;
		
		for( var i=0;i<dpLinks;i++)
		{
			if(document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value=="--" || document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value=="")
			{				
					alert("Please link the Source aginst to this habitation for the Asset"+document.forms[0].elements["dpLinks["+i+"].dpLinksAssetCode"].value+ "in WQty --> 4.Single Source Multiple Habitation Form ");
					return false;					
			}
			if(document.forms[0].elements["dpLinks["+i+"].waterBeingSupplied"].value=="")
			{				
					alert("Please Select Direct Pumping Linkage Water Being Supplied");
					return false;					
			}			
		}
		
		var dp=document.getElementById('dpCount').value;
		for( var i=0;i<dp;i++)
		{
			
			if(document.forms[0].elements["dps["+i+"].tableName"].value=="source" && document.forms[0].elements["dps["+i+"].sourceStatus"].value=="")
			{
				
					alert("Please Select Direct Pumping Source Status");
					return false;
					
			}
			if(document.forms[0].elements["dps["+i+"].tableName"].value=="source" && document.forms[0].elements["dps["+i+"].sourceType"].value=="")
			{
				
					alert("Please Select Direct Pumping Source Type");
					return false;
					
			}
			if(document.forms[0].elements["dps["+i+"].tableName"].value=="source" && document.forms[0].elements["dps["+i+"].waterBeingSupplied"].value=="")
			{
				
					alert("Please Select Direct Pumping Water Being Supplied");
					return false;
					
			}
			
		}
		
	
		var hp=document.getElementById('hpCount').value;
		
		for( var i=0;i<hp;i++)
		{
			
			if(document.forms[0].elements["hp["+i+"].sourceStatus"].value=="" )
			{
				alert("Please Select HP Source Status");
				return false;
				
			}
			if(document.forms[0].elements["hp["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select HP Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["hp["+i+"].soakPit"].value=="" )
			{
				alert("Please Select HP Saok Pits");
				return false;
				
			}
			if(document.forms[0].elements["hp["+i+"].waterBeingSupplied"].value=="" )
			{
				alert("Please Select HP Water Being Supplied");
				return false;
				
			}
		}
		var shp=document.getElementById('shpCount').value;
		
		for( var i=0;i<shp;i++)
		{
			
			if(document.forms[0].elements["shp["+i+"].sourceStatus"].value=="" )
			{
				alert("Please Select SHP Source Status");
				return false;
				
			}
			if(document.forms[0].elements["shp["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select SHP Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["shp["+i+"].soakPit"].value=="" )
			{
				alert("Please Select SHP Saok Pits");
				return false;
				
			}
			if(document.forms[0].elements["shp["+i+"].waterBeingSupplied"].value=="" )
			{
				alert("Please Select SHP Water Being Supplied");
				return false;
				
			}
		}

		var others=document.getElementById('othersCount').value;
		
		for( var i=0;i<others;i++)		{
			
			
			if(document.forms[0].elements["others["+i+"].sourceStatus"].value=="" )
			{
				alert("Please Select Others Source Status");
				return false;
				
			}
			if(document.forms[0].elements["others["+i+"].waterBeingSupplied"].value=="" )
			{
				alert("Please Select Others Water Being Supplied");
				return false;
				
			}
			if(document.forms[0].elements["others["+i+"].tableName"].value!="spring" ){
				
			if(document.forms[0].elements["others["+i+"].platformExisting"].value=="" )
			{
				alert("Please Select Others Platform Existing");
				return false;
				
			}
			if(document.forms[0].elements["others["+i+"].soakPit"].value=="" )
			{
				alert("Please Select Others Saok Pits");
				return false;
				
			}
			}
		}
		waterSuppy();
			
		var calCS=document.getElementById("coverageStatus").value;
		/* 
		if(calCS=='NSS'){
			if(document.getElementById("contaminationType").value==''){
				alert("Please click on ... button near Contamination Type to get Type of Contamination");
				return false;
			}
		} */
		var actCS=document.getElementById("previousCS").value;
		
		
		if(calCS!=actCS){
			
		if(actCS=="FC" && (calCS=="PC4" || calCS=="PC3" || calCS=="PC2" || calCS=="PC1" || calCS=="NC" || calCS=="NSS")){
			if(user=="100000" ){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
		else if(actCS=="PC4" && (calCS=="PC3" || calCS=="PC2" || calCS=="PC1" || calCS=="NC" || calCS=="NSS")){
			if(user=="100000"){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
		else if(actCS=="PC3" && (calCS=="PC2" || calCS=="PC1" || calCS=="NC" || calCS=="NSS")){
			if(user=="100000"){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
		else if(actCS=="PC2" && (calCS=="PC1" || calCS=="NC" || calCS=="NSS")){
			if(user=="100000"){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
		else if(actCS=="PC1" && (calCS=="NC" || calCS=="NSS")){
			if(user=="100000"){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
		else if(actCS=="NSS" && (calCS=="NC" )){
			//if(user=="100000" || user.substring(3,6)=="000"){
			if(user=="100000" ){
				if(!confirm("Slipped Back, Are you sure you want to continue?")){
					return false;
				}
				}
				else{
					alert("Cannot Slip Back. Please contact Head Office");
					return false;
				}
		}
	}
		
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=save";	
		document.forms[0].submit();
	}
	function fnHabDirUpdate()
	{
		if(document.getElementById("district").value=="")
		{
				alert("Please Select District");
				return false;
		}
		if(document.getElementById("mandal").value=="")
		{
				alert("Please Select Mandal");
				return false;
		}
		if(document.getElementById("panchayat").value=="")
		{
				alert("Please Select Panchayat");
				return false;
		}
		if(document.getElementById("village").value=="")
		{
				alert("Please Select Village");
				return false;
		}
		if(document.getElementById("habitation").value=="")
		{
				alert("Please Select Habitation");
				return false;
		}
		if(document.getElementById('houseHolds').value==0){
			alert("House Holds Should not be Zero");
			return false;
		}
		if(document.getElementById('totPop').value==0){
			alert("Total Population Should not be Zero please go to the habitation status entry form and update the population");
			return false;
		}
		if(parseInt(document.getElementById('houseHolds').value)<document.getElementById('houseConn').value){
			alert("House Connections Should not be greater than House Holds");
			return false;
		}
		document.forms[0].action="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=habdirupdate";	
		document.forms[0].submit();
	}
	
	
	function addPwsValue()
	{
		
		var len=document.getElementById('pwsCount').value;
		
		var pwsSafe=0;
		var noSafe=0;
		var pwsUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["pws["+i+"].pwsSafeLPCD"].value!=0 && document.forms[0].elements["pws["+i+"].tableName"].value=="source")
			{
				
				pwsSafe=pwsSafe+parseInt(document.getElementById("pws["+i+"].pwsSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value!=0 && document.forms[0].elements["pws["+i+"].tableName"].value=="source")
			{
				pwsUnSafe=pwsUnSafe+parseInt(document.getElementById("pws["+i+"].pwsUnSafeLPCD").value);
				noUnSafe++;
			}
			
		}
		document.getElementById('pwsHabLPCD').value=pwsSafe;
		document.getElementById('pwsNo').value=noSafe;
		document.getElementById('pwsHabUnsafeLPCD').value=pwsUnSafe;
		document.getElementById('pwsUnSafeNo').value=noUnSafe;
		waterSuppy();
	}
	function addPwsLinksValue()
	{	
		
		var len=document.getElementById('pwsLinksCount').value;		
		var pwsSafe=0;
		var pwsUnSafe=0;
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].tableName"].value=="source")
			{				
				pwsSafe=pwsSafe+parseInt(document.getElementById("pwsLinks["+i+"].pwsLinksSafeLPCD").value);
			}
			if(document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].tableName"].value=="source" )
			{
				pwsUnSafe=pwsUnSafe+parseInt(document.getElementById("pwsLinks["+i+"].pwsLinksUnSafeLPCD").value); 
			}
			
		}
		document.getElementById('pwsHabLinkLPCD').value=pwsSafe;
		document.getElementById('pwsHabLinkUnsafeLPCD').value=pwsUnSafe;
		waterSuppy();
	}
	function addMpwsLinksValue()
	{	
		var len=document.getElementById('mpwsLinksCount').value;		
		var mpwsSafe=0;
		var mpwsUnSafe=0;
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].tableName"].value=="source")
			{				
				mpwsSafe=mpwsSafe+parseInt(document.getElementById("mpwsLinks["+i+"].mpwsLinksSafeLPCD").value);
			}
			if(document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].tableName"].value=="source" )
			{
				mpwsUnSafe=mpwsUnSafe+parseInt(document.getElementById("mpwsLinks["+i+"].mpwsLinksUnSafeLPCD").value); 
			}
			
		}
		document.getElementById('mpwsHabLinkLPCD').value=mpwsSafe;
		document.getElementById('mpwsHabLinkUnsafeLPCD').value=mpwsUnSafe;
		waterSuppy();
	}
	function addDpLinksValue()
	{	
		var len=document.getElementById('dpLinksCount').value;		
		var dpSafe=0;
		var dpUnSafe=0;
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].value!=0 )
			{				
				dpSafe=dpSafe+parseInt(document.getElementById("dpLinks["+i+"].dpLinksSafeLPCD").value);
			}
			if(document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value!=0 )
			{
				dpUnSafe=dpUnSafe+parseInt(document.getElementById("dpLinks["+i+"].dpLinksUnSafeLPCD").value); 
			}
			
		}
		document.getElementById('dpHabLinkLPCD').value=dpSafe;
		document.getElementById('dpHabLinkUnsafeLPCD').value=dpUnSafe;
		waterSuppy();
	}
	function toggleFieldsPWS()
	{		
		var len=document.getElementById('pwsCount').value;
		 
		for( var i=0;i<len;i++)
		{			
			if(document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value!=0)
			{
				document.getElementById("pws["+i+"].flouride").disabled=false;
				document.getElementById("pws["+i+"].brakish").disabled=false;
				document.getElementById("pws["+i+"].iron").disabled=false;
				document.getElementById("pws["+i+"].nitrate").disabled=false;			
			}
			else{
				document.getElementById("pws["+i+"].flouride").disabled=true;
				document.getElementById("pws["+i+"].brakish").disabled=true;
				document.getElementById("pws["+i+"].iron").disabled=true;
				document.getElementById("pws["+i+"].nitrate").disabled=true;				
			}
		}
	}
	function addDpValue()
	{
		
		var len=document.getElementById('dpCount').value;
		
		var dpSafe=0;
		var noSafe=0;
		var dpUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["dps["+i+"].othersSafeLPCD"].value!=0)
			{
				
				dpSafe=dpSafe+parseInt(document.getElementById("dps["+i+"].othersSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].value!=0)
			{
				dpUnSafe=dpUnSafe+parseInt(document.getElementById("dps["+i+"].othersUnSafeLPCD").value);
				noUnSafe++;
			}
			
		}
		document.getElementById('dpHabLPCD').value=dpSafe;
		document.getElementById('dpSafeNo').value=noSafe;
		document.getElementById('dpHabUnsafeLPCD').value=dpUnSafe;
		document.getElementById('dpUnSafeNo').value=noUnSafe;
		waterSuppy();
	}
	
	function addMpwsValue()
	{
		
		var len=document.getElementById('mpwsCount').value;
		//alert(len);
		var mpwsSafe=0;
		var noSafe=0;
		var mpwsUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["mpws["+i+"].mpwsSafeLPCD"].value!=0 && document.forms[0].elements["mpws["+i+"].tableName"].value=="source")
			{
				
				mpwsSafe=mpwsSafe+parseInt(document.getElementById("mpws["+i+"].mpwsSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value!=0 && document.forms[0].elements["mpws["+i+"].tableName"].value=="source")
			{
				mpwsUnSafe=mpwsUnSafe+parseInt(document.getElementById("mpws["+i+"].mpwsUnSafeLPCD").value);
				noUnSafe++;
			}
			
		}
		document.getElementById('mpwsHabLPCD').value=mpwsSafe;
		document.getElementById('mpwsNo').value=noSafe;
		document.getElementById('mpwsHabUnsafeLPCD').value=mpwsUnSafe;
		document.getElementById('mpwsUnSafeNo').value=noUnSafe;
		 waterSuppy();
	}
	function toggleFieldsMPWS()
	{
		
		var len=document.getElementById('mpwsCount').value;
		for( var i=0;i<len;i++)
		{
			
			if(document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value!=0)
			{
				document.getElementById("mpws["+i+"].flouride").disabled=false;
				document.getElementById("mpws["+i+"].brakish").disabled=false;
				document.getElementById("mpws["+i+"].iron").disabled=false;
				document.getElementById("mpws["+i+"].nitrate").disabled=false;				
			}
			else{
				document.getElementById("mpws["+i+"].flouride").disabled=true;
				document.getElementById("mpws["+i+"].brakish").disabled=true;
				document.getElementById("mpws["+i+"].iron").disabled=true;
				document.getElementById("mpws["+i+"].nitrate").disabled=true;				
			}
			
		}
		
		
	}
	function addCpwsValue()
	{
		
		var len=document.getElementById('cpwsCount').value;
		var cpwsSafe=0;
		var noSafe=0;
		for( var i=0;i<len;i++)
		{
			
			if(document.forms[0].elements["cpws["+i+"].cpwsSafeLPCD"].value!=0 && document.forms[0].elements["cpws["+i+"].tableName"].value=="source")
			{
				
				cpwsSafe=cpwsSafe+parseInt(document.getElementById("cpws["+i+"].cpwsSafeLPCD").value);
				noSafe++;
			}
				
		}
		document.getElementById('cpwsHabLPCD').value=cpwsSafe;
		document.getElementById('cpwsNo').value=noSafe;
		waterSuppy();
	}
	function addHpValue()
	{
		
		var len=document.getElementById('hpCount').value;
		var hpSafe=0;
		var noSafe=0;
		var hpUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["hp["+i+"].hpSafeLPCD"].value!=0)
			{
				
				hpSafe=hpSafe+parseInt(document.getElementById("hp["+i+"].hpSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value!=0)
			{
				hpUnSafe=hpUnSafe+parseInt(document.getElementById("hp["+i+"].hpUnSafeLPCD").value);
				noUnSafe++;
			}
			
		}
		document.getElementById('hpHabLPCD').value=hpSafe;
		document.getElementById('hpNo').value=noSafe;
		document.getElementById('hpHabUnsafeLPCD').value=hpUnSafe;
		document.getElementById('hpUnSafeNo').value=noUnSafe;
		waterSuppy();
	}
	function toggleFieldsHP()
	{		
		var len=document.getElementById('hpCount').value;
		for( var i=0;i<len;i++)
		{			
			if(document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value!=0)
			{
				document.getElementById("hp["+i+"].flouride").disabled=false;
				document.getElementById("hp["+i+"].brakish").disabled=false;
				document.getElementById("hp["+i+"].iron").disabled=false;
				document.getElementById("hp["+i+"].nitrate").disabled=false;
				
				
			}
			else{
				document.getElementById("hp["+i+"].flouride").disabled=true;
				document.getElementById("hp["+i+"].brakish").disabled=true;
				document.getElementById("hp["+i+"].iron").disabled=true;
				document.getElementById("hp["+i+"].nitrate").disabled=true;
				}			
		}		
	}
	function addShpValue()
	{
		
		var len=document.getElementById('shpCount').value;
		var shpSafe=0;
		var noSafe=0;
		var shpUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{
			if(document.forms[0].elements["shp["+i+"].shpSafeLPCD"].value!=0)
			{
				
				shpSafe=shpSafe+parseInt(document.getElementById("shp["+i+"].shpSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value!=0)
			{
				shpUnSafe=shpUnSafe+parseInt(document.getElementById("shp["+i+"].shpUnSafeLPCD").value);
				noUnSafe++;
			}
			
		}
		document.getElementById('shpHabLPCD').value=shpSafe;
		document.getElementById('shpNo').value=noSafe;
		document.getElementById('shpHabUnsafeLPCD').value=shpUnSafe;
		document.getElementById('shpUnSafeNo').value=noUnSafe;
		waterSuppy();
	}
	function toggleFieldsSHP()
	{		
		var len=document.getElementById('shpCount').value;
		for( var i=0;i<len;i++)
		{
			
			if(document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value!=0)
			{
				document.getElementById("shp["+i+"].flouride").disabled=false;
				document.getElementById("shp["+i+"].brakish").disabled=false;
				document.getElementById("shp["+i+"].iron").disabled=false;
				document.getElementById("shp["+i+"].nitrate").disabled=false;
			}
			else{
				document.getElementById("shp["+i+"].flouride").disabled=true;
				document.getElementById("shp["+i+"].brakish").disabled=true;
				document.getElementById("shp["+i+"].iron").disabled=true;
				document.getElementById("shp["+i+"].nitrate").disabled=true;
				}			
		}		
	}
	function addOthersValue()
	{
		
		var len=document.getElementById('othersCount').value;
		var othersSafe=0;
		var noSafe=0;
		var othersUnSafe=0;
		var noUnSafe=0;   
		for( var i=0;i<len;i++)
		{			
			if(document.forms[0].elements["others["+i+"].othersSafeLPCD"].value!=0)
			{				
				othersSafe=othersSafe+parseInt(document.getElementById("others["+i+"].othersSafeLPCD").value);
				noSafe++;
			}
			if(document.forms[0].elements["others["+i+"].tableName"].value!="spring" && document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value!=0 )
			{
				othersUnSafe=othersUnSafe+parseInt(document.getElementById("others["+i+"].othersUnSafeLPCD").value);
				noUnSafe++;
			}		
		}
		document.getElementById('othersHabLPCD').value=othersSafe;
		document.getElementById('othersNo').value=noSafe;
		document.getElementById('othersHabUnsafeLPCD').value=othersUnSafe;
		document.getElementById('othersUnSafeNo').value=noUnSafe;
		waterSuppy();
	}
	function toggleFieldsOthers()
	{
		
		var len=document.getElementById('othersCount').value;
		for( var i=0;i<len;i++)
		{
			
			if(document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value!=0)
			{
				document.getElementById("others["+i+"].flouride").disabled=false;
				document.getElementById("others["+i+"].brakish").disabled=false;
				document.getElementById("others["+i+"].iron").disabled=false;
				document.getElementById("others["+i+"].nitrate").disabled=false;
				
				
			}
			else{
				document.getElementById("others["+i+"].flouride").disabled=true;
				document.getElementById("others["+i+"].brakish").disabled=true;
				document.getElementById("others["+i+"].iron").disabled=true;
				document.getElementById("others["+i+"].nitrate").disabled=true;
			}
		}
		
	}
	function waterSuppy(){		
		var pws=document.getElementById('pwsCount').value;
		var pwsLinks=document.getElementById('pwsLinksCount').value;
		var cpws=document.getElementById('cpwsCount').value;
		var cpwsLinks=document.getElementById('cpwsLinksCount').value;
		var mpws=document.getElementById('mpwsCount').value;
		var mpwsLinks=document.getElementById('mpwsLinksCount').value;
		var hp=document.getElementById('hpCount').value;
		var shp=document.getElementById('shpCount').value;
		var others=document.getElementById('othersCount').value;
		var dp=document.getElementById('dpCount').value;
		var dpLinks=document.getElementById('dpLinksCount').value;

		var flag=false;
		var pwsSafe=0;
		var pwsLinkSafe=0;
		var pwsLinkUnSafe=0;
		var cpwsSafe=0;
		var cpwsLinkSafe=0;
		var mpwsSafe=0;
		var mpwsLinkSafe=0;
		var mpwsLinkUnSafe=0;
		var dpSafe=0;
		var dpLinkSafe=0;
		var dpLinkUnSafe=0;
		var hpSafe=0;
		var shpSafe=0;
		var othersSafe=0;
		var pwsUnSafe=0;
		var mpwsUnSafe=0;
		var dpUnSafe=0;
		var hpUnSafe=0;
		var shpUnSafe=0;
		var othersUnSafe=0;
		
		
		if(pws!=0){
		 pwsSafe=document.getElementById('pwsHabLPCD').value;
		 pwsUnSafe=document.getElementById('pwsHabUnsafeLPCD').value;
		}
		if(pwsLinks!=0){
			 pwsLinkSafe=document.getElementById('pwsHabLinkLPCD').value;
			 pwsLinkUnSafe=document.getElementById('pwsHabLinkUnsafeLPCD').value;
		}
		if(dp!=0){
			 dpSafe=document.getElementById('dpHabLPCD').value;
			 dpUnSafe=document.getElementById('dpHabUnsafeLPCD').value;
		}
		if(dpLinks!=0){
			 dpLinkSafe=document.getElementById('dpHabLinkLPCD').value;
			 dpLinkUnSafe=document.getElementById('dpHabLinkUnsafeLPCD').value;
		}
		if(cpws!=0){
			 cpwsSafe=document.getElementById('cpwsHabLPCD').value;
		}
		if(cpwsLinks!=0){
			 cpwsLinkSafe=document.getElementById('cpwsHabLinkLPCD').value;
		}
		if(mpws!=0){
		 mpwsSafe=document.getElementById('mpwsHabLPCD').value;
		 mpwsUnSafe=document.getElementById('mpwsHabUnsafeLPCD').value;
		}
		if(mpwsLinks!=0){
			 mpwsLinkSafe=document.getElementById('mpwsHabLinkLPCD').value;
			 mpwsLinkUnSafe=document.getElementById('mpwsHabLinkUnsafeLPCD').value;
		}
		if(hp!=0){
		 hpSafe=document.getElementById('hpHabLPCD').value;
		 hpUnSafe=document.getElementById('hpHabUnsafeLPCD').value;
		}
		if(shp!=0){
		 shpSafe=document.getElementById('shpHabLPCD').value;
		 shpUnSafe=document.getElementById('shpHabUnsafeLPCD').value;
		}
		if(others!=0){
		 othersSafe=document.getElementById('othersHabLPCD').value;
		 othersUnSafe=document.getElementById('othersHabUnsafeLPCD').value;
		}
		if(pws==0 && mpws==0 && cpws==0 && dp==0 && pwsLinks==0 && cpwsLinks==0 && mpwsLinks==0 && dpLinks==0 ){
			flag=true;
		}
		else{
			if(pwsSafe==0 && mpwsSafe==0 && cpwsSafe==0 && dpSafe==0 && pwsLinkSafe==0 && cpwsLinkSafe==0 && mpwsLinkSafe==0 && dpLinkSafe==0){
				flag=true;
			}
		}
		
		var netPop=document.getElementById('netPop').value;
		var censusYear=document.getElementById('cYear').value;
		var thisdate = new Date();
		var presentYear = thisdate.getFullYear();
		var totalWaterSupply=parseInt(pwsSafe)+parseInt(dpSafe)+parseInt(mpwsSafe)+parseInt(cpwsSafe)+parseInt(cpwsLinkSafe)+parseInt(pwsLinkSafe)+parseInt(mpwsLinkSafe)+parseInt(dpLinkSafe)+parseInt(hpSafe)+parseInt(shpSafe)+parseInt(othersSafe)+parseInt(pwsUnSafe)+parseInt(dpUnSafe)+parseInt(mpwsUnSafe)+parseInt(hpUnSafe)+parseInt(shpUnSafe)+parseInt(othersUnSafe)+parseInt(pwsLinkUnSafe)+parseInt(mpwsLinkUnSafe)+parseInt(dpLinkUnSafe);
		var hpint=parseInt(hpSafe);
		var hpunsafeint=parseInt(hpUnSafe);
		var shpint=parseInt(shpSafe);
		var shpunsafeint=parseInt(shpUnSafe);
		var othersint=parseInt(othersSafe);
		var othersunsafeint=parseInt(othersUnSafe);
			if(flag){
		if(parseInt((hpint+hpunsafeint)/2)<parseInt(hpunsafeint)){
			hpSafe=0;
		}
		if(parseInt((shpint+shpunsafeint)/2)<parseInt(shpunsafeint)){
			shpSafe=0;
		}
		if(((othersint+othersunsafeint)/2)<parseInt(othersunsafeint)){
			othersSafe=0;
		}
			}
			var totalWaterSupplySafe=parseInt(pwsSafe)+parseInt(dpSafe)+parseInt(mpwsSafe)+parseInt(cpwsSafe)+parseInt(cpwsLinkSafe)+parseInt(pwsLinkSafe)+parseInt(mpwsLinkSafe)+parseInt(dpLinkSafe)+parseInt(hpSafe)+parseInt(shpSafe)+parseInt(othersSafe);
			var totalWaterSupplyUnSafe=parseInt(pwsUnSafe)+parseInt(dpUnSafe)+parseInt(mpwsUnSafe)+parseInt(hpUnSafe)+parseInt(shpUnSafe)+parseInt(othersUnSafe)+parseInt(pwsLinkUnSafe)+parseInt(mpwsLinkUnSafe)+parseInt(dpLinkUnSafe);
			document.getElementById('totalWaterSupply').value=totalWaterSupply;
			document.getElementById('totalWaterSupplySafeSource').value=totalWaterSupplySafe;
			document.getElementById('totalWaterSupplyUnSafeSource').value=totalWaterSupplyUnSafe;
			document.getElementById('totalWaterSupplySafeUnSafe').value=totalWaterSupplySafe+totalWaterSupplyUnSafe;
			//THIS IS UPTO 2017 AND IT IS CHANGED ON 16-MAR-2018 AS PER MAIL GIVEN BY THE DEPARTMENT
			/* var levelOfWaterSupply=totalWaterSupplySafe/(netPop*Math.pow(1.01,presentYear-censusYear));
			levelOfWaterSupply=levelOfWaterSupply.toFixed(2);
			var levelOfWaterSupplySafe=totalWaterSupplySafe/(netPop*Math.pow(1.01,presentYear-censusYear));
			var levelOfWaterSupplyUnSafe=totalWaterSupplyUnSafe/(netPop*Math.pow(1.01,presentYear-censusYear)); */
			var levelOfWaterSupply=totalWaterSupplySafe/(netPop*Math.pow(1.01,3));//THIS HAS BEEN FIXED AS THERE IS NO POPULATION GROWTH
			levelOfWaterSupply=levelOfWaterSupply.toFixed(2);
			var levelOfWaterSupplySafe=totalWaterSupplySafe/(netPop*Math.pow(1.01,3));
			var levelOfWaterSupplyUnSafe=totalWaterSupplyUnSafe/(netPop*Math.pow(1.01,3));
			document.getElementById('levelOfWaterSupplyLPCD').value=levelOfWaterSupply;
			document.getElementById('levelOfWaterSupplySafeSource').value=levelOfWaterSupplySafe.toFixed(2);
			document.getElementById('levelOfWaterSupplyUnSafeSource').value=levelOfWaterSupplyUnSafe.toFixed(2);
			document.getElementById('levelOfWaterSupplySafeUnSafe').value=(levelOfWaterSupplyUnSafe+levelOfWaterSupplySafe).toFixed(2);
			var calCoverageStatus;
			var actualPopValue=document.getElementById('actTotPop').value;
			
			var calNewCoverageStatus="";
		if(levelOfWaterSupply>0)
		{	
			if(levelOfWaterSupply>0 && levelOfWaterSupply<13.75)
			{
					calCoverageStatus = "PC1";
			}
			else if(levelOfWaterSupply>=13.75 && levelOfWaterSupply<27.50)
			{
					calCoverageStatus = "PC2";
			}
			else if(levelOfWaterSupply>=27.50 && levelOfWaterSupply<41.25)
			{
					calCoverageStatus = "PC3";
			}
			else if(levelOfWaterSupply>=41.25 && levelOfWaterSupply<55)
			{
					calCoverageStatus = "PC4";
			}
			else if(levelOfWaterSupply>=55)
			{
					calCoverageStatus = "FC";
			}
		}
		else
		{
			var totalSuppUnsafe = parseInt(totalWaterSupplyUnSafe);
			if(totalSuppUnsafe==0)
				calCoverageStatus = "NC";
			else  if(totalSuppUnsafe>0)
				calCoverageStatus = "NSS";
		}
		/* added new from 16/04/2020 as per mail */
		document.getElementById('newLpcd').value = "0";
		if(actualPopValue>0){
			var lpcd_new_value=totalWaterSupplySafe/actualPopValue;
			lpcd_new_value = lpcd_new_value.toFixed(2);
			document.getElementById('newLpcd').value = lpcd_new_value;
			if(lpcd_new_value>0)
			{	
				//alert(lpcd_new_value+'andhra');
				if(lpcd_new_value>0 && lpcd_new_value<13.75)
				{
						calNewCoverageStatus = "PC1";
				}
				else if(lpcd_new_value>=13.75 && lpcd_new_value<27.50)
				{
						calNewCoverageStatus = "PC2";
				}
				else if(lpcd_new_value>=27.50 && lpcd_new_value<41.25)
				{
						calNewCoverageStatus = "PC3";
				}
				else if(lpcd_new_value>=41.25 && lpcd_new_value<55)
				{
						calNewCoverageStatus = "PC4";
				}
				else if(lpcd_new_value>=55)
				{
						calNewCoverageStatus = "FC";
				}
			}
			else
			{
				//alert(lpcd_new_value+'and');
				var totalSuppUnsafe = parseInt(totalWaterSupplyUnSafe);
				if(totalSuppUnsafe==0)
					calNewCoverageStatus = "NC";
				else  if(totalSuppUnsafe>0)
					calNewCoverageStatus = "NSS";
			}
			}
		document.getElementById('newCoverageStatus').value=calNewCoverageStatus;
		document.getElementById('coverageStatus').value=calCoverageStatus;	
		/*	if(document.getElementById('coverageStatus').value=='NSS'){
		document.getElementById('show').style.display='block';
		document.getElementById('show1').style.display='block';
	}else{
		document.getElementById('show').style.display='none';
		document.getElementById('show1').style.display='none';
	}
	
	 if(document.getElementById('newCoverageStatus').value=='NSS'){
		document.getElementById('show').style.display='block';
		document.getElementById('show1').style.display='block';
	}else{
		document.getElementById('show').style.display='none';
		document.getElementById('show1').style.display='none';
	} */
	}
	function pwsLinksParams(i){
		
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if(document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value!="" && document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value!="--"){
				
			if((document.forms[0].elements["pwsLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].iron"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].nitrate"].value!="--")){
			 	if(document.forms[0].elements["pwsLinks["+i+"].flouride"].value > flouridePPM || document.forms[0].elements["pwsLinks["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["pwsLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["pwsLinks["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].value=0;
			 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
			 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].readOnly=true;
			 	}
			}
			else{
				document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
		 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
			}	
			}else{
				document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].value=0;
				document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
				alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
				return false;
			}
	}
function mpwsLinksParams(i){
		
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if(document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value!="" && document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value!="--"){
				
			if((document.forms[0].elements["mpwsLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].iron"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value!="--")){
			 	if(document.forms[0].elements["mpwsLinks["+i+"].flouride"].value > flouridePPM || document.forms[0].elements["mpwsLinks["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["mpwsLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].value=0;
			 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
			 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
			}
			else{
				document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
		 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
			}	
			}else{
				document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].value=0;
				document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
				alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
				return false;
			}
	}
	
function dpLinksParams(i){
	
	var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
	var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
	var ironPPM=parseInt(document.getElementById('ironPPM').value);
	var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
		if(document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value!="" && document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value!="--"){
			
		if((document.forms[0].elements["dpLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["dpLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["dpLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].iron"].value!=0 && document.forms[0].elements["dpLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["dpLinks["+i+"].nitrate"].value!="--")){
		 	if(document.forms[0].elements["dpLinks["+i+"].flouride"].value > flouridePPM || document.forms[0].elements["dpLinks["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["dpLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["dpLinks["+i+"].nitrate"].value>nitratePPM) {
		 		document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].value=0;
		 		document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].readOnly=true;
		 	}
		 	else{
		 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
		 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].readOnly=true;
		 		alert("There is no contamination in this source");
		 		return false;
		 	}
		}
		else{
			document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
	 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].readOnly=true;
			alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
			return false;
		}	
		}else{
			document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].value=0;
			document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
			alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
			return false;
		}
}

function checkSourcePwsLink(i){
	
		if(document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value!="" && document.forms[0].elements["pwsLinks["+i+"].pwsLinksSourceCode"].value!="--"){
		}else{
			document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].value=0;
			document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
			alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
			return false;
		}
}
function checkSourceMpwsLink(i){
	
		if(document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value!="" && document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSourceCode"].value!="--"){
		}else{
			document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].value=0;
			document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
			alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
			return false;
		}	
}

function checkSourceDpLink(i){

	if(document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value!="" && document.forms[0].elements["dpLinks["+i+"].dpLinksSourceCode"].value!="--"){
	}else{
		document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].value=0;
		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
		alert("To Update safe LPD or Unsafe LPD, Please link the Source aginst to this habitation in WQty --> 4.Single Source Multiple Habitation Form");
		return false;
	}
}
	
	function pwsParams(i){
		var pws=document.getElementById('pwsCount').value;
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if((document.forms[0].elements["pws["+i+"].flouride"].value!=0 && document.forms[0].elements["pws["+i+"].flouride"].value!="--") || (document.forms[0].elements["pws["+i+"].brakish"].value!=0 && document.forms[0].elements["pws["+i+"].brakish"].value!="--") || (document.forms[0].elements["pws["+i+"].iron"].value!=0 && document.forms[0].elements["pws["+i+"].iron"].value!="--") || (document.forms[0].elements["pws["+i+"].nitrate"].value!=0 && document.forms[0].elements["pws["+i+"].nitrate"].value!="--")){
			 	if(document.forms[0].elements["pws["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["pws["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["pws["+i+"].iron"].value>ironPPM || document.forms[0].elements["pws["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["pws["+i+"].pwsSafeLPCD"].value=0;
			 		document.forms[0].elements["pws["+i+"].pwsSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value=0;
			 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
			}
			else{
				document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value=0;
		 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
			}		
	}
	function dpParams(i){
		var dp=document.getElementById('dpCount').value;
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
				if((document.forms[0].elements["dps["+i+"].flouride"].value!=0 && document.forms[0].elements["dps["+i+"].flouride"].value!="--") || (document.forms[0].elements["dps["+i+"].brakish"].value!=0 && document.forms[0].elements["dps["+i+"].brakish"].value!="--") || (document.forms[0].elements["dps["+i+"].iron"].value!=0 && document.forms[0].elements["dps["+i+"].iron"].value!="--") || (document.forms[0].elements["dps["+i+"].nitrate"].value!=0 && document.forms[0].elements["dps["+i+"].nitrate"].value!="--")){
					if(document.forms[0].elements["dps["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["dps["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["dps["+i+"].iron"].value>ironPPM || document.forms[0].elements["dps["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["dps["+i+"].othersSafeLPCD"].value=0;
				 		document.forms[0].elements["dps["+i+"].othersSafeLPCD"].readOnly=true;
				 	}
				 	else{
				 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].value=0;
				 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].readOnly=true;
				 		alert("There is no contamination in this source");
				 		return false;
				 	}
					}
				else{
					document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].value=0;
			 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].readOnly=true;
					alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
					return false;
					}				
		}
	function mpwsParams(i){
		var mpws=document.getElementById('mpwsCount').value;
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if((document.forms[0].elements["mpws["+i+"].flouride"].value!=0 && document.forms[0].elements["mpws["+i+"].flouride"].value!="--") || (document.forms[0].elements["mpws["+i+"].brakish"].value!=0 && document.forms[0].elements["mpws["+i+"].brakish"].value!="--") || (document.forms[0].elements["mpws["+i+"].iron"].value!=0 && document.forms[0].elements["mpws["+i+"].iron"].value!="--") || (document.forms[0].elements["mpws["+i+"].nitrate"].value!=0 && document.forms[0].elements["mpws["+i+"].nitrate"].value!="--")){
			 	if(document.forms[0].elements["mpws["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["mpws["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["mpws["+i+"].iron"].value>ironPPM || document.forms[0].elements["mpws["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["mpws["+i+"].mpwsSafeLPCD"].value=0;
			 		document.forms[0].elements["mpws["+i+"].mpwsSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value=0;
			 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
				}
			else{
				document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value=0;
		 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
				}			
		
	}
	function hpParams(i){
		var hp=document.getElementById('hpCount').value;
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if((document.forms[0].elements["hp["+i+"].flouride"].value!=0 && document.forms[0].elements["hp["+i+"].flouride"].value!="--") || (document.forms[0].elements["hp["+i+"].brakish"].value!=0 && document.forms[0].elements["hp["+i+"].brakish"].value!="--") || (document.forms[0].elements["hp["+i+"].iron"].value!=0 && document.forms[0].elements["hp["+i+"].iron"].value!="--") || (document.forms[0].elements["hp["+i+"].nitrate"].value!=0 && document.forms[0].elements["hp["+i+"].nitrate"].value!="--")){
				if(document.forms[0].elements["hp["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["hp["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["hp["+i+"].iron"].value>ironPPM || document.forms[0].elements["hp["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["hp["+i+"].hpSafeLPCD"].value=0;
			 		document.forms[0].elements["hp["+i+"].hpSafeLPCD"].readOnly=true;
			 		addHpValue();
			 	}
			 	else{
			 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value=0;
			 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
				}
			else{
				document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value=0;
		 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].readOnly=true;
		 		alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
				}				
	}
	function shpParams(i){
		var shp=document.getElementById('shpCount').value;
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if((document.forms[0].elements["shp["+i+"].flouride"].value!=0 && document.forms[0].elements["shp["+i+"].flouride"].value!="--") || (document.forms[0].elements["shp["+i+"].brakish"].value!=0 && document.forms[0].elements["shp["+i+"].brakish"].value!="--") || (document.forms[0].elements["shp["+i+"].iron"].value!=0 && document.forms[0].elements["shp["+i+"].iron"].value!="--") || (document.forms[0].elements["shp["+i+"].nitrate"].value!=0 && document.forms[0].elements["shp["+i+"].nitrate"].value!="--")){
				if(document.forms[0].elements["shp["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["shp["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["shp["+i+"].iron"].value>ironPPM || document.forms[0].elements["shp["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["shp["+i+"].shpSafeLPCD"].value=0;
			 		document.forms[0].elements["shp["+i+"].shpSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value=0;
			 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
				}
			else{
				document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value=0;
		 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
				}				
	}
	function othersParams(i){
	var others=document.getElementById('othersCount').value;
	var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
	var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
	var ironPPM=parseInt(document.getElementById('ironPPM').value);
	var nitratePPM=parseInt(document.getElementById('nitratePPM').value);
			if((document.forms[0].elements["others["+i+"].flouride"].value!=0 && document.forms[0].elements["others["+i+"].flouride"].value!="--") || (document.forms[0].elements["others["+i+"].brakish"].value!=0 && document.forms[0].elements["others["+i+"].brakish"].value!="--") || (document.forms[0].elements["others["+i+"].iron"].value!=0 && document.forms[0].elements["others["+i+"].iron"].value!="--") || (document.forms[0].elements["others["+i+"].nitrate"].value!=0 && document.forms[0].elements["others["+i+"].nitrate"].value!="--")){
				if(document.forms[0].elements["others["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["others["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["others["+i+"].iron"].value>ironPPM || document.forms[0].elements["others["+i+"].nitrate"].value>nitratePPM) {
			 		document.forms[0].elements["others["+i+"].othersSafeLPCD"].value=0;
			 		document.forms[0].elements["others["+i+"].othersSafeLPCD"].readOnly=true;
			 	}
			 	else{
			 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value=0;
			 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].readOnly=true;
			 		alert("There is no contamination in this source");
			 		return false;
			 	}
				}
			else{
				document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value=0;
		 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].readOnly=true;
				alert("To Update Unsafe LPD, You Must Update The Lab Testing Parameters in Water Quality For The Particular Source");
				return false;
				}				
	}
	
	function openFile(sourceno,assetcode){		  
		var url="switch.do?prefix=/masters&page=/Asset.do?mode=showCompImage&sourceid="+sourceno+"&assetCode="+assetcode;
		var width = 990;
		var height = 450;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=yes,status=yes,left=20,top=20";

		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
	 }
function wqTest(){
		
		var flouridePPM=parseFloat(document.getElementById('flouridePPM').value);
		var brakishPPM=parseInt(document.getElementById('brakishPPM').value);
		var ironPPM=parseInt(document.getElementById('ironPPM').value);
		var nitratePPM=parseInt(document.getElementById('nitratePPM').value);					
				
			var pws=document.getElementById('pwsCount').value;				
			for( var i=0;i<pws;i++)
			{		
				if((document.forms[0].elements["pws["+i+"].flouride"].value!=0 && document.forms[0].elements["pws["+i+"].flouride"].value!="--") || (document.forms[0].elements["pws["+i+"].brakish"].value!=0 && document.forms[0].elements["pws["+i+"].brakish"].value!="--") || (document.forms[0].elements["pws["+i+"].iron"].value!=0 && document.forms[0].elements["pws["+i+"].iron"].value!="--") || (document.forms[0].elements["pws["+i+"].nitrate"].value!=0 && document.forms[0].elements["pws["+i+"].nitrate"].value!="--")){
				 	if(document.forms[0].elements["pws["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["pws["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["pws["+i+"].iron"].value>ironPPM || document.forms[0].elements["pws["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["pws["+i+"].pwsSafeLPCD"].value=0;
				 		document.forms[0].elements["pws["+i+"].pwsSafeLPCD"].readOnly=true;
				 		addPwsValue();
				 	}
				 	else{
				 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value=0;
				 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].readOnly=true;
				 		addPwsValue();
				 	}
					}
				else{
					document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].value=0;
			 		document.forms[0].elements["pws["+i+"].pwsUnSafeLPCD"].readOnly=true;
			 		addPwsValue();
					}				
			}		
			var dp=document.getElementById('dpCount').value;
			for( var i=0;i<dp;i++)
			{				
					if((document.forms[0].elements["dps["+i+"].flouride"].value!=0 && document.forms[0].elements["dps["+i+"].flouride"].value!="--") || (document.forms[0].elements["dps["+i+"].brakish"].value!=0 && document.forms[0].elements["dps["+i+"].brakish"].value!="--") || (document.forms[0].elements["dps["+i+"].iron"].value!=0 && document.forms[0].elements["dps["+i+"].iron"].value!="--") || (document.forms[0].elements["dps["+i+"].nitrate"].value!=0 && document.forms[0].elements["dps["+i+"].nitrate"].value!="--")){
						if(document.forms[0].elements["dps["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["dps["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["dps["+i+"].iron"].value>ironPPM || document.forms[0].elements["dps["+i+"].nitrate"].value>nitratePPM) {
					 		document.forms[0].elements["dps["+i+"].othersSafeLPCD"].value=0;
					 		document.forms[0].elements["dps["+i+"].othersSafeLPCD"].readOnly=true;
					 		addDpValue();
					 	}
					 	else{
					 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].value=0;
					 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].readOnly=true;
					 		addDpValue();
					 	}
						}
						else{
							document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].value=0;
					 		document.forms[0].elements["dps["+i+"].othersUnSafeLPCD"].readOnly=true;
					 		addDpValue();
						}						
			}		
			var mpws=document.getElementById('mpwsCount').value;
			for( var i=0;i<mpws;i++)
			{
				if((document.forms[0].elements["mpws["+i+"].flouride"].value!=0 && document.forms[0].elements["mpws["+i+"].flouride"].value!="--") || (document.forms[0].elements["mpws["+i+"].brakish"].value!=0 && document.forms[0].elements["mpws["+i+"].brakish"].value!="--") || (document.forms[0].elements["mpws["+i+"].iron"].value!=0 && document.forms[0].elements["mpws["+i+"].iron"].value!="--") || (document.forms[0].elements["mpws["+i+"].nitrate"].value!=0 && document.forms[0].elements["mpws["+i+"].nitrate"].value!="--")){
				 	if(document.forms[0].elements["mpws["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["mpws["+i+"].brakish"].value > brakishPPM   || document.forms[0].elements["mpws["+i+"].iron"].value>ironPPM || document.forms[0].elements["mpws["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["mpws["+i+"].mpwsSafeLPCD"].value=0;
				 		document.forms[0].elements["mpws["+i+"].mpwsSafeLPCD"].readOnly=true;
				 		addMpwsValue();
				 	}
				 	else{
				 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value=0;
				 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].readOnly=true;
				 		addMpwsValue();
				 	}
					}
				else{
					document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].value=0;
			 		document.forms[0].elements["mpws["+i+"].mpwsUnSafeLPCD"].readOnly=true;
			 		addMpwsValue();
					}				
			}
			var pwsLinks=document.getElementById('pwsLinksCount').value;				
			for( var i=0;i<pwsLinks;i++)
			{		
				if((document.forms[0].elements["pwsLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].iron"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["pwsLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["pwsLinks["+i+"].nitrate"].value!="--")){
				 	if(document.forms[0].elements["pwsLinks["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["pwsLinks["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["pwsLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["pwsLinks["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].value=0;
				 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksSafeLPCD"].readOnly=true;
				 	}
				 	else{
				 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
				 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].readOnly=true;				 		
				 	}
					}
				else{
					document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].value=0;
			 		document.forms[0].elements["pwsLinks["+i+"].pwsLinksUnSafeLPCD"].readOnly=true;			 		
					}				
			}		
			var dpLinks=document.getElementById('dpLinksCount').value;
			for( var i=0;i<dpLinks;i++)
			{				
					if((document.forms[0].elements["dpLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["dpLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["dpLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].iron"].value!=0 && document.forms[0].elements["dpLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["dpLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["dpLinks["+i+"].nitrate"].value!="--")){
						if(document.forms[0].elements["dpLinks["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["dpLinks["+i+"].brakish"].value > brakishPPM  || document.forms[0].elements["dpLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["dpLinks["+i+"].nitrate"].value>nitratePPM) {
					 		document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].value=0;
					 		document.forms[0].elements["dpLinks["+i+"].dpLinksSafeLPCD"].readOnly=true;					 		
					 	}
					 	else{
					 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
					 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].readOnly=true;					 		
					 	}
						}
						else{
							document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].value=0;
					 		document.forms[0].elements["dpLinks["+i+"].dpLinksUnSafeLPCD"].readOnly=true;					 		
						}						
			}		
			var mpwsLinks=document.getElementById('mpwsLinksCount').value;
			for( var i=0;i<mpwsLinks;i++)
			{
				if((document.forms[0].elements["mpwsLinks["+i+"].flouride"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].flouride"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].brakish"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].brakish"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].iron"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].iron"].value!="--") || (document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value!=0 && document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value!="--")){
				 	if(document.forms[0].elements["mpwsLinks["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["mpwsLinks["+i+"].brakish"].value > brakishPPM   || document.forms[0].elements["mpwsLinks["+i+"].iron"].value>ironPPM || document.forms[0].elements["mpwsLinks["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].value=0;
				 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksSafeLPCD"].readOnly=true;				 		
				 	}
				 	else{
				 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
				 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].readOnly=true;				 		
				 	}
					}
				else{
					document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].value=0;
			 		document.forms[0].elements["mpwsLinks["+i+"].mpwsLinksUnSafeLPCD"].readOnly=true;			 		
					}				
			}	
			var hp=document.getElementById('hpCount').value;
			for( var i=0;i<hp;i++)
			{	
				if((document.forms[0].elements["hp["+i+"].flouride"].value!=0 && document.forms[0].elements["hp["+i+"].flouride"].value!="--") || (document.forms[0].elements["hp["+i+"].brakish"].value!=0 && document.forms[0].elements["hp["+i+"].brakish"].value!="--") || (document.forms[0].elements["hp["+i+"].iron"].value!=0 && document.forms[0].elements["hp["+i+"].iron"].value!="--") || (document.forms[0].elements["hp["+i+"].nitrate"].value!=0 && document.forms[0].elements["hp["+i+"].nitrate"].value!="--")){
					if(document.forms[0].elements["hp["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["hp["+i+"].brakish"].value > brakishPPM   || document.forms[0].elements["hp["+i+"].iron"].value>ironPPM || document.forms[0].elements["hp["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["hp["+i+"].hpSafeLPCD"].value=0;
				 		document.forms[0].elements["hp["+i+"].hpSafeLPCD"].readOnly=true;
				 		addHpValue();
				 	}
				 	else{
				 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value=0;
				 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].readOnly=true;
				 		addHpValue();
				 	}
					}
				else{
						document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].value=0;
				 		document.forms[0].elements["hp["+i+"].hpUnSafeLPCD"].readOnly=true;
				 		addHpValue();
					}			
			}		
			var shp=document.getElementById('shpCount').value;
			for( var i=0;i<shp;i++)
			{		
				if((document.forms[0].elements["shp["+i+"].flouride"].value!=0 && document.forms[0].elements["shp["+i+"].flouride"].value!="--") || (document.forms[0].elements["shp["+i+"].brakish"].value!=0 && document.forms[0].elements["shp["+i+"].brakish"].value!="--") || (document.forms[0].elements["shp["+i+"].iron"].value!=0 && document.forms[0].elements["shp["+i+"].iron"].value!="--") || (document.forms[0].elements["shp["+i+"].nitrate"].value!=0 && document.forms[0].elements["shp["+i+"].nitrate"].value!="--")){
					if(document.forms[0].elements["shp["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["shp["+i+"].brakish"].value > brakishPPM   || document.forms[0].elements["shp["+i+"].iron"].value>ironPPM || document.forms[0].elements["shp["+i+"].nitrate"].value>nitratePPM) {
				 		
						document.forms[0].elements["shp["+i+"].shpSafeLPCD"].value=0;
				 		document.forms[0].elements["shp["+i+"].shpSafeLPCD"].readOnly=true;
				 		addShpValue();
				 	}
				 	else{
				 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value=0;
				 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].readOnly=true;
				 		addShpValue();
				 	}
					}
				else{
						document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].value=0;
				 		document.forms[0].elements["shp["+i+"].shpUnSafeLPCD"].readOnly=true;
				 		addShpValue();
					}					
		}		
		var others=document.getElementById('othersCount').value;
		for( var i=0;i<others;i++)
		{
				if((document.forms[0].elements["others["+i+"].flouride"].value!=0 && document.forms[0].elements["others["+i+"].flouride"].value!="--") || (document.forms[0].elements["others["+i+"].brakish"].value!=0 && document.forms[0].elements["others["+i+"].brakish"].value!="--") || (document.forms[0].elements["others["+i+"].iron"].value!=0 && document.forms[0].elements["others["+i+"].iron"].value!="--") || (document.forms[0].elements["others["+i+"].nitrate"].value!=0 && document.forms[0].elements["others["+i+"].nitrate"].value!="--")){
					if(document.forms[0].elements["others["+i+"].flouride"].value > flouridePPM ||	 document.forms[0].elements["others["+i+"].brakish"].value > brakishPPM   || document.forms[0].elements["others["+i+"].iron"].value>ironPPM || document.forms[0].elements["others["+i+"].nitrate"].value>nitratePPM) {
				 		document.forms[0].elements["others["+i+"].othersSafeLPCD"].value=0;
				 		document.forms[0].elements["others["+i+"].othersSafeLPCD"].readOnly=true;
				 		addOthersValue();
				 	}
				 	else{
				 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value=0;
				 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].readOnly=true;
				 		addOthersValue();
				 	}
					}
				else{
					document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].value=0;
			 		document.forms[0].elements["others["+i+"].othersUnSafeLPCD"].readOnly=true;
			 		addOthersValue();
					}				
			}	
		
	}
/* function showContamination() {
document.getElementById("con_id").value="Processing...";
var str=document.getElementById("habitation").value;
var statusDt=document.getElementById("statusDate").value;
//alert(str);
  var xhttp;    
  if (str == "") {
    document.getElementById("contaminationType").innerHTML = "";
    return;
  }
  xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
    	//alert(this.responseText);
    	var res=this.responseText;
    	res = res.replace(/^\s*|\s*$/g,'');
		if(res!=null || res!="" || res.length>0){
			var st=res.split("/");
			var date=st[1];
			alert("Please update Water Quality Test Results to current financial year & One of the source is updated at "+date);
			if(st[0]!='--')
				document.getElementById("contaminationType").value=st[0];
			else
				document.getElementById("contaminationType").value="";
		}			
    	 
    	 document.getElementById("con_id").value="...";
    }
  };
  xhttp.open("GET", "masters/rws_contamination_type.jsp?habcode="+str+"&statusDate="+statusDt, true);
  xhttp.send();
} */
    </script>
    </head>
    



	<body onload="waterSuppy();addOthersValue();addDpValue();ohsrglsrrelated();">
<html:form  action="habSafeSuply.do" method="post">
	<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Coverage Status Automation Form" />
		<jsp:param name="TWidth" value="930" />
	</jsp:include>

	<table bgcolor="ffffe0" bordercolor="#8A9FCD" rules="none" width="1000"
		border=1 style="border-collapse: collapse;">					
						
		<table bgcolor="ffffe0" style="text-align: center;" width="960" bordercolor="#8A9FCD">
			<tr>
				<td>
				<fieldset><legend><b>Habitation Details</b></legend>
				<table width="960" border=0 style="border-collapse: collapse;">
				<tr>						
						<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
						<td class="btext2">District<span class="mandatory">*</span></td>
						<td class="btext2">
							<html:select property="district" style="width:140px"   onchange="functionDistrictChanged();"	 styleClass="mycombo">
								<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
								<html:options collection="districts" name="labelValueBean"  property="value" labelProperty="label" />
							</html:select>
						</td>			
						</logic:equal>			
			
				<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<td class="btext2">District<span class="mandatory">*</span></td>
				<td class="btext2">
				<html:text property="districtName" styleClass="mytext" style="width:140px"    readonly="true" />				
				<html:hidden property="district" />
				</td>
				</logic:notEqual>	
				<td class="btext2">Mandal<span class="mandatory">*</span></td>
				<td class="btext2">
					<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="functionMandalChanged()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<html:options collection="mandals1" name="labelValueBean" property="value" labelProperty="label" />
					</html:select>
				</td>
						<td class="btext2">Panchayat<span class="mandatory">*</span></td>			
						<td class="btext2">
						<html:select property="panchayat" style="width:140px"    styleClass="mycombo"  onchange="functionPanchayatChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
						</td>
						<%if(status.equals("Yes")){ %>
						<td style="text-align: right; background: transparent; border: 0; height: 25px; font-size: 16px; color: green; font-weight: bold;" rowspan="2">Last Updated On: <br/><html:text style="text-align: right; background: transparent; border: 0; float: right; height: 25px; font-size: 16px;color: green; font-weight: bold;" property="updateDate" readonly="true"/></td>
						<%} %>
						</tr><tr>
						<td class="btext2">Village<span class="mandatory">*</span></td>						
						<td class="btext2">
						<html:select property="village" style="width:140px"    styleClass="mycombo" onchange="functionVillageChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					 <html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" /> 
				</html:select>
						</td>
						<td class="btext2">Habitation<span class="mandatory">*</span></td>
				
						<td class="btext2">
						<html:select property="habitation" style="width:140px"    styleClass="mycombo" onchange="functionHabitationChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					 <html:options collection="habitations" name="labelValueBean" 
								  property="value" labelProperty="labelValue" /> 
				</html:select>
						</td>				
			</tr>
			</table>
			</fieldset>
			</td>
			</tr>
			<%if(status.equals("Yes")){ %>			
			<tr>
				<td>
				<fieldset><legend><B>Habitation Directory</B></legend>
				<table width="900" align="center" border=0 style="border-collapse: collapse;" >					  
					<logic:notEmpty name="HabSafeSuplyForm" property="reservoirs">
					<tr>
					 	<td class="btext2" align="right">House&nbsp;Holds<span class="mandatory">*</span></td>
						<td><html:text property="houseHolds" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">House&nbsp;Conn.</td>
						<td><html:text property="houseConn" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">No.&nbsp;Of&nbsp;Stand&nbsp;Posts</td>
						<td><html:text property="standPosts" size="10" onkeypress="return numeralsOnly(event)"/></td>
						<td class="btext2" align="right">Census&nbsp;Total&nbsp;Pop<span class="mandatory">*</span></td>
						<td><html:text property="totPop" size="10" readonly="true" styleClass="readonlyfield"/></td>
						</tr>
						<tr>
						<td class="btext2" align="right">OHSR&nbsp;NO</td>
						<td><html:text property="ohsrNo" size="10"  onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">OHSR(Capacity&nbsp;in&nbsp;litres)</td>
						<td><html:text property="ohsrQty" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">GLSR&nbsp;NO</td>
						<td><html:text property="glsrNo" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">GLSR(Capacity&nbsp;in&nbsp;litres)</td>
						<td><html:text property="glsrQty" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>						
						
					</tr>	
						<tr>
					<td class="btext2" align="right">Actual&nbsp;Total&nbsp;Population<span class="mandatory">*</span></td>
						<td><html:text property="actTotPop" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
					
					<td class="btext2" align="right">Actual&nbsp;Households<span class="mandatory">*</span></td>
						<td><html:text property="actHouseHold" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
					
					<td class="btext2" align="right">Actual&nbsp;House Connections<span class="mandatory">*</span></td>
						<td><html:text property="actHouseConn" size="10" onkeypress="return numeralsOnly(event)" readonly="true" styleClass="readonlyfield"/></td>
					
					</tr>					
					</logic:notEmpty>					
				</table>
				</fieldset>
				</td>
			</tr>
			<logic:notEmpty name="HabSafeSuplyForm" property="ppmValues">
					<html:hidden property="flouridePPM"/>
					<html:hidden property="ironPPM"/>
					<html:hidden property="nitratePPM"/>
					<html:hidden property="brakishPPM"/>					
			</logic:notEmpty>			
			<tr>
				<td>
				<fieldset><legend><B>CPWS Schemes (With Habitation Linkage)</B></legend>
				<%int cpwsLinksCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="cpwsLinks">
				<table width="900px" align="center" border=0 style="border-collapse: collapse;">					
					 <tr>
						<td class="btext2" align="right">Total&nbsp;Safe&nbsp;Supply</td>
						<td><html:text property="cpwsHabLinkLPCD" size="10" onkeyup="waterSuppy();" onkeypress="return numeralsOnly(event);"/>
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">					
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
					</tr>					
					<logic:iterate id="cpwsLinks" name="HabSafeSuplyForm" property="cpwsLinks" indexId="index">
					 <tr>
					  <% cpwsLinksCount++; %>
						<td align="center"><bean:write name="cpwsLinks" property="sNo" /></td>
						<td align="center"><bean:write name="cpwsLinks" property="cpwsLinksAssetCode" /></td>
						<td align="center"><bean:write name="cpwsLinks" property="cpwsLinksAssetName" /></td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="cpwsLinks" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						<html:hidden name="cpwsLinks" property="cpwsLinksAssetCode" indexed="true"/>
					</tr> 
					</logic:iterate>					
				</table>
				</logic:notEmpty>
				<br>
				<br>
				<%int cpwsLinksResCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="cpwsResLinks">
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">					
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>						
					</tr>						
					<logic:iterate id="cpwsResLinks" name="HabSafeSuplyForm" property="cpwsResLinks" indexId="index">
					 <tr>
					  <% cpwsLinksResCount++; %>
						<td align="center"><bean:write name="cpwsResLinks" property="sNo" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="cpwsLinksAssetCode" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="cpwsLinksAssetName" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="cpwsLinksSourceCode" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="cpwsLinksSourceName" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="cpwsLinksLocation" /></td>
						<td  align=center >
							<logic:equal name="cpwsResLinks"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="cpwsResLinks" property="cpwsSourceCode"/>','<bean:write name="cpwsResLinks" property="cpwsLinksAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="cpwsResLinks"  property="imageStatus"  value="Yes" >
									-
							</logic:notEqual> 
						</td>
						<td align="center"><html:text name="cpwsResLinks" property="cpwsLinksSafeLPCD" size="10" indexed="true" onkeyup="ohsrglsrrelated();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="cpwsResLinks" property="yield" /></td>
						<td align="center"><bean:write name="cpwsResLinks" property="flouride"/></td>
						<td align="center"><bean:write name="cpwsResLinks" property="brakish"/></td>
						<td align="center"><bean:write name="cpwsResLinks" property="iron"/></td>
						<td align="center"><bean:write name="cpwsResLinks" property="nitrate"/></td>
						<td align="center"><bean:write name="cpwsResLinks" property="preparedOn"/></td>
						<html:hidden name="cpwsResLinks" property="tableName" indexed="true"/>
						<html:hidden name="cpwsResLinks" property="cpwsLinksAssetCode" indexed="true"/>
						<html:hidden name="cpwsResLinks" property="cpwsLinksSourceCode" indexed="true"/>
					</tr> 
					</logic:iterate>					
				</table>				
				</logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="cpwsLinks">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="cpwsLinksCount" id="cpwsLinksCount" value="<%=cpwsLinksCount %>"/>
					<input type="hidden" name="cpwsLinksResCount" id="cpwsLinksResCount" value="<%=cpwsLinksResCount %>"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>CPWS</B></legend>
				<%int cpwsCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="cpws">
				<table width="900px" align="center" border=0 style="border-collapse: collapse;">
					
					 <tr>
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="cpwsHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">CPWS&nbsp;No</td>
						<td><html:text property="cpwsNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
						
					</tr>
					
					
					
					<logic:iterate id="cpws" name="HabSafeSuplyForm" property="cpws" indexId="index">
					 <tr>
					  <% cpwsCount++; %>
						<td align="center"><bean:write name="cpws" property="sNo" /></td>
						<td align="center"><bean:write name="cpws" property="cpwsAssetCode" /></td>
						<td align="center"><bean:write name="cpws" property="cpwsAssetName" /></td>
						<td align="center"><bean:write name="cpws" property="cpwsSourceCode" /></td>
						<td align="center"><bean:write name="cpws" property="cpwsSourceName" /></td>
						<td align="center"><bean:write name="cpws" property="cpwsLocation" /></td>
						<td  align=center >
							<logic:equal name="cpws"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="cpws" property="cpwsSourceCode"/>','<bean:write name="cpws" property="cpwsAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="cpws"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal  name="cpws" value="source" property="tableName">
						<td align="center">
						<html:select name="cpws" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="D">DEFUNCT</html:option>
						</html:select>
						</td>
						</logic:equal>
						<logic:notEqual  name="cpws" value="source" property="tableName">
						<td align="center">--</td>
						</logic:notEqual>
						<td align="center"><html:text name="cpws" property="cpwsSafeLPCD" size="10" indexed="true" onkeyup="addCpwsValue();ohsrglsrrelated();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="cpws" property="yield" /></td>
						<logic:equal  name="cpws" value="source" property="tableName">
						<td align="center">
							<html:select property="waterBeingSupplied" name="cpws" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						</logic:equal>
						<logic:notEqual  name="cpws" value="source" property="tableName">
						<td align="center">--</td>
						</logic:notEqual>
						
						<td align="center"><bean:write name="cpws" property="flouride"/></td>
						<td align="center"><bean:write name="cpws" property="brakish"/></td>
						<td align="center"><bean:write name="cpws" property="iron"/></td>
						<td align="center"><bean:write name="cpws" property="nitrate"/></td>
						<td align="center"><bean:write name="cpws" property="preparedOn"/></td>
						<html:hidden name="cpws" property="flouride"  indexed="true"/>
						<html:hidden name="cpws" property="brakish"  indexed="true"/>
						<html:hidden name="cpws" property="iron"  indexed="true"/>
						<html:hidden name="cpws" property="nitrate"  indexed="true"/>
						
					
						<html:hidden name="cpws" property="tableName" indexed="true"/>
						<html:hidden name="cpws" property="cpwsAssetCode" indexed="true"/>
						<html:hidden name="cpws" property="cpwsSourceCode" indexed="true"/>
					</tr> 
					</logic:iterate>
					
				</table></logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="cpws">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="cpwsCount" id="cpwsCount" value="<%=cpwsCount %>"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>PWS Schemes (With Habitation Linkage)</B></legend>
				<%int pwsLinksCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="pwsLinks">
				<table width="900px" align="center" border=0 style="border-collapse: collapse;">
					
					 <tr>
						<td class="btext2" align="right">Total&nbsp;Safe&nbsp;Supply</td>
						<td><html:text property="pwsHabLinkLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Total&nbsp;UnSafe&nbsp;Supply</td>
						<td><html:text property="pwsHabLinkUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
					</tr>
					
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<!-- <td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td> -->
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status</td>
						<td class="btext2" align="center">Source Type</td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr>					
					<logic:iterate id="pwsLinks" name="HabSafeSuplyForm" property="pwsLinks" indexId="index">
					<tr>
					  <%
					  String strFun = "pwsLinksParams("+pwsLinksCount+");addPwsLinksValue();";
					  String safeFun= "checkSourcePwsLink("+pwsLinksCount+");addPwsLinksValue();ohsrglsrrelated();";
					  pwsLinksCount++; 
					  %>
						<td align="center"><bean:write name="pwsLinks" property="sNo" /></td>
						<td align="center"><bean:write name="pwsLinks" property="pwsLinksAssetCode" /></td>
						<td align="center"><bean:write name="pwsLinks" property="pwsLinksAssetName" /></td>
						<td align="center"><bean:write name="pwsLinks" property="pwsLinksSourceCode" /></td>
						<td align="center"><bean:write name="pwsLinks" property="pwsLinksSourceName" /></td>
						<td align="center"><bean:write name="pwsLinks" property="pwsLinksLocation" /></td>
						<td  align=center >
							<logic:equal name="pwsLinks"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="pwsLinks" property="pwsLinksSourceCode"/>','<bean:write name="pwsLinks" property="pwsLinksAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="pwsLinks"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal  name="pwsLinks" value="source" property="tableName">
						<td align="center">
							<logic:equal name="pwsLinks" property="sourceStatus" value="W">WORKING</logic:equal>
							<logic:equal name="pwsLinks" property="sourceStatus" value="D">DEFUNCT</logic:equal>
						</td> 
						<td align="center">
							<logic:equal name="pwsLinks" property="sourceType" value="1">SUBSURFACE SOURCE</logic:equal>
							<logic:equal name="pwsLinks" property="sourceType" value="2">SURFACE SOURCE</logic:equal>
						</td>
						</logic:equal>
						<logic:notEqual  name="pwsLinks" value="source" property="tableName">
						<td align="center">-</td> 
						<td align="center">-</td>
						</logic:notEqual>
						<td align="center"><html:text name="pwsLinks" property="pwsLinksSafeLPCD" size="10" indexed="true" onkeyup="<%=safeFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="pwsLinks" property="pwsLinksUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun%>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="pwsLinks" property="yield" /></td>						
						<logic:equal  name="pwsLinks" value="source" property="tableName">			
						<td align="center">
							<html:select property="waterBeingSupplied" name="pwsLinks" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
							</logic:equal>
						<logic:notEqual  name="pwsLinks" value="source" property="tableName">
						<td align="center">-</td> 					
						</logic:notEqual>
						<td align="center"><bean:write name="pwsLinks" property="flouride"/></td>
						<td align="center"><bean:write name="pwsLinks" property="brakish"/></td>
						<td align="center"><bean:write name="pwsLinks" property="iron"/></td>
						<td align="center"><bean:write name="pwsLinks" property="nitrate"/></td>
						<td align="center"><bean:write name="pwsLinks" property="preparedOn"/></td>
					</tr> 
						<html:hidden name="pwsLinks" property="flouride"  indexed="true"/>
						<html:hidden name="pwsLinks" property="brakish"  indexed="true"/>
						<html:hidden name="pwsLinks" property="iron"  indexed="true"/>
						<html:hidden name="pwsLinks" property="nitrate"  indexed="true"/>
						
						<html:hidden name="pwsLinks" property="tableName" indexed="true"/>
						<html:hidden name="pwsLinks" property="pwsLinksAssetCode" indexed="true"/>
						<html:hidden name="pwsLinks" property="pwsLinksSourceCode" indexed="true"/>
					</logic:iterate>
					
				</table></logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="pwsLinks">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="pwsLinksCount" id="pwsLinksCount" value="<%=pwsLinksCount %>"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>PWS</B></legend>
				<%int pwsCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="pws">
				<table width="900" align="center" border=0 style="border-collapse: collapse;">				
					<tr>					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="pwsHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="pwsNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="pwsHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">UnSafe&nbsp;No</td>
						<td><html:text property="pwsUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					<tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Source Type<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
						
					</tr>
					
					<logic:iterate id="pws" name="HabSafeSuplyForm" property="pws" indexId="index">
						 <tr>
					 <% 
					 String strFun = "addPwsValue();pwsParams("+pwsCount+");";
					 
					 pwsCount++; %>
						<td align="center"><bean:write name="pws" property="sNo" /></td>
						<td align="center"><bean:write name="pws" property="pwsAssetCode" /></td>
						<td align="center"><bean:write name="pws" property="pwsAssetName" /></td>
						<td align="center"><bean:write name="pws" property="pwsSourceCode" /></td>
						<td align="center"><bean:write name="pws" property="pwsSourceName" /></td>
						<td align="center"><bean:write name="pws" property="pwsLocation" /></td>
						<td  align=center >
							<logic:equal name="pws"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="pws" property="pwsSourceCode"/>','<bean:write name="pws" property="pwsAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="pws"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal  name="pws" value="source" property="tableName">
						<td align="center">
						<html:select name="pws" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="D">DEFUNCT</html:option>
						</html:select>
						</td> 
						<td align="center">
						<html:select name="pws" property="sourceType" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="1">SUBSURFACE SOURCE</html:option>
						<html:option value="2">SURFACE SOURCE</html:option>
						</html:select>
						</td>
						 </logic:equal> 
						 <logic:notEqual  name="pws" value="source" property="tableName"> 
						 <td>--</td>
						 <td>--</td>
						 </logic:notEqual>
						<td align="center"><html:text name="pws" property="pwsSafeLPCD" size="10" indexed="true" onkeyup="addPwsValue();ohsrglsrrelated();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="pws" property="pwsUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="pws" property="yield" /></td>
						<logic:equal  name="pws" value="source" property="tableName">
						<td align="center">
							<html:select property="waterBeingSupplied" name="pws" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						</logic:equal> 
						 <logic:notEqual  name="pws" value="source" property="tableName">
						 <td align="center">--</td>
						 </logic:notEqual>
						
						
						<td align="center"><bean:write name="pws" property="flouride"/></td>
						<td align="center"><bean:write name="pws" property="brakish"/></td>
						<td align="center"><bean:write name="pws" property="iron"/></td>
						<td align="center"><bean:write name="pws" property="nitrate"/></td>
						<td align="center"><bean:write name="pws" property="preparedOn"/></td>
						<html:hidden name="pws" property="flouride"  indexed="true"/>
						<html:hidden name="pws" property="brakish"  indexed="true"/>
						<html:hidden name="pws" property="iron"  indexed="true"/>
						<html:hidden name="pws" property="nitrate"  indexed="true"/>
						
						<html:hidden name="pws" property="tableName" indexed="true"/>
						<html:hidden name="pws" property="pwsAssetCode" indexed="true"/>
						<html:hidden name="pws" property="pwsSourceCode" indexed="true"/>
					</tr> 
					</logic:iterate>
					
					
				</table></logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="pws">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
					<input type="hidden" name="pwsCount" id="pwsCount" value="<%=pwsCount %>"/>
					<html:hidden property="netPop"/>
					<html:hidden property="cYear"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>MPWS Schemes (With Habitation Linkage)</B></legend>
				<%int mpwsLinksCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="mpwsLinks">
				<table width="900px" align="center" border=0 style="border-collapse: collapse;">
					
					<tr>
						<td class="btext2" align="right">Total&nbsp;Safe&nbsp;Supply</td>
						<td><html:text property="mpwsHabLinkLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Total&nbsp;UnSafe&nbsp;Supply</td>
						<td><html:text property="mpwsHabLinkUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
					</tr>
					
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status</td>
						<td class="btext2" align="center">Source Type</td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr>					
					<logic:iterate id="mpwsLinks" name="HabSafeSuplyForm" property="mpwsLinks" indexId="index">
					<tr>
					  <%
					  String strFun = "mpwsLinksParams("+mpwsLinksCount+");addMpwsLinksValue();";
					  String safeFun= "checkSourceMpwsLink("+mpwsLinksCount+");addMpwsLinksValue();ohsrglsrrelated();";
					  mpwsLinksCount++; 
					  %>
						<td align="center"><bean:write name="mpwsLinks" property="sNo" /></td>
						<td align="center"><bean:write name="mpwsLinks" property="mpwsLinksAssetCode" /></td>
						<td align="center"><bean:write name="mpwsLinks" property="mpwsLinksAssetName" /></td>
						<td align="center"><bean:write name="mpwsLinks" property="mpwsLinksSourceCode" /></td>
						<td align="center"><bean:write name="mpwsLinks" property="mpwsLinksSourceName" /></td>
						<td align="center"><bean:write name="mpwsLinks" property="mpwsLinksLocation" /></td>
						<td  align=center >
							<logic:equal name="mpwsLinks"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="mpwsLinks" property="mpwsLinksSourceCode"/>','<bean:write name="mpwsLinks" property="mpwsLinksAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="mpwsLinks"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal  name="mpwsLinks" value="source" property="tableName">
						<td align="center">
							<logic:equal name="mpwsLinks" property="sourceStatus" value="W">WORKING</logic:equal>
							<logic:equal name="mpwsLinks" property="sourceStatus" value="D">DEFUNCT</logic:equal>
						</td> 
						<td align="center">
							<logic:equal name="mpwsLinks" property="sourceType" value="1">SUBSURFACE SOURCE</logic:equal>
							<logic:equal name="mpwsLinks" property="sourceType" value="2">SURFACE SOURCE</logic:equal>
						</td>
							</logic:equal>
						<logic:notEqual  name="mpwsLinks" value="source" property="tableName">
							<td align="center">--</td>
							<td align="center">--</td>
						</logic:notEqual>
						<td align="center"><html:text name="mpwsLinks" property="mpwsLinksSafeLPCD" size="10" indexed="true" onkeyup="<%=safeFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="mpwsLinks" property="mpwsLinksUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun%>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="mpwsLinks" property="yield" /></td>
						<logic:equal  name="mpwsLinks" value="source" property="tableName">						
						<td align="center">
							<html:select property="waterBeingSupplied" name="mpwsLinks" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
							</logic:equal>
						<logic:notEqual  name="mpwsLinks" value="source" property="tableName">
							<td align="center">--</td>					
						</logic:notEqual>
						<td align="center"><bean:write name="mpwsLinks" property="flouride"/></td>
						<td align="center"><bean:write name="mpwsLinks" property="brakish"/></td>
						<td align="center"><bean:write name="mpwsLinks" property="iron"/></td>
						<td align="center"><bean:write name="mpwsLinks" property="nitrate"/></td>
						<td align="center"><bean:write name="mpwsLinks" property="preparedOn"/></td>
					</tr> 
						<html:hidden name="mpwsLinks" property="flouride"  indexed="true"/>
						<html:hidden name="mpwsLinks" property="brakish"  indexed="true"/>
						<html:hidden name="mpwsLinks" property="iron"  indexed="true"/>
						<html:hidden name="mpwsLinks" property="nitrate"  indexed="true"/>
						
						<html:hidden name="mpwsLinks" property="tableName" indexed="true"/>
						<html:hidden name="mpwsLinks" property="mpwsLinksAssetCode" indexed="true"/>
						<html:hidden name="mpwsLinks" property="mpwsLinksSourceCode" indexed="true"/>
						
					</logic:iterate>
					</table>
				</logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="mpwsLinks">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="mpwsLinksCount" id="mpwsLinksCount" value="<%=mpwsLinksCount %>"/>
				</fieldset>
				</td>
			</tr>			
			<tr>
				<td>
				<fieldset><legend><B>MPWS</B></legend>
				<%int mpwsCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="mpws">
				<table width="900" align="center" border=0 style="border-collapse: collapse;">					
					<tr>					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="mpwsHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="mpwsNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="mpwsHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">UnSafe&nbsp;No</td>
						<td><html:text property="mpwsUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Source Type<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr> 
					
					<logic:iterate id="mpws" name="HabSafeSuplyForm" property="mpws" indexId="index">
					 <tr>
					  <% 
					  String strFun = "addMpwsValue();mpwsParams("+mpwsCount+");";
					  mpwsCount++; %>
						<td align="center"><bean:write name="mpws" property="sNo" /></td>
						<td align="center"><bean:write name="mpws" property="mpwsAssetCode" /></td>
						<td align="center"><bean:write name="mpws" property="mpwsAssetName" /></td>
						<td align="center"><bean:write name="mpws" property="mpwsSourceCode" /></td>
						<td align="center"><bean:write name="mpws" property="mpwsSourceName" /></td>
						<td align="center"><bean:write name="mpws" property="mpwsLocation" /></td>
						<td  align=center >
							<logic:equal name="mpws"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="mpws" property="mpwsSourceCode"/>','<bean:write name="mpws" property="mpwsAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="mpws"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal  name="mpws" value="source" property="tableName"> 
						<td align="center">
						<html:select name="mpws" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="N">NOT WORKING</html:option>
						<html:option value="D">DRIED</html:option>
						<html:option value="S">SEASONAL</html:option>
						<html:option value="C">CONDEMED</html:option>
						</html:select>
						</td>
						<td align="center">
						<html:select name="mpws" property="sourceType" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="1">SUBSURFACE SOURCE</html:option>
						<html:option value="2">SURFACE SOURCE</html:option>
						</html:select>
						</td>
						 </logic:equal> 
						 <logic:notEqual  name="mpws" value="source" property="tableName"> 
						 <td>--</td>
						 <td>--</td>
						 </logic:notEqual>
						<td align="center"><html:text name="mpws" property="mpwsSafeLPCD" size="10" indexed="true" onkeyup="addMpwsValue();ohsrglsrrelated();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="mpws" property="mpwsUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="mpws" property="yield" /></td>
						<logic:equal  name="mpws" value="source" property="tableName"> 
						<td align="center">
							<html:select property="waterBeingSupplied" name="mpws" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						</logic:equal> 
						 <logic:notEqual  name="mpws" value="source" property="tableName"> 
						 <td align="center">--</td>
						 </logic:notEqual>
						
						<td align="center"><bean:write name="mpws" property="flouride"/></td>
						<td align="center"><bean:write name="mpws" property="brakish"/></td>
						<td align="center"><bean:write name="mpws" property="iron"/></td>
						<td align="center"><bean:write name="mpws" property="nitrate"/></td>
						<td align="center"><bean:write name="mpws" property="preparedOn"/></td>
						<html:hidden name="mpws" property="flouride"  indexed="true"/>
						<html:hidden name="mpws" property="brakish"  indexed="true"/>
						<html:hidden name="mpws" property="iron"  indexed="true"/>
						<html:hidden name="mpws" property="nitrate"  indexed="true"/>
						
						<html:hidden name="mpws" property="tableName" indexed="true"/>
						<html:hidden name="mpws" property="mpwsAssetCode" indexed="true"/>
						<html:hidden name="mpws" property="mpwsSourceCode" indexed="true"/>
					</tr> 
					</logic:iterate>
					
					</table>
					</logic:notEmpty>
					
				
				<logic:empty name="HabSafeSuplyForm" property="mpws">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
					<input type="hidden" name="mpwsCount" id="mpwsCount" value="<%=mpwsCount %>"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>DP Schemes (With Habitation Linkage)</B></legend>
				<%int dpLinksCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="dpLinks">
				<table width="900px" align="center" border=0 style="border-collapse: collapse;">
					
					<tr>
						<td class="btext2" align="right">Total&nbsp;Safe&nbsp;Supply</td>
						<td><html:text property="dpHabLinkLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Total&nbsp;UnSafe&nbsp;Supply</td>
						<td><html:text property="dpHabLinkUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
					</tr>
					
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status</td>
						<td class="btext2" align="center">Source Type</td>
						<td class="btext2" align="center">Safe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)/Capacity</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr>					
					<logic:iterate id="dpLinks" name="HabSafeSuplyForm" property="dpLinks" indexId="index">
					<tr>
					  <%
					  String strFun = "dpLinksParams("+dpLinksCount+");addDpLinksValue();";
					  String safeFun= "checkSourceDpLink("+mpwsLinksCount+");addDpLinksValue();";
					  dpLinksCount++; 
					  %>
						<td align="center"><bean:write name="dpLinks" property="sNo" /></td>
						<td align="center"><bean:write name="dpLinks" property="dpLinksAssetCode" /></td>
						<td align="center"><bean:write name="dpLinks" property="dpLinksAssetName" /></td>
						<td align="center"><bean:write name="dpLinks" property="dpLinksSourceCode" /></td>
						<td align="center"><bean:write name="dpLinks" property="dpLinksSourceName" /></td>
						<td align="center"><bean:write name="dpLinks" property="dpLinksLocation" /></td>
						<td  align=center >
							<logic:equal name="dpLinks"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="dpLinks" property="dpLinksSourceCode"/>','<bean:write name="dpLinks" property="dpLinksAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="dpLinks"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<td align="center">
							<logic:equal name="dpLinks" property="sourceStatus" value="W">WORKING</logic:equal>
							<logic:equal name="dpLinks" property="sourceStatus" value="D">DEFUNCT</logic:equal>
						</td> 
						<td align="center">
							<logic:equal name="dpLinks" property="sourceType" value="1">SUBSURFACE SOURCE</logic:equal>
							<logic:equal name="dpLinks" property="sourceType" value="2">SURFACE SOURCE</logic:equal>
						</td>
						<td align="center"><html:text name="dpLinks" property="dpLinksSafeLPCD" size="10" indexed="true" onkeyup="<%=safeFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="dpLinks" property="dpLinksUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun%>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="dpLinks" property="yield" /></td>						
						<td align="center">
							<html:select property="waterBeingSupplied" name="dpLinks" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>						
						<td align="center"><bean:write name="dpLinks" property="flouride"/></td>
						<td align="center"><bean:write name="dpLinks" property="brakish"/></td>
						<td align="center"><bean:write name="dpLinks" property="iron"/></td>
						<td align="center"><bean:write name="dpLinks" property="nitrate"/></td>
						<td align="center"><bean:write name="dpLinks" property="preparedOn"/></td>
					</tr> 
						<html:hidden name="dpLinks" property="flouride"  indexed="true"/>
						<html:hidden name="dpLinks" property="brakish"  indexed="true"/>
						<html:hidden name="dpLinks" property="iron"  indexed="true"/>
						<html:hidden name="dpLinks" property="nitrate"  indexed="true"/>
						
						<html:hidden name="dpLinks" property="tableName" indexed="true"/>
						<html:hidden name="dpLinks" property="dpLinksAssetCode" indexed="true"/>
						<html:hidden name="dpLinks" property="dpLinksSourceCode" indexed="true"/>
					</logic:iterate>					
				</table>
				</logic:notEmpty>
				<logic:empty name="HabSafeSuplyForm" property="dpLinks">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="dpLinksCount" id="dpLinksCount" value="<%=dpLinksCount %>"/>
				</fieldset>
				</td>
			</tr>
			
			
			
			<tr>
				<td>
				<fieldset><legend><B>Direct Pumping</B></legend>
				<%int dpsCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="dps">
				
				<table width="900" align="center" border=0 style="border-collapse: collapse;">
					<tr>
					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="dpHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="dpSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="dpHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">UnSafe&nbsp;No</td>
						<td><html:text property="dpUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Source Type<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr> 
					
					<logic:iterate id="dps" name="HabSafeSuplyForm" property="dps" indexId="index">
					 <tr>
					  <% 
					  String strFun = "addDpValue();dpParams("+dpsCount+");";
					  dpsCount++; %>
						<td align="center"><font size="1"><bean:write name="dps" property="sNo" /></font></td>
						<td align="center"><bean:write name="dps" property="othersAssetCode" /></td>
						<td align="center"><bean:write name="dps" property="othersAssetName" /></td>
						<td align="center"><bean:write name="dps" property="othersSourceCode" /></td>
						<td align="center"><bean:write name="dps" property="othersSourceName" /></td>
						<td align="center"><bean:write name="dps" property="othersLocation" /></td>
						<td  align=center >
							<logic:equal name="dps"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="dps" property="othersSourceCode"/>','<bean:write name="dps" property="othersAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="dps"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<td align="center">
						<html:select name="dps" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="N">NOT WORKING</html:option>
						<html:option value="D">DRIED</html:option>
						<html:option value="S">SEASONAL</html:option>
						<html:option value="C">CONDEMED</html:option>
						</html:select>
						</td>
						<td align="center">
							<html:select name="dps" property="sourceType" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">Select</html:option>
								<html:option value="1">SUBSURFACE SOURCE</html:option>
								<html:option value="2">SURFACE SOURCE</html:option>
							</html:select>
						</td>
						<td align="center"><html:text name="dps" property="othersSafeLPCD" size="10" indexed="true" onkeyup="addDpValue();ohsrglsrrelated();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="dps" property="othersUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="dps" property="yield" /></td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="dps" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>						
						<td align="center"><bean:write name="dps" property="flouride"/></td>
						<td align="center"><bean:write name="dps" property="brakish"/></td>
						<td align="center"><bean:write name="dps" property="iron"/></td>
						<td align="center"><bean:write name="dps" property="nitrate"/></td>
						<td align="center"><bean:write name="dps" property="preparedOn"/></td>
						<html:hidden name="dps" property="flouride"  indexed="true"/>
						<html:hidden name="dps" property="brakish"  indexed="true"/>
						<html:hidden name="dps" property="iron"  indexed="true"/>
						<html:hidden name="dps" property="nitrate"  indexed="true"/>
						
						<html:hidden name="dps" property="tableName"  indexed="true"/>
						<html:hidden name="dps" property="othersAssetCode"  indexed="true"/>
						<html:hidden name="dps" property="othersSourceCode"  indexed="true"/>
					</tr> 
					</logic:iterate>					
					</table>					
					</logic:notEmpty>
					<% String strFunOgGl = "ohsrglsrrelated();";
					%>
				
				<logic:empty name="HabSafeSuplyForm" property="dps">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
					<input type="hidden" name="dpCount" id="dpCount" value="<%=dpsCount %>"/>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<fieldset><legend><B>Hand&nbsp;Pumps</B></legend>
				<%int hpCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="hp">
				<table width="900" align="center" border=0 style="border-collapse: collapse;">
					
					
					
					<tr>
					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="hpHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="hpNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="hpHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">UnSafe&nbsp;No</td>
						<td><html:text property="hpUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">PlatForm Existing<span class="mandatory">*</span></td>
						<td class="btext2" align="center">SAOK PITS<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr> 
					
					<logic:iterate id="hp" name="HabSafeSuplyForm" property="hp" indexId="index">
					 <tr>
					 <%
					 String strFun = "addHpValue();hpParams("+hpCount+");";
					 hpCount++; %>
						<td align="center"><bean:write name="hp" property="sNo"/></td>
						<td align="center"><bean:write name="hp" property="hpAssetCode"/></td>
						<td align="center"><bean:write name="hp" property="hpAssetName" /></td>
						<td align="center"><bean:write name="hp" property="hpSourceCode"/></td>
						<td align="center"><bean:write name="hp" property="hpLocation"/></td>
						<td  align=center >
							<logic:equal name="hp"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="hp" property="hpSourceCode"/>','<bean:write name="hp" property="hpAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="hp"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<td align="center">
						<html:select name="hp" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="N">NOT WORKING</html:option>
						<html:option value="D">DRIED</html:option>
						<html:option value="S">SEASONAL</html:option>
						<html:option value="C">CONDEMED</html:option>
						</html:select>
						</td>
						<td align="center"><html:text name="hp" property="hpSafeLPCD" size="10" indexed="true" onkeyup="addHpValue();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="hp" property="hpUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event);" /></td>
						<td align="center"><bean:write name="hp" property="yield" /></td>
						<td align="center">
						
						<html:select name="hp" property="platformExisting" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
						<html:select name="hp" property="soakPit" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="hp" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						
						<td align="center"><bean:write name="hp" property="flouride"/></td>
						<td align="center"><bean:write name="hp" property="brakish"/></td>
						<td align="center"><bean:write name="hp" property="iron"/></td>
						<td align="center"><bean:write name="hp" property="nitrate"/></td>
						<td align="center"><bean:write name="hp" property="preparedOn"/></td>
						<html:hidden name="hp" property="flouride"  indexed="true"/>
						<html:hidden name="hp" property="brakish"  indexed="true"/>
						<html:hidden name="hp" property="iron"  indexed="true"/>
						<html:hidden name="hp" property="nitrate"  indexed="true"/>
						
						<html:hidden name="hp" property="tableName" indexed="true"/>
						<html:hidden name="hp" property="hpAssetCode" indexed="true"/>
						<html:hidden name="hp" property="hpSourceCode" indexed="true"/>
					</tr> 
					</logic:iterate>
					
					</table>
					</logic:notEmpty>
					<logic:empty name="HabSafeSuplyForm" property="hp">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
				<input type="hidden" name="hpCount" id="hpCount" value="<%=hpCount %>"/>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<fieldset><legend><B>Shallow Hand Pumps</B></legend>
				<%int shpCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="shp">
				<table width="900" align="center" border=0 style="border-collapse: collapse;">
					<tr>
					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="shpHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="shpNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="shpHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Unsafe&nbsp;No</td>
						<td><html:text property="shpUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">PlatForm Existing<span class="mandatory">*</span></td>
						<td class="btext2" align="center">SAOK PITS<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr> 
					
					<logic:iterate id="shp" name="HabSafeSuplyForm" property="shp" indexId="index">
					 <tr>
					 <% 
					 String strFun = "addShpValue();shpParams("+shpCount+");";
					 shpCount++; %>
						<td align="center"><bean:write name="shp" property="sNo"/></td>
						<td align="center"><bean:write name="shp" property="shpAssetCode" /></td>
						<td align="center"><bean:write name="shp" property="shpAssetName" /></td>
						<td align="center"><bean:write name="shp" property="shpSourceCode"/></td>
						<td align="center"><bean:write name="shp" property="shpLocation"/></td>
						<td  align=center >
							<logic:equal name="shp"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="shp" property="shpSourceCode"/>','<bean:write name="shp" property="shpAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="shp"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<td align="center">
						<html:select name="shp" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="N">NOT WORKING</html:option>
						<html:option value="D">DRIED</html:option>
						<html:option value="S">SEASONAL</html:option>
						<html:option value="C">CONDEMED</html:option>
						</html:select>
						</td>
						<td align="center"><html:text name="shp" property="shpSafeLPCD" size="10" indexed="true" onkeyup="addShpValue();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="shp" property="shpUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><bean:write name="shp" property="yield" /></td>
						<td align="center">
						<html:select name="shp" property="platformExisting" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
						<html:select name="shp" property="soakPit" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="shp" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						
						<td align="center"><bean:write name="shp" property="flouride"/></td>
						<td align="center"><bean:write name="shp" property="brakish"/></td>
						<td align="center"><bean:write name="shp" property="iron"/></td>
						<td align="center"><bean:write name="shp" property="nitrate"/></td>
						<td align="center"><bean:write name="shp" property="preparedOn"/></td>
						<html:hidden name="shp" property="flouride"  indexed="true"/>
						<html:hidden name="shp" property="brakish"  indexed="true"/>
						<html:hidden name="shp" property="iron"  indexed="true"/>
						<html:hidden name="shp" property="nitrate"  indexed="true"/>
						
						<html:hidden name="shp" property="tableName" indexed="true"/>
						<html:hidden name="shp" property="shpAssetCode" indexed="true"/>
						<html:hidden name="shp" property="shpSourceCode" indexed="true"/>
				</tr> 
				</logic:iterate>
				
				</table>
				</logic:notEmpty>
					
				
				<logic:empty name="HabSafeSuplyForm" property="shp">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
					<input type="hidden" name="shpCount" id="shpCount" value="<%=shpCount %>"/>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<fieldset><legend><B>Others(Open Well & Others)</B></legend>
				<%int othersCount=0; %>
				<logic:notEmpty name="HabSafeSuplyForm" property="others">
				
				<table width="900" align="center" border=0 style="border-collapse: collapse;">
					<tr>
					 
						<td class="btext2" align="right">Safe&nbsp;Supply</td>
						<td><html:text property="othersHabLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">Safe&nbsp;No</td>
						<td><html:text property="othersNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						<td class="btext2" align="right">UnSafe&nbsp;Supply</td>
						<td><html:text property="othersHabUnsafeLPCD" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="right">UnSafe&nbsp;No</td>
						<td><html:text property="othersUnSafeNo" size="10" readonly="true" styleClass="readonlyfield"/></td>
						
					</tr>
					</table>
					<table width="900" align="center" border=1 style="border: 1px solid #000000; border-collapse: collapse;">
					 <tr>
						<td class="btext2" align="center">S.NO</td>
						<td class="btext2" align="center">Asset Code</td>
						<td class="btext2" align="center">Asset Name</td>
						<td class="btext2" align="center">Source Code</td>
						<td class="btext2" align="center">Source Type/<br>Source Name</td>
						<td class="btext2" align="center">Location</td>
						<td class="btext2" align="center">Image</td>
						<td class="btext2" align="center">Status<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Safe Supply(LPD)</td>
						<td class="btext2" align="center">UnSafe Supply(LPD)</td>
						<td class="btext2" align="center">Yield(LPM)</td>
						<td class="btext2" align="center">PlatForm Existing<span class="mandatory">*</span></td>
						<td class="btext2" align="center">SAOK PITS<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Water Being Supplied<span class="mandatory">*</span></td>
						<td class="btext2" align="center">Flouride</td>
						<td class="btext2" align="center">Brakish</td>
						<td class="btext2" align="center">Iron</td>
						<td class="btext2" align="center">Nitrate</td>
						<td class="btext2" align="center">Test Date</td>
					</tr> 
					
					<logic:iterate id="others" name="HabSafeSuplyForm" property="others" indexId="index">
					 <tr>
					  <% 
					   String strFun = "addOthersValue();othersParams("+othersCount+");";
					  othersCount++; %>
						<td align="center"><font size="1"><bean:write name="others" property="sNo" /></font></td>
						<td align="center"><bean:write name="others" property="othersAssetCode" /></td>
						<td align="center"><bean:write name="others" property="othersAssetName" /></td>
						<td align="center"><bean:write name="others" property="othersSourceCode" /></td>
						<logic:equal value="spring" name="others" property="tableName" >
						<td align="center"><bean:write name="others" property="othersSourceName" /></td>
						</logic:equal>
						<logic:equal value="ow" name="others" property="tableName" >
						<td align="center"><bean:write name="others" property="othersSourceName" /></td>
						</logic:equal>
						<td align="center"><bean:write name="others" property="othersLocation" /></td>
						<td  align=center >
							<logic:equal name="others"  property="imageStatus"  value="Yes" >
								<a href="#" onclick="openFile('<bean:write name="others" property="othersSourceCode"/>','<bean:write name="others" property="othersAssetCode" />')">View</a>&nbsp;
							</logic:equal> 
							<logic:notEqual name="others"  property="imageStatus"  value="Yes" >
									--
							</logic:notEqual> 
						</td>
						<logic:equal value="ow" name="others" property="tableName" >
						<td align="center">
						<html:select name="others" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="W">WORKING</html:option>
						<html:option value="N">NOT WORKING</html:option>
						<html:option value="D">DRIED</html:option>
						<html:option value="S">SEASONAL</html:option>
						<html:option value="C">CONDEMED</html:option>
						</html:select>
						</td>
						<td align="center"><html:text name="others" property="othersSafeLPCD" size="10" indexed="true" onkeyup="addOthersValue();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center"><html:text name="others" property="othersUnSafeLPCD" size="10" indexed="true" onkeyup="<%=strFun %>" onkeypress="return numeralsOnly(event)"/></td>
						
						<td align="center"><bean:write name="others" property="yield" /></td>
						<td align="center">
						<html:select name="others" property="platformExisting" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
						<html:select name="others" property="soakPit" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
						</html:select>
						</td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="others" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						
						
						<td align="center"><bean:write name="others" property="flouride"/></td>
						<td align="center"><bean:write name="others" property="brakish"/></td>
						<td align="center"><bean:write name="others" property="iron"/></td>
						<td align="center"><bean:write name="others" property="nitrate"/></td>
						<td align="center"><bean:write name="others" property="preparedOn"/></td>
						<html:hidden name="others" property="flouride"  indexed="true"/>
						<html:hidden name="others" property="brakish"  indexed="true"/>
						<html:hidden name="others" property="iron"  indexed="true"/>
						<html:hidden name="others" property="nitrate"  indexed="true"/>
						</logic:equal>
						
						<logic:equal value="spring" name="others" property="tableName" >
						<td align="center">
						<html:select name="others" property="sourceStatus" style="width:100px" styleClass="mycombo" indexed="true">
						<html:option value="">Select</html:option>
						<html:option value="1">WORKING</html:option>
						<html:option value="2">NOT WORKING</html:option>
						</html:select>
						</td>
						<td align="center"><html:text name="others" property="othersSafeLPCD" size="10" indexed="true" onkeyup="addOthersValue();" onkeypress="return numeralsOnly(event)"/></td>
						<td align="center">--</td>
						
						<td align="center"><bean:write name="others" property="yield" /></td>
						
						<td align="center">--</td>
						<td align="center">--</td>
						<td align="center">
							<html:select property="waterBeingSupplied" name="others" style="width:100px" styleClass="mycombo" indexed="true">
								<html:option value="">SELECT...</html:option>
								<html:option value="Daily">Daily</html:option>
								<html:option value="Alternate Days">Alternate Days</html:option>
								<html:option value="Weekly">Weekly</html:option>
								<html:option value="Not Supplying">Not Supplying</html:option>
							</html:select>
						</td>
						<td align="center">--</td>
						<td align="center">--</td>
						<td align="center">--</td>
						<td align="center">--</td>
						<td align="center">--</td>
						</logic:equal>
						
						<html:hidden name="others" property="tableName"  indexed="true"/>
						<html:hidden name="others" property="othersAssetCode"  indexed="true"/>
						<html:hidden name="others" property="othersSourceCode"  indexed="true"/>
				</tr> 
					</logic:iterate>
					
					</table>
					
					</logic:notEmpty>
					
				
				<logic:empty name="HabSafeSuplyForm" property="others">
					<h5 style="text-align: center; margin: 0px">No Records Found</h5>
					</logic:empty>
					<input type="hidden" name="othersCount" id="othersCount" value="<%=othersCount %>"/>
				</fieldset>
				</td>
			</tr>
			
				<tr>
				<td>
				<fieldset><legend><B>Water Supply</B></legend>
				
				<table width="900" align="center" border=0 style="border-collapse: collapse;">
					<tr>
						<td class="btext2" align="left">Total Water Supply</td>
						<td><html:text property="totalWaterSupply" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="left">Level Of Water Supply(LPCD)</td>
						<td><html:text property="levelOfWaterSupplyLPCD" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					<tr>
						<td class="btext2" align="left">Total Water Supply(Safe Source)</td>
						<td><html:text property="totalWaterSupplySafeSource" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="left">Level Of Water Supply(Safe Source)</td>
						<td><html:text property="levelOfWaterSupplySafeSource" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					<tr>
						<td class="btext2" align="left">Total Water Supply(UnSafe Source)</td>
						<td><html:text property="totalWaterSupplyUnSafeSource" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="left">Level Of Water Supply(UnSafe Source)</td>
						<td><html:text property="levelOfWaterSupplyUnSafeSource" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					<tr>
						<td class="btext2" align="left">Total Water Supply(Safe+UnSafe)</td>
						<td><html:text property="totalWaterSupplySafeUnSafe" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="left">Level Of Water Supply(Safe+UnSafe)</td>
						<td><html:text property="levelOfWaterSupplySafeUnSafe" size="10" readonly="true" styleClass="readonlyfield"/></td>
					</tr>
					<tr>
						<td class="btext2" align="left">Coverage Status</td>
						<td><html:text property="coverageStatus" size="10" readonly="true" styleClass="readonlyfield"/>
						<%-- <td class="btext2" align="left">Previous Year LPCD</td>
						<td><html:text property="previousYearLPCD" size="10" readonly="true" styleClass="readonlyfield"/> --%>
						</tr>
					
					<tr>
						<td class="btext2" align="left">Coverage Status as on 01/04/<%=year %></td>
						<td><html:text property="newCoverageStatus" size="10" readonly="true" styleClass="readonlyfield"/>
						<td class="btext2" align="left">Safe LPCD as on 01/04/<%=year %></td>
						<td><html:text property="newLpcd" size="10" readonly="true" styleClass="readonlyfield"/>
						
						<%-- <td class="btext2" align="left">Previous Year LPCD</td>
						<td><html:text property="previousYearLPCD" size="10" readonly="true" styleClass="readonlyfield"/> --%>
						<%-- <td class="btext2" align="left"><div id="show" style="display:none;">Contamination Type</div></td>
						<td>
						<div id="show1" style="display:none;"><input class="btext2" type="button" onclick="showContamination()" id="con_id"
							value="..."  onmouseover="Tip('Click here to get Contamination Type',TITLE,'')" onmouseout="UnTip()"> &nbsp;&nbsp;<html:text property="contaminationType" size="10" readonly="true" styleClass="readonlyfield"/></div>
						</td> --%>	
						<html:hidden property="previousCS"/>
						<html:hidden property="statusDate"/>
						
					</tr>
					</table>
					<script >
					window.onload = ohsrglsrrelated;
					//window.onload=wqTest;
					</script>
				</fieldset>
				</td>
			</tr>	
					
						<tr>
						<td align="center" ><input class="btext2" type="button" onclick="fnSave()"
							value="Update" ></input></td>
							
					</tr>
					<tr>
					<td align="center" ><input class="btext2" type="button" onclick="fnSavePS()"
							value="Update Platforms & Soakpits" ></input></td>
					</tr> 
					<tr>
					<td>
					<font color="green" size="2">Note:</font>
					
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">1.This form automates the coverage status generation process </font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">2.House holds and total population Should not be Zero and House Connections should not be greater than House Holds </font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">3. Habitation Directory 'update '  will update only the habitation directory details</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">4. Habitation wise source details  are displayed viz  pws,cpws,mpws,handpumps,shallow handpumps and others(Direct Pumping and Open Wells)</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">5. HP's, SHP's and Others Unsafe Supply > 50 % then treated as unsafe source if and only if PWS's, MPWS's, CPWS's and DP's Safe Supply is Zero</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">6. Unsafe LPD is dependent on lab tests. No values in these columns indicate either safe source or lab results not updated</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">7. Safe Supply is auto generated(sum of safe lpd) scheme wise</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">8. Reservoirs(OHSR and GLSR) capacity will not be included in Safe Supply</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">9. * fields are Mandatory and shaded fields are non editable</font>
					
					</td>
					</tr>
				
			<%} %>
	</table>

		
		
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="930" />
		</jsp:include>

		

		<%@ include file="/commons/rws_footer.jsp"%>
	</table>
	
</html:form>
<script>
	waterSuppy();
    </script>
</body>
<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>
