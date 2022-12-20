<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
Statement stmt6=null,stmt3=null;
Statement stmt8=null;
ResultSet rs8=null;
Statement stmt7=null;
ResultSet rs7=null;
ResultSet rs6=null;
ResultSet rs3=null;
String attend="";
int wno=0;
int gwno=0;
String a="";
int s=0;
//
String fromdate=request.getParameter("fromDate");



	
Format formatter;

formatter = new SimpleDateFormat("dd/MM/yyyy");

fromdate=fromdate.replace("/","-");
//System.out.println("f1*************"+fromdate);
		
	String todate=request.getParameter("toDate");
	todate=todate.replace("/","-");
//


String dcode=request.getParameter("district");


int day=Integer.parseInt(fromdate.substring(0,2));
int month=Integer.parseInt(fromdate.substring(3,5));
int year=Integer.parseInt(fromdate.substring(6,10));

int day1=Integer.parseInt(todate.substring(0,2));
int month1=Integer.parseInt(todate.substring(3,5));
int year1=Integer.parseInt(todate.substring(6,10));


java.util.Date date = new java.util.Date(year-1900,month-1,day);
java.util.Date date1 = new java.util.Date(year1-1900,month1-1,day1);
formatter = new SimpleDateFormat("dd/MMM/yyyy");

//fromdate=fromdate.replace("/","-");
//System.out.println("f1*************"+fromdate);

		
	
	//todate=todate.replace("/","-");
String fromdate1=formatter.format(date);
String todate1=formatter.format(date1);
System.out.println("f1*************"+fromdate1);
System.out.println("f1*************"+todate1);



int sno=1;
int gcount=0;
int gcomplaintcount=0;

int gncomplaintcount=0;

int f1=0,gf1=0;
int d1=0,gd1=0;
int dcount=0,gdcount=0;
int b1=0;
int gb1=0;
int s1=0;
int gs1=0;
int t1=0;
int gt1=0;
String habsd="";
String habsf="";
String habsb="";
int ghabsf=0;
int ghabsd=0;
int ghabsb=0;
int r1=0;
int flush=0;
int deep=0;
int drought=0;
int gdrought=0;
int gflush=0;
int gdeep=0;
int conflush=0;
int condeep=0;
int gconflush=0;
int gcondeep=0;
int totcon=0;
int totrecords=0;
int gtotcon=0;
int gtotrecords=0;
int nonattendf=0;
int gnonattendf=0;
int nonattendd=0;
int gnonattendd=0;
int atnotcont=0;
int atnotcond=0;
int gatnotcont=0;
int gatnotcond=0;
int owflushing=0;
int owcontingency=0;
int owdeepcontingency=0;
int owdeepattended=0;
int totowconf=0;
int totowattendedf=0;
int totowcondeep=0;
int totowattendeddeep=0;
int totcontigency=0;
int totattended=0;

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			


			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Abstract Deepening /Flushing of Borewells Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=2 nowrap>Sl.No</td>
               <td class=btext rowspan=2 nowrap>District</td>
               <td class=btext rowspan=2 nowrap>No. of Drought Habitations</td>
               <td class=btext colspan=2 nowrap> Flushing Borewells</td> 
			   <td class=btext colspan=2 nowrap> Deepening Borewells</td> 
			   
			   <td class=btext colspan=2 nowrap> Deepening OpenWells</td> 
			   
               <td class=btext colspan=2 nowrap>Total ( Flushing or Deepening (Borewells and openwells) )</td> 
              
		   
			   </tr>
			   <tr>
			   <td class=btext>Contingency</td>
               <td class=btext>Attended</td>
			   <!-- <td class=btext>Not Attended</td>
			   <td class=btext>Attended But Not in Contingency</td> -->

			   <td class=btext>Contingency</td>
               <td class=btext>Attended</td>
			 <!--   <td class=btext>Not Attended</td>
