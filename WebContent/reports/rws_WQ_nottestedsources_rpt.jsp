<%@ include file="./conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>

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

<body>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	StringBuffer loggedUser =new StringBuffer();
	loggedUser.append(user.getUserId());
	
	
	 StringBuffer source=null;
	  StringBuffer hp=null;
	  StringBuffer shp=null;
	  StringBuffer op=null;
	  StringBuffer pon=null;

	  StringBuffer source1=null;
	  StringBuffer hp1=null;
	  StringBuffer shp1=null;
	  StringBuffer op1=null;
	  StringBuffer pon1=null;
	  
StringBuffer dcode=new StringBuffer();
StringBuffer qry13=null;
if(request.getParameter("district")!=null && !request.getParameter("district").equals("")){
dcode.append(request.getParameter("district"));

}else{
	dcode.append(request.getParameter("dcode"));
}
  session.setAttribute("dcode",dcode);
StringBuffer divCode=new StringBuffer();

if(request.getParameter("divCode")!=null){
divCode.append(request.getParameter("divCode"));
}
  session.setAttribute("divCode",divCode);

StringBuffer finYear=new StringBuffer(request.getParameter("finyear"));
  session.setAttribute("finYear",finYear);

  String finyear=request.getParameter("finyear");
	String tdsfy[]=finyear.split("-");
	String yearStart = tdsfy[0];
	String yearEnd = tdsfy[1];
	session.setAttribute("yearStart", yearStart);
	session.setAttribute("yearEnd", yearEnd);
	//String financialYear = tdsfy[2];
  
/* StringBuffer yr =new StringBuffer();
	
	
	yr.append(finYear.substring(0,4));

  session.setAttribute("yr",yr);

StringBuffer prevMonth=new StringBuffer(RwsUtils.getPreviousMonth().toUpperCase());
StringBuffer cmonth=new StringBuffer(RwsUtils.getCurrentMont().toUpperCase());
StringBuffer prevprevMonth=new StringBuffer(RwsUtils.getPreviousMonth1().toUpperCase());


StringBuffer nextmonth=new StringBuffer(RwsUtils.getNextMonth().toUpperCase());

StringBuffer yr1=new StringBuffer();
StringBuffer yr2=new StringBuffer();
StringBuffer yr3=new StringBuffer();

	
	//"",yr2="",yr3="";
if(nextmonth.toString().equals("JAN") || nextmonth.toString().equals("FEB") || nextmonth.toString().equals("MAR")){
	// yr2.append(String.valueOf(Integer.parseInt(yr.toString())+1).toString());
	yr2.append(String.valueOf(Integer.parseInt(yr.toString())+1).toString());
}else{
yr2.append(yr.toString());
}

//if(cmonth.equals("JAN")|| cmonth.equals("FEB") || cmonth.equals("MAR")){
	if(cmonth.toString().equals("JAN")|| cmonth.toString().equals("FEB") || cmonth.toString().equals("MAR")){

		 //yr1=""+(Integer.parseInt(yr)+1);
		yr1.append(String.valueOf(Integer.parseInt(yr.toString())+1).toString());
}else{
 yr1.append(yr);
 //System.out.println("y1"+yr1);
 yr3.append(String.valueOf(Integer.parseInt(yr.toString())+1).toString());
 //yr3=""+(Integer.parseInt(yr)+1);
 //System.out.println("y3"+yr3);
 
 
 session.setAttribute("yr3",yr3);
 session.setAttribute("yr1",yr1);
 
}


session.setAttribute("yr1",yr1);
session.setAttribute("yr3",yr3); */

Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
int nothab=0,gnothab=0;



StringBuffer style=new StringBuffer();

int styleCount=0;

try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();
		%>


<table border = 0 cellspacing = 0 cellpadding = 0 width=50%   style="border-collapse:collapse" >
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=50% align="right" >		
				<tr align="right">
					<td  ><a href="javascript:history.go(-1)">Back| 
                  <!--   <a href="rws_WQ_RFD_excel.jsp" target="_new">Excel</a>-->
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class="gridhdbg" colspan="6"><b>WaterQuality Sources Not Tested  Abstract <%=finYear %></font></font></b></td>
		</tr>
      	<tr align=center>
		<td class="gridhdbg"rowspan=3>Sl.No</td>
		<td class="gridhdbg" rowspan=3>Circle</td>
		
	
  
