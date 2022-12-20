<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>

<body>
<p align=right>
<%

String circlecode=null,divisioncode=null,labcode=null,sourcecode=null,circlename=null,divisionname=null,labname=null,sourcename=null;
int slno=0;int totNotFoundContaminated=0;int totNotFoundContaminatedb=0;
	    circlename=(String)session.getAttribute("circleName");
	    divisionname=(String)session.getAttribute("divName");

	    labname=(String)session.getAttribute("lbName");
	    sourcename=(String)session.getAttribute("sName");
	   	    
		circlecode=request.getParameter("district");
		//System.out.println("circlecode"+circlecode);
		session.setAttribute("circlecode",circlecode);
        
        divisioncode=request.getParameter("division");
        //System.out.println("divisioncode"+divisioncode);
        session.setAttribute("divisioncode",divisioncode);
		
        labcode= request.getParameter("lab");
		//(String)session.getAttribute("lbCode");
		sourcecode=request.getParameter("assetType");
		//=(String)session.getAttribute("sCode");

		String year=request.getParameter("year");
        String month=request.getParameter("month");
		String mon=request.getParameter("month");
		String yr=request.getParameter("year");
        //System.out.println("mon"+mon);
		//System.out.println("yr"+yr);
         
		if(month!=null && !month.equals("") && month.equals("51") || month.equals("0"))
		{
		  mon="ALL";
		}
		if(yr!=null && !yr.equals("") && yr.equals("51") || yr.equals("0"))
		{
		  yr="ALL";
        }
         
         session.setAttribute("month",month);
         session.setAttribute("year",year);
         session.setAttribute("mon",mon);
         session.setAttribute("yr",yr);

	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt13=null;
    ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs13=null;
	int gtotdw=0,gftk=0,gsample=0,gtsample=0,gtsource=0,gsample1=0,gsample2=0,gftktot=0,gsample3=0;
		%>