<td class=btext>Attended But Not in Contingency</td> -->
			   
			     <td class=btext>Contingency</td>
               <td class=btext>Attended</td>
              
			   
			   <td class=btext>Total Contingency</td>
               <td class=btext>Total Attended</td>
			   </tr>
			   
<% 
try
{
    String query = "";
	 if(dcode!=null && !dcode.equals("") && dcode.equals("51"))
		{
	  query="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dname";
	  }
	else if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	{
	  query="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	  }
attend="";
  //System.out.println("frmdate"+fromdate);
//System.out.println("Todate"+todate);

  stmt1=conn.createStatement();
   stmt2=conn.createStatement();
  // stmt3=conn.createStatement();
   //stmt8=conn.createStatement();
   //stmt7=conn.createStatement();
  rs1=stmt1.executeQuery(query);
  while (rs1.next())
	{
	
//String qry1="select (select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='F' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a1,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where  deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a2,(select count(*) from RWS_DROUGHT_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and (to_date(FRM_DATE) >= '"+fromdate1+"' and to_date(to_date) >='"+todate1+"')  and (to_date(FRM_DATE) <='"+todate1+"' )  )a3,(select sum(flushing) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and to_date <= to_date('"+todate+"','dd-mm-yyyy'))a4,(select sum(deepening) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and to_date <= to_date('"+todate+"','dd-mm-yyyy'))a5   from dual";		

/* String qry1="select (select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='F' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a1,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where  deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a2,(select count(*) from RWS_DROUGHT_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and to_date(FRM_DATE) >= '"+fromdate1+"' and (to_date(frm_date) <='"+todate1+"' )  )a3,(select sum(flushing) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and frm_date <= to_date('"+todate+"','dd-mm-yyyy'))a4,(select sum(deepening) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and frm_date <= to_date('"+todate+"','dd-mm-yyyy'))a5   from dual"; */

String qry1="select  (select  count(distinct hp_code) from RWS_DROUGHT_FLUSH_DEEPEN_TBL a,rws_drought_habitation_tbl b where a.HABITATION_CODE=b.HABCODE  and  deepen_flush='F' and substr(HP_CODE,20,2) not in('OW') AND substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a1,(select  count(distinct hp_code) from RWS_DROUGHT_FLUSH_DEEPEN_TBL a,rws_drought_habitation_tbl b  where a.habitation_code=b.habcode and substr(hp_code,20,2) not in('OW')  AND deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a2,(select count(distinct habcode) from RWS_DROUGHT_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'   and FRM_DATE >= to_date('"+fromdate+"','dd-mm-yyyy'))a3,(select sum(flushing) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  year='"+year+"')a4,(select sum(deepening) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and  year='"+year+"')a5,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='F' and substr(habitation_code,1,2)='"+rs1.getString(1)+"'  and substr(hp_code,20,2)='OW' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate1+"','dd-mm-yyyy'))a6,(select count(flushing) from rws_drought_habitation_tbl a,RWS_DROUGHT_FLUSH_DEEPEN_TBL b  where a.HABCODE=b.habitation_code and substr(habcode,1,2)='"+rs1.getString(1)+"'  and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and frm_date <= to_date('"+todate+"','dd-mm-yyyy'))a7,(select sum(nvl(DEEP_OW_NUM,0))  from rws_drought_habitation_tbl  where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  year='"+year+"') a8,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"'  and substr(hp_code,20,2)='OW' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate1+"','dd-mm-yyyy'))a9 from dual";

//String qry1="select  (select  count(distinct hp_code) from RWS_DROUGHT_FLUSH_DEEPEN_TBL a,rws_drought_habitation_tbl b where a.HABITATION_CODE=b.HABCODE  and  deepen_flush='F' and substr(HP_CODE,20,2) not in('OW') AND substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a1,(select  count(distinct hp_code) from RWS_DROUGHT_FLUSH_DEEPEN_TBL a,rws_drought_habitation_tbl b  where a.habitation_code=b.habcode and substr(hp_code,20,2) not in('OW')  AND deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate+"','dd-mm-yyyy'))a2,(select count(distinct habcode) from RWS_DROUGHT_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'   and FRM_DATE >= to_date('"+fromdate+"','dd-mm-yyyy') and to_date<=to_date('"+todate+"','dd-mm-yyyy'))a3,(select sum(flushing) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  year=to_date(substr(frm_date,8,2),'yyyy')a4,(select sum(deepening) from rws_drought_habitation_tbl where substr(habcode,1,2)='"+rs1.getString(1)+"' and  year='2015')a5,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='F' and substr(habitation_code,1,2)='"+rs1.getString(1)+"'  and substr(hp_code,20,2)='OW' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate1+"','dd-mm-yyyy'))a6,(select count(flushing) from rws_drought_habitation_tbl a,RWS_DROUGHT_FLUSH_DEEPEN_TBL b  where a.HABCODE=b.habitation_code and substr(habcode,1,2)='"+rs1.getString(1)+"'  and  frm_date >= to_date('"+fromdate+"','dd-mm-yyyy') and frm_date <= to_date('"+todate+"','dd-mm-yyyy'))a7,(select sum(nvl(DEEP_OW_NUM,0))  from rws_drought_habitation_tbl  where substr(habcode,1,2)='"+rs1.getString(1)+"'  and  year='2015') a8,(select count(*) from RWS_DROUGHT_FLUSH_DEEPEN_TBL where deepen_flush='D' and substr(habitation_code,1,2)='"+rs1.getString(1)+"'  and substr(hp_code,20,2)='OW' and date_of_completion >= to_date('"+fromdate+"','dd-mm-yyyy') and  date_of_completion <= to_date('"+todate1+"','dd-mm-yyyy'))a9 from dual";
System.out.println("hhhqqqq"+qry1);
		
		
		

		
		
		  
		
		  rs2=stmt2.executeQuery(qry1);
          flush=0; 
          deep=0;
		  drought=0;
		  totcon=0;
		  totrecords=0;
          
		 while(rs2.next())
		{
			flush=rs2.getInt(1);
            deep=rs2.getInt(2);
			drought=rs2.getInt(3);
			conflush=rs2.getInt(4);
			condeep=rs2.getInt(5);
			owflushing=rs2.getInt(6);
			owcontingency=rs2.getInt(7);
			owdeepcontingency=rs2.getInt(8);
			owdeepattended=rs2.getInt(9);
			
				   
			 
		}
//for flush
        if(flush<conflush)
{
		nonattendf=conflush-flush;
        atnotcont=0;
}
else
{
      atnotcont=flush-conflush;
      nonattendf=flush-atnotcont;
}
//for deep
 if(deep<condeep)
{
		nonattendd=condeep-deep;
        atnotcond=0;
        
}
else
{
      atnotcond=deep-condeep;
      nonattendd=deep-atnotcond;
}
		
		gnonattendf=gnonattendf+nonattendf;
		gnonattendd=gnonattendd+nonattendd;
		//Contingency
		totcon=conflush+condeep;
		//total flush+deep
		totrecords=flush+deep;
		gtotcon=totcon+gtotcon;
		gtotrecords=totrecords+gtotrecords;
		gflush=flush+gflush;
		gdeep=gdeep+deep;
		gdrought=drought+gdrought;
		gconflush=conflush+gconflush;
		gcondeep=condeep+gcondeep;
//grand totals
gatnotcont=atnotcont+gatnotcont;
gatnotcond=atnotcond+gatnotcond;



totowconf=totowconf+owcontingency;
totowattendedf=totowattendedf+owflushing;

totowcondeep=totowcondeep+owdeepcontingency;
totowattendeddeep=totowattendeddeep+owdeepattended;

totcontigency=totcontigency+conflush+condeep+owcontingency+owdeepcontingency;
totattended=totattended+flush+deep+owflushing+owdeepattended;
//System.out.println("totcontigency"+totcontigency);
//System.out.println("totattended"+totattended);     
	
			
		%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
                <td class=rptValue NOWRAP><%=drought%></td>
                <td class=rptValue NOWRAP><%=conflush%></td>
				<%if(flush>0){%>
                <td class=rptValue NOWRAP><a href="rws_drought_deepen_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=1%>&fromdate=<%=fromdate%>&todate=<%=todate%>&dname=<%=rs1.getString(2)%>"><%=flush%></a></td>
				
				<%}
				else{%>
					<td class=rptValue NOWRAP><%=flush%></td>
					<%}%>
			<%-- 		<td class=rptValue NOWRAP><%=nonattendf%></td>
			<td class=rptValue NOWRAP><%=atnotcont%></td> --%>


				<td class=rptValue NOWRAP><%=condeep%></td>
				<%
				if(deep>0)
				{%>
				<td class=rptValue NOWRAP><a href="rws_drought_deepen_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=2%>&fromdate=<%=fromdate%>&todate=<%=todate%>&dname=<%=rs1.getString(2)%>"><%=deep%></a></td>
				
				<%}else{
					%>
					<td class=rptValue NOWRAP><%=deep%></td>
				
					<%}%>
					
					   <%-- <td class=rptValue NOWRAP><%=owcontingency%></td>
					   <%if(owflushing>0)
					   { %>
					   
					   
				      <td class=rptValue NOWRAP><a href="rws_drought_deepen_ow_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=1%>&fromdate=<%=fromdate%>&todate=<%=todate%>&dname=<%=rs1.getString(2)%>"><%=owflushing%></a></td>
				      <%}else{
				    	  %>
				    	  <td class=rptValue NOWRAP><%=owflushing%></td>
				
					<%}%> --%>
				       <td class=rptValue NOWRAP><%=owdeepcontingency%></td>
				       
				       <%if(owdeepattended>0){
				    	   %>
				      <td class=rptValue NOWRAP><a href="rws_drought_deepen_ow_rpt.jsp?district=<%=rs1.getString(1)%>&attend=<%=2%>&fromdate=<%=fromdate%>&todate=<%=todate%>&dname=<%=rs1.getString(2)%>"><%=owdeepattended%></a></td>
					<%}else{ %>
					 <td class=rptValue NOWRAP><%=owdeepattended%></td>
					 <%} %>
			<%-- 	<td class=rptValue NOWRAP><%=nonattendd%></td>
				<td class=rptValue NOWRAP><%=atnotcond%></td> --%>

                <td class=rptValue NOWRAP><%=conflush+condeep+owcontingency+owdeepcontingency%></td>
				<td class=rptValue NOWRAP><%=flush+deep+owflushing+owdeepattended%></td>
				
				
				</tr>
<%			
}
  


  
	%>
	<tr>
	 <td class="btext" colspan="2">Total:</td>
      
      <td class="btext" ><%=gdrought%></td> 
  	  <td class="btext" ><%=gconflush%></td>
	  <td class="btext" ><%=gflush%></td>
    <%--   <td class="btext" ><%=gnonattendf%></td>
            <td class="btext" ><%=gatnotcont%></td> --%>
	  <td class="btext" ><%=gcondeep%></td>
	  <td class="btext" ><%=gdeep%></td>
	  
	  <%--  <td class="btext" ><%=totowconf%></td>
	  <td class="btext" ><%=totowattendedf%></td> --%>
	  <td class="btext" ><%=totowcondeep%></td>
	  <td class="btext" ><%=totowattendeddeep%></td>
	 <%--  <td class="btext" ><%=gnonattendd%></td>
      <td class="btext" ><%=gatnotcond%></td> --%>
	 
	  <td class="btext" ><%=totcontigency%></td>
	   <td class="btext" ><%=totattended%></td>
	 	</tr>
	<%
}
catch(Exception e)
{
	
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</span>
