
var i;

function isWhitespace(charToCheck)
{
    var whitespaceChars = " \t\n\r\f";
    return (whitespaceChars.indexOf(charToCheck) != -1);
}

function ltrim(str)
{
    for(var k = 0; k < str.length && isWhitespace(str.charAt(k)); k++);
    return str.substring(k, str.length);
}

function rtrim(str)
{
    for(var j=str.length-1; j>=0 && isWhitespace(str.charAt(j)) ; j--) ;
    return str.substring(0,j+1);
}

function trim(str)
{
    return ltrim(rtrim(str));
}

//function trim(obj)
//{
//    var temp="";
//    var c;
//    for(var i=0;i<obj.length;i++)
//    {
//        c= obj.substring(i,i+1);
//        if(c!=" ")
//            temp=temp+c;
//    }
//
//    return temp;
//}

function check_number(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)

    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    return true;
}

function check_empcode(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        return false;
    }
    if(a.indexOf(".")!=-1)

    {
        alert("Enter Valid "+s);
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        return false;
    }

    return true;
}

function check_number_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a))
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    if(a.length > 1)
    {
        var i,flg=0;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c!="0"))
            {
                flg=1;
                return true;
            }
            else
            {
                flg=0;
            }
        }
        if(flg==0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }

    return true;
}

