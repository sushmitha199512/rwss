function checkSpaceAndSpecial(event)
{
	upperOnly();
	var Key = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	if(Key==32){
		alert("Space Character Not Allowed");
		return false;
	}
	else if(Key==64)return false;
	else if(Key==46)return false;
	else if(Key==95)return false;
	else if(Key==96)return false;
	else if(Key==126)return false;
	else if(Key==33)return false;
	else if(Key==35)return false;
	else if(Key==36)return false;
	else if(Key==37)return false;
	else if(Key==94)return false;
	else if(Key==38)return false;
	else if(Key==42)return false;
	else if(Key==40)return false;
	else if(Key==41)return false;
	else if(Key==43)return false;
	else if(Key==124)return false;
	else if(Key==45)return false;
	else if(Key==61)return false;
	else if(Key==92)return false;
	else if(Key==60)return false;
	else if(Key==62)return false;
	else if(Key==47)return false;
	else if(Key==63)return false;
	else if(Key==123)return false;
	else if(Key==125)return false;
	else if(Key==91)return false;
	else if(Key==93)return false;
	else if(Key==58)return false;
	else if(Key==59)return false;
	else if(Key==39)return false;
	else if(Key==34)return false;
	else if(Key==44)return false;
	else return true;
}
function upperOnly()
{
    var charCode = event.keyCode;
    if (charCode > 96 && charCode < 123)
	{
        event.keyCode = charCode - 32;
    }
}

function numeralsOnly(evt)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57))
	{
        alert("Only numbers are allowed in this field.");
        return false;
    }
	return true;
}



function numeralsOnlyTest(evt)
{
    evt = (evt) ? evt : event;
    alert(evt.charChode);
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57))
	{
        alert("Only numbers are allowed in this field.");
        return false;
    }
	return true;
}

function decimalsOnly(evt)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
	{
        alert("Only numbers and . are allowed in this field.");
        return false;
    }
	return true;
}

function textOnly(evt)
{
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
	if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode < 65 || charCode > 90) &&
		(charCode < 97 || charCode > 122) && charCode != 46	&& charCode != 32 && charCode != 44 && 
		 charCode != 45 && charCode != 40 && charCode != 41 && charCode != 58 && charCode != 59 &&
		 charCode != 91 && charCode != 93 && charCode != 92 && charCode != 47)
	{
        alert("Special characters are not allowed here.");
        return false;
    }
	upperOnly();
}
function textOnly1(evt)
{
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
	if (charCode > 31 && (charCode < 65 || charCode > 90) &&
		(charCode < 97 || charCode > 122) && charCode != 46	&& charCode != 32 && charCode != 44 && 
		 charCode != 45 && charCode != 40 && charCode != 41 && charCode != 58 && charCode != 59 &&
		 charCode != 91 && charCode != 93 && charCode != 92 && charCode != 47)
	{
        alert("Special characters & Numbers are not allowed here.");
        return false;
    }
	upperOnly();
}
function eMailCheck(str) {
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }
		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID7")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

 		 return true					
}
function isEmpty(elem)
{
	var str = elem.value;
	var re =/.+/;
	if(str.match(re))
		return false;
	else
	{
		for(var i = 0 ; i< str.length; i++)
		{
			if(charAt(i) == '')
				return false;
		}
		return true;
	}
}

function isPositiveDecimal(that)
{
	var str = that.value;
	var re = /^\d*\.?\d*$/;
	str = str.toString();
	if(!str.match(re))
	{	
		return false;
	}
	return true;
}

/**
*	Function for checking checkboxes
*	@param element
*	@param id
*/
function checkAll(elem, id)
{
	var formName = document.getElementById(elem).form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements(elem);
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
	
		for(var i=0; i<len; i++) 
		{
			if( checkCollection[i].id == id && !checkCollection[i].disabled)
				checkCollection[i].checked = true;
		}
	}
}

/**
*	Function for unchecking checkboxes
*	@param element
*	@param id
*/
function clearAll(elem, id)
{
	var formName = document.getElementById(elem).form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements(elem);
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
	
		for(var i=0; i<len; i++) 
		{
			if( checkCollection[i].id == id && !checkCollection[i].disabled)
				checkCollection[i].checked = false;
		}
	}
}

