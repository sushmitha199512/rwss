<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html>

<head>
<title>Report</title>
</head>
<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
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






<%


int count=1;
//String divname=request.getParameter("divname");
//String dname=(String)session.getAttribute("dname");
StringBuffer year=new StringBuffer(request.getParameter("year"));
//System.out.println("year---"+year);
//String subdivname=request.getParameter("subdivname");
StringBuffer yr=new StringBuffer(String.valueOf(session.getAttribute("yr")));
//System.out.println("yr---"+yr);
//System.out.println("yr***"+yr);

//String yr1=request.getParameter("yr1"); 
//String yr1=(String)session.getAttribute("yr1");
//System.out.println("Y1*******"+yr1);

//String yr3=(String)session.getAttribute("yr3");

//System.out.println("Y3*******"+yr3);
//String circleofficecode=request.getParameter("circleofficecode");
//System.out.println("circleofficecode************"+circleofficecode);
//String divisionofficecode=request.getParameter("divisionofficecode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");


//String y11=request.getParameter("year");
//String y11=(String)session.getAttribute("year");
//System.out.println("Y11*******"+y11);



//String y33=request.getParameter("year1");
//String y33=(String)session.getAttribute("year1");
//System.out.println("Y33*******"+y33);




//String[] programes=request.getParameterValues("program");
//System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
StringBuffer dcode=new StringBuffer(request.getParameter("dcode"));
   if(dcode.toString()!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");



 %>
<form>
<table border = 0 cellspacing = 0 cellpadding = 0 width="70%"   style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=1 rules=none style="border-collapse:collapse" align = "right">			
			<td  ><a href="javascript:history.go(-1)">Back| 
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr  align="center">
		
</tr>

</table>
<table    width="70%" border=0 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>Name   </b></td>

<td class=gridhdbg><b>No Of Sources </b></td>




  </tr>


	<%ResultSet rs3=null,rs4=null;
	Statement stmt3=null,stmt4=null;
	
	//String z1="",z2="",z3="",z4="",z5="",z6="";
	int styleCount=0;
	StringBuffer style=new StringBuffer();
	
	Hashtable source=(Hashtable)session.getAttribute("sources1");
	Hashtable ponds=(Hashtable)session.getAttribute("ps");
	Hashtable shall=(Hashtable)session.getAttribute("shps");
	Hashtable hand=(Hashtable)session.getAttribute("hps");
	Hashtable open=(Hashtable)session.getAttribute("ops");
	
	StringBuffer sourcecnt=new StringBuffer();
	StringBuffer hpcnt=new StringBuffer();
	StringBuffer shpcnt=new StringBuffer();

	
	StringBuffer opcnt=new StringBuffer();
	StringBuffer pscnt=new StringBuffer();

	try
      {
		
		 sourcecnt.append((String.valueOf(source.get(dcode.toString())))==null?"0":(String.valueOf(source.get(dcode.toString()))));	
		
		
		 hpcnt.append((String.valueOf(hand.get(dcode.toString())))==null?"0":(String.valueOf(hand.get(dcode.toString()))));	
		
		 shpcnt.append((String.valueOf(shall.get(dcode.toString())))==null || String.valueOf(shall.get(dcode.toString())).equals("null") ?"0":(String.valueOf(shall.get(dcode.toString()))));	
		opcnt.append((String.valueOf(open.get(dcode.toString())))==null || String.valueOf(open.get(dcode.toString())).equals("null") ?"0":(String.valueOf(open.get(dcode.toString()))));	
		pscnt.append((String.valueOf(ponds.get(dcode.toString())))==null || String.valueOf(ponds.get(dcode.toString())).equals("null") ?"0":(String.valueOf(ponds.get(dcode.toString()))));	
		 
		
		style.delete(0,style.length()); 
		
		style.append("gridbg1");
%>
<tr>
<td class="<%=style.toString() %>" style="text-align: left;" align="right">Scheme Sources</td><td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_rpt1.jsp?stype=SO&dcode=<%=dcode.toString()%>')"><%=sourcecnt.toString() %></td>
</tr>
<tr>
<td class="<%=style %>" style="text-align: left;" align="right">Hand Pumps</td><td class="<%=style %>" style="text-align: right;" align="right" ><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_rpt1.jsp?stype=HP&dcode=<%=dcode%>')"><%=hpcnt %></td>
</tr>
<tr>
<td class="<%=style %>" style="text-align: left;" align="right">OpenWells</td><td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_rpt1.jsp?stype=OP&dcode=<%=dcode%>')"><%=opcnt %></td>
</tr>
<tr>
<td class="<%=style %>" style="text-align: left;" align="right">Shallow HandPumps</td><td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_rpt1.jsp?stype=SHP&dcode=<%=dcode%>')"><%=shpcnt %></td>
</tr>
<tr>
<td class="<%=style %>" style="text-align: left;" align="right">Ponds </td><td class="<%=style %>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_rpt1.jsp?stype=PS&dcode=<%=dcode%>')"><%=pscnt %></td>
</tr>
<% 
      }

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 	
	%>
	
</table>
</form>

