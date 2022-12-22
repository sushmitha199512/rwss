<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/tgrwss/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/tgrwss/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{
//var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	//if(URL!="")
	//{
	//	myNewWin = window.open(URL,'newWinddow',popFeatures);
	//	myNewWin.focus();	
	//}	
	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);

  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();


    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	<td><a href="./rws_bls_abstract_excel.jsp" target=_new>Excel</a></td>
	    
	</tr>  
	</table>
	</caption>
	
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    <tr >
	<td align="center" class=gridhdbg colspan=28> Base Line Survey - Abstract Report</td>
	</tr>
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=1 colspan="6">Water Facility</td>
    <td class=gridhdbg rowspan=1 colspan="4">Govt Building IN GP</td>
    <td class=gridhdbg rowspan=1 colspan="4">VWSCommitte</td>
    <td class=gridhdbg rowspan=1 colspan="4">CommunitySanitary</td>
    <td class=gridhdbg rowspan=1 colspan="8">OtherOrganizations</td>
    
    </tr>
    <tr>
    <td class=gridhdbg >Total StandPosts</td>
    <td class=gridhdbg >Total Households</td>
   <td class=gridhdbg> Total Multi StandPost</td>
    <td class=gridhdbg> Total Multi Households </td>
    <td class=gridhdbg >Total Pumps </td>
    <td class=gridhdbg >Total OpenWell </td>
    
    
    <td class=gridhdbg >Latrine Facility<br>(Yes) </td>
    <td class=gridhdbg >Latrine Facility<br>(No) </td>
    <td class=gridhdbg >Water Facility<br>(Yes) </td>
    <td class=gridhdbg >Water Facility<br>(No) </td>
  
     <td class=gridhdbg >VWSC is Formed<br>(Yes) </td>
    <td class=gridhdbg >VWSC is Formed	<br>(No) </td>
    <td class=gridhdbg >VWSC is Functional<br>(Yes) </td>
    <td class=gridhdbg >VWSC is Functional<br>(No) </td>
    
    
    
    <td class=gridhdbg >Total CSC Constructed </td>
    <td class=gridhdbg >Total Functional CSC</td>
    <td class=gridhdbg >Total Defunct CSC </td>
    <td class=gridhdbg >No.of Additional CSC Required</td>
	
	 <td class=gridhdbg >NGOS<br>(Yes)</td>
    <td class=gridhdbg >NGOS<br>(No)</td>
    <td class=gridhdbg >SHGS<br>(Yes)</td>
    <td class=gridhdbg >SHGS<br>(No)</td>
    <td class=gridhdbg >Women Groups<br>(Yes)</td>
    <td class=gridhdbg >Women Groups<br>(No)</td>
    <td class=gridhdbg >Other Groups <br>(Yes)</td>
    <td class=gridhdbg>Other Groups <br>(No)</td>
	</tr>
	<tr>
	<%for(int i=1;i<29;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
       
<%
try
{
	


   //main qry
   Statement stmt3=null,stmt4=null;
   ResultSet rs3=null,rs4=null;
   int sno=1;
 ///Water Facility qry

	stmt3=conn.createStatement();
	   
	String waterfacqry="select dcode,sum(TOTAL_STANDPOSTS),sum(TOTAL_HOUSEHOLDS),sum(TOTAL_MULTI_STANDPOST),sum(TOTAL_MULTI_HOUSEHOLDS),sum(TOTAL_PUMPS),sum(TOTAL_OPENWELL) from rws_bls_water_fac_Inhab_tbl ,rws_district_tbl  where substr(habitation_code,1,2)=dcode  ";

	if(dcode!=null && !dcode.equals("00")){
		waterfacqry+="and dcode='"+dcode+"'";
			}
	waterfacqry+=" group by dcode order by dcode";

	//System.out.println("qryyy1"+waterfacqry);
	Hashtable water_fac_hash = new Hashtable();
	rs3=stmt3.executeQuery(waterfacqry);
	   while(rs3.next())
	   {
		   water_fac_hash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7));
			
	   }
	   if(stmt3!=null){
		   stmt3.close();
		}
		if(rs3!=null){
				rs3.close();
		}  
 
 
 ///Govt buliding qry
 stmt3=conn.createStatement();
   
