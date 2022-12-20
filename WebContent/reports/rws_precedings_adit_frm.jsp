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
{
	  var d=document.getElementById('demo1').value;
	  var d1=document.getElementById('demo2').value;
	  var pname=document.f1.program.value;
	  //alert(d+d1);
		if(d=='')
		{
			alert("Please Select From Date");
		}
	   else if(d1=='')
		{
			alert("Please Select To Date");
		}
	  else if(document.f1.program.value=='')
		{
		alert("Please Select program");
		return false;
		}
	 else if(document.f1.division.value=='')
		{
		alert("Please Select Division");
		return false;
		}


  else{
	    document.f1.prgname.value=pname;
		document.f1.fdate.value=d;
		document.f1.todate.value=d1;
		document.f1.div1.value = document.f1.division.options[document.f1.division.selectedIndex].text;
	    //alert(document.f1.prgname.value);
		//alert(document.f1.fdate.value);
		//alert(document.f1.todate.value);
		//alert(document.f1.div1.value);
        var fDate=getDateObject(document.f1.fdate.value,"-");
	    var tDate=getDateObject(document.f1.todate.value,"-");
	    if(fDate<=tDate)
		{
	    document.f1.action="rws_precedings_adit_rpt.jsp";
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
 String division=request.getParameter("division");
 String div="",cir="";
 
 stmt1=conn.createStatement();
if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest"))){}else
 {
    cir=loggedUser.substring(1,3);
	//System.out.println("cir::::::::"+cir);
	div=loggedUser.substring(3,4);
	//	System.out.println("div::::::::"+div);
 }


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
				
                <font color="#FFFFFF">Central/State Bills Audit Report</font>
			</td>	
		</tr>


 <tr><td class=rptLabel>From Bill-Date &nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="10" >
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td></tr>
<tr>
<td class=rptLabel>To Bill-Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo2" type="text" size="10">
       <a href="javascript:NewCal('demo2','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"  class="mycombo">
			<option value="">SELECT</option>
			<option value="01,48,49,02">COVERAGE</option>
			<option value="18,51">QUALITY</option>
			<option value="50,01">SUSTAINABILITY</option>
			<option value="32,60,01,23">O & M</option>
			<option value="11,58">DDP</option>
			<option value="59">CALAMITY</option>
		    </select>
			</td></tr> 
<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
	<%

	if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
	 {
		%>
	  <SELECT name="division" id="combo" class="mycombo" style="width:150px" >
		<option value="">SELECT</option>
     <%  String qry1="select  distinct circle_office_code,division_office_code,division_office_name  from rws_division_office_tbl a,rws_office_bank_account_tbl b where substr(b.office_code,2,2)=a.circle_office_code and substr(b.office_code,4,1)=a.division_office_code  order by division_office_name "; 
		 //System.out.println("qry1:"+qry1);
		 rs1=stmt1.executeQuery(qry1);
			 while(rs1.next())
			   {
			    	if(rs1.getString(1).equals(division))
						{
						%>
							 <option value="<%=rs1.getString(1)+rs1.getString(2)%>" selected><%=rs1.getString(3)%></option> 
							 	
					<%
						}
						else
						{
			%>
					 <option value="<%=rs1.getString(1)+rs1.getString(2)%>"><%=rs1.getString(3)%> </option>
				
			<%
				}%>
		
			<%}
			
	 }
	 else{
		 
		 String qry1="select  distinct circle_office_code,division_office_code,division_office_name,circle_office_code+division_office_code ,substr(b.office_code,2,3)  from rws_division_office_tbl a,rws_office_bank_account_tbl b where  circle_office_code='"+loggedUser.substring(1,3)+"' and  division_office_code= '"+loggedUser.substring(3,4)+"' "; 
		 System.out.println("qry12:"+qry1);
		 rs1=stmt1.executeQuery(qry1);
		 while(rs1.next())
		 {%>
				<input type="text" name="division1" readonly="true" class="mytext" style="width:150px" value="<%=rs1.getString(3)%>">
				<input type="hidden" name="division" value="<%=loggedUser.substring(1,3)+rs1.getString(1)%>">
	 <%}

  }
%>
</SELECT>
</td>
</tr>

<%
}
catch(Exception e1)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }

%>
   <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table><br><br><br>
<p align="center">
<font face="verdana" size="2" color="red">
Note********:Audit Report is generated based on To and From Bill Dates </font></p>
<font face="verdana" size="2" color="red">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note******:Programmes - Coverage includes ARWS,ARWS-SCP,NRDWP-COV,20%ARWS</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quality includes SMP,NRDWP-QA</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sustainability includes 5% ARWS and NRDWP-SUS</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O & M includes ARWS-Bharat Nirman,Bharat Nirman,15%ARWS,NRDWP-O&M</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DDp includes DDp,NRDWP-DDP</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Calamity includes NRDWP-Calamity</font></p>




<INPUT type="hidden" name="prgname">
<INPUT type="hidden" name="div1">
<INPUT type="hidden" name="fdate">
<INPUT type="hidden" name="todate">
</form>
</body>
</html>

<%@ include file = "footer.jsp" %>