function check_null_number(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(a.indexOf(".")!=-1)

        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(isNaN(a) || a<=0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function check_null_number_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(a.indexOf(".")!=-1)

        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(isNaN(a) || a<0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function check_decimal(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    return true;
}

function check_null_decimal(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(isNaN(a) || a<=0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
    return true;
}

function check_character(obj,s)
{
    var a=obj.value
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z") && a.charAt(i)!=" ")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}
/* newly added function by Siva*/
function check_null_character(obj,s)
{
    var a=obj.value
    var flag=true;
    if(trim(a)!="")
    {
        for(var i=0;i<a.length;i++)
        {
            if((a.charAt(i)<"a" || a.charAt(i)>"z")&&
                (a.charAt(i)<"A" || a.charAt(i)>"Z") && a.charAt(i)!=" ")
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }
        }
    }
    return true;
}

function check_character_nospace(obj,s)
{
    var a=obj.value
    var flag=true;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z"))
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function checkFirst_char(obj){
    if(!((obj<"a" || obj>"z")&&
        (obj<"A" || obj>"Z"))){
        return true;
    }
    else{
        return false;
    }
}

function check_alphanumeric(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(i==0){
            if(checkFirst_char(a.charAt(i))){
                flag=true;
            }
            else{
                flag=false;
                break;
            }
        }
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" ")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    if(!flag){
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    return true;
}

/* added by murali 12/04/2010  to check the input type alphanumeric*/
function check_alphanumeric_all(obj,s)
{
   var a=obj.value
    var flag=false;
     if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" " )
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    return true;
}

function check_pwd(obj,s)
{
    var a=obj.value

    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="_")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    return true;
}

function check_null_pwd(obj,s)
{
    var a=obj.value
    if(trim(a)!="")
    {
        for(var i=0;i<a.length;i++)
        {
            if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
                (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="_")
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}

//function check_pwd(obj,s)
//{
//    var a=obj.value
//    
//    if(trim(a)=="")
//    {
//        alert("Enter "+s)
//        obj.focus();
//        return false;
//    }
//    
//    re =/[#,@,_]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one Special Character # @  _");
//	obj.focus();
//       return false;
//	   }
//re = /[0-9]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one number (0-9)!");
//	obj.focus();
//       return false;
//	   }
//re = /[a-z,A-Z]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one letter (a-z,A-Z)!");
//	obj.focus();
//	return false;
//    }
//     for(var i=0;i<a.length;i++)
//    {
//        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
//            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="_" &&
//             a.charAt(i)!="#" && a.charAt(i)!="@" )
//            {
//            alert("Enter Valid "+s);
//            obj.focus();
//            return false;
//        }
//
//    }
//    return true;
//}
//function check_null_pwd(obj,s)
//{
//    var a=obj.value
//    if(trim(a)!="")
//    {
//        re =/[#,@,_]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one Special Character # @  _");
//	obj.focus();
//       return false;
//	   }
//re = /[0-9]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one number (0-9)!");
//	obj.focus();
//       return false;
//	   }
//re = /[a-z,A-Z]/;
//if(!re.test(obj.value)) {
//	alert("Password must contain at least one letter (a-z,A-Z)!");
//	obj.focus();
//	return false;
//    }
//     for(var i=0;i<a.length;i++)
//    {
//        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
//            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="_" &&
//             a.charAt(i)!="#" && a.charAt(i)!="@" )
//            {
//            alert("Enter Valid "+s);
//            obj.focus();
//            return false;
//        }
//
//    }
//    }
//    return true;
//}

/* newly added function */

function check_alphanumeric_nosapce(obj,s)
{

    var a=obj.value
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for( var i=0;i<a.length;i++)
    {

        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9"))
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }

    return true;

}

function check_null_alphanumeric_nosapce(obj,s)
{

    var a=obj.value
    var flag=false;
    if(trim(a)!="")
    {
        for( var i=0;i<a.length;i++)
        {
            if(i==0){
                if(checkFirst_char(a.charAt(i))){
                    flag=true;
                }
                else{
                    flag=false;
                    break;
                }
            }
            if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
                (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9"))
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;

}

function check_null_alphanumeric(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)!="")
    {
        for(var i=0;i<a.length;i++)
        {
            if(i==0){
                if(checkFirst_char(a.charAt(i))){
                    flag=true;
                }
                else{
                    flag=false;
                    break;
                }
            }
            if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
                (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" ")
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function check_address(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
           
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
           
           
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="-")))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
             
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

/* newly added function by Siva*/
function check_address_must(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    else{
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="-")))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }

}

/* newly added function*/

function check_address_braces(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c=="(")||(c==")")||(c=="-")))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function numCheck(nm) {
    for (var i=0;i<nm.length;i++)
        if ( isNaN(nm.substring(i,i+1)) || nm.substring(i,i+1)==" ")
            return false;
    return true;
}

function isDate(dt,s)
{
    var flag=false;
    var dtvals = dt.value.split("/");
    if (dtvals.length!=3)
    {
        alert("Enter Valid "+ s);
        dt.focus();
        return false;
    }
    for (var i=0;i<dtvals.length;i++)
        if (!numCheck(dtvals[i])||dtvals[i]=="0"||dtvals[i]=="")
        {
            flag=true;
        }
    if(flag==false)
    {
        var day = parseInt(dtvals[0],10);
        var mon = parseInt(dtvals[1],10);
        var year = parseInt(dtvals[2],10);

        if (day<1||day>31||mon<1||mon>12||year<1900 ||year>9999)
        {
            alert("Enter Valid "+ s);
            dt.focus();
            return false;
        }
        if (mon==4||mon==6||mon==9||mon==11)
            if (day>30)
            {
                alert("Enter Valid "+ s)
                dt.focus();
                return false;
            }
        if (mon==2)
            if(year%4==0 && year%100!=0 || year%400==0)
            {
                if (day>29)
                {
                    alert("Enter Valid "+ s);
                    dt.focus();
                    return false;
                }
            }
            else
            if (day>28)
            {
                alert("Enter Valid "+ s);
                dt.focus();
                return false;
            }

    }
    else
    if(flag==true)
    {
        alert("Enter Valid " +s);
        dt.focus();
        return false;
    }
    return true;
}

function isNullDate(dt,s)
{
    var a=dt.value;
    if(trim(a)=="")
    {
        return true;
    }
    else
    {
        var flag=false;
        var dtvals = dt.value.split("/");
        if (dtvals.length!=3)
        {
            alert("Enter Valid "+ s);
            dt.focus();
            return false;
        }
        for (var i=0;i<dtvals.length;i++)
            if (!numCheck(dtvals[i])||dtvals[i]=="0"||dtvals[i]=="")
            {
                flag=true;
            }
        if(flag==false)
        {
            var day = parseInt(dtvals[0],10);
            var mon = parseInt(dtvals[1],10);
            var year = parseInt(dtvals[2],10);

            if (day<1||day>31||mon<1||mon>12||year<1900 || year>9999)
            {
                alert("Enter Valid "+ s);
                dt.focus();
                return false;
            }
            if (mon==4||mon==6||mon==9||mon==11)
                if (day>30)
                {
                    alert("Enter Valid "+ s)
                    dt.focus();
                    return false;
                }
            if (mon==2)
                if(year%4==0 && year%100!=0 || year%400==0)
                {
                    if (day>29)
                    {
                        alert("Enter Valid "+ s);
                        dt.focus();
                        return false;
                    }
                }
                else
                if (day>28)
                {
                    alert("Enter Valid "+ s);
                    dt.focus();
                    return false;
                }

        }
        else
        if(flag==true)
        {
            alert("Enter Valid " +s);
            dt.focus();
            return false;
        }
    }
    return true;
}


function change_date_format(obj)
{
    var first_sep=obj.value.indexOf("/",0);
    var second_sep=obj.value.indexOf("/",first_sep+1);
    if (first_sep!=-1 && second_sep!=-1)
    {
        var d=obj.value.substring(0,first_sep);
        var m=obj.value.substring(first_sep+1,second_sep);
        if (d.length==1) d="0"+d;
        if (m.length==1) m="0"+m;
        obj.value=d+"/"+m+"/"+obj.value.substring(second_sep+1);
    }
    return true;
}

function isgtDate(fdate,sdate,fdatedesc,sdatedesc)
{
    var xd,xm,xyear;
    var x1d,x1m,x1year;
    xd=0;
    xm=0;
    xyear=0;
    x1d=0;
    x1m=0;
    x1year=0;
    var x=new Date(fdate);
    var x1=new Date(sdate);

    var first_sep,second_sep;
    var Input=fdate.value;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    xd=parseFloat(Input.substring(0,first_sep));

    xm=parseFloat(Input.substring(first_sep+1,second_sep));
    xyear=parseFloat(Input.substring(second_sep+1));

    Input=0;
    Input=sdate.value;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    x1d=parseFloat(Input.substring(0,first_sep));
    x1m=parseFloat(Input.substring(first_sep+1,second_sep));
    x1year=parseFloat(Input.substring(second_sep+1));

    if (x1year < xyear)
    {
        alert(sdatedesc +" " + sdate.value + " should be greater than or equals to "+ fdatedesc +" " +fdate.value);
        return false;
    }
    else
    {
        if(xyear==x1year)
        {
            if (x1m < xm)
            {
                alert(sdatedesc + " " + sdate.value + " should be greater than "+ fdatedesc+" " +fdate.value);
                return false;
            }
            else if(xm==x1m)
            {
                if(x1d < xd)
                {
                    alert(sdatedesc + " " + sdate.value + " should be greater than "+ fdatedesc+" " +fdate.value);
                    return false;
                }

            }
        }
    }
    return true;
}

function isltDate(fdate,sdate,fdatedesc,sdatedesc)
{
    var xd,xm,xyear;
    var x1d,x1m,x1year;
    xd=0;
    xm=0;
    xyear=0;
    x1d=0;
    x1m=0;
    x1year=0;
    var x=new Date(fdate);
    var x1=new Date(sdate);

    var first_sep,second_sep;
    var Input=fdate.value;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    xd=parseFloat(Input.substring(0,first_sep));

    xm=parseFloat(Input.substring(first_sep+1,second_sep));
    xyear=parseFloat(Input.substring(second_sep+1));

    Input=0;
    Input=sdate.value;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    x1d=parseFloat(Input.substring(0,first_sep));
    x1m=parseFloat(Input.substring(first_sep+1,second_sep));
    x1year=parseFloat(Input.substring(second_sep+1));

    if (x1year > xyear)
    {
        alert(sdatedesc +" " + sdate.value + " should be Less than or equals to "+ fdatedesc +" " +fdate.value);
        return false;
    }
    else
    {
        if(xyear==x1year)
        {
            if (x1m > xm)
            {
                alert(sdatedesc + " " + sdate.value + " should be Less than "+ fdatedesc+" " +fdate.value);
                return false;
            }
            else if(xm==x1m)
            {
                if(x1d > xd)
                {
                    alert(sdatedesc + " " + sdate.value + " should be Less than "+ fdatedesc+" " +fdate.value);
                    return false;
                }

            }
        }
    }
    return true;
}

function selectvalid(obj,desc)
{

    if(obj.selectedIndex=="0")
    {
        alert("Select "+desc);
        obj.focus();
        return false;

    }
    else
        return true;
}

function EmailValidation(Element)
{
    var flag=false;
    var stremail=Element.value;
    for(var i=0;i<stremail.length;i++)
    {
        if(i==0){
            if(checkFirst_char(stremail.charAt(i))){
                flag=true;
            }
            else{
                flag=false;
                break;
            }
        }
    }
    if(!flag){
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    var emailchar=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    if(emailchar.test(stremail))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function checkinitalpha(obj,desc)
{
    var temp=obj.value.charAt(0);
    if((temp<65 && temp!=47 ) ||(temp>90 && temp<97)||temp>122)
    {
        alert("First Character Must be either Alphabet or /");
        obj.value="";
        obj.focus();
        return false;
    }
    return true;
}

function checkmaxlen(obj,s,len)
{
    if(obj.value.length>len)
    {
        alert("Length of "+s+" should be maximum "+len);
        obj.focus();
        return false;
    }
    return true;
}

function checkminlen(obj,s,len)
{

    if(obj.value.length <len)
    {
        alert("Length of "+s+" should be minimum "+len );
        obj.focus();
        return false;
    }
    return true;
}

function checkpin(obj,s)
{
    if((obj.value!=""))
    {
        if((obj.value.length!=6))
        {
            alert("PIN code should be a six digit number")
            obj.focus();
            return false
        }
        if(!check_number(obj,s))
            return false
    }
    return true
}

/* newly added function to check the blood group name*/
function check_posneg(obj,s)
{
    var a=obj.value
    var flag=true;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for( var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="+" && a.charAt(i)!="-")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;

}

/* newly added function to check the special characters*/
function check_otherspecial_symbols(obj,s)
{
    var a=obj.value
    var flag=true;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(i==0){
            if(checkFirst_char(a.charAt(i))){
                flag=true;
            }
            else{
                flag=false;
                break;
            }
        }

        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="+" && a.charAt(i)!="-" && a.charAt(i)!="(" && a.charAt(i)!=")"
            && a.charAt(i)!="." && a.charAt(i)!="-" && a.charAt(i)!=" " && a.charAt(i)!="/" && a.charAt(i)!="&")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    if(!flag){
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    return true;

}

/* function to check the range of nationality*/
function checklength(obj,s,len)
{
    var a=obj.value;
    if(a.length>len)
    {
        alert("Length of "+s+" Must be "+len+" digits only");
        obj.focus();
        return false;
    }
    return true;
}

// newly added at 18-09-09
function check_address_null(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
             var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
             }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ") ||(c=="(")||(c==")") ||(c==".")||(c==",")||(c==":")||(c=="/")||(c=="-") || (c=='&')))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

// newly function for checkbox validation by Farzana
function checkBoxValidation(chkBoxName,s)
{
    var chks = document.getElementsByName(chkBoxName);
    var hasChecked = false;
    for (var i = 0; i < chks.length; i++)
    {
        if (chks[i].checked)
        {
           
           hasChecked = true;
            break;
        }
    }
    if (hasChecked == false)
    {
        alert("Select atleast one "+s);
        return false;
    }
    else
        return true;
}
 
 
// new function tocheck radio button is selected or not
function radioButtonValidation(radioButtonName,s)
{
    var chks = document.getElementsByName(radioButtonName);
    var hasChecked = false;
    for (var i = 0; i < chks.length; i++)
    {
        if (chks[i].checked)
        {
            hasChecked = true;
            break;
        }
    }
    if (hasChecked == false)
    {
        alert("Select option for "+s);
        return false;
    }
    return true;
}

// Function to check the time
function checkTime(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    else
    {
        var flag=false;
        var tvals = obj.value.split(":");
        if (tvals.length!=2)
        {
            alert("Enter Valid "+ s);
            obj.focus();
            return false;
        }
        for (var i=0;i<tvals.length;i++){
            if (!numCheck(tvals[i])||tvals[i]=="")
            {
                flag=true;
            }
        }
        if(flag==false)
        {
            var hour = parseInt(tvals[0]);
            var minute = parseInt(tvals[1]);


            if (hour<1||hour>12||minute<0||minute>59)
            {
                alert("Enter Valid "+ s);
                obj.focus();
                return false;
            }
        }
        else
        if(flag==true)
        {
            alert("Enter Valid " +s);
            obj.focus();
            return false;
        }
    }
    return true;
}

// To check the given date is greater than the minimum year
function isValidDate(dt,s,minYear)
{
    var flag=false;
    var dtvals = dt.value.split("/");
    if (dtvals.length!=3)
    {
        alert("Enter Valid "+ s);
        dt.focus();
        return false;
    }
    for (var i=0;i<dtvals.length;i++)
        if (!numCheck(dtvals[i])||dtvals[i]=="0"||dtvals[i]=="")
        {
            flag=true;
        }
    if(flag==false)
    {
        var day = parseInt(dtvals[0],10);
        var mon = parseInt(dtvals[1],10);
        var year = parseInt(dtvals[2],10);

        if (day<1||day>31||mon<1||mon>12||year<minYear)
        {
            alert("Enter Valid "+ s);
            dt.focus();
            return false;
        }
        if (mon==4||mon==6||mon==9||mon==11)
            if (day>30)
            {
                alert("Enter Valid "+ s)
                dt.focus();
                return false;
            }
        if (mon==2)
            if(year%4==0 && year%100!=0 || year%400==0)
            {
                if (day>29)
                {
                    alert("Enter Valid "+ s);
                    dt.focus();
                    return false;
                }
            }
            else
            if (day>28)
            {
                alert("Enter Valid "+ s);
                dt.focus();
                return false;
            }

    }
    else
    if(flag==true)
    {
        alert("Enter Valid " +s);
        dt.focus();
        return false;
    }
    return true;
}

// To check the dropdown list item is selcted or not
function selectvalid_Value(obj,desc)
{
    if(obj.selectedIndex=="-1")
    {
        alert("Select "+desc);
        obj.focus();
        return false;

    }
    else
        return true;
}



//Added on 18/07/2016
function check_Pancard(obj){
	 if (trim(obj.value)!='') {
        ObjVal = obj.value;
        var panPat = /^([a-zA-Z]{5})(\d{4})([a-zA-Z]{1})$/;
        if (ObjVal.search(panPat) == -1) {
            alert('Invalid Pan Number : ' + obj.value);
            obj.value="";
            obj.focus();
            return false;
        }
        return true;
    }
	 obj.focus();
         obj.value="";
	 alert('Invalid Pan Number : ' + obj.value);
	 return false;
}
function check_null_Pancard(obj){
	 if (trim(obj.value)!= '') {
       ObjVal = trim(obj.value);
       var panPat = /^([a-zA-Z]{5})(\d{4})([a-zA-Z]{1})$/;
       if (ObjVal.search(panPat) == -1) {
           alert('Invalid Pan Number : ' + obj.value);
           obj.focus();
           return false;
       }
       return true;
   }	 
	 return true;
}
function check_Phone_Number(obj){
	 if (trim(obj.value) != '') {
       ObjVal = trim(obj.value);
       var panPat = /^[0-9-+]+$/;
       if (ObjVal.search(panPat) == -1) {
           alert('Invalid Phone Number : ' + obj.value);
           obj.focus();
           return false;
       }
       return true;
   }
	 obj.focus();
	 alert('Invalid Phone Number : ' + obj.value);
	 return false;
}
function check_null_Phone_Number(obj,s,len){
 if (trim(obj.value)!='') {
	 if(checkminlen(obj, s, len)){
		 ObjVal = trim(obj.value); 
		 var panPat = /^[0-9-+]+$/;
		 if (ObjVal.search(panPat)==-1) {
	          alert('Invalid Phone Number : ' + obj.value);
	          obj.focus();
	          return false;
	      }
		 else
			 return true;
	 }
  return false;
 }
 return true;
}
var d=[
       [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
       [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
       [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
       [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
       [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
       [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
       [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
       [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
       [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
       [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
   ];
   // permutation table p
   var p=[
       [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
       [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
       [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
       [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
       [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
       [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
       [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
       [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
   ];
// inverse table inv
   var inv = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9];
   // converts string or number to an array and inverts it
   function invArray(array){
       if (Object.prototype.toString.call(array) == "[object Number]"){
           array = String(array);
       }
       if (Object.prototype.toString.call(array) == "[object String]"){
           array = array.split("").map(Number);
       }
    return array.reverse();
   }
// generates checksum
   function generate(array){
    var c = 0;
    var invertedArray = invArray(array);
    for (var i = 0; i < invertedArray.length; i++){
     c = d[c][p[((i + 1) % 8)][invertedArray[i]]];
    }
    return inv[c];
   }
   // validates checksum
   function check_Aathar(obj, s) {
	   var array=obj.value;
	   var c = 0;
	   if(check_number(obj, s)){
		   var invertedArray = invArray(array); 
		   for (var i = 0; i < invertedArray.length; i++){
		        c=d[c][p[(i % 8)][invertedArray[i]]];
		   }
		   if(c === 0)
			   return true;
		   else{
			   	alert("Invalid Aathar Number : " + array);
			   	obj.focus();
			   	return false;
		   }
	   }
	   else
		   obj.focus();
		   return false;       
   }
   function check_null_Aathar(obj, s) {
	   var c = 0;
	   var array=obj.value;
	   if(trim(array)=='')
		   return true; 
	   if(check_number(obj, s)){
		   var invertedArray = invArray(array); 
		   for (var i = 0; i < invertedArray.length; i++){
		        c=d[c][p[(i % 8)][invertedArray[i]]];
		   }
		   if(c === 0)
			   return true;
		   else{
			   obj.focus();
			   alert("Invalid Aathar Number : " + array);
			   return false;
		   }
	   }
	   else
		   obj.focus();
		   return false;       
   }   
   function NumToWord(inputNumber, outputControl) {
            inputNumber=Number(inputNumber).toString();
	    var str = new String(inputNumber)
	    var splt = str.split("");
	    var rev = splt.reverse();
	    var once = ['Zero', ' One', ' Two', ' Three', ' Four', ' Five', ' Six', ' Seven', ' Eight', ' Nine'];
	    var twos = ['Ten', ' Eleven', ' Twelve', ' Thirteen', ' Fourteen', ' Fifteen', ' Sixteen', ' Seventeen', ' Eighteen', ' Nineteen'];
	    var tens = ['', 'Ten', ' Twenty', ' Thirty', ' Forty', ' Fifty', ' Sixty', ' Seventy', ' Eighty', ' Ninety'];

	    numLength = rev.length;
	    var word = new Array();
	    var j = 0;
	    for (i = 0; i < numLength; i++) {
	        switch (i) {
	            case 0:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = '' + once[rev[i]];
	                }
	                word[j] = word[j];
	                break;

	            case 1:
	                aboveTens();
	                break;

	            case 2:
	                if (rev[i] == 0) {
	                    word[j] = '';
	                }
	                else if ((rev[i - 1] == 0) || (rev[i - 2] == 0)) {
	                    word[j] = once[rev[i]] + " Hundred ";
	                }
	                else {
	                    word[j] = once[rev[i]] + " Hundred and";
	                }
	                break;

	            case 3:
	                if (rev[i] == 0 || rev[i + 1] == 1) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if ((rev[i + 1] != 0) || (rev[i] > 0)) {
	                    word[j] = word[j] + " Thousand";
	                }
	                break;


	            case 4:
	                aboveTens();
	                break;

	            case 5:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if (rev[i + 1] !== '0' || rev[i] > '0') {
	                    word[j] = word[j] + " Lakh";
	                }

	                break;

	            case 6:
	                aboveTens();
	                break;

	            case 7:
	                if ((rev[i] == 0) || (rev[i + 1] == 1)) {
	                    word[j] = '';
	                }
	                else {
	                    word[j] = once[rev[i]];
	                }
	                if (rev[i + 1] !== '0' || rev[i] > '0') {
	                    word[j] = word[j] + " Crore";
	                }
	                break;

	            case 8:
	                aboveTens();
	                break;
	            default: break;
	        }
	        j++;
	    }
	    function aboveTens() {
	        if (rev[i] == 0) {
				word[j] = '';
			}
	        else if (rev[i] == 1) {
				word[j] = twos[rev[i - 1]];
			}
	        else {
				word[j] = tens[rev[i]];
			}
	    }
	    word.reverse();
	    var finalOutput = '';
	    for (i = 0; i < numLength; i++) {
	        finalOutput = finalOutput + word[i];
	    }
	    document.getElementById(outputControl).innerHTML = finalOutput;
	}
// End Added on 18/07/2016





/* To check the float value, added function by Farzana*/
function check_precision_decimal(obj,s,precision,scale)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+s);
        obj.focus();
        return false;
    }

    var tvals = obj.value.split(".");
    if (tvals.length>2)
    {
        alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
        obj.focus();
        return false;
    }

    if (tvals[0].length<=precision)
    {
        if(isNaN(tvals[0]) ||tvals[0]<=0 ){
            alert( "Enter valid"+ s);
            obj.focus();
            return false;
        }
    }
    else{
        alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
        obj.focus();
        return false;
    }
    if(tvals.length==2){
        if (tvals[1].length<=scale)
        {
            if(isNaN(tvals[1]) ||tvals[1]<0 ){
                alert( "Enter valid "+ s);
                obj.focus();
                return false;
            }
        }
        else{
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }
    }
    return true;
}

/*newly added function by Siva To check date is null or valid date*/
function check_null_isDate(dt,s)
{
    if(trim(dt.value)!="")
    {
        var flag=false;
        var dtvals = dt.value.split("/");
        if (dtvals.length!=3)
        {
            alert("Enter Valid "+ s);
            dt.focus();
            return false;
        }
        for (var i=0;i<dtvals.length;i++)
            if (!numCheck(dtvals[i])||dtvals[i]=="0"||dtvals[i]=="")
            {
                flag=true;
            }
        if(flag==false)
        {
            var day = parseInt(dtvals[0],10);
            var mon = parseInt(dtvals[1],10);
            var year = parseInt(dtvals[2],10);

            if (day<1||day>31||mon<1||mon>12||year<1900)
            {
                alert("Enter Valid "+ s);
                dt.focus();
                return false;
            }
            if (mon==4||mon==6||mon==9||mon==11)
                if (day>30)
                {
                    alert("Enter Valid "+ s)
                    dt.focus();
                    return false;
                }
            if (mon==2)
                if(year%4==0 && year%100!=0 || year%400==0)
                {
                    if (day>29)
                    {
                        alert("Enter Valid "+ s);
                        dt.focus();
                        return false;
                    }
                }
                else
                if (day>28)
                {
                    alert("Enter Valid "+ s);
                    dt.focus();
                    return false;
                }

        }
        else
        if(flag==true)
        {
            alert("Enter Valid " +s);
            dt.focus();
            return false;
        }
    }
    return true;
}

/*newly added function by Siva To comare whether second date is greater than first date or not with values*/
function isgtDateWithValues(fdate,sdate,fdatedesc,sdatedesc)
{
    var xd,xm,xyear;
    var x1d,x1m,x1year;
    xd=0;
    xm=0;
    xyear=0;
    x1d=0;
    x1m=0;
    x1year=0;
    var first_sep,second_sep;
    var Input=fdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    xd=parseFloat(Input.substring(0,first_sep));

    xm=parseFloat(Input.substring(first_sep+1,second_sep));
    xyear=parseFloat(Input.substring(second_sep+1));

    Input=0;
    Input=sdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    x1d=parseFloat(Input.substring(0,first_sep));
    x1m=parseFloat(Input.substring(first_sep+1,second_sep));
    x1year=parseFloat(Input.substring(second_sep+1));

    if (x1year < xyear)
    {
        alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
        return false;
    }
    else
    {
        if(xyear==x1year)
        {
            if (x1m < xm)
            {
                alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
                return false;
            }
            else if(xm==x1m)
            {
                if(x1d < xd)
                {
                    alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
                    return false;
                }
            }
        }
    }
    return true;
}

/*newly added function by Siva To comare whether first date is less than second date or not with values*/
function isltDateWithValues(fdate,sdate,fdatedesc,sdatedesc)
{
    var xd,xm,xyear;
    var x1d,x1m,x1year;
    xd=0;
    xm=0;
    xyear=0;
    x1d=0;
    x1m=0;
    x1year=0;
    var first_sep,second_sep;
    var Input=fdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    xd=parseFloat(Input.substring(0,first_sep));

    xm=parseFloat(Input.substring(first_sep+1,second_sep));
    xyear=parseFloat(Input.substring(second_sep+1));

    Input=0;
    Input=sdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    x1d=parseFloat(Input.substring(0,first_sep));
    x1m=parseFloat(Input.substring(first_sep+1,second_sep));
    x1year=parseFloat(Input.substring(second_sep+1));

    if (xyear > x1year )
    {
        alert(fdatedesc + " should be less than or equals to "+ sdatedesc);
        return false;
    }
    else
    {
        if(xyear==x1year)
        {
            if (xm >x1m )
            {
                alert(fdatedesc + " should be less than or equals to "+ sdatedesc);
                return false;
            }
            else if(xm==x1m)
            {
                if(xd>x1d)
                {
                    alert(fdatedesc + " should be less than or equals to "+ sdatedesc);
                    return false;
                }

            }
        }
    }
    return true;
}

/*newly added function by Siva To comare Date with Current Date and 01/01/1900*/
function compareDateWithCurrentDate(dt,todayDate,desc){

    if(isDate(dt,desc)&&
        isgtDateWithValues('01/01/1900',dt.value,'01/01/1900',desc) &&
        isltDateWithValues(dt.value,todayDate,desc,todayDate)){
        return true;
    }
    else
        return false;
}

/*newly added function by Reddaiah To change  uppercase letters */
function makeUppercase(obj)
{
    var a=obj.value;
    obj.value = a.toUpperCase();
//obj.focus();
}

/*newly added function by Reddaiah To converts cm to inches*/
function convert_CM_Inches(obj,targetObj)
{
    var a=obj.value;
    var num=a*0.3937008;
    num=(num*100)/100;
    targetObj.value = Math.round(num*Math.pow(10,2))/Math.pow(10,2);
}

/*newly added function by siva To validate image file*/
function validateImg(fObj,msg){
    //    alert("------------start");
    var isValidExt=false;
    var extensions = new Array("jpg","jpeg","gif","png","bmp");
    var image_file = fObj.value;
    if(image_file ==""){
        return true;
    }else{

        var image_length = fObj.value.length;
        var pos = image_file.lastIndexOf('.') + 1;
        var ext = image_file.substring(pos, image_length);
        var final_ext = ext.toLowerCase();
        for (i = 0; i < extensions.length; i++)
        {

            if(extensions[i] == final_ext)
            {
                isValidExt=true;
            }

        }
        if(!isValidExt){
            alert("You must upload an image file with one of the following extensions: "+ extensions.join(', ') +".");
            return false;
        }
        var size = 1;
        var y = document.images;
        var imglength = 0;
        for (i=0;i<y.length;i++)
        {
            imglength += (y[i].fileSize)*1;
        }
        var total = size + imglength;
        if(total>=102400){
            alert("File is large must be <= 102400 byte \n Your size is :"+total +" bytes");
            return false;
        }
    }
    return true;
}

// added by murali to check for date comparision in rti reply module
function isgreaterDate(fdate,sdate,fdatedesc,sdatedesc)
{

    var xd,xm,xyear;
    var x1d,x1m,x1year;
    xd=0;
    xm=0;
    xyear=0;
    x1d=0;
    x1m=0;
    x1year=0;
    var x=new Date(fdate);
    var x1=new Date(sdate);

    var first_sep,second_sep;
    var Input=fdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    xd=parseFloat(Input.substring(0,first_sep));

    xm=parseFloat(Input.substring(first_sep+1,second_sep));
    xyear=parseFloat(Input.substring(second_sep+1));

    Input=0;
    Input=sdate;
    first_sep=parseFloat(Input.indexOf("/",0));
    second_sep=parseFloat(Input.indexOf("/",first_sep+1));
    x1d=parseFloat(Input.substring(0,first_sep));
    x1m=parseFloat(Input.substring(first_sep+1,second_sep));
    x1year=parseFloat(Input.substring(second_sep+1));

    if (x1year < xyear)
    {
        alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
        return false;
    }
    else
    {
        if(xyear==x1year)
        {
            if (x1m < xm)
            {
                alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
                return false;
            }
            else if(xm==x1m)
            {
                if(x1d < xd)
                {
                    alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
                    return false;
                }

            }
        }
    }
    return true;
}

// added by murali
function EmailValidation_null(Element)
{
    var stremail=Element.value;
    var flag=false;
    if(trim(stremail)!="")
    {
        for(var i=0;i<stremail.length;i++)
        {
            if(i==0){
                if(checkFirst_char(stremail.charAt(i))){
                    flag=true;
                }
                else{
                    flag=false;
                    break;
                }
            }
        }
        if(!flag){
            alert("Enter valid eMail ID");
            Element.focus();
            return false;
        }
        var emailchar=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
        if(emailchar.test(stremail))
        {
            return true;
        }
        else
        {
            alert("Enter valid eMail ID")
            Element.focus();
            return false;
        }
    }
    return true;

}

/* To compare the passwords */
function comparePwd(pwd,cpwd){
    if(pwd.value==cpwd.value){
        return true;
    }
    else{
        pwd.focus();
        alert("Password mismatch")
        return false;
    }
}

/* To check the special characters */
function check_null_spl_chars(obj,s){
    var a=obj.value;
    if(trim(a)!="")
    {
        for(var i=0;i<a.length;i++)
        {
            if(i==0){
                if((a.charAt(i) >="0" && a.charAt(i)<="9")){
                    alert("Enter Valid "+s);
                    obj.focus();
                    return false;
                }
            }
            if(a.charAt(i)=="~"|| a.charAt(i)=="!" || a.charAt(i)=="@" || a.charAt(i)=="#" ||  a.charAt(i) =="$" || a.charAt(i) =="^" ||
                a.charAt(i)=="&" || a.charAt(i)=="*" || a.charAt(i)=="(" || a.charAt(i)==")" ||a.charAt(i)=="_" ||a.charAt(i)=="-" ||
                a.charAt(i)=="+" ||a.charAt(i)=="|" || a.charAt(i)=="}" || a.charAt(i)=="{" || a.charAt(i)=="[" || a.charAt(i)=="]" ||
                a.charAt(i)=="." ||  a.charAt(i)=="=" || a.charAt(i)=="/" || a.charAt(i)=="<" ||
                a.charAt(i)==">"||a.charAt(i)=="?")
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }
        }
    }
    return true;
}

function check_spl_chars(obj,s){
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }else
    {
        for(var i=0;i<a.length;i++)
        {

            if(a.charAt(i)=="~"|| a.charAt(i)=="!" || a.charAt(i)=="@" || a.charAt(i)=="#" ||  a.charAt(i) =="$" || a.charAt(i) =="^" ||
                a.charAt(i)=="&" || a.charAt(i)=="*" || a.charAt(i)=="(" || a.charAt(i)==")" ||a.charAt(i)=="_" ||a.charAt(i)=="-" ||
                a.charAt(i)=="+" ||a.charAt(i)=="|" || a.charAt(i)=="}" || a.charAt(i)=="{" || a.charAt(i)=="[" || a.charAt(i)=="]" ||
                a.charAt(i)=="." ||  a.charAt(i)=="=" || a.charAt(i)=="/" || a.charAt(i)=="<" ||
                a.charAt(i)==">"||a.charAt(i)=="?")
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }
        }
    }
    return true;
}

function convert_CM_Inches_1(val)
{
    if(val!=""){
        var a=val;
        var num=a*0.3937008;
        num=(num*100)/100;
        a = Math.round(num*Math.pow(10,2))/Math.pow(10,2);
        return a;
    }
    return "0.0";

}

//To Validate text area address
function check_address_textarea(obj,s,len)
{
    var a=obj.value;
    var flag=false;
    var textLen=a.length;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    else
    {
        var i;
        var rows=0;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if(!(isWhitespace(c))){
                if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                    flag=true;
                }
                if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".") ||(c=="(")||(c==")") ||(c==",")||(c==":")||(c=="/")||(c=="-")))
                {
                    alert(s +" should not contain special characters")
                    obj.focus()	;
                    return false;
                }
            }
            else{
                rows=rows+1;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(textLen+rows>len){
            alert(s +" Length should not exceed "+len+" characters")
            obj.focus()	;
            return false;
        }
    }
    return true;
}

function check_null_address_textarea(obj,s,len)
{
    var a=obj.value;
    var textLen=a.length;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        var rows=0;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if(!(isWhitespace(c))){
                if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                    flag=true;
                }
                if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":")||(c=="/")||(c=="-")||(c==")")||(c=="(")))
                {
                    alert(s +" should not contain special characters")
                    obj.focus()	;
                    return false;
                }
            }
            else{
                rows=rows+1;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(textLen+rows>len){
            alert(s +" Length should not exceed "+len+" characters")
            obj.focus()	;
            return false;
        }
    }
    return true;
}

function check_Year(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(trim(a).length<4)
    {
        alert("Enter "+s+" greater than 1900 ");
        obj.focus();
        return false;
    }
    if(trim(a)<'1900'){
        alert("Enter "+s+" greater than 1900 ");
        obj.focus();
        return false;
    }
    return true;
}

function check_martial_number(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)

    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    if(a>4||a<1)
    {
        alert(s+" should be in between 1 and 4");
        obj.focus();
        return false;
    }

    return true;
}

function check_alphacode_martial(obj,s)
{
    var a=obj.value;
    var flag=true;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    if(a=="D" || a=="M" || a=="U" || a=="W")
    {

        return true;
    }
    else{
        alert(s+" should be either D or M or U or W");
        obj.focus();
        return false;
    }
}

function check_name_martial(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    if(a=="Divorced" || a=="Married" || a=="Unmarried" || a=="Widowed")
    {

        return true;
    }
    else{

        alert(s+" should be either Divorced or Married or Unmarried or Widowed");
        obj.focus();
        return false;
    }
}

function isgtYear(ndate,oldDt,fdatedesc,sdatedesc)
{
    var newDt=ndate.value;
    if (newDt < oldDt)
    {
        alert(fdatedesc + " should be greater than "+ sdatedesc);
        ndate.focus();
        return false;
    }
    return true;
}

function check_alphanumeric_numeric(obj,s)
{
    var a=obj.value
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" ")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function check_null_alphanumeric_numeric(obj,s)
{
    var a=obj.value
    if(!(trim(a)==""))
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" ")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

/* function added by reddaiah */
function check_max_value(obj,s,maxval){
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(trim(a)>maxval){
        alert(s +" should not exceed "+maxval);
        obj.focus();
        return false;
    }
    return true;
}

/*  Author:Reddaiah */
function calculateAge(startDate,endDate){
    var dob=startDate.value;
    var doe=endDate.value;
    var  dobvals = dob.split("/");
    var dobday = parseInt(dobvals[0],10);
    var dobmon = parseInt(dobvals[1],10);
    var dobyear = parseInt(dobvals[2],10);
    var  doevals = doe.split("/");
    var doeday = parseInt(doevals[0],10);
    var doemon = parseInt(doevals[1],10);
    var doeyear = parseInt(doevals[2],10);
    var years=doeyear-dobyear-1;
    var months=12-dobmon+doemon;
    var days=dobday-doeday+1;
    if(days>0){
        months=months+1;
    }
    if(months>12){
        years=years+1;
    }
    if(years>=18){
        return true;
    }else return false;
}

/* To check the float value, added function by reddaiah*/
function check_null_precision_decimal(obj,s,precision,scale)
{
    var a=obj.value;
    if(trim(a)!=""){
        var tvals = obj.value.split(".");
        if (tvals.length>2)
        {
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }

        if (tvals[0].length<=precision)
        {
            if(isNaN(tvals[0]) ||tvals[0]<=0 ){
                alert( "Enter valid"+ s);
                obj.focus();
                return false;
            }
        }
        else{
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }
        if(tvals.length==2){
            if (tvals[1].length<=scale)
            {
                if(isNaN(tvals[1]) ||tvals[1]<0 ){
                    alert( "Enter valid "+ s);
                    obj.focus();
                    return false;
                }
            }
            else{
                alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
                obj.focus();
                return false;
            }
        }
        return true;
    }else{
        return true;
    }

}

/* To check the float value, including 0 value added function by Farzana on 01.05.2010 */
function check_precision_decimal_zero(obj,s,precision,scale)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+s);
        obj.focus();
        return false;
    }

    var tvals = obj.value.split(".");
    if (tvals.length>2)
    {
        alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
        obj.focus();
        return false;
    }

    if (tvals[0].length<=precision)
    {
        if(isNaN(tvals[0]) ||tvals[0]<0 ){
            alert( "Enter valid"+ s);
            obj.focus();
            return false;
        }
    }
    else{
        alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
        obj.focus();
        return false;
    }
    if(tvals.length==2){
        if (tvals[1].length<=scale)
        {
            if(isNaN(tvals[1]) ||tvals[1]<0 ){
                alert( "Enter valid "+ s);
                obj.focus();
                return false;
            }
        }
        else{
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }
    }
    return true;
}

/* To check the float value, including 0 value added function by Reddaiah on 11.05.2010 */
function check_null_precision_decimal_zero(obj,s,precision,scale)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        var tvals = obj.value.split(".");
        if (tvals.length>2)
        {
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }

        if (tvals[0].length<=precision)
        {
            if(isNaN(tvals[0]) ||tvals[0]<0 ){
                alert( "Enter valid"+ s);
                obj.focus();
                return false;
            }
        }
        else{
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }
        if(tvals.length==2){
            if (tvals[1].length<=scale)
            {
                if(isNaN(tvals[1]) ||tvals[1]<0 ){
                    alert( "Enter valid "+ s);
                    obj.focus();
                    return false;
                }
            }
            else{
                alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
                obj.focus();
                return false;
            }
        }
        return true;
    }else{
        return true;
    }
}

//check precision value null by (added by murali 23.03.10
function check_precision_decimal_null(obj,s,precision,scale)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        var tvals = obj.value.split(".");
        if (tvals.length>2)
        {
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }

        if (tvals[0].length<=precision)
        {
            if(isNaN(tvals[0]) ||tvals[0]<=0 ){
                alert( "Enter valid"+ s);
                obj.focus();
                return false;
            }
        }
        else{
            alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
            obj.focus();
            return false;
        }
        if(tvals.length==2){
            if (tvals[1].length<=scale)
            {
                if(isNaN(tvals[1]) ||tvals[1]<0 ){
                    alert( "Enter valid "+ s);
                    obj.focus();
                    return false;
                }
            }
            else{
                alert(s+" precision should be less than or equal to "+precision+" and decimal should be less than or equal to "+scale);
                obj.focus();
                return false;
            }
        }
    }
    return true;
}

