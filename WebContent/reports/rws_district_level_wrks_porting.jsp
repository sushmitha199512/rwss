<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

<title>WaterSoft</title>

<script language="JavaScript">

function fnSubmit()
{    
       //  alert("hai i am in excel jspppppppppppp");
	    var d=document.getElementById('demo1').value;
	    var d1=document.getElementById('demo2').value;

         if(d=='')
		{
			alert("Please Select From Date");
		}
	    else if(d1=='')
		{
			alert("Please Select To Date");
		}
      
       
		else
       {

	    document.forms[0].fdate.value=d;
		document.forms[0].todate.value=d1;

 		//alert("Date1"+d.split("-"));
		var dd1=d.split("-");
		var dd2=d1.split("-");
 		
       // alert("dd1[1]"+dd1[0]);
       // alert("dd1[2]"+dd1[1]);
       //  alert("dd1[3]"+dd1[2]);

       var arr1 = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
		  for( i = 0; i < arr1.length; i++)
          {
		     // alert("arr1[i]"+arr1[i]);
             if(dd1[1]==arr1[i])
             { i++;
               dd1[1]=i;
             }
               
		  }

         for( j = 0; j < arr1.length; j++)
          {
		     // alert("arr1[i]"+arr1[i]);
             if(dd2[1]==arr1[j])
             { j++;
               dd2[1]=j;
             }
               
		  }


         //alert("dd1[1]"+dd1[1]);
        //  alert("dd2[1]"+dd2[1]);  

        //myDate.setFullYear(2010,0,14);
		
		var d1 = new Date("October 13, 1975 11:13:00");
		var d2 = new Date("October 19, 1975 11:13:00")
		
		d1.setFullYear(dd1[2],dd1[1],dd1[0]);
		d2.setFullYear(dd2[2],dd2[1],dd2[0]);
	
		var diffDays = parseInt((d2 - d1) / (1000 * 60 * 60 * 24)); 
		// alert(diffDays);
     
        if(diffDays>31)
        {
            alert("Only Porting  for One Month is Allowed");
        }
		else
		{
	     document.forms[0].action="switch.do?prefix=/reports&page=/DistrictLevel.do?mode=get";
	  	 document.forms[0].submit();
		
        }
	 }
}

 
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<html:form action="DistrictLevel.do">


<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=30% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="./home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<!--<font color="#FFFFFF">Borewell Status Graph</font>-->
                <font color="#FFFFFF">District Level MPR And ProjectShelf Porting</font>
			</td>	
		</tr>

<TR> 
	<TD   valign=top  align="center" height="25%" width="30%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>

<tr><td class=rptLabel>From Date &nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" >
       <a href="javascript:NewCal('demo1','ddmmmyyyy')">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>To Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10">
       <a href="javascript:NewCal('demo2','ddmmmyyyy')">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
	</table>
	</TR>
<TR>	
<TD colspan=2 align=center valign=top>	

		<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="Start" class = btext></td>
	</tr>
</table>
	
</TD></TR>
</TABLE><br>
<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td><td class=rptValue nowrap>1. For District Level MPR , Update Date is Considered. </td></tr>
<br><tr><td bordercolor="black"></td><td class=rptValue nowrap>2. District Level Porting File contains both (PhysicalMPR data and respective ProjectShelf Data). </td></tr>
<br><tr><td bordercolor="black"></td><td class=rptValue nowrap>3. Only One Month Data can be Ported at a time. </td></tr>

</table>
<input type="hidden" name="dName"/>
<INPUT type="hidden" name="fdate">
<INPUT type="hidden" name="todate">

</html:form>
</body>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
		
%>
 alert('<%=request.getAttribute("message")%>');
<%
request.removeAttribute("message");
 }
%>
</script>


<%@ include file="/commons/rws_footer.jsp" %>
</html>
