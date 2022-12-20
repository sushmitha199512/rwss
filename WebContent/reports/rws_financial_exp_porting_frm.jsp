<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.*" %>
<%@ include file = "conn.jsp" %>

<%		try{
		
java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
String transdate=null;
transdate=dateFormat.format(systemdate);
String year=transdate.substring(6);
// System.out.println("Date"+year);	 

%>
<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

<title>WaterSoft</title>

<script language="JavaScript">

function getDateObject(dateString,dateSeperator)
{
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;  
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
  	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth-1,cDate);	
	return dtObject;
} 

function fnSubmit()
{    

      var rep='';
       if(document.f1.reptype[0].checked)
		{
            rep='Schools';
			//alert("Schools"+rep);
		}
       
       if(document.f1.reptype[1].checked)
		{
		  rep='Works'
          // alert("Works"+rep);
		}






        document.f1.reptype.value=rep;
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
	    document.f1.fdate.value=d;
		document.f1.todate.value=d1;
		//var fDate=getDateObject(document.f1.fdate.value,"-");
	    //var tDate=getDateObject(document.f1.todate.value,"-");
	   // if(fDate<=tDate)
		//{
	    document.f1.action="rws_financial_exp_porting_rpt.jsp";
		document.f1.submit();
		//}
	  //  else
	  //  {
		// alert("To Date Must be always greater than From Date");   
		//}	 
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

<form name=f1 action="<%= request.getRequestURI()%>">


<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=30% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<!--<font color="#FFFFFF">Borewell Status Graph</font>-->
                <font color="#FFFFFF">Expenditure Porting</font>
			</td>	
		</tr>


<%
	String rDist = null;
    String  rYear=null;
	String rMonth=null;
	String dCode=null;
	String dName=null;
	
%>
<TR> 
	<TD   valign=top  align="center" height="25%" width="30%">

<%

 %>

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class=btext>
			<input type="radio" name="reptype" id="con" value="Schools" checked/>Schools</td>
           <td align="center" class=btext> <input type="radio" name="reptype" id="det" value="Works" />Works
		</td>
</tr>
<tr><td class=rptLabel>From Rel.Date &nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" >
       <a href="javascript:NewCal('demo1','ddmmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>To Rel.Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10">
       <a href="javascript:NewCal('demo2','ddmmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
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
	<%//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	
	
		%>
</TD></TR>
</TABLE><br>
<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td><td class=rptValue nowrap>Programmes Considered for Expenditure Porting are given below:</td></tr>
<br><tr><td bordercolor="black"></td><td class=rptValue nowrap><bean:message key="app.nrdwprelatedfin"/>


</td></tr>
</table>




<input type="hidden" name="dName"/>
<INPUT type="hidden" name="fdate">
<INPUT type="hidden" name="todate">
<INPUT type="hidden" name="reptype">

</form>

</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="connClose.jsp" %>  <%}finally{}%>


</html>
