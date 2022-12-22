<%@ include file="/commons/rws_header1.jsp"%>
<% java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0,totnohab=0,totpop=0,nohab1=0,pop1=0,nohab2=0,pop2=0,nohab3=0,pop3=0,nohab4=0,pop4=0,nohab5=0,pop5=0,
	nohab6=0,pop6=0,nohab7=0,pop7=0,nohab8=0,pop8=0;
	
    String[] popRange = {"500","501","1001","1501","2001","3001","4001","5001"};

%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
	<tr>
		<td class="rptValue" align="center" colspan=20><b>DistrictWise-Population Report</b></td>
	</tr>
	
	<tr align="center">
		<td align="center" class="rptValue" colspan=20>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 18 align="Center">Population Range&nbsp;&nbsp;</td>
	</tr>
	<tr>
	    <td class=btext colspan = 2 align="center">Total</td>
		<td class=btext colspan = 2 align="center">Upto 500</td>
		<td class=btext colspan = 2 align="center">501-1000</td>
		<td class=btext colspan = 2 align="center">1001-1500</td>
		<td class=btext colspan = 2 align="center">1501-2000</td>
		<td class=btext colspan = 2 align="center">2001-3000</td>
		<td class=btext colspan = 2 align="center">3001-4000</td>
		<td class=btext colspan = 2 align="center">4001-5000</td>
        <td class=btext colspan = 2 align="center">Beyond 5001</td>
	</tr>
	<tr align = center>
		
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
	</tr>
