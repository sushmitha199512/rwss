<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

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


</script>





	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	//String dprsvs="";

     String completionDate=null;
     																
	
    double aas=0;
         
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);

	if(request.getParameter("finyear")!=null)
	
	{
	financialyr=request.getParameter("finyear");
	//System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
   String yr= financialyr.substring(0,4);
session.setAttribute("financialyr",financialyr);

  	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=24>Pending Permissions Report for the Financial Year(<%=session.getAttribute("financialyr")%>)<font color="red"></font></td>	
	</tr>
<tr >
		<td class=btext rowspan=4>Sl.No</td>
		<td class=btext rowspan=4>District</td>
             
</tr>

<tr>
<td class=btext align="center"  colspan=10>Pending Permissions as on 1.4.<%=yr %> and During The Year </td>
					
<td  class=btext align="center"  colspan=11>Permissions cleared</td>	
</tr>

<tr>
<td rowspan=2 colspan=1 class=btext align="center">Land acquisition </td>	
<td rowspan=2  colspan=1 class=btext align="center">Forest clearance</td>
<td rowspan=2  colspan=1 class=btext align="left">Water drawal permission </td>
<td rowspan=2 colspan=1 class=btext align="center">Railway crossing</td>	
<td rowspan=2  colspan=1 class=btext align="center">Road crossing (NHAI)</td>	
<td rowspan=2  colspan=1 class=btext align="left">Road crossing (State Highway) </td>

<td rowspan=2 colspan=1 class=btext align="center">Power (AP Transco)</td>	
<td rowspan=2  colspan=1 class=btext align="center">HMWSSB</td>	
<td rowspan=2  colspan=1 class=btext align="left">Others </td>

		
<td rowspan=2 colspan=1 class=btext align="center">Total</td><td rowspan=2 colspan=1 class=btext align="center">Land acquisition </td>	
<td rowspan=2  colspan=1 class=btext align="center">Forest clearance</td>
<td rowspan=2  colspan=1 class=btext align="left">Water drawal permission </td>
<td rowspan=2 colspan=1 class=btext align="center">Railway crossing</td>	
<td rowspan=2  colspan=1 class=btext align="center">Road crossing (NHAI)</td>	
<td rowspan=2  colspan=1 class=btext align="left">Road crossing (State Highway) </td>

<td rowspan=2 colspan=1 class=btext align="center">Power (AP Transco)</td>	
<td rowspan=2  colspan=1 class=btext align="center">HMWSSB</td>	
<td rowspan=2  colspan=1 class=btext align="left">Others </td>

		
<td rowspan=2 colspan=1 class=btext align="center">Total</td>	
<td rowspan=2  colspan=1 class=btext align="left">Exp<br>(Rs.Lakhs)</br><br>DPR Charges</td>



</tr>
<!-- </tr><tr><td class=btext align="center">1</td><td class=btext align="center">2</td><td class=btext align="center">3</td><td class=btext align="center">4</td><td class=btext align="center">5</td><td class=btext align="center">6</td><td class=btext align="center">7</td><td class=btext align="center">8</td><td class=btext align="center">9</td><td class=btext align="center">10</td><td class=btext align="center">11</td><td class=btext align="center">12</td><td class=btext align="center">13</td><td class=btext align="center">14</td></tr>-->
<%

Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null;
ResultSet rs1=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null;
int count=1;
  try{
	
			
//lan

String dprlan="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and LANDAQUISITION='Y'  ";
dprlan+="  group by  substr(b.office_code,2,2) order by 1";



stmt3=conn.createStatement();
//System.out.println("dprlan******"+dprlan);
	 rs2=stmt3.executeQuery(dprlan);
	Hashtable dprlanper=new Hashtable();
	while(rs2.next())
	{
		dprlanper.put(rs2.getString(2),rs2.getString(1));
	}
//forest 
String forest="select count(*),substr(b.office_code,2,2)from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and FORESTCLEARANCE ='Y'  ";
forest+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(forest);
Hashtable dprforest=new Hashtable();
while(rs2.next())
{
	dprforest.put(rs2.getString(2),rs2.getString(1));
}

//water 
String water="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and WATERDRAWLPERMISSION ='Y'  ";
water+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(water);
Hashtable dprwater=new Hashtable();
while(rs2.next())
{
	dprwater.put(rs2.getString(2),rs2.getString(1));
}
//railway
 
String railway="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and RAILWAYCROSSINGPERMISSION='Y'  ";
railway+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(railway);
Hashtable dprrailway=new Hashtable();
while(rs2.next())
{
	dprrailway.put(rs2.getString(2),rs2.getString(1));
}
//road crossing

String roadcross="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ROADCROSSINGPERMISSIONNHAI ='Y'  ";
roadcross+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(roadcross);
Hashtable dprroadcross=new Hashtable();
while(rs2.next())
{
	dprroadcross.put(rs2.getString(2),rs2.getString(1));
}

//road crossing state

String roadcrossstate="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ROADCROSSINGPERMISSIONSTATE='Y'";
roadcrossstate+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(roadcrossstate);
Hashtable roadstate=new Hashtable();
while(rs2.next())
{
	roadstate.put(rs2.getString(2),rs2.getString(1));
}

//power 

String power="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and POWERAPTRANSCOREQ ='Y' ";
power+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(power);
Hashtable dprpower=new Hashtable();
while(rs2.next())
{
	dprpower.put(rs2.getString(2),rs2.getString(1));
}

//HMWSSBREQ 

String hmwssb="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and HMWSSBREQ  ='Y' ";
hmwssb+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(hmwssb);
Hashtable dprhmwssb=new Hashtable();
while(rs2.next())
{
	dprhmwssb.put(rs2.getString(2),rs2.getString(1));
}

//OTHERS 

String other="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and OTHERS='Y' ";
other+=" group by  substr(b.office_code,2,2) order by 1";

//System.out.println("Others Pending"+other);
rs2=stmt3.executeQuery(other);
Hashtable dprother=new Hashtable();
while(rs2.next())
{
	dprother.put(rs2.getString(2),rs2.getString(1));
}


//LAN DATE 
  

String lanobtaindt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and LANDAQUISITION ='Y'AND LANDAQUISITIONOBTAINDATE  is not null";
lanobtaindt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(lanobtaindt);
Hashtable lanobdt=new Hashtable();
while(rs2.next())
{
	lanobdt.put(rs2.getString(2),rs2.getString(1));
}


//forest is not null obtain date

String forestobtaindt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is not null";
forestobtaindt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(forestobtaindt);
Hashtable forestobdt=new Hashtable();
while(rs2.next())
{
	forestobdt.put(rs2.getString(2),rs2.getString(1));
}

//

String waterobtdt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is not null";
waterobtdt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(waterobtdt);
Hashtable waterobtdate=new Hashtable();
while(rs2.next())
{
	waterobtdate.put(rs2.getString(2),rs2.getString(1));
}



//railobt
String railwayobtdt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and RAILWAYCROSSINGPERMISSION ='Y' AND RAILWAYCROSSINGPEROBTAIN is not null";
railwayobtdt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(railwayobtdt);
Hashtable railobtdate=new Hashtable();
while(rs2.next())
{
	railobtdate.put(rs2.getString(2),rs2.getString(1));
}
///road crossing nhai

String roadobtdt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is not null";
//String roadobtdt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ROADCROSSINGPERMISSIONNHAI ='Y' ";
roadobtdt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(roadobtdt);
Hashtable roadobtdate=new Hashtable();
while(rs2.next())
{
	roadobtdate.put(rs2.getString(2),rs2.getString(1));
}

//road crossing state


String roadobtdtstate="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is not null";
roadobtdtstate+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(roadobtdtstate);
Hashtable roadstateobtdate=new Hashtable();
while(rs2.next())
{
	roadstateobtdate.put(rs2.getString(2),rs2.getString(1));
}


//power ap transcco

String powerobt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is not null";
powerobt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(powerobt);
Hashtable powerobtdt=new Hashtable();
while(rs2.next())
{
	powerobtdt.put(rs2.getString(2),rs2.getString(1));
}

//hmwssb
String hmwssobt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is not null";
hmwssobt+=" group by  substr(b.office_code,2,2) order by 1";
rs2=stmt3.executeQuery(hmwssobt);
Hashtable hmwssobtdt=new Hashtable();
while(rs2.next())
{
	hmwssobtdt.put(rs2.getString(2),rs2.getString(1));
}





//end


//othersobt


String otherobt="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and OTHERS='Y' AND OTHERSOBTAINDATE is not null";
otherobt+=" group by  substr(b.office_code,2,2) order by 1";

//System.out.println("Others cleared"+otherobt);
rs2=stmt3.executeQuery(otherobt);
Hashtable otherobtdt=new Hashtable();
while(rs2.next())
{
	otherobtdt.put(rs2.getString(2),rs2.getString(1));
}
//obtexp
String expobt="select sum(nvl(DPRCHARGES/100000,'0') + nvl(HMWSCHRGS/100000,'0')+ nvl(LANDAQUISITIONCHRG/100000,'0')+nvl(WATERDRAWLPERMISSIONCHRG/100000,'0') +nvl(RAILWAYCROSSINGPERMISSIONCHRG/100000,'0')+nvl(ROADCROSSINGPERMISSIONCHRG/100000,'0')+nvl(ROADCROSSINGPERMISSIONNHAICHRG/100000,'0')+nvl(FORESTCLEARANCECHRG/100000,'0') + nvl(OTHERSCHRG/100000 ,'0')),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and ((a.LANDAQUISITIONOBTAINDATE is not null and a.LANDAQUISITION='Y') or  ( HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is not null) or (POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is not null ) or(ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is not null) or ( ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is not null ) or( RAILWAYCROSSINGPERMISSION ='Y' AND RAILWAYCROSSINGPEROBTAIN is not null ) or (WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is not null ) or(FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is not null ) or (OTHERS='Y' AND OTHERSOBTAINDATE is not null))  group by  substr(b.office_code,2,2) order by 1";

//System.out.println("Exp Query"+expobt);
rs2=stmt3.executeQuery(expobt);
Hashtable expobtdt=new Hashtable();
while(rs2.next())
{
	expobtdt.put(rs2.getString(2),rs2.getString(1));
}








/***********************************End  ************************************/



String query="select dname,dcode from rws_district_tbl  order by 1";
stmt2=conn.createStatement();
 rs1=stmt2.executeQuery(query);

String dname="";
int svs=0,mvs=0,svspre=0,mvspre=0,svscom=0,mvscom=0,dprex=0,svspart=0,mvspart=0,svspartclerence=0,mvspartclerence=0;
int gdsvs=0,gdmvs=0,gtot=0,railobtsobdtp=0,gsvspartcle=0,gcom=0,gsur=0,svssur=0,gsvspart=0,gpre=0,mvssur=0,gdprSVSTOBEPREPA=0,gdprMVSTOBEPREPA=0,gdprsvscomp=0,gdprmvscomp=0,gdprsvssurv=0;
int gdprmvssurv=0,gsvsmvs=0;
double rel1=0,grel1=0,relUpto=0,relCur=0,grelUpto=0,grelCur=0,relUptoSVS=0,relCurSVS=0,grelUptoSVS=0,grelCurSVS=0,partAMT=0,gpartaclerewncerallchrg=0;
double expUptoMVS=0,expCurSVS=0,expUptoSVS=0,expCurMVS=0,gexpUptoSVS=0,gexpCurSVS=0,gexpUptoMVS=0,gexpCurMVS=0,gpartaAMTtotal=0;
int totdprSVSTOBEPREPA=0,gdprrailobtdate=0,gdprexpchar=0,gpartatotal=0,gpartaMVStotal=0,gmvssvspart=0,gpartasvsclerancedate=0,gpartamvsclerancedate=0;
//lanper
int gdprlanpermision=0,groadstatobtdtobtdate=0,gdprforestobdtper=0,gdprhmwssbper=0,gdprforest=0,gdprpowerper=0,gdprrstate=0,gdprforestper=0,gdprwaterper=0,gdprrailwayper=0,gdprdprroadcross=0,dprroadcrossstates=0;
int mvafore=0,roadstobtsobdtp=0,lanobdtp=0,groadobtdtobtdate=0,gdprwaterobtdateper=0,waterobtsobdtp=0,forestsobdtp=0,gdprlanobdtper=0,totall=0,gdprotherper=0,dprotherp=0,svslan=0,dprswater=0,dprsrail=0,dprsroad=0,dprsroadstate=0,dprpowerp=0,dprhmwssp=0;
int powerobtdate=0,gexpobtdat=0,gpowerobtdat=0,otherobtdate=0,gotherobtdat=0,ghmwssobtdat=0,hmwssobtdate=0,total=0,total1=0,gtotal1=0;
int gTotal=0,railobtsobdtp1=0;
double expobtdate=0,gexpobtdate=0;

String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){
	
		
	
//	//dpr lan per
	String dprlanpermision=(String)dprlanper.get(rs1.getString(2));
//forest
String dprforestper=(String)dprforest.get(rs1.getString(2));

String dprwaterper=(String)dprwater.get(rs1.getString(2));
String dprrailwayper=(String)dprrailway.get(rs1.getString(2));

String dprdprroadcross=(String)dprroadcross.get(rs1.getString(2));

String dprrstate=(String)roadstate.get(rs1.getString(2));

String dprpowerper=(String)dprpower.get(rs1.getString(2));

String dprhmwssbper=(String)dprhmwssb.get(rs1.getString(2));

String dprotherper=(String)dprother.get(rs1.getString(2));
//lan obt dt


String dprlanobdtper=(String)lanobdt.get(rs1.getString(2));
//forest forestobdt
String dprforestobdtper=(String)forestobdt.get(rs1.getString(2));

String dprwaterobtdateper=(String)waterobtdate.get(rs1.getString(2));
String dprrailobtdate=(String)railobtdate.get(rs1.getString(2));

String roadobtdtobtdate=(String)roadobtdate.get(rs1.getString(2));

String roadstatobtdtobtdate=(String)roadstateobtdate.get(rs1.getString(2));

String powerobtdat=(String)powerobtdt.get(rs1.getString(2));

String otherobtdat=(String)otherobtdt.get(rs1.getString(2));

String hmwssobtdat=(String)hmwssobtdt.get(rs1.getString(2));
String expobtdat=(String)expobtdt.get(rs1.getString(2));


//totall+=(svslan+mvafore+dprswater+dprsrail+dprsroad+dprsroadstate+dprpowerp+dprhmwssp+dprotherp);

//String ss=(String)dprroadcrossstate.get(rs1.getString(3)+rs1.getString(4));
	  // stmt3=conn.createStatement();
	    //  //System.out.println("dprsvs"+dprsvs);
		// rs2=stmt3.executeQuery(dprsvs);
		
	//	while(rs2.next())
	//	{
	//		dprSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
			
	//	}

	
	
	
	
	%>
<tr></tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<%}
else{
%>
<td  class=rptLabel></td>


<%} %>


<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=1&dcode=<%=rs1.getString(2) %>')"><%= dprlanper.get(rs1.getString(2))==null?"0":(svslan=(Integer.parseInt((String)dprlanper.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=2&dcode=<%=rs1.getString(2) %>')"><%= dprforest.get(rs1.getString(2))==null?"0":(mvafore=(Integer.parseInt((String)dprforest.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=3&dcode=<%=rs1.getString(2) %>')"><%= dprwater.get(rs1.getString(2))==null?"0":(dprswater=(Integer.parseInt((String)dprwater.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=4&dcode=<%=rs1.getString(2) %>')"><%= dprrailway.get(rs1.getString(2))==null?"0":(dprsrail=(Integer.parseInt((String)dprrailway.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=5&dcode=<%=rs1.getString(2) %>')"><%= dprroadcross.get(rs1.getString(2))==null?"0":(dprsroad=(Integer.parseInt((String)dprroadcross.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=6&dcode=<%=rs1.getString(2) %>')"><%= roadstate.get(rs1.getString(2))==null?"0":(dprsroadstate=(Integer.parseInt((String)roadstate.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=7&dcode=<%=rs1.getString(2) %>')"><%= dprpower.get(rs1.getString(2))==null?"0":(dprpowerp=(Integer.parseInt((String)dprpower.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=8&dcode=<%=rs1.getString(2) %>')"><%= dprhmwssb.get(rs1.getString(2))==null?"0":(dprhmwssp=(Integer.parseInt((String)dprhmwssb.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=9&dcode=<%=rs1.getString(2) %>')"><%= dprother.get(rs1.getString(2))==null?"0":(dprotherp=(Integer.parseInt((String)dprother.get(rs1.getString(2))))) %></a></td>


<%

total=svslan+mvafore+dprswater+dprsrail+dprsroad+dprsroadstate+dprpowerp+dprhmwssp+dprotherp;
gTotal+=total;

 %>
<td class=rptValue ><%=total %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=1&subType=1&dcode=<%=rs1.getString(2) %>')"><%= lanobdt.get(rs1.getString(2))==null?"0":(lanobdtp=(Integer.parseInt((String)lanobdt.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=2&subType=1&dcode=<%=rs1.getString(2) %>')"><%= forestobdt.get(rs1.getString(2))==null?"0":(forestsobdtp=(Integer.parseInt((String)forestobdt.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=3&subType=1&dcode=<%=rs1.getString(2) %>')"><%= waterobtdate.get(rs1.getString(2))==null?"0":(waterobtsobdtp=(Integer.parseInt((String)waterobtdate.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=4&subType=1&dcode=<%=rs1.getString(2) %>')"><%= railobtdate.get(rs1.getString(2))==null?"0":(railobtsobdtp=(Integer.parseInt((String)railobtdate.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=5&subType=1&dcode=<%=rs1.getString(2) %>')"><%= roadobtdate.get(rs1.getString(2))==null?"0":(railobtsobdtp1=(Integer.parseInt((String)roadobtdate.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=6&subType=1&dcode=<%=rs1.getString(2) %>')"><%= roadstateobtdate.get(rs1.getString(2))==null?"0":(roadstobtsobdtp=(Integer.parseInt((String)roadstateobtdate.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=7&subType=1&dcode=<%=rs1.getString(2) %>')"><%= powerobtdt.get(rs1.getString(2))==null?"0":(powerobtdate=(Integer.parseInt((String)powerobtdt.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=8&subType=1&dcode=<%=rs1.getString(2) %>')"><%= hmwssobtdt.get(rs1.getString(2))==null?"0":(hmwssobtdate=(Integer.parseInt((String)hmwssobtdt.get(rs1.getString(2))))) %></a></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_workdpr_statusper_drill_sec_rpt.jsp?type=9&subType=1&dcode=<%=rs1.getString(2) %>')"><%= otherobtdt.get(rs1.getString(2))==null?"0":(otherobtdate=(Integer.parseInt((String)otherobtdt.get(rs1.getString(2))))) %></a></td>

<%

total1=lanobdtp+forestsobdtp+waterobtsobdtp+railobtsobdtp+roadstobtsobdtp+railobtsobdtp1+powerobtdate+hmwssobtdate+otherobtdate;
gtotal1+=total1;
if(expobtdt.get(rs1.getString(2))!=null && !expobtdt.get(rs1.getString(2)).equals("") ){
expobtdate=Double.parseDouble((String)expobtdt.get(rs1.getString(2)));
}else{
expobtdate=0;
}
 %>

<td class=rptValue ><%=total1 %></td>
<td class=rptValue ><%=ndf.format(expobtdate)  %></a></td>









<% 
//System.out.print("Total"+total1);
lanobdtp=0;forestsobdtp=0;waterobtsobdtp=0;railobtsobdtp=0;railobtsobdtp=0;railobtsobdtp1=0;powerobtdate=0;hmwssobtdate=0;otherobtdate=0;
roadstobtsobdtp=0;
total1=0;
total=0;
gtot+=svs+mvs;
svslan=0;mvafore=0;dprswater=0;dprsrail=0;dprsroad=0;dprsroadstate=0;dprpowerp=0;dprhmwssp=0;dprotherp=0;
gsur+=svssur+mvssur;
gpre+=svspre+mvspre;
gcom+=svscom+mvscom;
gsvspart+=mvspart+svspart;
gsvspartcle+=svspartclerence+ mvspartclerence;

gmvssvspart+=mvspart+svspart;
svssur=0;
mvssur=0;


//gdsvs+=gdsvs+Integer.parseInt(dsvs);


grel1+=rel1;
svs=0;
svspart=0;
mvspart=0;
mvs=0;
svspartclerence=0;
mvspartclerence=0;
svscom=0;
mvscom=0;
svspre=0;
mvspre=0;
//total 
if(dprlanpermision!=null && !dprlanpermision.equals("")){
	gdprlanpermision+=Double.parseDouble(dprlanpermision);
	}

if(dprforestper!=null && !dprforestper.equals("")){
	gdprforestper+=Integer.parseInt(dprforestper);
	}


if(dprwaterper!=null && !dprwaterper.equals("")){
	gdprwaterper+=Integer.parseInt(dprwaterper);
	}

if(dprrailwayper!=null && !dprrailwayper.equals("")){
	gdprrailwayper+=Integer.parseInt(dprrailwayper);
	}
if(dprdprroadcross!=null && !dprdprroadcross.equals("")){
	gdprdprroadcross+=Integer.parseInt(dprdprroadcross);
	}





if(dprrstate!=null && !dprrstate.equals("")){
	gdprrstate+=Integer.parseInt(dprrstate);
	}

if(dprpowerper!=null && !dprpowerper.equals("")){
	gdprpowerper+=Integer.parseInt(dprpowerper);
	}


if(dprhmwssbper!=null && !dprhmwssbper.equals("")){
	gdprhmwssbper+=Integer.parseInt(dprhmwssbper);
	}

if(dprotherper!=null && !dprotherper.equals("")){
	gdprotherper+=Integer.parseInt(dprotherper);
	}

if(dprlanobdtper!=null && !dprlanobdtper.equals("")){
	gdprlanobdtper+=Integer.parseInt(dprlanobdtper);
	}

if(dprforestobdtper!=null && !dprforestobdtper.equals("")){
	gdprforestobdtper+=Integer.parseInt(dprforestobdtper);
	}

if(dprwaterobtdateper!=null && !dprwaterobtdateper.equals("")){
	gdprwaterobtdateper+=Integer.parseInt(dprwaterobtdateper);
		}



if(dprrailobtdate!=null && !dprrailobtdate.equals("")){
	gdprrailobtdate+=Integer.parseInt(dprrailobtdate);
		}
	

if(roadobtdtobtdate!=null && !roadobtdtobtdate.equals("")){
	groadobtdtobtdate+=Integer.parseInt(roadobtdtobtdate);
		}



if(roadstatobtdtobtdate!=null && !roadstatobtdtobtdate.equals("")){
	groadstatobtdtobtdate+=Integer.parseInt(roadstatobtdtobtdate);
		}

if(powerobtdat!=null && !powerobtdat.equals("")){
	gpowerobtdat+=Integer.parseInt(powerobtdat);
		}
if(otherobtdat!=null && !otherobtdat.equals("")){
	gotherobtdat+=Integer.parseInt(otherobtdat);
		}

if(hmwssobtdat!=null && !hmwssobtdat.equals("")){
	ghmwssobtdat+=Integer.parseInt(hmwssobtdat);
		}


gexpobtdate+=expobtdate;


//if(expobtdat!=null && !expobtdat.equals("")){
	//gexpobtdat+=Integer.parseInt(expobtdat);
		//}

	}







//total
//gdsvs+=Integer.parseInt(dsvs);

%>
</tr>
<tr><td colspan=2 class=btext align=right>Total:</td>

<td  class=btext ><%=gdprlanpermision %></td>
<td  class=btext><%=gdprforestper %></td>
<td  class=btext ><%=gdprwaterper %></td>
<td  class=btext><%=gdprrailwayper %></td>
<td class=btext><%=gdprdprroadcross %></td>
<td  class=btext><%=gdprrstate %></td>
<td  class=btext><%=gdprpowerper %></td>
<td  class=btext><%=gdprhmwssbper %></td>
<td  class=btext><%=gdprotherper %></td>
<td  class=btext><%=gTotal %></td>
<td  class=btext><%=gdprlanobdtper %></td>
<td  class=btext><%=gdprforestobdtper %></td>
<td  class=btext><%=gdprwaterobtdateper %></td>
<td  class=btext><%=gdprrailobtdate %></td>
<td  class=btext><%=groadobtdtobtdate %></td>
<td  class=btext><%=groadstatobtdtobtdate %></td>


<td  class=btext><%=gpowerobtdat %></td>

<td  class=btext><%=ghmwssobtdat %></td>
<td  class=btext><%=gotherobtdat %></td>



<td  class=btext><%=gtotal1 %></td>
<td  class=btext><%=ndf.format(gexpobtdate) %></td>
</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>