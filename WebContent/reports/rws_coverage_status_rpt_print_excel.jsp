<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null;
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 		
	String query = null,a1="";
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0;		
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode"));
  String fdate=request.getParameter("FDate");
String tdate=request.getParameter("TDate");


//System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
 //System.out.println("mMMMMMMMMMcode  ="+mCode);
 //System.out.println("pPPPPPPPPPPPPPPPP=   "+pCode);

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>
<html>
<head>
<title> WaterSoft </title>
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
<body >
<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font>
<br>
<p width="100%" align="center"><b><font face="Verdana" size="3">Habitation Coverage Status  Report </font>
	</p>
<p width="100%" align="right"><b><font face="Verdana" size="2">
	Report Date :<%=fmt.format(new java.util.Date()) %></font>
</p>
<P border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align="center">	
	<% if(!dCode.equals("51")) {%>
	<font color="navy">District: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<% if(session.getAttribute("mName")!=null){%>
<font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<font color="navy">Panchayat: <%=session.getAttribute("pName") %><% } %></font>
</p>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" rules="cols">	
	<tr >
	
		<% if(dCode.equals("51") && session.getAttribute("dName")==null) {%>
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>District Name</td> 
		<td align="center" class="btext" colspan=7> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		</tr>
		<%} else if(session.getAttribute("dName")!=null && mCode.equals("0") && pCode.equals("0")) {%>
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Mandal Name</td> 
		<td align="center" class="btext" colspan=7> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		</tr>
		<% }else if( mCode.equals("5200")  && session.getAttribute("mName")==null ) {%>
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Mandal Name</td> 
		<td align="center" class="btext" colspan=7> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		</tr>
		<%} else if(session.getAttribute("mName")!=null && session.getAttribute("pName")==null && pCode.equals("0") ){%> 	
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Panchayat Name</td> 
		<td align="center" class="btext" colspan=7> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		</tr>
		<%}else if(pCode.equals("5300") && session.getAttribute("pName")==null) {%>
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Panchayat Name</td>
		<td align="center" class="btext" colspan=7> Habitation Status</td> 
	<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		</tr>	
		<% } else if(session.getAttribute("pName")!=null) {%>
		<td class="btext" >S.NO.</td>
		<td class="btext" >Habitation</td>

		<td class="btext" >Coverage Status</td> 
		 <%}%>
		

<%
int Count=0,i=0;
// //System.out.println("coount of rows is    ");
try
{
	 if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{
		a1 =  "  and to_char(status_date,'dd/mm/yyyy')  >='" + fdate +"' and to_char(status_date,'dd/mm/yyyy')  <= '"+ tdate +"' ";
	}
	if(dCode.equals("51")){

		%>	<%@ include file="./rws_dist_status_rpt.jsp" %>
		<%		
		}
		else if( (mCode.equals("0") || mCode.equals("5200")) && !dCode.equals("51") && !dCode.equals("0") )
			{%>
	
			<%@ include file="./rws_mandal_status_rpt.jsp" %>
			<% }
			
			else if(  (pCode.equals("5300") || pCode.equals("0")) && !mCode.equals("5200") && !mCode.equals("0") && !dCode.equals("51") && !dCode.equals("0") )

			{

		 //System.out.println("coount of rows is    "+Count);
		int slno=0;
		String qq2="SELECT distinct  p.pcode, p.pname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dCode+"' and  m.mcode='"+mCode+ "'  order by p.pname"; 
		st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
		rs6=st6.executeQuery(qq2);	
		rs6.last();
		Count = rs6.getRow();
	// //System.out.println("coount of rows is    "+Count);
		rs6.beforeFirst();
		String panchcode[]=new String[Count];

	if(request.getParameter("start") !=  null) {
	start = Integer.parseInt(request.getParameter("start"));
	// //System.out.println("start values  is "+start);
		}
		else
		{
			start = 1;
			// //System.out.println("start values  is "+start);	
		}
		end = start + limit;
		
		for(int j = start; j <= Count ; j++)
		//for(int j = start; j < end ; j++)
		{	//rs6.next();
				rs6.absolute(j);
			
					
		panchcode[i]=rs6.getString(1);
		// //System.out.println("panchayat  name is "+panchcode[i]);			

		query="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and  coverage_status='FC'"+ a1 ;

		String q1="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='PC1'"+ a1 ;

		String q2="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"'  and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='PC2'"+ a1 ;

		String q3="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='PC3'"+ a1 ;

		String q4="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='PC4'"+ a1 ;

		String q5="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"'  and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='NC'"+ a1 ;
 	
		String q6="SELECT count(*) from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  substr(h.hab_code,1,2)='"+dCode+"'  and substr(h.hab_code,6,2)='"+mCode+"' and substr(h.hab_code,13,2)='"+panchcode[i]+"' and coverage_status='NSS'"+ a1 ;

		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
	
		st1 = conn.createStatement();
		rs1 = st1.executeQuery(q1);
		
		st2 = conn.createStatement();
		rs2 = st2.executeQuery(q2);
		
		st3 = conn.createStatement();
		rs3= st3.executeQuery(q3);
	
		st4 = conn.createStatement();
		rs4 = st4.executeQuery(q4);
	
		st5 = conn.createStatement();
		rs5= st5.executeQuery(q5);
	
		st7 = conn.createStatement();
		rs7= st5.executeQuery(q5);

		rs.next();
		rs1.next();
		rs2.next();
		rs3.next();
		rs4.next();
		rs5.next();
		rs7.next();
			
		%>	

		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>
			<td class="mystyle1"><%=rs6.getString(2) %> </td>
		    <td class="mystyle1"><%= rs.getString(1)%></td> 
		    <td class="mystyle1"> <%= rs1.getString(1)%> </td> 
			<td class="mystyle1"><%= rs2.getString(1)%></td> 
    		<td class="mystyle1"> <%= rs3.getString(1)%> </td> 
			<td class="mystyle1"><%= rs4.getString(1)%></td> 
			<td class="mystyle1"> <%= rs5.getString(1)%> </td> 
			<td class="mystyle1"> <%= rs7.getString(1)%> </td> 
		</tr>
<%	// //System.out.println("panchayat  name is "+panchcode[i]);
		fcgtotal = fcgtotal + rs.getInt(1);	
			pc1gtotal = pc1gtotal + rs1.getInt(1);	
			pc2gtotal = pc2gtotal + rs2.getInt(1);	
			pc3gtotal = pc3gtotal + rs3.getInt(1);	
			pc4gtotal = pc4gtotal + rs4.getInt(1);	
			ncgtotal = ncgtotal + rs5.getInt(1);	
			nssgtotal = nssgtotal + rs7.getInt(1);	
		rs.close();
	rs1.close();
	rs2.close();
	rs3.close();
	rs4.close();
	rs5.close();
	stmt.close();	
	st1.close();	st2.close();st3.close();st4.close();st5.close();
}

%>
<tr>
		<td class="btext" colspan=2>TOTAL</td>
		
		<td class="btext"><%=fcgtotal%></td>
		<td class="btext"><%=pc1gtotal%></td>
		<td class="btext"><%=pc2gtotal%></td>
		<td class="btext"><%=pc3gtotal%></td>
		<td class="btext"><%=pc4gtotal%></td>
		<td class="btext"><%=ncgtotal%></td>
		<td class="btext"><%=nssgtotal%></td>

		</tr>
<%
	}
	else{ %>
			<%@ include file="./rws_panch_only_status_rpt.jsp" %>
		<%}


}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	finally
	{
	
	conn.close();
	}

%>
</table>


</body>
</html>
<p width="100%" align="center">
Designed & Developed by National Informatics Centre, AP State Centre
</p>