/*newly added function by Murali To comare Date if it is null with Current Date and 01/01/1900*/
function compareDateWithCurrentDate_null(dt,todayDate,desc){
    var a=dt.value;
    if(trim(a)!="")
    {
        if(isDate(dt,desc)&&
            isgtDateWithValues('01/01/1900',dt.value,'01/01/1900',desc) &&
            isltDateWithValues(dt.value,todayDate,desc,todayDate)){
            return true;
        }
        else
            return false;
    }
    return true;
}

/*newly added function by Farzana To accept numeric characters also in
 *first letter of the address field for bidder regno on  21/04/2010 */
function check_address_numeric(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z") ||(c>="0" && c<="9") ){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") ||
                (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="-")))
                {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

/*newly added function by Farzana To accept numeric characters also in
 *first letter of the address field for bidder regno on  24/04/2010 */
function check_address_numeric_must(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    else{
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z") ||(c>="0" && c<="9") ){
                flag=true;
            }

            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="-")))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }

}

// added by murali 27/03/10  to check the null date comp
function isgreaterDate_null(fdate,sdate,fdatedesc,sdatedesc)
{
    var a=sdate;
    if(trim(a)=="")
    {
        return true;
    }
    else
    {
        var xd,xm,xyear;
        var x1d,x1m,x1year;
        xd=0;
        xm=0;
        xyear=0;
        x1d=0;
        x1m=0;
        x1year=0;
        var x=new Date(fdate);
        var x1=new Date(sdate);

        var first_sep,second_sep;
        var Input=fdate;
        first_sep=parseFloat(Input.indexOf("/",0));
        second_sep=parseFloat(Input.indexOf("/",first_sep+1));
        xd=parseFloat(Input.substring(0,first_sep));

        xm=parseFloat(Input.substring(first_sep+1,second_sep));
        xyear=parseFloat(Input.substring(second_sep+1));

        Input=0;
        Input=sdate;
        first_sep=parseFloat(Input.indexOf("/",0));
        second_sep=parseFloat(Input.indexOf("/",first_sep+1));
        x1d=parseFloat(Input.substring(0,first_sep));
        x1m=parseFloat(Input.substring(first_sep+1,second_sep));
        x1year=parseFloat(Input.substring(second_sep+1));

        if (x1year < xyear)
        {
            alert(sdatedesc + " should be greater than or equals to "+ fdatedesc);
            return false;
        }
        else
        {
            if(xyear==x1year)
            {
                if (x1m < xm)
                {
                    alert(sdatedesc + " should be greater than "+ fdatedesc);
                    return false;
                }
                else if(xm==x1m)
                {
                    if(x1d < xd)
                    {
                        alert(sdatedesc + " should be greater than "+ fdatedesc);
                        return false;
                    }

                }
            }
        }
    }
    return true;
}

