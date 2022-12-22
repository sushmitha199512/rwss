<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

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
   
String divname=request.getParameter("divname");
String cname=request.getParameter("cname");
String subdivname=request.getParameter("subdivname");
String year=(String)session.getAttribute("year");
String[] ar=year.split("-");
String yearStart=ar[0];
String yearEnd=ar[1];
String month=(String)session.getAttribute("month");
String typeofsource=request.getParameter("typeofsource");

String circleofficecode=request.getParameter("circleofficecode");
System.out.println("typeofsource************"+typeofsource);
String divisionofficecode=request.getParameter("divisionofficecode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
//System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");



 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:<%=cname%>&nbsp;&nbsp;&nbsp;Division:<%=divname%> </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>Mandal  </b></td>
<td class=gridhdbg><b>Panchayati  </b></td>
<td class=gridhdbg ><b>Village   </b></td>
<td class=gridhdbg ><b>Hab Name   </b></td>
<td class=gridhdbg ><b>Hab Code   </b></td>
<td class=gridhdbg ><b>Source  </b></td>
<td class=gridhdbg ><b>Lab&nbsp;Code </b></td>


  </tr>


	<%ResultSet rs11=null;
	Statement stmt11=null;
	String z1="",z2="",z3="",z4="",z5="",z6="";
	int styleCount=0;
	String style="";
StringBuffer eebudget11=new StringBuffer();
StringBuffer query=new StringBuffer();
	try
      {
		eebudget11.delete(0,eebudget11.length());
if(typeofsource!=null && typeofsource.equals("01"))
{
		eebudget11.append("select b.lab_code,c.mname,c.pname,a.source_code,a.hab_code,c.vname,a.test_id,c.panch_Name  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id  and substr(b.source_code,20,2)='SO' and substr(c.panch_code,1,2)='"+circleofficecode+"' and a.division_office_code='"+divisionofficecode+"'");
}
else
{
	eebudget11.append("select b.lab_code,c.mname,c.pname,a.source_code,a.hab_code,c.vname,a.test_id,c.panch_Name  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and substr(c.panch_code,1,2)='"+circleofficecode+"' and a.division_office_code='"+divisionofficecode+"'");
	}
					if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
					 {
						eebudget11.append(" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ");
					 }
					 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
					 {
						 eebudget11.append(" and SAMP_COLLECT_DATE between '"+yearStart+"' and '"+yearEnd+"'");
					 }
					 eebudget11.append(" order by 2");

		
		/* String eebudget11="";
     //  eebudget11="select b.lab_code,test_id,test_code,source_code,to_char(prepared_on,'dd/mm/yyyy')  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+mn+" ";
      eebudget11= "select b.lab_code,c.mname,c.pname,a.source_code,a.hab_code,c.vname,a.test_id,c.panch_Name  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  and to_char(SAMP_COLLECT_DATE,'dd/mm/yyyy') between '"+yearStart+"' and '"+yearEnd+"' and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+" order by 2 "; */
     stmt11=conn.createStatement();
	 // System.out.println("eebudget11:"+eebudget11);
		 rs11=stmt11.executeQuery(eebudget11.toString());
		Hashtable eeList11=new Hashtable();
		while(rs11.next())
		{
			eeList11.put(rs11.getString(4),rs11.getString(1)+"#"+rs11.getString(2)+"#"+rs11.getString(3)+"#"+rs11.getString(5)+"#"+rs11.getString(6)+"#"+rs11.getString(8));
		}
		if(rs11!=null)rs11.close();
		if(stmt11!=null)stmt11.close();

		//
		int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       double san=0.0;
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

query.delete(0,query.length());
if(typeofsource!=null && typeofsource.equals("01"))
{
query.append("select count(distinct a.source_code),a.source_code,b.test_code  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id  and substr(a.source_code,20,2)='SO' and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+"");
}
else
	{
	query.append("select count(distinct a.source_code),a.source_code,b.test_code  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+"");
	}
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
				query.append(" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ");
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
				 query.append(" and SAMP_COLLECT_DATE between '"+yearStart+"' and '"+yearEnd+"'");
			 }
			 query.append(" group by  a.source_code,b.test_code");
/* query="select count(distinct a.source_code),a.source_code  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  and SAMP_COLLECT_DATE between '"+yearStart+"' and '"+yearEnd+"' and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+" group by  a.source_code ";

System.out.println("queryssss*******&&&&&&&&&&&*"+query );*/

rs3=stmt3.executeQuery(query.toString());
String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	scode=rs3.getString(2);
	int hcount=rs3.getInt(1);
	//System.out.println("scode+hcount"+scode);
	//System.out.println("scode+hcount"+hcount);
	
	/*labcode=rs3.getString(2);
	testid=rs3.getString(3);
	condemn=rs3.getString(4);
	prepared=rs3.getString(5);*/
	////
	String hiss=""+eeList11.get(rs3.getString(2));
	if(hiss!=null && !hiss.equals("") && !hiss.equals("null"))
		{
		String []zzz=hiss.split("#");
		z1=zzz[0];
		z2=zzz[1];
		z3=zzz[2];
		z4=zzz[3];
		z5=zzz[4];
		z6=zzz[5];
		

		}
		else
		{
			z1="-";
			z2="-";
			z3="-";
			z4="-";
			z5="-";
			z6="-";
			
		}
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	
	
	
//System.out.println("prepared"+prepared);
%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=z2 %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=z3 %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=z5 %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=z6 %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=z4 %></td>



<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_source_rpt.jsp?ccode=<%=circleofficecode%>&divoffcode=<%=divisionofficecode%>&cirname=<%=cname%>&divsname=<%=divname %>&sourcec=<%=rs3.getString(2)%>&testCode=<%=rs3.getString(3)%>')"><%=rs3.getString(2) %></td>





<td class="<%=style %>" style="text-align: left;" align="right"><%=z1 %></td>

</tr>
<% 


}
}

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

