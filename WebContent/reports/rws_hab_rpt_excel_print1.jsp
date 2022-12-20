<%@ page contentType="application/vnd.ms-excel"%>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>


<%  
	java.util.Date d=new java.util.Date();
	long now=d.getTime();
	response.setHeader("Expires",(now-(1000*60*60))+"");

    String assetType = request.getParameter("aType");
	int start=0,end,limit =20,  j=0, slno=0, pgcnt, pgno=0;
	ArrayList labelcol3 = (ArrayList)session.getAttribute("arrayLabel");
	
	java.util.Iterator label1 = labelcol3.iterator();
	int cnty=labelcol3.size();
	
	String labelNames[]=null;
	//String record[]=null;
	labelNames =(String[]) label1.next();
	//System.out.println("lebal are  count  "+labelNames.length);
	ArrayList myList2 = (ArrayList)session.getAttribute("arrayList");
	
	Iterator iterator = myList2.iterator();
	int mylists1=myList2.size();
%>

<html>
<head>
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<body>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>
        <td  class= "btext" rowspan=2>S.No</td>
		<td class="btext" rowspan=2>Constituency Name</td>

		<td class="btext" rowspan=2>Panchyat Name</td>
		<td class="btext" rowspan=2>Village Name</td>
		<td class="btext" rowspan=2>Habitation Name</td>

		<% if(assetType.equals("01")|| assetType.equals("02")|| assetType.equals("04")|| assetType.equals("03"))
		{%>
		<td class="btext" rowspan=2>Habitation Code</td>

		 <% 
		}
		  if(assetType.equals("03"))
		{
		%>
		  <%-- <td class="btext" rowspan=2>Update<br>Date</td> --%>
		<% 
		  }
		    if(assetType.equals("01"))
			{
			 for(j=4; j<labelNames.length;j++ )
		     {
			 //out.println("label is"+labelNames[j]);
			 if(labelNames[j].equals("CensusPop"))
		     {
            %>
			<td class = btext colspan=5>Census<br>Population</td>
			<% 
			}
             if(labelNames[j].equals("safelpcd"))
		     {
            %>
			<td class = btext rowspan=2>SAFE LPCD</td>
			<% 
			}          

if(labelNames[j].equals("unsafelpcd"))
		     {
            %>
			<td class = btext rowspan=2>UNSAFE LPCD</td>
			<% 
			}

            if(labelNames[j].equals("Gis"))
		     {
            %>
			<td class = btext colspan=5>Gis <br>Info</td>
			<% 
			}
            if(labelNames[j].equals("Lwe"))
		     {
            %>
			<td class = btext rowspan=2>Whether<br>Lwe</td>
			<% 
			}    
if(labelNames[j].equals("Minority"))
		     {
            %>
			<td class = btext rowspan=2>Minority<br>Dominated</td>
			<% 
			}          

if(labelNames[j].equals("Itda"))
		     {
            %>
			<td class = btext rowspan=2> Is Itda<br>(TSP)</td>
			<% 
			}          
if(labelNames[j].equals("Houseconn"))
		     {
            %>
			<td class = btext  colspan=5> House <br>Connections</td>
			<% 
			}          



			if(labelNames[j].equals("FloatPop"))
				{
			%>
		   <td class = btext colspan=2>Floating<br>Population</td>
			<% 
			}
			if(labelNames[j].equals("CovStatus"))
				{
			%>
			<td class = btext rowspan=2>Coverage<br>Status</td>
			<% 
			}
			if(labelNames[j].equals("Status"))
				{
			%>
			<td class = btext colspan=2>Coverage<br>Status</td>
			<% 
			}
			if(labelNames[j].equals("PopCov"))
				{
			%>
			<td class = btext colspan=5>Population<br>Covered</td>
			<% 
			}
			if(labelNames[j].equals("HouseHolds"))
				{
			%>
			<td class = btext colspan=6><center>HouseHolds/<br>Cattle</center></td>
			<% 
			}
			if(labelNames[j].equals("Existingsource"))
				{
			%>
			<td class = btext colspan=2><center>No.Of</center></td>
			<% 
			}
			if(labelNames[j].equals("Nearsource"))
				{
			%>
			<td class = btext rowspan=2><center>Nearest<br>Available<br>Source</center></td>
			<% 
			}
			if(labelNames[j].equals("SourceDistance"))
				{
			%>
			<td class = btext rowspan=2><center>Distance&nbsp;of&nbsp;availability<br>of&nbsp;Water&nbsp;Supply&nbsp;Point<br>from&nbsp;house&nbsp;hold</center></td>
			<% 
			}
			if(labelNames[j].equals("Hab"))
				{
			%>
			<td class = btext colspan=3>Habitation</td>
			<% 
			}
			if(labelNames[j].equals("updatedate"))
				{
			%>
			<td class = btext rowspan=2>Update<br>Date</td>
			<% 
			}
		   
		  } %>
		</tr>
		<tr>
		<%
		 for(j=4;j<labelNames.length;j++ )
			{
			  //out.println("labellength"+labelNames.length);
		  if(labelNames[j].equals("CensusPop"))
		     {
			%>
			
			<td class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
			<td class=btext>Total</td>
          <%}
           if(labelNames[j].equals("Gis"))
		     {
			%>
			
			<td class=btext>Way Point</td>
			<td class=btext>Latitude -N</td>
			<td class=btext>Longitude -E</td>
            <td class=btext>Elevation</td>
			<td class=btext>Land Mark</td>
          <%} 
           if(labelNames[j].equals("Houseconn"))
		     {
			%>
			
			<td class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
            <td class=btext>Total(House Connections)</td>
			
          <%} 


			 if(labelNames[j].equals("FloatPop"))
		     { %>
			<td class=btext>Pop</td>
			<td class=btext>Reasons</td>
			<%}
			if(labelNames[j].equals("PopCov"))
		     { %>
			<td rowspan=1 colspan=1  class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
		    <td class=btext>Total</td>
            <%}
			if(labelNames[j].equals("HouseHolds"))
		     { %>
            <td class=btext>Plain</td>
            <td class=btext>SC</td>
            <td class=btext>ST</td>
            <td class=btext>Minority</td>  
			<td class=btext>Total(HouseHolds)</td>
			<td class=btext>Cattle</td>
            <%}
            if(labelNames[j].equals("Status"))
		     {
			%>
			<td class=btext>Prev Yr</td>
			<td class=btext>Present Yr</td>
          <%} 
			if(labelNames[j].equals("Existingsource"))
		     { %>
			<td class=btext>Existing<br>Sources</td>
			<td class=btext>Safe<br>Sources</td>
            <%}
			if(labelNames[j].equals("Hab"))
		     { %>
			<td class=btext>Type</td>
			<td class=btext>SubType</td>
			<td class=btext>Category</td>
            <%}
		}%>
			 </TR> 
      <% } 
		    if(assetType.equals("02"))
			{
				
			for(j=4; j<labelNames.length;j++ )
		     {
				//System.out.println("label is"+labelNames[j]);
			if(labelNames[j].equals("HandPumps"))
		     {
            %>
			<td class = btext colspan=2>HandPumps</td>
			<% 
			}
			if(labelNames[j].equals("HandPumps(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>HandPumps(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("PWS"))
				{
			%>
		   <td class = btext colspan=2>Pws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("MPWS"))
				{
			%>
			<td class = btext colspan=2>Mpws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("CPWS"))
				{
			%>
			<td class = btext colspan=2>Cpws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("EXTENSION"))
				{
			%>
			<td class = btext colspan=2>Extension of<BR>Scheme</td>
			<% 
			}
			if(labelNames[j].equals("PWS(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>PWS(Unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("MPWS(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>MPWS(Unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("OPENWELLS"))
				{
			%>
			<td class = btext colspan=2>Openwells(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("PONDS"))
				{
			%>
			<td class = btext colspan=2>Ponds(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("SHALLOWPUMPS"))
				{
			%>
			<td class = btext colspan=2>ShallowPumps(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("OTHERS"))
				{
			%>
			<td class = btext colspan=2>Others</td>
			<% 
			}
			if(labelNames[j].equals("OTHERS(unsafe)")) 
			{
			%>
			<td class = btext colspan=2>Others(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("Total"))
				{
			%>
			<td class = btext rowspan=2>Total Water Supply<br>(Lts/Day)(safe)</td>
			<% 
			}
			if(labelNames[j].equals("Total(unsafe)"))
			{
			%>
			<td class = btext rowspan=2>Total Water Supply<br>(Lts/Day)(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("Existing"))
				{
			%>
			<td class = btext rowspan=2>Existing<br>Water<br>level(LPCD)</td>
			<% 
			}
			if(labelNames[j].equals("Status"))
				{
			%>
			<td class = btext colspan=2>Coverage<br>Status</td>
			<% 
			}
			if(labelNames[j].equals("SurfaceSource"))
				{
			%>
			<td class = btext colspan=2>Distance<br>From<br>Source(In Kms)</td>
			<% 
			}
			if(labelNames[j].equals("Qualityeffect"))
				{
			%>
			<td class = btext rowspan=2 align="center">Quality<br>Affected</td>
			<% 
			}
			if(labelNames[j].equals("slippage"))
				{
			%>
			<td class = btext rowspan=2 align="center">Reasons&nbsp;For<br>SlipPage</td>
			<% 
			}
			 if(labelNames[j].equals("Sources"))
				{
			%>
			<td class = btext colspan=2>No.Of<br>Sources</td>
			<% 
			}
			if(labelNames[j].equals("Proposed"))
				{
			%>
			<td class = btext colspan=2>Proposed<br>FC</td>
			<% 
			}
			if(labelNames[j].equals("updatedate"))
				{
			%>
			<td class = btext rowspan=2>Update<br>Date</td>
			<% 
			}
		   
		  } %>
		</tr>
		<tr>
		<%
		 for(j=4;j<labelNames.length;j++ )
			{
			//  System.out.println("labellength"+labelNames.length);
		  if(labelNames[j].equals("HandPumps"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
          if(labelNames[j].equals("HandPumps(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			 if(labelNames[j].equals("PWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("MPWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("CPWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
          if(labelNames[j].equals("EXTENSION"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("OPENWELLS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("PONDS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("SHALLOWPUMPS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("OTHERS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
          
          if(labelNames[j].equals("PWS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%}
          if(labelNames[j].equals("MPWS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%}
          if(labelNames[j].equals("OTHERS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%} 
			if(labelNames[j].equals("Status"))
		     {
			%>
			<td class=btext>Prev Yr</td>
			<td class=btext>Present Yr</td>
          <%} 
			if(labelNames[j].equals("SurfaceSource"))
		     {
			%>
			<td class=btext>Surface</td>
			<td class=btext>Ground</td>
          <%} 
			if(labelNames[j].equals("Sources"))
		     { %>
			<td class=btext>Existing</td>
			<td class=btext>Safe</td>
            <%}
			if(labelNames[j].equals("Proposed"))
		     {
			%>
			<td class=btext>Year</td>
			<td class=btext>Est Amt(Rs.In Lakhs)</td>
          <%} 
			
		}%>
			 </TR> 
      <% } 
	 
	  else if(assetType.equals("03")) {
			//System.out.println("0000000000   "+labelNames.length);
			for(j=1;j<labelNames.length;j++)
			{
			//System.out.println("labelNames[j] "+labelNames[j]);
				//out.println("label is"+labelNames[j]);
			
			if(labelNames[j].equals("Temples"))
				{
			%>
			<td class = btext colspan=4>Temples</td>
			<% 
			}
			if(labelNames[j].equals("PrimaryHealthCentre"))
				{
			%>
			<td class = btext colspan=4>Primary<br>Health<br>Centre</td>
			<% 
			}
			if(labelNames[j].equals("AnganwadiCentres"))
				{
			%>
			<td class = btext colspan=4>Anganwadi<br>Centres</td>
			<% 
			}
			if(labelNames[j].equals("Libraries"))
				{
			%>
			<td class = btext colspan=4>Libraries</td>
			<% 
			}
			if(labelNames[j].equals("CommunityHalls"))
				{
			%>
			<td class = btext colspan=4>Community<br>Halls</td>
			<% 
			}
			if(labelNames[j].equals("PrimarySchool"))
			{
			%>
			<td class = btext colspan=4>Primary<br>School</td>
			<% 
			}
			if(labelNames[j].equals("U.PSchools"))
				{
			%>
			<td class = btext colspan=4>U.P<br>Schools</td>
			<% 
			}
			if(labelNames[j].equals("HighSchools"))
				{
			%>
			<td class = btext colspan=4>High<br>Schools</td>
			<% 
			}
			if(labelNames[j].equals("B.CHostels"))
				{
			%>
			<td class = btext colspan=4>B.C<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("S.CHostels"))
				{
			%>
			<td class = btext colspan=4>S.C<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("S.THostels"))
				{
			%>
			<td class = btext colspan=4>S.T<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("TotalNo"))
			{
			%>
			<td class = btext colspan=4>Total&nbsp;Public<br>Institutions</td>
			<% 
			}
			} %>
			</tr>
			<tr>
			<%
			for(j=3;j<=((labelNames.length-2)/4)+1;j++ )
			 {%>
				<td class = btext>No.</td>
				<td class = btext>Covered</td>
				<td class = btext>Not<br>working</td>
				<td class = btext>Working</td>
			<%} %>
			 </TR> 
         <%	}
		    else if(assetType.equals("04"))
			{
				
			for(j=4; j<labelNames.length;j++ )
		     {
				//out.println("label is"+labelNames[j]);
			if(labelNames[j].equals("CensusPop"))
		     {
            %>
			<td class = btext colspan=5>Census<br>Population</td>
			<% 
			}
			if(labelNames[j].equals("safelpcd"))
		     {
            %>
			<td class = btext rowspan=2>SAFE LPCD</td>
			<% 
			}          

if(labelNames[j].equals("unsafelpcd"))
		     {
            %>
			<td class = btext rowspan=2>UNSAFE LPCD</td>
			<% 
			}
            if(labelNames[j].equals("Gis"))
		     {
            %>
			<td class = btext colspan=5>Gis<br>Info</td>
			<% 
			}
           if(labelNames[j].equals("Lwe"))
		     {
            %>
			<td class = btext rowspan=2>Whether<br>Lwe</td>
			<% 
			}
            if(labelNames[j].equals("Minority"))
		     {
            %>
			<td class = btext rowspan=2>Minority<br>Dominated</td>
			<% 
			}
            if(labelNames[j].equals("Itda"))
		     {
            %>
			<td class = btext rowspan=2> Is Itda<br>(TSP)</td>
			<% 
			}          
            if(labelNames[j].equals("Houseconn"))
		     {
            %>
			<td class = btext colspan=5> House<br>Connections</td>
			<% 
			}
			if(labelNames[j].equals("FloatPop"))
				{
			%>
		   <td class = btext colspan=2>Floating<br>Population</td>
			<% 
			}
			
			if(labelNames[j].equals("PopCov"))
				{
			%>
			<td class = btext colspan=5>Population<br>Covered</td>
			<% 
			}
			if(labelNames[j].equals("HouseHolds"))
				{
			%>
			<td class = btext colspan=6><center>HouseHolds/<br>Cattle</center></td>
			<% 
			}
			if(labelNames[j].equals("Existingsource"))
				{
			%>
			<td class = btext colspan=2><center>No.Of</center></td>
			<% 
			}
			if(labelNames[j].equals("Nearsource"))
				{
			%>
			<td class = btext rowspan=2><center>Nearest<br>Available<br>Source</center></td>
			<% 
			}
			if(labelNames[j].equals("SourceDistance"))
				{
			%>
			<td class = btext rowspan=2><center>Distance&nbsp;of&nbsp;availability<br>of&nbsp;Water&nbsp;Supply&nbsp;Point<br>from&nbsp;house&nbsp;hold</center></td>
			<% 
			}
			if(labelNames[j].equals("Hab"))
				{
			%>
			<td class = btext colspan=3>Habitation</td>
			<% 
			}
			if(labelNames[j].equals("updatedate"))
				{
			%>
			<td class = btext rowspan=2>Update<br>Date</td>
			<% 
			}
			if(labelNames[j].equals("HandPumps"))
		     {
            %>
			<td class = btext colspan=2>HandPumps(safe)</td>
			<% 
			}
			if(labelNames[j].equals("HandPumps(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>HandPumps(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("PWS"))
				{
			%>
		   <td class = btext colspan=2>Pws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("MPWS"))
				{
			%>
			<td class = btext colspan=2>Mpws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("CPWS"))
				{
			%>
			<td class = btext colspan=2>Cpws(safe)</td>
			<% 
			}
			if(labelNames[j].equals("EXTENSION"))
				{
			%>
			<td class = btext colspan=2>Extension Of <BR> Scheme</td>
			<% 
			}
			if(labelNames[j].equals("PWS(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>PWS(Unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("MPWS(unsafe)"))
		     {
            %>
			<td class = btext colspan=2>MPWS(Unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("OPENWELLS"))
				{
			%>
			<td class = btext colspan=2>Openwells(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("PONDS"))
				{
			%>
			<td class = btext colspan=2>Ponds(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("SHALLOWPUMPS"))
				{
			%>
			<td class = btext colspan=2>ShallowPumps(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("OTHERS"))
				{
			%>
			<td class = btext colspan=2>Others(safe)</td>
			<% 
			}
			if(labelNames[j].equals("OTHERS(unsafe)"))
			{
			%>
			<td class = btext colspan=2>Others(unsafe)</td>
			<% 
			}
			if(labelNames[j].equals("Total"))
				{
			%>
			<td class = btext rowspan=2>Total Water Supply<br>(Lts/Day)(safe)</td>
			<% 
			}
			if(labelNames[j].equals("Total(unsafe)"))
			{
			%>
			<td class = btext rowspan=2>Total Water Supply<br>(Lts/Day)(unsafe)</td>
			<% 
			}
			
			if(labelNames[j].equals("Existing"))
				{
			%>
			<td class = btext rowspan=2>Existing<br>Water<br>level(LPCD)</td>
			<% 
			}
			 if(labelNames[j].equals("Sources"))
				{
			%>
			<td class = btext colspan=2>No.Of<br>Sources</td>
			<% 
			}
			if(labelNames[j].equals("Status"))
				{
			%>
			<td class = btext colspan=2>Coverage<br>Status</td>
			<% 
			}
			if(labelNames[j].equals("Qualityeffect"))
				{
			%>
			<td class = btext rowspan=2 align="center">Quality<br>Affected</td>
			<% 
			}
			if(labelNames[j].equals("slippage"))
				{
			%>
			<td class = btext rowspan=2 align="center">Reasons&nbsp;For<br>SlipPage</td>
			<% 
			}
			if(labelNames[j].equals("SurfaceSource"))
				{
			%>
			<td class = btext colspan=2>Distance<br>From<br>Source(In Kms)</td>
			<% 
			}
			if(labelNames[j].equals("Proposed"))
				{
			%>
			<td class = btext colspan=2>Proposed<br>FC</td>
			<% 
			}
			//code added to show Public Institution Details in checkList for(ALL Option)021208
				
			if(labelNames[j].equals("Temples"))
			{
			%>
			<td class = btext colspan=4>Temples</td>
			<% 
			}
			if(labelNames[j].equals("PrimaryHealthCentre"))
			{
			%>
			<td class = btext colspan=4>Primary<br>Health<br>Centre</td>
			<% 
			}
			if(labelNames[j].equals("AnganwadiCentres"))
			{
			%>
			<td class = btext colspan=4>Anganwadi<br>Centres</td>
			<% 
			}
			if(labelNames[j].equals("Libraries"))
			{
			%>
			<td class = btext colspan=4>Libraries</td>
			<% 
			}
			if(labelNames[j].equals("CommunityHalls"))
			{
			%>
			<td class = btext colspan=4>Community<br>Halls</td>
			<% 
			}
			if(labelNames[j].equals("PrimarySchool"))
			{
			%>
			<td class = btext colspan=4>Primary<br>School</td>
			
			<% 
			}
			if(labelNames[j].equals("U.PSchools"))
			{
			%>
			<td class = btext colspan=4>U.P<br>Schools</td>
			<% 
			}
			if(labelNames[j].equals("HighSchools"))
			{
			%>
			<td class = btext colspan=4>High<br>Schools</td>
			<% 
			}
			if(labelNames[j].equals("B.CHostels"))
			{
			%>
			<td class = btext colspan=4>B.C<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("S.CHostels"))
			{
			%>
			<td class = btext colspan=4>S.C<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("S.THostels"))
			{
			%>
			<td class = btext colspan=4>S.T<br>Hostels</td>
			<% 
			}
			if(labelNames[j].equals("TotalNo"))
			{
			%>
			<td class = btext colspan=4>Total&nbsp;Public<br>Institutions</td>
			<% 
			}			
		     //end of code added
		   
		  } %>
		</tr>
		<tr>
		<%
		 for(j=4;j<labelNames.length;j++ )
			{
			  //out.println("labellength"+labelNames.length);
		  if(labelNames[j].equals("CensusPop"))
		     {
			%>
			
			<td class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
			<td class=btext>Total</td>
          <%} 
            if(labelNames[j].equals("Gis"))
		     {
			%>
			
			<td class=btext>Way Point</td>
			<td class=btext>Latitude -N</td>
			<td class=btext>Longitude -E</td>
            <td class=btext>Elevation</td>
			<td class=btext>Land Mark</td>
          <%}
           if(labelNames[j].equals("Houseconn"))
		     {
			%>
			<td class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
            <td class=btext>Total(House Connections)</td>
		<%}
			 if(labelNames[j].equals("FloatPop"))
		     { %>
			<td class=btext>Pop</td>
			<td class=btext>Reasons</td>
			<%}
			if(labelNames[j].equals("PopCov"))
		     { %>
			<td rowspan=1 colspan=1 class=btext>Plain</td>
			<td class=btext>SC</td>
			<td class=btext>ST</td>
            <td class=btext>Minority</td>
		    <td class=btext>Total</td>
            <%}
			if(labelNames[j].equals("HouseHolds"))
		     { %>
             <td class=btext>Plain</td>
             <td class=btext>SC</td>
             <td class=btext>ST</td>
             <td class=btext>Minority</td>
			<td class=btext>Total(HouseHolds)</td>
			<td class=btext>Cattle</td>
            <%}
            if(labelNames[j].equals("Existingsource"))
		     { %>
			<td class=btext>Existing<br>Sources</td>
			<td class=btext>Safe<br>Sources</td>
            <%}
	         if(labelNames[j].equals("Hab"))
		     { %>
			<td class=btext>Type</td>
			<td class=btext>SubType</td>
			<td class=btext>Category</td>
            <%}
			if(labelNames[j].equals("HandPumps"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
          if(labelNames[j].equals("HandPumps(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			 if(labelNames[j].equals("PWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("MPWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("CPWS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%}
			if(labelNames[j].equals("EXTENSION"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%}
			if(labelNames[j].equals("OPENWELLS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("PONDS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("SHALLOWPUMPS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("OTHERS"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
          if(labelNames[j].equals("PWS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%}
          if(labelNames[j].equals("MPWS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/day)</td>
          <%}
          if(labelNames[j].equals("OTHERS(unsafe)"))
		     {
			%>
			<td class=btext>No</td>
			<td class=btext>Water<br>Supply(Lts/Day)</td>
          <%} 
			if(labelNames[j].equals("Status"))
		     {
			%>
			<td class=btext>Prev Yr</td>
			<td class=btext>Present Yr</td>
          <%} 
			if(labelNames[j].equals("SurfaceSource"))
		     {
			%>
			<td class=btext>Surface</td>
			<td class=btext>Ground</td>
          <%} 
			if(labelNames[j].equals("Sources"))
		     { %>
			<td class=btext>Existing</td>
			<td class=btext>Safe</td>
            <%}
			if(labelNames[j].equals("Proposed"))
		     {
			%>
			<td class=btext>Year</td>
			<td class=btext>Est Amt</td>
          <%} 
			//code added to show Public Institution Details in checkList for(ALL Option) 011208
				
			if(labelNames[j].equals("Temples"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
			
			<% 
			}
			if(labelNames[j].equals("PrimaryHealthCentre"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>				
			<% 
			}
			if(labelNames[j].equals("AnganwadiCentres"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("Libraries"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("CommunityHalls"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("PrimarySchool"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			
			<% 
			}
			if(labelNames[j].equals("U.PSchools"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("HighSchools"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("B.CHostels"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("S.CHostels"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("S.THostels"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}
			if(labelNames[j].equals("TotalNo"))
			{
			%>
			<td class = btext>No.</td>
			<td class = btext>Covered</td>
			<td class = btext>Not<br>working</td>
			<td class = btext>Working</td>
				
			<% 
			}			
		   //end of code added
			
		}%>
			 </TR> 
      <% }  
	try{
	    String statcount=(String)session.getAttribute("statuscount");
		String slipcount = (String)session.getAttribute("slippagecount");
		//System.out.println("statuscount"+statcount+"slipcount"+slipcount);
		int prevcount=0,slcount=0,prescount=0;
		if(statcount!=null){
		prescount=Integer.parseInt(statcount);
		prevcount=prescount-1;
		session.removeAttribute("statuscount");
		}
		if(slipcount!=null){
		slcount=Integer.parseInt(slipcount);
		session.removeAttribute("slippagecount");
		}
		//System.out.println("prevcount"+prevcount+"prescount"+prescount+"slcount"+slcount);
		int prstatus=0,prestatus=0;
		String distcode="",mandcode="";
		String[] record1 =null;
        String previousStat="",presentStat=""; 
		for(start=0;start<myList2.size();start++)
		{	
			 record1 =(String[])myList2.get(start);		
			slno++;
			if(prevcount>0){
				previousStat=record1[prevcount];
				presentStat=record1[prescount];
		 	    if(previousStat.equals("FC")){prstatus=1;}
		        if(previousStat.equals("PC4")){prstatus=2;}
		        if(previousStat.equals("PC3")){prstatus=3;}
		        if(previousStat.equals("PC2")){prstatus=4;}
		        if(previousStat.equals("PC1")){prstatus=5;}
		        if(previousStat.equals("NC")){prstatus=6;}
		        if(previousStat.equals("NSS")){prstatus=7;}
		        if(presentStat.equals("FC")){prestatus=1;}
		        if(presentStat.equals("PC4")){prestatus=2;}
		        if(presentStat.equals("PC3")){prestatus=3;}
		        if(presentStat.equals("PC2")){prestatus=4;}
		        if(presentStat.equals("PC1")){prestatus=5;}
		        if(presentStat.equals("NC")){prestatus=6;}
		        if(presentStat.equals("NSS")){prestatus=7;}
				//System.out.println("prevstatus"+previousStat+"prstatus"+prstatus);				
				//System.out.println("prevstatus"+presentStat+"prestatus"+prestatus);
				}
%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=slno%></td>
		 <% if(assetType.equals("01")|| assetType.equals("02")|| assetType.equals("04"))
			{
%>
			<td class="mystyle1"><%=record1[1]%></td>
			<td class="mystyle1"><%=record1[2]%></td>
		    <td class="mystyle1"><%=record1[3]%></td>
<% 			            
			}
			if(assetType.equals("03"))
			{ %>
			<td class="mystyle1"><%=record1[1]%></td>
			<td class="mystyle1"><%=record1[2]%></td>
			<%--<td class="mystyle1"><%=record1[0]%></td> --%>
		 <% 			            
			}			
			if(!assetType.equals("03"))
			{
			for(int k=4;k<(labelNames.length);k++)
			{
				if(record1[k].equals("null"))
				{		
%>
                   <td class="mystyle1"><%="-"%></td>
<%
				}
  			    else
				{
				    //System.out.println("in the loop");
				if(slcount>0 &&  k==slcount){
				if(prstatus>=prestatus ){
				%>
				
					<td class="mystyle1" nowrap>--&nbsp;</td>
			    <% 
				}else{
				%>
				
				<%if(record1[k].length()==14 || record1[k].length()==16){
				%>
					<td class="mystyle1" nowrap>&nbsp;<%=record1[k]%></td>
			    <%  
				}
				else
				{
				%>
				<td class="mystyle1" nowrap><%=record1[k]%></td>
				<%
				} 
				}} else{
				%>
				<%if(record1[k].length()==14 || record1[k].length()==16){
				%>
					<td class="mystyle1" nowrap>&nbsp;<%=record1[k]%></td>
			    <%  
				}
				else
				{
				%>
				<td class="mystyle1" nowrap><%=record1[k]%></td>
				<%
				}
			  }}
				} 
			}
			else
			{				
				for(int k=3;k<labelNames.length;k++)
				{
				
%>
				<td class="mystyle1">&nbsp;<%=record1[k]%>&nbsp;</td>
<%				} 
			}
		}
}//try end
catch(Exception e)
{
	//System.out.println("Exception "+e);
	}
	%>
</tr>	

</table>
</body>
</html>
