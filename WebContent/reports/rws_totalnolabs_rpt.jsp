<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form>
<%
int sno=1;
	  Statement st1=null,st2=null;
	  ResultSet rs1=null,rs2=null;
	  String qry="";
	  //Connection conn=null;
      String district=request.getParameter("district");
      //System.out.println("district***********"+district);
      String dname=request.getParameter("dname");
      // System.out.println("district***********"+dname);
     String asset="";
     String shp="";
     String openwell="";
     String source="";
     String pond=""; 
	 String stested="";
	 String stestedsamples="";

	 String gtxidValueOld = "",gtxidValue="";

	
ResultSet rs3=null,rs4=null,rs5=null;
Statement stmt1=null, stmt2=null,stmt3=null,stmt4=null,stmt5=null;
//date formate
String fromdate=request.getParameter("x");
String todate=request.getParameter("y");
//System.out.println("fromdate********"+fromdate);
//System.out.println("todate************"+todate);%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	Note:-<font color=red align=center>No. Of Sources=Sources + Handpumps + Openwells + Ponds + ShallowHandpumps</font>
	
	
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back |&nbsp;|</a></td>
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home  </td>
	<!--</a><a href="./rws_habgis_xls.jsp" target=_new>Excel</a></td>-->
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > Water Quality Sources  - Report</td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td class=btext>District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red></font>&nbsp;&nbsp;&nbsp;<font color=red> </font>&nbsp;&nbsp;&nbsp;FromDate:<font color=red><%=fromdate%></font>&nbsp;&nbsp;&nbsp;<font color=red> </font>ToDate:<font color=red><%=todate%></font>&nbsp;&nbsp;&nbsp;<font color=red>  </font></td>
	</tr>
	</table>
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
	<tr>
	<td class=btext  nowrap align=center>Sl.No</td>
    <td class=btext  nowrap align=center>District</td>
	<td class=btext  nowrap align=center>Division</td>
	<td class=btext  nowrap align=center>No. Of Sources</td>
    <td class=btext  nowrap align=center>Total No. Of LAB's</td>
	<td class=btext  nowrap align=center>No. Of Sources Tested</td>
	<td class=btext  nowrap align=center>No. Of Sample's Collected</td>
	</tr>
