<%@ include file="/commons/rws_header1.jsp"%>
<% java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0;
	
	
    String[] popRange = {"SC","ST","PLAIN"};

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
		<td class="textborder" align="center" colspan="10">
			<b>District-CategoryWise-Population Report</b></td>
	</tr>

	<tr  align="center">
		<td align="center" class="rptValue" colspan=10>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 8 align="Center">Population&nbsp;&nbsp;</td>
	</tr>
	<tr>
	    <td class=btext colspan = 2 align="center">Total</td>
		<td class=btext colspan = 2 align="center">PLAIN</td>
		<td class=btext colspan = 2 align="center">SC</td>
		<td class=btext colspan = 2 align="center">ST</td>
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
	</tr>
<%
	try
	{
	int count3=0,pop=0,counttot=0,counttot1=0,counttot2=0,grplantot=0,grsctot=0,gesttot=0;
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	query="select distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' group by d.dcode,d.dname order by dcode";
	////System.out.println("query is:"+query);
	rs2=st2.executeQuery(query);
	
	while(rs2.next())
	{
	   int count=0,count1=0,count2=0,plaintot=0,sctot=0,sttot=0;
	   int j=0;
				
	   ////System.out.println("ssssssssssss" );		
       if(popRange[j].equals("SC"))
	   {
			query3 =" create or replace view popcate as SELECT HD.census_plain_popu,hd.census_sc_popu,hd.census_st_popu,hd.hab_code from  rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
			st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs3 = st3.executeQuery(query3);
	   }
	   /* if(popRange[j+1].equals("501"))
		{
		query4 ="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		 if(popRange[j+2].equals("1001"))
		{
		query5 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1500' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		  if(popRange[j+3].equals("1501"))
		{
		query6 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='2000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		  if(popRange[j+4].equals("2001"))
		{
		query7 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='2001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='3000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		  if(popRange[j+5].equals("3001"))
		{
		query8 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='3001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='4000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		  if(popRange[j+6].equals("4001"))
		{
		query9 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='4001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='5000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}
		  if(popRange[j+7].equals("5001"))
		{
		query10 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='5001' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
		}*/
	
		////System.out.println("query is"+query);
		try
		{
			query3="select * from popcate where substr(hab_code,1,2)='"+rs2.getString(1)+"' ";

			st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				/*st4=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st5=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st9=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				st10=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);*/

		rs3 = st3.executeQuery(query3);
		while(rs3.next())
		{
			if (rs3.getInt(1)<=rs3.getInt(2))
			{
    		 if (rs3.getInt(1)<=rs3.getInt(3))
    		 {
         	  //min=x;
         	   if (rs3.getInt(2)<=rs3.getInt(3))
				{
            	 //if(rs3.getInt(3) < 50)
			     if(((rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3))*0.5) < 50)
				 {
			   		count++;
				    plaintot=plaintot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
			 	 }
			     else
			 	 {
               		count2++;
	                sttot=sttot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
			 	 }
		 		}
          		else
		 		{
				 //if(rs3.getInt(2) < 50)
				 if(((rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3))*0.5) < 50)
				 {
		               count++;
		               plaintot=plaintot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
				 }
			     else
				 {
					  count1++;
					  sctot=sctot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
					 // //System.out.println(count1+" sctot count "+sctot);
				 }
			    }
   			  }
		      else
		      {              
		         // if(rs3.getInt(2) < 50)
				 if(((rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3))*0.5) < 50)
				 {
			           count++;
					   plaintot=plaintot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
				 }
				 else
				 {
					  count1++;
					  sctot=sctot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
				 }
		     }
		}
		else if (rs3.getInt(1)<=rs3.getInt(3))
		{
		    //if(rs3.getInt(3) < 50)
			if(((rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3))*0.5) < 50)
			{
				 count++;
				 plaintot=plaintot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
			}
			else
			{
			     count2++;
				 sttot=sttot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
			}
		}
		else
		{
			count++;
			plaintot=plaintot+rs3.getInt(1)+rs3.getInt(2)+rs3.getInt(3);
		}

  }
  count3+=count+count1+count2; 
   pop+=plaintot+sctot+sttot;
   counttot+=count;
   grplantot+=plaintot;
   counttot1+=count1;
   grsctot+=sctot;
   counttot2+=count2;
   gesttot+=sttot;
%>
		<tr>	
		     <td class=rptValue><%=++sno%></td>
		     <td class=rptValue><%=rs2.getString(2)%></td>
			 <td class=btext><%=count+count1+count2%></td>
			 <td class=btext><%=plaintot+sctot+sttot%></td>
		     <td class=rptValue><%=count%></td>
			 <td class=rptValue><%=plaintot%></td>
			 <td class=rptValue><%=count1%></td>
			 <%////System.out.println(count1+" sctot "+sctot);%>
			 <td class=rptValue><%=sctot%></td>
			 <td class=rptValue><%=count2%></td>
			 <%////System.out.println(count1+" sttot "+sttot);%>
			 <td class=rptValue><%=sttot%></td>
		</tr>
<%
			}
			catch(Exception e)
			{
			}
			finally
			{
				//query3 ="drop view popcate";
				//st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				//rs3 = st3.executeQuery(query3);
				
				rs3.close();
				st3.close();
			}
		 }
		%><tr>
		<td align="center" class=btext colspan=2>Total</td>	
		<td class=btext><%=count3%>	</td>
		<td class=btext><%=pop%></td>	
	    <td class=rptValue><%=counttot%></td>
	    <td class=rptValue><%=grplantot%></td>
	    <td class=rptValue><%=counttot1%></td>
	    <td class=rptValue><%=grsctot%></td>
	    <td class=rptValue><%=counttot2%></td>
	    <td class=rptValue><%=gesttot%></td>
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


