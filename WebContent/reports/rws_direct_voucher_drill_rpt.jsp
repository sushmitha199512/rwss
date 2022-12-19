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
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
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
		<td align="center" class="gridhdbg " ></td><td align="right" class="gridhdbg " >*** Amount In Rupees </td>
</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg " ></td><td align="center" class="gridhdbg " >District:<%=dname%>&nbsp;&nbsp;&nbsp;Division:<%=divname%>  </td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>Sl&nbsp;No   </b></td>
<td class=gridhdbg ><b>Work Id   </b></td>
<td class=gridhdbg ><b>Work Name  </b></td>
<td class=gridhdbg ><b>Bill&nbsp;Sl&nbsp;No</b></td>
<td class=gridhdbg ><b>Sanction Amount(Lakhs)   </b></td>
<td class=gridhdbg ><b>Category&nbsp;Code </b></td>
<td class=gridhdbg ><b>Voucher&nbsp;Amount </b></td>
<td class=gridhdbg ><b>Voucher&nbsp;No </b></td>
<td class=gridhdbg ><b>Voucher&nbsp;Date </b></td>
<td class=gridhdbg ><b>Cheque&nbsp;No </b></td>
<td class=gridhdbg ><b>Cheque&nbsp;Date </b></td>
<td class=gridhdbg ><b>Milestone&nbsp;Sl &nbsp;No</b></td>












  </tr>





	<%try
      { int count=1;
       Statement stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
       ResultSet rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
      double san=0.0,billcount=0.0,gbillcount=0.0,sancount=0.0,gsancount=0.0;
       String qry="";
       stmt3=conn.createStatement();
       int styleCount=0;
       String style="";
       String p2="";
      

boolean notGrounded=false;

       String distname1="",distname2="";
double explast=0,explastMonth=0,expcurMonth=0;
int habsCovered=0;

String query="";


query="SELECT w.WORK_ID,w.WORK_NAME,nvl(to_char(m.BILL_SL_NO),'-'),SANCTION_AMOUNT ,CATEGORY_CODE,m.VOUCHER_AMT,m.VOUCHER_NO,to_char(m.VOUCHER_DT,'dd/mm/yyyy'),m.CHEQUE_NO,to_char(m.CHEQUE_DT,'dd/mm/yyyy'),nvl(m.MILESTONE_SLNO,0) FROM RWS_WORK_ADMN_TBL W,rws_work_direct_voucher_tbl m   where  w.work_id=m.work_id  and work_cancel_dt is null and  substr(w.office_code,2,2)='"+circleofficecode+"' and substr(w.office_code,4,1)='"+divisionofficecode+"'  and  w.programme_code in ('04','57','65','46','12')  ";

System.out.println("query********"+query);
String sw="";
rs3=stmt3.executeQuery(query);

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
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(3) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(4) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(5) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(6) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(7) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(8) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(9) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(10) %></td>
<td class=<%=style %> style="text-align: right;"><%=rs3.getString(11) %></td>






</tr>
<% 



billcount=Double.parseDouble(rs3.getString(6));
gbillcount+=billcount;



sancount=Double.parseDouble(rs3.getString(4));
gsancount+=sancount;



} 
      %>
       <td class="gridhdbg" style="text-align: right;"  colspan=4>Total:</td>
       <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gsancount) %></td>
      <td class="gridhdbg" style="text-align: right;">-</td>
   
    
     <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gbillcount)%></td> 
     <td class="gridhdbg" style="text-align: right;">-</td>
     <td class="gridhdbg" style="text-align: right;">-</td>
     <td class="gridhdbg" style="text-align: right;">-</td>
     <td class="gridhdbg" style="text-align: right;">-</td>
     <td class="gridhdbg" style="text-align: right;">-</td>	 
      
      
      
      <% 
      }

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

