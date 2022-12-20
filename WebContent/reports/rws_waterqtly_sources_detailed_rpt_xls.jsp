<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>

<%

String circlecode=null,divisioncode=null,labcode=null,sourcecode=null,circlename=null,divisionname=null,labname=null,sourcename=null;
int slno=0;
	    circlename=(String)session.getAttribute("circlename");
	    divisionname=(String)session.getAttribute("divisionname");

	    labname=(String)session.getAttribute("lbName");
	    sourcename=(String)session.getAttribute("sName");
	   	    
		circlecode=(String)session.getAttribute("circlecode");
		
        divisioncode=(String)session.getAttribute("divisioncode");
        
		String year=(String)session.getAttribute("year");
        String month=(String)session.getAttribute("month");
		String mon="",yr=""; 
        yr=(String)session.getAttribute("yr");
		
        mon=(String)session.getAttribute("mon");
       
	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt13=null;
    ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs13=null;
	int gtotdw=0,gftk=0,gsample=0,gtsample=0,gtsource=0,gsample1=0,gsample2=0,gftktot=0,gsample3=0;
	

//System.out.println(" All circles"+yr);

 %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=70%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       
</caption>
  <tr align=center  align=center>
		<td class=btext colspan="11"><b><font color="blue">WaterQuality Sources Detailed Report</font></b></td>
		</tr>
        <tr align=center>
	        <td class=btext colspan="11"><b><font color="blue">Circle :<%=circlename%> &nbsp; Division:<%=divisionname%> &nbsp; Year:<%=yr%> &nbsp; Month:<%=mon%></font></b></td>
	       </tr>
	        <tr align=center>
			<td class=btext>Sl.No</td>
			<td class=btext>Habitation Code</td>
	        <td class=btext>Habitation Name</td>
	        <td class=btext>Source Code</td>
	        </tr>
	        <tr align=center>
	        <td class=btext>1</td>
	        <td class=btext>2</td>
	        <td class=btext>3</td>
	        <td class=btext>4</td>
	        </tr>     
        
	<%
       try{ 
             slno=1;
            String firstval="",nextval="";
           
        

           String qry7="select distinct panch_code,panch_name,source_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd where substr(source_code,1,16)=hd.panch_code and c.test_id is not null and c.circle_office_code='"+circlecode+"' and  c.division_office_code='"+divisioncode+"'";
		   if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
		   if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry7+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' order by 3";
			}			       
         	
		 stmt7=conn.createStatement();
	   //  System.out.println("detailed sources having lab results qry7:"+qry7);
		 rs7=stmt7.executeQuery(qry7);
         while(rs7.next())
           {
		      firstval=rs7.getString(1);
               %>

      
	        <tr>
              <td class=rptValue><%=slno++%></td>
			     <%if(!firstval.equals(nextval)){ %>
                 <td class=rptValue>&nbsp;<%=rs7.getString(1)%></td>
                 <td class=rptValue><%=rs7.getString(2)%></td>
                 <%}else{%>
                 <td class=rptValue>"</td>
                 <td class=rptValue>"</td>
                 <%} %>
                 <td class=rptValue><%=rs7.getString(3)%></td>
            </tr>
         
		    <%
              nextval=firstval;
             }
     
	
  }
    catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:");
        e.printStackTrace();
	   }
	  
	   %>
</table>

<pre align="left"><font color="red">
Note:-Total No. of Drinking Water Sources = Sum ( PWS+MPWS+CPWS+HANDPUMPS+OPENWELLS+PONDS+ SHALLOWHANDPUMPS )
</font></pre>

	  