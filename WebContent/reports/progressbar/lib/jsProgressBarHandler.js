   var tname=new Array();
     var index = 0;
	 tname[0]="District_tbl";
	 tname[1]="Mandal_tbl";
	 tname[2]="Panchayat_tbl";
	 tname[3]="Village_tbl"; 
	 tname[4]="Panchayat Raj_tbl";
	 tname[5]="Works- Admin Sanction Table";
	 tname[6]="Works-Admin Hab Link Table";
	
	 tname[7]="Works-Admin Hab Link Table";
	 tname[8]="Works-Admin Hab Link Table";
	
	 tname[9]="Source Identification tbl";
	 tname[10]="Circle Office tbl"; 
	 tname[11]="Division Office tbl";
	 tname[12]="Sub Division Office tbl";
	 tname[13]="Assets - Asset Type Table";
	 tname[14]="Assets - Asset Hab Table";
	 tname[15]="Assets - Asset Master Table";
	 tname[16]="Assets - Handpumps Table";
	 tname[17]="Assets Source Type Table";
	 tname[18]="Assets Sub Source Type Table";
	 tname[19]="Assets Source Table ";
	 tname[20]="Assets RawWater Collection Well Table"; 
	 tname[21]="Assets SSTank Table ";
   
	 tname[22]="Assets SSTank Table ";
     tname[23]="Assets SSTank Table ";

	 tname[24]="Assets Filters Table";
	 tname[25]="Assets Sump Table ";
	 tname[26]="Assets Foot path Bridge Table";

	 tname[27]="Assets Foot path Bridge Table";
	 tname[28]="Assets Foot path Bridge Table";

	 tname[29]="Assets PumpHouse Table"; 
	 tname[30]="Assets Watchman Quarter Table ";
	 tname[31]="Assets Clear Water Collection Well Table ";
	 tname[32]="Assets PumpingMain Table ";
	 tname[33]="Assets Gravity Main Table ";
	 tname[34]="Assets Distribution Table "; 

	 tname[35]="Assets Bpt Table ";
	 tname[36]="Assets Bpt Table ";

	 tname[37]="Assets GLBR Table";
	 tname[38]="Assets GLSR Table";
	 tname[39]="Assets OHBR Table ";
	 tname[40]="Assets OHSR Table"; 
	 tname[41]="Assets Cisterns Table";
	 tname[42]="Assets Chlorination Table";
	 tname[43]="Assets OandM Table ";
	 tname[44]="Assets Pumpsets Table ";
	 tname[45]="Assets Open Well Master Table"; 
	 tname[46]="Assets Open Well Table ";
	 tname[47]="Assets Shallow Handpumps Table";

	 tname[48]="Assets Shallow Handpumps Table";
	 tname[49]="Assets Shallow Handpumps Table";

	
	
	 
	 if (!JS_BRAMUS) { var JS_BRAMUS = new Object(); }

	JS_BRAMUS.jsProgressBarHandler = Class.create();
	
	JS_BRAMUS.jsProgressBarHandler.prototype = {
	
		imageWidth			: 240,
		pbArray				: new Object(),
	
		initialize			: function() {
			
			this.initialPos		= (this.imageWidth / 2) * (-1);
			this.pxPerPercent	= (this.imageWidth / 2) / 100;
			
			$$('span.progressBar').each(function(progressBar) {
				this.buildProgressBar(progressBar);  
			}.bind(this));
			
		},
		
		buildProgressBar	: function(progressBar) {
			var percentage 		= parseInt(progressBar.innerHTML.replace("%",""));
			//alert(percentage);
			var id				= progressBar.id;
			//alert('<img id="' + id + '_percentImage" src="images/percentImage.png" alt="0%" style="background-position: 0px 0px;"/> <span id="' + id + '_percentText">0%</span>');
			progressBar.update('<img id="' + id + '_percentImage" src="progressbar/images/percentImage.png" alt="0%" style="background-position: 0px 0px;"/> <span id="' + id + '_percentText">0%</span>');
			
			this.setPercentage(id, percentage);
		},
		
		setPercentage		: function(id, percentage) {
		if(document.getElementById('demo').style.display=='block'){
			var prevPercentage	= (this.pbArray[id] || 0);
			
			if ((percentage.toString().substring(0,1) == "+") || (percentage.toString().substring(0,1) == "-")) {
				percentage	= prevPercentage + parseInt(percentage);
			}
			
			if (percentage < 0)		percentage = 0;
			if (percentage > 100)	percentage = 100;
			
			if (percentage != prevPercentage) {					
				if (prevPercentage < percentage) {
					prevPercentage++;	
				} else {
					prevPercentage--;	
				}			
			}
			
			this.pbArray[id]	= prevPercentage;
			
			$(id + "_percentImage").style.backgroundPosition 	= "" + (this.initialPos + (prevPercentage * this.pxPerPercent)) + "px 0px";
			$(id + "_percentImage").alt 						= "" + prevPercentage + "%";
			$(id + "_percentImage").title 						= "" + prevPercentage + "%";
			
			$(id + "_percentText").update("" + prevPercentage + "%");
		  //alert(percentage);
           	  
			    if (percentage != prevPercentage) {
					
				setTimeout("myJsProgressBarHandler.setPercentage('" + id + "','" + percentage + "')", 100);
				if(prevPercentage%2>0)
				document.getElementById('elementValue').innerHTML= tname[index++];
				if(prevPercentage==99){
//					alert("complete");
					document.getElementById('demo2').style.display='block';
					document.getElementById("s").disabled = false;

				}
				 //alert("my"+prevPercentage);
				 
			//alert(percentage);
			}
			//alert("aaaaaaaaaaa");
		}
		else
			{
			setTimeout("myJsProgressBarHandler.setPercentage('" + id + "','" + percentage + "')", 100);
			}
		},
		
		getPercentage		: function(id) {
			return this.pbArray[id];	
		}
		
	}
	

	function initProgressBarHandler() { myJsProgressBarHandler = new JS_BRAMUS.jsProgressBarHandler(); }
	Event.observe(window, 'load', initProgressBarHandler, false);
