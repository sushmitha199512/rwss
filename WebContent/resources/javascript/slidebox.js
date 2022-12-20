var USER = new getUserInfo();

function getUserInfo() {
  var USER         = new Object();
  this.value_enc   = getCookieData("ORA_UCM_INFO");
  this.array       = this.value_enc.split("~");
  USER.version      = this.array[0];
  USER.guid         = this.array[1];
  USER.firstname    = this.array[2];
  USER.lastname     = this.array[3];
  USER.username     = this.array[4];
  USER.country      = this.array[5];
  USER.language     = this.array[6];
  USER.interest1    = this.array[7];
  USER.interest2    = this.array[8];
  USER.interest3    = this.array[9];
  USER.interest4    = this.array[10];
  USER.ascii        = this.array[11];	
  USER.email        = this.username;
  USER.companyname  = null;
  USER.title        = null;
  USER.characterset = null;
  USER.interest5    = null;
  return USER;
}


function sso_sign_out() 
{ 
    //rUrl = window.location.href; 
    
    rUrl = escape(window.location.href); 
		
	if (    ( rUrl.indexOf('http://oraclepartnernetwork.oracle.com/portal/' ) >-1 )  ||  (  rUrl.indexOf('http://www.oracle.com/partners' ) > -1 )  )  		
	  rUrl = "http://oraclepartnernetwork.oracle.com/";
	window.location="http://login.oracle.com/sso/logout?p_done_url="+rUrl; //stage only
} 



function signout(url)
{

  //rUrl = window.location.href; 
  rUrl = escape(window.location.href); 
  window.location="http://login.oracle.com/sso/logout?p_done_url="+rUrl; //stage only
}


function getCookieData(label) {
  var labelLen = label.length
  var cLen = document.cookie.length
  var i = 0
  var cEnd
  while (i < cLen) {
    var j=i+labelLen;
    if (document.cookie.substring(i,j) == label) {
      cEnd=document.cookie.indexOf(";",j);
      if (cEnd==-1) {
      	cEnd=document.cookie.length;
      }
      j++;
      return unescape(document.cookie.substring(j,cEnd));
    }
    i++;
  }
  return "";
}


  function findPosX(obj)
  {
    var curleft = 0;
    if(obj.offsetParent)
        while(1) 
        {
          curleft += obj.offsetLeft;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.x)
        curleft += obj.x;
    return curleft;
  }
  
  function findPosY(obj)
  {
    var curtop = 0;
    if(obj.offsetParent)
        while(1)
        {
          curtop += obj.offsetTop;
          if(!obj.offsetParent)
            break;
          obj = obj.offsetParent;
        }
    else if(obj.y)
        curtop += obj.y;
    return curtop;
  }
// Worldwide popup menu
function panelMOv() {
	if (navigator.appName != "Netscape") {
		var dropdown = document.getElementById("group");
		dropdown.style.visibility = "hidden";
	}
	var p = document.getElementById("panelDiv");
	p.style.visibility = "visible";
}

function panelMOu() {
	var p = document.getElementById("panelDiv");
	p.style.visibility = "hidden";
	
	if (navigator.appName != "Netscape") {
		var dropdown = document.getElementById("group");
		dropdown.style.visibility = "visible";
	}
}

function mvqMOv() {

	if (navigator.appName != "Netscape") {
		var dropdown = document.getElementById("group");
		dropdown.style.visibility = "hidden";
	}
	
	var mvqPDiv = document.getElementById("panelDiv"); 
	mvqPDiv.style.visibility = "visible";

}

function mvqMOu() {
	var mvqPDiv = document.getElementById("panelDiv"); 
	mvqPDiv.style.visibility = "hidden";

	if (navigator.appName != "Netscape") {
		var dropdown = document.getElementById("group");
		dropdown.style.visibility = "visible";
	}
}
	
//more industries
function indMOv() {
	var indarrow = document.getElementById("indarrow"); 
	var x = findPosX(indarrow);
	var y = findPosY(indarrow);

	var indDiv = document.getElementById("indDiv"); 
	//alert(navigator.appName);
	if (navigator.appName == "Netscape")
		x = x-26;
	else
		x = x-46;
	if (navigator.appName == "Netscape")
		y = y+13;
	else
		y = y-2;
	//alert(x + " " + y);
	indDiv.style.left=x+'px';
	indDiv.style.top=y+'px';
	indDiv.style.position="absolute";
	
  	indDiv.style.visibility = "visible";
	indDiv.style.display = "";
}