<%if(circlecode.equals("00")){
//System.out.println(" All circles"+yr);

 %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                    <a href="rws_waterqtly_sources_rpt_xls.jsp" target="_new">Excel</a>
                 </td>
			</tr>
		 </table>
</caption>
        <tr align=center  align=center>
		<td class=rptValue colspan="11"><b><font color="blue">WaterQuality Sources Report</font></b></td>
		</tr>
        <tr align=center  align=center>
		<td class=rptValue colspan="11"><font color="blue">&nbsp;ALL &nbsp;Circles&nbsp;&nbsp;-&nbsp;&nbsp;Divisions&nbsp;:&nbsp;ALL &nbsp;&nbsp;-&nbsp;&nbsp;Year&nbsp;:&nbsp;<%=yr%>&nbsp;&nbsp;-&nbsp;&nbsp;Month&nbsp;:&nbsp;<%=mon%></font></td>
		</tr>
		<tr align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Circle</td>
		<td class=btext>Division</td>
        <td class=btext>Total No.of Sources</td>
 <td class=btext>Total No.of Tested Sources</td>
		<td class=btext>No.of Sources having Field<br>Test-Chemical Results(FTK-C)</td>
        <td class=btext>No.of Sources having Field<br>Test-H2s Vials(FTK-B)</td>
		<td class=btext colspan=2>No.of Sources Not Found Contaminated</td>
       	<td class=btext>No.of Samples Forwarded<br>to the Laboratory(FTK TESTED SOURCES ONLY)</td>
        <td class=btext>No. of Samples having<br>Chemical Test Results</td>
        <td class=btext>No.of Samples having <br>Bacteriological Test Results</td>
        <td class=btext>Total No.of Sources <br>having Laboratory Results</td>
        <td class=btext>Total No.of Samples <br>having Laboratory Results</td>
		</tr>
       <tr align=center>






        <td class=btext>1</td>
        <td class=btext>2</td>
		<td class=btext>3</td>
		<td class=btext>4</td>
		<td class=btext>5</td>
		<td class=btext>6</td>
<td class=btext>7</td>
		<td class=btext>8(ftk-c)</td>
		<td class=btext>9(ftk-b)</td>
		<td class=btext>10</td>
		<td class=btext>11</td>
        <td class=btext>12</td><td class=btext>13</td>

<td class=btext>14</td>
		</tr>
	<%
       try{  slno=1;
              
			//mpws,cpws,pws
			String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry1+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry1+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry1+="group by substr(m.hab_code,1,2),m.division_office_code order by 2";

            System.out.println("mpws,cpws,pws qry1:"+qry1);
			stmt1=conn.createStatement();
			rs1=stmt1.executeQuery(qry1);
			Hashtable aht=new Hashtable();
			while(rs1.next())
			{
			  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
              //System.out.println(aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1)));
			}
            if(rs1!=null){rs1.close();}
            if(stmt1!=null){stmt1.close();}

			//hp
			String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry2+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry2+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }  */
            qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt2=conn.createStatement();
			System.out.println("hp qry2:"+qry2);
			rs2=stmt2.executeQuery(qry2);
			Hashtable hpht=new Hashtable();
			while(rs2.next())
			 {
			   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
			 }
			 if(rs2!=null){rs2.close();}
            if(stmt2!=null){stmt2.close();}
             //open
			String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry3+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry3+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
			qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt3=conn.createStatement();
			System.out.println("open qry3:"+qry3);
			rs3=stmt3.executeQuery(qry3);
			Hashtable opht=new Hashtable();
			while(rs3.next())
			 {
			   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
			 }
            if(rs3!=null){rs3.close();}
            if(stmt3!=null){stmt3.close();}
			 // shp
			String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry4+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry4+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt4=conn.createStatement();
		    System.out.println("shp qry4:"+qry4);
			rs4=stmt4.executeQuery(qry4);
			Hashtable shpht=new Hashtable();
			while(rs4.next())
			 {
			   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
			 }
            if(rs4!=null){rs4.close();}
            if(stmt4!=null){stmt4.close();}
			//ponds
		    String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
		 	/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry5+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry5+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt5=conn.createStatement();
			System.out.println("ponds qry5:"+qry5);
			rs5=stmt5.executeQuery(qry5);
			Hashtable pondht=new Hashtable();
			while(rs5.next())
			 {
			   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
			 }
              if(rs5!=null){rs5.close();}
            if(stmt5!=null){stmt5.close();}
             //ftk-c sources
			String qry6="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and (ARSENIC='Y' or NITRATE='Y' or FLORIDE='Y'or SALINITY='Y'or IRON='Y')";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
			qry6+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt6=conn.createStatement();
			System.out.println("ftk sources qry6:"+qry6);
			rs6=stmt6.executeQuery(qry6);
			Hashtable ftkht=new Hashtable();
			while(rs6.next())
			{
			  ftkht.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}



          String notFoundContaminated="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16)  ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
notFoundContaminated+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

			Statement stmt66=conn.createStatement();
			System.out.println("ftk sources notFoundContaminated:"+notFoundContaminated);
			ResultSet rs66=stmt66.executeQuery(notFoundContaminated);
			Hashtable nofoundTable=new Hashtable();
			while(rs66.next())
			{
			  nofoundTable.put(rs66.getString(2)+rs66.getString(3),rs66.getString(1));
            }
            if(rs66!=null){rs66.close();}
            if(stmt66!=null){stmt66.close();}

//srinivas
            
            String notFoundContaminatedb="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  ( COLIFORM is null )  ";

            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
  			 {
  			  notFoundContaminatedb+=" and to_char(test_date,'MON')='"+month+"' ";
  			 }
  			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
  			 {
  			  notFoundContaminatedb+=" and to_char(test_date,'yyyy')='"+year+"' ";
  			 }
             notFoundContaminatedb+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

  			Statement stmt68=conn.createStatement();
  			System.out.println("notFoundContaminatedb:"+notFoundContaminatedb);
  			ResultSet rs68=stmt68.executeQuery(notFoundContaminatedb);
  			Hashtable nofoundTableb=new Hashtable();
  			while(rs68.next())
  			{
  			  nofoundTableb.put(rs68.getString(2)+rs68.getString(3),rs68.getString(1));
              }
              if(rs68!=null){rs68.close();}
              if(stmt68!=null){stmt68.close();}

            
            //end
            
            
                
            
                     
            
            
            
            
            
              //ftk-bat sources
			String qry8="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and COLIFORM ='Y'";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry8+=" and to_char(test_date,'MON')='"+month+"' ";
			}
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
		     qry8+=" and to_char(test_date,'yyyy')='"+year+"' ";
			}
		    qry8+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt8=conn.createStatement();
			System.out.println("ftk bat sources qry8:"+qry8);
			rs8=stmt8.executeQuery(qry8);
			Hashtable ftkbt=new Hashtable();
			while(rs8.next())
			{
			  ftkbt.put(rs8.getString(2)+rs8.getString(3),rs8.getString(1));
            }
            if(rs8!=null){rs8.close();}
            if(stmt8!=null){stmt8.close();}
            //sources having lab results

           /* String qry13="select count(distinct a.source_code),substr(c.panch_code,1,2),a.division_office_code from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry13+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry13+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}
			qry13+=" group by  substr(c.panch_code,1,2),a.division_office_code  order by 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry13:"+qry13);
			rs13=stmt13.executeQuery(qry13);
			Hashtable sources=new Hashtable();
			while(rs13.next())
			{
			  sources.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}

            */


			String qry7="select count(distinct c.source_code),substr(hd.panch_code,1,2),c.division_office_code  from rws_water_sample_collect_tbl c,rws_complete_hab_view hd   where hd.panch_code=c.hab_code and c.test_id is not null";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry7+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}
			qry7+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";

			stmt7=conn.createStatement();
			System.out.println("sources having lab results qry7:"+qry7);
			rs7=stmt7.executeQuery(qry7);
			Hashtable water=new Hashtable();
			while(rs7.next())
			{
			  water.put(rs7.getString(2)+rs7.getString(3),rs7.getString(1));
			}
            if(rs7!=null){rs7.close();}
            if(stmt7!=null){stmt7.close();}
          //chemical sample
            String qryc1="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=1 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc1+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc1+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}
			qryc1+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt13=conn.createStatement();
			System.out.println("chemical sample qryc1:"+qryc1);
			rs13=stmt13.executeQuery(qryc1);
			Hashtable testsamples1=new Hashtable();
			while(rs13.next())
			{
			  testsamples1.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
             if(rs13!=null){rs13.close();}
             if(stmt13!=null){stmt13.close();}
            //bact sample
			String qryc2="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=2 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc2+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc2+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}  
			qryc2+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt11=conn.createStatement();
			System.out.println("bact sample qryc2:"+qryc2);
			rs11=stmt11.executeQuery(qryc2);
			Hashtable testsamples2=new Hashtable();
			while(rs11.next())
			{
			  testsamples2.put(rs11.getString(2)+rs11.getString(3),rs11.getString(1));
			}
            if(rs11!=null){rs11.close();}
            if(stmt11!=null){stmt11.close();} 
           //lab samples res
            String qry9="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry9+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry9+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}
			qry9+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt9=conn.createStatement();
			System.out.println("lab samples res qry9:"+qry9);
			rs9=stmt9.executeQuery(qry9);
			Hashtable testsamples=new Hashtable();
			while(rs9.next())
			{
			  testsamples.put(rs9.getString(2)+rs9.getString(3),rs9.getString(1));
			}
            if(rs9!=null){rs9.close();}
            if(stmt9!=null){stmt9.close();}

            //lab sources forwared to lab
            String qry10="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  FORWARD_DATE is not null ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  qry10+=" and to_char(test_date,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     qry10+=" and to_char(test_date,'yyyy')='"+year+"' ";
				}
            qry10+="group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt10=conn.createStatement();
			System.out.println("lab sources forwared to lab qry10:"+qry10);
			rs10=stmt10.executeQuery(qry10);
			Hashtable testsources=new Hashtable();
			while(rs10.next())
			{
			  testsources.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
            if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();}
			

			String query= "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where b.status<>'UI' and a.circle_office_code=b.circle_office_code";
			       query+=" order by circle_office_name ";
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
             System.out.println("main qry:"+query);
               boolean flag=false;
               int j=0;
  int tesTot=0;
			  while(rs.next())
		     {
               flag=true;

	           String ast=""+aht.get(rs.getString(1)+rs.getString(3));
			   if(ast!=null && !ast.equals("") && !ast.equals("null"))
               {
               }
               else
               {
                 ast="0";
               }
	          String hp=""+hpht.get(rs.getString(1)+rs.getString(3));
			  if(hp!=null && !hp.equals("") && !hp.equals("null")){} else{ hp="0";}
			  String open=""+opht.get(rs.getString(1)+rs.getString(3));
			  if(open!=null && !open.equals("") && !open.equals("null")){} else{ open="0";}
			  String shp=""+shpht.get(rs.getString(1)+rs.getString(3));
			  if(shp!=null && !shp.equals("") && !shp.equals("null")){} else{ shp="0";}
			  String pond=""+pondht.get(rs.getString(1)+rs.getString(3));
			  if(pond!=null && !pond.equals("") && !pond.equals("null")){} else{ pond="0";}
			
	          int totdw=Integer.parseInt(ast)+Integer.parseInt(hp)+Integer.parseInt(open)+Integer.parseInt(shp)+Integer.parseInt(pond);
              
              //ftk sources
				String ftk=""+ftkht.get(rs.getString(1)+rs.getString(3));
				if(ftk!=null && !ftk.equals("") && !ftk.equals("null")){} else{ ftk="0";}

                //ftk bt sources
				String ftbk=""+ftkbt.get(rs.getString(1)+rs.getString(3));
				if(ftbk!=null && !ftbk.equals("") && !ftbk.equals("null")){} else{ ftbk="0";}
						 
               //total lab sources
              String ftkcsample=""+water.get(rs.getString(1)+rs.getString(3));
		      if(ftkcsample!=null && !ftkcsample.equals("") && !ftkcsample.equals("null")){} else{ ftkcsample="0";}
		      
		      
		      
		    


            // String labsources=""+sources.get(rs.getString(1)+rs.getString(3));
		     //if(labsources!=null && !labsources.equals("") && !labsources.equals("null")){} else{ labsources="0";}

             /*int sourcecount=0,sourcecount1=0,sourcetot=0;
             boolean flag1=false;

              if(labsources.equals(ftkcsample))
                 {
                   sourcecount=1;
                   j=j+1;                                 
                 } 
              else sourcecount1+=1; 
             
              sourcetot=sourcecount+sourcecount1;*/
		 
              //chemical smaples
               String tsample1=""+testsamples1.get(rs.getString(1)+rs.getString(3));
               if(tsample1!=null && !tsample1.equals("") && !tsample1.equals("null")){} else{ tsample1="0";}
		    
              //bact samples
               String tsample2=""+testsamples2.get(rs.getString(1)+rs.getString(3));
		       if(tsample2!=null && !tsample2.equals("") && !tsample2.equals("null")){} else{ tsample2="0";}
             
             //lab samples results
             String tsample=""+testsamples.get(rs.getString(1)+rs.getString(3));
		     if(tsample!=null && !tsample.equals("") && !tsample.equals("null")){} else{ tsample="0";}
		      
               //sources forwared to lab
             String tsource=""+testsources.get(rs.getString(1)+rs.getString(3));
		     if(tsource!=null && !tsource.equals("") && !tsource.equals("null")){} else{ tsource="0";}
		 
			String notFoundsources=""+nofoundTable.get(rs.getString(1)+rs.getString(3));
					if(notFoundsources==null || notFoundsources.equals("null")){
							notFoundsources="0";		
					}

					//srinivas
					String notFoundsourcesb=""+nofoundTableb.get(rs.getString(1)+rs.getString(3));
					      if(notFoundsourcesb==null || notFoundsourcesb.equals("null")){
							notFoundsourcesb="0";
								}
					//end

					
					
					
					
					
					
	       %>
	        <tr>
                <%if(flag){%>
		        <td class=rptValue><%=slno++%></td>
		        <td class=rptValue><%=rs.getString(2)%></td>
                <%}else{ %>
                <td class=rptValue></td>
		        <td class=rptValue></td>
                <%}%>
				<td class=rptValue><%=rs.getString(4)%></td>
				<td class=rptValue align="right"><%=totdw%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)%></td>

				<td class=rptValue align="right"><%=ftk%></td>
				<td class=rptValue align="right"><%=ftbk%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)!=0?Integer.parseInt(notFoundsources)-Integer.parseInt(ftk):"0"%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)!=0?Integer.parseInt(notFoundsources)-Integer.parseInt(ftbk):"0"%></td>
			    <td class=rptValue align="right"><%=tsource%></td>            
				<td class=rptValue align="right"><%=tsample1%></td>
				<td class=rptValue align="right"><%=tsample2%></td>
               <%if(!ftkcsample.equals("0")){ %>
                <td class=rptValue align="right"><a href="rws_waterqtly_sources_detailed_rpt.jsp?ccode=<%=rs.getString(1)%>&cname=<%=rs.getString(2)%>&dcode=<%=rs.getString(3)%>&dname=<%=rs.getString(4)%>&mon=<%=month%>&yr=<%=year%>"><%=ftkcsample%></a></td>
				<%}else{ %>
               <td class=rptValue align="right"><%=ftkcsample%></td>
                <%} %>
				<td class=rptValue align="right"><%=tsample%></td>
		    </tr>
          <% 
