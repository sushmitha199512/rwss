<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="";
    
String dCode,pCode,mCode,Pname=null;	 
String district=request.getParameter("district");
//System.out.println("district++++++++++++++"+district);
String mandal=request.getParameter("mandal");
//System.out.println("mandal++++++++++++++"+mandal);
String panchayat=request.getParameter("panchayat");
//System.out.println("panchayat++++++++++++++"+panchayat);
	
     
String dName=String.valueOf(session.getAttribute("dName"));
String mName=String.valueOf(session.getAttribute("mName"));
 
 if(district==null && mandal==null && panchayat==null)
 {
	 //dCode=String.valueOf(session.getAttribute("dcode"));
	// mCode=String.valueOf(session.getAttribute("mCode"));
   dCode=request.getParameter("dcode");
   //System.out.println("dCode+++++++++++++++++"+dCode);
   mCode=request.getParameter("mcode");
   //System.out.println("mCode+++++++++++++++++"+mCode);
   pCode=request.getParameter("pcode");
    session.setAttribute("pCode",pCode); 
	Pname=request.getParameter("pname");
	session.setAttribute("pName",Pname); 

 }
 else
 {
	 dCode = district;
	 mCode = mandal;
	 pCode=panchayat;
 }
	
String qu="SELECT DISTINCT v.vcode,v.vname from rws_district_tbl d,rws_mandal_tbl m, rws_panchayat_tbl p,rws_village_tbl v where d.dcode=v.dcode and m.mcode=v.mcode and p.pcode= v.pcode and p.dcode=d.dcode and p.mcode=m.mcode and m.dcode=d.dcode and v.dcode='"+dCode+"' and v.mcode='"+mCode+"' and v.pcode='"+pCode+"' order by v.vcode,v.vname";

