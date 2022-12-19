<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="conn.jsp" %>

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
StringBuffer dcode=new StringBuffer();
dcode.append(request.getParameter("district"));
//String dcode=request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode**********" +dcode);
StringBuffer financialyr=new StringBuffer();
StringBuffer sname=new StringBuffer();
StringBuffer yr=new StringBuffer();
StringBuffer yr1=new StringBuffer();


	if(request.getParameter("finyear")!=null)
	
	{
	financialyr.append(request.getParameter("finyear"));
	//System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr.append((String)session.getAttribute("financialyr"));
	}
	yr.append(financialyr.substring(0,4));
	  session.setAttribute("yr",yr);
		//System.out.println("yr:"+yr);
		//String nextyr=""+Integer.parseInt(yr)+1;
	 //   String prvyr=""+(Integer.parseInt(yr)-1);
		 yr1.append(""+(Integer.parseInt(yr.toString())+1));
	  session.setAttribute("yr1",yr1);
	 // System.out.println("yr*******************:"+yr);
	//	System.out.println("yr1*******************:"+yr1);
	   // String subnextyr=nextyr.substring(2,4);
	  //  System.out.println("subnextyr:"+subnextyr);
String[] programes=request.getParameterValues("program");
	
    StringBuffer pname=new StringBuffer();
	for(int i=0;i<programes.length;i++)
	{
		pname.append( programes[i]+",");
	}
	//System.out.println("programe::"+pname);
	pname.append(pname.substring(0,pname.length()-1));
   session.setAttribute("pname",pname);

  
   
   if(request.getParameterValues("scheme")!=null){
   String[] schemes=request.getParameterValues("scheme");
 	
     
 	for(int i=0;i<schemes.length;i++)
 	{
 		sname.append( schemes[i]+",");
 	}
 	//System.out.println("sname::"+sname);
 	sname.append(sname.substring(0,sname.length()-1));
 session.setAttribute("scheme",sname);
 }
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

StringBuffer cYear=new StringBuffer();
//cYear.append(w.getServerDate().substring(6,10));

