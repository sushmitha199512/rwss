<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
   
  
String dname=request.getParameter("dname");
String divisionname=request.getParameter("divisionname");
String circleofficecode=request.getParameter("circleofficecode");
String divisionofficecode=request.getParameter("divisionofficecode");
  String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="right" class="rptHeading" >*** Amount In Rupees </td>
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" ></td><td align="center" class="rptHeading" >District:<%=dname%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>  </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=btext ><b>SL NO   </b></td>
<td class=btext ><b>Work Id   </b></td>
<td class=btext ><b>Work Name  </b></td>
<td class=btext ><b>Program  </b></td>
<td class=btext ><b>Sanction   </b></td>
<td class=btext ><b>Work Category  </b></td>
<!-- <td class=btext ><b>Bill Type   </b></td> -->
<td class=btext ><b>Bill  No  </b></td>
<td class=btext ><b>Bill Date   </b></td>
<td class=btext ><b>Bill  Enterd Date  </b></td>
<td class=btext ><b>EE FWD Date  </b></td>
<td class=btext ><b>Bill AMT Contractor  </b></td>
<td class=btext ><b>Bill AMT Admissible  </b></td>


  </tr>





	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
       String qry="";
       double san=0.0;
       stmt3=conn.createStatement();
      
       String selectedProgramsFin="'01','48','32','23','49','51','18','60','59','58','50'";
boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
// query="select b.dname,a.WORK_ID ,a.WORK_NAME,to_char(ADMIN_DATE,'dd/mm/yyyy'),nvl(ADMIN_AMOUNT,'0') ,nvl(EXPENDITURE_UPTO,'0'),nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-')  from rws_drought_works_tbl a,rws_district_tbl  b where a.work_type='Deeping'  and  substr(a.office_code,2,2)=b.dcode and b.dcode='"+dcode+"'";
////query="SELECT  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_bill_tbl c where   substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and w.work_id=c.work_id and c.EE_FWD_DATE is  null and substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,2)='"+divisionofficecode+"'  group by  b.DIVISION_OFFICE_NAME ,c.WORK_ID,BILL_TYPE,c.BILL_SL_NO,c.EE_FWD_DATE,c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE order by 1 ";
//and DATE_OF_COMPLETION is not null 
///
String eebudget="select programme_name,programme_code from rws_programme_tbl";
   // System.out.println("eebudget"+eebudget);

	Statement stmt22=conn.createStatement();
	 //  System.out.println("eebudget:"+eebudget);
		ResultSet rs22=stmt22.executeQuery(eebudget);
		Hashtable eeList=new Hashtable();
		while(rs22.next())
		{
			eeList.put(rs22.getString(2),rs22.getString(1));
		}
		if(rs22!=null)rs22.close();
		if(stmt22!=null)stmt22.close();

///
query="SELECT c.WORK_ID,w.WORK_NAME ,nvl(v.CATEGORY_NAME ,'-') ,nvl(BILL_TYPE,'-'),c.BILL_NO,to_char(c.bill_date) as a1,nvl(to_char(c.UPDATE_DATE,'dd/mm/yyyy'),'-') ,nvl(to_char(c.EE_FWD_DATE,'dd/mm/yyyy'),'-'),c.BILL_AMT_CONTRACTOR,c.BILL_AMT_ADMISSIBLE,w.programme_code,SANCTION_AMOUNT  FROM RWS_WORK_ADMN_TBL W ,rws_work_bill_tbl c ,rws_work_category_tbl v where substr(w.work_id,1,2) in ("+selectedProgramsFin+" )   and   w.CATEGORY_CODE =v.CATEGORY_CODE and  bill_sl_no<>0 and   w.work_id=c.work_id and c.EE_FWD_DATE is  null   and substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,1)='"+divisionofficecode+"'  order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc"; 
//System.out.println("queryssss********"+query);
String sw="";
rs3=stmt3.executeQuery(query);

while(rs3.next()){
	
	san=Double.parseDouble(rs3.getString(12))*100000;
	sw=(String)eeList.get(rs3.getString(11));
	if(sw!=null && !sw.equals(""))
	{
		
	}
	else
	{
		sw="-";
	}

%>
<tr><td class=rptValue><%=count++ %></td>
<td class=rptValue><%=rs3.getString(1) %></td>
<td class=rptValue><%=rs3.getString(2) %></td>
<td class=rptValue><%=sw %></td>

<td class=rptValue><%=ndf.format(san) %></td>
<td class=rptValue><%=rs3.getString(3) %></td>


<td class=rptValue><%=rs3.getString(5) %></td>
<td class=rptValue><%=rs3.getString(6) %></td>
<td class=rptValue><%=rs3.getString(7) %></td>
<td class=rptValue><%=rs3.getString(8) %></td>
<td class=rptValue><%=rs3.getString(9) %></td>
<td class=rptValue><%=rs3.getString(10) %></td>


</tr>
<% 



}}

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

