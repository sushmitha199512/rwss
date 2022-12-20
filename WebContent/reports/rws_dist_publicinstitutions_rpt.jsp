<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
 <%@ page import="nic.watersoft.reports.rws_hab_publicins_bean"%>
 

<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
function Print()
{
 alert("Print this page");
 window.print();
    
}
 
function closewin()
{
window.close();
}

</script>
<html:html>
<HEAD>
<TITLE>DISTRICTS</TITLE>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
.mystylere
{
	border-width:1;
	color:red;
	font-family:verdana;
	font-size:8pt;
}
.mystylergr
{
	border-width:1;
	color:green;
	font-family:verdana;
	font-size:8pt;
}

.mystyleranc
{
	border-width:1;
	color:Rose;
	font-family:verdana;
	font-size:8pt;
}
</style>
</HEAD>
<BODY>
<table  width="100%" >

<tr>
<td align="right">
<a href="./rws_login_frm.jsp">HOME</a>
</td></tr></table>
 <logic:present name="VIEW">
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
PUBLIC INSTITUTIONS REPORT  
</td>
</tr>
<tr>
<td><%int count=0; %>
<%try{ %>
 <logic:present name="PublicInstitutions">
 <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"	bordercolor="#000000" style="border-collapse:collapse">
	<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH colspan="2"> </TH>
						<TH colspan="2">Total
					 	<TH colspan="2">Primary Schools</TH>
				 		<TH colspan="2">Temples</TH>
				 		<TH colspan="2">Primary Health Centres</TH>
				 		<TH colspan="2">Anganwadi Centres </TH>
				 		<TH colspan="2">Librarys </TH>
				 		<TH colspan="2">Community Halls</TH>
				 		<TH colspan="2">U.P Schools</TH>
				 		<TH colspan="2">High Schools</TH>
				 		<TH colspan="2">B.C Hostels</TH>
				 		<TH colspan="2">S.C Hostels</TH>
				 		<TH colspan="2">S.T Hostels</TH>
				   
	<THEAD align="left"  bgcolor="#8A9FDD" class="textborder">
				 		<th>S.NO</th>
				 		<th >District Name</th>
				 		<th  >Total No.</th>
				 		<th>Total Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		</TH>
 					</THEAD>
 					 	   	 
 					<logic:iterate id="instittutions" name="PublicInstitutions" scope="request">
						<%count++; %>
							<TR>
							    <td class="mystyle1"><%=count %></td>
							    <td class="mystyle1"><font color="#6A829E"><bean:write name="instittutions" property="disName"/></font></td>
							    <td class="mystylere"><bean:write  name="instittutions" property="instNum"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="isnCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions" property="primarySchool"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="primaryCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="temples"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="templesCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="phCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="phCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="anganwadiCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="angCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="lib"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="libCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="commHall"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="commCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="upSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="upschCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="higSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="highCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="bcHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="bcHosCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions" property="scHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="scCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions" property="stHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="stCov"/></td> 
	                     	</TR>
					</logic:iterate>
				
					<logic:iterate id="instittutions1" name="PublicInstitutions1" scope="request">  	
					<TR>
								<td colspan=2>TOTAL</td>
							    <td class="mystylere"><bean:write  name="instittutions1" property="totno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="totcov1"/></td> 
								<td class="mystylere"><bean:write  name="instittutions1" property="pno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="pcov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="tno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="tcov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="phno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="phcov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="ano1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="acov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="libno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="libcov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="cno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="ccov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="upno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="upcov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="hsno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="hscov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="bcno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="bccov1"/></td>
								<td class="mystylere"><bean:write  name="instittutions1" property="scno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="sccov1"/></td> 
								<td class="mystylere"><bean:write  name="instittutions1" property="stno1"/></td>
								<td class="mystylergr"><bean:write name="instittutions1" property="stcov1"/></td> 
	                     	</TR>
 				</logic:iterate> 
					 
</logic:present>

<%}catch(Exception e){} %>	
<%try{ %>				
<logic:present name="PublicInstitutionsMan">
					<TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH colspan="3"> </TH>
						<TH colspan="2"	     >Total
					 	<TH colspan="2"	     >Primary Schools</TH>
				 		<TH colspan="2"	     >Temples</TH>
				 		<TH colspan="2"	     >Primary Health Centres</TH>
				 		<TH colspan="2"		 >Anganwadi Centres </TH>
				 		<TH colspan="2" 	 >Librarys </TH>
				 		<TH colspan="2"		 >Community Halls</TH>
				 		<TH colspan="2"	     >U.P Schools</TH>
				 		<TH colspan="2"		 >High Schools</TH>
				 		<TH colspan="2"	     >B.C Hostels</TH>
				 		<TH colspan="2"		 >S.C Hostels</TH>
				 		<TH colspan="2"	     >S.T Hostels</TH>
				 		<THEAD align="left"  bgcolor="#8A9FDD" class="textborder">
				 		<th>S.NO</th>
				 		<th>District name</th>
				 	 	<th>Mandal Name</th>
				 		<th>Total No.</th>
				 		<th>Total Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		</TH>
 					</THEAD>
					<%  count=0; %>
					
                      <logic:iterate id="instittutions" name="PublicInstitutionsMan"  scope="request">
						<%count++; %>
							<TR>
							    <td class="mystyle1"><%=count %></td>
							    <td class="mystylere"><bean:write name="instittutions" property="disName"/> </td> 
							    <td class="mystylere"><a href="PublicInst.do?mode=view&dcode=<%=((rws_hab_publicins_bean)instittutions).getDisCode()%>&mcode=<%=((rws_hab_publicins_bean)instittutions).getManCode()%>&vcode=&hcode=&pcode=">
							    <bean:write name="instittutions" property="manName"/></a></td>
							    <td class="mystylere"><bean:write  name="instittutions"  property="instNum"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="isnCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="primarySchool"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="primaryCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="temples"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="templesCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="phCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="phCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="anganwadiCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="angCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="lib"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="libCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="commHall"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="commCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="upSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="upschCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="higSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="highCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="bcHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="bcHosCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="scHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="scCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="stHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="stCov"/></td> 
	                     <!-- <td class="mystyle1">
	                     <a href="/pred/images/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>.JPG">
	                     <bean:write name="instittutions" property="habName"/></a></td>-->
	 							
	 						</TR>
					</logic:iterate>
</logic:present>
<%}catch(Exception e){} %>
<%try{ %>
<logic:present name="PublicInstitutionsPan">
	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%" bordercolor="#000000" style="border-collapse:collapse">
	 <THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH colspan="4"> </TH>
						<TH colspan="2"	     >Total
					 	<TH colspan="2"	     >Primary Schools</TH>
				 		<TH colspan="2"	     >Temples</TH>
				 		<TH colspan="2"	     >Primary Health Centres</TH>
				 		<TH colspan="2"		 >Anganwadi Centres </TH>
				 		<TH colspan="2" 	 >Librarys </TH>
				 		<TH colspan="2"		 >Community Halls</TH>
				 		<TH colspan="2"	     >U.P Schools</TH>
				 		<TH colspan="2"		 >High Schools</TH>
				 		<TH colspan="2"	     >B.C Hostels</TH>
				 		<TH colspan="2"		 >S.C Hostels</TH>
				 		<TH colspan="2"	     >S.T Hostels</TH>
				 		<THEAD align="left"  bgcolor="#8A9FDD" class="textborder">
				 		<th>S.NO</th>
				 		<th>District name</th>
				 	 	<th>Mandal Name</th>
				 	 	<th>Panchayat Name</th>
				 		<th>Total No.</th>
				 		<th>Total Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		</TH>
 					</THEAD>
					<%  count=0; %>
					
                      <logic:iterate id="instittutions" name="PublicInstitutionsPan" scope="request">
						<%count++; %>
							<TR>
							    <td class="mystyle1"><%=count %></td>
							    <td class="mystylere"  ><bean:write name="instittutions" property="disName"/> </td>
							     <td class="mystylere"  ><bean:write name="instittutions" property="manName"/> </td> 
							    <td class="mystylere"  ><a href="PublicInst.do?mode=view&dcode=<%=((rws_hab_publicins_bean)instittutions).getDisCode()%>&mcode=<%=((rws_hab_publicins_bean)instittutions).getManCode()%>&pcode=<%=((rws_hab_publicins_bean)instittutions).getPCode()%>&vcode=&hcode= ">
							    <bean:write name="instittutions" property="PName"/></a></td>
							    <td class="mystylere"><bean:write  name="instittutions"  property="instNum"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="isnCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="primarySchool"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="primaryCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="temples"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="templesCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="phCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="phCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="anganwadiCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="angCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="lib"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="libCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="commHall"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="commCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="upSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="upschCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="higSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="highCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="bcHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="bcHosCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="scHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="scCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="stHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="stCov"/></td> 
	                     <!-- <td class="mystyle1">
	                     <a href="/pred/images/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>.JPG">
	                     <bean:write name="instittutions" property="habName"/></a></td>-->
	 							
	 						</TR>
					</logic:iterate>
</logic:present>
<%}catch(Exception e){} %>
<%try{ %>
<logic:present name="PublicInstitutionsVil">
	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%" bordercolor="#000000" style="border-collapse:collapse">
    	<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH colspan="4"> </TH>
						<TH colspan="2"	     >Total
					 	<TH colspan="2"	     >Primary Schools</TH>
				 		<TH colspan="2"	     >Temples</TH>
				 		<TH colspan="2"	     >Primary Health Centres</TH>
				 		<TH colspan="2"		 >Anganwadi Centres </TH>
				 		<TH colspan="2" 	 >Librarys </TH>
				 		<TH colspan="2"		 >Community Halls</TH>
				 		<TH colspan="2"	     >U.P Schools</TH>
				 		<TH colspan="2"		 >High Schools</TH>
				 		<TH colspan="2"	     >B.C Hostels</TH>
				 		<TH colspan="2"		 >S.C Hostels</TH>
				 		<TH colspan="2"	     >S.T Hostels</TH>
				 		<THEAD align="left"  bgcolor="#8A9FDD" class="textborder">
				 		<th>S.NO</th>
				 	  	<th>Mandal Name</th>
				 	 	<th>Panchayat Name</th>
				 	 	<th>Village Name</th>
				 		<th>Total No.</th>
				 		<th>Total Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
		  	 		 </TH>
 					</THEAD>
					<%  count=0; %>
					
                      <logic:iterate id="instittutions" name="PublicInstitutionsVil"  scope="request">
						<%count++; %>
							<TR>
							    <td class="mystyle1"><%=count %></td>
							    <td class="mystylere"  ><bean:write name="instittutions" property="manName"/> </td> 
							    <td class="mystylere"  ><bean:write name="instittutions" property="PName"/></a></td>
                                <td class="mystylere"  ><a href="PublicInst.do?mode=view&dcode=<%=((rws_hab_publicins_bean)instittutions).getDisCode()%>&mcode=<%=((rws_hab_publicins_bean)instittutions).getManCode()%>&pcode=<%=((rws_hab_publicins_bean)instittutions).getPCode()%>&vcode=<%=((rws_hab_publicins_bean)instittutions).getVilCode()%>&hcode= ">
							    <bean:write name="instittutions" property="vilName"/></a></td>
							    <td class="mystylere"><bean:write  name="instittutions"  property="instNum"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="isnCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="primarySchool"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="primaryCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="temples"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="templesCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="phCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="phCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="anganwadiCentre"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="angCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="lib"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="libCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="commHall"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="commCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="upSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="upschCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="higSch"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="highCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="bcHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="bcHosCov"/></td>
								<td class="mystylere"><bean:write  name="instittutions"  property="scHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="scCov"/></td> 
								<td class="mystylere"><bean:write  name="instittutions"  property="stHos"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="stCov"/></td> 
	                     <!-- <td class="mystyle1">
	                     <a href="/pred/images/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>.JPG">
	                     <bean:write name="instittutions" property="habName"/></a></td>-->
						</TR>
					</logic:iterate>
</logic:present>
<%}catch(Exception e){} %>
<%try{ %>
<logic:present name="PublicInstitutionsHab">
	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%"	bordercolor="#000000" style="border-collapse:collapse">
	<THEAD align="left" bgcolor="#8A9FCD" class="textborder">
						<TH colspan="4"> </TH>
						<TH colspan="2">Total
					 	<TH colspan="2">Primary Schools</TH>
				 		<TH colspan="2">Temples</TH>
				 		<TH colspan="2">Primary Health Centres</TH>
				 		<TH colspan="2">Anganwadi Centres </TH>
				 		<TH colspan="2">Librarys </TH>
				 		<TH colspan="2">Community Halls</TH>
				 		<TH colspan="2">U.P Schools</TH>
				 		<TH colspan="2">High Schools</TH>
				 		<TH colspan="2">B.C Hostels</TH>
				 		<TH colspan="2">S.C Hostels</TH>
				 		<TH colspan="2">S.T Hostels</TH>
				 		<THEAD align="left"  bgcolor="#8A9FDD" class="textborder">
				 		<th>S.NO</th>
				 	  	<th>Panchayat Name</th>
				 	 	<th>Village Name</th>
				 	 	<th>HabName</th>
				 		<th>Total No.</th>
				 		<th>Total Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		<th>No.</th>
				 		<th>Cov</th>
				 		</TH>
 					</THEAD>
					<%  count=0; %>
					
<logic:iterate id="instittutions" name="PublicInstitutionsHab" scope="request">
	<%count++; %>
		<TR>
							    <td class="mystyle1"><%=count %></td>
							    <td class="mystylere"  ><bean:write name="instittutions" property="PName"/></a></td>
							    <td class="mystylere"  ><bean:write name="instittutions" property="vilName"/></a></td>
                                <td class="mystylere"  ><bean:write name="instittutions" property="habName"/></td>
							    <td class="mystylere"><bean:write  name="instittutions"  property="instNum"/></td>
								<td class="mystylergr"><bean:write name="instittutions" property="isnCov"/></td> 
								<td class="mystyleranc"><bean:write  name="instittutions"  property="primarySchool"/></td>
								<td class="mystylergr">
								<a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>01.JPG">
								 
								<bean:write name="instittutions" property="primaryCov"/>
								 </a></td>
								<td class="mystyleranc"><bean:write  name="instittutions"  property="temples"/></td>
								<td class="mystylergr"><a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>02.JPG">
								 
								<bean:write name="instittutions" property="templesCov"/>
								 </a></td>
								<td class="mystyleranc"><bean:write  name="instittutions"  property="phCentre"/></td>
								<td class="mystylergr">
								<a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>03.JPG">
								 
								<bean:write name="instittutions" property="phCov"/>
								 </a></td>
								<td class="mystyleranc"><bean:write  name="instittutions"  property="anganwadiCentre"/> </td>
								<td class="mystylergr">
								<a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>04.JPG">
								 
								<bean:write name="instittutions" property="angCov"/>
								 </a></td>
								<td class="mystyleranc"> 	<bean:write  name="instittutions"  property="lib"/>
								</td> <td class="mystylergr">
								<a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>05.JPG">
								 
								<bean:write name="instittutions" property="libCov"/>
								 </a></td>
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="commHall"/>
								 </td> <td class="mystylergr">
								 <a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>06.JPG">
								 
								 <bean:write name="instittutions" property="commCov"/>
								  </a></td>
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="upSch"/>
								 </td> <td class="mystylergr">
								 <a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>07.JPG">
								 
								 <bean:write name="instittutions" property="upschCov"/>
								 </td>
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="higSch"/>
								 </td> <td class="mystylergr">
								 <a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>08.JPG">
								 
								 <bean:write name="instittutions" property="highCov"/>
								  </a></td>
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="bcHos"/>
								 </td> <td class="mystylergr">
								 <a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>09.JPG">
								 
								 <bean:write name="instittutions" property="bcHosCov"/>
								 </a></td>
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="scHos"/>
							     </td> <td class="mystylergr">
							     <a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>10.JPG">
								 
							     <bean:write name="instittutions" property="scCov"/>
							     </a></td> 
								<td class="mystyleranc"> <bean:write  name="instittutions"  property="stHos"/>
								</td> <td class="mystylergr">
								<a href="/pred/images/public-inst/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>11.JPG">
								 
								<bean:write name="instittutions" property="stCov"/>
								 </a></td> 
	                     <!-- <td class="mystyle1">
	                     <a href="/pred/images/<%=((rws_hab_publicins_bean)instittutions).getHabCode()%>.JPG">
	                     <bean:write name="instittutions" property="habName"/></a></td>-->
	 							
	 						</TR>
					</logic:iterate>
</logic:present>
<%}catch(Exception e){} %>									 
				</TABLE>
				</td>
</tr>
</table>
</logic:present>
<logic:notPresent name="VIEW">
<table border="2" cellspacing="0" cellpadding="0" width="20%"
					bordercolor="#8A9FDD" style="border-collapse:collapse" >
					<tr><td class="mystylere" align="center">NO RECORDS</td></tr></table>
</logic:notPresent>
<table>

</td>
</tr>
</table> 
 
 
 



</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
