<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   
String divname=request.getParameter("divname");
String cname=request.getParameter("cname");
String subdivname=request.getParameter("subdivname");
String year=(String)session.getAttribute("year");
String month=(String)session.getAttribute("month");

String circleofficecode=request.getParameter("circleofficecode");
System.out.println("circleofficecode************"+circleofficecode);
String divisionofficecode=request.getParameter("divisionofficecode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		System.out.println("dcode*********"+dcode);
		
}

   String dname="",dname1="";
    DecimalFormat ndf = new DecimalFormat("##.##");



 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<!-- <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Amount In Rupees </td>
</tr> -->
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="center" class="rptHeading" >District:<%=cname%>&nbsp;&nbsp;&nbsp;Division:<%=divname%> </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SL NO   </b></td>
<!--  <td class=btext ><b>Mandal  </b></td>
<td class=btext ><b>Panchayati  </b></td>
<td class=btext ><b>Village   </b></td>
 <td class=btext ><b>Source  </b></td>-->
 
 
 
 
 
 
 
 
<td class=btext ><b>Hab Code </b></td>
<td class=btext ><b>Hab Name   </b></td>



  </tr>


	<%ResultSet rs11=null;
	Statement stmt11=null;
	String z1="",z2="",z3="",z4="",z5="";
	
	try
      {
		//
		
		String eebudget11="";
     //  eebudget11="select b.lab_code,test_id,test_code,source_code,to_char(prepared_on,'dd/mm/yyyy')  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+mn+" ";
      eebudget11= "select c.panch_name,c.mname,c.pname,a.source_code,a.hab_code,c.vname,a.test_id  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+" order by 2 ";
     stmt11=conn.createStatement();
	   System.out.println("eebudget11:"+eebudget11);
		 rs11=stmt11.executeQuery(eebudget11);
		Hashtable eeList11=new Hashtable();
		while(rs11.next())
		{
			eeList11.put(rs11.getString(4),rs11.getString(1)+"#"+rs11.getString(2)+"#"+rs11.getString(3)+"#"+rs11.getString(5)+"#"+rs11.getString(6));
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

String query="";
//query="select  distinct SOURCE_CODE,LAB_CODE,TEST_ID,TEST_CODE ,to_char(PREPARED_ON,'dd/mm/yyyy') from RWS_WQ_TEST_RESULTS_TBL  where substr(source_code,1,2)='"+dcode+"'   and  substr(test_id,1,3)=cand substr(test_id,4,2)='"+s1+"' "+pmn+"  ";
//query="select count(distinct source_code),source_code  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+pmn+" group by  source_code";

//query="select  count(distinct source_code),source_code  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"' and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+mn+" group by  source_code";

query="select count(distinct a.source_code),a.source_code  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' and substr(c.panch_code,1,2)="+circleofficecode+" and a.division_office_code="+divisionofficecode+" group by  a.source_code ";

System.out.println("queryssss*******&&&&&&&&&&&*"+query);

rs3=stmt3.executeQuery(query);
String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	scode=rs3.getString(2);
	int hcount=rs3.getInt(1);
	System.out.println("scode+hcount"+scode);
	System.out.println("scode+hcount"+hcount);
	
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
		

		}
		else
		{
			z1="-";
			z2="-";
			z3="-";
			z4="-";
			z5="-";
			
		}

	
	
//System.out.println("prepared"+prepared);
%>
<tr>



<% 
if(!dname1.equals(z4)){
dname1=z4;
%>
<td  class=rptvalue><%=count++ %></td>
<% }
else{
%>
<td  class=rptvalue></td>
<%} %>
 








 <% 
if(!dname.equals(z4)){
dname=z4;
%>
<td  class=rptvalue><%=dname %></td>
<% }
else{
%>
<td  class=rptvalue></td>
<%} %>
 




<td class=rptvalue><%=z1 %></td>


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

