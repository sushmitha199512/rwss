<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
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


</script>
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

String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
session.setAttribute("fromdate",fromdate);
session.setAttribute("todate",todate);
	
System.out.println("fromdate"+fromdate);
		
System.out.println("todate"+todate);


int compaintno=0;
int attendedno=0;

String dcode1="";
String query2="";




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
			<td><a href="./rws_grievance_status_excel.jsp">Excel</a></td>
			<td class="bwborder"><a href="#" onclick="window.print()" >Print</a></td> </tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

<tr align="right">
<td class="bwborder"></td>
				
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Grievance Status Abstract Report</td>
</tr>
<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=3 >Sl.No</td>
               
               <td class=btext rowspan=3 >Date</td>
               <td class=btext  colspan="26">District</td>
                 <td class=btext  rowspan=2 colspan="2">Total</td>
              
            
			   
			  
			   </tr>
			  
			  <tr>
			  <%String qry="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dcode";
			  
			  stmt1=conn.createStatement();
			  rs1=stmt1.executeQuery(qry);
			  while (rs1.next())
				{
				  %>
				  <td class=btext colspan="2" ><%=rs1.getString(2)%></td> 
			<%
				}
			  %>
			  </tr>
			 
			   <tr>
			    <td class=btext>No</td>
              <td class=btext >Attended No</td>
              
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
              
                <td class=btext>No</td>
                <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
             <td class=btext >Attended No</td>
             
                <td class=btext>No</td>
            <td class=btext >Attended No</td>
            
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
               <td class=btext >Attended No</td>
               
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
                <td class=btext>No</td>
              <td class=btext >Attended No</td>
               
			  </tr>
			  
			   
