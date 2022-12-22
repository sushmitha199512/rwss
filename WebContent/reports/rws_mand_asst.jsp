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
	String query = null, a1="",dname=null;

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
  String dcode;
 
 if(district==null)   
 {
 
  dcode=request.getParameter("dcode");
 session.setAttribute("dcode",dcode);

   dname=request.getParameter("dname");
  session.setAttribute("dName",dname);
   session.setAttribute("subdiv",null);
 }
 else
 {
	 dcode = district;
	 session.setAttribute("dcode",dcode);
  dname=request.getParameter("dname");
 }
 

 // String fdate=request.getParameter("FDate");
//String tdate=request.getParameter("TDate");



int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;

%>
		

<%

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

String qu="SELECT m.mcode,m.mname from rws_mandal_tbl m,rws_district_tbl d where m.dcode=d.dcode and m.dcode='"+dcode+"' order by m.mcode,m.mname";
rs1=st1.executeQuery(qu);


	
	%>
<html>
<head>
<!--<script>
		window.history.forward(1);
</script>-->
<style>
.mystyle
{
	border-width:1;
	color:#000000;
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
<title> WaterSoft </title>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_asset_status_no_frm.jsp">Back|</a>
				<a href="../home.jsp">Home</a>
			<!-- 	<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a> -->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Sources Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<tr>
	<td align="center" class="btext"><font color="navy">District: <%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>



</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>MANDAL</td>
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
					<td class=btext>SubSurface</td>
					<td class=btext>Pumpsets</td>
					
				</tr>
	
<%

int slno=0,hp=0,pond=0,open=0,shallow=0,ppump=0,psur=0,psub=0,mpump=0,msur=0,msub=0,cpump=0,csur=0,csub=0;
	 while(rs1.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue>
			<a href="rws_panch_asst.jsp?mcode=<%=rs1.getString(1)%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs1.getString(2)%></a>
			</td>
           <% 
			String qu1="SELECT distinct count(*) FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_mandal_tbl m WHERE     A.ASSET_CODE=H.ASSET_CODE and substr(H.hp_code,1,2)=m.dcode and substr(H.hp_code,6,2)=m.mcode and substr(H.hp_code,1,2)='"+dcode+"' and  substr(H.hp_code,6,2)='"+rs1.getString(1)+"'";//HANDPUMPS
            rs=st.executeQuery(qu1);
			rs.next();
			hp=hp+rs.getInt(1);
			if(!rs.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&code=<%="HP"%>&mcode=<%=rs1.getString(1)%>&mname=<%=rs1.getString(2)%>"><%=rs.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			String qu2="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.pond_code,1,2)=m.dcode and substr(H.pond_code,6,2)=m.mcode and substr(h.pond_code,1,2)='"+dcode+"' and  m.mcode='"+rs1.getString(1)+"'";//PONDS
            rs2=st2.executeQuery(qu2);
			rs2.next();
			pond=pond+rs2.getInt(1);
			if(!rs2.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="POND"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs2.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
                 String qu3="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.HABITATION_code,1,2)=m.dcode and substr(H.habitation_code,6,2)=m.mcode and substr(h.habitation_code,1,2)='"+dcode+"' and  m.mcode='"+rs1.getString(1)+"'";//openwells
			     rs3=st3.executeQuery(qu3);
			      rs3.next();
				   open=open+rs3.getInt(1);
				if(!rs3.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="OPENWELL"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs3.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
                String qu4="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_shallowhandpumps_TBL H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and substr(h.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode and substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//shallow
			     rs4=st4.executeQuery(qu4);
			      rs4.next();
				   shallow=shallow+rs4.getInt(1);
				  if(!rs4.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="SHALLOW"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs4.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu5="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=m.dcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' AND substr(H.hab_code,6,2)=m.mcode and substr(h.hab_code,1,2)='"+dcode+"'  and  m.mcode='"+rs1.getString(1)+"'";//
			     rs5=st5.executeQuery(qu5);
			      rs5.next();
				   psub=psub+rs5.getInt(1);
				 if(!rs5.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="PWSSUBSURFACE"%>&mname=<%=rs1.getString(2)%>
			   &dcode=<%=dcode%>&dname=<%=dname%>"><%=rs5.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu6="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2' AND substr(h.hab_code,1,2)='"+dcode+"' and m.dcode='"+rs1.getString(1)+"'";//
			     rs6=st6.executeQuery(qu6);
			      rs6.next();
				   psur=psur+rs6.getInt(1);
				 if(!rs6.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="PWSSURFACE"%>&mname=<%=rs1.getString(2)%>
			   &dcode=<%=dcode%>&dname=<%=dname%>"><%=rs6.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu7="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL  H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs7=st7.executeQuery(qu7);
			      rs7.next();
				    ppump=ppump+rs7.getInt(1);
				 if(!rs7.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="PWSPUMPSETS"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs7.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu8="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1' AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs8=st8.executeQuery(qu8);
			      rs8.next();
				   csub=csub+rs8.getInt(1);
				 if(!rs8.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="CPWSSUBSURFACE"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs8.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu9="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode  and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2' AND substr(h.hab_code,1,2)='"+dcode+"' and  m.mcode='"+rs1.getString(1)+"'";//
			     rs9=st9.executeQuery(qu9);
			      rs9.next();
				  csur=csur+rs9.getInt(1);
				 if(!rs9.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="CPWSSURFACE"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs9.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu10="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL  H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs10=st10.executeQuery(qu10);
			      rs10.next();
				  cpump=cpump+rs10.getInt(1);
				 if(!rs10.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="CPWSPUMPSETS"%>&mname=<%=rs1.getString(2)%>
			   &dcode=<%=dcode%>&dname=<%=dname%>"><%=rs10.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu11="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND  substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode and SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1' AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs11=st11.executeQuery(qu11);
			      rs11.next();
				  msub=msub+rs11.getInt(1);
				 if(!rs11.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="MPWSSUBSURFACE"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs11.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu12="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE AND substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode and  SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2' AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs12=st12.executeQuery(qu12);
			      rs12.next();
				   msur=msur+rs12.getInt(1);
				 if(!rs12.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="MPWSSURFACE"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs12.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} 
			     String qu13="SELECT count(*) FROM RWS_ASSET_MAST_TBL A,RWS_AST_SUBCOMP_PARAM_TBL  H,rws_mandal_tbl m WHERE A.ASSET_CODE=H.ASSET_CODE and Substr(H.hab_code,1,2)=m.dcode and substr(H.hab_code,6,2)=m.mcode AND substr(h.hab_code,1,2)='"+dcode+"' and m.mcode='"+rs1.getString(1)+"'";//
			     rs13=st13.executeQuery(qu13);
			      rs13.next();
				   mpump=mpump+rs13.getInt(1);
				 if(!rs13.getString(1).equals("0"))
			{
			%>
			   <td class=rptValue align="center"><a href="rws_sourcodes_rpt.jsp?mcode=<%=rs1.getString(1)%>&code=<%="MPWSPUMPSETS"%>&mname=<%=rs1.getString(2)%>&dcode=<%=dcode%>&dname=<%=dname%>"><%=rs13.getString(1)%></a></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
				   <%
			} %>
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

	