tesTot+=Integer.parseInt(notFoundsources);
           gtotdw+=totdw;
			totNotFoundContaminated+=Integer.parseInt(notFoundsources);
			totNotFoundContaminatedb+=Integer.parseInt(notFoundsourcesb);
		   gftk+=Integer.parseInt(ftk);
		   gtsource+=Integer.parseInt(ftbk);
		   gtsample+=Integer.parseInt(tsource);
		   gsample1+=Integer.parseInt(tsample1);
           gsample2+=Integer.parseInt(tsample2);
           gftktot+=Integer.parseInt(ftkcsample);
		   gsample3+=Integer.parseInt(tsample);
		}
	 //System.out.println("jjjjjjjjjjjjj"+j);	 
		  
		  %>
      <tr>
			<td class="btext" colspan="3">Total:</td>
		    <td class=btext align="right"><%=gtotdw%></td>
   <td class=btext align="right"><%=tesTot %></td>
			<td class=btext align="right"><%=gftk%></td>
			<td class=btext align="right"><%=gtsource %></td>
 <td class=btext align="right"><%=totNotFoundContaminated %></td>
  <td class=btext align="right"><%=totNotFoundContaminatedb %></td>
			<td class=btext align="right"><%=gtsample %></td>
			<td class=btext align="right"><%=gsample1 %></td>
         
            <td class=btext align="right"><%=gsample2 %></td>
            <td class=btext align="right"><%=gftktot %></td>
			<td class=btext align="right"><%=gsample3%></td>
     </tr> 
		    <%
  flag=false;   }    
	
     catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:");
        e.printStackTrace();
	   }
	  
	   %>
</table>
<%}%>

