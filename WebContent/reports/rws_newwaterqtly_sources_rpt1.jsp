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


function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
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
		////System.out.println("circlecode"+circlecode);
		session.setAttribute("circlecode",circlecode);
        
        divisioncode=request.getParameter("division");
        //System.out.println("divisioncode"+divisioncode);
        session.setAttribute("divisioncode",divisioncode);
		
        labcode= request.getParameter("lab");
		//(String)session.getAttribute("lbCode");
		sourcecode=request.getParameter("assetType");
		//=(String)session.getAttribute("sCode");

		String year=request.getParameter("year");
		String[] ar=year.split("-");
		String yearStart1=ar[0];
		String yearEnd1=ar[1];
		String yearStart="01/APR/"+yearStart1;
		String yearEnd="31/MAR/"+yearEnd1;
		String ysye=yearStart+"-"+yearEnd;
		//System.out.println("ysye-----"+ysye);
		session.setAttribute("year",ysye);
		
		
        String month=request.getParameter("month");
        
		String mon=request.getParameter("month");
		String yr=request.getParameter("year");
		String typeofsource=request.getParameter("typeofsource");
      // System.out.println("typeofsource"+typeofsource);
       session.setAttribute("typeofsource",typeofsource);
		////System.out.println("yr"+yr);
         
		if(month!=null && !month.equals("") && month.equals("51") || month.equals("0"))
		{
		  mon="ALL";
		}
		if(yr!=null && !yr.equals("") && yr.equals("51") || yr.equals("0"))
		{
		  yr="ALL";
        }
         
         session.setAttribute("month",month);
         session.setAttribute("year",ysye);
         session.setAttribute("mon",mon);
         session.setAttribute("yr",yr);

	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt13=null,stmt133=null,stmt20=null;
    ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs13=null,rs133=null,rs20=null;
	int gtotdw=0,gftk=0,gsample=0,gtsample=0,gtsource=0,gsample1=0,gsample2=0,gftktot=0,gsample3=0;
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
			<td class=rptValue colspan="19"><b><font color="blue">WaterQuality Sources Report</font></b></td>
		</tr>
        <tr align=center  align=center>
			<td class=rptValue colspan="19"><font color="blue">&nbsp;ALL &nbsp;Circles&nbsp;&nbsp;-&nbsp;&nbsp;Divisions&nbsp;:&nbsp;ALL &nbsp;&nbsp;-&nbsp;&nbsp;Financial Year&nbsp;:&nbsp;<%=yr%>&nbsp;&nbsp;-&nbsp;&nbsp;Month&nbsp;:&nbsp;<%=mon%></font></td>
		</tr>
		<tr align=center>
			<td class=btext rowspan=4>Sl.No</td>
			<td class=btext rowspan=4>Circle</td>
			<td class=btext rowspan=4>Division</td>
	        <td class=btext rowspan=4>Total No.of Sources</td>
		</tr>
		<tr>
			<td class=btext  colspan=6 align=center style="background-color:orange;color:white;"><b>Only FTK</b></td>
			<td class=btext colspan=3 align=center rowspan=2 style="background-color:white;color:green;"><b>Forwarded to Lab(FTK)</b></td>
			<td class=btext colspan=7 align=center rowspan=2 style="background-color:green;color:white;"><b>Only Laboratories</b></td>
		</tr>
		<tr>
			<td class=btext  colspan=3 align=center style="background-color:orange;color:white;">Chemical</td>
			<td class=btext colspan=3 align=center style="background-color:orange;color:white;">H2S Vial</td>
		</tr>
		<tr>
			<td class=btext rowspan=1 style="background-color:orange;color:white;">Total No.of Tested Sources</td>
			<td class=btext rowspan=1 style="background-color:orange;color:white;">No.of Sources  Chemically Contaminated</td>
			<td class=btext rowspan=1 style="background-color:orange;color:white;"> No.of Sources  Not Found Contaminated</td>
		 	<td class=btext rowspan=1 style="background-color:orange;color:white;">Total No.of Tested Sources</td>
			<td class=btext rowspan=1 style="background-color:orange;color:white;" >No.of Sources   Contaminated</td>
			<td class=btext rowspan=1 style="background-color:orange;color:white;">No.of Sources  Not Found Contaminated</td>
		 	<td class=btext rowspan=1 style="background-color:white;color:green;" >Total No.of Tested Sources</td>
			<td class=btext rowspan=1 style="background-color:white;color:green;">No.of Sources  Chemically Contaminated</td>
			<td class=btext rowspan=1 style="background-color:white;color:green;">No.of Sources Found H2s Vial Contaminated</td>
		    <td class=btext rowspan=1 style="background-color:green;color:white;">Habitation</td>
		    <td class=btext rowspan=1 style="background-color:green;color:white;" >Total No.of Tested Sources</td>
		 	<td class=btext rowspan=1 style="background-color:green;color:white;">Total No.of Tested Samples</td>
			<td class=btext rowspan=1 style="background-color:green;color:white;">No.of Sources  Found Physico-Chemical Contaminated</td>
			<td class=btext rowspan=1 style="background-color:green;color:white;">No. of Sources with Bacteriological Contaminants <br>(MPN Coliform/100 ml)</td>
			<td class=btext  rowspan=1 style="background-color:green;color:white;">No. of Sources with Bacteriological Contaminants<br>(MPN(E-Coliform)/100ml)</td>
		</tr>
       <tr align=center>
			<td class=btext>1</td>
			<td class=btext>2</td>
			<td class=btext>3</td>
			<td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7<br>(5-6)</td>
			<td class=btext>8</td>
			<td class=btext>9</td>
			<td class=btext>10<br>(8-9)</td>
			<td class=btext>11</td>
			<td class=btext>12</td>
			<td class=btext>13</td>
			<td class=btext>14</td>
			<td class=btext>15</td>
			<td class=btext>16</td>
			<td class=btext>17</td>
			<td class=btext>18</td>
			<td class=btext>19</td>
		</tr>
	<%
       try{  slno=1;
             
       if(typeofsource!=null && typeofsource.equals("51"))
       {
			//mpws,cpws,pws
			String qry1="SELECT COUNT(*), SUBSTR(A.SOURCE_CODE,1,2), M.DIVISION_OFFICE_CODE FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SOURCE_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.HAB_CODE=V.PANCH_CODE AND M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' OR M.TYPE_OF_ASSET_CODE='02' OR M.TYPE_OF_ASSET_CODE='03' OR  M.TYPE_OF_ASSET_CODE='09') AND A.ASSET_CODE=S.ASSET_CODE ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry1+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry1+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry1+="GROUP BY SUBSTR(A.SOURCE_CODE,1,2),M.DIVISION_OFFICE_CODE ORDER BY 2";

          ////System.out.println("mpws,cpws,pws qry1:"+qry1);
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
			String qry2="SELECT COUNT(*), SUBSTR(A.HP_CODE,1,2), M.DIVISION_OFFICE_CODE FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_HP_SUBCOMP_PARAM_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' AND A.ASSET_CODE=S.ASSET_CODE AND M.HAB_CODE=V.PANCH_CODE AND (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' OR SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' OR SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry2+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry2+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }  */
            qry2+="GROUP BY SUBSTR (A.HP_CODE,1,2), M.DIVISION_OFFICE_CODE ORDER BY 2";
			stmt2=conn.createStatement();
	//	System.out.println("hp qry2:"+qry2);
			rs2=stmt2.executeQuery(qry2);
			Hashtable hpht=new Hashtable();
			while(rs2.next())
			 {
			   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
			 }
			 if(rs2!=null){rs2.close();}
            if(stmt2!=null){stmt2.close();}
             //open
			String qry3="SELECT COUNT(*), SUBSTR(A.OPENWELL_CODE,1,2), M.DIVISION_OFFICE_CODE  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_OPEN_WELL_MAST_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry3+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry3+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
			qry3+="GROUP BY SUBSTR (A.OPENWELL_CODE,1,2), M.DIVISION_OFFICE_CODE ORDER BY 2";
			stmt3=conn.createStatement();
			//System.out.println("open qry3:"+qry3);
			rs3=stmt3.executeQuery(qry3);
			Hashtable opht=new Hashtable();
			while(rs3.next())
			 {
			   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
			 }
            if(rs3!=null){rs3.close();}
            if(stmt3!=null){stmt3.close();}
			 // shp
			String qry4="SELECT COUNT(*), SUBSTR (A.SHALLOWHP_CODE,1,2), M.DIVISION_OFFICE_CODE FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry4+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry4+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry4+=" GROUP BY SUBSTR (A.SHALLOWHP_CODE,1,2), M.DIVISION_OFFICE_CODE ORDER BY 2";
			stmt4=conn.createStatement();
	//   System.out.println("shp qry4:"+qry4);
			rs4=stmt4.executeQuery(qry4);
			Hashtable shpht=new Hashtable();
			while(rs4.next())
			 {
			   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
			 }
            if(rs4!=null){rs4.close();}
            if(stmt4!=null){stmt4.close();}
			//ponds
		    String qry5="SELECT COUNT(*), SUBSTR (A.POND_CODE,1,2), M.DIVISION_OFFICE_CODE  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_OPENWELL_POND_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' AND A.ASSET_CODE=S.ASSET_CODE AND V.PANCH_CODE=M.HAB_CODE";
		 	/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry5+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry5+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
            qry5+=" GROUP BY SUBSTR (A.POND_CODE,1,2), M.DIVISION_OFFICE_CODE ORDER BY 2";
			stmt5=conn.createStatement();
			//System.out.println("ponds qry5:"+qry5);
			rs5=stmt5.executeQuery(qry5);
			Hashtable pondht=new Hashtable();
			while(rs5.next())
			 {
			   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
			 }
              if(rs5!=null){rs5.close();}
            if(stmt5!=null){stmt5.close();}
         

    	//Only FTK-1.Tot No Of Tested Sources Chemical

		String q1="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND FIELD_TEST_CHEMICAL ='Y' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q1+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q1+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"' ";
			 }
			q1+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totFtkChem:"+q1);
			rs6=stmt6.executeQuery(q1);
		//System.out.println("totFtkChem:"+q1);
			Hashtable totFtkChem=new Hashtable();
			while(rs6.next())
			{
			  totFtkChem.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
			//System.out.println("totFtkChem"+totFtkChem.size());
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}
           

            String q2="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND FIELD_TEST_CHEMICAL ='Y' AND CONTAMINATION_STATUS='Y'";
	
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q2+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q2+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			 }
			q2+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totFtkChemContamination:"+q2);
			rs6=stmt6.executeQuery(q2);
			Hashtable totFtkChemCon=new Hashtable();
			while(rs6.next())
			{
			  totFtkChemCon.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}



		//Only FTK-3.Tot No Of Tested Sources H2s Vial
		
		String q3="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND H2S_VIAL ='Y' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q3+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q3+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			 }
			q3+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totH2s:"+q3);
			rs6=stmt6.executeQuery(q3);
			Hashtable totFtkH2s=new Hashtable();
			while(rs6.next())
			{
			  totFtkH2s.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}


		String q4="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND H2S_VIAL ='Y' AND CONTAMINATION_STATUS='Y'";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q4+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q4+=" AND TEST_DATE BETWEEN '"+yearStart+"' and '"+yearEnd+"'";
			 }
			q4+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
		//	System.out.println("H2sContamination***************8:"+q4);
			rs6=stmt6.executeQuery(q4);
			Hashtable totFtkH2sCon=new Hashtable();
			while(rs6.next())
			{
			  totFtkH2sCon.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
            }
            if(rs6!=null){rs6.close();}
            if(stmt6!=null){stmt6.close();}




            //lab sources forwared to lab
            String q5="SELECT COUNT(DISTINCT D.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD, RWS_WATER_SAMPLE_COLLECT_TBL D WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND  D.FTK_TEST_ID=C.FTK_TEST_ID  ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q5+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q5+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
				}
            q5+="GROUP BY  SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt10=conn.createStatement();
		//System.out.println("lab sources forwared to lab qry5:"+q5);
			rs10=stmt10.executeQuery(q5);
			Hashtable testFowardTolabsources=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabsources.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
            if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();
            }

  		String q6="SELECT COUNT(DISTINCT E.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD , RWS_WATER_SAMPLE_COLLECT_TBL E, RWS_WQ_TEST_RESULTS_TBL B, RWS_WQ_TEST_RESULTS_LNK_TBL D,RWS_WQ_PARA_TEST_TBL f WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND B.TEST_ID=D.TEST_ID AND E.TEST_ID=B.TEST_ID AND E.FTK_TEST_ID=C.FTK_TEST_ID AND d.TESTING_PARAMETER_CODE=f.TESTING_PARAMETER_CODE AND ((D.TESTING_PARAMETER_CODE='04' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL AND D.TESTING_PARAMETER_VALUE IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='05' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='07' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='12' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='13' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='15' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR (D.TESTING_PARAMETER_CODE='14' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='16' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='06' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL  ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q6+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q6+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
				}
            q6+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt10=conn.createStatement();
			//System.out.println("lab sources forwared to lab qry5:"+q6);
			rs10=stmt10.executeQuery(q6);
			Hashtable testFowardTolabConS=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabConS.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
            if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();}


 	 String q7="select count(distinct e.source_code),substr(hd.panch_code,1,2),c.division_office_co000.de  from rws_ftk_testing_tbl c,rws_complete_hab_view hd ,rws_water_sample_collect_tbl e ,rws_wq_test_results_tbl b,RWS_WQ_TEST_RESULTS_LNK_TBL d,RWS_WQ_PARA_TEST_TBL f  where hd.panch_code=substr(c.source_code,1,16) and b.test_id=d.test_id and  e.test_id=b.test_id and   e.ftk_test_id=c.ftk_test_id and  d.TESTING_PARAMETER_code='01'  and TESTING_PARAMETER_VALUE is not null and my_to_number(TESTING_PARAMETER_VALUE) is not null AND d.TESTING_PARAMETER_CODE=f.TESTING_PARAMETER_CODE AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and  b.test_code=2 ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q7+=" and SAMP_COLLECT_DATE between '"+yearStart+"' and '"+yearEnd+"'";
				}
            q7+="group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
			stmt10=conn.createStatement();
			//System.out.println("lab sources forwared to lab qry7:"+q7);
			rs10=stmt10.executeQuery(q7);
			Hashtable testFowardTolabH2sS=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabH2sS.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
            if(rs10!=null){rs10.close();}
            if(stmt10!=null){stmt10.close();}
            
   	String qry13="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2), A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry13+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry13+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry13+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt13=conn.createStatement();
		//System.out.println("sources having lab results qry13:"+qry13);
			rs13=stmt13.executeQuery(qry13);
			Hashtable sources=new Hashtable();
			while(rs13.next())
			{
			  sources.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
   		if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}        
            
          //add by Srinivas              
            String qry133="SELECT COUNT(DISTINCT PANCH_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry133+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry133+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' and '"+yearEnd+"'";
			}
			qry133+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt133=conn.createStatement();
		//System.out.println("sources having lab results qry13:"+qry133);
			rs133=stmt133.executeQuery(qry133);
			Hashtable sources1=new Hashtable();
			while(rs133.next())
			{
			  sources1.put(rs133.getString(2)+rs133.getString(3),rs133.getString(1));
			}
   		if(rs133!=null){rs133.close();}
            if(stmt133!=null){stmt133.close();}

            
      

	 String qry14="SELECT COUNT(A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry14+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry14+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry14+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry14:"+qry14);
			rs13=stmt13.executeQuery(qry14);
			Hashtable labSamples=new Hashtable();
			while(rs13.next())
			{
			  labSamples.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
 		if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}




 		String qry16="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL D,RWS_WQ_PARA_TEST_TBL F WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND  D.TESTING_PARAMETER_CODE=F.TESTING_PARAMETER_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=1 AND ((D.TESTING_PARAMETER_CODE='04' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL  AND D.TESTING_PARAMETER_VALUE IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='05' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='07' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='12' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='13' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='15' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='14' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='16' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='06' AND to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(F.MAX_PERMISSIBLE_VALUE))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL  AND  TO_NUMBER(TESTING_PARAMETER_VALUE)>TO_NUMBER(F.MAX_PERMISSIBLE_VALUE) ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry16+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' "; 
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry16+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry16+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry16:"+qry16);
			rs13=stmt13.executeQuery(qry16);
			Hashtable phisicalContaminated=new Hashtable();
			while(rs13.next())
			{
			  phisicalContaminated.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
            
            if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}





      String qry15="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL  D WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=2 AND D.TESTING_PARAMETER_CODE='01'  AND TESTING_PARAMETER_VALUE IS NOT NULL AND TESTING_PARAMETER_VALUE>'0' AND TESTING_PARAMETER_VALUE<>'00' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry15+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry15+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry15+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry15:"+qry15);
			rs13=stmt13.executeQuery(qry15);
			Hashtable bactContaminated=new Hashtable();
			while(rs13.next())
			{
			  bactContaminated.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}


            
	if(rs13!=null){rs13.close();}
            if(stmt13!=null){stmt13.close();}


            
            
 		///////////////////////////////////////////for MPN(E-Coliform)/100ml added by anupama on 06072015/////////////          
            String qry20="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL  D WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=2 AND D.TESTING_PARAMETER_CODE='02'  AND TESTING_PARAMETER_VALUE IS NOT NULL AND TESTING_PARAMETER_VALUE>'0' AND TESTING_PARAMETER_VALUE<>'00' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
				qry20+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
				 qry20+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			 qry20+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt20=conn.createStatement();
			//System.out.println("sources having lab results qry15:"+qry20);
			rs20=stmt20.executeQuery(qry20);
			Hashtable bactContamEcoli=new Hashtable();
			while(rs20.next())
			{
				bactContamEcoli.put(rs20.getString(2)+rs20.getString(3),rs20.getString(1));
			}


            
 		if(rs20!=null){rs20.close();}
            if(rs20!=null){rs20.close();}
			
		//////////////////////////////////////	
            
            
            
            
            
			
			
 String dname="";
			String query= "";