function indMOu() {
	var indDiv = document.getElementById("indDiv"); 
	if (navigator.appName != "Netscape") {
		if (!indDiv.contains(window.event.toElement)) {
			indDiv.style.visibility = "hidden";
			indDiv.style.display = "";
		}
	} else {
		indDiv.style.visibility = "hidden";
		indDiv.style.display = "";
		}
}

function indPanelMOv() {
	var indDiv = document.getElementById("indDiv"); 
	indDiv.style.visibility = "visible";
	indDiv.style.display = "";
}

function indPanelMOu() {
	var indDiv = document.getElementById("indDiv"); 
	if (navigator.appName != "Netscape") {
		if (!indDiv.contains(window.event.toElement)){
			indDiv.style.visibility = "hidden";
			indDiv.style.display = "";
			}
	} else
	{
		indDiv.style.visibility = "hidden";
		indDiv.style.display = "";
		}
}

//Business Solutions
function indMOv1() {
	var indDiv = document.getElementById("indDiv1"); 
  indDiv.style.visibility = "visible";
}

function indMOv1() {
	var indarrow1 = document.getElementById("indarrow1"); 
	var x = findPosX(indarrow1);
	var y = findPosY(indarrow1);

	var indDiv = document.getElementById("indDiv1"); 
	//alert(navigator.appName);
	if (navigator.appName == "Netscape")
		x = x-26;
	else
		x = x-46;
	if (navigator.appName == "Netscape")
		y = y+13;
	else
		y = y-2;
	//alert(x + " " + y);
	indDiv.style.left=x+'px';
	indDiv.style.top=y+'px';
	indDiv.style.position="absolute";
	
  	indDiv.style.visibility = "visible";
	indDiv.style.display = "";
}

function indMOu1() {
	var indDiv = document.getElementById("indDiv1"); 
	if (navigator.appName != "Netscape") {
		if (!indDiv.contains(window.event.toElement))
		{
			indDiv.style.visibility = "hidden";
			indDiv.style.display = "";
		}
	} else
	{
		indDiv.style.visibility = "hidden";
		indDiv.style.display = "";
	}
}

function indPanelMOv1() {
	var indDiv = document.getElementById("indDiv1"); 
	indDiv.style.visibility = "visible";
}

function indPanelMOu1() {
	var indDiv = document.getElementById("indDiv1"); 
	if (navigator.appName != "Netscape") {
		if (!indDiv.contains(window.event.toElement))
		{
			indDiv.style.visibility = "hidden";
			indDiv.style.display = "";
		}
	} else
	{
		indDiv.style.visibility = "hidden";
		indDiv.style.display = "";
	}
}

