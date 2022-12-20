<%@ include file="/commons/rws_header1.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ page contentType="application/vnd.ms-excel" %>
<html>
<head>

<% DecimalFormat ndf = new DecimalFormat("####.00");
String 	tname="rws_habitation_directory_tbl"; 
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
Statement stmt11=conn.createStatement();
	Statement stmt4=conn.createStatement();
	
	ResultSet rs2=null,rs3=null,rs4=null,rs11=null;
	String qry1="",qry2="",qry3="",qry4="";
%>

<title>Unselected Bills  EE-Budget</title>
</head>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
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
	
	System.out.println("Inside excel file ....");
	%>



<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center" >
	

			
			 <tr align="center">
				<td class=gridhdbg rowspan="2">Sl. No.</td>
				<!-- <td class=gridhdbg rowspan="2">Circle</td> -->
				<td class=gridhdbg rowspan="2">EE-Forwarded Date</td>
				<!-- <td class=gridhdbg rowspan="2">District</td> -->
				<td class=gridhdbg rowspan="2">Division</td>
				<td class=gridhdbg rowspan="2">Work Id</td>
				<td class=gridhdbg rowspan="2">Work Name</td>
				<td class=gridhdbg rowspan="2">Estimation Cost</td>
				<td class=gridhdbg rowspan="2">Plain</td>
				<td class=gridhdbg rowspan="2">SC</td>
				<td class=gridhdbg rowspan="2">ST</td>
				<td class=gridhdbg rowspan="2">Total</td>
			</tr>
			<tr>
			</tr>
			
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
	<tr></tr>
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
	if(noOfHab != null && noOfHab.toString().trim().length()>0)
		nosHabs = Integer.parseInt(noOfHab.toString());
	if(workId != null && workId.toString().trim().length()>0)
		workID = workId.toString();
	if(billamt != null && billamt.toString().trim().length()>0)
		admissibleAmt = Double.parseDouble(billamt.toString());
	if(subprogCode != null && subprogCode.toString().trim().length()>0)
		subProgramCode = subprogCode.toString();
	
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
	System.out.println("pop44444:"+qry3);
		rs3=stmt3.executeQuery(qry3);
	while(rs3.next())
	{
	%>
	 <tr >
	
	<td class=<%=style %> style="text-align: left;" ><%=sno++%></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td>
		<%-- <td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td> --%>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="divName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workId" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="estCost" /></td>
		
	<%
	int totalp=rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
	//System.out.println("tpop:"+totalp);
	double billa=admissibleAmt;
	//System.out.println("billa:"+billa);
	 sca=billa*rs3.getInt(1)/totalp;
	 sta=billa*rs3.getInt(2)/totalp;
	 plaina=billa*rs3.getInt(3)/totalp;
//System.out.println("sta:"+sta);
stotnew=sca+sta+plaina;
//System.out.println("stotnewstotnewstotnewstotnew:"+stotnew);
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
		%>
		
		 <tr   >
	
	<td class=<%=style %> style="text-align: left;" ><%=sno++%></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td>
		<%-- <td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="eeFwdDate" /></td> --%>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="divName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workId" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="workName" /></td>
		<td class=<%=style %> style="text-align: left;" ><bean:write name="billsList" property="estCost" /></td>
		<%
		if(subProgramCode.equals("00"))	
		{
		qry4="select  nvl(CENSUS_SC_POPU,0) , nvl(CENSUS_ST_POPU,0) ,nvl(CENSUS_PLAIN_POPU,0) from RWS_EST_NEW_HAB_LNK_TBL a, rws_habitation_directory_tbl b   where work_id='"+workID+"' and a.hab_code=b.hab_code";
		//System.out.println("pop44444:"+qry4);
		rs4=stmt4.executeQuery(qry4);
		while(rs4.next())
			{
		int totalp1=rs4.getInt(1)+rs4.getInt(2)+rs4.getInt(3);
		//System.out.println("tpop00000000:"+totalp1);
		double billa1=admissibleAmt;
		//System.out.println("billa0000000000:"+billa1);
		if(totalp1>0){
		sca1=billa1*rs4.getInt(1)/totalp1;
		sta1=billa1*rs4.getInt(2)/totalp1;
		plaina1=billa1*rs4.getInt(3)/totalp1;
		}else{
			sca1=0;sta1=0;plaina1=0;
		}
		//System.out.println("sta00000000000:"+sta1);
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
			<td class=rptvalue align="right"><%=ndf.format(fftot)%></td>
		<%}else if(subProgramCode.equals("02")){
			ff1=admissibleAmt;
		
		ff=0.0;
		ff2=0.0;%>
		<td class=<%=style %> align="right"><%=ndf.format(ff1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff2)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff)%></td>
		<%fftot1=ff1+ff2+ff;
			//System.out.println("fftotfftotfftotfftotfftotffto1111111t"+fftot1);%>
			<td class=<%=style %> align="right"><%=ndf.format(fftot1)%></td>
			<%}else  if(subProgramCode.equals("03") || subProgramCode.equals("04")){
			ff2=admissibleAmt;
			ff1=0.0;
			ff=0.0;%>
		<td class=<%=style %> align="right"><%=ndf.format(ff1)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff2)%></td>
		<td class=<%=style %> align="right"><%=ndf.format(ff)%></td>
			<%fftot2=ff1+ff2+ff;
		//	System.out.println("fftotfftotfftotfftotfftot22222222fftot"+fftot2);%>
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


</table>



</body>
</html>