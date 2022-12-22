<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   

String dname=request.getParameter("dname");
session.setAttribute("dname",dname);
String labCode=request.getParameter("labCode");
String labName=request.getParameter("labname");
String pmn=(String)session.getAttribute("pmn");
String divisionname=request.getParameter("divisionname");
String circleofficecode=request.getParameter("circleofficecode");
String divisionofficecode=request.getParameter("divisionofficecode");
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		
}

   String s1=(String)session.getAttribute("y1");
   if(pmn.equals("and to_char(prepared_on,'MON')='DEC'")){
	   int year=Integer.parseInt(s1);
	   year--;
	   s1=year+"";
   }
     
    DecimalFormat ndf = new DecimalFormat("##.##");

String testCode=request.getParameter("testCode");
 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="90%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<a href="#" onClick="window.close();">Close</a>
</td>
	</tr>  
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="center" class="rptHeading" >District:<%=dname%> </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SL NO   </b></td>
<td class=btext ><b>Mandal  </b></td>
<td class=btext ><b>Panchayat </b></td>
<td class=btext ><b>Village</b></td>
<td class=btext ><b>Habitation Code/<br/>Habitation Name</b></td>
 <td class=btext ><b>Source  </b></td>
 <td class=btext ><b>Lab Name  </b></td>
<td class=btext ><b>Lab Code </b></td>
<td class=btext ><b>TestId  </b></td>
<td class=btext ><b>Test Code  </b></td>
<td class=btext ><b>Prepared On   </b></td>


  </tr>


	<%ResultSet rs11=null;
	Statement stmt11=null;
	String z1="",z2="",z3="",z4="",z5="",z6="",z7="",z8="";
	
	try
      {
		
		String wqtest="";
        
        wqtest="select lab_code,test_id,test_code,source_code,to_char(prepared_on,'dd/mm/yyyy'),MNAME,PNAME,VNAME,PANCH_CODE,PANCH_NAME  from RWS_WQ_TEST_RESULTS_TBL a,rws_complete_hab_view b where  substr(source_code,1,2)=b.dcode and substr(source_code,6,2)=b.mcode and substr(source_code,13,2)=b.pcode and substr(source_code,8,3)=b.vcode and substr(source_code,1,16)=b.panch_code and  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+pmn+" ";
     if(testCode!=null && testCode!=""){
    	 wqtest+=" and test_code='"+testCode+"'";
     }

       
       
       stmt11=conn.createStatement();
		 rs11=stmt11.executeQuery(wqtest);
		Hashtable eeList11=new Hashtable();
		while(rs11.next())
		{
			eeList11.put(rs11.getString(4),rs11.getString(1)+"#"+rs11.getString(2)+"#"+rs11.getString(3)+"#"+rs11.getString(5)+"#"+rs11.getString(6)+"#"+rs11.getString(7)+"#"+rs11.getString(8)+"#"+rs11.getString(9)+"/ "+rs11.getString(10));
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


if(testCode!=null && testCode!=""){
	query="select source_code  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+pmn+" and test_code='"+testCode+"'";
}
else{
	query="select source_code,count(distinct source_code)  from RWS_WQ_TEST_RESULTS_TBL where  substr(source_code,1,2)='"+dcode+"'  and substr(test_id,1,3)='"+labCode+"' and substr(test_id,4,2)='"+s1+"' "+pmn+"  group by  source_code";
}

rs3=stmt3.executeQuery(query);
String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	scode=rs3.getString(1);
	
	String hiss=""+eeList11.get(rs3.getString(1));
	if(hiss!=null && !hiss.equals("") && !hiss.equals("null"))
		{
		String []zzz=hiss.split("#");
		z1=zzz[0];
		z2=zzz[1];
		z3=zzz[2];
		z4=zzz[3];
		
		z5=zzz[4];
		z6=zzz[5];
		z7=zzz[6];
		z8=zzz[7];
		

		}
		else
		{
			z1="-";
			z2="-";
			z3="-";
			z4="-";
			z5="-";
			z6="-";
			z7="-";
			
		}

	
	
%>
<tr><td class=rptValue><%=count++ %></td>
<td class=rptValue><%=z5 %></td>
<td class=rptValue><%=z6 %></td>
<td class=rptValue><%=z7 %></td>
<td class=rptValue><%=z8 %></td>


<td class=rptValue><%=rs3.getString(1) %></td>
<td class=rptValue><%=labName%></td>
<td class=rptValue><%=z1 %></td>
<td class=rptValue><%=z2 %></td>
<td class=rptValue><%=z3 %></td>
<td class=rptValue><%=z4 %></td>

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

