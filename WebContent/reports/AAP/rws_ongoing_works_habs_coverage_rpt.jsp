<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script language="JavaScript">


function wopen(url, name, w, h)
{

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

<form>
<%

DecimalFormat ndf1 = new DecimalFormat("##.##");
String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
////System.out.println("dcode**********" +dcode);
String financialyr="";
String sname="";

	if(request.getParameter("finyear")!=null)
	
	{
	financialyr=request.getParameter("finyear");
	////System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
	String yr =financialyr.substring(0,4);
	  session.setAttribute("yr",yr);
		////System.out.println("yr:"+yr);
		//String nextyr=""+Integer.parseInt(yr)+1;
	 //   String prvyr=""+(Integer.parseInt(yr)-1);
		String yr1=""+(Integer.parseInt(yr)+1);
	  session.setAttribute("yr1",yr1);
	  ////System.out.println("yr*******************:"+yr);
		////System.out.println("yr1*******************:"+yr1);
	   // String subnextyr=nextyr.substring(2,4);
	  //  ////System.out.println("subnextyr:"+subnextyr);
String[] programes=request.getParameterValues("program");
	
    String pname="";
	for(int i=0;i<programes.length;i++)
	{
		pname += programes[i]+",";
	}
	////System.out.println("programe::"+pname);
	pname = pname.substring(0,pname.length()-1);
   session.setAttribute("pname",pname);

  
   
   if(request.getParameterValues("scheme")!=null){
   String[] schemes=request.getParameterValues("scheme");
 	
     
 	for(int i=0;i<schemes.length;i++)
 	{
 		sname += schemes[i]+",";
 	}
 	////System.out.println("sname::"+sname);
 	sname = sname.substring(0,sname.length()-1);
 session.setAttribute("scheme",sname);
 }
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//////System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);
//////System.out.println("cYear%%%%%%%%%%%%%%%%%%%%%"+cYear);
String lpcdrange=request.getParameter("lpcdrange");
session.setAttribute("lpcdrange",lpcdrange);

    Statement stmt8=null,stmt131=null;
    ResultSet rs1=null,rs8=null;
    String qry="";
    int styleCount=0;
    String style="";

	String status="";
    String div="";
    int count=0;
    int sno=1;
    
    String nsscount="";
    String nccount="";
    String pc1count="";
    String pc2count="";
    String pc3count="";
    String pc4count="";
    String fccount="";
    int h1=0;
    int workcount=0;
    
    int ghabcount=0;
    int gnsscount=0;
    int gnccount=0;
    int gpc1count=0;
    int gpc2count=0;
    
    int gpc3count=0;
    int gpc4count=0;
    int gfccount=0;
    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	<td ><a href="rws_ongoing_works_habs_coverage_excel.jsp">Excel </td>
	<!--   <td class="bwborder"><a href="./rws_noofcompletion_habs_xls.jsp" target="_new">Excel</a></td> -->
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > Ongoing Works - STATUS WISE <%=lpcdrange %> LPCD HABITATIONS CURRENT FINANCIAL YEAR -(<%=yr %>-<%=yr1 %>) .</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Total works</td>
        <td class=gridhdbg rowspan=2>Bal Est.<br>As On 01.04.<%=yr %></br></td>
    
    <td class=gridhdbg rowspan=2>Total</td>
    <td class=gridhdbg colspan=7>Coverage Of Habitations</td>
    
	
	</tr>
	<tr>
	<td class=gridhdbg >NSS</td>
	<td class=gridhdbg >NC</td>
	<td class=gridhdbg >PC1</td>
	
	<td class=gridhdbg >PC2</td>
	<td class=gridhdbg >PC3</td>
	<td class=gridhdbg >PC4</td>
	<td class=gridhdbg >FC</td>
	</tr>
    <tr>
       </tr>
       
<%
try
{
	Statement stmt444=null;
	ResultSet rs444=null;
	AAPreport1 aapbean=null;
	ArrayList aapdetails=new ArrayList();
	//works
	String dpr444="";
	dpr444="select  count(work_id),substr(office_code,2,2) from rws_work_admn_tbl b where to_date(ADMIN_DATE) < '01-Apr-"+yr+"' and  work_cancel_dt is null  and ((work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))) and  (work_id not in (select work_id from rws_work_admn_tbl where (to_date(TARGET_DATE_COMP) <'01-Apr-"+yr+"')))) and BLOCK_DATE is null ";
	 if(sname!=null && !sname.equals("")){
		 dpr444+=" and b.type_of_asset in("+sname+")";
	  }
	 dpr444+= " and  b.programme_code in ("+pname+") ";
	 dpr444+="  group by  substr(office_code,2,2) order by 2";
	  
		  
	 stmt444=conn.createStatement();
	////System.out.println("dpr444******KKKKKK"+dpr444);
		  rs444=stmt444.executeQuery(dpr444);
		Hashtable wrks=new Hashtable();
		while(rs444.next())
		{
			wrks.put(rs444.getString(2),rs444.getInt(1));
			
		}
		if(stmt444!=null){
			stmt444.close();
		}
		if(rs444!=null){
			rs444.close();
		}
	///
	
		String estcost="select  substr(office_code,2,2),sum(sanction_amount) from rws_work_admn_tbl b where to_date(ADMIN_DATE) < '01-Apr-"+yr+"' and  work_cancel_dt is null  and ((work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))) and  (work_id not in (select work_id from rws_work_admn_tbl where (to_date(TARGET_DATE_COMP) <'01-Apr-"+yr+"')))) and BLOCK_DATE is null ";
		 if(sname!=null && !sname.equals("")){
			 estcost+=" and b.type_of_asset in("+sname+")";
		  }
		 estcost+= " and  b.programme_code in ("+pname+") ";
		 estcost+="  group by  substr(office_code,2,2) order by 2";
		  
			  
		 stmt444=conn.createStatement();
		////System.out.println("estcost******KKKKKK"+estcost);
			  rs444=stmt444.executeQuery(estcost);
			Hashtable est_hash=new Hashtable();
			while(rs444.next())
			{
				est_hash.put(rs444.getString(1),rs444.getString(2));
				
			}
			if(stmt444!=null){
				stmt444.close();
			}
			if(rs444!=null){
				rs444.close();
			}
	////
	
			String expcost="select  substr(office_code,2,2),sum(case when voucher_Amt is null then 0.0 else voucher_Amt end)/100000 from rws_work_admn_tbl b,rws_work_exp_voucher_tbl a where to_date(ADMIN_DATE) < '01-Apr-"+yr+"' and  work_cancel_dt is null  and ((b.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))) and  (b.work_id not in (select work_id from rws_work_admn_tbl where (to_date(TARGET_DATE_COMP) <'01-Apr-"+yr+"')))) and b.work_id=a.work_id and BLOCK_DATE is null ";
			 if(sname!=null && !sname.equals("")){
				 expcost+=" and b.type_of_asset in("+sname+")";
			  }
			 expcost+= " and  b.programme_code in ("+pname+") ";
			 expcost+="  group by  substr(office_code,2,2) order by 2";
			  
				  
			 stmt444=conn.createStatement();
			////System.out.println("expcost******KKKKKK"+expcost);
				  rs444=stmt444.executeQuery(expcost);
				Hashtable exp_hash=new Hashtable();
				while(rs444.next())
				{
					exp_hash.put(rs444.getString(1),rs444.getString(2));
					
				}
				if(stmt444!=null){
					stmt444.close();
				}
				if(rs444!=null){
					rs444.close();
				}
			


	
	
		String statusqry="select distinct b.hab_code,nvl(d.CENSUS_PLAIN_POPU,0),nvl(d.CENSUS_SC_POPU,0),nvl(d.CENSUS_ST_POPU,0),nvl(total_water_supply,0),substr(b.hab_code,1,2),(case when d.safe_lpcd is null then 0 else d.safe_lpcd end),(case when d.unsafe_lpcd is null then 0 else d.unsafe_lpcd end)  from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_complete_hab_view c,rws_habitation_directory_tbl d where to_date(ADMIN_DATE) < '01-Apr-"+yr+"' and  work_cancel_dt is null  and ((a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))) and  (a.work_id not in (select work_id from rws_work_admn_tbl where (to_date(TARGET_DATE_COMP) <'01-Apr-"+yr+"')))) and  a.work_id=b.work_id and b.hab_code=d.hab_code and d.hab_code=c.PANCH_CODE and BLOCK_DATE is null";
		if(sname!=null && !sname.equals("")){
			statusqry+=" and a.type_of_asset in("+sname+")";
		  }
		statusqry+= " and  a.programme_code in ("+pname+") ";
		statusqry+="  order by substr(b.hab_code,1,2) ";
		 stmt444=conn.createStatement();
		
			rs444=stmt444.executeQuery(statusqry);
			//System.out.println("statusqry******KKKKKK"+statusqry);
				while(rs444.next())
				{
					double safe=rs444.getDouble(7);
					double unsafe=rs444.getDouble(8);
				//System.out.println("safe="+rs444.getDouble(7)+"@unsafe="+rs444.getDouble(8)+"/result="+(safe==0 && unsafe>0));
				if(safe==0 && unsafe>0){
aapbean=new AAPreport1();
					
					aapbean.setHabcode(rs444.getString(1));
					aapbean.setStatus("NSS");
					aapbean.setHabtype(rs444.getString(6));
					aapdetails.add(aapbean);
					
				}
				else{
						

					int total_pop=rs444.getInt(2)+rs444.getInt(3)+rs444.getInt(4);
					
					double water_supply=rs444.getDouble(5);
					double lpcd=water_supply/total_pop;
					
if(lpcdrange.equals("40")){
	
						//lpcd40
						if(lpcd>40){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("FC");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);						
							}
						if(lpcd==0){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("NC");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);
							}
						if(lpcd>0 && lpcd<=10){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("PC1");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);
							}
						if(lpcd>10 && lpcd<=20){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("PC2");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);						
							}
						if(lpcd>20 && lpcd<=30){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("PC3");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);
							}
						if(lpcd>30 && lpcd<=40){
							aapbean=new AAPreport1();
							
							aapbean.setHabcode(rs444.getString(1));
							aapbean.setStatus("PC4");
							aapbean.setHabtype(rs444.getString(6));
							aapdetails.add(aapbean);
							}
						}
					
					
					
					//lpcd55
					if(lpcdrange.equals("55")){
						
					if(lpcd>55){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("FC");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
					if(lpcd==0){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("NC");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
					if(lpcd>0 && lpcd<=13.25){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("PC1");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
					if(lpcd>13.25 && lpcd<=27.5){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("PC2");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
					if(lpcd>27.5 && lpcd<=41.25){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("PC3");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
					if(lpcd>41.25 && lpcd<=55){
						aapbean=new AAPreport1();
						
						aapbean.setHabcode(rs444.getString(1));
						aapbean.setStatus("PC4");
						aapbean.setHabtype(rs444.getString(6));
						aapdetails.add(aapbean);
						}
						}
				
				}
				
				}
			//	System.out.println("size of aaylist is "+aapdetails.size());
				if(stmt444!=null){
					stmt444.close();
				}
				if(rs444!=null){
					rs444.close();
				}	
				
		//main qry
		session.setAttribute("wrks",wrks);
		session.setAttribute("est_hash",est_hash);
		session.setAttribute("exp_hash",exp_hash);
		session.setAttribute("aapdetails",aapdetails);
		
		 stmt8=conn.createStatement();
   if(dcode.equals("00"))
   {
qry="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<> '16'";
   }
   else
   {
	 qry=  "select  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+dcode+"'";
   }
	
   int gworkCount=0;
   
   int a1=0;
  // ////System.out.println("qry1***************"+qry); 
	rs8=stmt8.executeQuery(qry);
	
    double estimateamnt=0.0,expamnt=0.0,balance=0.0;
    double gestimateamnt=0.0,gexpamnt=0.0,gbalance=0.0;
	while (rs8.next())
	{
		int nss1=0;
	    int nc1=0;
	    int pc1=0;
	    int pc2=0;
	    int pc3=0;
	    int pc4=0;
	    int fc=0;
	    int habcount=0;
		if(wrks.get(rs8.getString(1))!=null){
			workcount=(Integer)wrks.get(rs8.getString(1));
		}
		gworkCount+=workcount;
		
		
		
		
		//System.out.println("habcount="+habcount+"/totl"+ghabcount);
		if(est_hash.get(rs8.getString(1))!=null){
			estimateamnt=Double.parseDouble((String)est_hash.get(rs8.getString(1)));
		}
		if(exp_hash.get(rs8.getString(1))!=null){
			expamnt=Double.parseDouble((String)exp_hash.get(rs8.getString(1)));
		}
		balance=estimateamnt-expamnt;
		//
		for(int i=0;i<aapdetails.size();i++){
			if(((AAPreport1)aapdetails.get(i)).getHabtype().equals(rs8.getString(1))){
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("NC")){
					nc1++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("FC")){
					fc++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC1")){
					pc1++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC2")){
					pc2++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC3")){
					pc3++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("PC4")){
					pc4++;
				}
				if(((AAPreport1)aapdetails.get(i)).getStatus().equals("NSS")){
					nss1++;
				}
			}
			
		}
		habcount=nc1+fc+pc1+pc2+pc3+pc4+nss1;
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=workcount%></td>
    <td  class="<%=style%> "style="text-align: right;"> <%=ndf1.format(balance)%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=habcount%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=nss1%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=nc1%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=pc1%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=pc2%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=pc3%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=pc4%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=fc%></td>
   
   
    <%
    gnccount+=nc1;
    gnsscount+=nss1;
    gpc1count+=pc1;
    gpc2count+=pc2;
    gpc3count+=pc3;
    gpc4count+=pc4;
    gfccount+=fc;
    gbalance+=balance;
    ghabcount+=habcount;
	} %>
	<tr>
   	<td  class=gridhdbg style="text-align: left;"> </td>
   	<td  class=gridhdbg style="text-align: right;">Total: </td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gworkCount%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=ndf1.format(gbalance)%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=ghabcount%></td>
   		<td  class=gridhdbg style="text-align: right;"> <%=gnsscount%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gnccount%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gpc1count%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gpc2count%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gpc3count%></td>
   	<td  class=gridhdbg style="text-align: right;"> <%=gpc4count%></td>
   	   	<td  class=gridhdbg style="text-align: right;"> <%=gfccount%></td>
   	
   	</tr>
   	
	<%
	}catch(Exception e)
		{
		e.printStackTrace();
		}
finally
{
try
{
if(stmt8 != null)
{
stmt8.close();
}
if(rs8 != null)
{
rs8.close();
}
if( conn != null )
{
conn.close();
}

}
catch(SQLException p)
{
p.printStackTrace();
}
}
%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>