if(circlecode!=null && circlecode.equals("00") && divisioncode==null){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE";
}else if(circlecode!=null && !circlecode.equals("00") && divisioncode !=null && !divisioncode.equals("00")){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE='"+circlecode+"' AND B.DIVISION_OFFICE_CODE='"+divisioncode+"'" ;

}
else if(circlecode!=null && !circlecode.equals("00") && divisioncode !=null && divisioncode.equals("00")){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE='"+circlecode+"'" ;

}
			       query+=" ORDER BY A.CIRCLE_OFFICE_CODE,B.DIVISION_OFFICE_CODE ";
             
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
            // System.out.println("main qry:"+query);
               boolean flag=false;
               int j=0;
  int tesTot=0;
int totFTKTestedSources=0,gtotFTKTestedSources=0,totFTKConSources=0,gtotFTKConSources=0,totFTKNotConSources=0,gtotFTKNotConSources=0;
int totH2sTestedSources=0,gtotH2sTestedSources=0,totH2sConSources=0,gtotH2sConSources=0,totH2sNotConSources=0,gtotH2snotConSources=0;
int totlabForSources=0,gtotlabForSources=0;
int totlabTestedSources=0,totlabTestedSources1=0,gtotlabTestedSources1=0,gtotlabTestedSources=0,totlabTestedSamples=0,gtotlabTestedSamples=0,gtottotbactEcol=0;
int totbactContaminated=0,gtotbactContaminated=0,totphisicoChemical=0,gtotphisicoChemical=0,totbactEcol=0;
int labForwardConSources=0,glabForwardConSources=0,labForwardH2sSources=0,glabForwardH2sSources=0;


			  while(rs.next())
		     {
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
              
          
          if(totFtkChem.get(rs.getString(1)+rs.getString(3))!=null){
			totFTKTestedSources=Integer.parseInt((String)totFtkChem.get(rs.getString(1)+rs.getString(3)));
				}

          if(totFtkChemCon.get(rs.getString(1)+rs.getString(3))!=null){
			totFTKConSources=Integer.parseInt((String)totFtkChemCon.get(rs.getString(1)+rs.getString(3)));
				}

 if(totFtkH2s.get(rs.getString(1)+rs.getString(3))!=null){
			totH2sTestedSources=Integer.parseInt((String)totFtkH2s.get(rs.getString(1)+rs.getString(3)));
				}

 if(totFtkH2sCon.get(rs.getString(1)+rs.getString(3))!=null){
			totH2sConSources=Integer.parseInt((String)totFtkH2sCon.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabsources.get(rs.getString(1)+rs.getString(3))!=null){
			totlabForSources=Integer.parseInt((String)testFowardTolabsources.get(rs.getString(1)+rs.getString(3)));
				}
if(sources.get(rs.getString(1)+rs.getString(3))!=null){
			totlabTestedSources=Integer.parseInt((String)sources.get(rs.getString(1)+rs.getString(3)));
				}

//add by Srinivas

if(sources1.get(rs.getString(1)+rs.getString(3))!=null){
	totlabTestedSources1=Integer.parseInt((String)sources1.get(rs.getString(1)+rs.getString(3)));
		}

//end

if(labSamples.get(rs.getString(1)+rs.getString(3))!=null){
			totlabTestedSamples=Integer.parseInt((String)labSamples.get(rs.getString(1)+rs.getString(3)));
				}


if(bactContaminated.get(rs.getString(1)+rs.getString(3))!=null){
			totbactContaminated=Integer.parseInt((String)bactContaminated.get(rs.getString(1)+rs.getString(3)));
				}


if(bactContamEcoli.get(rs.getString(1)+rs.getString(3))!=null)
{
	totbactEcol=Integer.parseInt((String)bactContamEcoli.get(rs.getString(1)+rs.getString(3)));
	}

if(phisicalContaminated.get(rs.getString(1)+rs.getString(3))!=null){
			totphisicoChemical=Integer.parseInt((String)phisicalContaminated.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabConS.get(rs.getString(1)+rs.getString(3))!=null){
			labForwardConSources=Integer.parseInt((String)testFowardTolabConS.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabH2sS.get(rs.getString(1)+rs.getString(3))!=null){
			labForwardH2sSources=Integer.parseInt((String)testFowardTolabH2sS.get(rs.getString(1)+rs.getString(3)));
				}

					



					totFTKNotConSources=totFTKTestedSources-totFTKConSources;
					totH2sNotConSources=totH2sTestedSources-totH2sConSources;
					
					
	       %>
	        <tr>
          
		        <td class=rptLabel><%=slno++%></td>
		        <% 
if(!dname.equals(rs.getString(2))){
dname=rs.getString(2);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
				<td class=rptLabel><%=rs.getString(4)%></td>				
				<td class=rptValue align="right"><%=totdw%></td>				
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_totsourceche_rpt1.jsp?circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totFTKTestedSources %></td>
				<td class=rptValue align="right"><%=totFTKConSources %></td>
				<td class=rptValue align="right"><%=totFTKNotConSources %></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_totsourceh2s_rpt1.jsp?circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totH2sTestedSources %></td>
				<td class=rptValue align="right"><%=totH2sConSources %></td>
			    <td class=rptValue align="right"><%=totH2sNotConSources %></td>            
				<td class=rptValue align="right"><%=totlabForSources %></td>
				<td class=rptValue align="right"><%=labForwardConSources %></td>  
                <td class=rptValue align="right"><%=labForwardH2sSources %></td>
                <!-- drill jsp in habs rws_WQ_drill_Hab_rpt.jsp?circleofficecode -->
                <td class=rptValue align="right"><%=totlabTestedSources1%></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_HAB_rpt1.jsp?circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totlabTestedSources %></td>
				<td class=rptValue align="right"><%=totlabTestedSamples %></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=PCC&dcode=<%=rs.getString(1)%>&typeofsource=<%=typeofsource%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totphisicoChemical%></a></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=MPNC&dcode=<%=rs.getString(1)%>&typeofsource=<%=typeofsource%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totbactContaminated%></a></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=MPNE&dcode=<%=rs.getString(1)%>&typeofsource=<%=typeofsource%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totbactEcol%></a></td>
		    </tr>
          <% 
gtotdw+=totdw;
			
gtotFTKTestedSources+=totFTKTestedSources;
gtotFTKConSources+=totFTKConSources;
gtotFTKNotConSources+=totFTKNotConSources;
gtotH2sTestedSources+=totH2sTestedSources;
gtotH2sConSources+=totH2sConSources;
gtotH2snotConSources+=totH2sNotConSources;
gtotlabForSources+=totlabForSources;
gtotlabTestedSources+=totlabTestedSources;
gtotlabTestedSamples+=totlabTestedSamples;
gtotbactContaminated+=totbactContaminated;
gtotphisicoChemical+=totphisicoChemical;
glabForwardConSources+=labForwardConSources;
glabForwardH2sSources+=labForwardH2sSources;
gtotlabTestedSources1+=totlabTestedSources1;
gtottotbactEcol+=totbactEcol;
totlabTestedSources1=0;
totlabForSources=0;
totbactContaminated=0;
totH2sNotConSources=0;
totlabTestedSamples=0;
totFTKTestedSources=0;totFTKConSources=0;
totH2sTestedSources=0;totH2sConSources=0;
totFTKNotConSources=0;totH2sNotConSources=0;
totlabTestedSources=0;totphisicoChemical=0;
labForwardConSources=0;
labForwardH2sSources=0;
totbactEcol=0;
		}
		  %>
      <tr>
			<td class="btext" colspan="3">Total:</td>
		    <td class=btext align="right"><%=gtotdw%></td>
   <td class=btext align="right"><%=gtotFTKTestedSources %></td>
			<td class=btext align="right"><%=gtotFTKConSources%></td>
			<td class=btext align="right"><%=gtotFTKNotConSources %></td>
 <td class=btext align="right"><%=gtotH2sTestedSources %></td>
  <td class=btext align="right"><%=gtotH2sConSources %></td>
			<td class=btext align="right"><%=gtotH2snotConSources %></td>
			<td class=btext align="right"><%=gtotlabForSources %></td>
         
            <td class=btext align="right"><%=glabForwardConSources %></td>
            <td class=btext align="right"><%=glabForwardH2sSources %></td>
              <td class=btext align="right"><%=gtotlabTestedSources1%></td>
            
			<td class=btext align="right"><%=gtotlabTestedSources%></td>
			<td class=btext align="right"><%=gtotlabTestedSamples%></td>
			<td class=btext align="right"><%=gtotphisicoChemical %></td>
			<td class=btext align="right"><%=gtotbactContaminated %></td>
			<td class=btext align="right"><%=gtottotbactEcol%></td>


     </tr> 
		    <%
  flag=false;   }
       else
       {
    	   String qry1="SELECT COUNT(*),SUBSTR(A.SOURCE_CODE,1,2),M.DIVISION_OFFICE_CODE FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SOURCE_TBL A, RWS_COMPLETE_HAB_VIEW V WHERE M.HAB_CODE=V.PANCH_CODE AND M.ASSET_CODE=A.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' OR M.TYPE_OF_ASSET_CODE='02' OR M.TYPE_OF_ASSET_CODE='03' OR  M.TYPE_OF_ASSET_CODE='09') AND A.ASSET_CODE=S.ASSET_CODE ";
			/*if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		    {
			 qry1+=" and to_char(date_creation,'MON')='"+month+"' ";
		    }
		    if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
		    {
			qry1+=" and to_char(date_creation,'yyyy')='"+year+"' ";
		    }*/
           qry1+="GROUP BY SUBSTR(A.SOURCE_CODE,1,2),M.DIVISION_OFFICE_CODE ORDER BY 2";

         ////System.out.println("mpws,cpws,pws qry1:"+qry1);
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

			

   //Only FTK-1.Tot No Of Tested Sources Chemical

String q1="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND FIELD_TEST_CHEMICAL ='Y' AND SUBSTR(SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q1+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q1+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"' ";
			 }
			q1+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totFtkChem:"+q1);
			rs6=stmt6.executeQuery(q1);
			//System.out.println("totFtkChem:"+q1);
			Hashtable totFtkChem=new Hashtable();
			while(rs6.next())
			{
			  totFtkChem.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
           }
			//System.out.println("totFtkChem"+totFtkChem.size());
           if(rs6!=null){rs6.close();}
           if(stmt6!=null){stmt6.close();}
          

           String q2="SELECT COUNT(DISTINCT C.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2), C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C, RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND FIELD_TEST_CHEMICAL ='Y' AND CONTAMINATION_STATUS='Y' AND SUBSTR(SOURCE_CODE,20,2)='SO'";
	
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q2+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q2+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			 }
			q2+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totFtkChemContamination:"+q2);
			rs6=stmt6.executeQuery(q2);
			Hashtable totFtkChemCon=new Hashtable();
			while(rs6.next())
			{
			  totFtkChemCon.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
           }
           if(rs6!=null){rs6.close();}
           if(stmt6!=null){stmt6.close();}



//Only FTK-3.Tot No Of Tested Sources H2s Vial

String q3="SELECT COUNT(DISTINCT C.SOURCE_CODE),SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND H2S_VIAL ='Y' AND SUBSTR(SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q3+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q3+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			 }
			q3+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("totH2s:"+q3);
			rs6=stmt6.executeQuery(q3);
			Hashtable totFtkH2s=new Hashtable();
			while(rs6.next())
			{
			  totFtkH2s.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
           }
           if(rs6!=null){rs6.close();}
           if(stmt6!=null){stmt6.close();}


String q4="SELECT COUNT(DISTINCT C.SOURCE_CODE),SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND H2S_VIAL ='Y' AND CONTAMINATION_STATUS='Y' AND SUBSTR(SOURCE_CODE,20,2)='SO'";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q4+=" AND TO_CHAR(TEST_DATE,'MON')='"+month+"' ";
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q4+=" AND TEST_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			 }
			q4+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt6=conn.createStatement();
			//System.out.println("H2sContamination***************8:"+q4);
			rs6=stmt6.executeQuery(q4);
			Hashtable totFtkH2sCon=new Hashtable();
			while(rs6.next())
			{
			  totFtkH2sCon.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
           }
           if(rs6!=null){rs6.close();}
           if(stmt6!=null){stmt6.close();}




           //lab sources forwared to lab
           String q5="SELECT COUNT(DISTINCT D.SOURCE_CODE), SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD ,RWS_WATER_SAMPLE_COLLECT_TBL D WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND  D.FTK_TEST_ID=C.FTK_TEST_ID AND SUBSTR(C.SOURCE_CODE,20,2)='SO' ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q5+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q5+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
				}
           q5+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt10=conn.createStatement();
		//System.out.println("lab sources forwared to lab qry5:"+q5);
			rs10=stmt10.executeQuery(q5);
			Hashtable testFowardTolabsources=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabsources.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
           if(rs10!=null){rs10.close();}
           if(stmt10!=null){stmt10.close();}


 String q6="SELECT COUNT(DISTINCT E.SOURCE_CODE),SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD ,RWS_WATER_SAMPLE_COLLECT_TBL E ,RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_TEST_RESULTS_LNK_TBL  D  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND B.TEST_ID=D.TEST_ID AND  E.TEST_ID=B.TEST_ID AND   E.FTK_TEST_ID=C.FTK_TEST_ID AND  ((D.TESTING_PARAMETER_CODE='04' AND D.TESTING_PARAMETER_VALUE >8.5 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL  AND D.TESTING_PARAMETER_VALUE IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='05' AND D.TESTING_PARAMETER_VALUE >2000 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='07' AND D.TESTING_PARAMETER_VALUE >600 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='12' AND D.TESTING_PARAMETER_VALUE >1000 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='13' AND D.TESTING_PARAMETER_VALUE >1.5 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='15' AND D.TESTING_PARAMETER_VALUE >45 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='14' AND D.TESTING_PARAMETER_VALUE >400 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='16' AND D.TESTING_PARAMETER_VALUE >1.0 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='06' AND D.TESTING_PARAMETER_VALUE >600 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL AND SUBSTR(C.SOURCE_CODE,20,2)='SO' ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q6+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q6+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
				}
           q6+=" GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt10=conn.createStatement();
			//System.out.println("lab sources forwared to lab qry5:"+q6);
			rs10=stmt10.executeQuery(q6);
			Hashtable testFowardTolabConS=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabConS.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
           if(rs10!=null){rs10.close();}
           if(stmt10!=null){stmt10.close();}


 String q7="SELECT COUNT(DISTINCT E.SOURCE_CODE),SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  FROM RWS_FTK_TESTING_TBL C,RWS_COMPLETE_HAB_VIEW HD ,RWS_WATER_SAMPLE_COLLECT_TBL E ,RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_TEST_RESULTS_LNK_TBL  D  WHERE HD.PANCH_CODE=SUBSTR(C.SOURCE_CODE,1,16) AND B.TEST_ID=D.TEST_ID AND  E.TEST_ID=B.TEST_ID AND   E.FTK_TEST_ID=C.FTK_TEST_ID AND  D.TESTING_PARAMETER_CODE='01'  AND TESTING_PARAMETER_VALUE IS NOT NULL AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL AND   D.TESTING_PARAMETER_VALUE >'10' AND SUBSTR(C.SOURCE_CODE,20,2)='SO'  ";
		    if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
				{
				  q7+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
				}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
				{
			     q7+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
				}
           q7+="GROUP BY  SUBSTR(HD.PANCH_CODE,1,2),C.DIVISION_OFFICE_CODE  ORDER BY 2 ";
			stmt10=conn.createStatement();
			//System.out.println("lab sources forwared to lab qry7:"+q7);
			rs10=stmt10.executeQuery(q7);
			Hashtable testFowardTolabH2sS=new Hashtable();
			while(rs10.next())
			{
			  testFowardTolabH2sS.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
           if(rs10!=null){rs10.close();}
           if(stmt10!=null){stmt10.close();}




  String qry13="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND SUBSTR(A.SOURCE_CODE,20,2)='SO'";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
// 			  qry13+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry13+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry13+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
		System.out.println("sources having lab results qry13:"+qry13);
			rs13=stmt13.executeQuery(qry13);
			Hashtable sources=new Hashtable();
			while(rs13.next())
			{
			  sources.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
  if(rs13!=null){rs13.close();}
           if(stmt13!=null){stmt13.close();}
           
           
         //add by Srinivas  
           
           String qry133="SELECT COUNT(DISTINCT PANCH_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND SUBSTR(A.SOURCE_CODE,20,2)='SO'";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry133+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry133+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry133+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt133=conn.createStatement();
		//System.out.println("sources having lab results qry13:"+qry133);
			rs133=stmt133.executeQuery(qry133);
			Hashtable sources1=new Hashtable();
			while(rs133.next())
			{
			  sources1.put(rs133.getString(2)+rs133.getString(3),rs133.getString(1));
			}
  if(rs133!=null){rs133.close();}
           if(stmt133!=null){stmt133.close();}

           
     

String qry14="SELECT COUNT(A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND SUBSTR(A.SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry14+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry14+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry14+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry14:"+qry14);
			rs13=stmt13.executeQuery(qry14);
			Hashtable labSamples=new Hashtable();
			while(rs13.next())
			{
			  labSamples.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
if(rs13!=null){rs13.close();}
           if(stmt13!=null){stmt13.close();}




String qry16="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL  D WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=1 AND ((D.TESTING_PARAMETER_CODE='04' AND D.TESTING_PARAMETER_VALUE >8.5 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL  AND D.TESTING_PARAMETER_VALUE IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='05' AND D.TESTING_PARAMETER_VALUE >2000 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='07' AND D.TESTING_PARAMETER_VALUE >600 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='12' AND D.TESTING_PARAMETER_VALUE >1000 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='13' AND D.TESTING_PARAMETER_VALUE >1.5 AND  MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='15' AND D.TESTING_PARAMETER_VALUE >45 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='14' AND D.TESTING_PARAMETER_VALUE >400 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='16' AND D.TESTING_PARAMETER_VALUE >1.0 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL) OR  (D.TESTING_PARAMETER_CODE='06' AND D.TESTING_PARAMETER_VALUE >600 AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL))  AND MY_TO_NUMBER(TESTING_PARAMETER_VALUE) IS NOT NULL AND SUBSTR(A.SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry16+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' "; 
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry16+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry16+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			//System.out.println("sources having lab results qry16:"+qry16);
			rs13=stmt13.executeQuery(qry16);
			Hashtable phisicalContaminated=new Hashtable();
			while(rs13.next())
			{
			  phisicalContaminated.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}
           
           if(rs13!=null){rs13.close();}
           if(stmt13!=null){stmt13.close();}





     String qry15="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL  D WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=2 AND D.TESTING_PARAMETER_CODE='01'  AND TESTING_PARAMETER_VALUE IS NOT NULL AND TESTING_PARAMETER_VALUE>'0' AND TESTING_PARAMETER_VALUE<>'00'  AND SUBSTR(A.SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
			  qry15+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
			   qry15+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			qry15+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt13=conn.createStatement();
			System.out.println("SOURCES HAVING LAB RESULTS QRY15:"+qry15);
			rs13=stmt13.executeQuery(qry15);
			Hashtable bactContaminated=new Hashtable();
			while(rs13.next())
			{
			  bactContaminated.put(rs13.getString(2)+rs13.getString(3),rs13.getString(1));
			}


           
           if(rs13!=null){rs13.close();}
           if(stmt13!=null){stmt13.close();}


           
           
///////////////////////////////////////////for MPN(E-Coliform)/100ml added by anupama on 06072015/////////////          
           String qry20="SELECT COUNT(DISTINCT A.SOURCE_CODE),SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL A,RWS_WQ_TEST_RESULTS_TBL B,RWS_COMPLETE_HAB_VIEW C,RWS_WQ_TEST_RESULTS_LNK_TBL  D WHERE C.PANCH_CODE=A.HAB_CODE AND A.SOURCE_CODE=B.SOURCE_CODE AND A.TEST_ID=B.TEST_ID AND  A.TEST_ID=D.TEST_ID AND B.TEST_CODE=2 AND D.TESTING_PARAMETER_CODE='02'  AND TESTING_PARAMETER_VALUE IS NOT NULL AND   TESTING_PARAMETER_VALUE>'0' AND TESTING_PARAMETER_VALUE<>'00' AND SUBSTR(A.SOURCE_CODE,20,2)='SO' ";
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
				qry20+=" AND TO_CHAR(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			{
				 qry20+=" AND SAMP_COLLECT_DATE BETWEEN '"+yearStart+"' AND '"+yearEnd+"'";
			}
			 qry20+=" GROUP BY  SUBSTR(C.PANCH_CODE,1,2),A.DIVISION_OFFICE_CODE  ORDER BY 2 ";

			stmt20=conn.createStatement();
			//System.out.println("sources having lab results qry15:"+qry20);
			rs20=stmt20.executeQuery(qry20);
			Hashtable bactContamEcoli=new Hashtable();
			while(rs20.next())
			{
				bactContamEcoli.put(rs20.getString(2)+rs20.getString(3),rs20.getString(1));
			}


           
if(rs20!=null){rs20.close();}
           if(rs20!=null){rs20.close();}
			
		//////////////////////////////////////	
           
           
           
           
           
			
			
String dname="";
			String query= "";
if(circlecode!=null && circlecode.equals("00") && divisioncode==null){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE";
}else if(circlecode!=null && !circlecode.equals("00") && divisioncode !=null && !divisioncode.equals("00")){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE='"+circlecode+"' AND B.DIVISION_OFFICE_CODE='"+divisioncode+"'" ;

}
else if(circlecode!=null && !circlecode.equals("00") && divisioncode !=null && divisioncode.equals("00")){
query="SELECT A.CIRCLE_OFFICE_CODE,A.CIRCLE_OFFICE_NAME,B.DIVISION_OFFICE_CODE, B.DIVISION_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL A,RWS_DIVISION_OFFICE_TBL B WHERE B.STATUS<>'UI' AND A.CIRCLE_OFFICE_CODE=B.CIRCLE_OFFICE_CODE AND A.CIRCLE_OFFICE_CODE='"+circlecode+"'" ;

}
			       query+=" ORDER BY A.CIRCLE_OFFICE_CODE,B.DIVISION_OFFICE_CODE ";
            
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(query);
            //System.out.println("main qry:"+query);
              boolean flag=false;
              int j=0;
 int tesTot=0;
int totFTKTestedSources=0,gtotFTKTestedSources=0,totFTKConSources=0,gtotFTKConSources=0,totFTKNotConSources=0,gtotFTKNotConSources=0;
int totH2sTestedSources=0,gtotH2sTestedSources=0,totH2sConSources=0,gtotH2sConSources=0,totH2sNotConSources=0,gtotH2snotConSources=0;
int totlabForSources=0,gtotlabForSources=0;
int totlabTestedSources=0,totlabTestedSources1=0,gtotlabTestedSources1=0,gtotlabTestedSources=0,totlabTestedSamples=0,gtotlabTestedSamples=0,gtottotbactEcol=0;
int totbactContaminated=0,gtotbactContaminated=0,totphisicoChemical=0,gtotphisicoChemical=0,totbactEcol=0;
int labForwardConSources=0,glabForwardConSources=0,labForwardH2sSources=0,glabForwardH2sSources=0;


			  while(rs.next())
		     {
              String ast=""+aht.get(rs.getString(1)+rs.getString(3));
			   if(ast!=null && !ast.equals("") && !ast.equals("null"))
              {
              }
              else
              {
                ast="0";
              }
	          
			
	          int totdw=Integer.parseInt(ast);
             
         
         if(totFtkChem.get(rs.getString(1)+rs.getString(3))!=null){
			totFTKTestedSources=Integer.parseInt((String)totFtkChem.get(rs.getString(1)+rs.getString(3)));
				}

         if(totFtkChemCon.get(rs.getString(1)+rs.getString(3))!=null){
			totFTKConSources=Integer.parseInt((String)totFtkChemCon.get(rs.getString(1)+rs.getString(3)));
				}

if(totFtkH2s.get(rs.getString(1)+rs.getString(3))!=null){
			totH2sTestedSources=Integer.parseInt((String)totFtkH2s.get(rs.getString(1)+rs.getString(3)));
				}

if(totFtkH2sCon.get(rs.getString(1)+rs.getString(3))!=null){
			totH2sConSources=Integer.parseInt((String)totFtkH2sCon.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabsources.get(rs.getString(1)+rs.getString(3))!=null){
			totlabForSources=Integer.parseInt((String)testFowardTolabsources.get(rs.getString(1)+rs.getString(3)));
				}
if(sources.get(rs.getString(1)+rs.getString(3))!=null){
			totlabTestedSources=Integer.parseInt((String)sources.get(rs.getString(1)+rs.getString(3)));
				}

//add by Srinivas

if(sources1.get(rs.getString(1)+rs.getString(3))!=null){
	totlabTestedSources1=Integer.parseInt((String)sources1.get(rs.getString(1)+rs.getString(3)));
		}

//end

if(labSamples.get(rs.getString(1)+rs.getString(3))!=null){
			totlabTestedSamples=Integer.parseInt((String)labSamples.get(rs.getString(1)+rs.getString(3)));
				}


if(bactContaminated.get(rs.getString(1)+rs.getString(3))!=null){
			totbactContaminated=Integer.parseInt((String)bactContaminated.get(rs.getString(1)+rs.getString(3)));
				}


if(bactContamEcoli.get(rs.getString(1)+rs.getString(3))!=null)
{
	totbactEcol=Integer.parseInt((String)bactContamEcoli.get(rs.getString(1)+rs.getString(3)));
	}

if(phisicalContaminated.get(rs.getString(1)+rs.getString(3))!=null){
			totphisicoChemical=Integer.parseInt((String)phisicalContaminated.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabConS.get(rs.getString(1)+rs.getString(3))!=null){
			labForwardConSources=Integer.parseInt((String)testFowardTolabConS.get(rs.getString(1)+rs.getString(3)));
				}
if(testFowardTolabH2sS.get(rs.getString(1)+rs.getString(3))!=null){
			labForwardH2sSources=Integer.parseInt((String)testFowardTolabH2sS.get(rs.getString(1)+rs.getString(3)));
				}

					



					totFTKNotConSources=totFTKTestedSources-totFTKConSources;
					totH2sNotConSources=totH2sTestedSources-totH2sConSources;
					
					
	       %>
	        <tr>
         
		        <td class=rptLabel><%=slno++%></td>
		        <% 
			if(!dname.equals(rs.getString(2))){
			dname=rs.getString(2);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
				<td class=rptLabel><%=rs.getString(4)%></td>				
				<td class=rptValue align="right"><%=totdw%></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_totsourceche_rpt1.jsp?typeofsource=01&circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totFTKTestedSources %></td>
				<td class=rptValue align="right"><%=totFTKConSources %></td>
				<td class=rptValue align="right"><%=totFTKNotConSources %></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_totsourceh2s_rpt1.jsp?typeofsource=01&circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totH2sTestedSources %></td>
				<td class=rptValue align="right"><%=totH2sConSources %></td>
			    <td class=rptValue align="right"><%=totH2sNotConSources %></td>            
				<td class=rptValue align="right"><%=totlabForSources %></td>
				<td class=rptValue align="right"><%=labForwardConSources %></td>   
              	<td class=rptValue align="right"><%=labForwardH2sSources %></td>
              	<!-- drill jsp in habs rws_WQ_drill_Hab_rpt.jsp?circleofficecode -->
           		<td class=rptValue align="right"><%=totlabTestedSources1%></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newWQ_drill_HAB_rpt1.jsp?typeofsource=01&circleofficecode=<%=rs.getString(1)%>&divisionofficecode=<%=rs.getString(3)%>&cname=<%=rs.getString(2)%>&divname=<%=rs.getString(4) %>')"><%=totlabTestedSources %></td>
				<td class=rptValue align="right"><%=totlabTestedSamples %></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=PCC&typeofsource=<%=typeofsource%>&dcode=<%=rs.getString(1)%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totphisicoChemical%></a></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=MPNC&typeofsource=<%=typeofsource%>&dcode=<%=rs.getString(1)%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totbactContaminated%></a></td>
				<td class=rptValue align="right"><a href="#" onclick="viewWorks('rws_newwqtly_sources_drill1.jsp?mode=MPNE&typeofsource=<%=typeofsource%>&dcode=<%=rs.getString(1)%>&division=<%=rs.getString(3)%>&month=<%=month%>&startyear=<%=yearStart%>&endyear=<%=yearEnd%>&dname=<%=dname%>&divname=<%=rs.getString(4)%>')"><%=totbactEcol%></a></td>

		    </tr>
         <% 
gtotdw+=totdw;
			
gtotFTKTestedSources+=totFTKTestedSources;
gtotFTKConSources+=totFTKConSources;
gtotFTKNotConSources+=totFTKNotConSources;
gtotH2sTestedSources+=totH2sTestedSources;
gtotH2sConSources+=totH2sConSources;
gtotH2snotConSources+=totH2sNotConSources;
gtotlabForSources+=totlabForSources;
gtotlabTestedSources+=totlabTestedSources;
gtotlabTestedSamples+=totlabTestedSamples;
gtotbactContaminated+=totbactContaminated;
gtotphisicoChemical+=totphisicoChemical;
glabForwardConSources+=labForwardConSources;
glabForwardH2sSources+=labForwardH2sSources;
gtotlabTestedSources1+=totlabTestedSources1;
gtottotbactEcol+=totbactEcol;
totlabTestedSources1=0;
totlabForSources=0;
totbactContaminated=0;
totH2sNotConSources=0;
totlabTestedSamples=0;
totFTKTestedSources=0;totFTKConSources=0;
totH2sTestedSources=0;totH2sConSources=0;
totFTKNotConSources=0;totH2sNotConSources=0;
totlabTestedSources=0;totphisicoChemical=0;
labForwardConSources=0;
labForwardH2sSources=0;
totbactEcol=0;
		}
		  %>
     <tr>
			<td class="btext" colspan="3">Total:</td>
		    <td class=btext align="right"><%=gtotdw%></td>
  			<td class=btext align="right"><%=gtotFTKTestedSources %></td>
			<td class=btext align="right"><%=gtotFTKConSources%></td>
			<td class=btext align="right"><%=gtotFTKNotConSources %></td>
			<td class=btext align="right"><%=gtotH2sTestedSources %></td>
 			<td class=btext align="right"><%=gtotH2sConSources %></td>
			<td class=btext align="right"><%=gtotH2snotConSources %></td>
			<td class=btext align="right"><%=gtotlabForSources %></td>
        
           	<td class=btext align="right"><%=glabForwardConSources %></td>
           	<td class=btext align="right"><%=glabForwardH2sSources %></td>
            <td class=btext align="right"><%=gtotlabTestedSources1%></td>
           
			<td class=btext align="right"><%=gtotlabTestedSources%></td>
			<td class=btext align="right"><%=gtotlabTestedSamples%></td>
			<td class=btext align="right"><%=gtotphisicoChemical %></td>
			<td class=btext align="right"><%=gtotbactContaminated %></td>
			<td class=btext align="right"><%=gtottotbactEcol%></td>


    </tr> 
    <%
       }
       
       
       }
	
	
	
	
	
     catch(Exception e)
	   {
	    System.out.println("exception in waterqtly report:");
        	//e.printStackTrace();
	   }
	  
	   %>
</table>

<pre align="left"><font color="red">
Note:-Total No. of Drinking Water Sources = Sum ( PWS+MPWS+CPWS+HANDPUMPS+OPENWELLS+PONDS+ SHALLOWHANDPUMPS )
</font></pre>
</body>
</html>
	  