<%if(!circlecode.equals("00") && divisioncode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                    <a href="rws_waterqtly_sources_rpt_xls.jsp" target="_new">Excel</a>
                 </td>
			</tr>
		 </table>
</caption>
<tr align=center  align=center>
		<td class=rptValue colspan="11"><b><font color="blue">WaterQuality Sources Report </font></b></td>
		</tr>
       <tr align=center  align=center>
		<td class=rptValue colspan="11"><font color="blue">&nbsp;Circle &nbsp;:&nbsp;<%=circlename%>&nbsp;&nbsp;-&nbsp;&nbsp;Divisions &nbsp;:&nbsp; ALL&nbsp;&nbsp;-&nbsp;&nbsp;Year&nbsp;:&nbsp;<%=yr%>&nbsp;&nbsp;-&nbsp;&nbsp;Month&nbsp;:&nbsp;<%=mon%></font></td>
		</tr>
		<tr align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Circle</td>
		<td class=btext>Division</td>
        <td class=btext>Total No.of Sources</td>
<td class=btext>Total No.of Tested Sources</td>
		<td class=btext>No.of Sources having Field<br>Test-Chemical Results(FTK-C)</td>
        <td class=btext>No.of Sources having Field<br>Test-H2s Vials(FTK-B)</td>
		<td class=btext colspan=2>No.of Sources Not Found Contaminated</td>

       	<td class=btext>No.of Samples Forwarded<br>to the Laboratory(FTK TESTED SOURCES ONLY)</td>
        <td class=btext>No. of Samples having<br>Chemical Test Results</td>
        <td class=btext>No.of Samples having <br>Bacteriological Test Results</td>
        <td class=btext>Total No.of Sources <br>having Laboratory Results</td>
        <td class=btext>Total No.of Samples <br>having Laboratory Results</td>
		</tr>
       <tr align=center> 
        <td class=btext>1</td>
        <td class=btext>2</td>
		<td class=btext>3</td>
		<td class=btext>4</td>
		<td class=btext>5</td>
		<td class=btext>6</td>
		<td class=btext>7(ftk-c)</td>
		<td class=btext>8(ftk-b)</td>
		<td class=btext>9</td>
		<td class=btext>10</td>
        <td class=btext>11</td>
		</tr>
	<%
       try{  slno=1;
              //System.out.println(" All circles-any division");
			//mpws,cpws,pws
			String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE";
           /* if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry1+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry1+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry1+=" group by substr(m.hab_code,1,2),m.division_office_code order by 2";
			System.out.println("qry1:"+qry1);
			stmt1=conn.createStatement();
			rs1=stmt1.executeQuery(qry1);
			Hashtable aht=new Hashtable();
			while(rs1.next())
			{
			  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
              //System.out.println(aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1)));
			}
            if(rs1!=null){rs1.close();}
            if(stmt1!=null){stmt1.close();}
			//hp
			String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";
			/*       if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry2+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry2+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt2=conn.createStatement();
			System.out.println("qry2:"+qry2);
			rs2=stmt2.executeQuery(qry2);
			Hashtable hpht=new Hashtable();
			while(rs2.next())
			 {
			   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
			 }
			 if(rs2!=null){rs2.close();}
             if(stmt2!=null){stmt2.close();}
             //open
			 String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";
            /* if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry3+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry3+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }	*/				
            qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt3=conn.createStatement();
			System.out.println("qry3:"+qry3);
			rs3=stmt3.executeQuery(qry3);
			Hashtable opht=new Hashtable();
			while(rs3.next())
			 {
			   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
			 }
            if(rs3!=null){rs3.close();}
            if(stmt3!=null){stmt3.close();}
			 // shp
		    String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
           /* if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry4+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry4+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/			 	    
            qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt4=conn.createStatement();
		   System.out.println("qry4:"+qry4);
			rs4=stmt4.executeQuery(qry4);
			Hashtable shpht=new Hashtable();
			while(rs4.next())
			 {
			   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
			 }
            if(rs4!=null){rs4.close();}
            if(stmt4!=null){stmt4.close();}
			//ponds
		    String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
            /*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry5+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry5+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/		 	      
            qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt5=conn.createStatement();
			System.out.println("qry5:"+qry5);
			rs5=stmt5.executeQuery(qry5);
			Hashtable pondht=new Hashtable();
			while(rs5.next())
			 {
			   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
			 }
            if(rs5!=null){rs5.close();}
            if(stmt5!=null){stmt5.close();}
             //ftk-c sources
			String qry6="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and (ARSENIC='Y' or NITRATE='Y' or FLORIDE='Y'or SALINITY='Y'or IRON='Y')";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }				   
            qry6+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt6=conn.createStatement();
			System.out.println("ftk sources qry6:"+qry6);
			rs6=stmt6.executeQuery(qry6);
			Hashtable ftkht=new Hashtable();
			while(rs6.next())
			{
			  ftkht.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}
              //ftk-bat sources





		 String notFoundContaminated="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
notFoundContaminated+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

			Statement stmt66=conn.createStatement();
			System.out.println("ftk sources qry6:"+qry6);
			ResultSet rs66=stmt66.executeQuery(notFoundContaminated);
			Hashtable nofoundTable=new Hashtable();
			while(rs66.next())
			{
			  nofoundTable.put(rs66.getString(2)+rs66.getString(3),rs66.getString(1));
            }
            if(rs66!=null){rs66.close();}
            if(stmt66!=null){stmt66.close();}

//srinivas

            String notFoundContaminatedb="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  ( COLIFORM is null )  ";

            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
  			 {
  			  notFoundContaminatedb+=" and to_char(test_date,'MON')='"+month+"' ";
  			 }
  			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
  			 {
  			  notFoundContaminatedb+=" and to_char(test_date,'yyyy')='"+year+"' ";
  			 }
             notFoundContaminatedb+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

  			Statement stmt68=conn.createStatement();
  			System.out.println("notFoundContaminatedb:"+notFoundContaminatedb);
  			ResultSet rs68=stmt68.executeQuery(notFoundContaminatedb);
  			Hashtable nofoundTableb=new Hashtable();
  			while(rs68.next())
  			{
  			  nofoundTableb.put(rs68.getString(2)+rs68.getString(3),rs68.getString(1));
              }
              if(rs68!=null){rs68.close();}
              if(stmt68!=null){stmt68.close();}





//end



			 String qry8="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and COLIFORM ='Y'";
				  if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry8+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry8+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
            qry8+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt8=conn.createStatement();
			System.out.println("ftk abt sources qry8:"+qry8);
			rs8=stmt8.executeQuery(qry8);
			Hashtable ftkbt=new Hashtable();
			while(rs8.next())
			{
			  ftkbt.put(rs8.getString(2)+rs8.getString(3),rs8.getString(1));
            }
            if(rs8!=null){rs8.close();}
            if(stmt8!=null){stmt8.close();}
            //sources having lab results
			String qry7="select count(distinct c.source_code),substr(hd.panch_code,1,2),c.division_office_code  from rws_water_sample_collect_tbl c,rws_complete_hab_view hd where hd.panch_code=c.hab_code and c.test_id is not null";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry7+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}			       
            qry7+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt7=conn.createStatement();
			//System.out.println("2 qry7:"+qry7);
			rs7=stmt7.executeQuery(qry7);
			Hashtable water=new Hashtable();
			while(rs7.next())
			{
			  water.put(rs7.getString(2)+rs7.getString(3),rs7.getString(1));
			}
             if(rs7!=null){rs7.close();}
            if(stmt7!=null){stmt7.close();}
          //chemical sample
          String qryc1="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=1 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc1+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc1+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}			  	
            qryc1+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt13=conn.createStatement();
			//System.out.println("qryc1:"+qryc1);
			rs13=stmt13.executeQuery(qryc1);
			Hashtable testsamples1=new Hashtable();
			while(rs13.next())
			{
			  testsamples1.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
            if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}
            //bact sample
			String qryc2="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=2 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc2+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc2+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}				   
            qryc2+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt11=conn.createStatement();
			System.out.println("qryc2:"+qryc2);
			rs11=stmt11.executeQuery(qryc2);
			Hashtable testsamples2=new Hashtable();
			while(rs11.next())
			{
			  testsamples2.put(rs11.getString(2)+rs11.getString(3),rs11.getString(1));
			}
            if(rs11!=null){rs11.close();}
            if(stmt11!=null){stmt11.close();}
           //lab samples res
            String qry9="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry9+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry9+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}					
            qry9+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt9=conn.createStatement();
			//System.out.println("qry9:"+qry9);
			rs9=stmt9.executeQuery(qry9);
			Hashtable testsamples=new Hashtable();
			while(rs9.next())
			{
			  testsamples.put(rs9.getString(2)+rs9.getString(3),rs9.getString(1));
			}
            if(rs9!=null){rs9.close();}
            if(stmt9!=null){stmt9.close();}

            //lab sources forwared to lab
            String qry10="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  FORWARD_DATE is not null";
	        if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry10+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry10+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
            qry10+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";			
            stmt10=conn.createStatement();
			//System.out.println("qry10:"+qry10);
			rs10=stmt10.executeQuery(qry10);
			Hashtable testsources=new Hashtable();
			while(rs10.next())
			{
			  testsources.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
            if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();}
			
			String query= "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.status<>'UI'";
			       query+=" and a.circle_office_code='"+circlecode+"'";
                   query+=" order by circle_office_name ";
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
            //  System.out.println("main qry:"+query);
               boolean flag=false;
			  while(rs.next())
		     {
               flag=true;
	           String ast=""+aht.get(rs.getString(1)+rs.getString(3));
			   if(ast!=null && !ast.equals("") && !ast.equals("null"))
               {
               }
               else
               {
                 ast="0";
               }
	          String hp=""+hpht.get(rs.getString(1)+rs.getString(3));
			  if(hp!=null && !hp.equals("") && !hp.equals("null")){} else{ hp="0";}
			  String open=""+opht.get(rs.getString(1)+rs.getString(3));
			  if(open!=null && !open.equals("") && !open.equals("null")){} else{ open="0";}
			  String shp=""+shpht.get(rs.getString(1)+rs.getString(3));
			  if(shp!=null && !shp.equals("") && !shp.equals("null")){} else{ shp="0";}
			  String pond=""+pondht.get(rs.getString(1)+rs.getString(3));
			  if(pond!=null && !pond.equals("") && !pond.equals("null")){} else{ pond="0";}
			
	          int totdw=Integer.parseInt(ast)+Integer.parseInt(hp)+Integer.parseInt(open)+Integer.parseInt(shp)+Integer.parseInt(pond);
              
              //ftk sources
				String ftk=""+ftkht.get(rs.getString(1)+rs.getString(3));
				if(ftk!=null && !ftk.equals("") && !ftk.equals("null")){} else{ ftk="0";}

                //ftk bt sources
				String ftbk=""+ftkbt.get(rs.getString(1)+rs.getString(3));
				if(ftbk!=null && !ftbk.equals("") && !ftbk.equals("null")){} else{ ftbk="0";}
						 
               //total lab sources
              String ftkcsample=""+water.get(rs.getString(1)+rs.getString(3));
		      if(ftkcsample!=null && !ftkcsample.equals("") && !ftkcsample.equals("null")){} else{ ftkcsample="0";}
		 
              //chemical smaples
               String tsample1=""+testsamples1.get(rs.getString(1)+rs.getString(3));
               if(tsample1!=null && !tsample1.equals("") && !tsample1.equals("null")){} else{ tsample1="0";}
		    
              //bact samples
               String tsample2=""+testsamples2.get(rs.getString(1)+rs.getString(3));
		       if(tsample2!=null && !tsample2.equals("") && !tsample2.equals("null")){} else{ tsample2="0";}
             
             //lab samples results
             String tsample=""+testsamples.get(rs.getString(1)+rs.getString(3));
		     if(tsample!=null && !tsample.equals("") && !tsample.equals("null")){} else{ tsample="0";}
		      
               //sources forwared to lab
             String tsource=""+testsources.get(rs.getString(1)+rs.getString(3));
		     if(tsource!=null && !tsource.equals("") && !tsource.equals("null")){} else{ tsource="0";}

	String notFoundsources=""+nofoundTable.get(rs.getString(1)+rs.getString(3));
      if(notFoundsources==null || notFoundsources.equals("null")){
		notFoundsources="0";
			}

    //srinivas
		String notFoundsourcesb=""+nofoundTableb.get(rs.getString(1)+rs.getString(3));
if(notFoundsourcesb==null || notFoundsourcesb.equals("null")){
	notFoundsourcesb="0";
		}

      
		  %>
	        <tr>
                <%if(flag){%>
		        <td class=rptValue><%=slno++%></td>
		        <td class=rptValue><%=rs.getString(2)%></td>
                <%}else{ %>
                <td class=rptValue></td>
		        <td class=rptValue></td>
                <%}%>
				<td class=rptValue align="right"><%=rs.getString(4)%></td>
				<td class=rptValue align="right"><%=totdw%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)%></td>

				<td class=rptValue align="right"><%=ftk%></td>
				<td class=rptValue align="right"><%=ftbk%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)-Integer.parseInt(ftk)%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundsources)-Integer.parseInt(ftbk)%></td>
			    <td class=rptValue align="right"><%=tsource%></td>            
				<td class=rptValue align="right"><%=tsample1%></td>
				<td class=rptValue align="right"><%=tsample2%></td>
                <%if(!ftkcsample.equals("0")){ %>
                <td class=rptValue align="right"><a href="rws_waterqtly_sources_detailed_rpt.jsp?ccode=<%=rs.getString(1)%>&cname=<%=rs.getString(2)%>&dcode=<%=rs.getString(3)%>&dname=<%=rs.getString(4)%>&mon=<%=month%>&yr=<%=year%>"><%=ftkcsample%></a></td>
				<%}else{ %>
               <td class=rptValue align="right"><%=ftkcsample%></td>
                <%} %>
                <td class=rptValue align="right"><%=tsample%></td>
		    </tr>
          <% 
           totNotFoundContaminated+=Integer.parseInt(notFoundsources);
           totNotFoundContaminatedb+=Integer.parseInt(notFoundsourcesb);
           gtotdw+=totdw;
		   gftk+=Integer.parseInt(ftk);
		   gtsource+=Integer.parseInt(ftbk);
		   gtsample+=Integer.parseInt(tsource);
		   gsample1+=Integer.parseInt(tsample1);
           gsample2+=Integer.parseInt(tsample2);
           gftktot+=Integer.parseInt(ftkcsample);
		   gsample3+=Integer.parseInt(tsample);
		}
		 
		  
		  %>
      <tr>
			<td class="btext" colspan="3">Total:</td>
		    <td class=btext align="right"><%=gtotdw%></td>
			<td class=btext align="right"><%=gftk%></td>
			<td class=btext align="right"><%=gtsource %></td>
		<td class=btext align="right"><%=totNotFoundContaminated %></td>
		<td class=btext align="right"><%=totNotFoundContaminatedb %></td>
			<td class=btext align="right"><%=gtsample %></td>
			<td class=btext align="right"><%=gsample1 %></td>
	
            <td class=btext align="right"><%=gsample2 %></td>
            <td class=btext align="right"><%=gftktot %></td>
			<td class=btext align="right"><%=gsample3%></td>
     </tr> 
		    <%
  flag=false;}    
	
     catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:"+e);
		e.printStackTrace();
	   }
	  
	   %>
</table>
<%}%>
<%if(!circlecode.equals("00") && !divisioncode.equals("00")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	       <table border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.go(-1)">Back| 
                    <a href="rws_waterqtly_sources_rpt_xls.jsp" target="_new">Excel</a>
                 </td>
			</tr>
		 </table>
</caption>
<tr align=center >
		<td class=rptValue colspan="11"><b><font color="blue">WaterQuality Sources Report</font></b></td>
		</tr>
       <tr align=center >
		<td class=rptValue colspan="11"><font color="blue">&nbsp;Circle&nbsp;:&nbsp;<%=circlename%>&nbsp;&nbsp;-&nbsp;&nbsp;Division&nbsp;:&nbsp;<%=divisionname%>&nbsp;&nbsp;-&nbsp;&nbsp;Year&nbsp;:&nbsp;<%=yr%>&nbsp;&nbsp;-&nbsp;&nbsp;Month&nbsp;:&nbsp;<%=mon%></font></td>
		</tr>
		<tr align=center  align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Circle</td>
		<td class=btext>Division</td>
        <td class=btext>Total No.of Sources</td>
        <td class=btext>Total No.of Tested Sources</td>
		<td class=btext>No.of Sources having Field<br>Test-Chemical Results(FTK-C)</td>
        <td class=btext>No.of Sources having Field<br>Test-H2s Vials(FTK-B)</td>
		<td class=btext colspan=2>No.of Sources NotFound Contaminated</td>

       	<td class=btext>No.of Samples Forwarded<br>to the Laboratory(FTK TESTED SOURCES ONLY)</td>
        <td class=btext>No. of Samples having<br>Chemical Test Results</td>
        <td class=btext>No.of Samples having <br>Bacteriological Test Results</td>
        <td class=btext>Total No.of Sources <br>having Laboratory Results</td>
        <td class=btext>Total No.of Samples <br>having Laboratory Results</td>
		</tr>
       <tr align=center>
        <td class=btext>1</td>
        <td class=btext>2</td>
		<td class=btext>3</td>
		<td class=btext>4</td>
		<td class=btext>5</td>
		<td class=btext>6</td>
		<td class=btext>7</td>
		<td class=btext>8(ftk-c)</td>
		<td class=btext>9(ftk-b)</td>
		<td class=btext>10</td>
		<td class=btext>11</td>
        <td class=btext>12</td>
        <td class=btext>13</td>
		</tr>
	<%
       try{  slno=1;
int testtot=0;
             //System.out.println(" Any  circle-Any division");
			//mpws,cpws,pws
			String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE";
            /*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry1+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry1+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry1+=" group by substr(m.hab_code,1,2),m.division_office_code order by 2";
			//System.out.println("qry1:"+qry1);
			
            stmt1=conn.createStatement();
			rs1=stmt1.executeQuery(qry1);
			Hashtable aht=new Hashtable();
			while(rs1.next())
			{
			  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
              ////System.out.println(aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1)));
			}
            if(rs1!=null){rs1.close();}
            if(stmt1!=null){stmt1.close();}
			//hp
			String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";
            /*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry2+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry2+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }	*/		       
            qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt2=conn.createStatement();
			//System.out.println("qry2:"+qry2);
			rs2=stmt2.executeQuery(qry2);
			Hashtable hpht=new Hashtable();
			while(rs2.next())
			 {
			   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
			 }
			 if(rs2!=null){rs2.close();}
            if(stmt2!=null){stmt2.close();}
             //open
			 String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry3+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry3+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }	*/				
            qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt3=conn.createStatement();
			//System.out.println("qry3:"+qry3);
			rs3=stmt3.executeQuery(qry3);
			Hashtable opht=new Hashtable();
			while(rs3.next())
			 {
			   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
			 }
            if(rs3!=null){rs3.close();}
            if(stmt3!=null){stmt3.close();}
			 // shp
			 String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry4+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry4+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/			 	    
			qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt4=conn.createStatement();
		   // System.out.println("qry4:"+qry4);
			rs4=stmt4.executeQuery(qry4);
			Hashtable shpht=new Hashtable();
			while(rs4.next())
			 {
			   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
			 }
            if(rs4!=null){rs4.close();}
            if(stmt4!=null){stmt4.close();}
			//ponds
		    String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry5+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry5+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }		*/ 	     
 			qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
			stmt5=conn.createStatement();
			//System.out.println("qry5:"+qry5);
			rs5=stmt5.executeQuery(qry5);
			Hashtable pondht=new Hashtable();
			while(rs5.next())
			 {
			   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
			 }
            if(rs5!=null){rs5.close();}
            if(stmt5!=null){stmt5.close();}
             //ftk-c sources




			String qry6="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and (ARSENIC ='Y' or NITRATE='Y' or FLORIDE='Y' or SALINITY='Y' or IRON='Y')";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry6+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }				   
            qry6+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt6=conn.createStatement();
			//System.out.println("ftk sources qry6:"+qry6);
			rs6=stmt6.executeQuery(qry6);
			Hashtable ftkht=new Hashtable();
			while(rs6.next())
			{
			  ftkht.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}
              

