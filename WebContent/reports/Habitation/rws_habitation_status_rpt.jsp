<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp"%>
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
String district=request.getParameter("district");
String mandal=request.getParameter("mandal");
String dname=(String)session.getAttribute("dname");
String finyear=request.getParameter("finyear");

/* int year = Calendar.getInstance().get(Calendar.YEAR); */
int year1=0, year2=0;
int updated_hab=0,tot_habs=0,updated_cov=0;
int notUpdated=0,notUpCovTot=0;

/* int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
    System.out.println("Financial month : " + month); 
   if (month < 4) {
   	year1=year-1;
   	year2=year;
        System.out.println("Financial Year : " + year1+ "-" + year2); 
   } else {
   	year1=year;
   	year2=year+1;
       System.out.println("Financial Year : " + year1 + "-" +year2);
   } */
   year1=Integer.parseInt(finyear.substring(0,4));
   year2=year1+1;
session.setAttribute("district", district);
session.setAttribute("mandal", mandal);
session.setAttribute("dname",dname);
session.setAttribute("year1", year1);
session.setAttribute("year2", year2);


String mname="";

String dcode="";
String mcode="";

int totalHabs=0,updatedHabTotal=0,updatedCovTotal=0,notUpdatedTotal=0,notUpdateCov=0;
int sno=1;
int styleCount=0;
String style="";


