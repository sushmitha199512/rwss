<%@ include file = "conn.jsp" %>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null;
	ResultSetMetaData rsm=null;
	String mname=null,dname=null;

	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	
    String dcode;
	String mCode;
    String dName=String.valueOf(session.getAttribute("dName"));
 
	 if(district==null && mandal==null)
	 {
	    dcode=request.getParameter("dcode");
	    mCode=request.getParameter("mcode");
		session.setAttribute("mCode",mCode); 
		mname=request.getParameter("mname");
		dname=request.getParameter("dname");
		session.setAttribute("mName",mname); 
	 }
	 else
	 {
	     dcode = district;
		 mCode = mandal;
		 mname=request.getParameter("mname");
		 dname=request.getParameter("dname");
		 String qry="select d.dname,m.mname from rws_district_tbl d,rws_mandal_tbl m where d.dcode=m.dcode and d.dcode='"+district+"' and m.mcode='"+mandal+"' ";
		 st9=conn.createStatement();
		 rs9=st9.executeQuery(qry);
	
		 while(rs9.next())
		 {
			 dname=rs9.getString(1);
			 mname=rs9.getString(2);
		 }	 
	 }
	 
	 int start=0,end,limit = 10;
	 int Cnt,pgn,tpn;
	 int Count=0,i=0;
	 String s=request.getParameter("start");
	        
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
		st12=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		String qu="SELECT distinct m.mcode,m.mname from rws_district_tbl d,rws_mandal_tbl m where m.dcode=d.dcode and m.dcode='"+dcode+"'and m.mcode='"+mCode+"' order by m.mcode,m.mname";
		rs1=st10.executeQuery(qu);
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

	<table border = 1 cellspacing = 0 cellpadding = 0 width=60% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			<tr align="right"><td class="bwborder"></td></tr>
		</table>
	</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Asset Status  Report </font></td>
	</tr>

	<tr><td valign=top>

	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr>
		<td align="center" class="btext"><font color="navy">District: <%=dname %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
		<td align="center" class="btext"><font color="navy">Mandal: <%=mname %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td> 
	</tr>
	</table>

	<INPUT TYPE="hidden" name="start" value="<%=start%>">

	<table border = 1 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" align=center >S.NO.</td>
		<td class="btext" align=center nowrap>MANDAL NAME</td>
		<td class="btext" align=center>PWS </td>
		<td class="btext" align=center>CPWS </td>
		<td class="btext" align=center>MPWS </td>
		<td class="btext" align=center>HANDPUMPS</td>
		<td class="btext" align=center>SHALLOW HANDPUMPS</td>
		<td class="btext" align=center>OPENWELLS</td>
		<td class="btext" align=center>PONDS </td>
		<td class="btext" align=center>OTHERS</td>
    </tr>
<% 
	int slno=0,hp=0,pond=0,open=0,shallow=0,pws=0,mpws=0,cpws=0,other=0;
	while(rs1.next())
	{
		++ slno;
%>

	<TR>
	   <td class=rptValue rowspan=2><%=slno%></td>
       <td class="mystyle1" rowspan=2><font color="#6D839C"><%=rs1.getString(2)%></font></td>
<% 	
	//PWS
	    String q="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE " +
   			     "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"' ";
        rs=st.executeQuery(q);
		rs.next();
		pws=pws+rs.getInt(1);
		//System.out.println("1"+q);
		if(!rs.getString(1).equals("0"))
		{
		%>			   
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs.getString(1)%> </font></td>
		<% 
		}
		   else
		{%>
           <td class=rptValue align="center" rowspan=2><%='-'%></td>
	  <%}
			
		//MPWS
		String q1="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE "+
	   		      "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"' ";
        rs12=st12.executeQuery(q1);
		rs12.next();
		mpws=mpws+rs12.getInt(1);
		if(!rs12.getString(1).equals("0"))
		{
%>
	         <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs12.getString(1)%> </font></td>
<% 		}
		else
		{%>
             <td class=rptValue align="center" rowspan=2><%='-'%></td>
		<%
		}
	   
	   //CPWS
	   String q2="SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE "+
   				 "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '8%' AND M.TYPE_OF_ASSET_CODE='03' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"' ";
        rs2=st2.executeQuery(q2);
		rs2.next();
		cpws=cpws+rs2.getInt(1);
		if(!rs2.getString(1).equals("0"))
		{
		%>
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs2.getString(1)%> </font></td>
		<% 
		}
		else
		{%>
           <td class=rptValue align="center" rowspan=2><%='-'%></td>
	  <%}
		
		//Handpumps
		String q3="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE  M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'  AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"'";
   		   
        rs3=st3.executeQuery(q3);
		rs3.next();
		hp=hp+rs3.getInt(1);
		if(!rs3.getString(1).equals("0"))
		{
		%>
	   		<td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs3.getString(1)%> </font></td>
		<% 
		}
	    else
		{%>
           <td class=rptValue align="center" rowspan=2><%='-'%></td>
	 <% }
		
		//shallowhandpumps
	    String q4="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"'";
        rs4=st4.executeQuery(q4);
		rs4.next();
		shallow=shallow+rs4.getInt(1);
		if(!rs4.getString(1).equals("0"))
		{
		%>			   
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs4.getString(1)%> </font></td>
		<% 
		}
		   else
		{%>
               <td class=rptValue align="center" rowspan=2><%='-'%></td>
	 <% }
	   
	    //openwells		   
	    String q5="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='06' AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '5%' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"'";
        rs5=st5.executeQuery(q5);
		rs5.next();
		open=open+rs5.getInt(1);
		if(!rs5.getString(1).equals("0"))
		{
		%>			   
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs5.getString(1)%> </font></td>
		<% 
		}
		   else
		{%>
               <td class=rptValue align="center" rowspan=2><%='-'%></td>
		 <%
		}
		
		//Ponds
		String q6="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"'";
        rs6=st6.executeQuery(q6);
		rs6.next();
		pond=pond+rs6.getInt(1);
		if(!rs6.getString(1).equals("0"))
		{
		%>			   
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs6.getString(1)%> </font></td>
		<% 
		}
		   else
		{%>
               <td class=rptValue align="center" rowspan=2><%='-'%></td>
<%		}
		
		//others																																															 	
		String q7="select count(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_mandal_tbl m WHERE M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='08' and SUBSTR (S.SCHEME_CODE,17,3) LIKE '9%' and substr(m.hab_code,1,2)=m.dcode and substr(m.hab_code,6,2)=m.mcode and substr(m.hab_code,1,2)='"+dcode+"' and  substr(m.hab_code,6,2)='"+mCode+"' and  m.mcode='"+rs1.getString(1)+"'";
        rs7=st7.executeQuery(q7);
		rs7.next();
		other=other+rs7.getInt(1);
		if(!rs7.getString(1).equals("0"))
		{
		%>			   
           <td class=rptValue align="center" rowspan=2><font color="#6A829E"><%=rs7.getString(1)%> </font></td>
		<% 
		}
		   else
		{%>
               <td class=rptValue align="center" rowspan=2><%='-'%></td>
	<%	}
	%>
	
	</tr>
<%	} 
    rs.close();rs1.close();rs2.close();rs3.close();rs4.close();rs5.close();rs6.close();rs12.close();rs7.close();
%>
	<tr>
	</tr>

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