<% 
try
{
	String query = "";
	int tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0,tot11=0,tot12=0,tot13=0;
	int atot1=0,atot2=0,atot3=0,atot4=0,atot5=0,atot6=0,atot7=0,atot8=0,atot9=0,atot10=0,atot11=0,atot12=0,atot13=0;
  query="select distinct to_char(COMPLAINT_DATE,'dd/mm/yyyy'),COMPLAINT_DATE from RWS_GENERIC_COMPLAINTS_REG_TBL where COMPLAINT_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') order by COMPLAINT_DATE ";  
    stmt2=conn.createStatement();
   
   rs2=stmt2.executeQuery(query); 
   System.out.println("first qry..."+query);

   
   while(rs2.next())
      {
	   int gcompaintno1=0;
	   int attendedno1=0;
      %>
      <tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs2.getString(1)%></td>
      <%
      
      
       String complaint=rs2.getString(1);
      query2="select dcode,dname from rws_district_tbl  order by dcode ";
      System.out.println("query2"+query2);
      stmt8=conn.createStatement();
      rs8=stmt8.executeQuery(query2);
      while(rs8.next())
      {
     dcode1=rs8.getString(1);
   query="select distinct count(complaint_no),count(ATTENDED_DATE ),to_date(COMPLAINT_DATE,'dd/mm/yyyy') from RWS_GENERIC_COMPLAINTS_REG_TBL where COMPLAINT_DATE=to_date('"+rs2.getString(1)+"','dd/mm/yyyy') and substr(habitation_code,1,2)='"+dcode1+"' group by to_date(COMPLAINT_DATE,'dd/mm/yyyy'),substr(habitation_code,1,2) order by to_date(COMPLAINT_DATE,'dd/mm/yyyy')";  
   stmt3=conn.createStatement();
  
  rs3=stmt3.executeQuery(query); 
  System.out.println("first qry. 1212.."+query);

  
  if(rs3.next())
     {
     
       compaintno=rs3.getInt(1);
       attendedno=rs3.getInt(2);
       
      
    
   %>
     <td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_grievance_status_drill.jsp?dcode=<%=dcode1%>&dname=<%=rs8.getString(2)%>&date=<%=rs2.getString(1)%>')"><%=compaintno%></a></td>
     <td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_grievance_status_drill1.jsp?dcode=<%=dcode1%>&dname=<%=rs8.getString(2)%>&date=<%=rs2.getString(1)%>')"><%=attendedno%></a></td>
       <%
     }
  else{
	  compaintno=0;
	  attendedno=0;
			
		%>
				
        <td class=rptValue align="right"><%=compaintno%></td>
     <td class=rptValue align="right"><%=attendedno%></td>      
				
				
<%			

  }
  rs3.close();
  stmt3.close();
  
  if(dcode1.equals("01")){
	  tot1+=compaintno;
	  atot1+=attendedno;
  }
  if(dcode1.equals("02")){
	  tot2+=compaintno;
	  atot2+=attendedno;
  }
  if(dcode1.equals("03")){
	  tot3+=compaintno;
	  atot3+=attendedno;
  }
  if(dcode1.equals("04")){
	  tot4+=compaintno;
	  atot4+=attendedno;
  }
  if(dcode1.equals("05")){
	  tot5+=compaintno;
	  atot5+=attendedno;
  }
  if(dcode1.equals("06")){
	  tot6+=compaintno;
	  atot6+=attendedno;
  }
  if(dcode1.equals("07")){
	  tot7+=compaintno;
	  atot7+=attendedno;
  }
  if(dcode1.equals("08")){
	  tot8+=compaintno;
	  atot8+=attendedno;
  }
  if(dcode1.equals("09")){
	  tot9+=compaintno;
	  atot9+=attendedno;
  }
  if(dcode1.equals("10")){
	  tot10+=compaintno;
	  atot10+=attendedno;
  }
  if(dcode1.equals("11")){
	  tot11+=compaintno;
	  atot11+=attendedno;
  }
  if(dcode1.equals("12")){
	  tot12+=compaintno;
	  atot12+=attendedno;
  }
  if(dcode1.equals("13")){
	  tot13+=compaintno;
	  atot13+=attendedno;
  }
  gcompaintno1+=compaintno;
  attendedno1+=attendedno;
     %>
  
  
     <%
  
     }
     rs8.close();
     stmt8.close();
   
	%>
	
	<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_grievance_status_drill2.jsp?date=<%=rs2.getString(1)%>')"><%=gcompaintno1%></a></td>
     <td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_grievance_status_drill3.jsp?date=<%=rs2.getString(1)%>')"><%=attendedno1%></a></td>   
	</tr>
	
	
		<%
}
   rs2.close();
   stmt2.close();
   %>
	<tr>
	<td class=btext colspan="2" align="right">Total</td>
	<td class=btext align="right"><%=tot1%></td>
	<td class=btext align="right"><%=atot1%></td>
	<td class=btext align="right"><%=tot2%></td>
	<td class=btext align="right"><%=atot2%></td>
	<td class=btext align="right"><%=tot3%></td>
	<td class=btext align="right"><%=atot3%></td>
	<td class=btext align="right"><%=tot4%></td>
	<td class=btext align="right"><%=atot4%></td>
	<td class=btext align="right"><%=tot5%></td>
	<td class=btext align="right"><%=atot5%></td>
	<td class=btext align="right"><%=tot6%></td>
	<td class=btext align="right"><%=atot6%></td>
	<td class=btext align="right"><%=tot7%></td>
	<td class=btext align="right"><%=atot7%></td>
	<td class=btext align="right"><%=tot8%></td>
	<td class=btext align="right"><%=atot8%></td>
	<td class=btext align="right"><%=tot9%></td>
	<td class=btext align="right"><%=atot9%></td>
	<td class=btext align="right"><%=tot10%></td>
	<td class=btext align="right"><%=atot10%></td>
	<td class=btext align="right"><%=tot11%></td>
	<td class=btext align="right"><%=atot11%></td>
	<td class=btext align="right"><%=tot12%></td>
	<td class=btext align="right"><%=atot12%></td>
	<td class=btext align="right"><%=tot13%></td>
	<td class=btext align="right"><%=atot13%></td>
	<td class=btext align="right"><%=tot1+tot2+tot3+tot4+tot5+tot6+tot7+tot8+tot9+tot10+tot11+tot12+tot13%></td>
	<td class=btext align="right"><%=atot1+atot2+atot3+atot4+atot5+atot6+atot7+atot8+atot9+atot10+atot11+atot12+atot13%></td>
       
	</tr>
	
	
		<%
   }
catch(Exception e)
{
System.out.println(""+e);
}
finally
{
	try
	{
		
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