/* added by murali 12/04/2010  to check the input type alphanumeric*/
function check_alphanumeric_slash(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        var c=a.substring(i,i+1)

        if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="/")||(c=="-")
            ||  (c==".")||(c==",")||(c==":") ||(c=="(")||(c==")")))
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    return true;
}

/* added by murali 12/04/2010  to check the input type alphanumeric*/
function check_alphanumeric_slash_null(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        return true;
    }
    else{
        for(var i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)

            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="/")||(c=="-")
                ||  (c==".")||(c==",")||(c==":") ||(c=="(")||(c==")")))
                {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}

/* added by murali 26/04/2010  to check null year*/
function check_Year_null(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(a.indexOf(".")!=-1)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(isNaN(a) || a<=0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(trim(a).length<4)
        {
            alert("Enter "+s+" greater than 1900 ");
            obj.focus();
            return false;
        }
        if(trim(a)<'1900'){
            alert("Enter "+s+" greater than 1900 ");
            obj.focus();
            return false;
        }
    }
    else{
        return true;
    }

    return true;
}

/* added by reddaiah 14/05/2010 to convertt to valid time format*/
function convertToValidTimeFormat(obj,msg){
    var a=obj.value;
    if(trim(a)!=""){
        if(checkTime(obj,msg)){
            var values=a.split(":");
            var hh=values[0];
            var mm=values[1];
            if(hh.length<2){
                hh="0"+hh;
            }
            if(mm.length<2){
                mm="0"+mm;
            }
            obj.value=hh+":"+mm;
        }
    }
}