<%
	try
	{
		st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs2=st2.executeQuery("select distinct d.dcode,d.dname from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'   order by d.dcode,d.dname");
		while(rs2.next())
		{
			int j=0;
	        if(popRange[j].equals("500"))
			{
				//query3 ="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and  coverage_status <> 'UI' and coverage_status is not null and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and ((hd.census_plain_popu is null or hd.census_sc_popu is null or hd.census_st_popu is null) or (hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='500')) ";
			query3="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"' and ((hd.census_plain_popu is null or hd.census_sc_popu is null or hd.census_st_popu is null) or (hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='500'))";
			}
		    if(popRange[j+1].equals("501"))
			{
			//query4 ="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI' and coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			 query4="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'"+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
			 if(popRange[j+2].equals("1001"))
			{
			//query5 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and coverage_status is not null  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1500' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			 query5="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1500' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
			  if(popRange[j+3].equals("1501"))
			{
			//query6 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='2000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			 query6="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' "+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='2000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
			  if(popRange[j+4].equals("2001"))
			{
			//query7 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='2001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='3000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			query7="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' "+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='2001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='3000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
			  if(popRange[j+5].equals("3001"))
			{
			//query8 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='3001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='4000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			 query8="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' "+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='3001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='4000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
			  if(popRange[j+6].equals("4001"))
			{
			//query9 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI' and coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='4001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='5000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			query9=" SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' "+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='4001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='5000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			
			}
			  if(popRange[j+7].equals("5001"))
			{
			//query10 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2) and HD.coverage_status <> 'UI' and HD.coverage_status is not null and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='5001' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			query10="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot   from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  "+
					" and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='5001' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
			}
		
		
			////System.out.println("query is"+query);
			try
			{
				st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st4=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st5=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st9=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st10=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

				rs3 = st3.executeQuery(query3);
				rs3.next();
				rs4 = st4.executeQuery(query4);
				rs4.next();
				rs5 = st5.executeQuery(query5);
				rs5.next();
				rs6 = st6.executeQuery(query6);
				rs6.next();
				rs7= st7.executeQuery(query7);
				rs7.next();
				rs8= st8.executeQuery(query8);
				rs8.next();
				rs9 = st9.executeQuery(query9);
				rs9.next();
				rs10 = st10.executeQuery(query10);
				rs10.next();
%>
	<tr>	
	   <td class=rptValue><%=++sno%></td>
	   <td class=rptValue><%=rs2.getString(2)%></td>
	   <td class=btext><%=rs3.getInt(1)+rs4.getInt(1)+rs5.getInt(1)+rs6.getInt(1)+rs7.getInt(1)+rs8.getInt(1)+rs9.getInt(1)+rs10.getInt(1)%></td>
	   <td class=btext><%=rs3.getInt(2)+rs4.getInt(2)+rs5.getInt(2)+rs6.getInt(2)+rs7.getInt(2)+rs8.getInt(2)+rs9.getInt(2)+rs10.getInt(2)%></td>
	   <td class=rptValue><%=rs3.getInt(1)%></td>
	   <td class=rptValue><%=rs3.getInt(2)%></td>
	   <td class=rptValue><%=rs4.getInt(1)%></td>
	   <td class=rptValue><%=rs4.getInt(2)%></td>
	   <td class=rptValue><%=rs5.getInt(1)%></td>
	   <td class=rptValue><%=rs5.getInt(2)%></td>
	   <td class=rptValue><%=rs6.getInt(1)%></td>
		<td class=rptValue><%=rs6.getInt(2)%></td>
		<td class=rptValue><%=rs7.getInt(1)%></td>
		<td class=rptValue><%=rs7.getInt(2)%></td>
		<td class=rptValue><%=rs8.getInt(1)%></td>
		<td class=rptValue><%=rs8.getInt(2)%></td>
		<td class=rptValue><%=rs9.getInt(1)%></td>
		<td class=rptValue><%=rs9.getInt(2)%></td>
		<td class=rptValue><%=rs10.getInt(1)%></td>
		<td class=rptValue><%=rs10.getInt(2)%></td>
    </tr>
<%
totnohab+=rs3.getInt(1)+rs4.getInt(1)+rs5.getInt(1)+rs6.getInt(1)+rs7.getInt(1)+rs8.getInt(1)+rs9.getInt(1)+rs10.getInt(1);
 totpop+=rs3.getInt(2)+rs4.getInt(2)+rs5.getInt(2)+rs6.getInt(2)+rs7.getInt(2)+rs8.getInt(2)+rs9.getInt(2)+rs10.getInt(2);
  nohab1+=rs3.getInt(1);
  pop1+=rs3.getInt(2);
  nohab2+=rs4.getInt(1);
  pop2+=rs4.getInt(2);
  nohab3+=rs5.getInt(1);
  pop3+=rs5.getInt(2);
  nohab4+=rs6.getInt(1);
  pop4+=rs6.getInt(2);
  nohab5+=rs7.getInt(1);
  pop5+=rs7.getInt(2);
  nohab6+=rs8.getInt(1);
  pop6+=rs8.getInt(2);
  nohab7+=rs9.getInt(1);
  pop7+=rs9.getInt(2);
  nohab8+=rs10.getInt(1);
  pop8+=rs10.getInt(2);	
	}
		catch(Exception e)
	 	{
	 	}
		finally
		{
			rs3.close();rs4.close();rs5.close();rs6.close();rs7.close();rs8.close();rs9.close();rs10.close();
			st3.close();st4.close();st5.close();st6.close();st7.close();st8.close();st9.close();st10.close();
		}
	}
%><tr>
	  <td class=btext colspan = 2 align="center">Grand Totals</td>
	  <td class=btext><%=totnohab%></td>
	  <td class=btext><%=totpop%></td>
	  <td class=rptValue><%=nohab1%></td>
	  <td class=rptValue><%=pop1%></td>
	  <td class=rptValue><%=nohab2%></td>
	  <td class=rptValue><%=pop2%></td>
	  <td class=rptValue><%=nohab3%></td>
	  <td class=rptValue><%=pop3%></td>
	  <td class=rptValue><%=nohab4%></td>
	  <td class=rptValue><%=pop4%></td>
	  <td class=rptValue><%=nohab5%></td>
	  <td class=rptValue><%=pop5%></td>
	  <td class=rptValue><%=nohab6%></td>
	  <td class=rptValue><%=pop6%></td>
	  <td class=rptValue><%=nohab7%></td>
	  <td class=rptValue><%=pop7%></td>
	  <td class=rptValue><%=nohab8%></td>
	  <td class=rptValue><%=pop8%></td>
	  
	  
	</tr>
	
<%	
  }
  catch(Exception e)
  {
  }
  finally
  {
	rs2.close();
	st2.close();
	conn.close();
  }
%>
</table>

</form>
</body>
</html>

