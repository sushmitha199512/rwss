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
if(request.getParameter("mandal")!=null){
mandal=request.getParameter("mandal");
session.setAttribute("mandal",mandal);
}
session.setAttribute("district",district);

System.out.println("mandal"+mandal);

    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_asset_status_abst_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	
    
	</table>
   
   <table width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td class=gridhdbg colspan="41">RWS&S-Constituency wise status and assets information(ABSTRACT)</td>
	</tr>
	 <tr>	
	<td class=gridhdbg rowspan=3>Sl.No</td>
	<td class=gridhdbg rowspan=3>District</td>
    <td class=gridhdbg rowspan=3>Name of Mandal</td>
    <td class=gridhdbg rowspan=3>Constituency</td>
    <td class=gridhdbg rowspan=3>No. of GPs</td>
    <td class=gridhdbg rowspan=3>No. of Habitations</td>
    <td class=gridhdbg rowspan=1 colspan="4">Population</td>
    <td class=gridhdbg rowspan=1 colspan="9">Status of Habitations</td> 
	<td class=gridhdbg rowspan=1 colspan="6">No. of Assets Existing</td>
	<td class=gridhdbg rowspan=1 colspan="16">Ongoing Works(Rs. Lakhs)</td>	
    
    
	</tr>
	<tr>
	<td class=gridhdbg rowspan=2>Plain</td>
	<td class=gridhdbg rowspan=2>SC</td>
	<td class=gridhdbg rowspan=2>ST</td>
	<td class=gridhdbg rowspan=2>Total</td>
	<td class=gridhdbg rowspan=2>FC</td>
	<td class=gridhdbg rowspan=2>PC4</td>
	<td class=gridhdbg rowspan=2>PC3</td>
	<td class=gridhdbg rowspan=2>PC2</td>
	<td class=gridhdbg rowspan=2>PC1</td>
	<td class=gridhdbg rowspan=1 colspan="4">QA</td>
	<td class=gridhdbg rowspan=2>CPWS(MVS)</td>
	<td class=gridhdbg rowspan=2>PWS(SVS)</td>
	<td class=gridhdbg rowspan=2>MPWS</td>
	<td class=gridhdbg rowspan=2>DP</td>
	<td class=gridhdbg rowspan=2>HP</td>
	<td class=gridhdbg rowspan=2>SHP</td>
	<td class=gridhdbg rowspan=2>MVS</td>
	<td class=gridhdbg rowspan=2>Cost</td>
	<td class=gridhdbg rowspan=2>SVS</td>
	<td class=gridhdbg rowspan=2>Cost</td>
	<td class=gridhdbg rowspan=2>Total</td>
      <td class=gridhdbg rowspan=2>Cost</td>
      <td class=gridhdbg rowspan=2>Habs Sanctioned</td>
      <td class=gridhdbg rowspan=2>FC</td>
	<td class=gridhdbg rowspan=2>PC4</td>
	<td class=gridhdbg rowspan=2>PC3</td>
	<td class=gridhdbg rowspan=2>PC2</td>
	<td class=gridhdbg rowspan=2>PC1</td>
	<td class=gridhdbg rowspan=1 colspan="4">QA</td>
	
       </tr>
     <tr>
     <td class=gridhdbg rowspan=1>Fluoride</td>
     <td class=gridhdbg rowspan=1>Brackish</td>
     <td class=gridhdbg rowspan=1>Iron</td>
     <td class=gridhdbg rowspan=1>Nitrate</td>
     <td class=gridhdbg rowspan=1>Fluoride</td>
     <td class=gridhdbg rowspan=1>Brackish</td>
     <td class=gridhdbg rowspan=1>Iron</td>
     <td class=gridhdbg rowspan=1>Nitrate</td>
     </tr>  