//added by murali  17 may 2010..
// check given yr should be less than curr yr
function isltYear(nyr,curYr,givYr,currYr)
{
    var newDt=nyr.value;
    if (newDt > curYr)
    {
        alert(givYr + " should be less than or equals to "+ currYr);
        nyr.focus();
        return false;
    }
    return true;
}

//added by reddaiah 06.09.2010

function isgreaterAmount(famount,samount,famountdesc,samountdesc){
    famount=parseFloat(trim(famount));
    samount=parseFloat(trim(samount));
    if(samount>=famount){
        return true;
    }else{
        alert(samountdesc + " Should be greater than or equals to "+ famountdesc);
        return false;
    }
}

function islessAmount(famount,samount,famountdesc,samountdesc)
{
    famount=parseFloat(trim(famount));
    samount=parseFloat(trim(samount));
    if((samount<=famount)){
        return true;
    }else{
        alert(samountdesc + " Should be less than or equals to "+ famountdesc);
        return false;
    }
}

function isgreaterAmount_null(famount,samount,famountdesc,samountdesc){
    if(trim(samount)==""){
        return true;
    }else{
        return isgreaterAmount(famount,samount,famountdesc,samountdesc);
    }
}

function islessAmount_null(famount,samount,famountdesc,samountdesc){
    if(trim(samount)==""){
        return true;
    }else{
        return islessAmount(famount,samount,famountdesc,samountdesc);
    }
}

function getmonths(selmonth)
{
    selmonth.length=1;
    selmonth.options[1]=new Option("April",1);
    selmonth.options[2]=new Option("May",2);
    selmonth.options[3]=new Option("June",3);
    selmonth.options[4]=new Option("July",4);
    selmonth.options[5]=new Option("August",5);
    selmonth.options[6]=new Option("September",6);
    selmonth.options[7]=new Option("October",7);
    selmonth.options[8]=new Option("November",8);
    selmonth.options[9]=new Option("December",9);
    selmonth.options[10]=new Option("January",10);
    selmonth.options[11]=new Option("February",11);
    selmonth.options[12]=new Option("March",12);
    selmonth.selectedIndex=1;
}

