<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file = "conn.jsp" %>

<%
         DecimalFormat ndf = new DecimalFormat("##.##");
		 PreparedStatement pstmt1 = null;ResultSet rs1=null,rs3=null,rs4=null;
         Statement stmt1=null,stmt2=null;
		String habTable = (String) session.getAttribute("habTable");
		String dcode = request.getParameter("dcode");
		System.out.println("Dcode" + dcode);
		String type = request.getParameter("type");	
         System.out.print("Type:"+type);
        int length=0;
		ArrayList florideList = new ArrayList((HashSet)session.getAttribute("flist"));
		ArrayList salinityList = new ArrayList((HashSet)session.getAttribute("slist"));
		ArrayList tdsList = new ArrayList((HashSet)session.getAttribute("tdslist"));
		ArrayList nitrateList =new ArrayList((HashSet) session.getAttribute("nitrateList"));
		ArrayList ironList = new ArrayList((HashSet)session.getAttribute("ironList"));
		ArrayList arscList=new ArrayList((HashSet)session.getAttribute("arsenicList"));

		if(type.equals("1")){
				length=florideList.size();
		}else if(type.equals("2")){
				length=salinityList.size();
		}else if(type.equals("3")){
				length=tdsList.size();
		}else if(type.equals("4")){
				length=nitrateList.size();
		}else if(type.equals("5")){
				length=ironList.size();
		}
       else if(type.equals("6")){
				length=arscList.size();
		}
	%>



<html:html>
<HEAD>
</HEAD>

<BODY>

<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext>Sl.No</td>
        <td class=btext>District</td>
       	<td class=btext>Mandal</td>
        <td class=btext>Panchayath</td>
        <td class=btext>Habitation Name</td>
		<td class=btext>Habitation ID</td>
		<td class=btext>Contamination Type</td>
		<td class=btext>Contamination Level(PPT)</td>
		<td class=btext>Whether covered under ongoing CPWS scheme (Yes/No)</td>
		<td class=btext>Whether covered under ongoing MVS work (Non CPWS) (Yes/No)</td>
		<td class=btext>Whether covered under Asset CPWS scheme (Yes/No)</td>
		
		<td class=btext>Coverage Status</td>
	
	</tr>


<%
 try{

 stmt1=conn.createStatement();
 stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
 String cpws="",mvs="";
   int i=0;int sno=1;
			pstmt1=conn.prepareStatement("select a.hab_code,b.PANCH_NAME,a.coverage_status,c.mname,d.dname,e.pname from "+habTable+" a ,RWS_PANCHAYAT_RAJ_TBL b,rws_mandal_tbl c,rws_district_tbl d ,RWS_PANCHAYAT_TBL e where d.dcode=? and e.dcode=? and e.mcode=substr(a.hab_code,6,2) and e.pcode=substr(a.hab_code,13,2) and  a.hab_code=? and substr(a.hab_code,1,2)=? and a.hab_code=b.panch_code and substr(a.hab_code,6,2)=c.mcode and c.dcode=?");
			String str="",conType="";
    if(length!=0){
   for(i=0;i<length;i++){
			if(type.equals("1")){
					 str=(String)florideList.get(i);
					conType="FLOURIDE";
 
			}else if(type.equals("2")){
      					conType="SALINITY";
					 str=(String)salinityList.get(i);
			}else if(type.equals("3")){
				conType="TDS";
					 str=(String)tdsList.get(i);
			}else if(type.equals("4")){
									conType="NITRATE";
					 str=(String)nitrateList.get(i);
			}else if(type.equals("5")){
					conType="IRON";
					 str=(String)ironList.get(i);
			}
				else if(type.equals("6")){
					conType="ARSENIC";
					 str=(String)arscList.get(i);
			}
				String rec[]=str.split("@");
						pstmt1.setString(1,rec[0]);
						pstmt1.setString(2,rec[0]);
						pstmt1.setString(3,rec[1]);
						pstmt1.setString(4,rec[0]);
						pstmt1.setString(5,rec[0]);
			rs1=pstmt1.executeQuery();
		while(rs1.next()){
cpws="";mvs="";String acpws="";
          String q1="SELECT count(*)  FROM rws_admn_hab_lnk_tbl a , RWS_WORK_ADMN_TBL b ,rws_work_completion_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and hab_code='"+rs1.getString(1)+"' and c.DATE_OF_COMPLETION is null and category_code='01' and b.work_cancel_dt is null";
         rs3=stmt1.executeQuery(q1);
         if(rs3.next()){
        		if(Integer.parseInt(rs3.getString(1))>0)
					{
        cpws="YES";
				}else {  cpws="NO"; }
		  		}
        String q2="SELECT NO_OF_HABS FROM rws_admn_hab_lnk_tbl a , RWS_WORK_ADMN_TBL b ,rws_work_completion_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and hab_code='"+rs1.getString(1)+"' and c.DATE_OF_COMPLETION is null and category_code<>'01' and b.work_cancel_dt is null";
        rs4=stmt2.executeQuery(q2);
        if(rs4.next()){
			if(Integer.parseInt(rs4.getString(1))>1)
					{
        mvs="YES";
				}else {  mvs="NO"; }
		}else{          mvs="NO"; }

        String q3="SELECT count(*) FROM rws_asset_mast_tbl b where b.hab_code='"+rs1.getString(1)+"' and TYPE_OF_ASSET_CODE='03'";
        ResultSet rs5=stmt3.executeQuery(q3);
        if(rs5.next()){
			if(Integer.parseInt(rs5.getString(1))>0)
					{
        acpws="YES";
				}else {  acpws="NO"; }
		}



%>
			<tr><td class=btext><%=sno++ %></td><td class=rptvalue><%=rs1.getString(5) %></td><td class=rptvalue><%=rs1.getString(4) %></td><td class=rptvalue><%=rs1.getString(6) %></td><td class=rptvalue><%=rs1.getString(2) %></td><td class=rptvalue><%=rs1.getString(1) %></td><td class=rptvalue ALIGN="CENTER"><%=conType %></td><td class=rptvalue ALIGN="CENTER"><%=ndf.format(Double.parseDouble(rec[2])) %></td><td class=rptvalue><%=cpws %></td><td class=rptvalue><%=mvs %></td><td class=rptvalue><%=acpws %></td><td class=rptvalue><%=rs1.getString(3) %></td></tr>
  <%	
}
}}else {
   %>
  <tr><td colspan=4 class=btext align=center>No Records</td></tr>
<%
}	

	}catch(Exception e){
			e.printStackTrace();
	}

 %>

</BODY>
</html:html>
