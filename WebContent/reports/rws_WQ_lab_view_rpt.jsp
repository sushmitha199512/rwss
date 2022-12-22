<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp"%>
<form>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();


ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs7=null,rr=null,rr1=null;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,st=null,sst1=null;
int tSOurces=0,otherCount=0;
int sno=1,bactCount=0,multiExcessPar=0;
int totalnitcount=0,totironCount=0,totfloridCount=0,tottdsCount=0,totnitrateCoount=0,totbactCount=0,totmultiExcessPar=0,totOtherCount=0;
String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
String dcode=request.getParameter("district");
String dname=request.getParameter("dname");
session.setAttribute("dname",dname);
session.setAttribute("fromdate",fromdate);
session.setAttribute("todate",todate);
int tnofSources=0,totalTestedSources=0;
int totalnfound=0,cnt=0;
int totalhardcoount=0;
double testValue=0;
HashMap results=new HashMap();
%>

 <font color="red"><b>Note: </b> Sources type:OpenWells,Ponds,Shallow
Handpumps,Hand Pumps,OHSR,GLBR,GLSR</font>
<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	<caption>
	<table border=0 rules=none style="border-collapse:collapse"
		align="right">


			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|
		| </a></td><td class="bwborder"><a href="./rws_WQ_lab_view_excel.jsp" target="_new">Excel
		| </a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>


		<tr align="right">
			<td class="bwborder"></td>
		</tr>
	</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"><%=dname %>
		DISTRICT WATER QUALITY PROFILE FOR LAB TESTING ---- <%=fromdate %> To
		<%=todate %></td>
	</tr>


</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>Mandal</td>
		<td class=btext rowspan=2>Total No Of Sources</td>
		<td class=btext rowspan=2>No Of Sources Tested</td>
		<td class=btext colspan=6 nowrap>No.of Sources with Single Excess
		Chemical Contaminants</td>
		<td class=btext rowspan=2>No. of Sources with Bacteriological
		Contaminants (Faecal Coliform)</td>
<td class=btext rowspan=2>No. of Sources with Multiple Excess
		Contaminants</td>
<!-- 		<td class=btext rowspan=2>No.of Sources with other Contaminants</td>   -->


	</tr>
	<tr>
		<td class=btext>IRON</td>
		<td class=btext>FLUORIDE</td>
		<td class=btext>TDS</td>
		<td class=btext>NITRATE</td>
		<td class=btext>Salinity</td>
		<td class=btext>OTHER<br>(Alkalinity<br>Chlorides<br>Sulphates)</td>

	</tr>

	<% 
