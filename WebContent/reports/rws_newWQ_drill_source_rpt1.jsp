<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   

String divsname=request.getParameter("divsname");
String cirname=request.getParameter("cirname");
String subdivname=request.getParameter("subdivname");

String month=(String)session.getAttribute("month");

String sourcec=request.getParameter("sourcec");
String year=(String)session.getAttribute("year");
String[] ar=year.split("-");
String yearStart=ar[0];
String yearEnd=ar[1];
//System.out.println("sourcec***********"+sourcec);

String ccode=request.getParameter("ccode");
//System.out.println("circleofficecode************"+circleofficecode);
String divoffcode=request.getParameter("divoffcode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
//System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}
   String testCode=request.getParameter("testCode");


    DecimalFormat ndf = new DecimalFormat("##.##");



 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="90%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<td  class="bwborder"><a href="javascript:history.go(-1)">Back|			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
		
		
		
		
		
		
		
		
		
		
		
	</caption>
<!-- <tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="right" class=gridhdbg >*** Amount In Rupees </td>
</tr> -->
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:<%=cirname%>&nbsp;&nbsp;&nbsp;Division:<%=divsname%> </td>
</tr>

</table>
<table    width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>Mandal  </b></td>
<td class=gridhdbg ><b>Panchayati  </b></td>
<td class=gridhdbg ><b>Village   </b></td>
<td class=gridhdbg ><b>Hab&nbsp;Name   </b></td>
<td class=gridhdbg ><b>Hab&nbsp;Code   </b></td>
<td class=gridhdbg ><b>Source  </b></td>
<td class=gridhdbg ><b>Lab&nbsp;Code </b></td>

<td class=gridhdbg ><b>Testing&nbsp;Parameter&nbsp;Code  </b></td>
<td class=gridhdbg ><b>Testing&nbsp;Parameter&nbsp;Name </b></td>
<td class=gridhdbg ><b>Testing&nbsp;Parameter&nbsp;Value </b></td>

  </tr>


	<%ResultSet rs11=null;
	Statement stmt11=null;
	String z1="",z2="",z3="",z4="",z5="",z6="",z7="",z8="",z9="";
	
	
	int styleCount=0;
	String style="";
	
	try
      {
		//
		
		String eebudget11="";
    
     
    
     eebudget11="select TESTING_PARAMETER_code ,TESTING_PARAMETER_NAME  from   rws_wq_para_test_tbl WHERE TEST_CODE='"+testCode+"'";
      
       stmt11=conn.createStatement();
	  //System.out.println("eebudget11:"+eebudget11);
		 rs11=stmt11.executeQuery(eebudget11);
		Hashtable eeList11=new Hashtable();
		while(rs11.next())
		{
			eeList11.put(rs11.getString(1),rs11.getString(2));
		}
		if(rs11!=null)rs11.close();
		if(stmt11!=null)stmt11.close();

		
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

StringBuffer query1=new StringBuffer();


query1.delete(0,query1.length());

query1.append("select b.lab_code,c.mname,c.pname,a.source_code,a.hab_code,c.vname,b.test_id,c.panch_Name ,TESTING_PARAMETER_CODE ,TESTING_PARAMETER_VALUE from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c, rws_wq_test_results_lnk_tbl d where a.test_id=b.test_id and a.test_id=d.test_id and b.test_id=d.test_id and c.panch_code=a.hab_code and a.source_code=b.source_code and a.source_code='"+sourcec+"' and a.test_id=b.test_id and substr(c.panch_code,1,2)="+ccode+" and a.division_office_code="+divoffcode+"");
				if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				 {
					query1.append(" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ");
				 }
				 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				 {
					 query1.append(" and SAMP_COLLECT_DATE between '"+yearStart+"' and '"+yearEnd+"'");
				 }
				 query1.append(" order by 2");
//query="select b.lab_code,c.mname,c.pname,a.source_code,a.hab_code,c.vname,b.test_id,c.panch_Name ,TESTING_PARAMETER_CODE ,TESTING_PARAMETER_VALUE from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c, rws_wq_test_results_lnk_tbl d where a.test_id=b.test_id and a.test_id=d.test_id and b.test_id=d.test_id and c.panch_code=a.hab_code and a.source_code=b.source_code and a.source_code='"+sourcec+"' and a.test_id=b.test_id and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' and substr(c.panch_code,1,2)="+ccode+" and a.division_office_code="+divoffcode+" order by 2 ";

//System.out.println("query*****"+query);

rs3=stmt3.executeQuery(query1.toString());
String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	scode=rs3.getString(2);
	int hcount=rs3.getInt(1);
	
	String hiss=""+eeList11.get(rs3.getString(9));
	//System.out.println("his*********"+hiss);
	if(hiss!=null && !hiss.equals("") && !hiss.equals("null"))
		{
		

		}
		else
		{
			
		hiss="_";	
			
			
		}

	
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	
	
//System.out.println("prepared"+prepared);
%>
<tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(2) %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(6) %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(5) %></td>

<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(4) %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(1) %></td>

<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;"><%=hiss %></td>
<td class="<%=style %>" style="text-align: left;"><%=rs3.getString(10) %></td>

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

