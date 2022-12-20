<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

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





/* Hashtable source=(Hashtable)session.getAttribute("sources1");
Hashtable ponds=(Hashtable)session.getAttribute("ps");
Hashtable shall=(Hashtable)session.getAttribute("shps");
Hashtable hand=(Hashtable)session.getAttribute("hps");
Hashtable open=(Hashtable)session.getAttribute("ops"); */






int count=1;
//String divname=request.getParameter("divname");
StringBuffer dname=new StringBuffer(String.valueOf(session.getAttribute("dname")));

//String year=request.getParameter("year");

//String subdivname=request.getParameter("subdivname");
//String yr=(String)session.getAttribute("yr");
//System.out.println("yr***"+yr);

//String yr1=request.getParameter("yr1"); 
StringBuffer yr1=new StringBuffer((String.valueOf(session.getAttribute("yearStart"))));
//System.out.println("Y1*******"+yr1);

StringBuffer yr3=new StringBuffer(String.valueOf(session.getAttribute("yearEnd")));

//System.out.println("Y3*******"+yr3);
//String circleofficecode=request.getParameter("circleofficecode");
//System.out.println("circleofficecode************"+circleofficecode);
//String divisionofficecode=request.getParameter("divisionofficecode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");














//String y11=request.getParameter("year");
//System.out.println("Y11*******"+y11);

//String y33=request.getParameter("year1");

//System.out.println("Y33*******"+y33);

StringBuffer stype=new StringBuffer(request.getParameter("stype"));


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
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<td  ><a href="javascript:history.go(-1)">Back| 
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>District</b></td>
<td class=gridhdbg ><b>Mandal </b></td>
<td class=gridhdbg ><b>Panchayat </b></td>
<td class=gridhdbg><b>Village </b></td>
<td class=gridhdbg><b>Hab Name </b></td>
<td class=gridhdbg><b>Hab Code </b></td>
<td class=gridhdbg><b>Source Code </b></td>


<td class=gridhdbg><b>Name </b></td>
<td class=gridhdbg><b>Location </b></td>




  </tr>


	<%ResultSet rs3=null,rs4=null;
	Statement stmt3=null,stmt4=null;
	
	//String z1="",z2="",z3="",z4="",z5="",z6="";
	int styleCount=0;
	StringBuffer style=new StringBuffer();
	StringBuffer qry=new StringBuffer();
	String []hhh=null;
	StringBuffer hh=new StringBuffer();

	try
      {
		qry.delete(0,qry.length());
		  qry.append("SELECT DNAME,MNAME,PNAME,VNAME,PANCH_NAME,PANCH_CODE FROM  RWS_COMPLETE_HAB_VIEW WHERE DCODE='"+dcode.toString()+"'"); 
		 /* qry.append("select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and a.dcode='"+dcode.toString()+"'"); */
		 //System.out.println("queryssss*******&&&&&&&&&&&"+qry);
		stmt4=conn.createStatement();
		rs4=stmt4.executeQuery(qry.toString());
		Hashtable sources=new Hashtable();
		
		while(rs4.next())
		{
		  sources.put(rs4.getString(6),rs4.getString(1)+"@"+rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5));
		}
		if(rs4!=null){
			rs4.close();
		}
		if(stmt4!=null){
			stmt4.close();
		}
		qry.delete(0,qry.length());
		//System.out.println("ooooo*"+qry);
