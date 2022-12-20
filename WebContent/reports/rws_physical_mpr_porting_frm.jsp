<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<%
ResultSet rs1=null,rs3=null;
    Statement stmt1=null,stmt3=null;
    String query = null,query1=null,query3=null;
	

 %>

<script>
 //date condition
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
  
	 
 //end


function fnSubmit()
{      var rep='';
       if(document.f1.reptype[0].checked)
		{
            rep='ENT';
			//alert("Entered Dates Rep"+rep);
		}
       
       if(document.f1.reptype[1].checked)
		{
		  rep='COM'
         // alert("Completed Dates Rep"+rep);
		}

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
        document.f1.reptype.value=rep;
        // alert(document.f1.fdate.value);
	    // alert(document.f1.todate.value);
         //alert("my rep type...."+rep);
		 var fDate=getDateObject(document.f1.fdate.value,"-");
	     var tDate=getDateObject(document.f1.todate.value,"-");
	    if(fDate<=tDate)
		{
	    document.f1.action="./rws_physical_mpr_porting_rpt.jsp";
		document.f1.submit();
		}
	    else
	    {
		 alert("To Date Must be always greater than From Date");   
		}
      }
  }
</script>
<%
try{
 nic.watersoft.commons.RwsUser user1=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
 String loggedUser = user1.getUserId();
 String data=request.getParameter("datewise");
 
 %>
<body>
<form name="f1"  method="post">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" width="300px">
		<tr align="right">
			<td class="bwborder"><a href="../home.jsp">Home</a>
			</td>
		</tr>
		</table>
</caption>


<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				
                <font color="#FFFFFF">Physical MPR Porting</font>
			</td>	
		</tr>


<tr bgcolor="#8A9FCD" align="center">
		<td align="center" colspan=3 class=btext>
			<input type="radio" name="reptype" id="con" value="ent" checked/>System Date  - Completion Date Entered <br>
            <input type="radio" name="reptype" id="det" value="comp" />Actual Date - Work Completed Date
		</td>
</tr>
 <tr><td class=rptLabel>From Date &nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" >
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>To Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10">
       <a href="javascript:NewCal('demo2','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 


<%
}
catch(Exception e1)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
  <tr>
		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="Start" class = btext></td>
	</tr>
  </table><br><br><br>

<INPUT type="hidden" name="fdate">
<INPUT type="hidden" name="todate">
<INPUT type="hidden" name="reptype">

</form>
</body>
</html>

<%@ include file = "footer.jsp" %>