/**
*	Function for determining whether a group of check boxes
*	are checked or not	
*/
function isSelected(elem, id, message)
{
	var formName = document.getElementById(elem).form.name;
	var frm = document.forms[formName];
	var checkCollection =  frm.elements(elem);
	var count = 0;
	if(checkCollection)
	{
		if(typeof checkCollection.length != "number")
		{
			checkCollection = [checkCollection];
		}

		var len = checkCollection.length;
		
		for(var i=0; i<len; i++)
		{
			if(checkCollection[i].checked && checkCollection[i].id == id)
				count++;
		}
	}
	if(count == 0)
	{
		alert(message);
		return false;
	}
	else
		return true;
}

/**	Function to validate proposal/estimate before 
*	submitting, i.e., checking memo no,  
*
*/
function validateSubmitForm(form)
{
	var message = "";
	var allowed = true;

	if( isEmpty(form.submitContent) )
	{
		allowed = false;
		message = "Content is required" + message;
		form.submitContent.focus();
	}
	if( isEmpty(form.submitSubject) )
	{	
		allowed = false;
		message = "Subject is required\n" + message;
		form.submitSubject.focus();
	}
	if( isEmpty(form.submitDate) )
	{
		allowed = false;
		message = "Date is required\n" + message;
		form.submitDate.focus();
	}
	if(	isEmpty(form.letterNo) )
	{	
		allowed = false;
		message = "Memo No. is required\n" + message;
		form.letterNo.focus();
	}

	if(!allowed)
	{
		alert(message);
		return false;
	}
	return true;
}

/**	Function to validate proposal/estimate before 
*	forwarding, i.e., checking memo no,  
*
*/
function validateForwardForm(form)
{
	var message = "";
	var allowed = true;

	if( isEmpty(form.forwardContent) )
	{
		allowed = false;
		message = "Content is required" + message;
		form.forwardContent.focus();
	}
	if( isEmpty(form.forwardSubject) )
	{	
		allowed = false;
		message = "Subject is required\n" + message;
		form.forwardSubject.focus();
	}
	if( isEmpty(form.forwardDate) )
	{
		allowed = false;
		message = "Date is required\n" + message;
		form.forwardDate.focus();
	}
	if(	isEmpty(form.memoNo) )
	{	
		allowed = false;
		message = "Memo No. is required\n" + message;
		form.memoNo.focus();
	}
	if(form.forwardTo.value == form.officeCode.value)
	{
		allowed = false;
		message = "Forward To is required\n" + message;
	}

	if(!allowed)
	{
		alert(message);
		return false;
	}
	return true;
}

/**	Function to validate proposal/estimate before 
*	deffering/transmitting, i.e., checking action, etc.  
*
*/
function validateDeferForm(form)
{
	var message = "";
	var allowed = true;

	if( isEmpty(form.otherRemarks) )
	{
		allowed = false;
		message = "Remarks is required" + message;
		form.otherRemarks.focus();
	}
	if( isEmpty(form.actionType) )
	{	
		allowed = false;
		message = "Action is required\n" + message;
		form.actionType.focus();
	}
	
	if(!allowed)
	{
		alert(message);
		return false;
	}
	return true;
}

/** Used in both New and O&M estimates for displaying
*	the work components
*	@param workId
*   @param type	 
*/
function fnShowWorkComponents(that, type)
{
	var workId = that.name;
	var url;
	if(type == 'new')
		url = "switch.do?prefix=/estimates&page=/ShowWorkComponents.do&type=new&workId="+workId;
	else
		url = "switch.do?prefix=/estimates&page=/ShowWorkComponents.do&type=om&workId="+workId;	
	
	var properties = 'width=300,height=150,toolbar=no,status=no,menubar=no,location=no,'
				   + 'directories=no,scrollbars=yes,copyhistory=no,resizable=yes';
		
	var newWindow = window.open(url,'',properties);
}

/** Used in both New and O&M estimates for displaying source details 
*	@param frm
*   @param workId
*   @param type	 
*/
function fnShowSourceDetails(elem)
{
	var sourceCode = document.getElementById(elem).value;
	if(sourceCode == '')
		alert("Please select a source.");
	else	
	{
		var url = "switch.do?prefix=/estimates&page=/ShowSourceDetails.do&sourceCode="+sourceCode;
		var properties = 'width=750,height=235,toolbar=no,status=no,menubar=no,location=no,directories=no,'
					   + 'scrollbars=yes,copyhistory=no,resizable=yes';
		var newWindow = window.open(url,"",properties);
	}
}

