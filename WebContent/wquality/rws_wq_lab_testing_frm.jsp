<%@ include file="/commons/rws_header1.jsp" %>
<%
    int count1 = 1;    
    String pValue = request.getParameter("paramValue");    
    java.util.ArrayList wqlist = new java.util.ArrayList();
    wqlist = (java.util.ArrayList) request.getAttribute("wqlist");
    if (wqlist == null || wqlist.size() < 1) {
        wqlist = new java.util.ArrayList(18);
        for (int i = 0; i < 18; i++) {
            wqlist.add(i, "N");
        }
    }
%>
<script language="JavaScript" src="<rws:context page='/resources/javascript/rwsWQLabValidate.js'/>"></script>
<script language="JavaScript">
    function showForm() {
        document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=parameters";
        document.forms[0].submit();
    }
    function checkDiv(){
        if (document.forms[0].contamin.value == "YES")
        {
            document.getElementById('submission').display = 'none';
        } else if (document.forms[0].contamin.value == "NO")
        {
            document.getElementById('submission').display = 'block';
        }
    }
    function checkforward() {
        if (document.forms[0].forwarded.value == "YES") {
            if (document.forms[0].ftklab[0].checked == true) {
               if (document.forms[0].forwardDate.value.length < 10 && document.forms[0].ftkTestDate.value.length > 8) {
                } else if (document.forms[0].forwardDate.value.length > 8 && document.forms[0].forwarded.value == "YES")
                {
                    var sourceTypeCode = document.forms[0].forwardedsurcType.value;
                    var sourceCode = document.forms[0].forwardedsurcCode.value;
                    var ftktestid = document.forms[0].forwardedftkid.value;
                    var mcode = document.forms[0].forwardedmcode.value;
                    var pcode = document.forms[0].forwardedpcode.value;
                    var hcode = document.forms[0].forwardedhcode.value;
                     alert("Forwarded to Lab");
                    document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=forwardtolab&ftklab=lab&sourceTypeCode=" + sourceTypeCode + "&sourceCode=" + sourceCode + "&ftktestid=" + ftktestid + "&mandalCode=" + mcode + "&panchayatCode=" + pcode + "&habCode=" + hcode;
                    document.forms[0].submit();
                }
            }
        }
    }

    function checkforward1(S) {
        if (document.getElementById("fdate").style.display == 'none'){
            document.getElementById("fdate").style.display = "";
        } else if (document.getElementById("fdate").style.display == ''){
            document.getElementById("fdate").style.display = "none";
        }
        if (document.getElementById("fcal").style.display == 'none'){
            document.getElementById("fcal").style.display = "";
        } else if (document.getElementById("fcal").style.display == ''){
            document.getElementById("fcal").style.display = "none";
        }
        var ele = document.getElementById("forwarddate");
        if (ele.style.display == "none") {
            ele.style.display = "";
        } else if (ele.style.display == "") {
            ele.style.display = "none";
        }
    }

    function valdate() {
        var flag = "false";
        var c = document.forms[0].ftkTestDate.value;
        var y = parseInt(c.substring(6, 10));
        var d = parseInt(c.substring(0, 2));
        var m = (c.substring(3, 5));
        var a = document.forms[0].sysdate.value;
        var y2 = parseInt(a.substring(6, 10));
        var d2 = parseInt(a.substring(0, 2));
        var m2 = (a.substring(3, 5));
        var date1 = new Date(y, m, d);
        var date3 = new Date(y2, m2, d2);
        if (date3 < date1){
            alert("Test Date must be less than or equal to Current date");
            return flag;
        }
    }
    
    function ftkchk(){
        var val;
        if (document.forms[0].ftklab[0].checked == false && document.forms[0].ftklab[1].checked == false){
            alert("Please select lab or ftk");
            return false;
        } else if (document.forms[0].ftklab[0].checked == true && document.forms[0].ftkTestDate.value == ""){
            alert("Please select Test Date");
            return false;
        } else if (document.forms[0].ftklab[0].checked == true && document.forms[0].ftkTestDate.value != ""){
            val = valdate();
            if (val == "false") {
                return false;
            } else if (val == "true"){
                return val;
            }
        } else if (document.forms[0].ftklab[0].checked == true && document.forms[0].forwardtolab.checked == true){
            if (document.forms[0].forwardDate.value == ""){
                alert("Please select Forward Date");
                return false;
            } else {
                val = valdate();
                if (val == "false") {
                    return false;
                } else if (val == "true") {
                    return val;
                }
            }
        }
    }
    function validate1(){
        var flag = "false";
        var b = document.forms[0].forwardDate.value;
        if (document.forms[0].forwardDate.value != "") {
            var y1 = parseInt(b.substring(6, 10));
            var d1 = parseInt(b.substring(0, 2));
            var m1 = (b.substring(3, 5));
            var date2 = new Date(y1, m1, d1);
            var a = document.forms[0].sysdate.value;
            var y2 = parseInt(a.substring(6, 10));
            var d2 = parseInt(a.substring(0, 2));
            var m2 = (a.substring(3, 5));
            var date3 = new Date(y2, m2, d2);
            var c = document.forms[0].ftkTestDate.value;
            var y = parseInt(c.substring(6, 10));
            var d = parseInt(c.substring(0, 2));
            var m = (c.substring(3, 5));
            var date1 = new Date(y, m, d);
            if (date3 < date2)  {
                alert("Forward Date must be less than or equal to Current date");
                return flag;
            } else if (date2 < date1) {
                alert("Forward Date must be greater than or equal to Test date");
                return flag;
            } else {
                flag = "true";
                return flag;
            }
        }

    }
    function getDateObject(dateString, dateSeperator) {
        var curValue = dateString;
        var sepChar = dateSeperator;
        var curPos = 0;
        var cDate, cMonth, cYear;
        curPos = dateString.indexOf(sepChar);
        cDate = dateString.substring(0, curPos);
        endPos = dateString.indexOf(sepChar, curPos + 1);
        cMonth = dateString.substring(curPos + 1, endPos);
        curPos = endPos;
        endPos = curPos + 5;
        cYear = curValue.substring(curPos + 1, endPos);
        dtObject = new Date(cYear, cMonth - 1, cDate);
        return dtObject;
    }

    function fnSave() {
        document.forms[0].elements['sourceType'].disabled = false;
        document.forms[0].elements['sourceCode'].disabled = false;
        if (document.forms[0].circleOfficeCode.value == "") {
            alert("Circle is Required");
            return false;
        }
        if (document.forms[0].mandalCode.value == "") {
            alert("Mandal is Required");
            return false;
        } else if (document.forms[0].panchayatCode.value == "") {
            alert("Panchayat is Required");
            return false;
        } else if (document.forms[0].habCode.value == "") {
            alert("Habitation is Required");
            return false;
        } else if (document.forms[0].elements['sourceType'].value == ""){
            document.forms[0].elements['sourceType'].disabled = true;
            alert(" Please Select source Type");
            return false;
        } else if (document.forms[0].elements['sourceCode'].value == "") {
            document.forms[0].elements['sourceCode'].disabled = true;
            alert(" Please Select sources");
            return false;
        } else if (document.forms[0].testCode.value == "") {
            alert(" Please Select Type of Test");
            return false;
        } else if (document.forms[0].natureOfTest.value == ""){
            alert(" Please Select Nature of Test");
            return false;
        } else if (document.forms[0].sampCollectCode.value == ""){
            alert(" Please Select Sample Collected By ");
            return false;
        } else if (document.forms[0].sampCollectDate.value == "") {
            alert(" Please Select Sample Collect Date and Time");
            return false;
        } else if (document.forms[0].labCode.value == "") {
            alert(" Pleas Select Lab name");
            return false;
        } else if (document.forms[0].testDate.value == "") {
            alert(" Pleas Select Test Date");
            return false;
        } else {
                    dt1 = getDateObject(document.forms[0].sampCollectDate.value, "/");
                    dt2 = getDateObject(document.forms[0].assignedOn.value, "/");
                    if (dt2 >= dt1) {
                        if(document.forms[0].paramValue.value=="13")
                        {
                             if (fnAdd2(document.forms[0].testCode.value)) {
                                document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                                document.forms[0].submit();
                            }
                        }
                        else {
                            if (fnAdd1(document.forms[0].testCode.value)) {
                                document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                                document.forms[0].submit();
                            } 
                        }
                    } else{
                        alert("Sample Collect Date Should be less than Current date");
                        return false;
                    }           
        }

   }

    function ftksave(that) {


        var flagg = "false";
        var subflag = "false";
        that.disabled = true;

        if (document.forms[0].circleOfficeCode.value == "")
        {
            alert("Circle is Required");
            return false;
        } else if (document.forms[0].ftklab[0].checked == false && document.forms[0].ftklab[1].checked == false)
        {
            alert("please Select ftk or lab");
            return false;
        } else if (document.forms[0].ftklab[0].checked == true && document.forms[0].ftklab[1].checked == false)
        {
            if (document.forms[0].mandalCode.value == "")
            {
                alert("Mandal is Required");
                return false;
            } else if (document.forms[0].panchayatCode.value == "")
            {
                alert("Panchayat is Required");
                return false;
            } else if (document.forms[0].habCode.value == "")
            {
                alert("Habitation is Required");
                return false;
            } else if (document.forms[0].sourceType.value == "")
            {
                alert(" Please Select sources");
                return false;
            } else if (document.forms[0].ftkTestDate.value == "")
            {
                alert(" Please Select Test Date ");
                return false;
            } else if (document.forms[0].ftkTestDate.value != "")
            {
                val = valdate();
                if (val == "false") {
                    return false;
                } else if (val == "true")
                {
                    return val;
                }
            }
            if (document.forms[0].contamin.value == "") {
                alert("Please select water contaminated YES or No");
                return false;
            }

            if (document.forms[0].contamin.value == "YES")
            {
                 if (document.forms[0].ftklab[0].checked == true || document.forms[0].ftklab[1].checked == true)
                {

                    if (document.forms[0].che[0].checked == true || document.forms[0].che[1].checked == true || document.forms[0].che[2].checked == true || document.forms[0].che[3].checked == true || document.forms[0].che[4].checked == true || document.forms[0].bat.checked == true || document.forms[0].phy.checked == true || document.forms[0].oth[0].checked == true || document.forms[0].oth[1].checked == true || document.forms[0].oth[2].checked == true || document.forms[0].oth[3].checked == true || document.forms[0].oth[4].checked == true || document.forms[0].oth[5].checked == true || document.forms[0].oth[6].checked == true || document.forms[0].oth[7].checked == true)
                    {
                       if (document.forms[0].forwardDate.value != "")
                        {
                            flagg = validate1();
                           if (flagg == "false")
                            {
                                subflag = "false";
                               } else
                            {
                                subflag = "true";
                            }
                        } else
                        {

                            subflag = "true";

                        }
                    } else
                    {
                        alert("Please Select any one contamination parameter");
                    }
                }
            } else
            {
                subflag = "true";                
            }
            if (subflag == "true")
            {
                document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                document.forms[0].submit();

            }

        } else if (document.forms[0].ftklab[1].checked == true && document.forms[0].ftklab[0].checked == false)
        {

            if (document.forms[0].testCode.value == "")
            {
                alert(" Please Select Type of Test");
                return false;
            } else if (document.forms[0].natureOfTest.value == "")
            {
                alert(" Please Select Nature of Test");
                return false;
            } else if (document.forms[0].sampCollectCode.value == "")
            {
                alert(" Please Select Sample Collected By ");
                return false;
            } else if (document.forms[0].sampCollectDate.value == "")
            {
                alert(" Please Select Sample Collect Date and Time");
                return false;
            } else if (document.forms[0].labCode.value == "")
            {
                alert(" Pleas Select Lab name");
                return false;
            } else if (document.forms[0].sampCollectDate.value != "")
            {

                dt1 = getDateObject(document.forms[0].sampCollectDate.value, "/");
                dt2 = getDateObject(document.forms[0].assignedOn.value, "/");
                if (dt2 >= dt1) {
                    if (fnAdd1(1)) {

                        document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                        document.forms[0].submit();
                    }
                } else
                {
                    alert("Sample Collect Date Should be less than Current date");
                    return false;
                }

            } else {

                document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                document.forms[0].submit();
            }
        }
    }
    function ftkchk1()
    {

        var val;
        if (document.forms[0].ftklab[0].checked == true)
        {
            val = ftkchk();
            if (val == "true") {
                if (document.forms[0].forwardtolab.checked == true && document.forms[0].forwardDate.value == "") {
                    alert("Please Select Forward Date");
                } else {
                    document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
                    document.forms[0].submit();
                }
            } else if (val == "false") {
                return false;
            }
        } else {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Save";
            document.forms[0].submit();
        }
    }

    function getsourcecheck() {

        if (document.forms[0].sourceCode.value == "")
        {
            alert(" Source Code is Rquired");
            document.forms[0].contamin.value = '';
        } else
        {
            getData();
        }

    }
    function ftkview() {

        if (document.forms[0].circleOfficeCode.value == "")
        {
            alert("Circle is required");
            return false;
        } else {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=view";
            document.forms[0].submit();
        }
    }
    function labview() {
        if (document.forms[0].circleOfficeCode.value == "")
        {
            alert("Circle is required");
            return false;
        } else if (document.forms[0].divisionOfficeCode.value == "")
        {
            alert("Division is required");
            return false;
        } else if (document.forms[0].subdivisionOfficeCode.value == "")
        {
            alert("SubDivision is required");
            return false;
        } else {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=View";
            document.forms[0].submit();
        }
    }
    function ftkupdate() {
        if (document.forms[0].contamin.value == "YES")
        {
            if (document.forms[0].forwardtolab.checked == false)
            {
                alert("Please select forwarded date");
            } else
            {
                document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Update";
                document.forms[0].submit();
            }
        } else if (document.forms[0].contamin.value == "NO")
        {
          	 document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=Update";
            document.forms[0].submit();
        }
    }
    // 
    function ftkcheck() {
        if (document.forms[0].circleOfficeCode.value == "")
        {
            alert("Please Select Circle ");
            document.forms[0].ftklab[0].checked = false;
        } else if (document.forms[0].divisionOfficeCode.value == "")
        {
            alert(" Please Select Division ");
            document.forms[0].ftklab[0].checked = false;
        } else if (document.forms[0].subdivisionOfficeCode.value == "")
        {
            alert(" Please Select Sub Division ");
            document.forms[0].ftklab[0].checked = false;
        } else
        {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk&mode1=formftk";
            document.forms[0].submit();
        }

    }
    function labcheck() {

        if (document.forms[0].circleOfficeCode.value == "")
        {
            alert("Please Select Circle ");
            document.forms[0].ftklab[1].checked = false;
        } else if (document.forms[0].divisionOfficeCode.value == "")
        {
            alert(" Please Select Division ");
            document.forms[0].ftklab[1].checked = false;
        } else if (document.forms[0].subdivisionOfficeCode.value == "")
        {
            alert(" Please Select Sub Division ");
            document.forms[0].ftklab[1].checked = false;
        } else
        {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=lab&mode1=formlab";
            document.forms[0].submit();
        }

    }

    function Reset()
    {
        document.forms[0].ftklab[0].checked = "false";
        document.forms[0].ftklab[1].checked = "false";
        document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=reset";
        document.forms[0].submit();
    }
    function funcReset()
    {
        document.forms[0].ftklab[0].disabled = "true";
        document.forms[0].ftklab[1].disabled = "true";

        getData();
    }


    function addSources()
    {
        var circleOfficeCode = document.forms[0].circleOfficeCode.value;
        var mandalCode = document.forms[0].mandalCode.value;
        var panchayatCode = document.forms[0].panchayatCode.value;
        var habCode = document.forms[0].habCode.value;
        var width = 850;
        var height = 450;
        var left = parseInt((screen.availWidth / 2) - (width / 2));
        var top = parseInt((screen.availHeight / 2) - (height / 2));
        var val = "yes";

        if (document.forms[0].panchayatCode.value != "")
        {
            if (document.forms[0].habCode.value != "")
            {

                var url = "switch.do?prefix=/masters&page=/Asset.do&mode=init&circleOfficeCode=" + circleOfficeCode + "&mandal=" + mandalCode + "&panchayatCode=" + panchayatCode + "&habCode=" + habCode + "&returnVal=" + val;
                var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
                        + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
                        + "resizable=yes,status=yes";
                newWindow = window.open(url, "_New", properties);
                newWindow.focus();
            } else
            {
                alert("Habitation is Required");
            }
        } else if (document.forms[0].mandalCode.value == "")
        {
            alert("Mandal is Required");
        } else
        {
            alert("Panchayat is Required");
        }


    }//end of showAssets
    function showSources()
    {

        var circleOfficeCode = document.forms[0].circleOfficeCode.value;
        var mandalCode = document.forms[0].mandalCode.value;
        var panchayatCode = document.forms[0].panchayatCode.value;
        var habCode = document.forms[0].habCode.value;
        var ftklab = "";

        ftklab = "lab";

        var width = 850;
        var height = 550;
        var left = parseInt((screen.availWidth / 2) - (width / 2));
        var top = parseInt((screen.availHeight / 2) - (height / 2));


        if (document.forms[0].mandalCode.value == "")
        {
            alert("Mandal Required");
        } else if (document.forms[0].panchayatCode.value == "")
        {
            alert("Panchayat Required");
        } else if (document.forms[0].habCode.value == "")
        {
            alert("Habitation is Required");
        } else
        {

            if (document.forms[0].circleOfficeCode.options != undefined)
            {
                var printString =
                        "District:" + document.forms[0].circleOfficeCode.options[document.forms[0].circleOfficeCode.selectedIndex].text
                        + " Mandal:" + document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
                        + " Panchayat:" + document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
                        + " Habitation:" + document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text;
            } else
            {
                var printString = "District:" + document.forms[0].circleOfficeName.value + " Mandal:" + document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
                        + " Panchayat:" + document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
                        + " Habitation:" + document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text;
            }

            var url = "switch.do?prefix=/wquality&page=/rws_select_sources_frm1.jsp?&habCode=" + habCode + "&ftklab=" + ftklab + "&printString=" + printString;
            var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
                    + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
                    + "resizable=yes,status=yes";
            newWindow = window.open(url, "_New", properties);
            newWindow.focus();
        }

    }
    function viewFtkSources() {

        var circleOfficeCode = document.forms[0].circleOfficeCode.value;
        var mandalCode = document.forms[0].mandalCode.value;
        var panchayatCode = document.forms[0].panchayatCode.value;
        var habCode = document.forms[0].habCode.value;
        var ftklab = "";

        ftklab = "lab";

        var width = 650;
        var height = 450;
        var left = parseInt((screen.availWidth / 2) - (width / 2));
        var top = parseInt((screen.availHeight / 2) - (height / 2));

        if (document.forms[0].panchayatCode.value != "")
        {
            if (document.forms[0].habCode.value != "")
            {
                var url = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=viewftkSources&ftktested=yes&circleOfficeCode=" + circleOfficeCode + "&mandalCode=" + mandalCode + "&panchayatCode=" + panchayatCode + "&habCode=" + habCode + "&ftklab=" + ftklab;
                var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
                        + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
                        + "resizable=yes,status=yes";
                newWindow = window.open(url, "_New", properties);
                newWindow.focus();
            } else
            {
                alert("Habitation is Required");
            }
        } else
        {
            if (document.forms[0].mandalCode.value != "")
            {
                var url = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=viewftkSources&ftktested=yes&circleOfficeCode=" + circleOfficeCode + "&mandalCode=" + mandalCode + "&ftklab=" + ftklab;
                var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
                        + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
                        + "resizable=yes,status=yes";
                newWindow = window.open(url, "_New", properties);
                newWindow.focus();
            } else
            {
                alert("Mandal Required");
            }
        }

    }

    function getData()
    {
        var getcheck = '<%= request.getParameter("mode")%>';

        document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=lab&getcheck=" + getcheck;
        document.forms[0].submit();

    }

    function getSourceCodes()
    {
        if (document.forms[0].mandalCode.value != "")
        {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk";
            document.forms[0].submit();
        } else
        {
            document.forms[0].sourceType.value = "";
            alert("Please Select Mandal");
        }
    }

    function getSourceLocation()
    {
        if (document.forms[0].habCode.value != "")
        {
            document.forms[0].action = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&ftklab=ftk";
            document.forms[0].submit();
        } else
        {
            document.forms[0].sourceType.value = "";
            alert("Please Select Habitation");
        }
    }
    function fnYrcreation()
    {
        var mydate = new Date();
        alert(mydate);
        if (document.forms[0].sampCollectDate.value >= mydate)
        {
            alert("Date must be less than or equal to current date");
            document.forms[0].sampCollectDate.value = '';
            document.forms[0].sampCollectDate.focus();
        }
    }
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<body onload = "checkforward();">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>	
    <html:form action="/WaterLabTesting.do" method="post">
    	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
        <html:hidden property="paramValue" />
        <jsp:include page="/commons/TableHeader.jsp">
            <jsp:param name="TableName" value="Water Quality Lab Testing" />
            <jsp:param name="TWidth" value="770" />
            <jsp:param name="contextHelpUrl" value="./help/WaterQuality.doc" />
        </jsp:include>
        <table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="810" border=1 style="border-collapse:collapse;" >
            <tr>
                <td  >
                    <fieldset>
                        <legend> Office Details </legend>
                        <label>
                            <table cellpadding="0" cellspacing="0" border="0"  width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
                                <tr>
                                    <td class="bwborder"><FONT class=myfontclr>Head Office&nbsp;:</FONT></td>
                                    <td class="bwborder">
                                        <html:text property="headOfficeName" name="RWS_USER" readonly="true"/>
                                        <html:hidden property="headOfficeCode" name="RWS_USER"/>
                                        <%String forwarded = (String) session.getAttribute("forwarded");
                                            String surccode = (String) session.getAttribute("forwardedsurcCode");
                                            String surctype = (String) session.getAttribute("forwardedsurcType");
                                            String forwardedftkid = (String) session.getAttribute("forwardedftkid");
                                            String forwardedmcode = "", forwardedpcode = "", forwardedhcode = "";
                                            if (surccode.length() > 10) {
                                                forwardedmcode = surccode.substring(5, 7);
                                                forwardedpcode = surccode.substring(12, 14);
                                                forwardedhcode = surccode.substring(0, 16);
                                            }
                                            java.util.Date systemdate = new java.util.Date(System.currentTimeMillis());
                                            java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                            String transdate = null;
                                            transdate = dateFormat.format(systemdate);

                                        %><html:hidden property="sysdate" value='<%=transdate%>'/>		
                                        <html:hidden property="forwarded" value='<%=forwarded%>'/>
                                        <html:hidden property="forwardedsurcCode" value='<%=surccode%>'/>
                                        <html:hidden property="forwardedsurcType" value='<%=surctype%>'/>
                                        <html:hidden property="forwardedftkid" value='<%=forwardedftkid%>'/>		
                                        <html:hidden property="forwardedmcode" value='<%=forwardedmcode%>'/>
                                        <html:hidden property="forwardedpcode" value='<%=forwardedpcode%>'/>
                                        <html:hidden property="forwardedhcode" value='<%=forwardedhcode%>'/>
                                    </td>

                                    <td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
                                    <td class="bwborder">
                                        <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
                                            <html:select property="circleOfficeCode" onchange="getData()" styleClass="combo">
                                                <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
                                                <logic:notEmpty name="circles">
                                                    <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
                                                </logic:notEmpty>			  
                                            </html:select>
                                        </logic:equal>
                                        <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
                                            <html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="text"/>
                                            <html:hidden property="circleOfficeCode" name="RWS_USER" />
                                        </logic:notEqual>
                                    </td>

                                    <td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
                                    <td class="bwborder">
                                        <logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
                                            <html:select property="divisionOfficeCode" onchange="getData()" styleClass="combo">
                                                <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
                                                <logic:notEmpty name="divisions">
                                                    <html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
                                                </logic:notEmpty>			  
                                            </html:select>
                                        </logic:equal>
                                        <logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
                                            <html:text property="divisionOfficeName" name="RWS_USER" readonly="true"/>
                                            <html:hidden property="divisionOfficeCode" name="RWS_USER" />
                                        </logic:notEqual>
                                    </td>

                                </tr>

                                <tr>
                                    <td class="bwborder"><FONT class=myfontclr>Sub Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
                                    <td class="bwborder">
                                        <logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
                                            <html:select property="subdivisionOfficeCode" onchange="getData()" styleClass="combo" >
                                                <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
                                                <logic:notEmpty name="subdivisions">
                                                    <html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
                                                </logic:notEmpty>
                                            </html:select>
                                        </logic:equal>
                                        <logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
                                            <html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true"/>
                                            <html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
                                        </logic:notEqual>
                                    </td>
                                    <% 
                                        String ftklabval = "lab";

                                        if (ftklabval != null && ftklabval.equals("lab")) {
                                            String special = (String) request.getAttribute("special");
                                            if (special == null) {
                                                special = "";
                                            }
                                    %>
                            </table>
                        </label>
                    </fieldset>
                    
                    <fieldset>
                        <legend  > Habitation Details </legend>
                        <label>

                            <table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
                                <tr>
                                    <td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td align=left >
                                        <html:select property="mandalCode" styleClass="mycombo" style="width:120px" onchange="getData()">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="mandals">
                                                <html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>
                                    <%if (special.equals("special")) { %>
                                    <td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td align=left>
                                        <html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="panchyats">
                                                <html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>
                                    <td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td align=left colspan="5">
                                        <html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="prhabs">
                                                <html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>
                                </tr>
                                <%} else if (special.equals("")) {  %>

                                <td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                <td align=left >
                                    <html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
                                        <html:option value="">SELECT...</html:option>
                                        <logic:notEmpty name="panchyats">
                                            <html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
                                        </logic:notEmpty>
                                    </html:select>
                                </td>
                                <td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                <td align=left colspan="5">

                                    <html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">

                                        <html:option value="">SELECT...</html:option>
                                        <logic:notEmpty name="prhabs">
                                            <html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
                                        </logic:notEmpty>
                                    </html:select>
                                </td>
                                </tr>
                                <%}
                                    }
								%> 
                                <tr><td colspan="10">&nbsp;</td></tr>
                                <tr>

                                    <td colspan="9" align="center">
                                        <html:button property="mode" styleClass="btext" value="Select Sources" onclick="return showSources()"/>&nbsp;
                                        <input type="button" Class="btext" value="Ftk Tested Sources" title="Ftk Tested Sources" style="width:140px" onclick="return viewFtkSources();"/>&nbsp;
                                    </td>  
                                </tr>
                            </table>
                        </label>
                    </fieldset>
                    <fieldset>             
                        <legend > Sample Collection Details</legend>
                        <label>
                            <table width="100%" cellspacing="4" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
                                <tr>
                                </tr>
                                <tr>
                                    <td class="bwborder" nowrap><FONT class=myfontclr>Source Type&nbsp;:<font color="#FF6666">*</font></FONT></td>

                                    <td class="bwborder">
                                        <html:hidden property="testId"/>
                                        <html:hidden property="ftktestid"/>
                                        <html:select property="sourceType" styleClass="mycombo" style="width:200px" disabled="true" >
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="sources1">
                                                <html:options collection="sources1" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />
                                            </logic:notEmpty>

                                        </html:select>
                                    </td>
                                    <html:hidden property="sourceType" />
                                    <html:hidden property="sourceCode" />


                                    <td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>

                                    <td class="bwborder" colspan="3">
                                        <html:select property="sourceCode"   styleClass="mycombo" disabled="true"  style="width:400px">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="sourceCodes">
                                                <html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
                                            </logic:notEmpty>
                                        </html:select>

                                    </td>


                                <tr>
                                    <td class="bwborder"><FONT class=myfontclr>Type of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td class="bwborder">
                                        <html:select property="testCode" styleClass="mycombo" style="width:123px" onchange="showForm()">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="watertests">
                                                <html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testName" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>

                                    <td class="bwborder"><FONT class=myfontclr>Nature of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td class="bwborder">
                                        <html:select property="natureOfTest" styleClass="mycombo" style="width:130px">
                                            <html:option value="">SELECT...</html:option>
                                            <html:option value="1">ROUTINE</html:option>
                                            <html:option value="2">SEASONAL</html:option>
                                            <html:option value="3">QUARTERLY</html:option>
                                            <html:option value="4">DISEASE OUTBREAK</html:option>
                                        </html:select>
                                    </td>

                                    <td class="bwborder"><FONT class=myfontclr>Sample Collected By&nbsp;:<font color="#FF6666">*</font></FONT></td>
                                    <td class="bwborder">
                                        <html:select property="sampCollectCode" styleClass="mycombo" style="width:133px">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="desgns">
                                                <html:options collection="desgns" name="rwsMaster"  property="desgnCode" labelProperty="desgnAcr" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>

                                </tr>
                                <tr>	

                                    <td class="bwborder"><FONT class=myfontclr>Collection Date<br>and Time&nbsp;:<font color="#FF6666">*</FONT></td>
                                    <td class="bwborder" nowrap>
                                        <html:text property="sampCollectDate" size="9"  styleClass="mytext" maxlength="10" readonly="true" />
                                        <html:text property="sampCollectTime" size="4" styleClass="mytext" maxlength="5" readonly="true" value='<%=new java.util.Date().getHours() + ":" + new java.util.Date().getMinutes()%>'/>
                                        <a href="javascript: showCalendar(document.forms[0].sampCollectDate);">
                                            <img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
                                        <FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;HH:MM</font></font>
                                    </td>


                                    <td class="bwborder"><FONT class=myfontclr>Assigned On&nbsp;:</FONT></td>
                                    <td class="bwborder"><html:text property="assignedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" readonly="true" styleClass="mytext"/></td>

                                    <%
                                        java.util.ArrayList col = new java.util.ArrayList();
                                    	col = (java.util.ArrayList) session.getAttribute("wqlabs"); 
                                    %>
                                    <td class="bwborder"><FONT class=myfontclr>Lab Assigned To<font color="#FF6666">*</font></FONT></td>
                                    <td class="bwborder" colspan="5"><html:select property="labCode" styleClass="mycombo" style="width:133px">
                                            <html:option value="">SELECT...</html:option>
                                            <logic:notEmpty name="wqlabs">
                                                <html:options collection="wqlabs" name="rwsMaster"  property="labCode" labelProperty="location" />
                                            </logic:notEmpty>
                                        </html:select>
                                    </td>
                                </tr>
                                <% %>
                            </table>
                        </label>
                    </fieldset>

                    <fieldset>             
                        <legend > Water Quality Parameters</legend>
                        <label>
                            <div style="height:220px; overflow:auto"> 
                                <table  bordercolor="#8A9FCD" width="99%" style="border-collapse:collapse;"  >
                                    <tr bgcolor="green"  >
                                        <td align=center ><b><font color="white">Sno</font></b></td>
                                        <td align=center ><b><font color="white">Parameter Name</font></b></td>
                                        <td align=center ><b><font color="white">Min Per Val</font></b></td>
                                        <td align=center ><b><font color="white">Max Per Val</font></b></td>
                                        <td align=center ><b><font color="white">Undesired Effect</font></b></td>
                                        <td align=center ><b><font color="white">Result</font></b></td>
                                    </tr>
                                    <%
                                    int val = -1;%>

                                    <nested:iterate id="TESTPARAM_LIST" property="wqtestParams">
                                        <tr align="left" bgcolor="lightblue" >
                                            
                                            <td  class="bwborder"><%=count1++%></td>

                                            <td  class="bwborder" >
                                                <nested:hidden name="TESTPARAM_LIST" property="testPCode" indexed="true"/> 
                                                <bean:write name="TESTPARAM_LIST" property="testPName"  />
                                                <%if(pValue.equals("13")) { %>
                                                    <% if (count1 - 1 == 3 || count1 - 1 == 4 || count1 - 1 == 5 || count1 - 1 == 6 || count1 - 1 == 9 || count1 - 1 == 10) {%>
                                                    <font color="red"><b>*</b></font>
                                                    <%} }else{%>
                                                    <% if (count1 - 1 == 4 || count1 - 1 == 5 || count1 - 1 == 6 || count1 - 1 == 7 || count1 - 1 == 10 || count1 - 1 == 11) {%>
                                                    <font color="red"><b>*</b></font>
                                                    <%} }%>
                                            </td>
                                            <td  class="bwborder" align=center>
                                                <bean:write name="TESTPARAM_LIST" property="minPerVal"></bean:write>
                                                <nested:hidden name="TESTPARAM_LIST" property="minPerVal" indexed="true"  />
                                            </td>
                                            <td  class="bwborder" align=center>
                                                <bean:write name="TESTPARAM_LIST" property="maxPerVal"  />
                                                <nested:hidden name="TESTPARAM_LIST" property="maxPerVal" indexed="true"  />
                                            </td>
                                            <td  class="bwborder" align=left width="200px">
                                                <bean:write name="TESTPARAM_LIST" property="undesirableEffect" />
                                            </td>
                                            <%
                                            val = val + 3;%>
                                            <td class="bwborder" align=center>
                                                <nested:text name="TESTPARAM_LIST" property="result" styleClass="mytbltext" style="width:70px" indexed="true" maxlength="9" />
                                            </td>
                                        </tr>
                                        <!--/logic:notEqual-->
                                    </nested:iterate>

                                </table>
                            </div>
                        </label>
                    </fieldset>
            </tr>

            <tr>	

                <td class="bwborder"><FONT class=myfontclr>Test Date:<font color="#FF6666">*</FONT>
                    <html:text property="testDate" size="9"  styleClass="mytext" maxlength="10" readonly="true" />
                    <a href="javascript: showCalendar(document.forms[0].testDate);">
                        <img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Potable:<html:select property="potable" styleClass="mycombo" style="width:133px">
                        <html:option value="">SELECT...</html:option>
                        <html:option value="Y">Yes</html:option>
                        <html:option value="N">No</html:option>
                    </html:select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Condemm The Source:<html:select property="condemTheSource" styleClass="mycombo" style="width:133px">
                        <html:option value="">SELECT...</html:option>
                        <html:option value="Y">Yes</html:option>
                        <html:option value="N">No</html:option>
                    </html:select>

                </td>
            </tr>
            <tr>
                <td class="bwborder"><FONT class=myfontclr>
                    Update Source Data:<html:select property="updateSourceData" styleClass="mycombo" style="width:133px">
                        <html:option value="">SELECT...</html:option>
                        <html:option value="Y">Yes</html:option>
                        <html:option value="N">No</html:option>
                    </html:select>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <FONT class=myfontclr>Forwarded On:
                    <html:text property="forwardedOn" size="9"  styleClass="mytext" maxlength="10" readonly="true" />
                    <a href="javascript: showCalendar(document.forms[0].forwardedOn);">
                        <img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a></FONT></FONT>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <FONT class=myfontclr>Recomendations:</FONT>&nbsp;&nbsp;&nbsp;&nbsp;<html:textarea property="recomended" style="width:133px">
                    </html:textarea>

                </td>
            </tr>

            <tr>
                <td align="center">
                    <% if (session.getAttribute("editCheck1") == null) {%>
                    <html:button property="mode1" title="Save the Fields"  styleClass="btext" value="Save" onclick="fnSave()"/>
                    <%}%>
                    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="Reset();" />
                    <%if (ftklabval != null && ftklabval.equals("lab")) {%>
                    <html:button property="mode" title="View the Fields(Lab testing)" styleClass="btext" value="View" onclick="labview();"/>
                    <%} else if (ftklabval != null && ftklabval.equals("ftk")) {
                    %>
                    <html:button property="mode" title="View the Fields( Ftk testing)" styleClass="btext" value="view" onclick="ftkview();" />
                    <% if (session.getAttribute("editCheck1") != null && session.getAttribute("editCheck1").equals("Y")) {%>
                    <html:button property="mode" title="Update the Fields( Ftk testing)" styleClass="btext" value="Update" onclick="ftkupdate();"/>
                     <%}} %>
                    <bean:define id="userId" name="RWS_USER" property="userId" />
                    <html:hidden property="preparedBy" value="<%=(String) userId%>"/>
                    <html:hidden property="preparedOn" value="<%=sdf.format(new java.util.Date())%>"/>
                    <%
                        session.setAttribute("water", "water");
                        session.getAttribute("water");                        
					%>
                </td>
            </tr>
        </table>
        <jsp:include page="/commons/TableFotter.jsp">
            <jsp:param name="TWidth" value="770"/>
        </jsp:include>
    </html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>