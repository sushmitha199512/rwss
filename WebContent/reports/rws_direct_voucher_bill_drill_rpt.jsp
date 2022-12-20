<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
String divname=request.getParameter("divname");
  
String dname=request.getParameter("dname");
//String divisionofficecode=(String)session.getAttribute("divisionofficecode");

//System.out.println("divisionofficecode****************"+divisionofficecode);
String circleofficecode=request.getParameter("circleofficecode");
String divisionofficecode=request.getParameter("divisionofficecode");
System.out.println("divisionofficecode****************"+divisionofficecode);
String subdivisionofficecode=request.getParameter("subdivisionofficecode");
System.out.println("subdivisionofficecode"+subdivisionofficecode);
String programename=request.getParameter("pname");


//String divisionofficecode=request.getParameter("divisionofficecode");


String workid=(String)session.getAttribute("workid");

System.out.println("workid******"+workid);




String programe=request.getParameter("programe");
System.out.println("workid"+workid);
  String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none align = "right">			
			
            <a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<!-- <td align="center" class="gridhdbg" ></td><td align="right" class="gridhdbg " >*** Amount In Rupees </td> -->
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg " ></td><td align="center" class="gridhdbg ">District:<%=dname%>&nbsp;&nbsp;&nbsp;Division:<%=divname%>  </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg  ><b>Sl No   </b></td>
<td class=gridhdbg  ><b>Work Id   </b></td>
<td class=gridhdbg  ><b>Work Name  </b></td>
<td class=gridhdbg  ><b>Sanction   </b></td>
<td class=gridhdbg  ><b>Admin Date </b></td>


  </tr>





	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
      double san=0.0;
       String qry="";
       stmt3=conn.createStatement();
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";
/*String eebudget="select programme_name,programme_code from rws_programme_tbl";
    System.out.println("eebudget"+eebudget);

	Statement stmt22=conn.createStatement();
	   System.out.println("eebudget:"+eebudget);
		ResultSet rs22=stmt22.executeQuery(eebudget);
		Hashtable eeList=new Hashtable();
		while(rs22.next())
		{
			eeList.put(rs22.getString(2),rs22.getString(1));
		}
		if(rs22!=null)rs22.close();
		if(stmt22!=null)stmt22.close();
*/
////
//SELECT substr(w.office_code,2,2),substr(w.office_code,4,1),substr(w.office_code,5,2),p.PROGRAMME_NAME ,sp.SUBPROGRAMME_NAME,m.BILL_AMT_ADMISSIBLE    FROM RWS_WORK_ADMN_TBL W,rws_work_direct_bill_tbl  m, rws_programme_tbl p,rws_subprogramme_tbl sp   where w.PROGRAMME_CODE=p.PROGRAMME_CODE  and w.PROGRAMME_CODE=sp.PROGRAMME_CODE and sp.SUBPROGRAMME_CODE =w.SUBPROGRAMME_CODE  and p.PROGRAMME_CODE=sp.PROGRAMME_CODE and  w.work_id=m.work_id and substr(w.office_code,2,2)="+rs1.getString(4)+" and substr(w.office_code,4,1)="+rs1.getString(5)+" and substr(w.office_code,5,2)="+rs1.getString(2)+" and w.programme_code in ("+programe+") group by  substr(w.office_code,2,2),substr(w.office_code,4,1),substr(w.office_code,5,2),p.PROGRAMME_NAME ,sp.SUBPROGRAMME_NAME ,m.BILL_AMT_ADMISSIBLE order by 1";

//latest files
//query="select a.WORK_ID,b.WORK_NAME ,nvl(v.CATEGORY_NAME,'-'),nvl(a.BILL_SL_NO ,0),a.BILL_NO,to_char(a.bill_date)as a1,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'-'),ENTERED_BY ,a.BILL_AMT_CONTRACTOR,a.BILL_AMT_ADMISSIBLE,b.programme_code,SANCTION_AMOUNT  from rws_work_admn_tbl b ,rws_work_category_tbl v where b.CATEGORY_CODE =v.CATEGORY_CODE  and  substr(b.office_code,2,2)='"+circleofficecode+"' and substr(b.office_code,4,1)='"+divisionofficecode+"'   order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

 query="SELECT w.WORK_ID,w.WORK_NAME,nvl(to_char(w.ADMIN_DATE,'dd/mm/yyyy'),'-'),SANCTION_AMOUNT ,CATEGORY_CODE,CATEGORY_CODE FROM RWS_WORK_ADMN_TBL W   where   work_cancel_dt is null and  substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,1)='"+divisionofficecode+"'  and w.programme_code in ('04','57','65','46','12')   ";

 


System.out.println("query********"+query);
String sw="";
rs3=stmt3.executeQuery(query);
int styleCount=0;
String style="";
String p2="";

while(rs3.next()){
	
	/*	san=Double.parseDouble(rs3.getString(12))*100000;
	
	sw=(String)eeList.get(rs3.getString(11));
	if(sw!=null && !sw.equals(""))
	{
		
	}
	else
	{
		sw="-";
	}
	*/
	
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
%>
<tr><td class=<%=style %> style="text-align: left;"><%=count++ %></td>
<td class=<%=style %> style="text-align: left;"><%=rs3.getString(1) %></td>
<td class=<%=style %> style="text-align: left;"><%=rs3.getString(2) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(4) %></td>

<td class=<%=style %> style="text-align: right;"><%=rs3.getString(3) %></td>






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