try{

PreparedStatement pstm1=null,pstm2=null,pstm3=null;
 stmt1=conn.createStatement();
 stmt3=conn.createStatement();
 stmt4=conn.createStatement();
 stmt5=conn.createStatement();
 stmt6=conn.createStatement();
 sst1=conn.createStatement();
Statement smt=conn.createStatement();
 st=conn.createStatement();
 ResultSet rr11=null;
Hashtable totalNoSourcesH=new Hashtable();
Hashtable totalTestedSourcesH=new Hashtable();
Hashtable parameterVaulesHash=new Hashtable();
Set bactSourcesList=new HashSet();

		String qq="SELECT TESTING_PARAMETER_CODE,MAX_PERMISSIBLE_VALUE FROM RWS_WQ_PARA_TEST_TBL WHERE my_to_number(MAX_PERMISSIBLE_VALUE) is not null";
		rr = st.executeQuery(qq);
int k=0;
			while(rr.next())
			{
			      if(rr.getString(2)!=null && !rr.getString(2).equals("null")){
				   parameterVaulesHash.put(rr.getString(1),rr.getString(2)); }
					
			}
			//Closing database connections
			st.close();rr.close();

String mainQuery,q10;
if(dname!=null && dname.equals("ALL"))
{
mainQuery="select  mcode,mname from rws_mandal_tbl";
}else
{
mainQuery="select  mcode,mname from rws_mandal_tbl  where dcode='"+dcode+"'";;
}

String q1="select (select distinct count(*) from RWS_SOURCE_TBL where SUBSTR(SOURCE_CODE,1,2)=? and SUBSTR(SOURCE_CODE,6,2)=?) a1,(select distinct count(*) from RWS_OPENWELL_POND_TBL where SUBSTR(POND_CODE,1,2)=? and SUBSTR(POND_CODE,6,2)=?) a2,(select distinct count(*) from rws_open_well_mast_tbl where SUBSTR(OPENWELL_CODE,1,2)=? and SUBSTR(OPENWELL_CODE,6,2)=?) a3,(select distinct count(*) from rws_hp_subcomp_param_tbl where SUBSTR(HP_CODE,1,2)=? and SUBSTR(HP_CODE,6,2)=?) a4,(select distinct count(*) from rws_shallowhandpumps_tbl where SUBSTR(SHALLOWHP_CODE,1,2)=? and SUBSTR(SHALLOWHP_CODE,6,2)=?) a5 ,(select distinct count(*) from RWS_AST_OHSR_SC_PARAM_TBL  where SUBSTR(OHSR_CODE,1,2)=? and SUBSTR(OHSR_CODE,6,2)=?) a6,(select distinct count(*) from RWS_ast_glsr_sc_param_tbl where SUBSTR(GLSR_CODE,1,2)=? and SUBSTR(GLSR_CODE,6,2)=?) a7,(select distinct count(*) from RWS_ast_glbr_sc_param_tbl where SUBSTR(GLBR_CODE,1,2)=? and SUBSTR(GLBR_CODE,6,2)=?) a8 from dual";	
		 pstm1 = conn.prepareStatement(q1);
String q4=" select (SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >? ) a1,(SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >? ) a2,(SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >? ) a3,(SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=?  and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >? ) a4 ,(SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >?) a5,(SELECT distinct count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE > ?) a6,(SELECT count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >?) a7,(SELECT count(*) FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID=? and TESTING_PARAMETER_CODE=? and TESTING_PARAMETER_VALUE >? ) a8 from dual";
 pstm2 = conn.prepareStatement(q4);

  q10="SELECT distinct TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE  FROM RWS_WQ_TEST_RESULTS_LNK_TBL WHERE my_to_number(TESTING_PARAMETER_VALUE) is not null and TEST_ID=? and (TESTING_PARAMETER_CODE =? or  TESTING_PARAMETER_CODE=? or  TESTING_PARAMETER_CODE=? or  TESTING_PARAMETER_CODE=? or TESTING_PARAMETER_CODE=?)  and TESTING_PARAMETER_VALUE is not null";
 pstm3 = conn.prepareStatement(q10);
        


 
	rs2 = stmt1.executeQuery(mainQuery);
		while(rs2.next())           //Mandal change
		{
bactCount=0;
String q11="select distinct a.source_code from RWS_WQ_TEST_RESULTS_TBL a,RWS_WQ_TEST_RESULTS_LNK_TBL b  where SUBSTR(a.SOURCE_CODE,1,2)='"+dcode+"' and SUBSTR(a.SOURCE_CODE,6,2)='"+rs2.getString(1)+"' and a.test_code=2 and b.TESTING_PARAMETER_code='01' and b.TESTING_PARAMETER_VALUE >10 and a.test_id=b.test_id and  a.PREPARED_ON >= to_date('"+fromdate+"','dd/mm/yyyy') and a.PREPARED_ON <= to_date('"+todate+"','dd/mm/yyyy') and a.PREPARED_ON=(select  MAX(c.prepared_on) from  RWS_WQ_TEST_RESULTS_TBL c where c.source_code=a.source_code) and a.test_code=2";
rr11=smt.executeQuery(q11);
while(rr11.next())
{
		
if(bactSourcesList.contains(rr11.getString(1))){
 continue;
}
bactCount++;
bactSourcesList.add(rr11.getString(1));
//System.out.println("Source Code"+rr11.getString(1));
}

		
			pstm1.setString(1,dcode);
			pstm1.setString(2,rs2.getString(1));
			pstm1.setString(3,dcode);
			pstm1.setString(4,rs2.getString(1));
			pstm1.setString(5,dcode);
			pstm1.setString(6,rs2.getString(1));
			pstm1.setString(7,dcode);
			pstm1.setString(8,rs2.getString(1));
			pstm1.setString(9,dcode);
			pstm1.setString(10,rs2.getString(1));
			pstm1.setString(11,dcode);
			pstm1.setString(12,rs2.getString(1));
			pstm1.setString(13,dcode);
			pstm1.setString(14,rs2.getString(1));
			pstm1.setString(15,dcode);
			pstm1.setString(16,rs2.getString(1));
			rs3 = pstm1.executeQuery();
			if(rs3.next())
			{
			      int tot=Integer.parseInt(rs3.getString(1))+Integer.parseInt(rs3.getString(2))+Integer.parseInt(rs3.getString(3))+Integer.parseInt(rs3.getString(4))+Integer.parseInt(rs3.getString(5))+Integer.parseInt(rs3.getString(6))+Integer.parseInt(rs3.getString(7))+Integer.parseInt(rs3.getString(8));
				   totalNoSourcesH.put(rs2.getString(1),""+tot);
			}
		
	String q2="select distinct TEST_ID,TEST_CODE,a.source_code from RWS_WQ_TEST_RESULTS_TBL a where SUBSTR(a.SOURCE_CODE,1,2)='"+dcode+"' and SUBSTR(a.SOURCE_CODE,6,2)='"+rs2.getString(1)+"' and a.PREPARED_ON >= to_date('"+fromdate+"','dd/mm/yyyy') and a.PREPARED_ON <= to_date('"+todate+"','dd/mm/yyyy') and a.PREPARED_ON=(select  MAX(b.prepared_on) from  RWS_WQ_TEST_RESULTS_TBL b where b.source_code=a.source_code)";
	rs5 = stmt4.executeQuery(q2);
		int nofound=0,tcount=0,icount=0,fcount=0,thcount=0,tdscount=0,ncount=0;
			while(rs5.next())
			{
					
		
   
	     pstm2.setString(1,rs5.getString(1));
		 pstm2.setInt(2,16);
		 pstm2.setDouble(3,Double.parseDouble((String)parameterVaulesHash.get("16")));	
pstm2.setString(4,rs5.getString(1));
		 pstm2.setInt(5,13);
		 pstm2.setDouble(6,Double.parseDouble((String)parameterVaulesHash.get("13")));	
pstm2.setString(7,rs5.getString(1));
		 pstm2.setInt(8,05);
		 pstm2.setDouble(9,Double.parseDouble((String)parameterVaulesHash.get("05")));	
pstm2.setString(10,rs5.getString(1));
		 pstm2.setInt(11,12);
		 pstm2.setDouble(12,Double.parseDouble((String)parameterVaulesHash.get("12")));	
pstm2.setString(13,rs5.getString(1));
		 pstm2.setInt(14,15);
		 pstm2.setDouble(15,Double.parseDouble((String)parameterVaulesHash.get("15")));	
pstm2.setString(16,rs5.getString(1));
		 pstm2.setInt(17,07);
		 pstm2.setDouble(18,Double.parseDouble((String)parameterVaulesHash.get("07")));	
pstm2.setString(19,rs5.getString(1));
		 pstm2.setInt(20,12);
		 pstm2.setDouble(21,Double.parseDouble((String)parameterVaulesHash.get("12")));	
pstm2.setString(22,rs5.getString(1));
		 pstm2.setInt(23,14);
		 pstm2.setDouble(24,Double.parseDouble((String)parameterVaulesHash.get("14")));
		


		rs7 = pstm2.executeQuery();
			
//System.out.println("Q4:"+q4); 
   
              tcount++;
				   if(rs7.next())
				   {
						   icount+=Integer.parseInt(rs7.getString(1));
						   fcount+=Integer.parseInt(rs7.getString(2));
						   tdscount+=Integer.parseInt(rs7.getString(3));
						   //thcount+=Integer.parseInt(rs7.getString(4));
						   ncount+=Integer.parseInt(rs7.getString(5));
						   otherCount+=Integer.parseInt(rs7.getString(6));
						   otherCount+=Integer.parseInt(rs7.getString(7));
						   otherCount+=Integer.parseInt(rs7.getString(8));
				    }
          

 //System.out.println("Test Id:"+rs5.getString(1));
pstm3.setString(1,rs5.getString(1));
pstm3.setInt(2,16);
pstm3.setInt(3,13);
pstm3.setInt(4,15);
pstm3.setInt(5,05);
pstm3.setInt(6,12);


rr1=pstm3.executeQuery();
              while(rr1.next())
				   {
                   testValue=Double.parseDouble(rr1.getString(2));
                   String s=(String)parameterVaulesHash.get(rr1.getString(1));
					if(s!=null && !s.equals("No") && !s.equals(" -") && !s.equals("-")&& !s.equals(".") && !s.equals(".0") && !s.equals("") && !s.equals("norel")){
						double value=Double.parseDouble(s);
					   if(rr1.getString(1).equals("12"))                //Salinity Calculation
							{
								double salinity=0.03+((1.806*testValue)/1000);
									if(salinity>1.836)
										{
													thcount+=1;	
										}
							}
                       
 						if(testValue>value){
						
				              cnt++;
							}
						}
			
			}
  
            if(cnt>1){		
              multiExcessPar+=cnt;}
			    cnt=0; 			
					}

	
			totalTestedSourcesH.put(rs2.getString(1),tcount+"@"+nofound+"@"+icount+"@"+fcount+"@"+tdscount+"@"+ncount+"@"+thcount+"@"+bactCount+"@"+otherCount+"@"+multiExcessPar);
			otherCount=0;icount=0;fcount=0;tdscount=0;thcount=0;ncount=0;multiExcessPar=0;bactCount=0;
				
		} //End mandal change loop
		//Display results
	
		rs4 = stmt3.executeQuery(mainQuery);
		while(rs4.next())
		{
		tSOurces=0;
	 String testedSOur,value1="",value2="",value3="",value4="",value5="",value6="",value7="",value8="",value9="",value10="";
	 String tSOurce=(String)totalNoSourcesH.get(rs4.getString(1));
     tSOurces=Integer.parseInt(tSOurce);			  
     testedSOur=(String)totalTestedSourcesH.get(rs4.getString(1));
         if(testedSOur!=null){ 
				String  v1[]=testedSOur.split("@");	 
				value1=v1[0]; //totcount
				value2=v1[1]; //nofound
				value3=v1[2]; //iron
				value4=v1[3]; //florid
				value5=v1[4]; //tds
				value6=v1[5]; //nitrate
				value7=v1[6];  //tothard
				value8=v1[7];  //bact
				value9=v1[8];  //other
				value10=v1[9]; //multiexcess

		 totironCount+=Integer.parseInt(value3);
		 totfloridCount+=Integer.parseInt(value4);
		 tottdsCount+=Integer.parseInt(value5);
         totbactCount+=Integer.parseInt(value8);
         totOtherCount+=Integer.parseInt(value9);
		 totmultiExcessPar+=Integer.parseInt(value10);
				
					if(v1[0]!=null && !v1[0].equals("null"))
					totalTestedSources+=Integer.parseInt(v1[0]);
					if(v1[1]!=null && !v1[1].equals("null"))
					totalnfound+=Integer.parseInt(v1[1]);
					
					if(v1[6]!=null && !v1[6].equals("null"))
					totalhardcoount+=Integer.parseInt(v1[6]);
					if(v1[5]!=null && !v1[5].equals("null"))
					totalnitcount+=Integer.parseInt(v1[5]);
					if(v1[1]!=null && !v1[1].equals("null"))
					totalnfound+=Integer.parseInt(v1[1]);
					
					}
			
			tnofSources+=tSOurces;
			
			 results.put(rs4.getString(1),tSOurces+"@"+value1+"@"+value3+"@"+value4+"@"+value5+"@"+value6+"@"+value7+"@"+value9+"@"+value8+"@"+value10);
		%>

	<tr>
		<td><%= sno++ %></td>
		<td class="btext"><%= rs4.getString(2)%></td>
		<td><%=tSOurces %></td>
		<td><%= value1 %></td>
		<td><%= value3 %></td>
		<td><%= value4 %></td>
		<td><%= value5 %></td>
		<td><%=value6 %></td>
		<td><%=value7 %></td>
		<td><%= value9 %></td>
		<td><%= value8 %></td>
		<td><%= value10 %></td>
		
		<td></td>
	</tr>
	<%
	}

%>
	<tr>
		<td></td>
		<td class="btext">Total:</td>
		<td class="btext"><%=tnofSources %></td>
		<td class="btext"><%= totalTestedSources %></td>
		<td class="btext"><%= totironCount %></td>
		<td class="btext"><%=totfloridCount  %></td>
		<td class="btext"><%=tottdsCount %></td>
		<td class="btext"><%= totalnitcount %></td>
		<td class="btext"><%= totalhardcoount%></td>
		<td class="btext"><%= totOtherCount %></td>
		<td class="btext"><a href="./rws_WQ_lab_bact_sources_list.jsp" target="_new"><%= totbactCount %></a></td>
		<td class="btext"><%= totmultiExcessPar %></td>
		
		<td class="btext"></td>
	</tr>


<!-- <tr><td colspan=12 align="center"><b><font color="red" >&nbsp;Note:&nbsp;Salinity=0.03+(1.806*Chloride Tested Value)</font></b></td></tr>  -->




	<%
session.setAttribute("bactSourcesList",bactSourcesList);
  session.setAttribute("results",results);
session.setAttribute("mainQuery",mainQuery);
	
	}catch(Exception e)
		{
		 e.printStackTrace();
		}finally{try{
				if(stmt1!=null)
                   stmt1.close();
                if(stmt4!=null)
                   stmt4.close();
				if(stmt2!=null)
                   stmt2.close();if(sst1!=null)
                   sst1.close();
				if(stmt5!=null)
				stmt5.close();
		
 		}catch(Exception e){e.printStackTrace();}
			}
		
%>
	</table>

</form>
