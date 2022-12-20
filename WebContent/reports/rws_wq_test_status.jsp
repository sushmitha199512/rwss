<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
	<title>Report</title>
		<link rel="stylesheet" type="text/css" href="style.css"> 
</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}
</script>

<body>
<p align=right>
<%

String circlecode=null,divisioncode=null,subdivisioncode=null,mandalcode=null, labcode=null,sourcecode=null,circlename=null,divisionname=null,subdivisionname=null,labname=null,sourcename=null,year=null,yearcode=null,mname=null;
int slno=0;
	   circlename=(String)session.getAttribute("circleName");
	   divisionname=(String)session.getAttribute("divName");
	   subdivisionname=(String)session.getAttribute("subdivName");
	   labname=(String)session.getAttribute("lbName");
	   sourcename=(String)session.getAttribute("sName");
	   year=(String)session.getAttribute("yrName");
	   mname=(String)session.getAttribute("mandalName");
	   
	    //circlecode=(String)session.getAttribute("circleCode");
		circlecode=request.getParameter("district");
		//divisioncode=(String)session.getAttribute("divCode");
		divisioncode=request.getParameter("division");
		subdivisioncode=request.getParameter("subdivision");
		mandalcode=request.getParameter("mandal");
		//=(String)session.getAttribute("subdivCode");
		labcode= request.getParameter("lab");
		//(String)session.getAttribute("lbCode");
		sourcecode=request.getParameter("assetType");
		//=(String)session.getAttribute("sCode");
		
		//=(String)session.getAttribute("yrCode");
	//System.out.println("circlecode:"+circlecode);
	//System.out.println("divisioncode:"+divisioncode);
	//System.out.println("subdivisioncode:"+subdivisioncode);
	//System.out.println("mandalcode"+mandalcode);
	//System.out.println("Lab Code"+labcode);
	//System.out.println("Source Code"+sourcecode);
	
	yearcode=request.getParameter("year");
				String tdsfy[]=yearcode.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
	Statement  stmt1=null;
	ResultSet rst1=null;
		boolean circleflag=true;
		boolean divflag=true;
		boolean subdivflag=true;
		boolean manflag=true;
		if(circlecode!=null && !circlecode.equals("00"))
			circleflag=false;
		if(divisioncode!=null && !divisioncode.equals("-1"))
			divflag=false;
		if(subdivisioncode!=null && !subdivisioncode.equals("-1"))
			subdivflag=false;
		if(mandalcode!=null && !mandalcode.equals("-1"))
			manflag=false;
		%>
