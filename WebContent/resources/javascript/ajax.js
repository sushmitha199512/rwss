// ajax.js

var xmlHttp;
function createXMLHttpRequest()
{
	if(window.ActiveXObject)
	{
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	if(window.XMLHttpRequest)
	{
		xmlHttp = new XMLHttpRequest();
	}
}

function refreshList(oElem,oTarget)
{
	/*
	var requestParams = [];
	for(int i=0;i<arguments.length; i++)
	{
	 	requestParams.push(arguments[i]);
	}
	
	for(int i=0;i<requestParams.length; i++)
	{
	 	alert(requestParams[i]);
	}
	*/
	var strName = oElem.name;
	var strValue = oElem.options[oElem.selectedIndex].value;
	var url = 'switch.do?prefix=/proposals&page=/AjaxComboXML.jsp';
	var strParams = '&' + strName + '=' + strValue 
	  			  + '&formName=' + oTarget.form.name
	  			  + '&targetElem=' + oTarget.name;
	
	//alert(url+strParams);
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = handleStateChange;
	xmlHttp.open("GET", url+strParams, true);
	xmlHttp.send(null);	
	
}

function handleStateChange()
{
	if(xmlHttp.readyState == 4)
	{
		if(xmlHttp.status == 200)
		{
			updateList();
		}
		else
		{	
			alert("Error!" + xmlHttp.status);
		}
	}
	
}

function updateList()
{
	var xmlDoc = xmlHttp.responseXML.documentElement;
	
	var xSel = xmlDoc.getElementsByTagName('selectElement')[0];
	
	var strFName = xSel.childNodes[0].firstChild.nodeValue;
	var strEName = xSel.childNodes[1].firstChild.nodeValue;
	
	var objDDL = document.forms[strFName].elements[strEName];
	objDDL.options.length = 0;
	
	var xRows = xmlDoc.getElementsByTagName('entry');
	for(i=0;i<xRows.length;i++)
	{
	  var theText = xRows[i].childNodes[0].firstChild.nodeValue;
	  var theValue = xRows[i].childNodes[1].firstChild.nodeValue;
	  var option = new Option(theText, theValue);
	  objDDL.options.add(option);
	}
	objDDL.disabled = false;
  }