//ftk-bat sources

  

			String qry8="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and COLIFORM ='Y'";
            if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry8+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry8+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }				   
            qry8+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt8=conn.createStatement();
			//System.out.println("ftk abt sources qry8:"+qry8);
			
rs8=stmt8.executeQuery(qry8);
			Hashtable ftkbt=new Hashtable();
			while(rs8.next())
			{
			  ftkbt.put(rs8.getString(2)+rs8.getString(3),rs8.getString(1));
            }
            if(rs8!=null){rs8.close();}
            if(stmt8!=null){stmt8.close();}







String notFoundContaminated="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16)  ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  notFoundContaminated+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
notFoundContaminated+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

			Statement stmt66=conn.createStatement();
			//System.out.println("notFoundContaminated chemical"+notFoundContaminated);
			ResultSet rs66=stmt66.executeQuery(notFoundContaminated);
			Hashtable nofoundTable=new Hashtable();
			while(rs66.next())
			{
			  nofoundTable.put(rs66.getString(2)+rs66.getString(3),rs66.getString(1));
            }
            if(rs66!=null){rs66.close();}
            if(stmt66!=null){stmt66.close();}



          //code is add by srinivas 
          //Bacteriological 
          String notFoundContaminatedb="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  ( COLIFORM ='N' ) ";

                    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
          			 {
          			  notFoundContaminatedb+=" and to_char(test_date,'MON')='"+month+"' ";
          			 }
          			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
          			 {
          			  notFoundContaminatedb+=" and to_char(test_date,'yyyy')='"+year+"' ";
          			 }
                     notFoundContaminatedb+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2";

          			Statement stmt68=conn.createStatement();
          			//System.out.println("notFoundContaminatedb:"+notFoundContaminatedb);
          			ResultSet rs68=stmt68.executeQuery(notFoundContaminatedb);
          			Hashtable nofoundTableb=new Hashtable();
          			while(rs68.next())
          			{
          			  nofoundTableb.put(rs68.getString(2)+rs68.getString(3),rs68.getString(1));
                      }
                      if(rs68!=null){rs68.close();}
                      if(stmt68!=null){stmt68.close();}

          // end
          
           
            //sources having lab results
			String qry7="select count(distinct c.source_code),substr(hd.panch_code,1,2),c.division_office_code  from rws_water_sample_collect_tbl c,rws_complete_hab_view hd where hd.panch_code=c.hab_code and c.test_id is not null";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry7+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}	
            qry7+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt7=conn.createStatement();
			//System.out.println("3 qry7:"+qry7);
			rs7=stmt7.executeQuery(qry7);
			Hashtable water=new Hashtable();
			while(rs7.next())
			{
			  water.put(rs7.getString(2)+rs7.getString(3),rs7.getString(1));
			}
             if(rs7!=null){rs7.close();}
            if(stmt7!=null){stmt7.close();}
          //chemical sample
          String qryc1="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=1 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
          if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc1+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc1+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}			  	
 			qryc1+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt13=conn.createStatement();
			//System.out.println("qryc1:"+qryc1);
			rs13=stmt13.executeQuery(qryc1);
			Hashtable testsamples1=new Hashtable();
			while(rs13.next())
			{
			  testsamples1.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
            if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}
            //bact sample
			String qryc2="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=2 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qryc2+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qryc2+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}				   
			qryc2+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt11=conn.createStatement();
			//System.out.println("qryc2:"+qryc2);
			rs11=stmt11.executeQuery(qryc2);
			Hashtable testsamples2=new Hashtable();
			while(rs11.next())
			{
			  testsamples2.put(rs11.getString(2)+rs11.getString(3),rs11.getString(1));
			}
            if(rs11!=null){rs11.close();}
            if(stmt11!=null){stmt11.close();}
           //lab samples res
            String qry9="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry9+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry9+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
			}					
            qry9+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt9=conn.createStatement();
			//System.out.println("qry9:"+qry9);
			rs9=stmt9.executeQuery(qry9);
			Hashtable testsamples=new Hashtable();
			while(rs9.next())
			{
			  testsamples.put(rs9.getString(2)+rs9.getString(3),rs9.getString(1));
			}
        if(rs9!=null){rs9.close();}
            if(stmt9!=null){stmt9.close();}

            //lab sources forwared to lab
            String qry10="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and  FORWARD_DATE is not null";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  qry10+=" and to_char(test_date,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  qry10+=" and to_char(test_date,'yyyy')='"+year+"' ";
			 }
			qry10+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt10=conn.createStatement();
			//System.out.println("qry10:"+qry10);
			rs10=stmt10.executeQuery(qry10);
			Hashtable testsources=new Hashtable();
			while(rs10.next())
			{
			  testsources.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();}
			
			String query= "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and b.status<>'UI'";
			       query+=" and a.circle_office_code='"+circlecode+"' and b.division_office_code='"+divisioncode+"'";
                   query+=" order by circle_office_name ";
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
             // System.out.println("main qry:"+query);
               boolean flag=false;
			  while(rs.next())
		     {
               flag=true;

	           String ast=""+aht.get(rs.getString(1)+rs.getString(3));
			   if(ast!=null && !ast.equals("") && !ast.equals("null"))
               {
               }
               else
               {
                 ast="0";
               }
	          String hp=""+hpht.get(rs.getString(1)+rs.getString(3));
			  if(hp!=null && !hp.equals("") && !hp.equals("null")){} else{ hp="0";}
			  String open=""+opht.get(rs.getString(1)+rs.getString(3));
			  if(open!=null && !open.equals("") && !open.equals("null")){} else{ open="0";}
			  String shp=""+shpht.get(rs.getString(1)+rs.getString(3));
			  if(shp!=null && !shp.equals("") && !shp.equals("null")){} else{ shp="0";}
			  String pond=""+pondht.get(rs.getString(1)+rs.getString(3));
			  if(pond!=null && !pond.equals("") && !pond.equals("null")){} else{ pond="0";}
			
	          int totdw=Integer.parseInt(ast)+Integer.parseInt(hp)+Integer.parseInt(open)+Integer.parseInt(shp)+Integer.parseInt(pond);
              
              //ftk sources
				String ftk=""+ftkht.get(rs.getString(1)+rs.getString(3));
				if(ftk!=null && !ftk.equals("") && !ftk.equals("null")){} else{ ftk="0";}

                //ftk bt sources
				String ftbk=""+ftkbt.get(rs.getString(1)+rs.getString(3));
				if(ftbk!=null && !ftbk.equals("") && !ftbk.equals("null")){} else{ ftbk="0";}
						 
               //total lab sources
              String ftkcsample=""+water.get(rs.getString(1)+rs.getString(3));
		      if(ftkcsample!=null && !ftkcsample.equals("") && !ftkcsample.equals("null")){} else{ ftkcsample="0";}
		 
              //chemical smaples
               String tsample1=""+testsamples1.get(rs.getString(1)+rs.getString(3));
               if(tsample1!=null && !tsample1.equals("") && !tsample1.equals("null")){} else{ tsample1="0";}
		    
              //bact samples
               String tsample2=""+testsamples2.get(rs.getString(1)+rs.getString(3));
		       if(tsample2!=null && !tsample2.equals("") && !tsample2.equals("null")){} else{ tsample2="0";}
             
             //lab samples results
             String tsample=""+testsamples.get(rs.getString(1)+rs.getString(3));
		     if(tsample!=null && !tsample.equals("") && !tsample.equals("null")){} else{ tsample="0";}
		      
               //sources forwared to lab
             String tsource=""+testsources.get(rs.getString(1)+rs.getString(3));
		     if(tsource!=null && !tsource.equals("") && !tsource.equals("null")){} else{ tsource="0";}
		  String notFoundSources=""+nofoundTable.get(rs.getString(1)+rs.getString(3));
	if(notFoundSources==null || notFoundSources.equals("null")){
			notFoundSources="0";
		}

    

	//CODE IS ADD BY srinivas
	//Bacteriological (FTK-B)
	String notFoundsourcesb=""+nofoundTableb.get(rs.getString(1)+rs.getString(3));
if(notFoundsourcesb==null || notFoundsourcesb.equals("null")){
notFoundsourcesb="0";
	}
	
	       %>
	        <tr>
                <%if(flag){%>
		        <td class=rptValue><%=slno++%></td>
		        <td class=rptValue><%=rs.getString(2)%></td>
                <%}else{ %>
                <td class=rptValue></td>
		        <td class=rptValue></td>
                <%}%>
				<td class=rptValue align="right"><%=rs.getString(4)%></td>
				<td class=rptValue align="right"><%=totdw%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundSources)%></td>

				<td class=rptValue align="right"><%=ftk%></td>
				<td class=rptValue align="right"><%=ftbk%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundSources)-Integer.parseInt(ftk)%></td>
				<td class=rptValue align="right"><%=Integer.parseInt(notFoundSources)-Integer.parseInt(ftbk)%></td>
			    <td class=rptValue align="right"><%=tsource%></td>            
				<td class=rptValue align="right"><%=tsample1%></td>
				<td class=rptValue align="right"><%=tsample2%></td>
                <%if(!ftkcsample.equals("0")){ %>
                <td class=rptValue align="right"><a href="rws_waterqtly_sources_detailed_rpt.jsp?ccode=<%=rs.getString(1)%>&cname=<%=rs.getString(2)%>&dcode=<%=rs.getString(3)%>&dname=<%=rs.getString(4)%>&mon=<%=month%>&yr=<%=year%>"><%=ftkcsample%></a></td>
				<%}else{ %>
               <td class=rptValue align="right"><%=ftkcsample%></td>
                <%} %>
				<td class=rptValue align="right"><%=tsample%></td>
		    </tr>
          <% 