%>
	<table border=1 cellspacing=0 cellpadding=0 width="80%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
		<table border=0 rules=none style="border-collapse: collapse" align="right">			
				<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
				<tr>
					<td align="right" class="bwborder"><a
						href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>


					<td class="bwborder"><a
						href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
					<td class="bwborder"><a
						href="./rws_habitation_status_rpt_xls.jsp?type=count">Excel</a></td>
				</tr>
				<%  } else {%>
				<tr>
					<td align="right" class="bwborder"><a
						href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a
						href="#" onclick="window.close()">Close</a></td>
				</tr>
				<%} %>

			</table>
		</caption>

		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class=gridhdbg colspan="5">Habitation Status
				Details For <%=year1 %>-<%=year2 %> (District: <%=dname %>)
			</td>
		</tr>

	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr align=center>

			<td class=gridhdbg rowspan="3">Sl.No</td>
			<%if(district.equals("ALL")){ %>
			<td class=gridhdbg rowspan="3">District</td>
			<% } else{ %>
			<td class=gridhdbg rowspan="3">Mandal</td>
			<%} %>
			<td class=gridhdbg rowspan="3">Total No.of habitations</td>
			<td class=gridhdbg colspan="4">Habotations In Current Financial	Year</td>
		</tr>
		<tr>
			<td class=gridhdbg colspan="2">Habitation directory</td>
			<td class=gridhdbg colspan="2">Coverage Status Automation</td>	
		</tr>
		<tr align=center>
			<td class=gridhdbg>Updated</td>
			<td class=gridhdbg>Not Updated</td>
			<td class=gridhdbg>Updated</td>		
			<td class=gridhdbg>Not Updated</td>
		</tr>
		<%try
		{	 
			 String query = "";
			 if(district.equals("ALL")){
				 query="select distinct dname,dcode from rws_district_tbl";
				 }
			 else if(mandal.equals("ALL")){
			 query="select distinct dname,mname,dcode,mcode from RWS_COMPLETE_HAB_DYNA_VIEW where dcode='"+district+"'";
			 }
			 else{
				 query="select distinct dname,mname,dcode,mcode from RWS_COMPLETE_HAB_DYNA_VIEW where dcode='"+district+"' and mcode='"+mandal+"'";
			 }
				//System.out.println("query-----" + query);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				while (rs.next()) {
					if(district.equals("ALL")){
						dname= rs.getString(1); 
						dcode= rs.getString(2);
					}
					else{
						mname= rs.getString(2);
						dcode= rs.getString(3);
						mcode= rs.getString(4);
					}
					 if(styleCount%2==0){
						 style="gridbg1";
					 }else{
						 style="gridbg2";
					 }
					 styleCount++; %>
		<tr>
			<td class="<%=style %>" style="text-align: center;"><%=sno++%></td>
			<% if(district.equals("ALL")){  %>
			<td class="<%=style %>" style="text-align: left;"><%=dname%></td>
			<% } else{  %>
			<td class="<%=style %>" style="text-align: left;"><%=mname%></td>
			<%} 
			 if(district.equals("ALL")){
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 else{
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			tot_habs = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close(); 						
			 if(district.equals("ALL")){
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and  UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }
			 else{
				 query="select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and  UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
			 }			 	
	 		//System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			updated_hab = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
	 		if(district.equals("ALL")){
	 			query = "select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and update_date<to_date('01/04/"+ year1 + "','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "'  and a.COVERAGE_STATUS <> 'UI'";
	 		 }
	 		 else{
	 			query = "select count(HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b where  a.HAB_CODE=b.PANCH_CODE and update_date<to_date('01/04/"+ year1 + "','dd/mm/yyyy') and substr(HAB_CODE,1,2)='"+dcode+ "' and substr(HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI'";
	 		 }	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);
	 		if (rs1.next()) {
	 			notUpdated = rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();	 		
	 		if(district.equals("ALL")){
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and a.COVERAGE_STATUS <> 'UI' ";
	 		 }
	 		 else{
	 			query = "select count(a.HAB_CODE) from RWS_HABITATION_DIR_DYNA_TBL a,RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where a.HAB_CODE=b.PANCH_CODE and b.panch_code=c.hab_code and c.UPDATE_DATE  between to_date('01/04/"+year1+"','dd/mm/yyyy') and to_date('31/03/"+year2+"','dd/mm/yyyy') and substr(a.HAB_CODE,1,2)='"+dcode+"' and  substr(a.HAB_CODE,6,2)='"+mcode+ "' and a.COVERAGE_STATUS <> 'UI' ";
			}	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);	 		
	 		if(rs1.next()) {
	 			updated_cov=rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
	 		if(district.equals("ALL")){
	 			query = "select (select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(b.panch_code,1,2)='"+dcode+"' and b.COVERAGE_STATUS <> 'UI')+(select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b where substr(b.panch_code,1,2)='"+dcode+"' and b.COVERAGE_STATUS <> 'UI' and b.PANCH_CODE not in (select hab_code from RWS_HAB_SUPPLY_STATUS_TBL))+(select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where b.panch_code=c.hab_code and c.UPDATE_DATE is null  and substr(b.panch_code,1,2)='"+dcode+"' and b.COVERAGE_STATUS <> 'UI' ) from dual";
	 		 }
	 		 else{
	 			query = "select (select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where b.panch_code=c.hab_code and c.UPDATE_DATE<to_date('01/04/"+year1+"','dd/mm/yyyy') and substr(b.panch_code,1,2)='"+dcode+"' and  substr(b.panch_code,6,2)='"+mcode+ "' and b.COVERAGE_STATUS <> 'UI')+(select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b where substr(b.panch_code,1,2)='"+dcode+"' and  substr(b.panch_code,6,2)='"+mcode+ "' and b.COVERAGE_STATUS <> 'UI' and b.PANCH_CODE not in (select hab_code from RWS_HAB_SUPPLY_STATUS_TBL))+(select count(b.panch_code) from RWS_COMPLETE_HAB_DYNA_VIEW b,RWS_HAB_SUPPLY_STATUS_TBL c where b.panch_code=c.hab_code and c.UPDATE_DATE is null  and substr(b.panch_code,1,2)='"+dcode+"' and  substr(b.panch_code,6,2)='"+mcode+ "' and b.COVERAGE_STATUS <> 'UI' ) from dual";
	 		}	 	 		
	 	//	System.out.println("query-----" + query);
	 		stmt1 = conn.createStatement();
	 		rs1 = stmt1.executeQuery(query);	 		
	 		if(rs1.next()) {
	 			notUpdateCov=rs1.getInt(1);
	 		}
	 		stmt1.close();
	 		rs1.close();
	 %>
	 		<td class="<%=style %>" style="text-align: right;"><a href="#"
				onclick="viewWorks('./rws_habitation_status_drill_rpt.jsp?status=Total&dcode=<%=dcode %>&dname=<%=dname %>&mcode=<%=mcode%>&mname=<%=mname%>')"><%=tot_habs%></a></td>
			<td class="<%=style %>" style="text-align: right;"><a href="#"
				onclick="viewWorks('./rws_habitation_status_drill_rpt.jsp?status=UpdatedHabs&dcode=<%=dcode %>&dname=<%=dname %>&mcode=<%=mcode%>&mname=<%=mname%>')"><%=updated_hab%></a></td>
	 		<td class="<%=style %>" style="text-align: right;"><a href="#"
				onclick="viewWorks('./rws_habitation_status_drill_rpt.jsp?status=NotUpdatedHabs&dcode=<%=dcode %>&dname=<%=dname %>&mcode=<%=mcode%>&mname=<%=mname%>')"><%=notUpdated%></a></td>
			<td class="<%=style %>" style="text-align: right;"><a href="#"
				onclick="viewWorks('./rws_habitation_status_drill_rpt.jsp?status=UpdatedCov&dcode=<%=dcode %>&dname=<%=dname %>&mcode=<%=mcode%>&mname=<%=mname%>')"><%=updated_cov%></a></td>
			<td class="<%=style %>" style="text-align: right;"><a href="#"
				onclick="viewWorks('./rws_habitation_status_drill_rpt.jsp?status=NotUpdatedcov&dcode=<%=dcode %>&dname=<%=dname %>&mcode=<%=mcode%>&mname=<%=mname%>')"><%=notUpdateCov%></a></td>
		</tr>
		<%
		 totalHabs=totalHabs+tot_habs;
		 updatedHabTotal=updatedHabTotal+updated_hab;
		 notUpdatedTotal=notUpdatedTotal+notUpdated;
		 updatedCovTotal=updatedCovTotal+updated_cov;
		 notUpCovTot=notUpCovTot+notUpdateCov;		 
		}
		stmt.close();
		rs.close();
		%>
		<tr>
			<td class="gridhdbg" style="text-align: right;" colspan=2>Total:</td>
			<td class="gridhdbg" style="text-align: right;"><%=totalHabs %></td>
			<td class="gridhdbg" style="text-align: right;"><%=updatedHabTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=notUpdatedTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=updatedCovTotal %></td>
			<td class="gridhdbg" style="text-align: right;"><%=notUpCovTot %></td>

		</tr>
		<%}
		catch(Exception e)
		{
		e.printStackTrace();
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
		} %>
		</table>
		<!-- <table align="center">
		<tr>
			<td>
			<font color="green" size="2">Note:</font>			
			<font color="red" size="1"> If Coverage Satus Automation is updated then both Hab Status and Coverage Status are Updated.</font>
			</td>
		</tr>		
		</table> -->
</form>

</td>
</tr>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/reports/connClose.jsp"%>
<%}finally{}%>
</span>
