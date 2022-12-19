<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="";

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 
  
 System.out.println("district:"+district);
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

%>
<html>
<title> WaterSoft </title>
<head>
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


<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a><a href="../home.jsp">|Back</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>




	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Sources Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
    <tr><% 
	if(session.getAttribute("dName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">District:<%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
</table>


<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>DISTRICT</td>
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
int Count=0,i=0;
//String s=request.getParameter("start");


try
{
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
//st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

String qu="SELECT dcode,dname from rws_district_tbl ";
if(district!=null && !district.equals("")){
	qu+=" where  dcode='"+district+"'";
}
qu+=" order by dcode,dname";

  rs1=st1.executeQuery(qu);
	//int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,hp=0,pond=0,open=0,shallow=0,ppump=0,psur=0,psub=0,mpump=0,msur=0,msub=0,cpump=0,csur=0,csub=0;
	 while(rs1.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
        <td class="mystyle1">
         <a href="rws_mand_asst.jsp?dcode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>"><%=rs1.getString(2)%></a></td>
		   <% 
			String qu1="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_district_tbl d WHERE     A.ASSET_CODE=H.ASSET_CODE and substr(H.hp_code,1,2)=d.dcode and  d.dcode='"+rs1.getString(1)+"'";
            rs=st.executeQuery(qu1);
			rs.next();
			hp=hp+rs.getInt(1);
			if(!rs.getString(1).equals("0"))
			{
			%>
			   
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="HP"%>&dname=<%=rs1.getString(2)%>"><%=rs.getString(1)%>
			   </a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			String qu2="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.pond_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";//PONDS
            rs2=st2.executeQuery(qu2);
			rs2.next();
			pond=pond+rs2.getInt(1);
			if(!rs2.getString(1).equals("0"))
			{
			%>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="POND"%>&dname=<%=rs1.getString(2)%>">
			   <%=rs2.getString(1)%></a></td>
               <% 
				}
			else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
                 String qu3="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.HABITATION_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";//openwells
			     rs3=st3.executeQuery(qu3);
			      rs3.next();
				  open=open+rs3.getInt(1);
				  if(!rs3.getString(1).equals("0"))
			{
				  %>
                <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="OPENWELL"%>&dname=<%=rs1.getString(2)%>"><%=rs3.getString(1)%></a></td>
			    <% 
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
                String qu4="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_shallowhandpumps_TBL H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.hab_code,1,2)=d.dcode and  d.dcode='"+rs1.getString(1)+"'";//shallow
			     rs4=st4.executeQuery(qu4);
			      rs4.next();
				  shallow=shallow+rs4.getInt(1);
				  if(!rs4.getString(1).equals("0"))
			{
				  %>
                <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="SHALLOW"%>&dname=<%=rs1.getString(2)%>"><%=rs4.getString(1)%></a></td>
			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu5="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=d.dcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs5=st5.executeQuery(qu5);
			      rs5.next();
				  psub=psub+rs5.getInt(1);
				   if(!rs5.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="PWSSUBSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs5.getString(1)%></a></td>
			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu6="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=d.dcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs6=st6.executeQuery(qu6);
			      rs6.next();
				  psur=psur+rs6.getInt(1);
				   if(!rs6.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="PWSSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs6.getString(1)%></a></td>
			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu7="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=d.dcode AND d.dcode='"+rs1.getString(1)+"'";//
			     rs7=st7.executeQuery(qu7);
			      rs7.next();
				  ppump=ppump+rs7.getInt(1);
				   if(!rs7.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="PWSPUMPSETS"%>&dname=<%=rs1.getString(2)%>"><%=rs7.getString(1)%></a></td>
			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu8="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=d.dcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs8=st8.executeQuery(qu8);
			      rs8.next();
				  csub=csub+rs8.getInt(1);
				    if(!rs8.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="CPWSSUBSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs8.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu9="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=d.dcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs9=st9.executeQuery(qu9);
			      rs9.next();
				  csur=csur+rs9.getInt(1);
				  if(!rs9.getString(1).equals("0"))
			{
				  %>
              <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="CPWSSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs9.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu10="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL  H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=d.dcode AND d.dcode='"+rs1.getString(1)+"'";//
			     rs10=st10.executeQuery(qu10);
			      rs10.next();
				  cpump=cpump+rs10.getInt(1);
				   if(!rs10.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="CPWSPUMPSETS"%>&dname=<%=rs1.getString(2)%>"><%=rs10.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu11="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=d.dcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs11=st11.executeQuery(qu11);
			      rs11.next();
				  msub=msub+rs11.getInt(1);
				  if(!rs11.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="MPWSSUBSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs11.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu12="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=d.dcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2' AND d.dcode='"+rs1.getString(1)+"'";//
			     rs12=st12.executeQuery(qu12);
			      rs12.next();
				  msur=msur+rs12.getInt(1);
				   if(!rs12.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="MPWSSURFACE"%>&dname=<%=rs1.getString(2)%>"><%=rs12.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}
			     String qu13="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL  H,rws_district_tbl d WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=d.dcode AND d.dcode='"+rs1.getString(1)+"'";//
			     rs13=st13.executeQuery(qu13);
			      rs13.next();
				  mpump=mpump+rs13.getInt(1);
				  if(!rs13.getString(1).equals("0"))
			{
				  %>
               <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=rs1.getString(1)%>&code=<%="MPWSPUMPSETS"%>&dname=<%=rs1.getString(2)%>"><%=rs13.getString(1)%></a></td>

			   <%
			}else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			}%>
			  </tr>

<%
	 rs2.close();rs3.close();rs4.close();rs5.close(); rs6.close();rs7.close();rs8.close();rs9.close();rs10.close();
     rs11.close();rs12.close();rs13.close();
			} 
            rs1.close();
%>
			<tr>
			<td class=btext colspan=2>Grand Total</td>
			<td class=btext  align="center"><%=hp%></td>
			<td class=btext  align="center"><%=pond%></td>
			<td class=btext  align="center"><%=open%></td>
			<td class=btext  align="center"><%=shallow%></td>
			<td class=btext  align="center"><%=psub%></td>
			<td class=btext  align="center"><%=psur%></td>
			<td class=btext  align="center"><%=ppump%></td>
			<td class=btext  align="center"><%=csub%></td>
			<td class=btext  align="center"><%=csur%></td>
			<td class=btext  align="center"><%=cpump%></td>
			<td class=btext  align="center"><%=msub%></td>
			<td class=btext  align="center"><%=msur%></td>
			<td class=btext align="center"><%=mpump%></td>
			</tr>


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
	System.out.println("connclose");
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