function getMonthName(mnth) {
    var mnthname="";
    m=parseInt(mnth);
    switch(m)
    {
        case 1:
            mnthname="April";
            break;
        case 2:
            mnthname="May";
            break;
        case 3:
            mnthname="June";
            break;
        case 4:
            mnthname="July";
            break;
        case 5:
            mnthname="August";
            break;
        case 6:
            mnthname="September";
            break;
        case 7:
            mnthname="October";
            break;
        case 8:
            mnthname="November";
            break;
        case 9:
            mnthname="December";
            break;
        case 10:
            mnthname="January";
            break;
        case 11:
            mnthname="February";
            break;
        case 12:
            mnthname="March";
            break;
    }
    return mnthname;
}

function getSubCompName(comp) {
    var compname="";
    m=parseInt(comp);
    switch(m)
    {
        case 1:
            compname="GPF";
            break;
        case 2:
            compname="";
            break;
        case 3:
            compname="DAARR";
            break;
        case 4:
            compname="PRC";
            break;
        case 5:
            compname="TRANSFER";
            break;
    }
    return compname;
}

// add on 7-3-2012
//added by naveen 18.04.2011
// financial year end date
function compareDateWithFintoDate(dt,s)
{
    var dtvals = dt.value.split("/");
    if (dtvals.length!=3)
    {
        alert("Enter Valid "+ s);
        dt.focus();
        return false;
    }

    else
    {
        var day = parseInt(dtvals[0],10);
        var mon = parseInt(dtvals[1],10);
        var year = parseInt(dtvals[2],10);

        if((day==31)&&(mon==3))
        {
            return true;
        }
        else
        {
            alert("Enter "+s);
            return false;
        }
    }
}

// financial year from date
function compareDateWithFinfromDate(dt,s)
{
    var dtvals = dt.value.split("/");
    if (dtvals.length!=3)
    {
        alert("Enter Valid "+ s);
        dt.focus();
        return false;
    }

    else
    {
        var day = parseInt(dtvals[0],10);
        var mon = parseInt(dtvals[1],10);
        var year = parseInt(dtvals[2],10);

        if((day==1)&&(mon==4))
        {
            return true;
        }
        else
        {
            alert("Enter "+s);
            return false;
        }
    }
}

function periodcheckOneYear(frm,tod)
{
    var fir=new Array();
    var sec=new Array();

    var frmdt=frm.value;
    var todt=tod.value;

    fir =frmdt.split("/");
    sec =todt.split("/");

    firy=parseInt( fir[2],10 );
    secy=parseInt( sec[2],10 );
    if(firy<secy && (secy-firy)==1){
        return true;
    }else{
        alert("CurrentDemandYear should be one year");
        return false;
    }
}

// decimal or zero
function check_null_decimal_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(isNaN(a) || a<0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
    return true;
}

function checkmaxlength(obj,s,l)
{
    var a=obj.value;
    if(obj.value.length>l)
    {
        alert("Length of "+s+" less than "+l);
        obj.focus();
        return false;
    }
    return true;
}

//addedby naveen 8/6/2011
function getHtaxmonths(selmonth)
{
    selmonth.length=1;
    selmonth.options[0]=new Option("Select Month",0);
    selmonth.options[1]=new Option("April",1);
    selmonth.options[2]=new Option("May",2);
    selmonth.options[3]=new Option("June",3);
    selmonth.options[4]=new Option("July",4);
    selmonth.options[5]=new Option("August",5);
    selmonth.options[6]=new Option("September",6);
    selmonth.options[7]=new Option("October",7);
    selmonth.options[8]=new Option("November",8);
    selmonth.options[9]=new Option("December",9);
    selmonth.options[10]=new Option("January",10);
    selmonth.options[11]=new Option("February",11);
    selmonth.options[12]=new Option("March",12);
    selmonth.selectedIndex=0;

}

function getHtaxMonthName(mnth) {
    var mnthname="";
    m=parseInt(mnth);
    switch(m)
    {
        case 10:
            mnthname="January";
            break;
        case 11:
            mnthname="February";
            break;
        case 12:
            mnthname="March";
            break;
        case 1:
            mnthname="April";
            break;
        case 2:
            mnthname="May";
            break;
        case 3:
            mnthname="June";
            break;
        case 4:
            mnthname="July";
            break;
        case 5:
            mnthname="August";
            break;
        case 6:
            mnthname="September";
            break;
        case 7:
            mnthname="October";
            break;
        case 8:
            mnthname="November";
            break;
        case 9:
            mnthname="December";
            break;

    }
    return mnthname;
}

/* added by naveen 26/11/2011  to check the input type alphanumericnull*/
function check_null_alphanumeric_all(obj,s)
{
    var a=obj.value
    var flag=false;
    for(var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!=" " && a.charAt(i)!="/")
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    return true;
}

function selectproper(obj,desc)
{
    if(parseInt(obj.value)=="0")
    {
        alert("Select "+desc);
        obj.focus();
        return false;

    }
    else
        return true;
}

//malli
function check_null_asign_zero(obj)
{

    if (obj.value.length==0)
    {
        obj.value=0;
        return true ;
    }
    else
        return false;

}

function check_option(obj)
{

    if (obj.checked)
    {
        obj.value="Y";
    }
    else
        obj.value="N";

}

function Date_Diff(date1,date2)
{
    var day1,day2,month1,month2,year1,year2,days=0,event;
    if (Check_Date(date1,date1.value,event,true,'3'))
    {
        day1=day123;
        month1=month123;
        year1=year123;
    }
    else
    {
        //alert("Invalid date format ");
        return 1;
    }
    if (Check_Date(date2,date2.value,event,true,'3'))
    {
        day2=day123;
        month2=month123;
        year2=year123;
    }
    else
    {
        //alert("Invalid date format ");
        return 1;
    }
    D1= new Date();
    D1.setDate(day1);
    D1.setMonth(month1-1);
    D1.setYear(year1);
    D2=new Date();
    D2.setDate(day2);
    D2.setMonth(month2-1);
    D2.setYear(year2);
    if (D1 > D2)
    {
        for(var i=year2;i<=year1;i++)
        {
            dd1=new Date();
            dd2=new Date();
            dd1.setDate( (i==year2 ? day2:1) );
            dd1.setMonth( (i==year2 ? month2-1:0) );
            dd1.setYear( (i==year2 ? year2:i) );
            dd2.setDate( (i==year1 ? day1: 31) );
            dd2.setMonth( (i==year1 ? month1-1:11 ) );
            dd2.setYear(i);
            if (i!=year2)
            {
                for (var j=dd1.getMonth();j<=dd2.getMonth();j++)
                {
                    dd1.setDate((i==year1 && j==eval(month1-1)) ? day1:1);
                    days+=get_no_of_days(dd1.getDate(),j,dd1.getYear());
                }
            }
            else
            {
                for (var j=dd1.getMonth();j<dd2.getMonth();j++)
                {
                    dd1.setDate((i==year1 && j==eval(month1-1)) ? day1:1);
                    days+=get_no_of_days(dd1.getDate(),j,dd1.getYear());
                }
                if (dd1.getMonth()!=dd2.getMonth())
                    days+=eval(day2);
                else
                    days+=dd2.getDate()-dd1.getDate()+1;
            //alert(day2);
            }
        }
    }
    else
    {
        for(var i=year1;i<=year2;i++)
        {
            dd1=new Date();
            dd2=new Date();

            dd1.setMonth( (i==year1 ? month1-1:0) );
            dd1.setYear( (i==year1 ? year1:i) );
            dd2.setDate( (i==year2 ? day2: 31) );
            dd2.setMonth( (i==year2 ? month2-1:11 ) );
            dd2.setYear(i);
            dd1.setDate(i==year1 ? day1:1);
            if (i!=year2)
            {
                for (var j=dd1.getMonth();j<=dd2.getMonth();j++)
                {
                    dd1.setDate((i==year1 && j==eval(month1-1)) ? day1:1);
                    days+=get_no_of_days(dd1.getDate(),j,dd1.getYear());
                }
            }
            else
            {
                for (var j=dd1.getMonth();j<dd2.getMonth();j++)
                {
                    dd1.setDate((i==year1 && j==eval(month1-1)) ? day1:1);
                    days+=get_no_of_days(dd1.getDate(),j,dd1.getYear());
                }
                if (dd1.getMonth()!=dd2.getMonth())
                    days+=eval(day2);
                else
                    days+=dd2.getDate()-dd1.getDate()+1;
            //alert(day2);
            }
        }
    }
    return days;
}

function wordconversion(val){
    var digit = new Array("One","Two","Three","Four","Five","Six","Seven","Eight","Nine");
    var ten =   new Array("Ten","Twenty","Thirty","Fourty","Fifty","Sixty","Seventy","Eighty"
        ,"Ninty");
    var teen =  new Array("Ten","Eleven", "Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen");
    var a,n,flag,sp,i,word="";
    var c=new Array(5);
    var num=val;
    n=parseInt(num,10);
    if(n==0)
        if(n<0){
            sp=1;
            n=n*-1;
        }
    a=n;
    for(i=4;i>=1;i--){
        c[i]=n % 10;
        n=parseInt(n/10);
    }
    c[0]=n;
    if(sp==1)
        word="minus";
    flag=1;
    if(c[0]!=0)    {
        if(c[0]==1)        {
            word=word + teen[c[1]];
            flag=0;
        }
        else        {
            word=word + ten[c[0]-1];
        }
    }
    if(c[1]!=0 && flag !=0)    {
        word=word + digit[c[1]-1];
    }
    if(a>999)    {
        word=word+"Thousand"+"and";
    }
    if(c[2]!=0)    {
        word=word+digit[c[2]-1];
        word=word+"Hundred"+"and";
    }
    else
        flag=1;
    if(a>9)
        if(c[3]!=1)        {
            if((c[3]-1)<0)
                word=word+""
            else            {
                word=word + ten[c[3]-1];
            }
        }
    if(c[3]==1)    {
        word=word+ teen[c[4]];
    }
    if(c[4]!=0 && c[3]!=1)    {
        word=word+digit[c[4]-1];
    }
    return word;
}