</tr>
<tr>
<td class="gridhdbg" colspan=3 align=center ><b>Water Quality Sources  </b></td>
</tr>


<tr>
<td class="gridhdbg" align=center >Total No.Of Sources <br> </td>
<td class="gridhdbg" align=center >Total Tested Sources <br> </td>
<td class="gridhdbg" align=center >Total Not Tested Sources<br></td>




</tr>

       <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		<td class="gridhdbg">4</td>
		<td class="gridhdbg">5</td>
			</tr>
	<%
      
int tot=0;
	long totalno=0;
Statement stmt13=null;
	ResultSet rs13=null;
	
	 qry13=new StringBuffer();
//
	 //String qry13="select count(distinct a.source_code),substr(c.panch_code,1,2) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id  and to_date(b.prepared_on)>='1-APR-"+yr+"' and  to_date(b.prepared_on)<'31-MAR-"+yr3+"'";
	
	 
	 ///tested Sources 
	/* qry13.delete(0,qry13.length()); 
	 qry13.append("select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b where substr(source_code,20,2) in ('SO','HP','PD','OW','SH') and  to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2 "); */
	qry13.delete(0,qry13.length()); 
	 qry13.append("select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b,rws_source_tbl a,rws_complete_hab_view c where b.source_code=a.source_code and c.panch_code=substr(a.source_code,1,16) and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2");
	

	stmt13=conn.createStatement();
	//System.out.println("tested sources:"+qry13);
	rs13=stmt13.executeQuery(qry13.toString());
	Hashtable sources=new Hashtable();
	while(rs13.next())
	{
		//System.out.println("ghfghf==="+rs13.getString(1));
		tot=rs13.getInt(1);
		//totalno=totalno+tot;
	  sources.put(rs13.getString(2),rs13.getString(1));
	}
	qry13.delete(0,qry13.length()); 
	qry13.append(" select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b,rws_hp_subcomp_param_tbl a,rws_complete_hab_view c where b.source_code=a.hp_code and c.panch_code=substr(a.hp_code,1,16) and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2");
	
	rs13=stmt13.executeQuery(qry13.toString());
	Hashtable sources5=new Hashtable();
	while(rs13.next())
	{
		//System.out.println("ghfghf==="+rs13.getString(1));
		tot=rs13.getInt(1);
		//totalno=totalno+tot;
	  sources5.put(rs13.getString(2),rs13.getString(1));
	}
	qry13.delete(0,qry13.length()); 
	qry13.append("select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b,rws_shallowhandpumps_tbl a,rws_complete_hab_view c where b.source_code=a.SHALLOWHP_CODE and c.panch_code=substr(a.SHALLOWHP_CODE,1,16) and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2");
	rs13=stmt13.executeQuery(qry13.toString());
	Hashtable sources2=new Hashtable();
	while(rs13.next())
	{
		//System.out.println("ghfghf==="+rs13.getString(1));
		tot=rs13.getInt(1);
		//totalno=totalno+tot;
	  sources2.put(rs13.getString(2),rs13.getString(1));
	}
	qry13.delete(0,qry13.length()); 
	qry13.append(" select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b,RWS_OPEN_WELL_MAST_TBL a,rws_complete_hab_view c where b.source_code=a.openwell_CODE and c.panch_code=substr(a.openwell_CODE,1,16) and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2");
	rs13=stmt13.executeQuery(qry13.toString());
	Hashtable sources3=new Hashtable();
	while(rs13.next())
	{
		//System.out.println("ghfghf==="+rs13.getString(1));
		tot=rs13.getInt(1);
		//totalno=totalno+tot;
	  sources3.put(rs13.getString(2),rs13.getString(1));
	}
	qry13.delete(0,qry13.length()); 
	qry13.append("  select count(distinct b.source_code),substr(b.source_code,1,2) from rws_wq_test_results_tbl b,RWS_OPENWELL_POND_TBL a,rws_complete_hab_view c where b.source_code=a.pond_CODE and c.panch_code=substr(a.pond_CODE,1,16) and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"'");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(b.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(b.source_code,1,2) order by 2");
	rs13=stmt13.executeQuery(qry13.toString());
	Hashtable sources4=new Hashtable();
	while(rs13.next())
	{
		//System.out.println("ghfghf==="+rs13.getString(1));
		tot=rs13.getInt(1);
		//totalno=totalno+tot;
	  sources4.put(rs13.getString(2),rs13.getString(1));
	}
if(rs13!=null){rs13.close();}
    if(stmt13!=null){stmt13.close();}
//
//String q1="select substr(d.office_code,2,2),count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-APR-"+yr+"' and to_date(a.prepared_on)<'1-"+prevMonth+"-"+yr+"'  and  a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2)";



Statement stmt14=null,stmt15=null,stmt16=null,stmt17=null,stmt18=null;
ResultSet rs14=null,rs15=null,rs16=null,rs17=null,rs18=null;
//Not Tested
  
  

//String qry14="select count(distinct a.source_code),substr(c.panch_code,1,2) from rws_water_sample_collect_tbl a,rws_complete_hab_view c where   NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.source_code=b.source_code and to_date(b.prepared_on)>='1-APR-"+yr+"' and  to_date(b.prepared_on)<'31-MAR-"+yr3+"') and  c.panch_code=a.hab_code "  ;

	//qry14+=" group by  substr(c.panch_code,1,2) order by 2 ";
	//source 
	qry13.delete(0,qry13.length());
 qry13.append("select count(distinct a.source_code),substr(a.source_code,1,2) from rws_source_tbl  a,rws_complete_hab_view c where c.panch_code=substr(a.source_code,1,16) and length(source_code)=24 and  NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.source_code=b.source_code  and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"')" );
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(a.source_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(a.source_code,1,2) order by 2 ");
	
	stmt14=conn.createStatement();
	//System.out.println("not tested sources having lab results qry14:"+qry13);
	rs14=stmt14.executeQuery(qry13.toString());
	Hashtable sources1=new Hashtable();
	while(rs14.next())
	{
	  sources1.put(rs14.getString(2),rs14.getString(1));
	}
	
if(rs14!=null){rs14.close();}
    if(stmt14!=null){stmt14.close();}

//

			
   

//HPS
	qry13.delete(0,qry13.length());
	 qry13.append("select count(distinct a.hp_code),substr(a.hp_code,1,2) from rws_hp_subcomp_param_tbl  a,rws_complete_hab_view c  where c.panch_code=substr(a.hp_code,1,16) and length(hp_code)=24 and  NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.hp_code=b.source_code and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"')");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(a.hp_code,1,2) = '"+dcode.toString()+"' ");
	}

	qry13.append(" group by  substr(a.hp_code,1,2) order by 2 ");
	
	stmt15=conn.createStatement();
	//System.out.println("not tested hps having lab results qry15:"+qry13);
	rs15=stmt15.executeQuery(qry13.toString());
	Hashtable hps=new Hashtable();
	while(rs15.next())
	{
	  hps.put(rs15.getString(2),rs15.getString(1));
	}
	
if(rs15!=null){rs15.close();}
    if(stmt15!=null){stmt15.close();}

//




//ShallowHand Pump
	qry13.delete(0,qry13.length());
	 qry13.append("select count(distinct a.SHALLOWHP_CODE ),substr(a.SHALLOWHP_CODE,1,2) from rws_shallowhandpumps_tbl  a,rws_complete_hab_view c where c.panch_code=substr(a.SHALLOWHP_CODE,1,16) and  NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.SHALLOWHP_CODE =b.source_code and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"')");

	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(a.SHALLOWHP_CODE,1,2) = '"+dcode.toString()+"' ");
	}

	qry13.append(" group by  substr(a.SHALLOWHP_CODE,1,2) order by 2 ");
	
	stmt16=conn.createStatement();
	//System.out.println("not tested shp having lab results qry15:"+qry13);
	rs16=stmt16.executeQuery(qry13.toString());
	Hashtable shps=new Hashtable();
	while(rs16.next())
	{
	  shps.put(rs16.getString(2),rs16.getString(1));
	}
	
if(rs16!=null){rs16.close();}
    if(stmt16!=null){stmt16.close();}

//





//OPen Pump
	qry13.delete(0,qry13.length());
	 qry13.append("select count(distinct a.openwell_code),substr(a.openwell_code,1,2) from RWS_OPEN_WELL_MAST_TBL   a ,rws_complete_hab_view c where c.panch_code=substr(a.openwell_code,1,16) and   NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.openwell_code=b.source_code and  to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"')");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(a.openwell_code,1,2) = '"+dcode.toString()+"' ");
	}
	qry13.append(" group by  substr(a.openwell_code,1,2) order by 2 ");
	
	stmt17=conn.createStatement();
	//System.out.println("not tested pw having lab results qry17:"+qry13);
	rs17=stmt17.executeQuery(qry13.toString());
	Hashtable ops=new Hashtable();
	while(rs17.next())
	{
	  ops.put(rs17.getString(2),rs17.getString(1));
	}
	
if(rs17!=null){rs17.close();}
    if(stmt17!=null){stmt17.close();}

    
//






//ponds Pump
	qry13.delete(0,qry13.length());
	 qry13.append("select count(distinct a.pond_code),substr(a.pond_code,1,2) from RWS_OPENWELL_POND_TBL   a ,rws_complete_hab_view c where c.panch_code=substr(a.pond_code,1,16) and   NOT EXISTS(select b.source_code from rws_wq_test_results_tbl b where a.pond_code=b.source_code and to_date(b.prepared_on)>='1-APR-"+yearStart+"' and  to_date(b.prepared_on)<='31-MAR-"+yearEnd+"')");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	{
		qry13.append(" and  substr(a.pond_code,1,2) = '"+dcode.toString()+"' ");
	}

	qry13.append(" group by  substr(a.pond_code,1,2) order by 2 ");
	
	stmt18=conn.createStatement();
	//System.out.println("not tested pond having lab results qry18:"+qry13);
	rs18=stmt18.executeQuery(qry13.toString());
	Hashtable ps1=new Hashtable();
	while(rs18.next())
	{
	  ps1.put(rs18.getString(2),rs18.getString(1));
	}
	
if(rs18!=null){rs18.close();}
    if(stmt18!=null){stmt18.close();}

//
session.setAttribute("ps",ps1);
session.setAttribute("sources1",sources1);
session.setAttribute("shps",shps);
session.setAttribute("hps",hps);
session.setAttribute("ops",ops);

///////total number of sources/////////
long n1=0,n2=0,n3=0,n4=0,n5=0;
long t1=0,t2=0,t3=0,t4=0,t5=0;

//source 
/* String query="select count(distinct a.source_code),substr(a.source_code,1,2) from rws_source_tbl  a,RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_complete_hab_view r where M.ASSET_CODE=a.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code and a.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09')"; */
String query="select count(distinct a.source_code),substr(a.source_code,1,2) from rws_source_tbl  a ,rws_complete_hab_view c where c.panch_code=substr(a.source_code,1,16) and length(a.source_code)=24 ";
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
	query+=" and substr(a.source_code,1,2) = '"+dcode.toString()+"' ";
}
query+=" group by  substr(a.source_code,1,2) ";

stmt14=conn.createStatement();
//System.out.println("sources having lab results qry14:"+query);
rs14=stmt14.executeQuery(query);
Hashtable sources11=new Hashtable();
while(rs14.next())
{
	//n1=rs14.getInt(1);
	sources11.put(rs14.getString(2),rs14.getString(1));
}
//System.out.println(sources11.size());
if(rs14!=null){rs14.close();}
if(stmt14!=null){stmt14.close();}

//

		


//HPS
/* query="select count(distinct a.hp_code),substr(a.hp_code,1,2) from rws_hp_subcomp_param_tbl  a,RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_complete_hab_view r where M.ASSET_CODE=a.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code and a.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' "; */
query="select count(distinct a.hp_code),substr(a.hp_code,1,2) from rws_hp_subcomp_param_tbl  a ,rws_complete_hab_view c where c.panch_code=substr(a.hp_code,1,16) and length(a.hp_code)=24 ";
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
	query+=" and substr(a.hp_code,1,2) = '"+dcode.toString()+"' ";
}

query+=" group by  substr(a.hp_code,1,2) ";

stmt15=conn.createStatement();
//System.out.println("sources having lab results qry15:"+query);
rs15=stmt15.executeQuery(query);
Hashtable hps1=new Hashtable();
while(rs15.next())
{
	//n2=rs15.getInt(1);
	hps1.put(rs15.getString(2),rs15.getString(1));
}

if(rs15!=null){rs15.close();}
if(stmt15!=null){stmt15.close();}

//




//ShallowHand Pump
query="select count(distinct a.SHALLOWHP_CODE ),substr(a.SHALLOWHP_CODE,1,2) from rws_shallowhandpumps_tbl  a ,rws_complete_hab_view c where c.panch_code=substr(a.SHALLOWHP_CODE,1,16) ";

if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
	query+=" and substr(a.SHALLOWHP_CODE,1,2) = '"+dcode.toString()+"' ";
}