/** Used in both New and O&M estimates for editing 
*	@param frm
*   @param workId
*   @param type	 
*/
function fnEditEstimate(frm, workId, type)
{
	var url;
	if(type == 'new')
		url = "switch.do?prefix=/estimates&page=/EditNewEstimate.do&mode=data&workId="+workId;
	else
	if(type == 'om')
		url = "switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=data&workId="+workId;
	frm.action = url;
	frm.submit();
}

function fnConfirmDelete()
{
	return confirm("Delete the selected record?");
}
function fnConfirmUpdate()
{
	return confirm("Update the record?");
}
function setFocus(elem)
{
	var frm = document.getElementById(elem).form;
	frm.elements[elem].focus();
}

/**	Function for closing a window
*
*/
function fnClose()
{
	window.close();
}


function winView()
{
	   if (confirm("Do you want save the record?"))
		   return true
	   else
		   return false
}

function deleteRec()
{
	return (confirm("Do u want to Delete the Record Y/N"));
}
function getAge(firstDate,dateString) {
/*
   function getAge
   parameters: dateString dateType
   returns: boolean

   dateString is a date passed as a string in the following
   formats:    29/05/1997

   Returns string containing the age in years, months and days
   in the format yyy years mm months dd days.
   Returns empty string if dateType is not one of the expected
   values.
*/


    //var today = new Date(now.getYear(),now.getMonth(),now.getDate());
    var yearNow = firstDate.substring(6,10);
    var monthNow = firstDate.substring(3,5);
    var dateNow = firstDate.substring(0,2);

     var dob = new Date(dateString.substring(6,10),
                            dateString.substring(3,5)-1,
                            dateString.substring(0,2));
   
    var yearDob = dob.getYear();
	var monthDob = dob.getMonth();
    var dateDob = dob.getDate();

    yearAge = yearNow - dateString.substring(6,10);

    if (monthNow >= monthDob)
        var monthAge = monthNow - monthDob;
    else {
        yearAge--;
        var monthAge = 12 + monthNow -monthDob;
    }

    if (dateNow >= dateDob)
        var dateAge = dateNow - dateDob;
    else {
        monthAge--;
        var dateAge = 31 + dateNow - dateDob;

        if (monthAge < 0) {
            monthAge = 11;
            yearAge--; 
        }
    }

    return yearAge + ' yrs ' + monthAge + ' months ' + dateAge + ' days';
}
function getNoOfYears(firstDate,dateString)
{
    var yearNow = firstDate.substring(6,10);
    var monthNow = firstDate.substring(3,5);
    var dateNow = firstDate.substring(0,2);

     var dob = new Date(dateString.substring(6,10),
                            dateString.substring(3,5)-1,
                            dateString.substring(0,2));
   
     var yearDob = dateString.substring(6,10);
	var monthDob = dateString.substring(3,5);
    var dateDob = dateString.substring(0,2)

    yearAge = yearNow - dateString.substring(6,10);
   
    return yearAge;
}
function getNoOfMonths(firstDate,dateString)
{
    var yearNow = firstDate.substring(6,10);
    var monthNow = firstDate.substring(3,5);
    var dateNow = firstDate.substring(0,2);

     var dob = new Date(dateString.substring(6,10),
                            dateString.substring(3,5)-1,
                            dateString.substring(0,2));
   
     var yearDob = dateString.substring(6,10);
	var monthDob = dateString.substring(3,5);
    var dateDob = dateString.substring(0,2)

    yearAge = yearNow - dateString.substring(6,10);

    if (monthNow >= monthDob)
        var monthAge = monthNow - monthDob;
    else {
        yearAge--;
        var monthAge = 12 + monthNow -monthDob;
    }

    return  monthAge;
}
function getNoOfDays(firstDate,dateString)
{
    var yearNow = firstDate.substring(6,10);
    var monthNow = firstDate.substring(3,5);
    var dateNow = firstDate.substring(0,2);

     var dob = new Date(dateString.substring(6,10),
                            dateString.substring(3,5)-1,
                            dateString.substring(0,2));
   
    var yearDob = dateString.substring(6,10);
	var monthDob = dateString.substring(3,5);
    var dateDob = dateString.substring(0,2)

    yearAge = yearNow - dateString.substring(6,10);

    if (monthNow >= monthDob)
        var monthAge = monthNow - monthDob;
    else {
        yearAge--;
        var monthAge = 12 + monthNow -monthDob;
    }

    if (dateNow >= dateDob)
        var dateAge = dateNow - dateDob;
    else {
        monthAge--;
        var dateAge = 31 + dateNow - dateDob;

        if (monthAge < 0) {
            monthAge = 11;
            yearAge--; 
        }
    }

    return dateAge;
}