String govtqry="select dcode,sum(case when LATRINE_FACILITY='Yes' then 1 else 0  end ),sum(case when LATRINE_FACILITY='No' then 1 else 0 end ),sum(case when WATER_FACILITY='Yes' then 1 else 0  end ),sum(case when WATER_FACILITY='No' then 1 else 0 end )from RWS_BLS_GOVTBLDG_INGP_TBL ,rws_district_tbl  where substr(habitation_code,1,2)=dcode ";

if(dcode!=null && !dcode.equals("00")){
	govtqry+="and dcode='"+dcode+"'";
		}
govtqry+=" group by dcode order by dcode";

//System.out.println("qryyy2"+govtqry);
Hashtable govt_lf_hash = new Hashtable();
rs3=stmt3.executeQuery(govtqry);
   while(rs3.next())
   {
	   govt_lf_hash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5));
		
   }
   if(stmt3!=null){
	   stmt3.close();
	}
	if(rs3!=null){
			rs3.close();
	}
  // VWM Commity qry
  
	stmt3=conn.createStatement();
	   
	String vwmqry="select dcode,sum(case when VWSC_FORMED='Yes' then 1 else 0  end ),sum(case when VWSC_FORMED='No' then 1 else 0 end ),sum(case when VWSM_FUNCTIONAL='Yes' then 1 else 0  end ),sum(case when VWSM_FUNCTIONAL='No' then 1 else 0 end )from rws_bls_vwm_comm_tbl ,rws_district_tbl  where substr(habitation_code,1,2)=dcode ";

	if(dcode!=null && !dcode.equals("00")){
		vwmqry+="and dcode='"+dcode+"'";
			}
	vwmqry+=" group by dcode order by dcode";

	//System.out.println("qryyy3"+vwmqry);
	Hashtable vwm_comm_hash = new Hashtable();
	rs3=stmt3.executeQuery(vwmqry);
	   while(rs3.next())
	   {
		   vwm_comm_hash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5));
			
	   }
	   if(stmt3!=null){
		   stmt3.close();
		}
		if(rs3!=null){
				rs3.close();
		}  
   
   //Community Sanitation qry 

		stmt3=conn.createStatement();
		   
		String commsantnqry="select dcode,sum(TOTAL_CSC_CONSTRUCTED),sum(TOTAL_FUNCTIONAL_CSC) ,sum(TOTAL_DEFUNCT_CSC),sum(NO_OFF_ADDL_CSC_REQ) from rws_bls_comm_sani_comp_tbl ,rws_district_tbl  where substr(habitation_code,1,2)=dcode  ";

		if(dcode!=null && !dcode.equals("00")){
			commsantnqry+="and dcode='"+dcode+"'";
				}
		commsantnqry+=" group by dcode order by dcode";

		//System.out.println("qryyy4"+commsantnqry);
		Hashtable comm_santn_hash = new Hashtable();
		rs3=stmt3.executeQuery(commsantnqry);
		   while(rs3.next())
		   {
			   comm_santn_hash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5));
				
		   }
		   if(stmt3!=null){
			   stmt3.close();
			}
			if(rs3!=null){
					rs3.close();
			}  
   
   //Other Organisations qry
		stmt3=conn.createStatement();
		   
		String orgqry="select dcode,sum(case when NGOS ='Yes' then 1 else 0  end ),sum(case when NGOS ='No' then 1 else 0 end ),sum(case when SHGS='Yes' then 1 else 0  end ),sum(case when SHGS='No' then 1 else 0 end ),sum(case when WOMEN_GRPS ='Yes' then 1 else 0  end ),sum(case when WOMEN_GRPS ='No' then 1 else 0 end ),sum(case when OTHER_GRPS ='Yes' then 1 else 0  end ),sum(case when OTHER_GRPS='No' then 1 else 0 end )from rws_bls_other_org_ingp_tbl  ,rws_district_tbl  where substr(habitation_code,1,2)=dcode ";

		if(dcode!=null && !dcode.equals("00")){
			orgqry+="and dcode='"+dcode+"'";
				}
		orgqry+=" group by dcode order by dcode";

		//System.out.println("qryyy5"+orgqry);
		Hashtable other_org_hash = new Hashtable();
		rs3=stmt3.executeQuery(orgqry);
		   while(rs3.next())
		   {
			   other_org_hash.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7)+"@"+rs3.getString(8)+"@"+rs3.getString(9));
				
		   }
		   if(stmt3!=null){
			   stmt3.close();
			}
			if(rs3!=null){
					rs3.close();
			}  
			session.setAttribute("water_fac_hash",water_fac_hash);
			session.setAttribute("govt_lf_hash",govt_lf_hash);
			session.setAttribute("vwm_comm_hash",vwm_comm_hash);
			session.setAttribute("comm_santn_hash",comm_santn_hash);
			session.setAttribute("other_org_hash",other_org_hash);