query+=" group by  substr(a.SHALLOWHP_CODE,1,2)";

stmt16=conn.createStatement();
//System.out.println("sources having lab results qry16:"+query);
rs16=stmt16.executeQuery(query);
Hashtable shps1=new Hashtable();
while(rs16.next())
{
	//n3=rs16.getInt(1);
	shps1.put(rs16.getString(2),rs16.getString(1));
}

if(rs16!=null){rs16.close();}
if(stmt16!=null){stmt16.close();}

//





//OPen Pump
query="select count(distinct a.openwell_code),substr(a.openwell_code,1,2) from RWS_OPEN_WELL_MAST_TBL   a,rws_complete_hab_view c where c.panch_code=substr(a.openwell_code,1,16) ";
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
	query+=" and substr(a.openwell_code,1,2) = '"+dcode.toString()+"' ";
}
query+=" group by  substr(a.openwell_code,1,2)  ";

stmt17=conn.createStatement();
//System.out.println("sources having lab results qry17:"+query);
rs17=stmt17.executeQuery(query);
Hashtable ops1=new Hashtable();
while(rs17.next())
{
	//n4=rs17.getInt(1);
	ops1.put(rs17.getString(2),rs17.getString(1));
}

if(rs17!=null){rs17.close();}
if(stmt17!=null){stmt17.close();}