// Function for the worldwide popup
function worldwideCountries(){
document.writeln("<div id=\'panelDiv\' style=\"position:absolute;right:10;visibility:hidden; z-index:1000; WIDTH: 620px; BORDER-RIGHT: #9A9A9A  1px solid; PADDING-RIGHT: 12px;BORDER-TOP: #9A9A9A  1px solid; PADDING-LEFT: 12px; PADDING-BOTTOM: 12px; BORDER-LEFT: #9A9A9A  1px solid; PADDING-TOP: 12px;BORDER-BOTTOM: #9A9A9A  1px solid; BACKGROUND-COLOR: #ffffff\" onmouseover=\"panelMOv();\" onmouseout=\"panelMOu();\">");
document.writeln("<table width=100%>");
document.writeln("<tr align=left><td colspan=5 class=\'sngPst\' style=\"border-bottom:#cccccc 1px solid\" title=\"select a country region\"><b>SELECT A COUNTRY/REGION<\/b><\/td><\/tr>");
document.writeln("<tr valign=top><td width=20% class=\'sngPst\'>");
document.writeln("<div nowrap><a href=\"/global/ao/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:AFRICA OPERATIONS\';\" id=\"Africa Operations\">Africa Operation<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ARGENTINA\';\" id=\"Argentina\">Argentina<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/au/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:AUSTRALIA\';\" id=\"Australia\">Australia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/at/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:AUSTRIA\';\" id=\"Austria\">Austria<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BAHRAIN\';\" id=\"Bahrain\">Bahrain<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BANGLADESH\';\" id=\"Bangladesh\">Bangladesh<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/be/\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BELGIUM AND LUXEMBOURG\';\" id=\"Belgium &amp; Luxembourg\">Belgium &amp; Luxembourg<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BELIZE\';\" id=\"Belize\">Belize<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BHUTAN\';\" id=\"Bhutan\">Bhutan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BOLIVIA\';\" id=\"Bolivia\">Bolivia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ba/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BOSNIA AND HERZEGOVINA\';\" id=\"Bosnia &amp; Herzegovina\">Bosnia &amp; Herzegovina<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/br/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BRASIL\';\" id=\"Brasil\">Brasil<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BRUNEI\';\" id=\"Brunei\">Brunei<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/bg/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:BULGARIA\';\" id=\"Bulgaria\">Bulgaria<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CAMBODIA\';\" id=\"Cambodia\">Cambodia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ca-en/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CANADA - ENGLISH\';\" id=\"Canada - English\">Canada - English<\/a><\/div> ");

document.writeln("<div nowrap><a href=\"/global/ca-fr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CANADA - FRENCH\';\" id=\"Canada - French\">Canada - French<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CHILE\';\" id=\"Chile\">Chile<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/cn/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CHINA\';\" id=\"China\">China<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:COLOMBIA\';\" id=\"Colombia\">Colombia<\/a><\/div> ");
document.writeln("<\/td>");
document.writeln("<td width=20% class=\'sngPst\'>");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:COSTA RICA\';\" id=\"Costa Rica\">Costa Rica<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/hr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CROATIA\';\" id=\"Croatia\">Croatia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/cy/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CYPRUS\';\" id=\"Cyprus\">Cyprus<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/cz/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:CZECH REPUBLIC\';\" id=\"Czech Republic\">Czech Republic<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/dk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:DENMARK\';\" id=\"Denmark\">Denmark<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ECUADOR\';\" id=\"Ecuador\">Ecuador<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:EGYPT\';\" id=\"Egypt\">Egypt<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ee/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ESTONIA\';\" id=\"Estonia\">Estonia<\/a><\/div> ");

document.writeln("<div nowrap><a href=\"/global/fi/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:FINLAND\';\" id=\"Finland\">Finland<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/fr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:FRANCE\';\" id=\"France\">France<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/de/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:GERMANY\';\" id=\"Germany\">Germany<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/gr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:GREECE\';\" id=\"Greece\">Greece<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:GAUTEMALA\';\" id=\"Guatemala\">Guatemala<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:HONDURAS\';\" id=\"Honduras\">Honduras<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/hk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:HONGKONG\';\" id=\"Hong Kong\">Hong Kong<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/hu/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:HUNGARY\';\" id=\"Hungary\">Hungary<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/in/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:INDIA\';\" id=\"India\">India<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ea/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:INDONESIA\';\" id=\"Indonesia\">Indonesia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:IRAQ\';\" id=\"Iraq\">Iraq<\/a><\/div>");
document.writeln("<div nowrap><a href=\"/global/ie/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:IRELAND\';\" id=\"Ireland\">Ireland<\/a><\/div>");
document.writeln("<\/td>");
document.writeln("<td width=20% class=\'sngPst\'>");

document.writeln("<div nowrap><a href=\"/global/il/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ISRAEL\';\" id=\"Israel\">Israel<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/it/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ITALY';\" id=\"Italy\">Italy<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"http://www.oracle.co.jp/\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:JAPAN\';\" id=\"Japan\">Japan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:JORDAN\';\" id=\"Jordan\">Jordan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ru/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:KAZAKHSTAN\';\" id=\"Kazakhstan\">Kazakhstan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/kr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:KOREA\';\" id=\"Korea\">Korea<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:KUWAIT\';\" id=\"Kuwait\">Kuwait<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/my/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:LAOS\';\" id=\"Laos\">Laos<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lv/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:LATVIA\';\" id=\"Lativa\">Latvia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:LEBANON\';\" id=\"Lebanon\">Lebanon<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lt/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:LITHUANIA\';\" id=\"Lithuania\">Lithuania<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/my/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:MALAYSIA\';\" id=\"Malaysia\">Malaysia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:MALDIVES\';\" id=\"Maldives\">Maldives<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/mt/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:MALTA\';\" id=\"Malta\">Malta<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:MEXICO\';\" id=\"Mexico\">Mexico<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ru/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:MOLDOVA\';\" id=\"Moldova\">Moldova<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:NEPAL\';\" id=\"Nepal\">Nepal<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/nl/\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:NETHERLANDS\';\" id=\"Netherlands\">Netherlands<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/nz/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:NEW ZEALAND\';\" id=\"New Zealand\">New Zealand<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:NICARAGUA\';\" id=\"Nicaragua\">Nicaragua<\/a><\/div> ");
document.writeln("<\/td>");
document.writeln("<td width=20% class=\'sngPst\'>");
document.writeln("<div nowrap><a href=\"/global/no/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:NORWAY\';\" id=\"Norway\">Norway<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:OMAN\';\" id=\"Oman\">Oman<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PAKISTAN\';\" id=\"Pakistan\">Pakistan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PANAMA\';\" id=\"Panama\">Panama<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PARAGUAY\';\" id=\"Paraguay\">Paraguay<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PERU\';\" id=\"Peru\">Peru<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ea/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PHILLIPINES\';\" id=\"Philippines\">Philippines<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pl/\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:POLAND\';\" id=\"Poland\">Poland<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pt/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PORTUGAL\';\" id=\"Portugal\">Portugal<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:PUERTO RICO\';\" id=\"Puerto Rico\">Puerto Rico<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:QATAR\';\" id=\"Qatar\">Qatar<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ro/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:ROMANIA\';\" id=\"Romania\">Romania<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ru/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:RUSSIA\';\" id=\"Russia\">Russia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SAUDI ARABIA\';\" id=\"Saudi Arabia\">Saudi Arabia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/yu/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SERBIA AND MONTENGRO\';\" id=\"Serbia &amp; Montenegro\">Serbia &amp; Montenegro<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ea/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SINGAPORE\';\" id=\"Singapore\">Singapore<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/sk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SLOVAKIA\';\" id=\"Slovakia\">Slovakia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/si/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SLOVENIA\';\" id=\"Slovenia\">Slovenia<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/za/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SOUTH AFRICA\';\" id=\"South Africa\">South Africa<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/es/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SPAIN\';\" id=\"Spain\">Spain<\/a><\/div> ");
document.writeln("<\/td>");
document.writeln("<td width=20% class='sngPst'>");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SRI LANKA\';\" id=\"Sri Lanka\">Sri Lanka<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/se/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SWEDEN\';\" id=\"Sweden\">Sweden<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ch-fr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SWITZERLAND -- FRENCH\';\" id=\"Switzerland - French\">Switzerland -- French<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ch-de/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:SWITZERLAND -- GERMAN\';\" id=\"Switzerland - German\">Switzerland -- German<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/tw/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:TAIWAN\';\" id=\"Taiwan\">Taiwan<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/th/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:THAILAND\';\" id=\"Thailand\">Thailand<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/tr/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:TURKEY\';\" id=\"Turkey\">Turkey<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/ru/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:UKRAINE\';\" id=\"Ukraine\">Ukraine<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:UNITED ARAB EMIRATES\';\" id=\"United Arab Emirates\">United Arab Emirates<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/uk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:UNITED KINGDOM\';\" id=\"United Kingdom\">United Kingdom<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:UNITED STATES\';\" id=\"United States\">United States<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:URAGUAY\';\" id=\"Uruguay\">Uruguay<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/lad/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:VENEZUELA\';\"id=\"Venezuela\">Venezuela<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/pk/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:VIETNAM\';\" id=\"Vietnam\">Vietnam<\/a><\/div> ");
document.writeln("<div nowrap><a href=\"/global/me/index.html\" class=\'sngPst\' onClick=\"s_objectID=\'R8:WW:YEMEN\';\" id=\"Yemen\">Yemen<\/a><\/div> ");
document.writeln("<\/td><\/tr>");
document.writeln("<tr><td><\/td><\/tr>");
document.writeln("<\/table>");
document.writeln("<\/div>");
}
// Start of functions used by new Ocom search
function trim(value)
{
  s = new String(value);
  if (value != null) {
    var beginIndex = -1;
    var endIndex   = s.length;

    for (var i = 0; i < s.length; i++)
    {
      if (s.charAt(i) != " ") {
        beginIndex = i;
        break;
      }
    }
    if (beginIndex == -1) return "";

    for (var j = s.length -1; j > beginIndex; j--) {
      if (s.charAt(j) != " ") {
        endIndex = j;
        break;
      }
    }
    if (endIndex != s.length) return s.substring(beginIndex, endIndex);
    else return s.charAt(beginIndex);
  }
  return value;
}


// Special Characters validation
// Added isSplCharsExist() on 25th April 2007 by Girish
var splCharsInKeyword;
function isSplCharsExist(value) {
    splCharsInKeyword = '';
     var iChars = "!#$%^=;|:?";
        for (var i = 0; i < value.length; i++) {
                if (iChars.indexOf(value.charAt(i)) != -1) {   
                idx = iChars.indexOf(value.charAt(i));
                splCharsInKeyword +=  iChars.charAt(idx) + ' ';

               }
     }
     
     if (splCharsInKeyword == '' || trim(splCharsInKeyword).length == 0 ) {
        return false;
      } 
     else {
        return true;
     }
}

// Serach validation Global value
// Modified isNotNull() on 25th April 2007 by Girish

var isUserInput = false ;
function isNotNull(value)
{
	  if (value == null || trim(value).length == 0  || value == "search site" || value =="Search OPN" || !isUserInput)
	  {
	    alert('You did not enter a search term.  Please try again.');
	    document.searchForm.keyword.value='';
	    isUserInput = true;	    
	    document.searchForm.keyword.focus();
	    return false;
	  }
	  else if (isSplCharsExist(value)) {
	  
		   if (trim(splCharsInKeyword).length > 1 ) {
		     splCharsInKeyword = 'Special characters ' + splCharsInKeyword + ' are ';
		   }
		   else {
		     splCharsInKeyword = 'Special character ' + splCharsInKeyword + ' is ';
		   }
		   
	   alert ( splCharsInKeyword +"not allowed.\n");
	   document.searchForm.keyword.focus();
	   return false;
	  }
	 else
	 return true;
}  


function checkSearch( value )
{
  if ( document.searchForm && document.searchForm.datasetId && typeof( langDataSetId ) != 'undefined' && langDataSetId )
  {
    document.searchForm.datasetId.value = langDataSetId;
  }

  if ( value == null || trim(value).length == 0 )
  {
    alert('Please enter the keyword(s) to search for');
    return false;
  }
  else 
  {
    if ( document.searchForm ) document.searchForm.submit();
    return true;
  }
}

function checkGlobalSearch( value )
{
  return checkSearch( value );
}

//Right nav funtion starts
/* Close all sideboxes */
function closeAll()
{
    for (i = 1; i <= sidelistsize; i++)
	{
		if( document.getElementById('sidebody'+i) )
		{
			document.getElementById('sidebody'+i).style.display = 'none';
		}
	}
}
/* Show all sideboxes */
function expandAll()
{
    for (i = 1; i <= sidelistsize; i++)
	{	
		if( document.getElementById('sidebody'+i) )
		{
			document.getElementById('sidebody'+i).style.display = 'block';
		}
    }
}

/* Toggle sidebox visibility */
function toggleSidebox(id) {
    if (document.getElementById(id).style.display == 'none') {
	document.getElementById(id).style.display = 'block';
    } else {
	document.getElementById(id).style.display = 'none';
    }
}

var sidelistsize = 0;
function getElementsByPrefix(inPrefix,inRoot)
{
	var elem_array = new Array;
	if(typeof inRoot.firstChild!= 'undefined')
	{
		var elem = inRoot.firstChild;
			while (elem!= null)
			{
				if(typeof elem.firstChild!= 'undefined')
				{
					elem_array = elem_array.concat(getElementsByPrefix(inPrefix,elem));
				}
				if(typeof elem.id!= 'undefined')
				{
					var reg = new RegExp ( '^'+inPrefix+'.*' );
						if(elem.id.match(reg))
						{
							elem_array.push(elem);
						}
				}
				elem = elem.nextSibling;
			}
	}
	return elem_array;
}


function DisplayElements(in_elem_array)
{
	sidelistsize = in_elem_array.length;
}

/* Display first right nav. box*/
function DisplayRightNav()
{
		for(i=1;i<=sidelistsize;i++)
		{
			
			if( document.getElementById('sidebody'+i) )
			{
				if (i <=1)
					document.getElementById('sidebody'+i).style.display = 'block';   
				else
					document.getElementById('sidebody'+i).style.display = 'none'; 
					
			}
			else
			{
				sidelistsize = sidelistsize+1;	
			}
		 }
}

//Right nav functions end

