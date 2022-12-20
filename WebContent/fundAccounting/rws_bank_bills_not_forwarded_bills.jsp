<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>



<head>

<% DecimalFormat ndf = new DecimalFormat("####.00");
String 	tname="rws_habitation_directory_tbl"; 
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
Statement stmt11=conn.createStatement();
	Statement stmt4=conn.createStatement();
	
	ResultSet rs2=null,rs3=null,rs4=null;//,rs11=null;
	String qry1="",qry2="",qry3="",qry4="";
%>

<title>Unselected Bills  EE-Budget</title>
<style>
.diva
{
	width:14px;
	height:14px;
	clip:rect(0,14,14,0);
	overflow:hidden;
}
.spana
{
background-color:red;
position:relative;
top:-3px;
left:-3px;
}
.checka
{
margin:0;
padding:0;
FILTER:progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=50)-moz-opacity:0.1;
}
.mytext
{
	height:20px;
	font-size:11px;
	color:green;
	font-style:bold;
	
}
.thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
background-color: transparent;
z-index: 60;
}

.thumbnail span{ /*CSS for enlarged image*/
position: absolute;
background-color: lightyellow;
padding: 4px;
left: -1000px;
border: 1px dashed gray;
visibility: hidden;
color: black;
text-decoration: none;
}

.thumbnail span img{ /*CSS for enlarged image*/
border-width: 0;
padding: 2px;
}

.thumbnail:hover span{ /*CSS for enlarged image on hover*/
visibility: visible;
top: -120px;
left: -350px; /*position where enlarged image should offset horizontally */

}
</style>
<script language="javascript">

function getBills(){
	
var circle=document.forms[0].elements['circleCode'].value;
var divCode=document.forms[0].elements['divCode'].value;
var year=document.forms[0].elements['yearCode'].value;
var mnth=document.forms[0].elements['monthCode'].value;



 if(circle=="0"){
        alert("Please Select Circle");
        return false;
 }
 if(divCode=="0"){
     alert("Please Select Division");
     return false;
}
 if(year=="0"){
     alert("Please Select Year");
     return false;
}
 if(mnth=="0"){
     alert("Please Select Month");
     return false;
}

	
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/BANKBillUnSelectedAction.do&mode=billsUnselectedList";	
	document.forms[0].submit();
}

function getDivisions(){
	
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/BANKBillUnSelectedAction.do&mode=divisions";	
	document.forms[0].submit();
	
}


</script>

</head>
<body>
<% double scta=0.0,stta=0.0,plainta=0.0;
double scta1=0.0,stta1=0.0,plainta1=0.0,stotnew=0.0,stotnew1=0.0,fftot3=0.0,fftot4=0.0,fftot=0.0,fftot1=0.0,fftot2=0.0;
double stot1=0.0,stot2=0.0,stot=0.0;
double gsc=0.0,gst=0.0,gplain=0.0;
double a1=0.0,a2=0.0,a3=0.0;
double ff=0.0,ff1=0.0,ff2=0.0,rt=0.0,trt=0.0,rt1=0.0,trt1=0.0;
double sca=0.0,sta=0.0,plaina=0.0;
double sca1=0.0,sta1=0.0,plaina1=0.0,newtot=0.0;
	double scna1=0.0,stna1=0.0,plainna1=0.0,newntot=0.0,admissibleAmt = 0.0;
	int nosHabs = 0;
	String workID="",subProgramCode="";
	%>
<html:form  action="BANKBillUnSelectedAction.do" method="post"  >
			<table  border=0 rules=none style="border-collapse:collapse" align="right" >		
				<tr>
					<td align="right" class="bwborder">
							<a href="<rws:context page='/home.jsp'/>" >My Home</a><a href="#" onclick="window.print()" >&nbsp;&nbsp;<img src="<rws:context page='/images/print_icon.jpg'/>" width="30" height="30"></a>
							| <a
							href="switch.do?prefix=/fundAccounting&page=/BANKBillUnSelectedAction.do&mode=billsUnselectedListExcel" target="_new">&nbsp;&nbsp;<img
							
								src="<rws:context page='/images/excel_icon.jpg'/>" width="30" height="30"></a>
					</td>
				</tr>
			</table>

<table>

<logic:present name="circles">
					
						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="circleCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDivisions();">
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="circles" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					
					<logic:present name="divisions">
					
						<td class="textborder">Division<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="divCode" 
							style="width:143px" styleClass="mycombo"
							>
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="divisions" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					
					<logic:present name="yearsList">
					
						<td class="textborder">Year<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="yearCode" 
							style="width:143px" styleClass="mycombo"
							>
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="yearsList" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
					<logic:present name="monthsList">
					
						<td class="textborder">Month<span class="mandatory">*</span></td>
						<td class="textborder"><html:select  property="monthCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getBills();">
							<html:option value="0">
								<font class="myfontclr1">Select...</font>
							</html:option>
							<html:options collection="monthsList" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:present>