<%
try
{
	
	
	 int sno=1;
	   
	   String dname="",mname="",pname="",tdname="",tmname="",tpname="",cname="",tcname="";
	  

   //main qry
   Statement stmt8=null,stmt7=null,stmt6=null;
   ResultSet rs8=null,rs7=null,rs6=null;
   stmt7=conn.createStatement();
   String workpopqry="select substr(a.work_id,5,2),sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and  SUBSTR(a.work_id,5,2)='"+district+"'  group by substr(a.work_id,5,2)";
   //System.out.println("workpopqry is"+workpopqry);
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
	
	stmt7=conn.createStatement();
	   String workamntqry="select substr(work_id,5,2),sum(nvl(sanction_amount,0)) from rws_work_admn_tbl  where WORK_CANCEL_DT is null and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and SUBSTR(work_id,5,2)='"+district+"'  group by substr(work_id,5,2)";
	   //System.out.println("workamntqry is"+workamntqry);
	   Hashtable wrkamnthash = new Hashtable();
	   rs7=stmt7.executeQuery(workamntqry);
	   while(rs7.next()){
		   wrkamnthash.put(rs7.getString(1),rs7.getDouble(2));
	   }
	   if(rs7!=null){
			rs7.close();
		}
		if(stmt7!=null){
			stmt7.close();
		}
		
	
			 Hashtable mvshabsplitamnthash = new Hashtable();
		stmt6=conn.createStatement();
		   String habsplitqryqry="select substr(a.work_id,5,2),substr(c.hab_code,6,2),sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)),sum(distinct nvl(a.sanction_amount,0)) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and CATEGORY_CODE='1' and  SUBSTR(a.work_id,5,2)='"+district+"' group by substr(a.work_id,5,2),substr(c.hab_code,6,2) ";
		   //System.out.println("mvshabsplitqryqry is"+habsplitqryqry);
		   rs6=stmt6.executeQuery(habsplitqryqry);
		while(rs6.next()){
			//System.out.println("work"+rs6.getString(1)+"--hab"+rs6.getString(2));
			int totalpopulat=(Integer)wrkpophash.get(rs6.getString(1));
			double sanamnt=0.0;
			if(wrkamnthash.get(rs6.getString(1))!=null){
				sanamnt=(Double)wrkamnthash.get(rs6.getString(1));
			}
			int habpopulate=rs6.getInt(3);
			double habamount=0.0;
			if(mvshabsplitamnthash.get(rs6.getString(1)+rs6.getString(2))!=null){
				habamount=(Double)mvshabsplitamnthash.get(rs6.getString(1)+rs6.getString(2));
			}
			if(totalpopulat>0){
				habamount+=(sanamnt*habpopulate)/totalpopulat;
				mvshabsplitamnthash.put(rs6.getString(1)+rs6.getString(2),habamount);
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
				   String svshabsplitqryqry="select substr(a.work_id,5,2),substr(c.hab_code,6,2),sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)),sum(nvl(a.sanction_amount,0)) from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status<>'UI' and CATEGORY_CODE='2' and  SUBSTR(a.work_id,5,2)='"+district+"' group by substr(a.work_id,5,2),substr(c.hab_code,6,2)";
				   //System.out.println("svshabsplitqryqry is"+svshabsplitqryqry);
				   rs6=stmt6.executeQuery(svshabsplitqryqry);
				while(rs6.next()){
					int totalpopulat=(Integer)wrkpophash.get(rs6.getString(1));
					double sanamnt=0.0;
					if(wrkamnthash.get(rs6.getString(1))!=null){
						sanamnt=(Double)wrkamnthash.get(rs6.getString(1));
					}
					int habpopulate=rs6.getInt(3);
					double habamount=0.0;
					if(svshabsplitamnthash.get(rs6.getString(1)+rs6.getString(2))!=null){
						habamount=(Double)svshabsplitamnthash.get(rs6.getString(1)+rs6.getString(2));
					}
					if(totalpopulat>0){
						habamount+=(sanamnt*habpopulate)/totalpopulat;
						svshabsplitamnthash.put(rs6.getString(1)+rs6.getString(2),habamount);
					}
				}
				 if(rs6!=null){
						rs6.close();
					}
					if(stmt6!=null){
						stmt6.close();
					}
   
   
   stmt7=conn.createStatement();
   String qaqry="select substr(a.hab_code,1,2),substr(a.hab_code,6,2),a.CONT_TYPE,count(1) from RWS_HAB_CONTAMINATION_TBL a where SUBSTR(HAB_CODE,1,2)='"+district+"' ";
   if(mandal!=null && !mandal.equals("00")){
	   qaqry+=" and SUBSTR(HAB_CODE,6,2)='"+mandal+"'";
		}
   qaqry+=" group by substr(a.hab_code,1,2),substr(a.hab_code,6,2),a.CONT_TYPE";
   //System.out.println("qaqry qry is"+qaqry);
   Hashtable qahash = new Hashtable();
   rs7=stmt7.executeQuery(qaqry);
   while(rs7.next()){
   qahash.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(3),rs7.getInt(4));
   }
   if(rs7!=null){
		rs7.close();
	}
	if(stmt7!=null){
		stmt7.close();
	}
	stmt7=conn.createStatement();
	 String assetqry="select substr(hab_code,1,2),substr(hab_code,6,2),TYPE_OF_ASSET_NAME,count(1) from  RWS_ASSET_MAST_TBL a,RWS_ASSET_TYPE_TBL b where a.TYPE_OF_ASSET_CODE=b.TYPE_OF_ASSET_CODE and  SUBSTR(HAB_CODE,1,2)='"+district+"' ";
	   if(mandal!=null && !mandal.equals("00")){
		   assetqry+=" and SUBSTR(HAB_CODE,6,2)='"+mandal+"'";
			}
	   assetqry+=" group by substr(hab_code,1,2),substr(hab_code,6,2),TYPE_OF_ASSET_NAME";
	   //System.out.println("assetqry qry is"+assetqry);
	   Hashtable assethash = new Hashtable();
	   rs7=stmt7.executeQuery(assetqry);
	   while(rs7.next()){
		 assethash.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(3),rs7.getInt(4));
	   }
	   if(rs7!=null){
			rs7.close();
		}
		if(stmt7!=null){
			stmt7.close();
		}
		stmt7=conn.createStatement();
		 String workqry="select  substr(c.hab_code,1,2),substr(c.hab_code,6,2),sum(case c.hab_code when a.LEAD_HABITATION then 1 else 0 end) as mvscount,sum(case CATEGORY_CODE when '2' then 1 else 0 end) as svscount,sum(nvl(SANCTION_AMOUNT,0)),sum(case CATEGORY_CODE when '1' then nvl(sanction_amount,0) else 0 end) as mvsamnt,sum(case CATEGORY_CODE when '2' then nvl(sanction_amount,0) else 0 end) as svsamnt,count(distinct c.hab_code),count(distinct(case c.coverage_status when 'FC' then c.hab_code else '-' end)),count(distinct(case c.coverage_status when 'PC4' then c.hab_code else '-' end)),count(distinct(case c.coverage_status when 'PC3' then c.hab_code else '-' end)),count(distinct(case c.coverage_status when 'PC2' then c.hab_code else '-' end)),count(distinct(case c.coverage_status when 'PC1' then c.hab_code else '-' end))  from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_COMPLETE_HAB_VIEW d where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.hab_code=d.panch_code  and  SUBSTR(c.HAB_CODE,1,2)='"+district+"' ";
		   if(mandal!=null && !mandal.equals("00")){
			   workqry+=" and SUBSTR(c.HAB_CODE,6,2)='"+mandal+"'";
				}
		   workqry+=" group by substr(c.hab_code,1,2),substr(c.hab_code,6,2)";
		   //System.out.println("workqry qry is"+workqry);
		   Hashtable workhash = new Hashtable();
		   rs7=stmt7.executeQuery(workqry);
		   while(rs7.next()){
			  workhash.put(rs7.getString(1)+rs7.getString(2),rs7.getInt(3)+"@"+rs7.getInt(4)+"@"+rs7.getString(5)+"@"+rs7.getString(6)+"@"+rs7.getString(7)+"@"+rs7.getInt(8)+"@"+rs7.getInt(9)+"@"+rs7.getInt(10)+"@"+rs7.getInt(11)+"@"+rs7.getInt(12)+"@"+rs7.getInt(13));
		   }
		   if(rs7!=null){
				rs7.close();
			}
			if(stmt7!=null){
				stmt7.close();
			}
			stmt7=conn.createStatement();
			 String workhabtypeqry="select  substr(c.hab_code,1,2),substr(c.hab_code,6,2),count(distinct c.hab_code),c.coverage_status   from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_COMPLETE_HAB_VIEW d where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.hab_code=d.panch_code  and  SUBSTR(c.HAB_CODE,1,2)='"+district+"' ";
			   if(mandal!=null && !mandal.equals("00")){
				   workhabtypeqry+=" and SUBSTR(c.HAB_CODE,6,2)='"+mandal+"'";
					}
			   workhabtypeqry+=" group by substr(c.hab_code,1,2),substr(c.hab_code,6,2),c.coverage_status";
			   //System.out.println("workhabtypeqry qry is"+workhabtypeqry);
			   Hashtable workhabhash = new Hashtable();
			   rs7=stmt7.executeQuery(workhabtypeqry);
			   while(rs7.next()){
				   workhabhash.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(4),rs7.getInt(3));
			   }
			   if(rs7!=null){
					rs7.close();
				}
				if(stmt7!=null){
					stmt7.close();
				}
			
			stmt7=conn.createStatement();
			 String worksrctypeqry="select  substr(c.hab_code,1,2),substr(c.hab_code,6,2),e.CONTAMINATION_CODE,count(1)  from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_HAB_CONTAMINATION_TBL d,RWS_CONTAMINATION_TBL e,RWS_COMPLETE_HAB_VIEW f where WORK_CANCEL_DT is null and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and a.work_id=b.work_id and b.hab_code=c.hab_code and c.hab_code=f.panch_code and c.hab_code=d.hab_code  and d.CONT_TYPE=e.CONTAMINATION_CODE  and  SUBSTR(c.HAB_CODE,1,2)='"+district+"' ";
			   if(mandal!=null && !mandal.equals("00")){
				   worksrctypeqry+=" and SUBSTR(c.HAB_CODE,6,2)='"+mandal+"'";
					}
			   worksrctypeqry+=" group by substr(c.hab_code,1,2),substr(c.hab_code,6,2),e.CONTAMINATION_CODE";
			  // System.out.println("worksrctypeqry qry is"+worksrctypeqry);
			   Hashtable worksrchash = new Hashtable();
			   rs7=stmt7.executeQuery(worksrctypeqry);
			   while(rs7.next()){
				   worksrchash.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(3),rs7.getInt(4));
			   }
			   if(rs7!=null){
					rs7.close();
				}
				if(stmt7!=null){
					stmt7.close();
				}
				
				stmt7=conn.createStatement();
				String mainhabqry="select d.dcode,m.mcode,coverage_status,count(distinct h.panch_code) from rws_district_tbl d,rws_mandal_tbl m,RWS_CONSTITUENCY_TBL c,RWS_PANCHAYAT_TBL p,RWS_PANCHAYAT_RAJ_TBL r,RWS_COMPLETE_HAB_VIEW h where d.dcode=m.dcode and c.dcode=m.dcode and c.mcode=m.mcode and p.dcode=m.dcode and p.mcode=m.mcode and SUBSTR(r.PANCH_CODE,1,2)=d.dcode and SUBSTR(r.PANCH_CODE,6,2)=m.mcode and SUBSTR(r.PANCH_CODE,13,2)=p.pcode and r.panch_code=h.PANCH_CODE and d.dcode='"+district+"' ";
				 
				   if(!mandal.equals("00")){
					   mainhabqry+="and m.mcode='"+mandal+"' ";
						}
					 
				   mainhabqry+="group by d.dcode,m.mcode,coverage_status";
				  	  // System.out.println("worksrctypeqry qry is"+worksrctypeqry);
				   Hashtable mainhabhash = new Hashtable();
				   rs7=stmt7.executeQuery(mainhabqry);
				   while(rs7.next()){
					   mainhabhash.put(rs7.getString(1)+rs7.getString(2)+rs7.getString(3),rs7.getInt(4));
				   }
				   if(rs7!=null){
						rs7.close();
					}
					if(stmt7!=null){
						stmt7.close();
					}	
				
			
   stmt8=conn.createStatement();
   String mainqry="select d.dcode,d.dname,m.mcode,m.mname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_name,count(distinct p.pcode),count(r.panch_code),sum(nvl(CENSUS_PLAIN_POPU,0)),sum(nvl(CENSUS_SC_POPU,0)),sum(nvl(CENSUS_ST_POPU,0)),sum(nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0)),count(distinct(case coverage_status when 'FC' then r.panch_code else '-' end)),count(distinct(case coverage_status when 'PC4' then r.panch_code else '-' end)),count(distinct(case coverage_status when 'PC3' then r.panch_code else '-' end)),count(distinct(case coverage_status when 'PC2' then r.panch_code else '-' end)),count(distinct(case coverage_status when 'PC1' then r.panch_code else '-' end)) from rws_district_tbl d,rws_mandal_tbl m,RWS_CONSTITUENCY_TBL c,RWS_PANCHAYAT_TBL p,RWS_PANCHAYAT_RAJ_TBL r,RWS_COMPLETE_HAB_VIEW h where d.dcode=m.dcode and c.dcode=m.dcode and c.mcode=m.mcode and p.dcode=m.dcode and p.mcode=m.mcode and SUBSTR(r.PANCH_CODE,1,2)=d.dcode and SUBSTR(r.PANCH_CODE,6,2)=m.mcode and SUBSTR(r.PANCH_CODE,13,2)=p.pcode and r.panch_code=h.PANCH_CODE and d.dcode='"+district+"' ";
 
   if(!mandal.equals("00")){
	   mainqry+="and m.mcode='"+mandal+"' ";
		}
	 
   mainqry+="group by d.dcode,d.dname,m.mcode,m.mname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_name order by d.dcode,m.mcode,CONSTITUENCY_CODE";
   //System.out.println("main qry is"+mainqry);
	rs8=stmt8.executeQuery(mainqry);
	int totplainpop=0,totscpop=0,totstpop=0,totpop=0,totfc=0,totpc4=0,totpc3=0,totpc2=0,totpc1=0,totsanhabsfl=0,totsanhabsbr=0,totsanhabsir=0,totsanhabsnit=0,totmainfc=0,totmainpc4=0,totmainpc3=0,totmainpc2=0,totmainpc1=0;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0,totwrkmvscnt=0,totwrksvs=0,tottotwrk=0;
	double totmvsamnt=0.0,totsvsamnt=0.0,tottotamnt=0.0;
	int totflcnt=0,totbrcnt=0,totircnt=0,totnitcnt=0,totsanhabs=0,totgps=0,tothabs=0,totsanhabsfc=0,totsanhabspc4=0,totsanhabspc3=0,totsanhabspc2=0,totsanhabspc1=0;
	session.setAttribute("workhash",workhash);
	   session.setAttribute("qahash",qahash);
	   session.setAttribute("assethash",assethash);
	   session.setAttribute("svshabsplitamnthash",svshabsplitamnthash);
	   session.setAttribute("mvshabsplitamnthash",mvshabsplitamnthash);
	   session.setAttribute("mainhabhash",mainhabhash);
	   session.setAttribute("worksrchash",worksrchash);
	   session.setAttribute("workhabhash",workhabhash);
		
	while(rs8.next()){
		int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,wrkmvscnt=0,wrksvs=0,totwrk=0,sanhabsfl=0,sanhabsbr=0,sanhabsir=0,sanhabsnit=0;
		int flcnt=0,brcnt=0,ircnt=0,nitcnt=0,sanhabs=0,sanhabsfc=0,sanhabspc4=0,sanhabspc3=0,sanhabspc2=0,sanhabspc1=0,mainfc=0,mainpc4=0,mainpc3=0,mainpc2=0,mainpc1=0;
		double mvsamnt=0.0,svsamnt=0.0,totamnt=0.0;
if(mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"FC")!=null){
			
			mainfc=(Integer)mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"FC");
				}