function Check_Date(vDateName, vDateValue, e, dateCheck,dateType)
{
    var vYearLength = 2;
    var vYearType = 4;
    var isNav4;
    var strSeperator = "/";
    var vDateType;
    change_date_format(vDateName);
    vDateType = dateType;
    vDateValue=vDateName.value;
    //var whichCode = (window.Event) ? e.which : e.keyCode;
    var whichCode="0";
    var alphaCheck = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/-";
    if(isNaN(vDateValue.substr(6,4)))
    {

        return false;
    }
    if((vDateValue.substr(2,1) != "/") || (vDateValue.substr(5,1) != "/"))
    {
        return false;
    }
    if (alphaCheck.indexOf(vDateValue) >= 1)
    {
        vDateName.value = vDateName.value.substr(0, (vDateValue.length-1));
        return false;
    }
    if (whichCode == 8) //Ignore the Netscape value for backspace. IE has no value
        return false;
    else
    {
        var strCheck= '47,48,49,50,51,52,53,54,55,56,57,58,59,95,96,97,98,99,100,101,102,103,104,105';
        if (strCheck.indexOf(whichCode) != -1)
        {
            if (isNav4)
            {
                if (((vDateValue.length <6 && dateCheck) || (vDateValue.length==7 && dateCheck)) && (vDateValue.length >=1))
                {
                    return false;
                }
                if (vDateValue.length == 6 && dateCheck)
                {
                    var mDay = vDateName.value.substr(2,2);
                    var mMonth = vDateName.value.substr(0,2);
                    var mYear = vDateName.value.substr(4,4)

                    if (mYear.length == 2 && vYearType == 4)
                    {
                        var mToday = new Date();

                        //If the year is greater than 30 years from now use 19, otherwise use 20

                        var checkYear = mToday.getFullYear() + 30;
                        var mCheckYear = '20' + mYear;

                        if (mCheckYear >= checkYear)
                            mYear = '19' + mYear;
                        else
                            mYear = '20' + mYear;
                    }

                    var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;

                    if (!dateValid1(vDateValueCheck))
                    {
                        return false;
                    }
                }
                else
                {
                    // Reformat the date for validation and set date type to a 1

                    if (vDateValue.length >= 8  && dateCheck)
                    {

                        if (vDateType == 3) // ddmmyyyy
                        {
                            var mMonth = vDateName.value.substr(2,2);
                            var mDay=vDateName.value.substr(0,2);
                            var mYear=vDateName.value.substr(4,4)
                            vDateName.value = mDay+strSeperator+mMonth+strSeperator+mYear;
                        }


                        var vDateTypeTemp = vDateType;
                        vDateType = 1;
                        var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;

                        if (!dateValid1(vDateValueCheck))
                        {
                            //alert("Invalid Date\nPlease Re-Enter")
                            vDateType = vDateTypeTemp;
                            return false;
                        }
                        vDateType = vDateTypeTemp;
                        return true;
                    }
                    else
                    {
                        if (((vDateValue.length < 8 && dateCheck) ||(vDateValue.length==9 && dateCheck)) && (vDateValue.length >=1))
                        {
                            //alert("Invalid Date\nPlease Re-Enter")
                            return false;
                        }
                    }
                }
            }
            else
            {

                if (((vDateValue.length < 8 && dateCheck) || (vDateValue.length == 9&&dateCheck)) && (vDateValue.length >=1))
                {
                    //alert("Invalid Date\nPlease Re-Enter")
                    return false;
                }
                if (vDateValue.length >= 8 && dateCheck)
                {
                    if (vDateType == 3) // dd/mm/yyyy
                    {
                        var mDay = vDateName.value.substr(0,2);
                        var mMonth = vDateName.value.substr(3,2);
                        var mYear = vDateName.value.substr(6,4)
                    }

                    if (vYearLength == 4)
                        if (mYear.length < 4)
                        {
                            //alert("Invalid Date\nPlease Re-Enter");

                            return false;
                        }


                    var vDateTypeTemp = vDateType;

                    // Change vDateType to a 1 for standard date format for validation
                    // Type will be changed back when validation is completed.


                    // Store reformatted date to new variable for validation.

                    var vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;
                    if (!dateValid1(vDateValueCheck))
                    {
                        //  alert("Invalid Date\nPlease Re-Enter")
                        vDateType = vDateTypeTemp;
                        return false;
                    }
                    var startdate= new Date();
                    var myears=1900;
                    month123=vDateName.value.substring(3,5);
                    day123=vDateName.value.substring(0,2);
                    year123=vDateName.value.substring(6,10)

                    if (mYear < myears)
                    {
                        //alert("Invalid Date\nPlease Re-Enter")
                        return true;
                    }
                    else
                    {
                        if (priordate(mYear,mMonth,mDay))
                        {
                            //alert("Entered Date is greater than current date\nPlease Re-Enter")
                            return true;
                        }
                    }




                    if (mYear.length == 2 && vYearType == 4 && dateCheck) {
                        //Turn a two digit year into a 4 digit year
                        var mToday = new Date();
                        //If the year is greater than 30 years from now use 19, otherwise use 20
                        var checkYear = mToday.getFullYear() + 30;
                        var mCheckYear = '20' + mYear;
                        if (mCheckYear >= checkYear)
                            mYear = '19' + mYear;
                        else
                            mYear = '20' + mYear;
                        vDateValueCheck = mMonth+strSeperator+mDay+strSeperator+mYear;


                        if (vDateTypeTemp == 3) // dd/mm/yyyy
                            vDateName.value = mDay+strSeperator+mMonth+strSeperator+mYear;
                    }
                    if (!dateValid1(vDateValueCheck))
                    {
                        //alert("Invalid Date\nPlease Re-Enter")
                        vDateType = vDateTypeTemp
                        return false;
                    }
                    vDateType = vDateTypeTemp;
                    return true;
                }
                else {
                    if (vDateType == 1) {
                        if (vDateValue.length == 2) {
                            vDateName.value = vDateValue+strSeperator
                        }
                        if (vDateValue.length == 5) {
                            vDateName.value = vDateValue+strSeperator
                        }
                    }
                    if (vDateType == 2) {
                        if (vDateValue.length == 4) {
                            vDateName.value = vDateValue+strSeperator
                        }
                        if (vDateValue.length == 7) {
                            vDateName.value = vDateValue+strSeperator
                        }
                    }
                    if (vDateType == 3) {
                        if (vDateValue.length == 2) {

                            vDateName.value = vDateValue+strSeperator
                        }
                        if (vDateValue.length == 5) {
                            vDateName.value = vDateValue+strSeperator
                        }
                    }
                    return true
                }
            }

            if (vDateValue.length == 10&& dateCheck) {
                if (!dateValid1(vDateName)) {
                    // Un-comment the next line of code for debugging the dateValid() function error
                    //alert(err);
                    //alert("Invalid Date Please Re-Enter")
                    return false;
                  //  vDateName.select()
                }
            }
            vDateName.focus();
            return false
        }
        else {
            // If the value is not in the string return the string minus the last
            // key entered.
            if (isNav4) {
                vDateName.select()
                return false
            }
            else
            {
                vDateName.value = vDateName.value.substr(0, (vDateValue.length-1))
                vDateName.focus();
                return false

            }

        }
    }
}

function dateValid1(objName)
{
    var strDate;
    var strDateArray;
    var strDay;
    var strMonth;
    var strYear;
    var intday;
    var intMonth;
    var intYear;
    var booFound = false;
    var datefield = objName;
    var err = 0;
    var strSeparatorArray = new Array("-"," ","/",".");
    var intElementNr;

    var strMonthArray = new Array(12);
    strMonthArray[0] = "Jan";
    strMonthArray[1] = "Feb";
    strMonthArray[2] = "Mar";
    strMonthArray[3] = "Apr";
    strMonthArray[4] = "May";
    strMonthArray[5] = "Jun";
    strMonthArray[6] = "Jul";
    strMonthArray[7] = "Aug";
    strMonthArray[8] = "Sep";
    strMonthArray[9] = "Oct";
    strMonthArray[10] = "Nov";
    strMonthArray[11] = "Dec";

    strDate = objName;

    if (strDate.length < 1)
    {
        return false;
    }

    for(intElementNr=0;intElementNr<strSeparatorArray.length;intElementNr++)
    {
        if (strDate.indexOf(strSeparatorArray[intElementNr]) != -1)
        {
            strDateArray = strDate.split(strSeparatorArray[intElementNr]);
            if (strDateArray.length != 3)
            {
                err = 1;
                return false;
            }
            else
            {
                strDay = strDateArray[0];
                strMonth = strDateArray[1];
                strYear = strDateArray[2];
            }
            booFound = true;
        }
    }
    if (booFound == false)
    {
        if (strDate.length>5)
        {
            strDay = strDate.substr(0, 2);
            strMonth = strDate.substr(2, 2);
            strYear = strDate.substr(4);
        }
    }

    //Adjustment for short years entered

    if (strYear.length == 2)
    {
        strYear = '20' + strYear;
    }

    strTemp = strDay;
    strDay = strMonth;
    strMonth = strTemp;
    intday = parseInt(strDay, 10);

    if (isNaN(intday))
    {
        err = 2;
        return false;
    }

    intMonth = parseInt(strMonth, 10);

    if (isNaN(intMonth))
    {
        for (i = 0;i<12;i++)
        {
            if (strMonth.toUpperCase() == strMonthArray[i].toUpperCase())
            {
                intMonth = i+1;
                strMonth = strMonthArray[i];
                i = 12;
            }
        }

        if (isNaN(intMonth))
        {
            err = 3;
            return false;
        }
    }

    intYear = parseInt(strYear, 10);
    if (isNaN(intYear))
    {
        err = 4;
        return false;
    }

    if (intMonth>12 || intMonth<1)
    {
        err = 5;
        return false;
    }

    if ((intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth==7 ||intMonth == 8 || intMonth == 10 || intMonth == 12)&&(intday>31||intday <1))
    {
        err = 6;
        return false;
    }

    if ((intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth ==11)&&(intday > 30 || intday < 1))
    {
        err = 7;
        return false;
    }

    if (intMonth == 2)
    {
        if (intday < 1)
        {
            err = 8;
            return false;
        }

        if (LeapYear(intYear) == true)
        {
            if (intday > 29)
            {
                err = 9;
                return false;
            }
        }
        else
        {
            if (intday > 28)
            {
                err = 10;
                return false;
            }
        }
    }

    return true;
}