if(stype.toString()!=null && stype.toString()!=("") && stype.toString().equals("SO"))
		{
	//System.out.println("queryssss*******&&&&&hhhhh&&&&&&*");
 qry.append("SELECT DISTINCT SUBSTR(A.SOURCE_CODE,1,16), A.SOURCE_CODE, NVL(A.SOURCE_NAME,'-'), NVL(A.LOCATION,'-') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SOURCE_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.HAB_CODE=V.PANCH_CODE AND M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' OR M.TYPE_OF_ASSET_CODE='02' OR M.TYPE_OF_ASSET_CODE='03' OR  M.TYPE_OF_ASSET_CODE='09') AND A.ASSET_CODE=S.ASSET_CODE AND NOT EXISTS(SELECT B.SOURCE_CODE FROM RWS_WQ_TEST_RESULTS_TBL B WHERE A.SOURCE_CODE=B.SOURCE_CODE AND TO_DATE(B.PREPARED_ON)>='1-APR-"+yr1.toString()+"' AND  TO_DATE(B.PREPARED_ON)<'31-MAR-"+yr3.toString()+"') AND  SUBSTR(A.SOURCE_CODE,1,2) = '"+dcode.toString()+"'");
stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&pppp"+qry);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(qry.toString());
//System.out.println("queryssss*******&&&&&&&&&&&666*"+qry);

//String scode="",labcode="",testid="",condemn="",prepared="";

if(!rs3.next()){
%>
<tr><td class="gridbg1" style="text-align: Center;" align="right" colspan="10">No Records Available</td></tr>
<%}else{
 do{
	hh.delete(0,hh.length());
	//System.out.println("System.out.println(sources.get(rs3.getString(1)));"+rs3.getString(1));
	//System.out.println("1111"+sources.get(rs3.getString(1)));
	if(sources.get(rs3.getString(1))!=null)
	{
		//System.out.println("5874");
		hh.append(String.valueOf(sources.get(rs3.getString(1))));
		hhh=hh.toString().split("@");
		hhh[0].toString();
		hhh[1].toString();
		hhh[2].toString();
		hhh[3].toString();
		hhh[4].toString();
		//System.out.println("1455");
	}
		
	style.delete(0,style.length());
	
	 if(styleCount%2==0){
		 style.append("gridbg1");
	 }else{
		 style.append("gridbg2");
	 }
	 styleCount++;
	
	
	

%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[0] %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[1]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[2]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[3]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[4]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>


<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>


</tr>
<% 

 }while(rs3.next());
}

	
	if(rs3!=null){
		rs3.close();
	}
	if(stmt3!=null){
		stmt3.close();
	}


}
qry.delete(0,qry.length());
if(stype.toString()!=null && stype.toString().equals("HP"))
{
qry.append("SELECT DISTINCT SUBSTR(A.HP_CODE,1,16), A.HP_CODE, NVL(M.ASSET_NAME,'-'), NVL(A.LOCATION,'-') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_HP_SUBCOMP_PARAM_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' AND A.ASSET_CODE=S.ASSET_CODE AND M.HAB_CODE=V.PANCH_CODE AND (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' OR SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' OR SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') AND NOT EXISTS(SELECT B.SOURCE_CODE FROM RWS_WQ_TEST_RESULTS_TBL B WHERE A.HP_CODE=B.SOURCE_CODE AND TO_DATE(B.PREPARED_ON)>='1-APR-"+yr1+"' AND  TO_DATE(B.PREPARED_ON)<'31-MAR-"+yr3+"') AND  SUBSTR(A.HP_CODE,1,2) = '"+dcode.toString()+"'"  );
stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+hpDetails);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(qry.toString());

//String scode="",labcode="",testid="",condemn="",prepared="";
if(!rs3.next()){
%>
<tr><td class="gridbg1" style="text-align: Center;" align="right" colspan="10">No Records Available</td></tr>
<%}else{
 do{
	hh.delete(0,hh.length());
	if(sources.get(rs3.getString(1))!=null)
	{
		 hh.append(String.valueOf(sources.get(rs3.getString(1))));
			hhh=hh.toString().split("@");
			hhh[0].toString();
			hhh[1].toString();
			hhh[2].toString();
			hhh[3].toString();
			hhh[4].toString();
	}
		
		
	style.delete(0,style.length());
	 if(styleCount%2==0){
		 style.append("gridbg1");
	 }else{
		 style.append("gridbg2");
	 }
	 styleCount++;
	
	
	

%>

<tr>
<td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[0] %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[1]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[2]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[3]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[4]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>




<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>


</tr>
<% 
 }while(rs3.next());

}

		if(rs3!=null){
			rs3.close();
		}
		if(stmt3!=null){
			stmt3.close();
		}
  

}


//op
qry.delete(0,qry.length());
if(stype.toString()!=null && stype.toString().equals("OP"))
{
qry.append("SELECT DISTINCT SUBSTR(A.OPENWELL_CODE,1,16),A.OPENWELL_CODE,NVL(M.ASSET_NAME,'-'),NVL(A.LOCATION,'-') FROM  RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_OPEN_WELL_MAST_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE AND NOT EXISTS(SELECT B.SOURCE_CODE FROM RWS_WQ_TEST_RESULTS_TBL B WHERE A.OPENWELL_CODE=B.SOURCE_CODE AND TO_DATE(B.PREPARED_ON)>='1-APR-"+yr1+"' AND  TO_DATE(B.PREPARED_ON)<'31-MAR-"+yr3+"') AND SUBSTR(A.OPENWELL_CODE,1,2) = '"+dcode+"'"  );
stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+sourceDetails);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(qry.toString());

