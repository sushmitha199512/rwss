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
if(session.getAttribute("constituency")!=null){
mandal=(String)session.getAttribute("constituency");

}

    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	
   
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
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   int sno=1;
   
   String dname="",mname="",pname="",tdname="",tmname="",tpname="",cname="",tcname="";
  
   stmt8=conn.createStatement();
   String mainqry="select d.dcode,d.dname,m.mcode,m.mname,c.CONSTITUENCY_CODE,c.CONSTITUENCY_name,p.pcode,p.pname,r.panch_code,r.panch_name,nvl(h.coverage_status,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_PLAIN_POPU,0) from rws_district_tbl d,rws_mandal_tbl m,RWS_CONSTITUENCY_TBL c,RWS_PANCHAYAT_TBL p,RWS_PANCHAYAT_RAJ_TBL r,RWS_COMPLETE_HAB_VIEW h where d.dcode=m.dcode and c.dcode=m.dcode and c.mcode=m.mcode and p.dcode=m.dcode and p.mcode=m.mcode and SUBSTR(r.PANCH_CODE,1,2)=d.dcode and SUBSTR(r.PANCH_CODE,6,2)=m.mcode and SUBSTR(r.PANCH_CODE,13,2)=p.pcode and r.panch_code=h.PANCH_CODE and d.dcode='"+district+"' ";
 
   if(mandal!=null && !mandal.equals("00")){
	   mainqry+="and c.CONSTITUENCY_CODE='"+mandal+"'";
		}
	 
   mainqry+=" order by d.dcode,m.mcode,CONSTITUENCY_CODE,p.pcode,r.panch_code";
   //System.out.println("main qry is"+mainqry);
   Hashtable qahash = (Hashtable)session.getAttribute("qahash");
	Hashtable workhash = (Hashtable)session.getAttribute("workhash");
	Hashtable assethash = (Hashtable)session.getAttribute("assethash");
	Hashtable svshabsplitamnthash = (Hashtable)session.getAttribute("svshabsplitamnthash");
	Hashtable mvshabsplitamnthash = (Hashtable)session.getAttribute("mvshabsplitamnthash");
	Hashtable assetcosthash = (Hashtable)session.getAttribute("assetcosthash");
	Hashtable cpwsassetcosthash = (Hashtable)session.getAttribute("cpwsassetcosthash");
	
	rs8=stmt8.executeQuery(mainqry);
	int totplainpop=0,totscpop=0,totstpop=0,totpop=0;
	int totcpwscnt=0,totpwscnt=0,totmpwscnt=0,totdpcnt=0,tothpcnt=0,totshpcnt=0,totwrkmvscnt=0,totwrksvs=0,tottotwrk=0;
	double totmvsamnt=0.0,totsvsamnt=0.0,tottotamnt=0.0,totalassetcost=0.0;
	while(rs8.next()){
		String conttype="-";
		int cpwscnt=0,pwscnt=0,mpwscnt=0,dpcnt=0,hpcnt=0,shpcnt=0,wrkmvscnt=0,wrksvs=0,totwrk=0;
		
		double mvsamnt=0.0,svsamnt=0.0,totamnt=0.0,habassetcost=0.0;
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
			wrkmvscnt=Integer.parseInt(exp[0]);
			wrksvs=Integer.parseInt(exp[1]);
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
	   <td class=gridhdbg style="text-align: left;"><%=totcpwscnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totpwscnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totmpwscnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totdpcnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=tothpcnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totshpcnt %></td>
	  <td class=gridhdbg style="text-align: right;"><%=ndf.format(totalassetcost) %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totwrkmvscnt %></td>
	 <td class=gridhdbg style="text-align: left;"><%=ndf.format(totmvsamnt) %></td>
	 <td class=gridhdbg style="text-align: left;"><%=totwrksvs %></td>
	 <td class=gridhdbg style="text-align: left;"><%=ndf.format(totsvsamnt) %></td>
	 <td class=gridhdbg style="text-align: left;"><%=tottotwrk %></td>
	 <td class=gridhdbg style="text-align: left;"><%=ndf.format(tottotamnt) %></td>
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