function priordate(mYear,mMonth,mDay)
{
    tdate =new Date()
    if(mYear < tdate.getYear())
        return false

    if(mYear >  tdate.getYear())
        return true

    if(mMonth < (tdate.getMonth()+1))
        return false

    if(mMonth > (tdate.getMonth()+1))
        return true

    if (mDay <= tdate.getDate())
        return false

    if (mDay > tdate.getDate())
        return true

    //alert("Date Could not be Checked")
    return true
}

function LeapYear(intYear)
{
    if (intYear % 100 == 0)
    {
        if (intYear % 400 == 0)
        {
            return true;
        }
    }
    else
    {
        if ((intYear % 4) == 0)
        {
            return true;
        }
    }
    return false;
}

function get_no_of_days(day,month,year)
{
    var days=0,leapyear=false;
    if (month==1)
    {
        if (year%4==0)
        {
            leapyear=true;
            if (year%100==0)
                if (year%400!=0)
                {
                    leapyear=false;
                }
        }
        // alert(leapyear);
        if (leapyear==true)
        {
            days=((day==1) ? 29 : 29-(day-1) );
            // alert(days);
            return days;
        }
        else
        {
            days=((day==1) ? 28 : 28-(day-1) );
            //alert(days);
            return days;
        }
    }
    if (month==0) {
        days=( (day==1) ? 31: 31-(day-1) ) ;
    }
    else
    if (month==2) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    else
    if (month==3) {
        days=( (day==1) ? 30: 30-(day-1) );
    }
    else
    if (month==4) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    else
    if (month==5) {
        days=( (day==1) ? 30: 30-(day-1) );
    }
    else
    if (month==6) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    else
    if (month==7) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    else
    if (month==8) {
        days=( (day==1) ? 30: 30-(day-1) );
    }
    else
    if (month==9) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    else
    if (month==10) {
        days=( (day==1) ? 30: 30-(day-1) );
    }
    else
    if (month==11) {
        days=( (day==1) ? 31: 31-(day-1) );
    }
    return days;

}

//23-01-2012
function check_alphanumeric_slash_hypen_null(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        return true;
    }
    else{
        for(var i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)

            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="/")||(c=="-")))
            {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}

function check_alphanumeric_slash_hypen(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    else{
        for(var i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)

            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="/")||(c=="-")))
            {
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}

function check_remarks_null(obj,s)
{

    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    { 
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ") ||(c=="(")||(c==")")))
            {
                alert(s +" should not contain special characters");
                 obj.focus();
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function check_loc(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(i=0;i<a.length;i++)
    {
        var c=a.substring(i,i+1)
        if((c>="a" && c<="z") || (c>="A" && c<="Z")){
            flag=true;
        }
        if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ") ||(c=="/")||(c=="-") || (c==":")))
        {
            alert(s +" should not contain special characters");
            obj.focus()	;
            return false;
        }
    }
    if(!flag){
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    return true;
}

function check_BirthConfirmremarks_null(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ") ||(c=="/")||(c=="-") || (c==":")))
            {
                alert(s +" should not contain special characters");
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            return false;
        }
    }
    return true;
}

// check number array separated by camma
function check_cama_numeric(obj,s)
{
    var a=obj.value
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    if(a.charAt(0)==',' || a.charAt(a.length-1)==','){
        alert("Enter Valid "+s+" but not Starts & Ends with 'COMMA'");
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if((a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="," || (a.charAt(i)==',' && a.charAt(i+1)==','))
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function taxcomp_check_number(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)

    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    return true;
}

function taxcomp_check_number_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(a.indexOf(".")!=-1)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    if(isNaN(a))
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }

    if(a.length > 1)
    {
        var i,flg=0;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c!="0"))
            {
                flg=1;
                return true;
            }
            else
            {
                flg=0;
            }
        }
        if(flg==0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }

    return true;
}

function taxcomp_check_decimal(obj,s)
{
    var a=obj.value;
    if(trim(a)=="")
    {
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    if(isNaN(a) || a<=0)
    {
        alert("Enter Valid "+s);
        obj.focus();
        return false;
    }
    return true;
}

function taxcomp_check_null_decimal_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(isNaN(a) || a<0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
    return true;
}

function taxcomp_check_null_number_zero(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(a.indexOf(".")!=-1)

        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(isNaN(a) || a<0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

function taxcomp_check_null_number(obj,s)
{
    var a=obj.value;
    if(trim(a)!="")
    {
        if(a.indexOf(".")!=-1)

        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        if(isNaN(a) || a<=0)
        {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;
}

//alphanumeric characters with telugu unicode chars + space or null
function valAlphaTelCharsNull(obj,s) {

    var a=obj.value;
    if(/^[a-zA-Z\u0C00-\u0C7f ]*$/.test(a)){
        return true;
    }
    else {
        alert("Enter valid "+s+".");
        obj.focus();
        return false;
    }
//        else if(/^[a-zA-Z ]*$/.test(a)){
//            return true;
//        }
// 

}

function check_htaxbklogaddress(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)!="")
    {
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
                         
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="-")))
            {
                alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            } 
            else
                flag=true;
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
    }
    return true;

}

function check_htax_doorno2(obj,s)
{
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
    {
        return true;
    }
    else{
        var c=a.substring(i,1);
        if(!(c=="/" || (c>="a" && c<="z") || (c>="A" && c<="Z")))
        {
            alert("First Character should be an Alphabet in Doorno2");
            return false;
        }
        
        else{
            for(var i=0;i<a.length;i++)
            {
                var c=a.substring(i,i+1)
            
                if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="/")||(c=="-")))
                {
                    alert("Enter Valid "+s);
                    obj.focus();
                    return false;
                }

            }
        }
    }
    return true;
}

//function check_number_greater_null(obj1,obj2,s1,s2)
//{
//    var a=obj1.value
//    var b=obj2.value;
//    if(check_number(a,s1) && check_number(b,s2))
//    {
//        if(eval(a) > eval(b) )
//            return true;
//        else
//        {
//            alert(s2 +"Should be Greater than "+s1);
//        }
//        return false;
//    }
//} 
function check_number_greater_null(obj1,obj2){
    alert("Year");
//    var a=obj1.value;
//    var b=obj2.value;
//    alert("Year");
//    if(trim(a)!=""&&trim(b)!="")
//    {                    
//        if(a<b)
//        {
//            alert("Year of "+s1 +"Should be Greater Than or Equal To Year of"+s2 );
//            obj2.focus();
//            return false;
//        }
//    }
    return true;  
    
    
 
}
function check_roadname(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    else{
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1)
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",") ||(c=="(")||(c==")") ||(c=="-") || (c=="/") || (c=="&")))
              {
                 alert(s +" should not contain special characters")
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
}
    function checkroadlength(obj,s)
{
   var a=obj.value;
       if(a.length!=7)
    {
      alert("Length of "+s+"  should be equals to 7");
      obj.focus();
      return false;
  }   else   
      return true;       
 }

function check_login_pwd(obj,s)
{
    var a=obj.value

    if(trim(a)=="")
    {
        alert("Enter "+s)
        obj.focus();
        return false;
    }
    for(var i=0;i<a.length;i++)
    {
        if(((a.charAt(i)<"a" || a.charAt(i)>"z")&&
            (a.charAt(i)<"A" || a.charAt(i)>"Z")) && (a.charAt(i) <"0" || a.charAt(i)>"9") && a.charAt(i)!="_" &&
             a.charAt(i)!="#" && a.charAt(i)!="@" )
            {
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }

    }
    return true;
}
 
      
function check_alphanumeric_hypen(obj,s){
    var a=obj.value
    var flag=false;
    if(trim(a)==""){
        alert("Enter "+ s);
        obj.focus();
        return false;
    }
    else{
        for(var i=0;i<a.length;i++){
            var c=a.substring(i,i+1)
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="-")||(c=="/")||(c=="(")||(c==")"))){
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}
function check_null_alphanumeric_hypen(obj,s){
    var a=obj.value
    var flag=false;
    if(trim(a)=="")
        return true;
    else{
        for(var i=0;i<a.length;i++){
            var c=a.substring(i,i+1)
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c=="-")||(c=="/")||(c=="(")||(c==")"))){
                alert("Enter Valid "+s);
                obj.focus();
                return false;
            }

        }
    }
    return true;
}
function check_address_special_char(obj,s){
    var a=obj.value;
    var flag=false;
    a=a.replace(/\t/g,' ');
    a=a.replace(/\n/g,' ');
    if(trim(a)==""){
        alert("Enter "+s);
        obj.focus();
        return false;
    }
    else{
        var i;
        for(i=0;i<a.length;i++){
            var c=a.substring(i,i+1);
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")")||(c=="/")||(c=="@")||(c=="&")||(c=="$")||(c=="%")||(c==">")||(c=="<")||(c=="=")||(c=="+")||(c=="-"))){
                alert(s +" should not contain special characters");
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
    
}


function check_address_mustWithAnd(obj,s)
{
    var a=obj.value;
    var flag=false;
    if(trim(a)=="")
    {
        alert("Enter "+s);
        obj.focus();
        return false;
    }
    else{
        var i;
        for(i=0;i<a.length;i++)
        {
            var c=a.substring(i,i+1);
            if((c>="a" && c<="z") || (c>="A" && c<="Z")){
                flag=true;
            }
            if (!((c>="a" && c<="z") || (c>="A" && c<="Z")|| (c>="0" && c<="9") || (c==" ")||(c==".")||(c==",")||(c==":") ||(c=="(")||(c==")") ||(c=="/")||(c=="&")||(c=="-")))
            {
                alert(s +" should not contain special characters");
                obj.focus()	;
                return false;
            }
        }
        if(!flag){
            alert("Enter Valid "+s);
            obj.focus();
            return false;
        }
        return true;
    }
}