</table>
<div class='container'>
 <h2 id='mynav'></h2>

<table  align=center  style="border-collapse:collapse">
	
<thead class='header'>
			
			 <tr align="center">
				<td class=gridhdbg rowspan="2">Sl. No.</td>
				
				<td class=gridhdbg rowspan="2">EE-Forwarded Date</td>
				<!-- <td class=gridhdbg rowspan="2">District</td> -->
				<td class=gridhdbg rowspan="2">Division</td>
				<td class=gridhdbg rowspan="2">Work Id</td>
				<td class=gridhdbg rowspan="2">Bill Sl No.</td>
				<td class=gridhdbg rowspan="2">Work Name</td>
				<td class=gridhdbg rowspan="2">Estimation Cost</td>				
				<td class=gridhdbg rowspan="2">SC</td>
				<td class=gridhdbg rowspan="2">ST</td>
				<td class=gridhdbg rowspan="2">Plain</td>
				<td class=gridhdbg rowspan="2">Total</td>
			</tr>
			
			</thead>
			<tbody>
	<%
	 int sno=1,styleCount=0;
	String style="";
	double amt=0.0;
	int hab=0,sc=0,st=0,plain=0;
	%>
	<logic:notEmpty name="RwsBankBillActionForm" property="billsList">
	
	<logic:iterate id="billsList" name="RwsBankBillActionForm" property="billsList"  indexId="ndx" >
	
	<%
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	%>
	<logic:equal name="billsList" property="recordStatus" value="Error" >
	<%
	 style="gridbg3";
	%>
	<tr align="left" id='tr<%=sno%>' />
	</logic:equal>
	<logic:equal name="billsList" property="recordStatus" value="NOError" >
	<bean:define id="noOfHab" name="billsList" property="noOfHabs"  toScope="request" />
	<bean:define id="workId" name="billsList" property="workId"  toScope="request" />
	<bean:define id="billamt" name="billsList" property="billAmtAdmissible"  toScope="request" />
	<bean:define id="subprogCode" name="billsList" property="subProgramCode"  toScope="request" />
	
	<% 
	scta=0.0;stta=0.0;plainta=0.0;
	 sca=0.0;sta=0.0;plaina=0.0;stotnew=0.0;
	scna1=0;stna1=0;plainna1=0;newntot=0;
	admissibleAmt = 0.0;
	a1=0;
	plaina=0;
	a2=0;scta=0;
	a3=0;stta=0;
	stotnew=0;
	stotnew1=0;
	fftot3=0;
	fftot4=0;
	fftot=0;
	fftot1=0;
	fftot2=0;
	plainta=0;
	plainta1=0;
	scta1=0;
	stta1=0;
	newtot=0;
	nosHabs = 0;
	workID="";
	subProgramCode = "";
	//billamt = 0;
	if(noOfHab != null && noOfHab.toString().trim().length()>0)
		nosHabs = Integer.parseInt(noOfHab.toString());
	if(workId != null && workId.toString().trim().length()>0)
		workID = workId.toString();
	if(billamt != null && billamt.toString().trim().length()>0)
		admissibleAmt = Double.parseDouble(billamt.toString());
	if(subprogCode != null && subprogCode.toString().trim().length()>0)
		subProgramCode = subprogCode.toString();
	
	System.out.println("admissible amt :"+billamt+" admissibleAmt :"+admissibleAmt);
	if(nosHabs > 1)
	{
		qry2="select count(hab_code) from RWS_EST_NEW_HAB_LNK_TBL  where work_id='"+workID+"'";
	}
	else
	{
	    qry2="select count(hab_code) from rws_admn_hab_lnk_tbl  where work_id='"+workID+"'";
	}
	//System.out.println("hab33333:"+qry2);

	rs2=stmt2.executeQuery(qry2);
	
	while(rs2.next())
	{
		if(rs2.getInt(1)>1)
		{
		qry3="select  sum(nvl(CENSUS_SC_POPU,0)), sum(nvl(CENSUS_ST_POPU,0)) ,sum(nvl(CENSUS_PLAIN_POPU,0)) from RWS_EST_NEW_HAB_LNK_TBL a, "+tname+" b   where work_id='"+workID+"' and a.hab_code=b.hab_code";
	//System.out.println("pop44444:"+qry3);
		rs3=stmt3.executeQuery(qry3);
	while(rs3.next())
	{
	%>
	 <tr align="left" id='tr<%=sno%>'  >
	
	<td class=<%=style %> style="text-align: left;" ><%=sno++%></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td>
		<%-- <td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td> --%>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="divName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workId" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="billSlNo" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="estCost" /></td>
		
	<%
	int totalp=rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
	
	double billa=admissibleAmt;
	//System.out.println("billa:"+billa);
	 sca=billa*rs3.getInt(1)/totalp;
	 sta=billa*rs3.getInt(2)/totalp;
	 plaina=billa*rs3.getInt(3)/totalp;
//System.out.println("sta:"+sta);
stotnew=sca+sta+plaina;
		%>

		<td class=<%=style %> align="right"><%=ndf.format(sca)%></td>
	<td class=<%=style %> align="right"><%=ndf.format(sta)%></td>
	<td class=<%=style %> align="right"><%=ndf.format(plaina)%></td>
	<td class=<%=style %> align="right"><%=ndf.format(stotnew)%></td>
		
	
	</tr>
	<%
	}
		}else{
			stot=0;
			stot1=0;
			stot2=0;
			fftot=0;
		fftot1=0;
		fftot2=0;
		System.out.println("subprogram code :"+subProgramCode+" admissibleAmt :"+admissibleAmt);
		%>
		
		 <tr align="left" id='tr<%=sno%>'  >
	
	<td class=<%=style %> style="text-align: left;" ><%=sno++%></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td>
		<%-- <td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td> --%>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="divName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workId" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="billSlNo" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="estCost" /></td>
		<%
		if(subProgramCode.equals("00"))	
		{
			
		qry4="select  nvl(CENSUS_SC_POPU,0) , nvl(CENSUS_ST_POPU,0) ,nvl(CENSUS_PLAIN_POPU,0) from RWS_EST_NEW_HAB_LNK_TBL a, rws_habitation_directory_tbl b   where work_id='"+workID+"' and a.hab_code=b.hab_code";
		
		rs4=stmt4.executeQuery(qry4);
		while(rs4.next())
			{
		int totalp1=rs4.getInt(1)+rs4.getInt(2)+rs4.getInt(3);
		
		double billa1=admissibleAmt;
		
		if(totalp1>0){
		sca1=billa1*rs4.getInt(1)/totalp1;
		sta1=billa1*rs4.getInt(2)/totalp1;
		plaina1=billa1*rs4.getInt(3)/totalp1;
		}else{
			sca1=0;sta1=0;plaina1=0;
		}
	
		newtot=sca1+sta1+plaina1;
		%>
		<td class=<%=style %> align="right"><%=ndf.format(sca1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(sta1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(plaina1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(newtot)%></td>
		<%
		scna1+=sca1;
		stna1+=sta1;
		plainna1+=plaina1;
		newntot=scna1+plainna1+stna1;
			}
		}
		else if(subProgramCode.equals("01") || subProgramCode.equals("05") || subProgramCode.equals("06")){ 
		
			ff=admissibleAmt;
			ff1=0.0;
			ff2=0.0;
			fftot=ff1+ff2+ff;
		%>
		<td class=<%=style %> align="right"><%=ndf.format(ff1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff2)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff)%></td>
			<%fftot=ff1+ff2+ff;
			//System.out.println("fftotfftotfftotfftotfftotfftot"+fftot);%>
			<td class=<%=style %> align="right"><%=ndf.format(fftot)%></td>
		<%}else if(subProgramCode.equals("02")){
			
			ff1=admissibleAmt;
		
		ff=0.0;
		ff2=0.0;%>
		<td class=<%=style %> align="right"><%=ndf.format(ff1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff2)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff)%></td>
		<%fftot1=ff1+ff2+ff;
			%>
			<td class=<%=style %> align="right"><%=ndf.format(fftot1)%></td>
			<%}else  if(subProgramCode.equals("03") || subProgramCode.equals("04")){
			ff2=admissibleAmt;
			ff1=0.0;
			ff=0.0;%>
		<td class=<%=style %> align="right"><%=ndf.format(ff1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff2)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff)%></td>
			<%fftot2=ff1+ff2+ff;
		%>
			<td class=<%=style %> align="right"><%=ndf.format(fftot2)%></td>
		<%}			
	styleCount++;
		}
	}
	%>
	</tr>
	</logic:equal>

</logic:iterate>
</logic:notEmpty>
<%if(sno==1)
{
%><tr><td colspan="13" align="center" class="btext">No Records</td></tr><%}
else{%><%}%>

</tbody>
</table>
</div>

</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>
</html>