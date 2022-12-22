<%System.out.println("****************************school get*****************************");%>
<%@page import="nic.watersoft.works.rws_works_WorkStatus_bean"%>
<%@ include file="/reports/conn.jsp"%>

<% 		
int count = 0;
String district=request.getParameter("workId");
System.out.println("Work_id:"+district);
String hab = request.getParameter("habs");
System.out.println("Habs"+hab);

try{
String mandal="",panchayat="",village="";
ArrayList schoolList = new ArrayList();
		Statement stmt1 = null;
		ResultSet rs1 = null;
		stmt = conn.createStatement();
		stmt1 = conn.createStatement();
		String qq = "select * from RWS_SCHOOL_ASSET_LNK_TBL where hab_code in ("
				+ hab.substring(0, hab.length() - 1)
				+ ") and asset_code='"
				+ district + "'";
		System.out.println("qq:" + qq);
		rs1 = stmt1.executeQuery(qq);
		ArrayList c = new ArrayList();
		while (rs1.next()) {
			c.add(rs1.getString(1) + rs1.getString(2) + rs1.getString(3));
		}
		String query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,RAJ.Panch_CODE,raj.panch_name,sm.SCHOOL_CODE,sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME, nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0)  from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code  and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and  substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status<>'UI' and hd.coverage_status is not null";
		if (district != null && !district.equals("")) {
				query += " and substr(raj.panch_code,1,2)='"
						+ district.substring(4, 6) + "' ";
			}
			if (mandal != null && !mandal.equals("")) {
				query += " and substr(raj.panch_code,6,2)='" + mandal + "' ";
			}
			if (panchayat != null && !panchayat.equals("")) {
				query += " and substr(raj.panch_code,13,2)='" + panchayat
						+ "' ";
			}
			if (village != null && !village.equals("")) {
				query += " and substr(raj.panch_code,8,3)='" + village + "' ";
			}
			if (hab != null && !hab.equals("")) {
				query += " and raj.panch_code in ("
						+ hab.substring(0, hab.length() - 1) + ")";
			}
			query += " order by raj.panch_name,sm.school_code ";
			System.out.println("VIEW  Query" + query);
			rs = stmt.executeQuery(query);
			
				while (rs.next()) {
					rws_works_WorkStatus_bean bean = new rws_works_WorkStatus_bean();
					if (c.contains(rs.getString(9) + rs.getString(11)
							+ district)){
						bean.setAlreadyExists("Y");}
					else{
						bean.setAlreadyExists("N");}
					bean.setSchoolHabCode(rs.getString(9) + rs.getString(11));
					bean.setPanchayat(rs.getString(6));
					bean.setVillage(rs.getString(8));
					bean.setHabitation(rs.getString(9));
					bean.setHabName(rs.getString(10));
					bean.setSchoolCode(rs.getString(11));
					System.out.println("School-Name:"+rs.getString(12));
					bean.setSchoolName(rs.getString(12));
					bean.setCategory(rs.getString(13));
					bean.setClassification(rs.getString(14));
					bean.setTotStudents(rs.getString(15));
					schoolList.add(bean);
				}
//
if(schoolList!=null){
System.out.println("ssssss:"+schoolList.size());
	%>
<tr>
	<td colspan="2" align="center"><b><font size="2" face="verdana"
		color="blue"> <u>Schools List for the Above Selected Habs</u></font><BR>
	<font size="2" face="verdana" color="red"> Note:** Please Select All
	the Schools at Once and Click 'Add the Selected School to this Work'
	button.<BR>
	The Selected Schools Only Linked with this Work. </font></b></td>
</tr>

<tr>
	<td colspan="2">
	<table border="1" cellspacing="0" cellpadding="0" width="740"
		align="center" bordercolor="#000000" style="border-collapse:collapse"
		bgcolor="#ffffff">
		<TR>
			<td class="btext" nowrap align="center">S.No.</td>
			<td class="btext" nowrap align="center">Select</td>
			<td class="btext" nowrap align="center">Panchayat</td>
			<td class="btext" nowrap align="center">Village</td>
			<td class="btext" nowrap align="center">Habitation</td>
			<td class="btext" nowrap align="center">Habitation Name</td>
			<td class="btext" nowrap align="center">School Code</td>
			<td class="btext" nowrap align="center">School Name</td>
			<td class="btext" nowrap align="center">Category</td>
			<td class="btext" nowrap align="center">Classification</td>
			<td class="btext" nowrap align="center">Total Students1</td>
		</TR>
		<%
for(int i=0;i<schoolList.size();i++)
{
	rws_works_WorkStatus_bean obj = (rws_works_WorkStatus_bean)schoolList.get(i);%>
		<tr onclick="toggleRowColor(this)">
			<td class="bwborder" align="center"><%= ++count %></td>
			<TD class="bwborder" align="center"><%if(obj.getAlreadyExists()!=null && obj.getAlreadyExists().equals("Y")){%>
			<input type="checkbox" name="school"
				value="<%=obj.getSchoolHabCode()%>" checked="true" /> <%}else{%> <input
				type="checkbox" name="school" value="<%=obj.getSchoolHabCode()%>" />
			<%}%></TD>

			<td class="bwborder" align="left" nowrap><%=obj.getPanchayat()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getVillage()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getHabitation()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getHabName()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getSchoolCode()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getSchoolName()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getCategory()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getClassification()%></td>
			<td class="bwborder" align="left" nowrap><%=obj.getTotStudents()%></td>
		</tr>
		<%}%>
	</table>
	</td>
</tr>
<%} else {%>
<tr onclick="toggleRowColor(this)">
	<td>No Schools Found</td>
</tr>
<%} %>
<input type="hidden" name="resultCount" value="<%=--count%>">
<% }catch(Exception e){
e.printStackTrace();
}
%>
