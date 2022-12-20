<%@ include file="/reports/conn.jsp" %>
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

StringBuffer upTo=null;
StringBuffer prev=null;
System.out.println("dddddddd");

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());

StringBuffer dcode=new StringBuffer();
//StringBuffer yr =new StringBuffer();
dcode.delete(0,dcode.length());
dcode.append(request.getParameter("district"));
System.out.println("dcode***********************"+dcode);


session.setAttribute("dcode",dcode);
StringBuffer divCode=new StringBuffer();

if(request.getParameter("divCode")!=null){
divCode.append(request.getParameter("divCode"));
}
  session.setAttribute("divCode",divCode);

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


<table border = 0 cellspacing = 0 cellpadding = 0 width=70%   style="border-collapse:collapse"">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=70% align="right" >		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                  <!--   <a href="rws_WQ_RFD_excel.jsp" target="_new">Excel</a>-->
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class="gridhdbg" colspan="6"><b>WaterQuality Lab Abstract(2012-2014)</font></font></b></td>
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

StringBuffer q1=new StringBuffer("select dcode,count(*) from rws_complete_hab_view group by dcode order by dcode");

stmt=conn.createStatement();
	
			ResultSet rss=stmt.executeQuery(q1.toString());
			Hashtable uptoHash=new Hashtable();
			while(rss.next())
			{
			  uptoHash.put(rss.getString(1),rss.getString(2));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}



//String q2="select substr(d.office_code,2,2),count(*) from rws_wq_test_results_tbl a,RWS_WATER_QUALITY_LAB_TBL d where  to_date(a.prepared_on)>='1-"+prevMonth+"-"+yr+"' and to_date(a.prepared_on)<'1-"+cmonth+"-"+yr1+"'  and a.test_id in(select test_id from rws_wq_test_results_lnk_tbl) and a.lab_code=d.lab_code group by substr(d.office_code,2,2)";
q1.delete(0,q1.length());
//q1.append("select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and C.COVERAGE_STATUS<>'UI' and  to_date(SAMP_COLLECT_DATE)>='1-APR-"+yr+"' and  to_date(SAMP_COLLECT_DATE)<'31-MAR-"+yr3.toString()+"'  group by  substr(c.panch_code,1,2) order by 1");


q1.append("select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(b.prepared_on)>='1-JAN-2012' and  to_date(b.prepared_on)<='31-DEC-2014'  group by  substr(c.panch_code,1,2) order by 1");

stmt=conn.createStatement();
	
			 rss=stmt.executeQuery(q1.toString());
			Hashtable prevHash=new Hashtable();
			while(rss.next())
			{
			  prevHash.put(rss.getString(1),rss.getString(2));
			}


            
 if(rss!=null){rss.close();}
            if(stmt!=null){stmt.close();}
			


long tot1=0,tot2=0,tot3=0;
			
 //StringBuffer dname=new StringBuffer();
 //StringBuffer divname=new StringBuffer();
 
q1.delete(0,q1.length());	
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
 q1.append("select a.dcode,a.dname  from rws_district_tbl a where a.dcode='"+dcode.toString()+"' and a.dcode<>'16' order by a.dcode ");
}
else if(dcode.toString().equals("00"))
{
 q1.append("select a.dcode,a.dname  from rws_district_tbl a where  a.dcode<>'16' order by a.dcode");
}
int slno=1;
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(q1.toString());
            

			   upTo=new StringBuffer();
			   prev=new StringBuffer();
			  
			  while(rs.next())
		     {
				  
				
				  
            	boolean flag=false;
            	
            	upTo.delete(0,upTo.length());
              upTo.append((String.valueOf(uptoHash.get(rs.getString(1)))));
 if(upTo.equals("null")){
upTo.append("0");
}else{
  tot1+=Long.parseLong(upTo.toString());
}	
 prev.delete(0,prev.length());
prev.append((String.valueOf(prevHash.get(rs.getString(1)))));	
 if(prev.equals("null")){
	prev.append("0");
}else{
 tot2+=Long.parseLong(prev.toString());
}	


nothab=Integer.parseInt(upTo.toString())-Integer.parseInt(prev.toString());
gnothab+=nothab;


style.delete(0,style.length());
if(styleCount%2==0){
		 style.append("gridbg1");
}else{
	
	 style.append("gridbg2");
}
styleCount++;





	       %>
	        <tr>
          
		        <td class="<%=style.toString() %>" style="text-align: left;"><%=slno++%></td>
	<td class="<%=style.toString() %>" style="text-align: left;"><%=rs.getString(2)%></td>	       			

<td class="<%=style.toString() %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverage_drill_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>')"><%=upTo%></td>

<td class="<%=style.toString() %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverageall_drilltestd_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>')"><%=prev%></td>
<td class="<%=style.toString() %>" style="text-align:right;"><a href="#" onclick="viewWorks('rws_WQ_lab_coverageall_drillNOTtestd_rpt.jsp?dcode=<%=rs.getString(1)%>&dname=<%=rs.getString(2)%>')"><%=nothab%></td>


				
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
	  finally{
		  upTo=null;
		  loggedUser=null;
		  dcode=null;
		//  yr=null;
		  divCode=null;
		 /* finYear=null;
		  prevMonth=null;
		  cmonth=null;
		  prevprevMonth=null;
		  nextmonth=null;*/
		  //yr1=null;
		  //yr2=null;
		  //yr3=null;
		  style=null;
		  prev=null;
	  }
	   %>
</table>

</body>
</html>

	  