<%
try
{
int  totSources=0,sourcesTested=0,totLabs=0,totSamples=0;

///select count(*)  from rws_ftk_testing_tbl where  to_date(test_date,'dd-mon-yy')>='05-FEB-09' and to_date(test_date,'dd-mon-yy')<='10-FEB-10'
// asset="select   count(*),substr(source_code,1,2),division_office_code from rws_ftk_testing_tbl a,rws_complete_hab_view b where substr(source_code,1,16)=b.panch_code and to_date(test_date,'dd-mon-yy')>='"+fromdate+"' and to_date(test_date,'dd-mon-yy')<='"+todate+"' group by substr(source_code,1,2),division_office_code";
   asset="select count(*),c.circle_office_code,c.division_office_code from RWS_WATER_QUALITY_LAB_TBL a ,rws_district_tbl b,rws_division_office_tbl c  where a.status<>'UI' and c.circle_office_code=b.dcode and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code group by c.circle_office_code,c.division_office_code order by c.circle_office_code";
    
    
	Statement	stsh=conn.createStatement();
	//System.out.println("asset:"+asset);
	ResultSet rssh=stsh.executeQuery(asset);
	Hashtable shh=new Hashtable();
	while(rssh.next())
	{
	shh.put(rssh.getString(2)+rssh.getString(3),rssh.getString(1));
	}

///
  //shp="select   distinct count(*) from rws_wq_test_results_tbl";
    
	//Statement sh=conn.createStatement();
	//System.out.println("shp**********:"+shp);
	//ResultSet shrs=sh.executeQuery(shp);
	//Hashtable h1=new Hashtable();
	//while(shrs.next())
	//{
	//h1.put(shrs.getString(2)+shrs.getString(3),shrs.getString(1));
	//}
	




	//lab tested
//stested="select count(*),c.circle_office_code,c.division_office_code from RWS_WATER_QUALITY_LAB_TBL a ,rws_district_tbl b,rws_division_office_tbl c,RWS_WQ_TEST_RESULTS_TBL d  where a.status<>'UI' and c.circle_office_code=b.dcode and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and a.lab_code=d.lab_code and to_date(PREPARED_ON,'dd-mon-yy')>='"+fromdate+"' and to_date(PREPARED_ON,'dd-mon-yy')<='"+todate+"'group by c.circle_office_code,c.division_office_code order by c.circle_office_code";


stested="select count(distinct a.SOURCE_CODE ),b.CIRCLE_OFFICE_CODE ,b.DIVISION_OFFICE_CODE  from  RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_SAMPLE_COLLECT_TBL b where a.LAB_CODE =b.LAB_CODE and a.SOURCE_CODE =b.SOURCE_CODE and a.TEST_ID =b.TEST_ID and a.test_code=b.test_code and to_date(SAMP_COLLECT_DATE ,'dd-mon-yy')>='"+fromdate+"' and to_date(SAMP_COLLECT_DATE ,'dd-mon-yy')<='"+todate+"'  group by b.CIRCLE_OFFICE_CODE ,b.DIVISION_OFFICE_CODE";
 Statement sttd=conn.createStatement();
//System.out.println("sttd:"+sttd);
ResultSet rssd=sttd.executeQuery(stested);
Hashtable sth=new Hashtable();
while(rssd.next())
	{
sth.put(rssd.getString(2)+rssd.getString(3),rssd.getString(1));
	}

//end srinivas



//tot no of Samples

stestedsamples="select count(a.source_code),b.CIRCLE_OFFICE_CODE ,b.DIVISION_OFFICE_CODE  from  RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_SAMPLE_COLLECT_TBL b where a.LAB_CODE =b.LAB_CODE and a.SOURCE_CODE =b.SOURCE_CODE and a.TEST_ID =b.TEST_ID and a.test_code=b.test_code and to_date(SAMP_COLLECT_DATE ,'dd-mon-yy')>='"+fromdate+"' and to_date(SAMP_COLLECT_DATE ,'dd-mon-yy')<='"+todate+"'  group by b.CIRCLE_OFFICE_CODE ,b.DIVISION_OFFICE_CODE";
//System.out.println("sdfsdfs");
Statement sttdsamples=conn.createStatement();
System.out.println("sttdsamples:"+stestedsamples);
ResultSet rssdsamples=sttdsamples.executeQuery(stestedsamples);
Hashtable sthsamples=new Hashtable();
while(rssdsamples.next())
	{
sthsamples.put(rssdsamples.getString(2)+rssdsamples.getString(3),rssdsamples.getString(1));
	}









/////
String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
qry1+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
// System.out.println("qry1:"+qry1);
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(qry1);
Hashtable aht=new Hashtable();
while(rs1.next())
{
  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
}
//hp
String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";

	qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt2=conn.createStatement();
// System.out.println("qry2:"+qry2);
rs2=stmt2.executeQuery(qry2);
Hashtable hpht=new Hashtable();
while(rs2.next())
 {
   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
 }
 //open wells
 String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";

	qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt3=conn.createStatement();
// System.out.println("qry3:"+qry3);
rs3=stmt3.executeQuery(qry3);
Hashtable opht=new Hashtable();
while(rs3.next())
 {
   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
 }
 // shp
 String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt4=conn.createStatement();
// System.out.println("qry4:"+qry4);
rs4=stmt4.executeQuery(qry4);
Hashtable shpht=new Hashtable();
while(rs4.next())
 {
   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
 }
//ponds
String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt5=conn.createStatement();
// System.out.println("qry5:"+qry5);
rs5=stmt5.executeQuery(qry5);
Hashtable pondht=new Hashtable();
while(rs5.next())
 {
   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
 }

///
    
    //for hp count

	//qry="select count(*),dcode,dname,a.division_office_code,sd.division_office_name from rws_ftk_testing_tbl a,rws_district_tbl d,rws_division_office_tbl sd  where d.dcode=substr(source_code,1,2) and sd.division_office_code=a.division_office_code and sd.circle_office_code=substr(source_code,1,2) and d.dcode='"+district+"' group by dcode,dname,a.division_office_code,sd.division_office_name order by 2";
    if(district.equals("ALL"))
    {
    qry="select a.circle_office_code,a.circle_office_name,b.division_office_code,b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code  order by a.circle_office_code"; 
   }
   else
    {
       qry="select a.circle_office_code,a.circle_office_name,b.division_office_code,b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and a.circle_office_code='"+district+"'"; 
    }
  
//	System.out.println("qry************"+qry);
    st1=conn.createStatement();
	rs1=st1.executeQuery(qry);
	while(rs1.next())
	{
     String s1=(String)aht.get(rs1.getString(1)+rs1.getString(3));
     if(s1!=null && !s1.equals("") && !s1.equals("null"))
     {
     } 
     else
     {
      s1="0";
      }

//
     String s2=(String)hpht.get(rs1.getString(1)+rs1.getString(3));
     if(s2!=null && !s2.equals("") && !s2.equals("null"))
     {
     } 
     else
     {
      s2="0";
      }

//
     String s3=(String)opht.get(rs1.getString(1)+rs1.getString(3));
     if(s3!=null && !s3.equals("") && !s3.equals("null"))
     {
     } 
     else
     {
      s3="0";
      }     
// 
     String s4=(String)shpht.get(rs1.getString(1)+rs1.getString(3));
     if(s4!=null && !s4.equals("") && !s4.equals("null"))
     {
     } 
     else
     {
      s4="0";
      } 
   //
   String s5=(String)pondht.get(rs1.getString(1)+rs1.getString(3));
     if(s5!=null && !s5.equals("") && !s5.equals("null"))
     {
     } 
     else
     {
      s5="0";
      } 




int p1=0; 
p1=Integer.parseInt(s1)+Integer.parseInt(s2)+Integer.parseInt(s3)+Integer.parseInt(s4)+Integer.parseInt(s5);
//System.out.println("count"+p1);
String ftk=(String)shh.get(rs1.getString(1)+rs1.getString(3));
if(ftk!=null && !ftk.equals("") && !ftk.equals("null"))
{
}
else
{
ftk="0";
}
//
String sam=(String)sth.get(rs1.getString(1)+rs1.getString(3));
if(sam!=null && !sam.equals("") && !sam.equals("null"))
{
}
else
{
sam="0";
}

//


String samples=(String)sthsamples.get(rs1.getString(1)+rs1.getString(3));
if(samples!=null && !samples.equals("") && !samples.equals("null"))
		{
		}
		else
		{
			samples="0";
		}
//   
%>

	<tr>
    <td class="rptValue"><%=sno++%></td>
<%gtxidValue=rs1.getString(2);
if(!gtxidValue.equals(gtxidValueOld)){ %>
    <td class="btext" align=left><%=rs1.getString(2)%></td>
   
<%}else{ %>  
    <td class="btext" align=left></td> 
<%} %>







    <!-- <td class="btext" align=left><%=rs1.getString(2)%></td>   -->
    <td class="btext" align=left><%=rs1.getString(4)%></td>  
    <td class="rptValue" align=left><%=p1%></td>
     <td class="rptValue" align=left><%=ftk%></td>
    <td class="rptValue" align=left><%=sam%></td>
	<td class="rptValue" align=left><%=samples%></td>
    
   	</tr>

<%


totSources+=p1;
sourcesTested+= Integer.parseInt(sam);
totLabs+= Integer.parseInt(ftk);
totSamples+= Integer.parseInt(samples);
 gtxidValueOld = gtxidValue;
 }
    
 %>
<tr>
    <td class="rptValue"></td>
    <td class="rptValue" align=left></td>  
    <td class="btext" align=right>Total</td>  
    <td class="btext" align=left><%=totSources %></td>
	<td class="btext" align=left><%=totLabs %></td>
	<td class="btext" align=left><%=sourcesTested %></td>
<td class="btext" align=left><%=totSamples %></td>
   	</tr>
 
<%
 

	}catch(Exception e)
		{
		e.printStackTrace();
		}
%>
     

</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