testtot+=Integer.parseInt(notFoundSources);
           gtotdw+=totdw;
          totNotFoundContaminated+=Integer.parseInt(notFoundSources);
          totNotFoundContaminatedb+=Integer.parseInt(notFoundsourcesb);
		   gftk+=Integer.parseInt(ftk);
		   gtsource+=Integer.parseInt(ftbk);
		   gtsample+=Integer.parseInt(tsource);
		   gsample1+=Integer.parseInt(tsample1);
           gsample2+=Integer.parseInt(tsample2);
           gftktot+=Integer.parseInt(ftkcsample);
		   gsample3+=Integer.parseInt(tsample);
		}
		 
		  
		  %>
      <tr>
			<td class="btext" colspan="3">Total:</td>
		    <td class=btext align="right"><%=gtotdw%></td>
<td class=btext align="right"><%=testtot %></td>
			<td class=btext align="right"><%=gftk%></td>
			<td class=btext align="right"><%=gtsource %></td>
		<td class=btext align="right"><%=totNotFoundContaminated %></td>
		<td class=btext align="right"><%=totNotFoundContaminatedb %></td>
			<td class=btext align="right"><%=gtsample %></td>
			<td class=btext align="right"><%=gsample1 %></td>
	
            <td class=btext align="right"><%=gsample2 %></td>
            <td class=btext align="right"><%=gftktot %></td>
			<td class=btext align="right"><%=gsample3%></td>
     </tr> 
		    <%
  flag=false;   }    
	
     catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:"+e);
		e.printStackTrace();
	   }
	  
	   %>
</table>
<%}%>





<pre align="left"><font color="red">
Note:-Total No. of Drinking Water Sources = Sum ( PWS+MPWS+CPWS+HANDPUMPS+OPENWELLS+PONDS+ SHALLOWHANDPUMPS )
</font></pre>
</body>
</html>

	  