//






//ponds Pump
query="select count(distinct a.pond_code),substr(a.pond_code,1,2) from RWS_OPENWELL_POND_TBL   a,rws_complete_hab_view c where c.panch_code=substr(a.pond_code,1,16) ";
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
	query+=" and substr(a.pond_code,1,2) = '"+dcode.toString()+"' ";
}

query+=" group by  substr(a.pond_code,1,2)";

stmt18=conn.createStatement();
//System.out.println("sources having lab results qry18:"+query);
rs18=stmt18.executeQuery(query);
Hashtable ps11=new Hashtable();
while(rs18.next())
{
	//n5=rs18.getInt(1);
	ps11.put(rs18.getString(2),rs18.getString(1));
}

if(rs18!=null){rs18.close();}
if(stmt18!=null){stmt18.close();}



//System.out.println("totalsources"+totalno);



long gtot1=0,tot1=0,tot2=0,tot3=0,hptot1=0,shptot1=0,pontot1=0,optot1=0,totalsources=0,gtotno=0;
			
qry13.delete(0,qry13.length());
 
	 
// "",divname="";			String query="";

if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
 
	qry13.append("select a.dcode,a.dname  from rws_district_tbl a where a.dcode='"+dcode.toString()+"' and a.dcode<>'16' order by a.dcode ");

}else if(dcode.toString().equals("00"))
{
	qry13.append("select a.dcode,a.dname  from rws_district_tbl a where  a.dcode<>'16' order by a.dcode");
}
int slno=1;
    // System.out.println("dcode query"+qry13);        
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(qry13.toString());
            
			  
			  StringBuffer cur1=new StringBuffer();
			  StringBuffer cur2=new StringBuffer();
			  StringBuffer cur3=new StringBuffer();
			  StringBuffer cur4=new StringBuffer();
			  StringBuffer cur5=new StringBuffer();
			  
			  
			   source=new StringBuffer();
			 hp=new StringBuffer();
			  shp=new StringBuffer();
			  op=new StringBuffer();
			  pon=new StringBuffer();
			  
			  source1=new StringBuffer();
				 hp1=new StringBuffer();
				  shp1=new StringBuffer();
				  op1=new StringBuffer();
				  pon1=new StringBuffer();
			  
			  
			  
			  while(rs.next())
		     {
            	
				
				  boolean flag=false;		
    			
				//total no of sources////
				
				  source1.delete(0,source1.length()); 
				 
				  source1.append((String.valueOf(sources11.get(rs.getString(1)))));	
				 
					 
					 if(source1.toString() != null && !source1.toString().equals(" ") && !source1.toString().equals("null") ){
						 
					
						 n1=Long.parseLong(source1.toString());
					
				}else{
					 source1.append("0");
				}	
					
					 hp1.delete(0,hp1.length()); 
					  hp1.append((String.valueOf(hps1.get(rs.getString(1)))));	
					  
					 
					 	 
					 	 if(hp1.toString()!=null && !hp1.toString().equals("") && !hp1.toString().equals("null") ){
					 	 
					 		 n2=Long.parseLong(hp1.toString());
					 	 
					 	 

					 }else{
					 	hp1.append("0");
					 }	
					  
					  
					  
					
					 shp1.delete(0,shp1.length());
					   shp1.append((String.valueOf(shps1.get(rs.getString(1)))));	
					  
					 	 
					  
					 	 
					 	 if(shp1.toString() != null && !shp1.toString().equals("") && !shp1.toString().equals("null") ){
					 	
					 		 n3=Long.parseLong(shp1.toString());

					 }else{
					 	shp1.append("0");
					 }	
					  
					  
					  
					
					 op1.delete(0,op1.length());
					  op1.append((String.valueOf(ops1.get(rs.getString(1)))));	
					  
					  if(op1.toString() != null && !op1.toString().equals("") && !op1.toString().equals("null") ){
					 	 
					 	 n4=Long.parseLong(op1.toString());
					  }
					 else{
					 op1.append("0");
					 }	
					 		
					  
					
					 pon1.delete(0,pon1.length());
					 pon1.append((String.valueOf(ps11.get(rs.getString(1)))));	
					  
					
					 	 if(pon1.toString() != null && !pon1.toString().equals("") && !pon1.toString().equals("null") ){
					 		 n5=Long.parseLong(pon1.toString());
					 }else{
					 	 pon1.append("0");
					 	
					 }
					 	totalno=0;
					 totalno=n1+n2+n3+n4+n5;
					gtotno+=totalno;
            	cur1.delete(0,cur1.length());
            	cur1.append(String.valueOf(sources.get(rs.getString(1))));	
            	if(cur1.toString() != null && !cur1.toString().equals("") && !cur1.toString().equals("null") ){
            		//tot3+=Long.parseLong(cur1.toString());
            		t1=Long.parseLong(cur1.toString());
            	
				}else{
					cur1.append("0");
				}	
				// System.out.println("1"+cur1.toString());
				 
				 cur2.delete(0,cur2.length());
	            	cur2.append(String.valueOf(sources5.get(rs.getString(1))));	
	            	if(cur2.toString() != null && !cur2.toString().equals("") && !cur2.toString().equals("null") ){
	            		//tot3+=Long.parseLong(cur2.toString());
	            		t2=Long.parseLong(cur2.toString());
	            	
					}else{
						cur2.append("0");
					}
					// System.out.println("2"+cur2.toString());
					 
					 cur3.delete(0,cur3.length());
		            	cur3.append(String.valueOf(sources2.get(rs.getString(1))));	
		            	if(cur3.toString() != null && !cur3.toString().equals("") && !cur3.toString().equals("null") ){
		            		//tot3+=Long.parseLong(cur3.toString());
		            		 t3=Long.parseLong(cur3.toString());
		            	
						}else{
							cur3.append("0");
						}
						// System.out.println("3"+cur3.toString());
						
						 cur4.delete(0,cur4.length());
			            	cur4.append(String.valueOf(sources3.get(rs.getString(1))));	
			            	if(cur4.toString() != null && !cur4.toString().equals("") && !cur4.toString().equals("null") ){
			            		//tot3+=Long.parseLong(cur4.toString());
			            		 t4=Long.parseLong(cur4.toString());
			            	
							}else{
								cur4.append("0");
							}
						//	 System.out.println("4"+cur4.toString());
							 cur5.delete(0,cur5.length());
				            	cur5.append(String.valueOf(sources4.get(rs.getString(1))));	
				            	if(cur5.toString() != null && !cur5.toString().equals("") && !cur5.toString().equals("null") ){
				            		//tot3+=Long.parseLong(cur5.toString());
				            		 t5=Long.parseLong(cur5.toString());
				            	
								}else{
									cur5.append("0");
								}
							//	 System.out.println("5"+cur5.toString());
								 
     
 
 //Not Tested sources
 source.delete(0,source.length()); 
  source.append((String.valueOf(sources1.get(rs.getString(1)))));	
 
	 
	 if(source.toString() != null && !source.toString().equals(" ") && !source.toString().equals("null") ){
		 tot1=Long.parseLong(source.toString());
	
}else{
	 source.append("0");
}	
 
 
 
 
//Not Tested HPS
hp.delete(0,hp.length()); 
 hp.append((String.valueOf(hps.get(rs.getString(1)))));	
 
	 
	 
	 if(hp.toString()!=null && !hp.toString().equals("") && !hp.toString().equals("null") ){
	 
		 hptot1=Long.parseLong(hp.toString());
	 
	 

}else{
	hp.append("0");
}	
 
 
 
//Not Tested shp
shp.delete(0,shp.length());
  shp.append((String.valueOf(shps.get(rs.getString(1)))));	
 
	 
	 
	 
	 if(shp.toString() != null && !shp.toString().equals("") && !shp.toString().equals("null") ){
	
		 shptot1=Long.parseLong(shp.toString());

}else{
	shp.append("0");
}	
 
 
 
//Not Tested op
op.delete(0,op.length());
 op.append((String.valueOf(ops.get(rs.getString(1)))));	
 if(op.toString() != null && !op.toString().equals("") && !op.toString().equals("null") ){
	 
	 optot1=Long.parseLong(op.toString());
 }
else{
op.append("0");
}	
		
 
//Not Tested ponds
pon.delete(0,pon.length());
pon.append((String.valueOf(ps1.get(rs.getString(1)))));	
 
	 
	 if(pon.toString() != null && !pon.toString().equals("") && !pon.toString().equals("null") ){
		 pontot1=Long.parseLong(pon.toString());
}else{
	 pon.append("0");
	
}	
 
 
 
 
 
 
	 totalsources=0;
 
 totalsources=pontot1+optot1+shptot1+hptot1+tot1;
 

gnothab+=nothab;

gtot1+=totalsources;

tot3+=t1+t2+t3+t4+t5;


if(styleCount%2==0){
	style.delete(0,style.length()); 
	style.append("gridbg1");
	
}else{
	style.delete(0,style.length()); 
	style.append("gridbg2");
}
styleCount++;





	       %>
	        <tr>
          
		        <td class="<%=style %>" style="text-align: left;"><%=slno++%></td>
	<td class="<%=style.toString() %>" style="text-align: left;"><%=rs.getString(2)%></td>	       			

 <td class="<%=style.toString()%>" style="text-align:right;"><%=totalno%></td> 	
 <td class="<%=style.toString()%>" style="text-align:right;"><%=t1+t2+t3+t4+t5%></td> 
<%-- <td class="<%=style.toString()%>" style="text-align:right;"><%=(totalno-totalsources)%></td> --%>

<td class="<%=style.toString() %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_nottestedsources_drill_count_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>&year=<%=yearStart.toString()%>&year1=<%=yearEnd.toString()%>')"><%=totalsources%></td>
			
		    </tr>




<% 

		}
%>
<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=gtotno%></td>
<td class="gridhdbg" style="text-align: right;"><%=tot3%></td>
<td class="gridhdbg" style="text-align: right;"><%=gtot1 %></td>

</tr>
	
		    <%
  }    
	
     catch(Exception e)
	   {

        e.printStackTrace();
	   }
	  finally
	  {
		  loggedUser=null;
		  dcode=null;
		  divCode=null;
		 /*  yr=null;
		  prevMonth=null;
		  cmonth=null;
		  prevprevMonth=null;
		  nextmonth=null;
		  yr1=null;
		  yr2=null;
		  yr3=null; */
		  style=null;
		  qry13=null;
		  pon=null;
		  shp=null;
		  hp=null;
		  source=null;
		  op=null;
	  }
	   %>
</table>

</body>
</html>

	  