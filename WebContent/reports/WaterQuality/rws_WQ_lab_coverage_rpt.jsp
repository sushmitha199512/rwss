<%@ include file="../conn.jsp" %>
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
	String loggedUser = user.getUserId();

String dcode="";

if(request.getParameter("district")!=null && !request.getParameter("district").equals("")){
dcode=request.getParameter("district");

}else{
	dcode=request.getParameter("dcode");
}
  session.setAttribute("dcode",dcode);
String divCode="";

if(request.getParameter("divCode")!=null){
divCode=request.getParameter("divCode");
}
  session.setAttribute("divCode",divCode);

String finYear=request.getParameter("finyear");
  session.setAttribute("finYear",finYear);

String yr =finYear.substring(0,4);
//System.out.println("yr******"+yr);
  session.setAttribute("yr",yr);
 String endyear= finYear.substring(5,9);
 
 System.out.println("yr****endyear**"+endyear);
  



Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
int nothab=0,gnothab=0;



String style="";

int styleCount=0;

try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();
		%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=70%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=70% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                  <!--   <a href="rws_WQ_RFD_excel.jsp" target="_new">Excel</a>-->
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class="gridhdbg" colspan="6"><b>WaterQuality Lab Abstract <%=finYear %></font></font></b></td>
		</tr>
      	<tr align=center>
		<td class="gridhdbg"rowspan=3>Sl.No</td>
		<td class="gridhdbg" rowspan=3>Circle</td>
		
	
  
</tr>
<tr>
<td class="gridhdbg" colspan=3 align=center ><b>Water Quality Laboratory Teststing Coverage </b></td>
</tr>


<tr>
<td class="gridhdbg" align=center >Total Habs <br> </td>
<td class="gridhdbg" align=center >Tested Habs<br></td>
<td class="gridhdbg" align=center >Not Tested Habs<br></td>



</tr>

       <tr align=center>
       <td class="gridhdbg">1</td>
        <td class="gridhdbg">2</td>
		<td class="gridhdbg">3</td>
		<td class="gridhdbg">4</td>
		<td class="gridhdbg">5</td>
	
			</tr>
	<%
      



//String q1="select substr(d.office_code,2,2),count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-APR-"+yr+"' and to_date(a.prepared_on)<'1-"+prevMonth+"-"+yr+"'  and  a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2)";

String q1="select dcode,count(*) from rws_complete_hab_view group by dcode order by dcode";



//String q1="select CIRCLE_OFFICE_CODE,count(*) from  RWS_HABITATION_DIRECTORY_TBL where  to_date(UPDATE_DATE )>='1-APR-"+yr+"' and to_date(UPDATE_DATE )<'31-MAR-"+yr3+"'  and COVERAGE_STATUS <>'UI' AND COVERAGE_STATUS  IS NOT NULL AND HAB_CODE IN(SELECT PANCH_CODE FROM RWS_COMPLETE_HAB_VIEW) group by CIRCLE_OFFICE_CODE  order by CIRCLE_OFFICE_CODE  ";
System.out.println("Q1"+q1);
stmt=conn.createStatement();
	
			ResultSet rss=stmt.executeQuery(q1);
			Hashtable uptoHash=new Hashtable();
			while(rss.next())
			{
			  uptoHash.put(rss.getString(1),rss.getString(2));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}



//String q2="select substr(d.office_code,2,2),count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-"+prevMonth+"-"+yr+"' and to_date(a.prepared_on)<'1-"+cmonth+"-"+yr1+"'  and a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2)";
//using sample collect
String q2="select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.test_id=b.test_id and C.COVERAGE_STATUS<>'UI' and C.COVERAGE_STATUS is not null and  to_date(b.PREPARED_ON)>='1-APR-2015' and  to_date(b.PREPARED_ON)<='31-MAR-2016'  group by  substr(c.panch_code,1,2) order by 1";

System.out.println("q2*****"+q2);
//System.out.println("Q1"+q2);
stmt=conn.createStatement();
	
			 rss=stmt.executeQuery(q2);
			Hashtable prevHash=new Hashtable();
			while(rss.next())
			{
			  prevHash.put(rss.getString(1),rss.getString(2));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}
			


String q3="select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_complete_hab_view c where NOT EXISTS (select a.hab_code from rws_wq_test_results_tbl b,rws_water_sample_collect_tbl a where a.test_id=b.test_id and a.hab_code=c.panch_code and  to_date(b.prepared_on)>='1-APR-2015' and  to_date(b.prepared_on)<='31-MAR-2016') and C.COVERAGE_STATUS<>'UI' and C.COVERAGE_STATUS is not null group by  substr(c.panch_code,1,2) order by 1";
System.out.println("Q3"+q3);
stmt=conn.createStatement();
	
		rss=stmt.executeQuery(q3);
			Hashtable nothabsHash=new Hashtable();
			while(rss.next())
			{
			  nothabsHash.put(rss.getString(1),rss.getString(2));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}




long tot1=0,tot2=0,tot3=0;
			
 String dname="",divname="";
			String query="";

if(dcode!=null && !dcode.equals("00")){
 

{
 query="select a.dcode,a.dname  from rws_district_tbl a where a.dcode='"+dcode+"' and a.dcode<>'16' order by a.dcode ";
}
}else if(dcode.equals("00")){
 query="select a.dcode,a.dname  from rws_district_tbl a where  a.dcode<>'16' order by a.dcode";
}
int slno=1;
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
            


			  while(rs.next())
		     {
            	boolean flag=false;		
    String upTo=(String)uptoHash.get(rs.getString(1));	
 if(upTo==null){
upTo="0";
}else{
  tot1+=Long.parseLong(upTo);
}	
String prev=(String)prevHash.get(rs.getString(1));	
 if(prev==null){
prev="0";
}else{
 tot2+=Long.parseLong(prev);
}	
 
String cur=(String)nothabsHash.get(rs.getString(1));	
 if(cur==null){
cur="0";
}else{
 tot3+=Long.parseLong(cur);
}	

nothab=Integer.parseInt(upTo)-Integer.parseInt(prev);
gnothab+=nothab;



if(styleCount%2==0){
	 style="gridbg1";
}else{
	 style="gridbg2";
}
styleCount++;





	       %>
	        <tr>
          
		        <td class="<%=style %>" style="text-align: left;"><%=slno++%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs.getString(2)%></td>	       			

<td class="<%=style %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverage_drill_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>&yr1=<%=yr%>&endyear=<%=endyear%>')"><%=upTo%></td>




<td class="<%=style %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverage_drilltestd_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>&yr1=<%=yr%>&endyear=<%=endyear%>')"><%=prev%></td>
<td class="<%=style %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverage_drillNOTtestd_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>&yr1=<%=yr%>&endyear=<%=endyear%>')"><%=cur%></td>


				
		    </tr>




<% 

		}
%>
<tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=tot1 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tot2 %></td>
<td class="gridhdbg" style="text-align: right;"><%=gnothab %></td></tr>
	
		    <%
  }    
	
     catch(Exception e)
	   {

        e.printStackTrace();
	   }
	  
	   %>
</table>

</body>
</html>

	  