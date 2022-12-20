<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%
int slno=1,hcount=0,totalpop=0,col1tot=0,col2tot=0,col3tot=0,col5tot=0,col6tot=0,col7tot=0,col17tot=0,col18tot=0,col19tot=0,col8tot=0,col16tot=0,col9tot=0,col10tot=0,col11tot=0,col12tot=0,col13tot=0,col14tot=0,col4tot=0,col15tot=0;
int hab1=0,pop1=0, hab2=0,pop2=0, hab3=0,pop3=0 ,hab4=0,pop4=0,hab5=0,pop5=0;
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
			<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=21>Coverage of Habitations by Schemes</td>	
		</tr>
		
<%
try
{
	
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>
			<td class=btext rowspan=2>No. of Habs</td>	
			<td class=btext rowspan=2>POP</td>	
		    <td class=btext colspan="3">CPWS</td>
			 <td class=btext colspan="3">PWS</td>
			 <td class=btext colspan="3">MPWS</td>
			 <td class=btext colspan="3">OTHERS(DP)</td>
			<td class=btext colspan="3">ALL Schemes</td>
            <td class=btext rowspan="2">Schemes Ongoing</td>
			<td class=btext rowspan="2">Schemes Completed and Commisioned but not converted to Asset</td>
			</tr>
       
		<tr align="center">
			<td class=btext>NO</td>
            <td class=btext>Habs</td>
			<td class=btext>POP</td>
			<td class=btext>NO</td>
			<td class=btext>Habs</td>
			<td class=btext>POP</td>
			<td class=btext>NO</td>
			<td class=btext>Habs</td>
			<td class=btext>POP</td>
			<td class=btext>NO</td>
			<td class=btext>Habs</td>
			<td class=btext>POP</td>
            <td class=btext>CPWS,PWS<br>MPWS,DP</td>
			<td class=btext>Habs</td>
			<td class=btext>POP</td>
			
		</tr>

     <%
      /* String qry19 = "select distinct substr(a.hab_code,1,2),sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')) from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c where b.type_of_asset_code in ('01','02','03','09') and a.asset_code=b.asset_code and a.hab_code=c.hab_code group by substr(a.hab_Code,1,2)";
	   Statement stmt19=conn.createStatement();
	   ResultSet rs19=stmt19.executeQuery(qry19);
       Hashtable allpop=new Hashtable();
	   while(rs19.next())
       {
          allpop.put(rs19.getString(1),rs19.getString(2));    
       }

       String qry18 = "select distinct substr(a.hab_code,1,2),sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')) from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c where b.type_of_asset_code='09' and a.asset_code=b.asset_code and a.hab_code=c.hab_code group by substr(a.hab_Code,1,2)";
	   Statement stmt18=conn.createStatement();
	   ResultSet rs18=stmt18.executeQuery(qry18);
       Hashtable dppop=new Hashtable();
	   while(rs18.next())
       {
          dppop.put(rs18.getString(1),rs18.getString(2));    
       }

       String qry17 = "select distinct substr(a.hab_code,1,2),sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')) from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c where b.type_of_asset_code='02' and a.asset_code=b.asset_code and a.hab_code=c.hab_code group by substr(a.hab_Code,1,2)";
	   Statement stmt17=conn.createStatement();
	   ResultSet rs17=stmt17.executeQuery(qry17);
       Hashtable mpwspop=new Hashtable();
	   while(rs17.next())
       {
          mpwspop.put(rs17.getString(1),rs17.getString(2));    
       }

       String qry16 = "select distinct substr(a.hab_code,1,2),sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')) from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c where b.type_of_asset_code='01' and a.asset_code=b.asset_code and a.hab_code=c.hab_code group by substr(a.hab_Code,1,2)";
	   Statement stmt16=conn.createStatement();
	   ResultSet rs16=stmt16.executeQuery(qry16);
       Hashtable pwspop=new Hashtable();
	   while(rs16.next())
       {
          pwspop.put(rs16.getString(1),rs16.getString(2));    
       }

       String qry15 = "select distinct substr(a.hab_code,1,2),sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')) from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c where b.type_of_asset_code='03' and a.asset_code=b.asset_code and a.hab_code=c.hab_code group by substr(a.hab_Code,1,2)";
	   Statement stmt15=conn.createStatement();
	   ResultSet rs15=stmt15.executeQuery(qry15);
       Hashtable cpwspop=new Hashtable();
	   while(rs15.next())
       {
          cpwspop.put(rs15.getString(1),rs15.getString(2));    
       }
        */
       String qry14 = "select substr(b.hab_code,1,2),count(distinct  a.hab_code) from rws_asset_hab_tbl a,rws_asset_mast_tbl b , rws_asset_scheme_tbl c where b.asset_code=c.asset_code and  b.type_of_asset_code in ('01','02','03','09') and a.asset_code=b.asset_code group by substr(b.hab_code,1,2)";
	   Statement stmt14=conn.createStatement();
	   ResultSet rs14=stmt14.executeQuery(qry14);
       Hashtable allhabs=new Hashtable();
	   while(rs14.next())
       {
          allhabs.put(rs14.getString(1),rs14.getString(2));    
       }

 
       String qry13 = "select substr(b.hab_code,1,2),count(distinct a.hab_code) from rws_asset_hab_tbl a,rws_asset_mast_tbl b , rws_asset_scheme_tbl c where b.asset_code=c.asset_code and  b.type_of_asset_code='09' and a.asset_code=b.asset_code group by substr(b.hab_code,1,2)";
	   Statement stmt13=conn.createStatement();
	   ResultSet rs13=stmt13.executeQuery(qry13);
       Hashtable dphabs=new Hashtable();
	   while(rs13.next())
       {
          dphabs.put(rs13.getString(1),rs13.getString(2));    
       }

       String qry12 = "select substr(b.hab_code,1,2),count(distinct a.hab_code) from rws_asset_hab_tbl a,rws_asset_mast_tbl b , rws_asset_scheme_tbl c where b.asset_code=c.asset_code and  b.type_of_asset_code='02' and a.asset_code=b.asset_code group by substr(b.hab_code,1,2)";
	   Statement stmt12=conn.createStatement();
	   ResultSet rs12=stmt12.executeQuery(qry12);
       Hashtable mpwshabs=new Hashtable();
	   while(rs12.next())
       {
          mpwshabs.put(rs12.getString(1),rs12.getString(2));    
       }

       String qry11 = "select substr(b.hab_code,1,2),count(distinct a.hab_code) from rws_asset_hab_tbl a,rws_asset_mast_tbl b , rws_asset_scheme_tbl c where b.asset_code=c.asset_code and  b.type_of_asset_code='01' and a.asset_code=b.asset_code group by substr(b.hab_code,1,2)";
	   Statement stmt11=conn.createStatement();
	   ResultSet rs11=stmt11.executeQuery(qry11);
       Hashtable pwshabs=new Hashtable();
	   while(rs11.next())
       {
          pwshabs.put(rs11.getString(1),rs11.getString(2));    
       }


       String qry10 = "select substr(b.hab_code,1,2),count(distinct a.hab_code) from rws_asset_hab_tbl a,rws_asset_mast_tbl b , rws_asset_scheme_tbl c where b.asset_code=c.asset_code and  b.type_of_asset_code='03' and a.asset_code=b.asset_code group by substr(b.hab_code,1,2)";
	   Statement stmt10=conn.createStatement();
	   ResultSet rs10=stmt10.executeQuery(qry10);
       Hashtable cpwshabs=new Hashtable();
	   while(rs10.next())
       {
          cpwshabs.put(rs10.getString(1),rs10.getString(2));    
       }


       String qry9 = "select substr(a.work_id,5,2),count(*) from rws_work_admn_tbl a,rws_work_completion_tbl b  where a.type_of_asset in ('01','02','03','09') and a. work_cancel_dt is null and a.work_id=b.work_id and b.date_of_completion is not null and b.date_of_comm is not null and b.work_id not in(select asset_code from rws_asset_mast_tbl) group by substr(a.work_id,5,2)";
	   Statement stmt9=conn.createStatement();
	   ResultSet rs9=stmt9.executeQuery(qry9);
       Hashtable lastcol=new Hashtable();
	   while(rs9.next())
       {
          lastcol.put(rs9.getString(1),rs9.getString(2));    
       }
       
       String qry8 = "select substr(work_id,5,2),count(*) from rws_work_admn_tbl where type_of_asset in('01','02','03','09') and WORK_CANCEL_DT is null and  work_id not in(select work_id from rws_work_completion_tbl) group by substr(work_id,5,2)";
	   Statement stmt8=conn.createStatement();
	   ResultSet rs8=stmt8.executeQuery(qry8);
       Hashtable ongoing=new Hashtable();
	   while(rs8.next())
       {
          ongoing.put(rs8.getString(1),rs8.getString(2));    
       }


      String qry7 = "select substr(hab_code,1,2),count(*) from rws_asset_mast_tbl a ,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and  type_of_asset_code in('01','02','03','09') group by substr(hab_code,1,2)";
	  Statement stmt7=conn.createStatement();
	  ResultSet rs7=stmt7.executeQuery(qry7);
      Hashtable all=new Hashtable();
	  while(rs7.next())
       {
          all.put(rs7.getString(1),rs7.getString(2));    
       }

      String qry6 = "select substr(hab_code,1,2),count(*) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and  type_of_asset_code='09' group by substr(hab_code,1,2)";
	  Statement stmt6=conn.createStatement();
	  ResultSet rs6=stmt6.executeQuery(qry6);
      Hashtable dp=new Hashtable();
	  while(rs6.next())
       {
          dp.put(rs6.getString(1),rs6.getString(2));    
       }


      String qry5 = "select substr(hab_code,1,2),count(*) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and type_of_asset_code='02' group by substr(hab_code,1,2)";
	  Statement stmt5=conn.createStatement();
	  ResultSet rs5=stmt5.executeQuery(qry5);
      Hashtable mpws=new Hashtable();
	  while(rs5.next())
       {
          mpws.put(rs5.getString(1),rs5.getString(2));    
       }


      String qry4 = "select substr(hab_code,1,2),count(*) from rws_asset_mast_tbl a ,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and  type_of_asset_code='01' group by substr(hab_code,1,2)";
	  Statement stmt4=conn.createStatement();
	  ResultSet rs4=stmt4.executeQuery(qry4);
      Hashtable pws=new Hashtable();
	  while(rs4.next())
       {
          pws.put(rs4.getString(1),rs4.getString(2));    
       }


      String qry3 = "select substr(hab_code,1,2),count(*) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and type_of_asset_code='03' group by substr(hab_code,1,2)";
	  Statement stmt3=conn.createStatement();
	  ResultSet rs3=stmt3.executeQuery(qry3);
      Hashtable cpws=new Hashtable();
	  while(rs3.next())
       {
          cpws.put(rs3.getString(1),rs3.getString(2));    
       }


       String qry1 = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
	   Statement stmt1=conn.createStatement();
	   ResultSet rs1=stmt1.executeQuery(qry1);
	   while(rs1.next())
       {

          String qry2 = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs1.getString(1)+"'";
	      Statement stmt2=conn.createStatement();
	      ResultSet rs2=stmt2.executeQuery(qry2);
	      while(rs2.next())
            {
                hcount++;
				totalpop=totalpop+rs2.getInt(2);

            }

            /////////////cpws/////////////////////
            String cpwscount=""+cpws.get(rs1.getString(1));
            if(cpwscount!=null && !cpwscount.equals("") && !cpwscount.equals("null"))
               {
               }
               else
               {
                 cpwscount="0";
               }
           //////////////end/////////////////

          /////////////pws/////////////////////
            String pwscount=""+pws.get(rs1.getString(1));
            if(pwscount!=null && !pwscount.equals("") && !pwscount.equals("null"))
               {
               }
               else
               {
                 pwscount="0";
               }
           //////////////end/////////////////
         
          /////////////mpws/////////////////////
            String mpwscount=""+mpws.get(rs1.getString(1));
            if(mpwscount!=null && !mpwscount.equals("") && !mpwscount.equals("null"))
               {
               }
               else
               {
                 mpwscount="0";
               }
           //////////////end/////////////////
           
           ////////////dp/////////////////////
            String dpcount=""+dp.get(rs1.getString(1));
            if(dpcount!=null && !dpcount.equals("") && !dpcount.equals("null"))
               {
               }
               else
               {
                 dpcount="0";
               }
           //////////////end/////////////////

          ////////////all/////////////////////
            String allcount=""+all.get(rs1.getString(1));
            if(allcount!=null && !allcount.equals("") && !allcount.equals("null"))
               {
               }
               else
               {
                 allcount="0";
               }
           //////////////end/////////////////

           ////////////all/////////////////////
            String ongoingcount=""+ongoing.get(rs1.getString(1));
            if(ongoingcount!=null && !ongoingcount.equals("") && !ongoingcount.equals("null"))
               {
               }
               else
               {
                 ongoingcount="0";
               }
           //////////////end/////////////////
          

           ////////////lase/////////////////////
            String lastcount=""+lastcol.get(rs1.getString(1));
            if(lastcount!=null && !lastcount.equals("") && !lastcount.equals("null"))
               {
               }
               else
               {
                 lastcount="0";
               }
           //////////////end/////////////////
         
         ////////////cpwshabs/////////////////////
            String cpwshabscount=""+cpwshabs.get(rs1.getString(1));
            if(cpwshabscount!=null && !cpwshabscount.equals("") && !cpwshabscount.equals("null"))
               {
               }
               else
               {
                 cpwshabscount="0";
               }
           //////////////end/////////////////

          ////////////pwshabs/////////////////////
            String pwshabscount=""+pwshabs.get(rs1.getString(1));
            if(pwshabscount!=null && !pwshabscount.equals("") && !pwshabscount.equals("null"))
               {
               }
               else
               {
                 pwshabscount="0";
               }
           //////////////end/////////////////


        ////////////mpwshabs/////////////////////
            String mpwshabscount=""+mpwshabs.get(rs1.getString(1));
            if(mpwshabscount!=null && !mpwshabscount.equals("") && !mpwshabscount.equals("null"))
               {
               }
               else
               {
                 mpwshabscount="0";
               }
           //////////////end/////////////////

       ////////////dphabs/////////////////////
            String dphabscount=""+dphabs.get(rs1.getString(1));
            if(dphabscount!=null && !dphabscount.equals("") && !dphabscount.equals("null"))
               {
               }
               else
               {
                 dphabscount="0";
               }
           //////////////end/////////////////

          ////////////allhabs/////////////////////
            String allhabscount=""+allhabs.get(rs1.getString(1));
            if(allhabscount!=null && !allhabscount.equals("") && !allhabscount.equals("null"))
               {
               }
               else
               {
                 allhabscount="0";
               }
           //////////////end/////////////////
           

          String qry15 = "select distinct a.hab_code,(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') )as totpop from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c ,rws_asset_scheme_tbl d where b.asset_code=d.asset_code and b.type_of_asset_code='03' and a.asset_code=b.asset_code and a.hab_code=c.hab_code and substr(b.hab_code,1,2)='"+rs1.getString(1)+"'";
	      Statement stmt15=conn.createStatement();
	      ResultSet rs15=stmt15.executeQuery(qry15);
	      while(rs15.next())
            {
                hab1++;
				pop1=pop1+rs15.getInt(2);

            }


         String qry16 = "select distinct a.hab_code,(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') )as totpop from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c ,rws_asset_scheme_tbl d where b.asset_code=d.asset_code and  b.type_of_asset_code='01' and a.asset_code=b.asset_code and a.hab_code=c.hab_code and substr(b.hab_code,1,2)='"+rs1.getString(1)+"'";
	     Statement stmt16=conn.createStatement();
	     ResultSet rs16=stmt16.executeQuery(qry16);
	     while(rs16.next())
            {
                hab2++;
				pop2=pop2+rs16.getInt(2);

            }

         String qry17 = "select distinct a.hab_code,(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') )as totpop from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c ,rws_asset_scheme_tbl d where b.asset_code=d.asset_code and  b.type_of_asset_code='02' and a.asset_code=b.asset_code and a.hab_code=c.hab_code and substr(b.hab_code,1,2)='"+rs1.getString(1)+"'";
	     Statement stmt17=conn.createStatement();
	     ResultSet rs17=stmt17.executeQuery(qry17);
	     while(rs17.next())
            {
                hab3++;
				pop3=pop3+rs17.getInt(2);

            }

         String qry18 = "select distinct a.hab_code,(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') )as totpop from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c ,rws_asset_scheme_tbl d where b.asset_code=d.asset_code and  b.type_of_asset_code='09' and a.asset_code=b.asset_code and a.hab_code=c.hab_code and substr(b.hab_code,1,2)='"+rs1.getString(1)+"'";
	     Statement stmt18=conn.createStatement();
	     ResultSet rs18=stmt18.executeQuery(qry18);
	     while(rs18.next())
            {
                hab4++;
				pop4=pop4+rs18.getInt(2);

            }

        String qry19 = "select distinct a.hab_code,(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') )as totpop from rws_asset_hab_tbl a,rws_asset_mast_tbl b ,rws_habitation_directory_tbl c ,rws_asset_scheme_tbl d where b.asset_code=d.asset_code and  b.type_of_asset_code in('01','02','03','09') and a.asset_code=b.asset_code and a.hab_code=c.hab_code and substr(b.hab_code,1,2)='"+rs1.getString(1)+"'";
	    Statement stmt19=conn.createStatement();
	    ResultSet rs19=stmt19.executeQuery(qry19);
	    while(rs19.next())
           {
                hab5++;
				pop5=pop5+rs19.getInt(2);

            }



 
          /*////////////cpwspop/////////////////////
            String cpwspopcount=""+cpwspop.get(rs1.getString(1));
            if(cpwspopcount!=null && !cpwspopcount.equals("") && !cpwspopcount.equals("null"))
               {
               }
               else
               {
                 cpwspopcount="0";
               }
           //////////////end/////////////////
 
         ///////////pwspop/////////////////////
            String pwspopcount=""+pwspop.get(rs1.getString(1));
            if(pwspopcount!=null && !pwspopcount.equals("") && !pwspopcount.equals("null"))
               {
               }
               else
               {
                 pwspopcount="0";
               }
           //////////////end/////////////////

       ///////////mpwspop/////////////////////
            String mpwspopcount=""+mpwspop.get(rs1.getString(1));
            if(mpwspopcount!=null && !mpwspopcount.equals("") && !mpwspopcount.equals("null"))
               {
               }
               else
               {
                 mpwspopcount="0";
               }
           //////////////end/////////////////

///////////dppop/////////////////////
            String dppopcount=""+dppop.get(rs1.getString(1));
            if(dppopcount!=null && !dppopcount.equals("") && !dppopcount.equals("null"))
               {
               }
               else
               {
                 dppopcount="0";
               }
           //////////////end/////////////////

            ///////////allpop/////////////////////
            String allpopcount=""+allpop.get(rs1.getString(1));
            if(allpopcount!=null && !allpopcount.equals("") && !allpopcount.equals("null"))
               {
               }
               else
               {
                 allpopcount="0";
               }
           //////////////end/////////////////*/
 
 
      
     
     %>
        <tr align="center">
			<td class=rptValue><%=slno++ %></td>
			<td class=rptValue align=left><%=rs1.getString(2) %></td>
			<td class=rptValue align=right><%=hcount%></td>	
			<td class=rptValue align=right><%=totalpop %></td>	
			<td class=rptValue align=right><%=Integer.parseInt(cpwscount) %></td>
			<td class=rptValue align=right><%=Integer.parseInt(cpwshabscount)%> </td>
			<td class=rptValue align=right><%=pop1%> </td>
			<td class=rptValue align=right><%=Integer.parseInt(pwscount) %></td>
			<td class=rptValue align=right><%=Integer.parseInt(pwshabscount)%></td>
			<td class=rptValue align=right><%=pop2%> </td>
			<td class=rptValue align=right><%=Integer.parseInt(mpwscount) %></td>
			<td class=rptValue align=right><%=Integer.parseInt(mpwshabscount)%></td>
            <td class=rptValue align=right><%=pop3%> </td>
			<td class=rptValue align=right><%=Integer.parseInt(dpcount) %></td>
			<td class=rptValue align=right><%=Integer.parseInt(dphabscount)%></td>
            <td class=rptValue align=right><%=pop4%> </td>
			<td class=rptValue align=right><%=Integer.parseInt(allcount) %></td>
            <td class=rptValue align=right><%=Integer.parseInt(allhabscount)%></td>
            <td class=rptValue align=right><%=pop5%></td>
			<td class=rptValue align=right><%=Integer.parseInt(ongoingcount) %></td>
			<td class=rptValue align=right><%=Integer.parseInt(lastcount) %></td>
 		</tr>
   <%
 
      col1tot+=hcount;
      col2tot+=totalpop;
      col3tot+=Integer.parseInt(cpwscount);
      col4tot+=Integer.parseInt(cpwshabscount);
      col15tot+=pop1;
      col5tot+=Integer.parseInt(pwscount);
      col6tot+=Integer.parseInt(pwshabscount);
      col16tot+=pop2;
      col7tot+=Integer.parseInt(mpwscount);
      col8tot+=Integer.parseInt(mpwshabscount);
      col17tot+=pop3;
      col9tot+=Integer.parseInt(dpcount);
      col10tot+=Integer.parseInt(dphabscount);
      col18tot+=pop4; 
      col11tot+=Integer.parseInt(allcount);
      col12tot+=Integer.parseInt(allhabscount);
	  col19tot+=pop5;
      col13tot+=Integer.parseInt(ongoingcount);
      col14tot+=Integer.parseInt(lastcount);


      hcount=0;
      totalpop=0;
      cpwscount=""; cpwshabscount="";
      pop1=0;pop2=0;pop3=0;pop4=0;pop5=0;
pwscount="";
      pwshabscount="";
//pwspopcount="";mpwscount="";mpwshabscount="";

//mpwspopcount="";
dpcount="";dphabscount="";
      //dppopcount="";
allcount=""; allhabscount="";
//allpopcount="";
 ongoingcount=""; lastcount="";
       }
   %>
       <tr align="center">
			<td class=btext colspan=2>Totals</td>
			<td class=btext align=right><%=col1tot %></td>
			<td class=btext align=right><%=col2tot %></td>	
			<td class=btext align=right><%=col3tot %></td>	
			<td class=btext align=right><%=col4tot %></td>
			<td class=btext align=right><%=col15tot %> </td>
			<td class=btext align=right><%=col5tot %></td>
			<td class=btext align=right><%=col6tot %></td>
			<td class=btext align=right><%=col16tot %> </td>
			<td class=btext align=right><%=col7tot %></td>
			<td class=btext align=right><%=col8tot %></td>
			<td class=btext align=right><%=col17tot %></td>
			<td class=btext align=right><%=col9tot %></td>
			<td class=btext align=right><%=col10tot %></td>
			<td class=btext align=right><%=col18tot %> </td>
			<td class=btext align=right><%=col11tot %></td>
			<td class=btext align=right><%=col12tot %></td>
 			<td class=btext align=right><%=col19tot %></td>
            <td class=btext align=right><%=col13tot %></td>
			<td class=btext align=right><%=col14tot %></td>
	  </tr>

<%		
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{

}

 %>
</table>
<br>
<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td><td class=rptValue nowrap>This report is generated based on <font color=red>Actual Schemes</font> present in the WaterSoft.</td></tr>

</table>
</body>
</html>
<br>
<br>
<%@ include file = "footer.jsp" %>
