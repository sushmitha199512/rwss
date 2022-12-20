<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>


<form>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "assetabstractreport.xls");
String mandal="";
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");
String district=(String)session.getAttribute("district");
if(session.getAttribute("mandal")!=null){
mandal=(String)session.getAttribute("mandal");}

System.out.println("mandal"+mandal);

    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>

   
   <table width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td class=gridhdbg colspan="32">RWS&S-Constituency wise status and assets information(ABSTRACT)</td>
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
	<td class=gridhdbg rowspan=1 colspan="7">Ongoing Works(Rs. Lakhs)</td>	
    
    
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
       </tr>
     <tr>
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
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   
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
	Hashtable qahash = (Hashtable)session.getAttribute("qahash");
	Hashtable workhash = (Hashtable)session.getAttribute("workhash");
	Hashtable assethash = (Hashtable)session.getAttribute("assethash");
	Hashtable svshabsplitamnthash = (Hashtable)session.getAttribute("svshabsplitamnthash");
	Hashtable mvshabsplitamnthash = (Hashtable)session.getAttribute("mvshabsplitamnthash");
	Hashtable mainhabhash = (Hashtable)session.getAttribute("mainhabhash");
	Hashtable workhabhash = (Hashtable)session.getAttribute("workhabhash");
	Hashtable worksrchash = (Hashtable)session.getAttribute("worksrchash");
	
	
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