//String scode="",labcode="",testid="",condemn="",prepared="";
if(!rs3.next()){
%>
<tr><td class="gridbg1" style="text-align: Center;" align="right" colspan="10">No Records Available</td></tr>
<%}else{
 do{
	hh.delete(0,hh.length());
if(sources.get(rs3.getString(1))!=null)
{
	 hh.append(String.valueOf(sources.get(rs3.getString(1))));
		hhh=hh.toString().split("@");
		hhh[0].toString();
		hhh[1].toString();
		hhh[2].toString();
		hhh[3].toString();
		hhh[4].toString();
}


style.delete(0,style.length());
if(styleCount%2==0){
 style.append("gridbg1");
}else{
 style.append("gridbg2");
}
styleCount++;




%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[0] %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[1]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[2]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[3]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[4]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>

<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>

</tr>
<% 
 }while(rs3.next());

}


if(rs3!=null){
rs3.close();
}
if(stmt3!=null){
stmt3.close();
}


}


//shp
qry.delete(0,qry.length());
if(stype.toString()!=null && stype.toString().equals("SHP"))
{
qry.append("SELECT DISTINCT SUBSTR(A.SHALLOWHP_CODE,1,16),A.SHALLOWHP_CODE,NVL(M.ASSET_NAME,'-'),NVL(A.LOCATION,'-') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE AND NOT EXISTS(SELECT B.SOURCE_CODE FROM RWS_WQ_TEST_RESULTS_TBL B WHERE A.SHALLOWHP_CODE=B.SOURCE_CODE AND TO_DATE(B.PREPARED_ON)>='1-APR-"+yr1.toString()+"' AND  TO_DATE(B.PREPARED_ON)<'31-MAR-"+yr3.toString()+"') AND SUBSTR(A.SHALLOWHP_CODE,1,2) = '"+dcode.toString()+"'"  );
stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+sourceDetails);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(qry.toString());

//String scode="",labcode="",testid="",condemn="",prepared="";
if(!rs3.next()){
%>
<tr><td class="gridbg1" style="text-align: Center;" align="right" colspan="10">No Records Available</td></tr>
<%}else{
 do{
	hh.delete(0,hh.length());
if(sources.get(rs3.getString(1))!=null)
{
	 hh.append(String.valueOf(sources.get(rs3.getString(1))));
		hhh=hh.toString().split("@");
		hhh[0].toString();
		hhh[1].toString();
		hhh[2].toString();
		hhh[3].toString();
		hhh[4].toString();
}


style.delete(0,style.length());
if(styleCount%2==0){
 style.append("gridbg1");
}else{
 style.append("gridbg2");
}
styleCount++;




%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[0] %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[1]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[2]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[3]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[4]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>

<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>
</tr>
<% 
 }while(rs3.next());

}


if(rs3!=null){
rs3.close();
}
if(stmt3!=null){
stmt3.close();
}


}








//ps
qry.delete(0,qry.length());
if(stype.toString()!=null && stype.toString().equals("PS"))
{
qry.append("SELECT DISTINCT SUBSTR(A.POND_CODE,1,16),A.POND_CODE,NVL(POND_NAME,'-'),NVL(POND_LOCATION,'-')  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_OPENWELL_POND_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE AND NOT EXISTS(SELECT B.SOURCE_CODE FROM RWS_WQ_TEST_RESULTS_TBL B WHERE A.POND_CODE=B.SOURCE_CODE AND TO_DATE(B.PREPARED_ON)>='1-APR-"+yr1.toString()+"' AND  TO_DATE(B.PREPARED_ON)<'31-MAR-"+yr3.toString()+"') AND  SUBSTR(A.POND_CODE,1,2) = '"+dcode.toString()+"'"  );
stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+sourceDetails);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(qry.toString());

//String scode="",labcode="",testid="",condemn="",prepared="";
//StringBuffer=new StringBuffer();
if(!rs3.next()){
%>
<tr><td class="gridbg1" style="text-align: Center;" align="right" colspan="10">No Records Available</td></tr>
<%}else{
 do{
	hh.delete(0,hh.length());
if(sources.get(rs3.getString(1))!=null)
{
//String hh=(String)sources.get(rs3.getString(1));
hh.append(String.valueOf(sources.get(rs3.getString(1))));
hhh=hh.toString().split("@");
hhh[0].toString();
hhh[1].toString();
hhh[2].toString();
hhh[3].toString();
hhh[4].toString();
}

style.delete(0,style.length());

if(styleCount%2==0){
 style.append("gridbg1");
}else{
 style.append("gridbg2");
}
styleCount++;




%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[0] %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[1]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[2]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[3]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=hhh[4]%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>


</tr>
<% 
 }while(rs3.next());

}


if(rs3!=null){
rs3.close();
}
if(stmt3!=null){
stmt3.close();
}


}

































      }
     catch(Exception e)
     {
     e.printStackTrace();
     }finally{
	conn.close();
} 
	%>
	
</table>
</form>