%>


<%
    int g23=0,g24=0,g25=0,g26=0,g27=0,g28=0,g3=0,g4=0,g5=0,g6=0,g7=0,g8=0,g9=0,g10=0,g11=0,g12=0,g13=0,g14=0,g15=0,g16=0,g17=0,g18=0,g19=0,g20=0,g21=0,g22=0; 
     String mainqry="select dcode,dname from rws_district_tbl where dcode<>'16' ";
if(dcode!=null && !dcode.equals("00")){
	mainqry+=" and dcode='"+dcode+"'";
		}
mainqry+="  order by dcode";
   stmt4=conn.createStatement();
   rs4=stmt4.executeQuery(mainqry);
   while(rs4.next())
   {
	   
       int lfyes=0,lfno=0,wfyes=0,wfno=0,vwscyes=0,vwscno=0,vwsmyes=0,vwsmno=0,cscc=0,cscf=0,cscd=0,csca=0,ngoyes=0,ngono=0,shgsyes=0,shgsno=0,wgyes=0,wgno=0,othrgyes=0,othrgno=0;
       int ts=0,th=0,tms=0,tmh=0,tp=0,to=0;
       if(water_fac_hash.get(rs4.getString(1))!=null){
			String wf = (String) water_fac_hash.get(rs4.getString(1));
			String wfvalues[]=wf.split("@");
			ts = Integer.parseInt(wfvalues[0]);
			th = Integer.parseInt(wfvalues[1]);
			tms=Integer.parseInt(wfvalues[2]);
			tmh=Integer.parseInt(wfvalues[3]);
			tp=Integer.parseInt(wfvalues[4]);
			to=Integer.parseInt(wfvalues[5]);
	   }
       
       
       if(govt_lf_hash.get(rs4.getString(1))!=null){
			String govt = (String) govt_lf_hash.get(rs4.getString(1));
			String govtvalues[]=govt.split("@");
			lfyes = Integer.parseInt(govtvalues[0]);
			lfno = Integer.parseInt(govtvalues[1]);
			wfyes=Integer.parseInt(govtvalues[2]);
			wfno=Integer.parseInt(govtvalues[3]);
	   }
	   if(vwm_comm_hash.get(rs4.getString(1))!=null){
			String vwm = (String) vwm_comm_hash.get(rs4.getString(1));
			String vwmvalues[]=vwm.split("@");
			vwscyes = Integer.parseInt(vwmvalues[0]);
			vwscno = Integer.parseInt(vwmvalues[1]);
			vwsmyes=Integer.parseInt(vwmvalues[2]);
			vwsmno=Integer.parseInt(vwmvalues[3]);
	   }
	   if(comm_santn_hash.get(rs4.getString(1))!=null){
			String cs = (String) comm_santn_hash.get(rs4.getString(1));
			String csvalues[]=cs.split("@");
			cscc = Integer.parseInt(csvalues[0]);
			cscf = Integer.parseInt(csvalues[1]);
			cscd=Integer.parseInt(csvalues[2]);
			csca=Integer.parseInt(csvalues[3]);
	   }
	   if(other_org_hash.get(rs4.getString(1))!=null){
			String org = (String) other_org_hash.get(rs4.getString(1));
			String orgvalues[]=org.split("@");
			ngoyes = Integer.parseInt(orgvalues[0]);
			ngono = Integer.parseInt(orgvalues[1]);
			shgsyes=Integer.parseInt(orgvalues[2]);
			shgsno=Integer.parseInt(orgvalues[3]);
			wgyes = Integer.parseInt(orgvalues[4]);
			wgno = Integer.parseInt(orgvalues[5]);
			othrgyes=Integer.parseInt(orgvalues[6]);
			othrgno=Integer.parseInt(orgvalues[7]);
	   }

		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;   
      
%>

	 <!-- printing td should b written here -->
   	<tr>
	
      <td  class="<%=style%>" style="text-align:  left;"> <%=sno++%></td>
      <td  class="<%=style%>" style="text-align: left;"> <%=rs4.getString(2)%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=23&dcode=<%=rs4.getString(1) %>')"> <%=ts%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=24&dcode=<%=rs4.getString(1) %>')"> <%=th%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=25&dcode=<%=rs4.getString(1) %>')"> <%=tms%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=26&dcode=<%=rs4.getString(1) %>')"> <%=tmh%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=27&dcode=<%=rs4.getString(1) %>')"> <%=tp%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=28&dcode=<%=rs4.getString(1) %>')"> <%=to%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=3&dcode=<%=rs4.getString(1) %>')"> <%=lfyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=4&dcode=<%=rs4.getString(1) %>')"> <%=lfno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=5&dcode=<%=rs4.getString(1) %>')"> <%=wfyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=6&dcode=<%=rs4.getString(1) %>')"> <%=wfno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=7&dcode=<%=rs4.getString(1) %>')"> <%=vwscyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=8&dcode=<%=rs4.getString(1) %>')"> <%=vwscno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=9&dcode=<%=rs4.getString(1) %>')"> <%=vwsmyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=10&dcode=<%=rs4.getString(1) %>')"><%=vwsmno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=11&dcode=<%=rs4.getString(1) %>')"> <%=cscc%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=12&dcode=<%=rs4.getString(1) %>')"><%=cscf%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=13&dcode=<%=rs4.getString(1) %>')"> <%=cscd%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=14&dcode=<%=rs4.getString(1) %>')"> <%=csca%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=15&dcode=<%=rs4.getString(1) %>')"> <%=ngoyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=16&dcode=<%=rs4.getString(1) %>')"> <%=ngono%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=17&dcode=<%=rs4.getString(1) %>')"> <%=shgsyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=18&dcode=<%=rs4.getString(1) %>')"> <%=shgsno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=19&dcode=<%=rs4.getString(1) %>')"> <%=wgyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=20&dcode=<%=rs4.getString(1) %>')"> <%=wgno%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=21&dcode=<%=rs4.getString(1) %>')"> <%=othrgyes%></td>
      <td  class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_bls_abstract_drill_rpt.jsp?drill=yes&type=22&dcode=<%=rs4.getString(1) %>')"><%=othrgno%></td>
    </tr>
   	