if(mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC4")!=null){
			
	mainpc4=(Integer)mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC4");
				}
if(mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC3")!=null){
	
	mainpc3=(Integer)mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC3");
		}
if(mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC2")!=null){
	
	mainpc2=(Integer)mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC2");
		}
if(mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC1")!=null){
	
	mainpc1=(Integer)mainhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC1");
		}
		
		
		
		
		
		if(workhabhash.get(rs8.getString(1)+rs8.getString(3)+"FC")!=null){
			
			sanhabsfc=(Integer)workhabhash.get(rs8.getString(1)+rs8.getString(3)+"FC");
				}
if(workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC4")!=null){
			
			sanhabspc4=(Integer)workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC4");
				}
if(workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC3")!=null){
	
	sanhabspc3=(Integer)workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC3");
		}
if(workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC2")!=null){
	
	sanhabspc2=(Integer)workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC2");
		}
if(workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC1")!=null){
	
	sanhabspc1=(Integer)workhabhash.get(rs8.getString(1)+rs8.getString(3)+"PC1");
		}
		
		
if(worksrchash.get(rs8.getString(1)+rs8.getString(3)+"01")!=null){
			
	sanhabsfl=(Integer)worksrchash.get(rs8.getString(1)+rs8.getString(3)+"01");
		}
