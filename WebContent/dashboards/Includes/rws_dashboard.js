
window.history.forward();
function createChart(swfFile,chartId,width,height,option1,option2,strXML,divId,fobj)
{
	
	if(strXML==""){
		strXML="<graph></graph>";	
	}
          		fobj = new FusionCharts(swfFile,chartId,width,height,option1,option2);
		        fobj.setDataXML(strXML);
		        
				fobj.render(divId);
}


function getCookie(c_name)
{
	
	//alert(c_name);
var c_value = document.cookie;
var c_start = c_value.indexOf(" " + c_name + "=");
//alert(c_value);
if (c_start == -1)
{
c_start = c_value.indexOf(c_name + "=");
}
if (c_start == -1)
{
c_value = null;
}
else
{
c_start = c_value.indexOf("=", c_start) + 1;
var c_end = c_value.indexOf(";", c_start);
if (c_end == -1)
{
c_end = c_value.length;
}
c_value = unescape(c_value.substring(c_start,c_end));
}
return c_value;
}

function setCookie(c_name,value,exdays)
{
	
var exdate=new Date();
exdays = 0;//by kalasagar
exdate.setDate(exdate.getDate() + exdays);
var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());

document.cookie=c_name + "=" + c_value;
}

function checkCookie(username)
{

var cvalue=getCookie(username);
 if (cvalue==null)
    {
    setCookie(username,'1',365);
    change(1);
    }else{
    	change(cvalue);
    }
}