try{
st=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st4=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st5=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st9=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st10=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st11=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st12=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st13=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	
	rs1=st.executeQuery(qu);
	
	%>
<html>
<head>
<title> WaterSoft </title>
<!--<script>
		window.history.forward(1);
	</script>-->
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_asset_status_no_frm.jsp">Back |</a>
				<a href="../home.jsp">Home</a>
				<!-- <a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a> -->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Asset Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<tr>
	<td align="center" class="btext"><font color="navy">District:<%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("mName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><font color="navy">Panchayat:<%=session.getAttribute("pName")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
	<!--<tr>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("circle")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>-->

</table>


<%
	//String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	     <tr>
	    <td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>VILLAGE</td>
		<td class="btext" rowspan=2>HANDPUMPS</td>
		<td class="btext" rowspan=2>PONDS </td>
		<td class="btext" rowspan=2>OPENWELLS</td>
		<td class="btext" rowspan=2>SHALLOWPUMPS</td>
		<td class="btext" colspan=3>PWS SOURCES</td>
		<td class="btext" colspan=3>CPWS SOURCES</td>
		<td class="btext" colspan=3>MPWS SOURCES</td>
        
		</tr>
		<tr align="center">
					<td class=btext>SubSurface</td>
					<td class=btext>Surface</td>
					<td class=btext>Pumpsets</td>
					<td class=btext>SubSurface</td>
					<td class=btext>Surface</td>
					<td class=btext>Pumpsets</td>
					<td class=btext>SubSurface</td>
					<td class=btext>Surface</td>
					<td class=btext>Pumpsets</td>
					
				</tr>
	
<%
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs1.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_hab_asst.jsp?vcode=<%=rs1.getString(1)%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs1.getString(2)%></a>
			</td>
        <% 
			String qu1="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_VILLAGE_tbl v WHERE     		A.ASSET_CODE=H.ASSET_CODE and substr(H.hp_code,1,2)=v.dcode and substr(H.hp_code,6,2)=v.mcode and substr(H.hp_code,13,2) = v.pcode and substr(H.hp_code,8,3) = v.vcode and substr(H.hp_code,1,2)='"+dCode+"'and substr(H.Hp_code,6,2)='"+mCode+"' and substr(H.Hp_code,13,2)='"+pCode+"' and v.vcode='"+rs1.getString(1)+"'";
            rs=st1.executeQuery(qu1);
			rs.next();
			if(!rs.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="HP"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			String qu2="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.pond_code,1,2)=v.dcode and substr(H.pond_code,6,2)=v.mcode and substr(H.pond_code,13,2)=v.pcode and substr(H.pond_code,8,3)=v.vcode and substr(H.pond_code,1,2)='"+dCode+"'and substr(H.pond_code,6,2)='"+mCode+"' and substr(H.pond_code,13,2)='"+pCode+"' and  substr(H.pond_code,8,3)='"+rs1.getString(1)+"'";//PONDS
            rs2=st2.executeQuery(qu2);
			rs2.next();
			if(!rs2.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="POND"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs2.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}  
                 String qu3="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.HABITATION_code,1,2)=v.dcode and substr(H.habitation_code,6,2)=v.mcode and substr(H.habitation_code,13,2) = v.pcode  and substr(H.habitation_code,8,3) = v.vcode and substr(H.habitation_code,1,2)='"+dCode+"' and substr(H.habitation_code,6,2)='"+mCode+"' and substr(H.habitation_code,13,2)='"+pCode+"' and  substr(H.habitation_code,8,3)='"+rs1.getString(1)+"'";
			     rs3=st3.executeQuery(qu3);
			      rs3.next();
				 if(!rs3.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="OPENWELL"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs3.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
                String qu4="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_shallowhandpumps_TBL H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and substr(H.hab_code,8,3) = v.vcode and substr(H.hab_code,1,2)='"+dCode+"' and substr(H.hab_code,6,2)='"+mCode+"'  and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs4=st4.executeQuery(qu4);
			      rs4.next();
				  if(!rs4.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="SHALLOW"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs4.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu5="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=v.dcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' AND substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3) = v.vcode  and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs5=st5.executeQuery(qu5);
			      rs5.next();
				  if(!rs5.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="PWSSUBSURFACE"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs5.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu6="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2' and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3) = v.vcode and substr(H.hab_code,1,2)='"+dCode+"' and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs6=st6.executeQuery(qu6);
			      rs6.next();
				  if(!rs6.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="PWSSURFACE"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs6.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu7="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL  H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and substr(H.hab_code,8,3) = v.vcode and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs7=st7.executeQuery(qu7);
			      rs7.next();
				  if(!rs7.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="PWSPUMPSETS"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs7.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu8="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3) = v.vcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1' and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs8=st8.executeQuery(qu8);
			      rs8.next();
				  if(!rs8.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="CPWSSUBSURFACE"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs8.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu9="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3) = v.vcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2' and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs9=st9.executeQuery(qu9);
			      rs9.next();
				  if(!rs9.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?pcode=<%=rs1.getString(1)%>&code=<%="CPWSSURFACE"%>&pname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs9.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu10="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL  H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE  and Substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3) = v.vcode and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs10=st10.executeQuery(qu10);
			      rs10.next();
				  if(!rs10.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="CPWSPUMPSETS"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs10.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu11="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3)= v.vcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1' and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs11=st11.executeQuery(qu11);
			      rs11.next();
				  if(!rs11.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="MPWSSUBSURFACE"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs11.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu12="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode and  substr(H.hab_code,8,3)= v.vcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2' and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs12=st12.executeQuery(qu12);
			      rs12.next();
				  if(!rs12.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="MPWSSURFACE"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs12.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu13="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL  H,rws_village_tbl v WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=v.dcode and substr(H.hab_code,6,2)=v.mcode and  substr(H.hab_code,13,2) = v.pcode  and  substr(H.hab_code,8,3)=v.vcode  and substr(H.hab_code,1,2)='"+dCode+"'and substr(H.hab_code,6,2)='"+mCode+"' and substr(H.hab_code,13,2)='"+pCode+"' and  substr(H.hab_code,8,3)='"+rs1.getString(1)+"'";
			     rs13=st13.executeQuery(qu13);
			      rs13.next();
				  if(!rs13.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?vcode=<%=rs1.getString(1)%>&code=<%="MPWSPUMPSETS"%>&vname=<%=rs1.getString(2)%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>"><%=rs13.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} %>
			  </tr>
			  <%
			} %>

</table>
<%

			
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
conn.close();
}
	
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>