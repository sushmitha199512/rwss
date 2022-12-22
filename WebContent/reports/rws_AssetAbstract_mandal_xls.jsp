<%@ page contentType = "application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>
<%

String rDistrict=null,rDistrictName=null,yrcreation=null,yrcreation1=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null;
Statement stmt1 = null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null;
// // System.out.println("gdfhdsgfhjdhd");
rDistrict =request.getParameter("rDistrict");
yrcreation=request.getParameter("yrcreation");
// // System.out.println("rDistrict:"+rDistrict);
if(yrcreation.equals("00"))
{
	yrcreation1="ALL";
}

rDistrictName=request.getParameter("rDistrictName");
%>
<html>
 
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=10>Asset-Abstract-Report</td>	
		</tr>
		 <tr>	<td class=btext  colspan=10>District: <%=rDistrictName%> &nbsp;&nbsp; Year:<%=yrcreation1%></td>
		</tr>
		  
		<tr align="center" bgcolor="#ffffff">
			<td class=btext >SNO</td>
			<td class=btext >Mandal</td>			
			<td class=btext size=2 align=center>CPWS</td>
			<td class=btext size=2 align=center>PWS</td>
			<td class=btext size=2 align=center>MPWS</td>	
			<td class=btext size=2 align=center>DIRECTING PUMPING</td>
			<td class=btext size=2 align=center>HAND PUMPS</td>
			<td class=btext size=2 align=center>OPEN WELLS</td>
			<td class=btext size=2 align=center>PONDS</td>
			<td class=btext size=2 align=center>SHALLOW HANDPUMPS</td>
			</tr>
			
	     <%
	try{
		 
		 int sno=1;
		 int coltot1=0,coltot2=0,coltot3=0,coltot4=0,coltot5=0,coltot6=0,coltot7=0,coltot8=0;
		 String pwsqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='01' "; 
		 if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			pwsqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			pwsqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
		pwsqry+=" group by mcode,mname order by  mcode";
		
		
		 /* String pwsqry="select count(distinct a.asset_code),dcode,dname from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' "; 
		 if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			pwsqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			pwsqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
		pwsqry+=" group by dcode,dname order by  dcode";  */
		
		
		
		//////////modified on 24/01/2015 for mpws //////
		
		
		
	    String  mpwsqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='02' ";
		if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			mpwsqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			mpwsqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			mpwsqry+=" group by mcode,mname order by  mcode";
			
			System.out.println("mpwsqry"+mpwsqry); 
//		SELECT COUNT(*),SUBSTR(SCHEME_CODE,6,2),h.mname  FROM RWS_COMPLETE_HAB_VIEW H , RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND M.HAB_CODE=H.PANCH_CODE  and SUBSTR(SCHEME_CODE,1,2 )=06 group by SUBSTR(SCHEME_CODE,6,2 ),h.mname order by h.mname 
		
		/*  
		 String  mpwsqry="SELECT COUNT(*),SUBSTR(SCHEME_CODE,6,2 ),h.mname  FROM RWS_COMPLETE_HAB_VIEW H , RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND (SUBSTR(SCHEME_CODE,17,3) LIKE '40%' or SUBSTR(SCHEME_CODE,17,3) LIKE '41%' or SUBSTR(SCHEME_CODE,17,3) LIKE '42%' or SUBSTR(SCHEME_CODE,17,3) LIKE '43%' or SUBSTR(SCHEME_CODE,17,3) LIKE '44%')  AND M.TYPE_OF_ASSET_CODE='02' AND M.HAB_CODE=H.PANCH_CODE ";
		if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			mpwsqry+=" and SUBSTR(SCHEME_CODE,1,2 )="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			mpwsqry+="  and to_char(M.DATE_CREATION,'YYYY')="+yrcreation;
			mpwsqry+=" group by SUBSTR(SCHEME_CODE,6,2 ),h.mname order by h.mname "; 

			
			System.out.println("mpwsqry"+mpwsqry); */
		 
		/////end on 24/01/2015//////////
			 
		
	    
		String  cpwsqry="select count(distinct a.asset_code),substr(a.hab_code,6,2) from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='03' ";
	    if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			cpwsqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			cpwsqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			cpwsqry+=" group by substr(a.hab_code,6,2) order by  substr(a.hab_code,6,2)";
			
		System.out.println("cpwsqry"+cpwsqry);
		String hpqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='04' ";
	    if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			hpqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			hpqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			hpqry+=" group by mcode,mname order by  mcode";
	    
		String shpqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='05' ";
		 if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			shpqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			shpqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			shpqry+=" group by mcode,mname order by  mcode";

	   String openqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='06' ";
		 if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			openqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			openqry+="  and to_char(M.DATE_CREATION,'YYYY')="+yrcreation;
			openqry+=" group by mcode,mname order by  mcode";
	  
	   String pondqry=" select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='07' ";
	    if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			pondqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			pondqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			pondqry+=" group by mcode,mname order by  mcode";

			
			///////////modified on 24012015 for dp by anupama/////
			
			
			
			
		String dpqry="select count(distinct a.asset_code),mcode,mname from rws_asset_mast_tbl a,rws_complete_hab_View c where a.hab_code=c.panch_code and type_of_asset_code='09' ";
	    if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			dpqry+=" and dcode="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			dpqry+="  and to_char(a.DATE_CREATION,'YYYY')="+yrcreation;
			dpqry+=" group by mcode,mname order by  mcode";
			
	 /*  String dpqry="SELECT COUNT(*),SUBSTR(SCHEME_CODE,6,2),h.mname  FROM RWS_COMPLETE_HAB_VIEW H , RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND (SUBSTR(SCHEME_CODE,17,3) LIKE '45%' or SUBSTR(SCHEME_CODE,17,3) LIKE '46%' or SUBSTR(SCHEME_CODE,17,3) LIKE '47%' or SUBSTR(SCHEME_CODE,17,3) LIKE '48%' or SUBSTR(SCHEME_CODE,17,3) LIKE '49%')  AND M.TYPE_OF_ASSET_CODE='09' AND M.HAB_CODE=H.PANCH_CODE";
	    if(rDistrict!=null && !rDistrict.equals("") && !rDistrict.equals("00"))
			dpqry+=" and SUBSTR(SCHEME_CODE,1,2 )="+rDistrict;
		if(yrcreation!=null && !yrcreation.equals("") &&  !yrcreation.equals("00"))
			dpqry+="  and to_char(M.DATE_CREATION,'YYYY')="+yrcreation;
			dpqry+=" group by SUBSTR(SCHEME_CODE,6,2 ),h.mname order by h.mname ";  */
			
			
			//System.out.println("dpqry"+dpqry);
	    
			
			
			///////end on 24012015 by anupama
		stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("pwsqry:"+pwsqry);
	    rs=stmt.executeQuery(pwsqry);

		stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("mpws:"+mpwsqry);
	    rs1=stmt1.executeQuery(mpwsqry);

		stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		System.out.println("cpws:"+cpwsqry);
	    rs2=stmt2.executeQuery(cpwsqry);
		
		stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("hp:"+hpqry);
	    rs3=stmt3.executeQuery(hpqry);

		stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("shp:"+shpqry);
	    rs4=stmt4.executeQuery(shpqry);

		stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("open:"+openqry);
	    rs5=stmt5.executeQuery(openqry);

		stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("pond:"+pondqry);
	    rs6=stmt6.executeQuery(pondqry);

		stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		// // System.out.println("dp:"+dpqry);
	    rs7=stmt7.executeQuery(dpqry);

		String qry="select mcode,mname,dcode from rws_mandal_tbl  where  dcode='"+rDistrict+"'  order by mcode" ;
		// // System.out.println("mandal:"+qry);
		stmt8=conn.createStatement();
		rs8=stmt8.executeQuery(qry);
		// int rsdata=0, rsdata1=0,rsdata2=0, rsdata3=0,rsdata4=0, rsdata5=0,rsdata6=0, rsdata7=0;
	    //int  rdata=0, rdata1=0, rdata2=0, rdata3=0,rdata4=0, rdata5=0, rdata6=0, rdata7=0;
		
		while(rs8.next())
		{
			%>
			<tr>
				<td class="rptValue" align=left><%=sno++%></td>
			<%
			if(rs2.next())//cpws
			{
			%>
				<td class="rptValue" align=left><a href="rws_AssetAbstract_hab_rpt.jsp?dcode=<%=rs8.getString(3)%>&mcode=<%=rs8.getString(1)%>&yrcreation=<%=yrcreation%>&mname=<%=rs8.getString(2)%>&dname=<%=rDistrictName%>"><%=rs8.getString(2)%></a></td>
				<%if (rs8.getInt(1)==rs2.getInt(2)) {
						coltot1+=rs2.getInt(1);
				%>
				<td class="rptValue" align=left><%=rs2.getInt(1)%></td>
			 <%} else
					{
					rs2.previous();
				%>
				 <td class="rptValue" align=left>0</td>
				<%
					}
			}
			else
			{
		%>
				<td class="rptValue" align=left><a href="rws_AssetAbstract_hab_rpt.jsp?dcode=<%=rs8.getString(3)%>&mcode=<%=rs8.getString(1)%>&yrcreation=<%=yrcreation%>&mname=<%=rs8.getString(2)%>"><%=rs8.getString(2)%></a></td>
				<td class="rptValue" align=left>0</td>
			<%
			}

			if(rs.next())//pws
			{
			%>
				<%if (rs8.getInt(1)==rs.getInt(2)) {
						coltot2+=rs.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs.getInt(1)%></td>
			 <%} else
					{
				rs.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}
			if(rs1.next())//mpws
			{
			%>
				<%if (rs8.getInt(1)==rs1.getInt(2)) {
						coltot3+=rs1.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs1.getInt(1)%></td>
			 <%} else
					{
				rs1.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}
			if(rs7.next())//Dp
			{
			%>
				<%if (rs8.getInt(1)==rs7.getInt(2)) {
						coltot4+=rs7.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs7.getInt(1)%></td>
			 <%} else
					{
				rs7.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}

			if(rs3.next())//hp
			{
			%>
				<%if (rs8.getInt(1)==rs3.getInt(2)) {
						coltot5+=rs3.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs3.getInt(1)%></td>
			 <%} else
					{
				rs3.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}

			if(rs5.next())//open wells
			{
			%>
				<%if (rs8.getInt(1)==rs5.getInt(2)) {
						coltot6+=rs5.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs5.getInt(1)%></td>
			 <%} else
					{
				rs5.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}

			if(rs6.next())//ponds
			{
			%>
				<%if (rs8.getInt(1)==rs6.getInt(2)) {
						coltot7+=rs6.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs6.getInt(1)%></td>
			 <%} else
					{
				rs6.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}

			if(rs4.next())//Shp
			{
			%>
				<%if (rs8.getInt(1)==rs4.getInt(2)) {
						coltot8+=rs4.getInt(1);
				%>
				<td class="rptValue" align="right"><%=rs4.getInt(1)%></td>
			 <%} else
					{
				rs4.previous();
				%>
				 <td class="rptValue" align="right">0</td>
				<%
					}
			}
			else
			{
			%>
				<td class="rptValue" align="right">0</td>
			<%
			}
		}
				%>
	 <tr>
		<td class=btext colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total</td>
					<td class=rptValue align="right"><%=coltot1%></td>
					<td class=rptValue align="right"><%=coltot2%></td>
					<td class=rptValue align="right"><%=coltot3%></td>
					<td class=rptValue align="right"><%=coltot4%></td>
					<td class=rptValue align="right"><%=coltot5%></td>
					<td class=rptValue align="right"><%=coltot6%></td>
					<td class=rptValue align="right"><%=coltot7%></td>
					<td class=rptValue align="right"><%=coltot8%></td>
		       </tr>
		
		 <%}catch(Exception e)
	 {
		 // // System.out.println(" Exception in asset abstract:"+e);
	 }
	 finally
	 {
		 if(rs!=null) rs.close(); if(rs1!=null) rs1.close();
		 if(rs2!=null) rs2.close(); if(rs3!=null) rs3.close();
		 if(rs4!=null) rs4.close(); if(rs5!=null) rs5.close();
		 if(rs6!=null) rs6.close(); if(rs7!=null) rs7.close();
		 if(rs8!=null) rs8.close();
		 if(stmt!=null) stmt.close(); if(stmt1!=null) stmt1.close();
		 if(stmt2!=null) stmt2.close(); if(stmt3!=null) stmt3.close();
		 if(stmt4!=null) stmt4.close(); if(stmt5!=null) stmt5.close();	
		 if(stmt6!=null) stmt6.close(); if(stmt7!=null) stmt7.close();
		 if(stmt8!=null) stmt8.close();


	 }
 %>
		</table>
		</body>
		</html>
		