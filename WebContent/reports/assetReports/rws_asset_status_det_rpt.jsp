<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
String mandal="";
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");
String district=request.getParameter("district");
if(request.getParameter("constituency")!=null){
mandal=request.getParameter("constituency");

}

session.setAttribute("constituency",mandal);
session.setAttribute("district",district);

    int styleCount=0;
    String style="";
    String scheme="";
    if(request.getParameterValues("scheme")!=null){
      String[] schemes=request.getParameterValues("scheme");
  	
      
  	for(int i=0;i<schemes.length;i++)
  	{
  	scheme += schemes[i]+",";
  	}
  	//System.out.println("programe::"+programe);
  	scheme = scheme.substring(0,scheme.length()-1);
  session.setAttribute("scheme",scheme);
  }
    String[] programes=request.getParameterValues("program");
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_asset_status_det_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	
    
	</table>
   
   <table width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td class=gridhdbg colspan="25">RWS&S-Constituency wise status and assets information(Details)</td>
	</tr>
	
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>District</td>
	<td class=gridhdbg rowspan=2>Name of Constituency</td>
    <td class=gridhdbg rowspan=2>Name of Mandal</td>
     
    <td class=gridhdbg rowspan=2>Name of Gram Panchayat</td>
    <td class=gridhdbg rowspan=2>Name of Habitation</td>
    <td class=gridhdbg rowspan=1 colspan="4">Population</td>
    <td class=gridhdbg rowspan=2>Status of Habitation</td> 
	<td class=gridhdbg rowspan=1 >If status is QA</td>
	<td class=gridhdbg rowspan=1 colspan="7">No.of Assets Existing</td>	
    <td class=gridhdbg rowspan=1 colspan="6">Covered by ongoing works(Rs.Lakhs)</td>
    
	</tr>
	<tr>
	<td class=gridhdbg>Plain</td>
	<td class=gridhdbg>SC</td>
	<td class=gridhdbg>ST</td>
	<td class=gridhdbg>Total</td>
	<td class=gridhdbg>Type of Contamination(Fl/Br/Iron/Nitrate)</td>
		<td class=gridhdbg>CPWS(MVS)</td>
	<td class=gridhdbg>PWS(SVS)</td>
	<td class=gridhdbg>MPWS</td>
	<td class=gridhdbg>DP</td>
	<td class=gridhdbg>HP</td>
	<td class=gridhdbg>SHP</td>
	<td class=gridhdbg>Total asset cost(Rs. in lakhs)</td>
	<td class=gridhdbg>MVS</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg>SVS</td>
	<td class=gridhdbg>Cost</td>
	<td class=gridhdbg >Total</td>
      <td class=gridhdbg>Cost</td></tr>
     
	
     
       
    <tr>
	<%for(int i=1;i<26;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
<%
try
{
	


   //main qry
   Statement stmt8=null,stmt7=null,stmt6=null;
   ResultSet rs8=null,rs7=null,rs6=null;
   int sno=1;
   
   String dname="",mname="",pname="",tdname="",tmname="",tpname="",cname="",tcname="";
   stmt7=conn.createStatement();
   String mvsqry="select lead_habitation,count(*) from rws_work_admn_tbl where lead_habitation is not null and substr(work_id,5,2)='"+district+"' and category_code='1' and WORK_CANCEL_DT is null and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-Apr-2014') ";
   if (scheme != null && !scheme.equals("")) {
	   mvsqry += "and type_of_asset in(" + scheme + ") ";
	}

   mvsqry += " and  programme_code in (" + programe + ") group by  lead_habitation";

   
   System.out.println("mvsqry is"+mvsqry);
   Hashtable mvshash = new Hashtable();
   rs7=stmt7.executeQuery(mvsqry);
   while(rs7.next()){
	   if(rs7.getString(1)!=null ){
	   mvshash.put(rs7.getString(1),rs7.getInt(2));
	   }
   }
   if(rs7!=null){
		rs7.close();
	}
	if(stmt7!=null){
		stmt7.close();
	}
   
	stmt7=conn.createStatement();
	   String svsqry="select hab_code,count(*) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b where a.work_id=b.work_id and  substr(a.work_id,5,2)='"+district+"' and category_code='2' and WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-Apr-2014') ";
	   if (scheme != null && !scheme.equals("")) {
		   svsqry += "and type_of_asset in(" + scheme + ") ";
		}

	   svsqry += " and  programme_code in (" + programe + ") group by  hab_code";

	   System.out.println("svsqry is"+svsqry);
	   Hashtable svshash = new Hashtable();
	   rs7=stmt7.executeQuery(svsqry);
	   while(rs7.next()){
		   svshash.put(rs7.getString(1),rs7.getInt(2));
	   }
	   if(rs7!=null){
			rs7.close();
		}
		if(stmt7!=null){
			stmt7.close();
		}
   
   stmt7=conn.createStatement();
   String assetpopqry="select a.asset_code,sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)) from rws_asset_mast_tbl a,RWS_ASSET_HAB_TBL b,rws_habitation_directory_tbl c where a.asset_code=b.asset_code and b.hab_code=c.hab_code and c.coverage_status<>'UI' and SUBSTR(a.asset_code,5,2)='"+district+"'   group by a.asset_code";
   System.out.println("assetpopqry is"+assetpopqry);
   Hashtable assetpophash = new Hashtable();
   rs7=stmt7.executeQuery(assetpopqry);
   while(rs7.next()){
	   assetpophash.put(rs7.getString(1),rs7.getInt(2));
   }
   if(rs7!=null){
		rs7.close();
	}
	if(stmt7!=null){
		stmt7.close();
	}
   
	stmt7=conn.createStatement();
	   String habpopqry="select hab_code,sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)) from rws_habitation_directory_tbl where SUBSTR(hab_code,1,2)='"+district+"' and coverage_status<>'UI'  group by hab_code";
	   System.out.println("habpopqry is"+habpopqry);
	   Hashtable habpophash = new Hashtable();
	   rs7=stmt7.executeQuery(habpopqry);
	   while(rs7.next()){
		   habpophash.put(rs7.getString(1),rs7.getInt(2));
	   }
	   if(rs7!=null){
			rs7.close();
		}
		if(stmt7!=null){
			stmt7.close();
		}	
   
   stmt7=conn.createStatement();
   String workpopqry="select a.work_id,sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and  SUBSTR(a.work_id,5,2)='"+district+"'  group by a.work_id";
   System.out.println("workpopqry is"+workpopqry);
   Hashtable wrkpophash = new Hashtable();
   rs7=stmt7.executeQuery(workpopqry);
   while(rs7.next()){
	   wrkpophash.put(rs7.getString(1),rs7.getInt(2));
   }
   if(rs7!=null){
		rs7.close();
	}
	if(stmt7!=null){
		stmt7.close();
	}
			 Hashtable mvshabsplitamnthash = new Hashtable();
		stmt6=conn.createStatement();
		   String habsplitqryqry="select a.work_id,c.hab_code,sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)),nvl(a.sanction_amount,0) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and CATEGORY_CODE='1' and  SUBSTR(a.work_id,5,2)='"+district+"' and to_date(admin_date) >= '01-Apr-2013' and to_date(admin_date) <= '01-Apr-2014'  ";
		   if (scheme != null && !scheme.equals("")) {
			   habsplitqryqry += "and a.type_of_asset in(" + scheme + ") ";
			}

		   habsplitqryqry += " and  a.programme_code in (" + programe + ") group by a.work_id,c.hab_code,nvl(a.sanction_amount,0)";
		   System.out.println("mvshabsplitqryqry is"+habsplitqryqry);
		   rs6=stmt6.executeQuery(habsplitqryqry);
		while(rs6.next()){
			//System.out.println("work"+rs6.getString(1)+"--hab"+rs6.getString(2));
			int totalpopulat=(Integer)wrkpophash.get(rs6.getString(1));
			double sanamnt=rs6.getDouble(4);
			int habpopulate=rs6.getInt(3);
			double habamount=0.0;
			if(mvshabsplitamnthash.get(rs6.getString(2))!=null){
				habamount=(Double)mvshabsplitamnthash.get(rs6.getString(2));
			}
			if(totalpopulat>0){
				habamount+=(sanamnt*habpopulate)/totalpopulat;
				mvshabsplitamnthash.put(rs6.getString(2),habamount);
			}
		}
		 if(rs6!=null){
				rs6.close();
			}
			if(stmt6!=null){
				stmt6.close();
			}
		
			 Hashtable svshabsplitamnthash = new Hashtable();
				stmt6=conn.createStatement();
				   String svshabsplitqryqry="select a.work_id,c.hab_code,sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)),nvl(a.sanction_amount,0) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and CATEGORY_CODE='2' and  SUBSTR(a.work_id,5,2)='"+district+"' and to_date(admin_date) >= '01-Apr-2013' and to_date(admin_date) <= '01-Apr-2014' ";
				   if (scheme != null && !scheme.equals("")) {
					   svshabsplitqryqry += "and a.type_of_asset in(" + scheme + ") ";
					}

				   svshabsplitqryqry += " and  a.programme_code in (" + programe + ") group by a.work_id,c.hab_code,nvl(a.sanction_amount,0)";
				  
				   //System.out.println("svshabsplitqryqry is"+svshabsplitqryqry);
				   rs6=stmt6.executeQuery(svshabsplitqryqry);
				while(rs6.next()){
					int totalpopulat=(Integer)wrkpophash.get(rs6.getString(1));
					double sanamnt=rs6.getDouble(4);
					int habpopulate=rs6.getInt(3);
					double habamount=0.0;
					if(svshabsplitamnthash.get(rs6.getString(2))!=null){
						habamount=(Double)svshabsplitamnthash.get(rs6.getString(2));
					}
					if(totalpopulat>0){
						habamount+=(sanamnt*habpopulate)/totalpopulat;
						svshabsplitamnthash.put(rs6.getString(2),habamount);
					}
				}
				 if(rs6!=null){
						rs6.close();
					}
					if(stmt6!=null){
						stmt6.close();
					}
   stmt7=conn.createStatement();
   String qaqry="select a.hab_code,a.CONT_TYPE,b.CONTAMINATION_NAME from RWS_HAB_CONTAMINATION_TBL a,RWS_CONTAMINATION_TBL b where b.CONTAMINATION_CODE=a.CONT_TYPE and  SUBSTR(HAB_CODE,1,2)='"+district+"' ";
   if(mandal!=null && !mandal.equals("00")){
	   qaqry+=" and SUBSTR(HAB_CODE,3,3)='"+mandal+"'";
		}
   System.out.println("qaqry qry is"+qaqry);
   Hashtable qahash = new Hashtable();
   rs7=stmt7.executeQuery(qaqry);
   while(rs7.next()){
   qahash.put(rs7.getString(1),rs7.getString(3));
   }
   if(rs7!=null){
		rs7.close();
	}
	if(stmt7!=null){
		stmt7.close();
	}
	stmt7=conn.createStatement();
	 String assetqry="select hab_code,TYPE_OF_ASSET_NAME,count(1) from  RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_CODE=b.TYPE_OF_ASSET_CODE and  SUBSTR(HAB_CODE,1,2)='"+district+"' ";
	   if(mandal!=null && !mandal.equals("00")){
		   assetqry+=" and SUBSTR(HAB_CODE,3,3)='"+mandal+"'";
			}
	   assetqry+=" group by TYPE_OF_ASSET_NAME,hab_code";
	 System.out.println("assetqry qry is"+assetqry);
	   Hashtable assethash = new Hashtable();
	   rs7=stmt7.executeQuery(assetqry);
	   while(rs7.next()){
		   assethash.put(rs7.getString(1)+rs7.getString(2),rs7.getInt(3));
	   }
	   if(rs7!=null){
			rs7.close();
		}
		if(stmt7!=null){
			stmt7.close();
		}
		stmt7=conn.createStatement();
		 String assetcostqry="select hab_code,sum(nvl(ASSET_COST,0)) from  RWS_ASSET_MAST_TBL where SUBSTR(HAB_CODE,1,2)='"+district+"' and type_of_asset_code<>'03' ";
		   if(mandal!=null && !mandal.equals("00")){
			   assetcostqry+=" and SUBSTR(HAB_CODE,3,3)='"+mandal+"'";
				}
		   assetcostqry+=" group by hab_code";
		  System.out.println("assetcostqry qry is"+assetcostqry);
		   Hashtable assetcosthash = new Hashtable();
		   rs7=stmt7.executeQuery(assetcostqry);
		   while(rs7.next()){
			   assetcosthash.put(rs7.getString(1),rs7.getDouble(2));
		   }
		   if(rs7!=null){
				rs7.close();
			}
			if(stmt7!=null){
				stmt7.close();
			}
		
	
			stmt7=conn.createStatement();
			 String cpwsassetcostqry="select hab_code,sum(nvl(ASSET_COST,0)),asset_code from  RWS_ASSET_MAST_TBL where SUBSTR(HAB_CODE,1,2)='"+district+"' and type_of_asset_code='03' ";
			   if(mandal!=null && !mandal.equals("00")){
				   cpwsassetcostqry+=" and SUBSTR(HAB_CODE,3,3)='"+mandal+"'";
					}
			   cpwsassetcostqry+=" group by hab_code,asset_code";
			  System.out.println("cpwsassetcostqry qry is"+cpwsassetcostqry);
			   Hashtable cpwsassetcosthash = new Hashtable();
			   rs7=stmt7.executeQuery(cpwsassetcostqry);
			   while(rs7.next()){
				   int totalpopulation=0,habpopulation=0;
				   double assetamnt=0.0,totalassetcost=0.0;
				   if(assetpophash.get(rs7.getString(3))!=null){
					   totalpopulation=(Integer)assetpophash.get(rs7.getString(3));
				   }
				   if(habpophash.get(rs7.getString(1))!=null){
					   habpopulation=(Integer)habpophash.get(rs7.getString(1));
				   }
				   if(totalpopulation>0){
					   assetamnt=(rs7.getDouble(2)*habpopulation)/totalpopulation; 
				   }
				   if(cpwsassetcosthash.get(rs7.getString(1))!=null){
					   assetamnt+=(Double)cpwsassetcosthash.get(rs7.getString(1));  
				   }
				   System.out.println("hab code="+rs7.getString(1)+" asset="+rs7.getString(3)+" cost="+rs7.getDouble(2)+" assetpop="+totalpopulation+" habpop="+habpopulation+" assetamnt="+assetamnt);

				   cpwsassetcosthash.put(rs7.getString(1),assetamnt);
			   }
			   if(rs7!=null){
					rs7.close();
				}
				if(stmt7!=null){
					stmt7.close();
				}
			
			
			
		stmt7=conn.createStatement();
		 String workqry="select  c.hab_code,sum(case c.hab_code when a.LEAD_HABITATION then 1 else 0 end) as mvscount,sum(case CATEGORY_CODE when '2' then 1 else 0 end) as svscount,sum(nvl(SANCTION_AMOUNT,0)),sum(case CATEGORY_CODE when '1' then nvl(sanction_amount,0) else 0 end) as mvsamnt,sum(case CATEGORY_CODE when '2' then nvl(sanction_amount,0) else 0 end) as svsamnt  from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_COMPLETE_HAB_VIEW d where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.hab_code=d.panch_code  and  SUBSTR(c.HAB_CODE,1,2)='"+district+"' and to_date(admin_date) >= '01-Apr-2013' and to_date(admin_date) <= '01-Apr-2014' ";
		   if(mandal!=null && !mandal.equals("00")){
			   workqry+=" and SUBSTR(c.HAB_CODE,3,3)='"+mandal+"'";
				}
		   if (scheme != null && !scheme.equals("")) {
			   workqry += "and a.type_of_asset in(" + scheme + ") ";
			}

		   
		   workqry+=" and  a.programme_code in (" + programe + ") group by c.hab_code order by c.hab_code";
		System.out.println("workqry qry is"+workqry);
		   Hashtable workhash = new Hashtable();
		   rs7=stmt7.executeQuery(workqry);
		   while(rs7.next()){
			   workhash.put(rs7.getString(1),rs7.getInt(2)+"@"+rs7.getInt(3)+"@"+rs7.getString(4)+"@"+rs7.getString(5)+"@"+rs7.getString(6));
		   }
		   if(rs7!=null){
				rs7.close();
			}
			if(stmt7!=null){
				stmt7.close();
			}
				
   stmt8=conn.createStatement();
   String mainqry="select d.dcode,d.dname,m.mcode,m.mname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_name,p.pcode,p.pname,r.panch_code,r.panch_name,nvl(h.coverage_status,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0) from rws_district_tbl d,rws_mandal_tbl m,RWS_CONSTITUENCY_TBL c,RWS_PANCHAYAT_TBL p,RWS_PANCHAYAT_RAJ_TBL r,RWS_COMPLETE_HAB_VIEW h where d.dcode=m.dcode and c.dcode=m.dcode and c.mcode=m.mcode and p.dcode=m.dcode and p.mcode=m.mcode and SUBSTR(r.PANCH_CODE,1,2)=d.dcode and SUBSTR(r.PANCH_CODE,6,2)=m.mcode and SUBSTR(r.PANCH_CODE,13,2)=p.pcode and r.panch_code=h.PANCH_CODE and d.dcode='"+district+"' ";
 
   if(mandal!=null && !mandal.equals("00")){
	   mainqry+="and c.CONSTITUENCY_CODE='"+mandal+"'";
		}
	 
   mainqry+=" order by d.dcode,m.mcode,CONSTITUENCY_CODE,p.pcode,r.panch_code";
   System.out.println("main qry is"+mainqry);
   session.setAttribute("workhash",workhash);
   session.setAttribute("qahash",qahash);
   session.setAttribute("assethash",assethash);
   session.setAttribute("svshabsplitamnthash",svshabsplitamnthash);
   session.setAttribute("mvshabsplitamnthash",mvshabsplitamnthash);
   session.setAttribute("assetcosthash",assetcosthash);
   session.setAttribute("cpwsassetcosthash",cpwsassetcosthash);
	rs8=stmt8.executeQuery(mainqry);
	int totplainpop=0,totscpop=0,totstpop=0,totpop=0;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0,totwrkmvscnt=0,totwrksvs=0,tottotwrk=0;
	double totmvsamnt=0.0,totsvsamnt=0.0,tottotamnt=0.0,totalassetcost=0.0;
while(rs8.next()){
	String conttype="-";
	int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,wrkmvscnt=0,wrksvs=0,totwrk=0;
	
	double mvsamnt=0.0,svsamnt=0.0,totamnt=0.0,habassetcost=0.0;
	
	
	if(svshash.get(rs8.getString(9))!=null){
		wrksvs=(Integer)svshash.get(rs8.getString(9));
	}
	if(mvshash.get(rs8.getString(9))!=null){
		wrkmvscnt=(Integer)mvshash.get(rs8.getString(9));
	}
	if(assetcosthash.get(rs8.getString(9))!=null){
		habassetcost=(Double)assetcosthash.get(rs8.getString(9));	
	}
	if(cpwsassetcosthash.get(rs8.getString(9))!=null){
		habassetcost+=(Double)cpwsassetcosthash.get(rs8.getString(9));	
		System.out.println("cpws cost="+(Double)cpwsassetcosthash.get(rs8.getString(9)));
	}
	if(workhash.get(rs8.getString(9))!=null){
		 
		//expUpto
		String expValues=(String)workhash.get(rs8.getString(9));
		String exp[]=expValues.split("@");
		//wrkmvscnt=Integer.parseInt(exp[0]);
		//wrksvs=Integer.parseInt(exp[1]);
		//if(exp[2]!=null || !exp[2].equals("")){
			//totamnt=Double.parseDouble(exp[2]);
		//}
		//if(exp[3]!=null || !exp[3].equals("")){
			//mvsamnt=Double.parseDouble(exp[3]);
		//}
		//if(exp[4]!=null || !exp[4].equals("")){
			//svsamnt=Double.parseDouble(exp[4]);
		//}
		totwrk=wrkmvscnt+wrksvs;
	}
	if(svshabsplitamnthash.get(rs8.getString(9))!=null){
		svsamnt=(Double)svshabsplitamnthash.get(rs8.getString(9));
	}
	if(mvshabsplitamnthash.get(rs8.getString(9))!=null){
		mvsamnt=(Double)mvshabsplitamnthash.get(rs8.getString(9));
	}
	totamnt=svsamnt+mvsamnt;
	if(qahash.get(rs8.getString(9))!=null){
		conttype=(String)qahash.get(rs8.getString(9));
	}
	if(assethash.get(rs8.getString(9)+"CPWS")!=null){
		cpwscnt=(Integer)assethash.get(rs8.getString(9)+"CPWS");
	}
	if(assethash.get(rs8.getString(9)+"PWS")!=null){
		pwscnt=(Integer)assethash.get(rs8.getString(9)+"PWS");
	}
	if(assethash.get(rs8.getString(9)+"MPWS")!=null){
		mpwscnt=(Integer)assethash.get(rs8.getString(9)+"MPWS");
	}
	if(assethash.get(rs8.getString(9)+"DIRECT PUMPING")!=null){
		dpcnt=(Integer)assethash.get(rs8.getString(9)+"DIRECT PUMPING");
	}
	if(assethash.get(rs8.getString(9)+"HANDPUMPS")!=null){
		hpcnt=(Integer)assethash.get(rs8.getString(9)+"HANDPUMPS");
	}
	if(assethash.get(rs8.getString(9)+"SHALLOW HAND PUMPS")!=null){
		shpcnt=(Integer)assethash.get(rs8.getString(9)+"SHALLOW HAND PUMPS");
	}
	if(dname.equals(rs8.getString(2))||tdname.equals(rs8.getString(2))){
 	   dname="-";
    }else{
 	   dname=rs8.getString(2);
    }
	if(cname.equals(rs8.getString(6))||tcname.equals(rs8.getString(6))){
	 	   cname="-";
	    }else{
	 	   cname=rs8.getString(6);
	    }
	
	if(mname.equals(rs8.getString(4))||tmname.equals(rs8.getString(4))){
		mname="-";
	    }else{
	    	mname=rs8.getString(4);
	    }
	if(pname.equals(rs8.getString(8))||tpname.equals(rs8.getString(8))){
		pname="-";
	    }else{
	    	pname=rs8.getString(8);
	    }
	 if(styleCount%2==0)
	 {
		 style="gridbg1";
	 }
	else
	 {
		 style="gridbg2";
	 }
	 styleCount++; 
%>
 <tr>
 <td class=<%=style %>><%=sno %></td>
 <td class=<%=style %> style="text-align: left;"><%=dname %></td>
 <td class=<%=style %> style="text-align: left;"><%=cname %></td>
 <td class=<%=style %> style="text-align: left;"><%=mname %></td>
 
 <td class=<%=style %> style="text-align: left;"><%=pname %></td>
 <td class=<%=style %> style="text-align: left;"><%=rs8.getString(9) %>/<%=rs8.getString(10) %></td>
  <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(12) %></td>
 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(13) %></td>
 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(14) %></td>
 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(15) %></td>
 <td class=<%=style %> style="text-align: left;"><%=rs8.getString(11) %></td>
 <td class=<%=style %> style="text-align: left;"><%=conttype %></td>
 <td class=<%=style %> style="text-align: right;"><%=cpwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=pwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=mpwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=dpcnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=hpcnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=shpcnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(habassetcost) %></td>
 <td class=<%=style %> style="text-align: right;"><%=wrkmvscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(mvsamnt) %></td>
 <td class=<%=style %> style="text-align: right;"><%=wrksvs %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(svsamnt) %></td>
 <td class=<%=style %> style="text-align: right;"><%=totwrk %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(totamnt) %></td>
 
 </tr>
	
   	
   	
<%
totplainpop+=rs8.getInt(12);
totscpop+=rs8.getInt(13);
totstpop+=rs8.getInt(14);totpop+=rs8.getInt(15);
totcpwscnt+=cpwscnt;totpwscnt+=pwscnt;totmpwscnt+=mpwscnt;totdpcnt+=dpcnt;tothpcnt+=hpcnt;totshpcnt+=shpcnt;totwrkmvscnt+=wrkmvscnt;
totwrksvs+=wrksvs;tottotwrk+=totwrk;
totmvsamnt+=mvsamnt;totsvsamnt+=svsamnt;tottotamnt+=totamnt;
totalassetcost+=habassetcost;
tdname=rs8.getString(2);
tmname=rs8.getString(4);
tpname=rs8.getString(8);
tcname=rs8.getString(6);
sno++;
}
   
  %>
  <tr>
  <td class=gridhdbg colspan=6>Total</td>
   <td class=gridhdbg><%=totplainpop %></td>
   <td class=gridhdbg><%=totscpop %></td>
   <td class=gridhdbg><%=totstpop %></td>
   <td class=gridhdbg><%=totpop %></td>
   <td class=gridhdbg>-</td>
   <td class=gridhdbg>-</td>
   <td class=gridhdbg style="text-align: right;"><%=totcpwscnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=totpwscnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=totmpwscnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=totdpcnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=tothpcnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=totshpcnt %></td>
  <td class=gridhdbg style="text-align: right;"><%=ndf.format(totalassetcost) %></td>
 <td class=gridhdbg style="text-align: right;"><%=totwrkmvscnt %></td>
 <td class=gridhdbg style="text-align: right;"><%=ndf.format(totmvsamnt) %></td>
 <td class=gridhdbg style="text-align: right;"><%=totwrksvs %></td>
 <td class=gridhdbg style="text-align: right;"><%=ndf.format(totsvsamnt) %></td>
 <td class=gridhdbg style="text-align: right;"><%=tottotwrk %></td>
 <td class=gridhdbg style="text-align: right;"><%=ndf.format(tottotamnt) %></td>
  </tr>
  
  
  <%
   
	if(rs8!=null){
		rs8.close();
	}
	if(stmt8!=null){
		stmt8.close();
	}
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>