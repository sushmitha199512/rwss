// rwsWQLabValidate.js




function checkMandatory(names, displaymessage)
{
    var flags = false;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    if (values == null || values == "")
    {
        alert("Please Enter the value for " + displaymessage);
    } else
    {
        flags = true;
    }
    return flags;
}
function checkMandatoryAndRanges(names, displaymessage, min, max)
{
    var flags = false;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;

    if (values == null || values == "")
    {
        alert("Please Enter the value for " + displaymessage);
    } else
    {
        if(min==max)
        {
            if (parseFloat(values) != parseFloat(max))
            {
                alert(displaymessage + " Must be equal to " + max);
                flags = false;
            } else
            {
                flags = true;
            }
        }
        else
        {
            if (parseFloat(values) < parseFloat(min))
            {
                alert(displaymessage + " Must be greater than or equal to " + min);
                flags = false;
            } else if (parseFloat(values) > parseFloat(max))
            {
                alert(displaymessage + " Must be less than or equal to " + max);
                flags = false;
            } else
            {
                flags = true;
            }
        }
    }
    return flags;
}
function checkMandatoryAndRanges1(names, displaymessage, min, max)
{
    var flags = false;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    names = parseInt(names) - 1;
    var values1 = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    if (values == null || values == "")
    {
        alert("Please Enter the value for " + displaymessage);
    } else
    {
        if (parseFloat(values1) < parseFloat(values))
        {
            alert("Total Hardness(Value:" + values + ") must be less than Dissolved Solids(Value:" + values1 + ")");
        } else
        {
            flags = true;
        }
    }
    return flags;
}
function checkMandatoryAndRanges2(names, displaymessage, max)
{
    var flags = false;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    if (parseFloat(max) < parseFloat(values))
    {
        alert(displaymessage + "(Value:" + values + ") must be less than Totalhardness(Value:" + max + ")");
    } else
    {
        flags = true;
    }
    return flags;
}
function checkMandatoryAndRanges3(names, displaymessage, min, max)
{
    var flags = false;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    if (parseFloat(values) < parseFloat(min))
    {
        alert(displaymessage + " Must be greater than or equal " + min);
        flags = false;
    } else if (parseFloat(values) > parseFloat(max))
    {
        alert(displaymessage + " Must be less than or equal " + max);
        flags = false;
    } else
    {
        flags = true;
    }
    return flags;
}

function checkRanges3(names, displaymessage, min, max)
{
    var flags = true;
    var values = document.getElementById("TESTPARAM_LIST[" + names + "].result").value;
    if(values!=null && values!="")
    {
        if (parseFloat(values) < parseFloat(min))
        {
            alert(displaymessage + " Must be greater than or equal " + min);
            flags = false;
        } 
        if (parseFloat(values) > parseFloat(max))
        {
            alert(displaymessage + " Must be less than or equal " + max);
            flags = false;
        } 
    }
    return flags;
}