if(worksrchash.get(rs8.getString(1)+rs8.getString(3)+"02")!=null){
	
	sanhabsbr=(Integer)worksrchash.get(rs8.getString(1)+rs8.getString(3)+"02");
		}
if(worksrchash.get(rs8.getString(1)+rs8.getString(3)+"03")!=null){
	
	sanhabsir=(Integer)worksrchash.get(rs8.getString(1)+rs8.getString(3)+"03");
		}
if(worksrchash.get(rs8.getString(1)+rs8.getString(3)+"05")!=null){
	
	sanhabsnit=(Integer)worksrchash.get(rs8.getString(1)+rs8.getString(3)+"05");
		}
		
		if(workhash.get(rs8.getString(1)+rs8.getString(3))!=null){
			 
			
			String expValues=(String)workhash.get(rs8.getString(1)+rs8.getString(3));
			String exp[]=expValues.split("@");
			wrkmvscnt=Integer.parseInt(exp[0]);
			wrksvs=Integer.parseInt(exp[1]);
			//if(exp[2]!=null || !exp[2].equals("")){
				//totamnt=Double.parseDouble(exp[2]);
			//}
			//if(exp[3]!=null || !exp[3].equals("")){
			//	mvsamnt=Double.parseDouble(exp[3]);
			//}
			//if(exp[4]!=null || !exp[4].equals("")){
			//	svsamnt=Double.parseDouble(exp[4]);
			//}
			totwrk=wrkmvscnt+wrksvs;
			sanhabs=Integer.parseInt(exp[5]);
			
			
		}
		
		if(svshabsplitamnthash.get(rs8.getString(1)+rs8.getString(3))!=null){
			svsamnt=(Double)svshabsplitamnthash.get(rs8.getString(1)+rs8.getString(3));
		}
		if(mvshabsplitamnthash.get(rs8.getString(1)+rs8.getString(3))!=null){
			mvsamnt=(Double)mvshabsplitamnthash.get(rs8.getString(1)+rs8.getString(3));
		}
		totamnt=svsamnt+mvsamnt;
		if(qahash.get(rs8.getString(1)+rs8.getString(3)+"01")!=null){
			
			flcnt=(Integer)qahash.get(rs8.getString(1)+rs8.getString(3)+"01");
		}
		if(qahash.get(rs8.getString(1)+rs8.getString(3)+"02")!=null){
			
			brcnt=(Integer)qahash.get(rs8.getString(1)+rs8.getString(3)+"02");
		}
		if(qahash.get(rs8.getString(1)+rs8.getString(3)+"03")!=null){
			
			ircnt=(Integer)qahash.get(rs8.getString(1)+rs8.getString(3)+"03");
		}
		if(qahash.get(rs8.getString(1)+rs8.getString(3)+"05")!=null){
			
			nitcnt=(Integer)qahash.get(rs8.getString(1)+rs8.getString(3)+"05");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"CPWS")!=null){
			cpwscnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"CPWS");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"PWS")!=null){
			pwscnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"PWS");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"MPWS")!=null){
			mpwscnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"MPWS");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"DIRECT PUMPING")!=null){
			dpcnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"DIRECT PUMPING");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"HANDPUMPS")!=null){
			hpcnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"HANDPUMPS");
		}
		if(assethash.get(rs8.getString(1)+rs8.getString(3)+"SHALLOW HAND PUMPS")!=null){
			shpcnt=(Integer)assethash.get(rs8.getString(1)+rs8.getString(3)+"SHALLOW HAND PUMPS");
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
			 <td class=<%=style %> style="text-align: left;"><%=mname %></td>
			 <td class=<%=style %> style="text-align: left;"><%=cname %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(7) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(8) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(9) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(10) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(11) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=rs8.getInt(12) %></td>
			 <td class=<%=style %> style="text-align: right;"><%=mainfc %></td>
			 <td class=<%=style %> style="text-align: right;"><%=mainpc4 %></td>
			 <td class=<%=style %> style="text-align: right;"><%=mainpc3 %></td>
			 <td class=<%=style %> style="text-align: right;"><%=mainpc2 %></td>
			 <td class=<%=style %> style="text-align: right;"><%=mainpc1 %></td>
		
			  <td class=<%=style %> style="text-align: right;"><%=flcnt %></td>
			  <td class=<%=style %> style="text-align: right;"><%=brcnt %></td>
			  <td class=<%=style %> style="text-align: right;"><%=ircnt %></td>
			  <td class=<%=style %> style="text-align: right;"><%=nitcnt %></td>
			  <td class=<%=style %> style="text-align: right;"><%=cpwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=pwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=mpwscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=dpcnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=hpcnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=shpcnt %></td>
			  <td class=<%=style %> style="text-align: right;"><%=wrkmvscnt %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(mvsamnt) %></td>
 <td class=<%=style %> style="text-align: right;"><%=wrksvs %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(svsamnt) %></td>
 <td class=<%=style %> style="text-align: right;"><%=totwrk %></td>
 <td class=<%=style %> style="text-align: right;"><%=ndf.format(totamnt) %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabs %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabsfc %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabspc4 %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabspc3 %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabspc2 %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabspc1 %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabsfl %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabsbr %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabsir %></td>
			  <td class=<%=style %> style="text-align: right;"><%=sanhabsnit %></td>
			  
			 </tr>
<%
totgps+=rs8.getInt(7);
tothabs+=rs8.getInt(8);
totplainpop+=rs8.getInt(9);
totscpop+=rs8.getInt(10);
totstpop+=rs8.getInt(11);totpop+=rs8.getInt(12);
totfc+=rs8.getInt(13);totpc4+=rs8.getInt(14);totpc3+=rs8.getInt(15);totpc2+=rs8.getInt(16);totpc1+=rs8.getInt(17);
totcpwscnt+=cpwscnt;totpwscnt+=pwscnt;totmpwscnt+=mpwscnt;totdpcnt+=dpcnt;tothpcnt+=hpcnt;totshpcnt+=shpcnt;totwrkmvscnt+=wrkmvscnt;
totwrksvs+=wrksvs;tottotwrk+=totwrk;
totmvsamnt+=mvsamnt;totsvsamnt+=svsamnt;tottotamnt+=totamnt;
totflcnt+=flcnt;totbrcnt+=brcnt;totircnt+=ircnt;totnitcnt+=nitcnt;totsanhabs+=sanhabs;
totsanhabsfc+=sanhabsfc;
totsanhabspc4+=sanhabspc4;
totsanhabspc3+=sanhabspc3;
totsanhabspc2+=sanhabspc2;
totsanhabspc1+=sanhabspc1;
totmainfc=mainfc;
totmainpc4=mainpc4;
totmainpc3=mainpc3;
totmainpc2=mainpc2;
totmainpc1=mainpc1;
sno++;
tdname=rs8.getString(2);
tmname=rs8.getString(4);
tpname=rs8.getString(8);
tcname=rs8.getString(6);
	}
	%>
	 <tr>
  <td class=gridhdbg colspan=4>Total</td>
  <td class=gridhdbg><%=totgps %></td>
  <td class=gridhdbg><%=tothabs %></td>
   <td class=gridhdbg><%=totplainpop %></td>
   <td class=gridhdbg><%=totscpop %></td>
   <td class=gridhdbg><%=totstpop %></td>
   <td class=gridhdbg><%=totpop %></td>
   <td class=gridhdbg><%=totmainfc %></td>
   <td class=gridhdbg><%=totmainpc4 %></td>
   <td class=gridhdbg><%=totmainpc3 %></td>
   <td class=gridhdbg><%=totmainpc2 %></td>
   <td class=gridhdbg><%=totmainpc1 %></td>
   
   <td class=gridhdbg><%=totflcnt %></td>
   <td class=gridhdbg><%=totbrcnt %></td>
   <td class=gridhdbg><%=totircnt %></td>
   <td class=gridhdbg><%=totnitcnt %></td>
   
   <td class=gridhdbg style="text-align: left;"><%=totcpwscnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=totpwscnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=totmpwscnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=totdpcnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=tothpcnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=totshpcnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=totwrkmvscnt %></td>
 <td class=gridhdbg style="text-align: left;"><%=ndf.format(totmvsamnt) %></td>
 <td class=gridhdbg style="text-align: left;"><%=totwrksvs %></td>
 <td class=gridhdbg style="text-align: left;"><%=ndf.format(totsvsamnt) %></td>
 <td class=gridhdbg style="text-align: left;"><%=tottotwrk %></td>
 <td class=gridhdbg style="text-align: left;"><%=ndf.format(tottotamnt) %></td>
 <td class=gridhdbg><%=totsanhabs %></td>
 <td class=gridhdbg style="text-align: right;"><%=totsanhabsfc %></td>
 <td class=gridhdbg style="text-align: right;"><%=totsanhabspc4 %></td>
 <td class=gridhdbg style="text-align: right;"><%=totsanhabspc3 %></td>
 <td class=gridhdbg style="text-align: right;"><%=totsanhabspc2 %></td>
 <td class=gridhdbg style="text-align: right;"><%=totsanhabspc1 %></td>
 <td class=gridhdbg><%=totsanhabsfl %></td>
 <td class=gridhdbg><%=totsanhabsbr %></td>
 <td class=gridhdbg><%=totsanhabsir %></td>
 <td class=gridhdbg><%=totsanhabsnit %></td>
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