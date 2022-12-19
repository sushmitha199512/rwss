<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
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
<form>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;

String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");






int styleCount=0;
String style="";


int sno=1;


%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			


			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
			<%-- <td   class="bwborder"><a href="./rws_Action_Taken_rpt_xls.jsp?fromDate=<%=fromdate%>&toDate=<%=todate%>">Excel</a></td> --%>
			</tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan="14">Type of Adverse News Item Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="gridhdbg" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>

               <td class=gridhdbg >Sl.No</td>
               <td class=gridhdbg >District</td>
               <td class=gridhdbg >Water Availability[Scarcity]</td>
               <td class=gridhdbg >Water Quality Related[Contamination]</td>
               <td class=gridhdbg >Both[WS&WC]</td>
            	<td class=gridhdbg >Maintenance Problem</td>
            	<td class=gridhdbg >Others</td>
			  <td class=gridhdbg >Total</td>
			   </tr>
			  <tr >
			  <td class=gridhdbg align="center">1</td>
               
               <td class=gridhdbg align="center">2</td>
               <td class=gridhdbg align="center">3</td>
               <td class=gridhdbg align="center">4</td>
               <td class=gridhdbg align="center">5</td>
            	<td class=gridhdbg align="center">6</td>
            	<td class=gridhdbg align="center">7</td>
			  <td class=gridhdbg align="center">8</td>
			  </tr>
			   
<% 
try
{
	int tani1=0,tani2=0,tani3=0,tani4=0,tani5=0;
	int tottani1=0,tottani2=0,tottani3=0,tottani4=0,tottani5=0,tTotal=0;
	String query = "";
	query="select DCODE,DNAME from rws_district_tbl order by DCODE";
	stmt1=conn.createStatement();
	 rs1=stmt1.executeQuery(query); 
	 while(rs1.next()){
	 
  query="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='Water Availability' and DCODE='"+rs1.getString(1)+"' and PAPER_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy')";
  //System.out.println(query);
    stmt2=conn.createStatement();
  
   rs2=stmt2.executeQuery(query); 
   
   if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
   
   if(rs2.next())
      {
	   tani1=rs2.getInt(1);
	   %>
	    <tr bgcolor="#ffffff">
				<td class="<%=style %>" style="text-align: center;"><%=sno++%></td>
				<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(2)%></td>
				<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=Water Availability&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=tani1%></a></td>
	  
	   <%
      }
   rs2.close();
   stmt2.close();
   query="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='Water Quality Related' and DCODE='"+rs1.getString(1)+"' and PAPER_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy')";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  tani2=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=Water Quality Related&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=tani2%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='Both WS AND WC' and DCODE='"+rs1.getString(1)+"' and PAPER_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy')";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  tani3=rs2.getInt(1);
      %>
       
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=Both WS AND WC&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=tani3%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='Maintenance Problem' and DCODE='"+rs1.getString(1)+"' and PAPER_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy')";   
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  tani4=rs2.getInt(1);
      %>
       <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=Maintenance Problem&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=tani4%></a></td>
       <%
      }
   rs2.close();
   stmt2.close();
   query="select count(*) from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where TYPEOF_ADVERSE_NEWS_ITEM='Others' and DCODE='"+rs1.getString(1)+"' and PAPER_DATE between to_date('"+fromdate+"','dd/mm/yyyy')  and  to_date('"+todate+"','dd/mm/yyyy')";  
   stmt2=conn.createStatement();
 
  rs2=stmt2.executeQuery(query); 
  

  
  if(rs2.next())
     {
	  tani5=rs2.getInt(1);
      %>
      <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=Others&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=tani5%></a></td>
    
      <%
      }
   rs2.close();
   stmt2.close();
  
	   int total=tani1+tani2+tani3+tani4+tani5;
      %>
     
		<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_Typeof_Adverse_News_Item_drill_rpt.jsp?actionTaken=ALL&fromDate=<%=fromdate%>&toDate=<%=todate%>&dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=total%></a></td>		
				
			</tr>
      <%
      tottani1=tottani1+tani1;
      tottani2=tottani2+tani2;
      tottani3=tottani3+tani3;
      tottani4=tottani4+tani4;
      tottani5=tottani5+tani5;
     
      tTotal=tTotal+total;
      
	 }
	 %>
	  <tr>
<td class="gridhdbg" style="text-align: right;" colspan=2 >Total:</td>
<td class="gridhdbg" style="text-align: right;"><%=tottani1 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tottani2 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tottani3 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tottani4 %></td>
<td class="gridhdbg" style="text-align: right;"><%=tottani5 %></td>

<td class="gridhdbg" style="text-align: right;"><%=tTotal %></td>
</tr>
<%
    
}
catch(Exception e)
{
e.printStackTrace();
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