function checkMandatoryAndRanges4(names, displaymessage, min, max)
{
    var flags = false;
    if (parseFloat(min) < parseFloat(max))
    {
        alert("Dissolved Solids Value should be greater than the Sum of Total Hardness & Chloride");
        flags = false;
    } else
    {
        flags = true;
    }
    return flags;
}
function fnAdd1(testCode)
{
    var flag = false;
    if (testCode == "1")
    {
        if (checkMandatoryAndRanges('3', 'pH Ranges', 6, 9) == true)
        {
            if (checkMandatory('4', 'Dissolved Solids') == true)
            {
                if (checkMandatoryAndRanges1('5', 'Total Hardness') == true)
                {
                    if (checkMandatory('6', 'Alkalinity') == true)
                    {
                        if (checkMandatoryAndRanges2('7', 'Calcium', document.getElementById("TESTPARAM_LIST[5].result").value) == true)
                        {
                            if (checkMandatoryAndRanges2('8', 'Magnesium', document.getElementById("TESTPARAM_LIST[5].result").value) == true)
                            {
                                if (checkMandatory('9', 'Chloride') == true)
                                {
                                    if (checkMandatoryAndRanges('10', 'Fluoride', 0, 20) == true)
                                    {
                                        if (checkMandatoryAndRanges3('14', 'Manganese', 0, 99) == true)
                                        {
                                            if (checkMandatoryAndRanges3('15', 'Residual Chlorine', 0, 9) == true)
                                            {
                                                if (checkMandatoryAndRanges4('', '', document.getElementById("TESTPARAM_LIST[4].result").value, parseFloat(document.getElementById("TESTPARAM_LIST[5].result").value) + parseFloat(document.getElementById("TESTPARAM_LIST[9].result").value)) == true)
                                                {
                                                    flag = true;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } else if (testCode == "2")
    {
        if (checkMandatoryAndRanges('0', 'MPN Coliform Bacteria', 0, 1609) == true)
        {
            if (checkMandatoryAndRanges3('1', 'E-Coli', 0, 24) == true)
            {
                flag = true;
            }
        }
    }
    if (flag == true)
    {
        //var testIdd = '<%=testId%>';
        //var url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=saveQT&testId="+testIdd;
        //document.forms[0].action=url;
        //document.forms[0].submit();
        //window.close();
        return true;
    }
    return false;
}


function fnAdd2(testCode)
{
    var flag = false;
    if (testCode == "1")
    {
                if (checkMandatoryAndRanges('2', 'pH Ranges', 0, 9) == true)
                {
                    if (checkMandatoryAndRanges('3', 'Dissolved Solids',0,15000) == true)
                    {
                        if (checkMandatoryAndRanges('4', 'Alkalinity',0,600) == true)
                        {
                            if (checkMandatoryAndRanges('5', 'Total Hardness',0,1000) == true)
                            {
                                if (checkRanges3('6', 'Calcium',0,200) == true)
                                {
                                    if (checkRanges3('7', 'Magnesium', 0,200) == true)
                                   {
                                        if (checkMandatoryAndRanges('8', 'Chloride',0,1000) == true)
                                        {
                                            if (checkMandatoryAndRanges('9', 'Fluoride', 0, 9) == true)
                                            {
                                                if (checkRanges3('10', 'Nitrate', 0, 200) == true)
                                                {
                                                    if (checkRanges3('11', 'Sulphate', 0, 200) == true)
                                                    {
                                                        if (checkRanges3('12', 'Iron', 0, 5) == true)
                                                        {
                                                            if (checkMandatoryAndRanges4('', '', document.getElementById("TESTPARAM_LIST[3].result").value, parseFloat(document.getElementById("TESTPARAM_LIST[4].result").value) + parseFloat(document.getElementById("TESTPARAM_LIST[8].result").value)) == true)
                                                            {
                                                                flag = true;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
    } else if (testCode == "2")
    {
        if (checkMandatoryAndRanges('0', 'MPN Coliform Bacteria', 0, 1609) == true)
        {
            if (checkMandatoryAndRanges3('1', 'E-Coli', 0, 24) == true)
            {
                flag = true;
            }
        }
    }
    if (flag == true)
    {
        //var testIdd = '<%=testId%>';
        //var url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=saveQT&testId="+testIdd;
        //document.forms[0].action=url;
        //document.forms[0].submit();
        //window.close();
        return true;
    }
    return false;
}

function ValidNumber(value) {

    value = value - 1;
    var minValue = parseFloat(document.getElementById("TESTPARAM_LIST[" + value + "].minPerVal").value);
//alert(minValue);

    var maxValue = parseFloat(document.getElementById("TESTPARAM_LIST[" + value + "].maxPerVal").value);
//alert(maxValue);
    if (!isNaN(document.getElementById("TESTPARAM_LIST[" + value + "].result").value)) {
        var resultValue = parseFloat(document.getElementById("TESTPARAM_LIST[" + value + "].result").value);


//alert(resultValue);
        if (resultValue != "") {
            if (resultValue < minValue || resultValue > maxValue) {
                alert("Please re-check the reported value, as it is above/below the permissible range.");
                //document.getElementById("TESTPARAM_LIST[" + value + "].result").focus();
                //return false;
            }
        }
        return true;
    } else {
        document.getElementById("TESTPARAM_LIST[" + value + "].result").value = "";
//document.getElementById("TESTPARAM_LIST["+value-1+"].result").focus;
        alert("Invalid Number");
        return false;
    }

}



function ValidNumber1(value) {

    if (!isNaN(document.getElementById("TESTPARAM_LIST[" + value + "].result").value))
    {
        alert("inivalid number");
        return false;
    } else {
        return true;
    }




    if (document.getElementById("TESTPARAM_LIST[" + value + "].result").value == "") {
        return true;
    }
    // var regEx = /^\d{1,2}\.\d{1,2}$/;  
    //var regEx = /^\d{3}\.\d{3}$/;  
    var regEx = "/[0-9]{3}\.[0-9]{2}$/";
    bValid = document.getElementById("TESTPARAM_LIST[" + value + "].result").value.match(regEx);

    if (!bValid) {
        alert('incorrect format');
        document.getElementById("TESTPARAM_LIST[" + value + "].result").value = "";
        document.getElementById("TESTPARAM_LIST[" + value + "].result").focus;
        return false;
    } else
        return true;
}




function IsNumeric(input) {
    return /^-?(0|[1-9]\d*|(?=\.))(\.\d+)?$/.test(input);
}