//String cYear=w.getServerDate().substring(6,10);
//System.out.println("cYear%%%%%%%%%%%%%%%%%%%%%"+cYear);


    Statement stmt8=null,stmt131=null;
    ResultSet rs1=null,rs8=null;
    StringBuffer qry=new StringBuffer();
    int styleCount=0;
  // String style="";

	//String status="";
  //  String div="";
    int count=0;
    int sno=1;
   /* String habcount="";
    String nsscount="";
    String nccount="";
    String pc1count="";
    String pc2count="";
    String pc3count="";
    String pc4count="";
    String fccount="";
    */
    
    StringBuffer status=new StringBuffer();
    StringBuffer style=new StringBuffer();
    StringBuffer div=new StringBuffer();
    StringBuffer habcount=new StringBuffer();
    StringBuffer nsscount=new StringBuffer();
    StringBuffer nccount=new StringBuffer();
    StringBuffer pc1count=new StringBuffer();
    StringBuffer pc2count=new StringBuffer();
    StringBuffer pc3count=new StringBuffer();
    StringBuffer pc4count=new StringBuffer();
    StringBuffer fccount=new StringBuffer();
    StringBuffer dpr331=new StringBuffer();
    StringBuffer dpr33=new StringBuffer();
    StringBuffer dpr34=new StringBuffer();
    
    
    StringBuffer dpr35=new StringBuffer();
    StringBuffer dpr36=new StringBuffer();
    StringBuffer dpr37=new StringBuffer();
    StringBuffer dpr51=new StringBuffer();
    StringBuffer sample22=new StringBuffer();
   
    
   
    int h1=0;
    int nss1=0;
    int nc1=0;
    int pc1=0;
    int pc2=0;
    int pc3=0;
    int pc4=0;
    int fc=0;
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
	   <td class="bwborder"><a href="./rws_noofcompletion_habs_xls.jsp" target="_new">Excel</a></td> 
	</tr>  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" > STATUS WISE COVERAGE OF HABITATIONS DURING THE CURRENT FINANCIAL YEAR -(2013-14)-(as per works monitoring)									
  - Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
    <td class=gridhdbg rowspan=2>District</td>
    <td class=gridhdbg rowspan=2>Total</td>
    <td class=gridhdbg colspan=7 align=center>Coverage Of Habitations</td>
    
	
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
	//
	dpr331.delete(0,dpr331.length());
	 dpr331.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='NSS' ");
	 if(sname!=null && !sname.toString().equals("")){
		 dpr331.append(" and b.type_of_asset in("+sname.toString()+")");
	  }
	 dpr331.append(" and  b.programme_code in ("+pname.toString()+") ");
	  dpr331.append("  group by  substr(b.office_code,2,2) order by 2");
	  
		  
	Statement stmt333=conn.createStatement();
	//System.out.println("dpr33******KKKKKK"+dpr331);
		 ResultSet rs233=stmt333.executeQuery(dpr331.toString());
		Hashtable dpr333=new Hashtable();
		while(rs233.next())
		{
			dpr333.put(rs233.getString(2),rs233.getString(1));
			
		}
	
	//
	//
	
	dpr33.delete(0,dpr33.length());
	 dpr33.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='NC'  ");
	 if(sname!=null && !sname.toString().equals("")){
		 dpr33.append(" and b.type_of_asset in("+sname.toString()+")");
	  }
	 dpr33.append("  and b.programme_code in ("+pname.toString()+") ");
	  dpr33.append("  group by  substr(b.office_code,2,2) order by 2");
	
		  
	Statement stmt33=conn.createStatement();
	//System.out.println("dpr33******KKKKKK"+dpr33);
		 ResultSet rs33=stmt33.executeQuery(dpr33.toString());
		Hashtable dpr22=new Hashtable();
		while(rs33.next())
		{
			dpr22.put(rs33.getString(2),rs33.getString(1));
			
		}
	
	//
	//
	dpr34.delete(0,dpr34.length());
	  dpr34.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='PC1'  ");
	  if(sname!=null && !sname.toString().equals("")){
			 dpr34.append(" and b.type_of_asset in("+sname.toString()+")");
		  }
		 dpr34.append("  and b.programme_code in ("+pname.toString()+") ");
		  dpr34.append("  group by  substr(b.office_code,2,2) order by 2");
		
	  
	  
		  
	Statement stmt34=conn.createStatement();
	//System.out.println("dpr34******KKKKKK"+dpr34);
		 ResultSet rs34=stmt34.executeQuery(dpr34.toString());
		Hashtable dpr23=new Hashtable();
		while(rs34.next())
		{
			dpr23.put(rs34.getString(2),rs34.getString(1));
			
		}
	
	//
	//
	//

	dpr35.delete(0,dpr35.length());
	  dpr35.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='PC2'  ");
	  if(sname!=null && !sname.toString().equals("")){
			 dpr35.append(" and b.type_of_asset in("+sname.toString()+")");
		  }
		 dpr35.append("  and b.programme_code in ("+pname.toString()+") ");
		  dpr35.append("  group by  substr(b.office_code,2,2) order by 2");
		
	  
		  
	Statement stmt35=conn.createStatement();
	//System.out.println("dpr35******KKKKKK"+dpr35);
		 ResultSet rs35=stmt35.executeQuery(dpr35.toString());
		Hashtable dpr24=new Hashtable();
		while(rs35.next())
		{
			dpr24.put(rs35.getString(2),rs35.getString(1));
			
		}
	
	//
	//
	dpr36.delete(0,dpr36.length());
	  dpr36.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='PC3'  ");
	  if(sname!=null && !sname.toString().equals("")){
			 dpr36.append(" and b.type_of_asset in("+sname.toString()+")");
		  }
		 dpr36.append("  and b.programme_code in ("+pname.toString()+") ");
		  dpr36.append("  group by  substr(b.office_code,2,2) order by 2");
		
	  
		  
	Statement stmt36=conn.createStatement();
	//System.out.println("dpr36******KKKKKK"+dpr36);
		 ResultSet rs36=stmt36.executeQuery(dpr36.toString());
		Hashtable dpr25=new Hashtable();
		while(rs36.next())
		{
			dpr25.put(rs36.getString(2),rs36.getString(1));
			
		}
	
	//
	dpr37.delete(0,dpr37.length());
	 dpr37.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='PC4'  ");
	 if(sname!=null && !sname.toString().equals("")){
		 dpr37.append(" and b.type_of_asset in("+sname.toString()+")");
	  }
	 dpr37.append(" and b.programme_code in ("+pname.toString()+") ");
	  dpr37.append("  group by  substr(b.office_code,2,2) order by 2");
	 
		  
	Statement stmt37=conn.createStatement();
	//System.out.println("dpr37******KKKKKK"+dpr37);
		 ResultSet rs37=stmt37.executeQuery(dpr37.toString());
		Hashtable dpr26=new Hashtable();
		while(rs37.next())
		{
			dpr26.put(rs37.getString(2),rs37.getString(1));
			
		}
	
	//
	//
	dpr51.delete(0,dpr51.length());
	 dpr51.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null and coverage_status='FC' ");
	 if(sname!=null && !sname.toString().equals("")){
		 dpr51.append(" and b.type_of_asset in("+sname.toString()+")");
	  }
	 dpr51.append(" and b.programme_code in ("+pname.toString()+") ");
	  dpr51.append("  group by  substr(b.office_code,2,2) order by 2");
	
	  
		  
	Statement stmt38=conn.createStatement();
	//System.out.println("dpr51******KKKKKK"+dpr51);
		 ResultSet rs38=stmt38.executeQuery(dpr51.toString());
		Hashtable dpr27=new Hashtable();
		while(rs38.next())
		{
			dpr27.put(rs38.getString(2),rs38.getString(1));
			
		}
	
	//*
	
	
	sample22.delete(0,sample22.length());
		 sample22.append("select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+yr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+yr.toString()+"') )  and work_cancel_dt is null   ");
		  if(sname!=null && !sname.toString().equals("")){
			  	   sample22.append(" and b.type_of_asset in("+sname.toString()+")");
			  }
			  sample22.append("  and b.programme_code in ("+pname.toString()+") ");
			  sample22.append("  group by  substr(b.office_code,2,2) order by 2");
	//
	// String sample22="select  count(hab_code),substr(b.office_code,2,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_complete_hab_view c  where c.panch_code=a.hab_code and substr(office_code,2,2)=c.dcode  and a.work_id=b.work_id and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null  and (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+cYear+"')) and work_cancel_dt is null   group by substr(office_code,2,2)";
	Statement stmt51=conn.createStatement();
	//System.out.println("sourcesample22:"+sample22);
	ResultSet rs51=stmt51.executeQuery(sample22.toString());
	Hashtable sourcehhh=new Hashtable();
		while(rs51.next())
	{
		sourcehhh.put(rs51.getString(2),rs51.getString(1));
	}
	


   //main qry
   stmt8=conn.createStatement();
   if(dcode.toString().equals("00"))
   {
	   
	   qry.delete(0,qry.length());
qry.append("select  d.dcode,d.dname from rws_district_tbl d where d.dcode<> '16'");
   }
   else
   {
	 qry.append("select  d.dcode,d.dname from rws_district_tbl d where d.dcode='"+dcode.toString()+"'");
   }
	 
  // System.out.println("qry"+qry);
   int a1=0;
  // System.out.println("qry1***************"+qry); 
	rs8=stmt8.executeQuery(qry.toString());
   
	while (rs8.next())
	{
		//Totalcount
	//	System.out.println("hiii");

		
		habcount.delete(0,habcount.length());
		habcount.append((String)sourcehhh.get(rs8.getString(1)));
		if(habcount!=null && !habcount.toString().equals(""))
		{
			
		}
		else
		{
			habcount.append("0");
		}
		
		  //System.out.println("habcount"+habcount);
		//
		//NSS Count
		
		nsscount.delete(0,nsscount.length());
		nsscount.append((String)dpr333.get(rs8.getString(1)));
		if(nsscount!=null && !nsscount.toString().equals("") && !nsscount.toString().equals("null"))
		{
			
		}
		else
		{
			
			nsscount.delete(0,nsscount.length());
			nsscount.append("0");
		}
		
		
		 //System.out.println("nsscount"+nsscount);
		//
		//NC Count
		
		nccount.delete(0,nccount.length());
		nccount.append((String)dpr22.get(rs8.getString(1)));
		if(nccount!=null && !nccount.toString().equals("") && !nccount.toString().equals("null"))
		{
			
		}
		else
		{
			nccount.delete(0,nccount.length());
			nccount.append("0");
		}
		//
		//PC1 Count
		// System.out.println("nccount"+nccount);
		
		pc1count.delete(0,pc1count.length());
		pc1count.append((String)dpr23.get(rs8.getString(1)));
		if(pc1count!=null && !pc1count.toString().equals("") && !pc1count.toString().equals("null"))
		{
			
		}
		else
		{
			pc1count.delete(0,pc1count.length());
			pc1count.append("0");
		}
		
		// System.out.println("pc1count"+pc1count);
		//
		//PC2 Count
		
		pc2count.delete(0,pc2count.length());
		pc2count.append((String)dpr24.get(rs8.getString(1)));
		if(pc2count!=null && !pc2count.toString().equals("") && !pc2count.toString().equals("null"))
		{
			
		}
		else
		{
			pc2count.delete(0,pc2count.length());
			pc2count.append("0");
		}
		
		// System.out.println("pc2count"+pc2count);
		//
		//PC3 Count
		pc3count.delete(0,pc3count.length());
		pc3count.append((String)dpr25.get(rs8.getString(1)));
		if(pc3count!=null && !pc3count.toString().equals("") && !pc3count.toString().equals("null"))
		{
			
		}
		else
		{
			pc3count.delete(0,pc3count.length());
			pc3count.append("0");
		}
		
		//System.out.println("pc3count"+pc3count);
		//
		//PC4 Count
		
		pc4count.delete(0,pc4count.length());
		pc4count.append((String)dpr26.get(rs8.getString(1)));
		if(pc4count!=null && !pc4count.toString().equals("") && !pc4count.toString().equals("null"))
		{
			
		}
		else
		{
			pc4count.delete(0,pc4count.length());
			pc4count.append("0");
		}
		
		//System.out.println("pc4count"+pc4count);
		//
		//FC Count
		
		fccount.delete(0,fccount.length());
		fccount.append((String)dpr27.get(rs8.getString(1)));
		if(fccount!=null && !fccount.toString().equals("") && !fccount.toString().equals("null"))
		{
			
		}
		else
		{
			
			fccount.delete(0,fccount.length());
			fccount.append("0");
		}
		
		
		//System.out.println("fccount"+fccount);
		//
		//
		h1=Integer.parseInt(habcount.toString());
		nss1=Integer.parseInt(nsscount.toString());
		nc1=Integer.parseInt(nccount.toString());
		pc1=Integer.parseInt(pc1count.toString());
		pc2=Integer.parseInt(pc2count.toString());
		pc3=Integer.parseInt(pc3count.toString());
		pc4=Integer.parseInt(pc4count.toString());
		fc=Integer.parseInt(fccount.toString());
		ghabcount=ghabcount+h1;
		gnsscount=gnsscount+nss1;
		gnccount=gnccount+nc1;
		gpc1count=gpc1count+pc1;
		gpc2count=gpc2count+pc2;
		gpc3count=gpc3count+pc3;
		gpc4count=gpc4count+pc4;
		gfccount=gfccount+fc;
		
		//System.out.println("gfccount"+gfccount);
		
		//
	
		
		
  	style.delete(0,style.length());
	 if(styleCount%2==0){
		 style.append("gridbg1");
	 }else{
		 style.append("gridbg2");
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
   <td  class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=habcount.toString()%></td>
    <%
 if(nss1==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=nsscount.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=NSS')"><%=nsscount.toString()%></a></td>
    <%}
 
 if(nc1==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=nccount.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=NC')"><%=nccount.toString()%></a></td>
    <%}
   
 if(pc1==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=pc1count.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=PC1')"><%=pc1count.toString()%></a></td>
    <%} 
    if(pc2==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=pc2count.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=PC2')"><%=pc2count.toString()%></a></td>
    <%} 
    if(pc3==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=pc3count.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=PC3')"><%=pc3count.toString()%></a></td>
    <%} 
 
 if(pc4==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=pc4count.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=PC4')"><%=pc4count.toString()%></a></td>
    <%} 
 
  
   
   
   
  
 if(fc==0)
 {
 %>
  <td class="<%=style%> "style="text-align: right;"> <%=fccount.toString()%></td>
  <%}else{ %>
    <td class="<%=style%> "style="text-align: right;"> <a href="#" onclick="viewWorks('rws_noofcompletion_habsdrill_rpt.jsp?dcode=<%=rs8.getString(1)%>&status=FC')"><%=fccount.toString()%></a></td>
    <%} %>
 
   
        
 
   	</tr>
   	
   	
<%
}
	%>
	<tr>
   	<td  class=gridhdbg style="text-align: left;"> </td>
   	<td  class=gridhdbg style="text-align: right;">Total: </td>
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
	
    qry=null;
    financialyr=null;cYear=null;
    yr=null;
    yr1=null;
    dcode=null;
    
   status=null;
    style=null;
    div=null;
    habcount=null;
    nsscount=null;
    nccount=null;
     pc1count=null;
   pc2count=null;
    pc3count=null;
    pc4count=null;
    fccount=null;
    dpr331=null;
    dpr33=null;
    dpr34=null;
    
    
    dpr35=null;
    dpr36=null;
    dpr37=null;
    dpr51=null;
    sample22=null;
	
	
	
	
	
	
	
	
	
	
	
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