<%@ include file = "conn.jsp" %>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;

	Statement stv=null;
	ResultSet rsv=null;
	 String district=request.getParameter("district");
	 if(district.equals("ALL"))
	 {
	 	district="-1";
	 }  
	
	 String mandal=request.getParameter("mandal");
	 if(mandal.equals("ALL"))
	 {
		 mandal="0";
	 }
	 String panchayat=request.getParameter("panchayat");
	 
	 String dCode=String.valueOf(session.getAttribute("dCode"));
	 String mCode=String.valueOf(session.getAttribute("mCode")); 
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

<table border = 1 cellspacing = 0 cellpadding = 0 width="50%" height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

  <caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right"><td class="bwborder"></td></tr>
	</table>
  </caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">Assets Status Report </font></td> 
	</tr>

	<tr><td valign=top>
	
	 <table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
     <tr>
<% 
	if(session.getAttribute("dName")!=null)
	{
%>
	<td align="center" class="mystyle1"><font color="navy">District:<%=session.getAttribute("dName")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%  }%>
	</tr>
	</table>

	<table border = 1 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" colspan=1>S.NO.</td>
		<td class="btext" colspan=1>DISTRICTS</td>
		<td class="btext" colspan=1>PWS</td>
		<td class="btext" colspan=1>CPWS</td>
		<td class="btext" colspan=1>MPWS</td>
		<td class="btext" colspan=1>HANDPUMPS</td>
		<td class="btext" colspan=1>SHALLOW HANDPUMPS</td>
		<td class="btext" colspan=1>OPENWELLS</td>
		<td class="btext" colspan=1>PONDS </td>
		<td class="btext" colspan=1>OTHERS</td>
	</tr> 
<%
	int Count=0,i=0;
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
		st12=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		int slno=0,hp=0,pond=0,open=0,shallow=0,pws=0,cpws=0,mpws=0,other=0;
		
		String qu="SELECT dcode,dname from rws_district_tbl order by dcode,dname";
		rs1=st1.executeQuery(qu);
				
		while(rs1.next())
		{
		   ++ slno;
%>
	<tr> 
	   <td class=rptValue><%=slno%></td>
       <td class="mystyle1"><font color="#6D839C" SIZE="2px">&nbsp;<%=rs1.getString(2)%>&nbsp;</font></td>
<% 		//PWS
		    String q="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE " +
		   		     "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"' ";
            rs=st.executeQuery(q);
			rs.next();
			pws=pws+rs.getInt(1);
			if(!rs.getString(1).equals("0"))
			{
%>
              <td class=rptValue align="center"><font color="#6A829E"><%=rs.getString(1)%> </font></td>
<% 
			}
		    else
			{
%>
              <td class=rptValue align="center"><%='-'%></td>
<%
			}
			
			//MPWS

			String q1="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE "+
		   		      "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"' ";
            rs12=st12.executeQuery(q1);
			rs12.next();
			mpws=mpws+rs12.getInt(1);
			if(!rs12.getString(1).equals("0"))
			{
%>			   
               <td class=rptValue align="center"><font color="#6A829E"><%=rs12.getString(1)%> </font></td>
<% 
			}
		    else
			{
%>
               <td class=rptValue align="center"><%='-'%></td>
<%
			}
		   
		   //CPWS
		   String q2="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE "+
	   				 "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '8%' AND M.TYPE_OF_ASSET_CODE='03' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"' ";
            rs2=st2.executeQuery(q2);
			rs2.next();
			cpws=cpws+rs2.getInt(1);
			if(!rs2.getString(1).equals("0"))
			{
%>
              <td class=rptValue align="center"><font color="#6A829E"><%=rs2.getString(1)%> </font></td>
<% 
			}
			else
			{
%>
                <td class=rptValue align="center"><%='-'%></td>
<%			}
			
		   //Handpumps
		    String q3="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE  M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'  AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";
            rs3=st3.executeQuery(q3);
			rs3.next();
			hp=hp+rs3.getInt(1);
			if(!rs3.getString(1).equals("0"))
			{
%>
               <td class=rptValue align="center"><font color="#6A829E"><%=rs3.getString(1)%> </font></td>
<% 			}
	  	    else
			{%>
              <td class=rptValue align="center"><%='-'%></td>
<%			}
			
			//shallowhandpumps
		    String q4="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";
            rs4=st4.executeQuery(q4);
			rs4.next();
			shallow=shallow+rs4.getInt(1);
			if(!rs4.getString(1).equals("0"))
			{
			%>			   
               <td class=rptValue align="center"><font color="#6A829E"><%=rs4.getString(1)%> </font></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
		  <%}
		   
		    //openwells		   
		    String q5="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='06' AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '5%' and  substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";
            rs5=st5.executeQuery(q5);
			rs5.next();
			open=open+rs5.getInt(1);
			if(!rs5.getString(1).equals("0"))
			{%>			   
               <td class=rptValue align="center"><font color="#6A829E"><%=rs5.getString(1)%> </font></td>
<%			}
			else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
<%			}
			
			//Ponds
			String q6="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";
            rs6=st6.executeQuery(q6);
			rs6.next();
			pond=pond+rs6.getInt(1);
			if(!rs6.getString(1).equals("0"))
			{
			%>			   
               <td class=rptValue align="center"><font color="#6A829E"><%=rs6.getString(1)%> </font></td>
			<% 
			}
			   else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
<%			}
			
			//others
			String q7="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='08' and SUBSTR (S.SCHEME_CODE,17,3) LIKE '9%' and substr(m.hab_code,1,2)=d.dcode and d.dcode='"+rs1.getString(1)+"'";
            rs7=st7.executeQuery(q7);
			rs7.next();
			other=other+rs7.getInt(1);
			if(!rs7.getString(1).equals("0"))
			{
			%>			   
               <td class=rptValue align="center"><font color="#6A829E"><%=rs7.getString(1)%> </font></td>
<%			}
		    else
			{%>
                   <td class=rptValue align="center"><%='-'%></td>
<%			}
%>
			  </tr>
<%			} 
      rs.close();rs1.close();rs2.close();rs3.close();rs4.close();rs5.close();rs6.close();rs12.close();rs7.close();
%>
		<tr>
			<td class=btext colspan=2>Grand Total</td>
			<td class=btext  align="center"><%=pws%></td>
			<td class=btext  align="center"><%=mpws%></td>
			<td class=btext  align="center"><%=cpws%></td>
			<td class=btext  align="center"><%=hp%></td>
			<td class=btext  align="center"><%=shallow%></td>
			<td class=btext  align="center"><%=open%></td>
			<td class=btext  align="center"><%=pond%></td>
			<td class=btext  align="center"><%=other%></td>
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
	}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