function extractNumber(obj, decimalPlaces, allowNegative)
{
	var temp = obj.value;
	
	// avoid changing things if already formatted correctly
	var reg0Str = '[0-9]*';
	if (decimalPlaces > 0) {
		reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
	} else if (decimalPlaces < 0) {
		reg0Str += '\\.?[0-9]*';
	}
	reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
	reg0Str = reg0Str + '$';
	var reg0 = new RegExp(reg0Str);
	if (reg0.test(temp)) return true;

	// first replace all non numbers
	var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
	var reg1 = new RegExp(reg1Str, 'g');
	temp = temp.replace(reg1, '');

	if (allowNegative) {
		// replace extra negative
		var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
		var reg2 = /-/g;
		temp = temp.replace(reg2, '');
		if (hasNegative) temp = '-' + temp;
	}
	
	if (decimalPlaces != 0) {
		var reg3 = /\./g;
		var reg3Array = reg3.exec(temp);
		if (reg3Array != null) {
			// keep only first occurrence of .
			//  and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
			var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
			reg3Right = reg3Right.replace(reg3, '');
			reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
			temp = temp.substring(0,reg3Array.index) + '.' + reg3Right;
		}
	}
	
	obj.value = temp;
}
function blockNonNumbersAndExtractNumber2(obj, e, allowDecimal, allowNegative)
{
	var val = blockNonNumbers(obj, e, allowDecimal, allowNegative);
	var val1 = extractNumber2(obj, 10,1,false);
	if(val==true && val1==true)
		return true;
	else 
		return false;
}
function blockNonNumbers(obj, e, allowDecimal, allowNegative)
{
	var key;
	var isCtrl = false;
	var keychar;
	var reg;
		
	if(window.event) {
		key = e.keyCode;
		isCtrl = window.event.ctrlKey
	}
	else if(e.which) {
		key = e.which;
		isCtrl = e.ctrlKey;
	}
	
	if (isNaN(key)) return true;
	
	keychar = String.fromCharCode(key);
	
	// check for backspace or delete, or if Ctrl was pressed
	if (key == 8 || isCtrl)
	{
		return true;
	}

	reg = /\d/;
	var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
	var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
	
	return isFirstN || isFirstD || reg.test(keychar);
}

function extractNumber2(obj, beforeDecimalPlaces,decimalPlaces, allowNegative)
{
	var temp = obj.value;
	beforeDecimalPlaces=beforeDecimalPlaces-decimalPlaces;
	str = new String(obj.value);
    str = str.split(".");
    var strTmp;
    strTmp=str[0];
    var length=strTmp.length;
    if(length>beforeDecimalPlaces)
    {
    	//obj.value="";
    	alert("length cannot be greater than "+beforeDecimalPlaces);
    	if(str[1])
    	obj.value=str[0].substring(0,beforeDecimalPlaces)+"."+str[1];
    	else
    	obj.value=str[0].substring(0,beforeDecimalPlaces);
    	
    	//obj.focus();
    	return false;
	}
	
	// avoid changing things if already formatted correctly
	var reg0Str = '[0-9]*';
	if (decimalPlaces > 0) {
		reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
	} else if (decimalPlaces < 0) {
		reg0Str += '\\.?[0-9]*';
	}
	reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
	reg0Str = reg0Str + '$';
	var reg0 = new RegExp(reg0Str);
	if (reg0.test(temp)) return true;

	// first replace all non numbers
	var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
	var reg1 = new RegExp(reg1Str, 'g');
	temp = temp.replace(reg1, '');

	if (allowNegative) {
		// replace extra negative
		var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
		var reg2 = /-/g;
		temp = temp.replace(reg2, '');
		if (hasNegative) temp = '-' + temp;
	}
	
	if (decimalPlaces != 0) {
		var reg3 = /\./g;
		var reg3Array = reg3.exec(temp);
		if (reg3Array != null) {
			// keep only first occurrence of .
			//  and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
			var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
			reg3Right = reg3Right.replace(reg3, '');
			reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
			temp = temp.substring(0,reg3Array.index) + '.' + reg3Right;
		}
	}
	
	obj.value = temp;
}