<%
   g23+=ts;
   g24+=th;
   g25+=tms;
   g26+=tmh;
   g27+=tp;
   g28+=to;
   g3+=lfyes;
   g4+=lfno;
   g5+=wfyes;
   g6+=wfno;
   g7+=vwscyes;
   g8+=vwscno;
   g9+=vwsmyes;
   g10+=vwsmno;
   g11+=cscc;
   g12+=cscf;
   g13+=cscd;
   g14+=csca;
   g15+=ngoyes;
   g16+=ngono;
   g17+=shgsyes;
   g18+=shgsno;
   g19+=wgyes;
   g20+=wgno;
   g21+=othrgyes;
   g22+=othrgno;
   }

%>
<tr>
	<td align="center" class="gridhdbg" colspan="2">Grand Total</td>
	<td style="text-align: right;" class="gridhdbg" ><%=g23 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g24 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g25 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g26 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g27 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g28 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g3 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g4 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g5 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g6 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g7 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g8 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g9 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g10 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g11 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g12 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g13 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g14 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g15 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g16 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g17 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g18 %></td>
    <td style="text-align: right;" class="gridhdbg" ><%=g19 %></td>
    <td style="text-align: right;" class="gridhdbg" ><%=g20 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g21 %></td>
	<td style="text-align: right;" class="gridhdbg" ><%=g22 %></td>
</tr>
<% 

	
	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>