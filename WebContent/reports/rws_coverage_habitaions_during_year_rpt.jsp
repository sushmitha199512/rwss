<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%


StringBuffer distname1=new StringBuffer();
StringBuffer distname2=new StringBuffer();
StringBuffer sw=new StringBuffer();
StringBuffer style=new StringBuffer();

StringBuffer query=new StringBuffer();
    DecimalFormat ndf = new DecimalFormat("##.##");


 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
        <tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;</td>
        	<td class="bwborder"><a href="rws_coverage_habitaions_during_year_xls.jsp" target="_new">Excel</a></td></tr></tr>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>

</table>
<table   width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>Sl No   </b></td>
<td class=gridhdbg  ><b>District  </b></td>
<td class=gridhdbg  ><b>Work Id  </b></td>
<td class=gridhdbg ><b>Work Name  </b></td>
<td class=gridhdbg ><b>Programme Name </b></td>
<td class=gridhdbg  ><b>Hab Code  </b></td>
<td class=gridhdbg  ><b>Hab Name  </b></td>
<td class=gridhdbg  ><b>Coverage Status  </b></td>


  </tr>





	<%try
      { int count=1;
      int styleCount=0;
		
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
      double san=0.0;
       
       stmt3=conn.createStatement();
      

boolean notGrounded=false;




      // String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;


query.delete(0,query.length());
 query.append("select d.dname,a.work_id,WORK_NAME,HAB_CODE,ch.panch_name,ch.coverage_status,pr.programme_name from rws_work_admn_tbl a,rws_contractor_selection_tbl b,rws_admn_hab_lnk_tbl c ,rws_complete_hab_view ch,rws_programme_tbl pr,rws_district_tbl d  where substr(a.work_id,5,2)=d.dcode and substr(a.work_id,1,2)=pr.programme_code and c.hab_code=ch.panch_code and a.work_id=b.work_id and  a.work_id not in (Select work_id from rws_work_completion_tbl ) and to_char(PROBABLE_DATE,'dd,mm,yy')<='31/03/2014' and c.work_id=a.work_id");

 


//System.out.println("query********"+query);

rs3=stmt3.executeQuery(query.toString());

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
	 
	
	style.delete(0, style.length());
		 if(styleCount%2==0){
			 style.append("gridbg1");
		 }else{
			 style.append("gridbg2");
		 }
		 styleCount++;
    
%>
<tr><td class=<%=style %>  style="text-align: center"><%=count++ %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(1) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(2) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(3) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(7) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(4) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(5) %></td>
<td class=<%=style %>  style="text-align: left"><%=rs3.getString(6) %></td>







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
<%@ include file="/commons/rws_footer.jsp"%>