function fnBeforeUnload()
{
	//alert("X="+window.event.clientX+" and Y="+window.event.clientY);
	
	if((window.event.clientX>200)&&(window.event.clientY<0))
	{
	
		var url = "/pred/closeWindow.do";
		var properties = "width=1px,height=1px,screenX=1px,screenY=1px";
		newWindow = window.open(url, "", properties);
	}

}
//function for comparing dates which are in string form in format(dd/mm/yyyy)
//this function returns 0 if both dates are equal ,and returns 1 if date1 is
//greater than date2, and returns -1 if date1 is less than date2.
function compareDates(date1Str, date2Str) 
{

	var year1=parseInt(date1Str.substring(6,10),10);
	var year2=parseInt(date2Str.substring(6,10),10);
	var month1=parseInt(date1Str.substring(3,5),10);
	var month2=parseInt(date2Str.substring(3,5),10);
	var date1=parseInt(date1Str.substring(0,2),10);
	var date2=parseInt(date2Str.substring(0,2),10);
	if(date1Str==date2Str)
		return 0;
	else
	{
		if(year1>year2)
		{
			return 1;
		}
		else if(year1<year2)
		{
			return -1;
		}
		else if(year1==year2)
		{
			if(month1>month2)
			{
				return 1;
			}
			else if(month1<month2)
			{
			
				return -1;
			}
			else if(month1==month2)
			{
				if(date1>date2)
				{
					return 1;
				}
				else if(date1<date2)
				{
					return -1;
				}
				else if(date1==date2)
				{
					return 0;
				}
			
			}
		}
	
	}
}
	
function roundNumberToSpefiedDecimal(numberToBeRounded,rlength) {
//numberField is the filed whose value to be rounded
//rlength is the no of decimal places to which it is to be rounded
	//var rnum = numberField.value;
	var rnum = numberToBeRounded;
	var rlength = 2; // The number of decimal places to round to
	if (rnum > 8191 && rnum < 10485) {
		rnum = rnum-5000;
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
		newnumber = newnumber+5000;
	} else {
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
	}
	//numberField.value = newnumber;
	return newnumber;
}
function alpha(e) {
	var k;
	document.all ? k = e.keyCode : k = e.which;
	upperOnly();
	return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k==32);
	
	}
function financialYearOnly(evt,that)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    
    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode!=45)
	{
        alert("Only numbers are allowed in this field.");
        return false;
    }
    if(charCode==45)
    {
    	if(that.value.length!=4)
    	{
    		alert("Invalid Financial Year format.\n Format example: 2005-2006");
    		return false;
    	}
    	
    }
	return true;
}
//example code to be included along with financialYearOnly while validating form 
//here financialYear is the field containing financial year
/*
else if(document.forms[0].financialYear.value.length!=9)
	{
		alert("Invalid FinancialYear format.\n Format example: 2005-2006");
		document.forms[0].financialYear.focus();
		return false;
	}
	else if(document.forms[0].financialYear.value.length==9)
	{
		var fromYear=parseInt(document.forms[0].financialYear.value.substring(0,4),10);
		var toYear=parseInt(document.forms[0].financialYear.value.substring(5,9),10);
		if((toYear-fromYear)!=1)
		{								
			alert("Invalid Financial Year format.\nThe difference between fromYear and toYear should be 1\n Format example: 2005-2006");
			document.forms[0].financialYear.focus();
			return false;
		}
	}
*/

function roundNumberToSpefiedDecimal(numberToBeRounded,rlength) {
//numberField is the filed whose value to be rounded
//rlength is the no of decimal places to which it is to be rounded
	//var rnum = numberField.value;
	var rnum = numberToBeRounded;
	var rlength = 2; // The number of decimal places to round to
	if (rnum > 8191 && rnum < 10485) {
		rnum = rnum-5000;
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
		newnumber = newnumber+5000;
	} else {
		var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
	}
	//numberField.value = newnumber;
	return newnumber;
}

//for limiting the text in text area to a max size
function TrimTextArea(s,maxlength) {

//var maxlength = 135; // Change number to your max length.
if (s.value.length > maxlength) 
{
alert("Total text cannot be greater than "+maxlength+" characters");
s.value = s.value.substring(0,maxlength);

}
}

function fileMimeType(filepath) {

	//var filter = /^[\w]+(.png|.jpg|.jpeg)$/;
	var filter = /^[\w]+(.PNG|.JPG|.bmp|.JPEG|.gif|.png|.jpg|.jpeg)$/;
	var fileName = filepath.split('\\').pop().split('/').pop();
//if (!filter.test(fileName)|| fileName.length>20 || fileName.length<1) {
	if (!filter.test(fileName)||  fileName.length<1) {
		alert("Upload Image in correct format only (Ex: Filename.jpg or filename.png) ");
		return false;

	} else {
		return true;
	}
}

