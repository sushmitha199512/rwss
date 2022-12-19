<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html:html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
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






<%
 String dcode=request.getParameter("dcode");
String dname=request.getParameter("dname");
 String programmeCode=request.getParameter("programmeCode");
String programmeName=request.getParameter("programmeName");
String subprogrammeCode=request.getParameter("subprogrammeCode");
String subprogrammeName=request.getParameter("subprogrammeName");
String mode=request.getParameter("mode");
String mode1=request.getParameter("mode1");
String work_id=request.getParameter("workid");
String yearStart=request.getParameter("yearStart");
String yearEnd=request.getParameter("yearEnd");
int yearStart1=Integer.parseInt(yearStart); 
int yearEnd1=Integer.parseInt(yearEnd);

String sub = "ALL";
if(request.getParameter("sub") !=null)
    sub = (String) request.getParameter("sub");

int count=1;
int styleCount=0;
String style="";
String query = "";

 %>


<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
			<a href="#" onClick="window.close();">Close</a>

  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Work Progress Detailed Report for &nbsp;<%=yearStart %>-<%=yearEnd %> and  Programme:&nbsp;<%=programmeName %> </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<%if(mode.equals("cWorks") || mode.equals("tWorks") || mode.equals("fWorks")) {%>
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>WorkId</b></td>
<td class=gridhdbg ><b>Work Name </b></td>
<td class=gridhdbg ><b>Sanction Date </b></td>
<td class=gridhdbg ><b>Est. Cost </b></td>
<td class=gridhdbg ><b>Probable Date of Completion </b></td>
<td class=gridhdbg ><b>Work Completion Date </b></td>
<td class=gridhdbg ><b>No. of Habs </b></td>
<td class=gridhdbg ><b>Image1 </b></td>
<td class=gridhdbg ><b>Image2</b></td>


  </tr>


	<%
	Statement statement=null;
	ResultSet resultSet=null;
	try{
		if(mode.equals("tWorks")){
			query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--') from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null  and a.programme_code in ("+programmeCode+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
			query += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
			if(subprogrammeCode!=null){
				query += " and a.subprogramme_code='"+subprogrammeCode+"'";
			}
			if(dcode!=null){
				query += " and substr(a.work_id,5,2)='"+dcode+"'";
			}
		}
		
		else if(mode.equals("cWorks")){
			query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--'),to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null "
					+ "  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("+programmeCode+") and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null and b.DATE_OF_COMPLETION between '01-APR-"+ yearStart+"' and '31-MAR-"+ yearEnd+"' and b.DATE_OF_COMPLETION is not null ";
			if(subprogrammeCode!=null){
				query += " and a.subprogramme_code='"+subprogrammeCode+"'";
			}
			if(dcode!=null){
				query += " and substr(a.work_id,5,2)='"+dcode+"'";
			}
		}
		else{
			query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--') from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_programme_tbl p  where WORK_CANCEL_DT is null "
					+ " and SUBSTR(a.work_id,7,2) not in ('11','12') and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.PROGRAMME_CODE=p.PROGRAMME_CODE  and a.programme_code in ("
					+ programmeCode
					+ ") and b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION between '01-APR-"
					+ (yearStart1 - 1)
					+ "' and '31-MAR-"
					+ (yearEnd1 - 1)
					+ "'  and b.DT_FIN_COMPLETION is null";
			query += " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
				if(subprogrammeCode!=null){
					query += " and a.subprogramme_code='"+subprogrammeCode+"'";
				}
				if(dcode!=null){
					query += " and substr(a.work_id,5,2)='"+dcode+"'";
				}
                                            System.out.println("phyCompNotFin DRILL: "+query);
		}
		
                                     if(sub.equals("MVS"))
                                        query+= " and a.TYPE_OF_ASSET='03' ";
                                    else if(sub.equals("SVS"))
                                        query+= " and a.TYPE_OF_ASSET<>'03' ";
                
		System.out.println(query);
		stmt=conn.createStatement();
		rs=stmt.executeQuery(query);
		while(rs.next()){
			
			String compDate="";
			String workCompletion="select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"+rs.getString(2)+"' and DATE_OF_COMPLETION is not null";
			statement=conn.createStatement();
			resultSet=statement.executeQuery(workCompletion);
			if(resultSet.next()){
				compDate=resultSet.getString(1);
			}
			else{
				compDate="--";
			}
			statement.close();
			resultSet.close();
			String noofHabs="";
			String habs="";
			if(mode.equals("tWorks")){
			habs="select count(hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='"+rs.getString(2)+"'";
			}
			else{
				habs="select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"+rs.getString(2)+"'";
			}
			statement=conn.createStatement();
			resultSet=statement.executeQuery(habs);
			if(resultSet.next()){
				noofHabs=resultSet.getString(1);
			}
			else{
				noofHabs="0";
			}
			statement.close();
			resultSet.close();
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		 String typeofasset=rs.getString(2).substring(6,8);
		 
		 if(typeofasset.equals("11")){
			 noofHabs="SCHOOL";
		} 
		 else if(typeofasset.equals("12")){
			 noofHabs="LAB";
		 }
			
		
%>

<tr>
<td class="<%=style %>" style="text-align: right;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=rs.getString(2) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs.getString(4) %></td>
<td class="<%=style %>" style="text-align: right;" align="right"><%=rs.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=compDate %></td>
<%if(mode.equals("tWorks")){ 
	 if(typeofasset.equals("11") || typeofasset.equals("12")){
		 %>	
		 <td class="<%=style %>" style="text-align: left;" align="right"><%=noofHabs %></td> 
	 <%}
	 else{
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=sHabs&mode1=work&workid=<%=rs.getString(2) %>&programmeCode=<%=programmeCode%>&programmeName=<%=programmeName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabs %></a></td>
<%}}
else if(mode.equals("fWorks")){
	%>	
	 <td class="<%=style %>" style="text-align: left;" align="right"><%=noofHabs %></td> 
<%
}
else{
	 if(typeofasset.equals("11") || typeofasset.equals("12")){
		 %>	
		 <td class="<%=style %>" style="text-align: left;" align="right"><%=noofHabs %></td> 
	 <%}
	 else{
	%>
	<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cHabs&mode1=work&workid=<%=rs.getString(2) %>&programmeCode=<%=programmeCode%>&programmeName=<%=programmeName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabs %></a></td>
	<%}
}

String image1 = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID='"+rs.getString(2)+"'";
statement=conn.createStatement();
resultSet=statement.executeQuery(image1);

if (resultSet.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image1')">View</a></td>

<%}
else{%>
<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
<%}
statement.close();
resultSet.close();

String image2 = "select WORK_IMAGE1 from rws_work_image_tbl where WORK_ID='"+rs.getString(2)+"'";
statement=conn.createStatement();
resultSet=statement.executeQuery(image2);

if (resultSet.next()) {
%>
<td class="<%=style %>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image2')">View</a></td>

<%}
else{%>
<td class="<%=style %>" style="text-align: left;" align="right">Image Not Exist</td>
<%}
statement.close();
resultSet.close();

%>


</tr>

	<%
		}
		stmt.close();
		rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
}
else{
	%>
	<tr align=center>
	<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
	<td class=gridhdbg ><b>District</b></td>
	<td class=gridhdbg ><b>Mandal</b></td>
	<td class=gridhdbg ><b>Panchayat</b></td>
	<td class=gridhdbg ><b>Village</b></td>
	<td class=gridhdbg ><b>Habitation Code</b></td>
	<td class=gridhdbg ><b>Habitation Name</b></td>
	
	<td class=gridhdbg ><b>Coverage Status</b></td>
	<td class=gridhdbg ><b>Total Population</b></td>
	</tr>
	<%
	Statement statement=null;
	ResultSet resultSet=null;
	try{
		
		if(mode.equals("sHabs")){
			query = "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
					+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
					+ programmeCode + ")";
			query += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
			if(mode1.equals("work")){
				query+=" and a.work_id='"+work_id+"'";
			}
			if(subprogrammeCode!=null){
				query += " and a.subprogramme_code='"+subprogrammeCode+"'";
			}
			if(dcode!=null){
				query += " and substr(a.work_id,5,2)='"+dcode+"'";
			}
		}
		else{
			query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null  and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
					+ programmeCode
					+ ") and b.DATE_OF_COMPLETION between '01-APR-"+ yearStart+"' and '31-MAR-"+ yearEnd+"' and b.DATE_OF_COMPLETION is not null";
			if(mode1.equals("work")){
				query+=" and a.work_id='"+work_id+"'";
			}
			if(subprogrammeCode!=null){
				query += " and a.subprogramme_code='"+subprogrammeCode+"'";
			}
			if(dcode!=null){
				query += " and substr(a.work_id,5,2)='"+dcode+"'";
			}
		}
		
                                    if(sub.equals("MVS"))
                                        query+= " and a.TYPE_OF_ASSET='03' ";
                                    else if(sub.equals("SVS"))
                                        query+= " and a.TYPE_OF_ASSET<>'03' ";
                
		System.out.println("query---"+query);
		Statement st=conn.createStatement();
		ResultSet rs1=st.executeQuery(query);
		while(rs1.next()){
	
			String hab_code=rs1.getString(1);
			String habDetails="select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),COVERAGE_STATUS from rws_habitation_directory_tbl where hab_code='"+hab_code+"' group by COVERAGE_STATUS";
			statement=conn.createStatement();
			resultSet=statement.executeQuery(habDetails);
			int population=0;
			String covStatus="";
			if(resultSet.next()){
				population=resultSet.getInt(1);
				covStatus=resultSet.getString(2);
			}
			statement.close();
			resultSet.close();
			if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			
			String details="select dname,mname,pname,vname,panch_code,panch_name  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl pr"
							+" where d.dcode=m.dcode and d.dcode=substr(panch_code,1,2) and m.mcode=substr(panch_code,6,2) and d.dcode=p.dcode and m.mcode=p.mcode and p.pcode=substr(panch_code,13,2)"
							+" and d.dcode=v.dcode and m.mcode=v.mcode and p.pcode=v.pcode and v.vcode=substr(panch_code,8,3) and panch_code='"+hab_code+"'";
			statement=conn.createStatement();
			resultSet=statement.executeQuery(details);
		 
		 if(resultSet.next()){
			 
		 
		
			
		
%>

<tr>
<td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(4) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(6) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=covStatus %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=population %></td>
</tr>

	<%}
		
		 else{
			 System.out.println(hab_code);
		 }
		 statement.close();
		 resultSet.close();
		}
		st.close();
		rs1.close();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
}
			%>
</table>

</html:html>