<table border = 0 width=100%><tr><td>
<table border = 0 width=20% align=left>
<tr><td colspan=2><b><font face=verdana size=2>Selection Criteria:</font></b></td></tr>
<%if(request.getParameter("circleName")!=null && !request.getParameter("circleName").equals("")){ %>
<tr><td class=btext>Circle:</td><td><font face=verdana size=2><%=request.getParameter("circleName")%></td></tr>
<%}if(request.getParameter("divisionName")!=null && !request.getParameter("divisionName").equals("")){ %>
<tr><td class=btext>Division:</td><td><font face=verdana size=2><%=request.getParameter("divisionName")%></td></tr>
<%}if(request.getParameter("subdivisionName")!=null && !request.getParameter("subdivisionName").equals("")){ %>
<tr><td class=btext>Sub Division:</td><td><font face=verdana size=2><%=request.getParameter("subdivisionName")%></td></tr>
<%}
// System.out.println("mname:"+request.getParameter("mandalName"));
if(request.getParameter("mandalName")!=null && !request.getParameter("mandalName").equals("")){ %>
<tr><td class=btext>Mandal:</td><td><font face=verdana size=2><%=request.getParameter("mandalName")%></td></tr>
<%}%>
</table></td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="./rws_lab_test_frm.jsp">Back| 
                    <a href="./rws_wq_test_status_excel_rpt.jsp?circlecode=<%=circlecode%>&divisioncode=<%=divisioncode%>&subdivisioncode=<%=subdivisioncode%>&mandalcode=<%=mandalcode%>&sourcecode=<%=sourcecode%>&yearcode=<%=yearcode%>& labcode=<%=labcode%>&circleName=<%=circlename%>&divisionName=<%=divisionname%>
					&subdivisionName=<%=subdivisionname%>&mandalName=<%=mname%>" target="_new">Excel</a></td>
				</tr>
			</table>
		</caption>
		 <tr align=center  align=center>
		<td class=btext >Sl.No</td>
		<%if(circleflag) {%><td class=btext >Circle</td><%}%>
		<%if(divflag) {%><td class=btext >Division</td><%}%>
		<%if(subdivflag) {%><td class=btext >Sub Division</td><%}%>
		<%if(manflag) {%><td class=btext >Mandal</td><%}%>
		<td class=btext >Habitation</td>
		<td class=btext >Test</td>
		<td class=btext >Source Code</td>
		<td class=btext>Source Name</td>
		<td class=btext>Lab Name</td>
		<td class=btext>Sample<br>Collected By</td>
		<td class=btext>Sample Collected Date</td>
		<td class=btext>Lab Assigned Date</td>
		 <td class=btext>Tested Date</td>
		</tr>
	<%
       try
		{	
	  String str="select DISTINCT sc.circle_office_code,v.circle_office_name,v.division_office_code,v.division_office_name,v.subdivision_office_code,v.subdivision_office_name, sc.source_code,decode (sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','020 1002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS'), l.location,t.test_name,l.lab_name,nvl(to_char(sc.SAMP_COLLECT_DATE,'dd-MON-yyyy'),'-'),nvl(to_char(sc.assigned_on,'dd- MON- yyyy'),'-'),decode(sc.Nature_of_test,'1','Routine','2','Seasonal','3','Quaterly','4','OutBreak'),sc.test_id,t.test_code,m.mcode, m.mname  from rws_water_sample_collect_tbl sc, rws_complete_office_view  v, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t, rws_mandal_tbl m where sc.lab_code=l.lab_code and sc.test_code=t.test_code and v.circle_office_code=sc.circle_office_code and v.division_office_code=sc.division_office_code and sc.subdivision_office_code= v.subdivision_office_code  and v.circle_office_code=m.dcode and substr(source_code,1,2)=m.mcode";
	 // str = " SELECT v.circle_office_name,v.division_office_code,v.division_office_name,v.subdivision_office_code,v.subdivision_office_name, WS.TEST_ID,T.TEST_CODE,T.TEST_NAME, WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/MM/YYYY') prepared_on, TO_CHAR (WS.SAMP_COLLECT_DATE,'dd/MM/YYYY') as sdate,ws.SAMP_COLLECT_DATE,WS.SOURCE_CODE,L.LAB_name, L.LOCATION,WS.TEST_ID,TO_CHAR(wt.FORWARDED_ON,'dd/MM/YYYY') as fwddate,wt.FORWARDED_ON,decode (ws.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '02 0 1002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname,panch.*,ws.source_type FROM RWS_WATER_SAMPLE_COLLECT_TBL WS,RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D, RWS_WATER_QUALITY_LAB_TBL L,RWS_WQ_TEST_RESULTS_TBL wt,rws_complete_hab_view panch,rws_complete_office_view v WHERE WS.TEST_CODE=T.TEST_CODE and ws.test_id=wt.test_id(+) AND WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND WS.LAB_CODE=L.LAB_CODE  and panch.panch_code=substr (ws.source_code,1,16) and wt.FORWARDED_ON is not null  and v.circle_office_code=substr(ws.source_code,1,2) and v.circle_office_code=ws.circle_office_code and v.division_office_code=ws.division_office_code and ws.subdivision_office_code= v.subdivision_office_code ";
	  str = " SELECT v.circle_office_name,v.division_office_code,v.division_office_name,v.subdivision_office_code,v.subdivision_office_name, WS.TEST_ID,T.TEST_CODE,T.TEST_NAME, WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/MM/YYYY') prepared_on, TO_CHAR (WS.SAMP_COLLECT_DATE,'dd/MM/YYYY') as sdate,ws.SAMP_COLLECT_DATE,WS.SOURCE_CODE,L.LAB_name, L.LOCATION,WS.TEST_ID,TO_CHAR(wt.FORWARDED_ON,'dd/MM/YYYY') as fwddate,wt.FORWARDED_ON,decode (ws.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701001','PONDS','0801001','OTHERS') as sname,panch.*,ws.source_type,to_char(ws.assigned_on,'dd/MM/YYYY') assigned_on FROM RWS_WATER_SAMPLE_COLLECT_TBL WS,RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D, RWS_WATER_QUALITY_LAB_TBL L,RWS_WQ_TEST_RESULTS_TBL wt,rws_complete_hab_view panch,rws_complete_office_view v WHERE WS.TEST_CODE=T.TEST_CODE and ws.test_id=wt.test_id(+) AND WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND WS.LAB_CODE=L.LAB_CODE  and panch.panch_code=substr (ws.source_code,1,16) and v.circle_office_code=substr(ws.source_code,1,2) and v.circle_office_code=ws.circle_office_code and v.division_office_code=ws.division_office_code and ws.subdivision_office_code= v.subdivision_office_code ";
		// System.out.println("1:"+str);
	     if(circlecode!=null && !circlecode.equals("") && !circlecode.equals("00"))
	      {
	       str+="  and v.circle_office_code=substr(ws.source_code,1,2) and ws.circle_office_code='"+circlecode+"' ";
	      }  
	      if(divisioncode!=null && !divisioncode.equals("") && !divisioncode.equals("-1"))
	      {
	        str+=" and ws.division_office_code='"+divisioncode+"'";
	       }
	     if(subdivisioncode!=null && !subdivisioncode.equals("") && !subdivisioncode.equals("-1"))
	      {
	       str+=" and  ws.subdivision_office_code='"+subdivisioncode+"'";
	       } 
		   if(mandalcode!=null && !mandalcode.equals("") && !mandalcode.equals("-1"))
	      {
	       str+=" and  substr(ws.source_code,6,2)='"+mandalcode+"'";
	       } 
	      if(sourcecode!=null && !sourcecode.equals("") && !sourcecode.equals("00"))
	      {
	      str+="  and source_type ='"+sourcecode+"'";
	      }
	      if(labcode!=null && !labcode.equals("") && !labcode.equals("00"))
	      {
	      str+="  and ws.lab_code='"+labcode+"'";
	      }
	      if(yearcode!=null && !yearcode.equals("") && !yearcode.equals("00"))
	      {
	    	 // System.out.println("yearcode"+yearcode);
	    	  //str+=" and (to_char(ws.assigned_on,'dd-MON-yyyy'))='"+yearcode+"'";
	    	  str+=" and ws.assigned_on BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
	    	 // str+=" and to_char(ws.assigned_on,'dd-MON-yyyy') BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
	      }
		  str += " order by WS.SAMP_COLLECT_DATE desc ";
	    slno=0;
	   stmt1=conn.createStatement();
	// System.out.println("222222222222:"+str);
	    ps=conn.prepareStatement(str);
		rs=ps.executeQuery();
	   while(rs.next())
	   {%>
		  
               <tr>
			    <td class=rptValue><%=++slno%></td>
					<%if(circleflag) {%><td class=rptValue nowrap><%=rs.getString(1)%></td><%}%>
					<%if(divflag) {%><td class=rptValue nowrap><%=rs.getString(3)%></td><%}%>
					<%if(subdivflag) {%><td class=rptValue nowrap><%=rs.getString(5)%></td><%}%>
					<%if(manflag) {%><td class=rptValue nowrap><%=rs.getString(24)%></td><%}%>
				<td class=rptValue nowrap><%=rs.getString(30)%></td>
				<td class=rptValue nowrap><%=rs.getString(8)%></td>
					 <%
				  //if(rs.getString(18)!=null && !rs.getString(18).equals(""))
					//{ 
			//    System.out.println("16:"+rs.getString(16));
			   %>
				<td class=rptValue nowrap><a href="#" onclick="wopen('./rws_source_loc_res_rpt.jsp?testId=<%=rs.getString(6)%>&testName=<%=rs.getString(8)%>&testCode=<%=rs.getString(7)%>&sourcecode=<%=rs.getString(14)%>&year=<%=yearcode %>&location=<%=rs.getString(16)%>&sctype=<%=rs.getString("source_type")%>','popup', 640, 480)" ><font face="verdana" size="2"><%=rs.getString(14)%></font></a></td>     
				<td class=rptValue nowrap><%if(rs.getString(20)!=null)out.println(rs.getString(20));else out.println("");%></td>
				<td class=rptValue nowrap><%=rs.getString(15)%></td>
				<td class=rptValue nowrap><%=rs.getString(10)%></td>
				<td class=rptValue style="width:100px"><%=rs.getString("sdate")%></td>
				<td class=rptValue style="width:100px"><%=rs.getString("assigned_on")%></td>
				<td class=rptValue style="width:100px"><%if(rs.getString(18)!=null)out.println(rs.getString(18));else{out.println(rs.getString("assigned_on"));}%></td> 
            </tr>
		    <%if(rst1!=null)
		     rst1.close();
	   }
		if(rs!=null)   
		rs.close(); 
		if(stmt1!=null)
		stmt1.close();
		if(ps!=null)
		ps.close();
		if(slno==0)
		{%> <tr align="center">
           <td class=rptHeading colspan=8 ><a href="javascript:window.history.back()"><%="No Records Match with this Selection Criteria"%></a></td></tr>
		<% }   
	   } catch(Exception e)
	   {
	   // System.out.println("exception lab status report :"+e);
	   }
	   finally{
		  
	   conn.close();
	   }
	   %>
	  <table broder="0" align="left">
	   <tr >
	   <td class=btext >Note: 'Source Code' Column represents: </td> 
	   </tr>
	   <tr>
	   <td class=rptValue>
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  A. Sources which are having test results are highlighted with Blue Color and By clicking the link you may see the results for that test.
	  </td></tr>
	  <tr><td class=rptValue>
  	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  B. Sources which are not having test results are highlighted with Black Color.
	   </td></tr>
	   </table>