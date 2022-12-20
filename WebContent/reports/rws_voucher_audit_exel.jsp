<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>


<%  
  String fromdate=(String)session.getAttribute("fromdate");
  String division=(String)session.getAttribute("division");
  String todate=(String)session.getAttribute("todate");
  String tname=(String)session.getAttribute("tname");
  String prname=(String)session.getAttribute("prname");
  String pname=(String)session.getAttribute("pname");
  String qrystr=(String)session.getAttribute("qrystr"); 
  //System.out.println("qrystr........."+qrystr);
  String dno=(String)session.getAttribute("dno");
  String divqry=(String)session.getAttribute("divqry");
   System.out.println("divqry........."+divqry);
	DecimalFormat ndf = new DecimalFormat("####.00");
  //  boolean   flag=false,flag1=false,flag2=false,flag3=false;  	

	  boolean   flag=false,flag1=false,flag2=false,flag3=false,fs1=false;;  
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null;
	String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="",qry8="",qry9="",qry10="",qry11="",qry12="",qry13="",qry14="",qry15="";
	String div="",cir="",cwork_id="",txid="",ptxid="",wrkbillno="";
	
   String h6values="";
   String h6v1="",h6v2="",h6v3="",h6v4="",h6v5="";
   String firstpop2[];
   
   String h7values="";
   String h7v1="",h7v2="",h7v3="";
   String secondpop2[];


	
   String h1values="";
   String h1v1="",h1v2="",h1v3="",h1v4="",h1v5="",h1v6="",h1v7="",h1v10="",h1v8="",h1v9="";
   String firstpop[];
   
   String h2values="";
   String h2v1="",h2v2="",h2v3="";
   String secondpop[];

   String h3values="";
   String h3v1="",h3v2="",h3v3="",h3v4="",h3v5="",h3v6="",h3v7="",h3v10="",h3v8="",h3v9="";
   String firstpop1[];
   
   String h4values="";
   String h4v1="",h4v2="",h4v3="",h4v4="",h4v5="",h4v6="",h4v7="",h4v8="",h4v9="",h4v10="",h4v11="",h4v12="",h4v13="";
   Set centralList=new HashSet();
   
   String h5values="";
   String h5v1="",h5v2="",h5v3="";
   String secondpop1[];
   int count=1,count1=1,count2=1;


   String h9values="";
   String h9v1="",h9v2="",h9v3="",h9v4="",h9v5="";
   String voucherlist[];

   String h10values="";
   String h10v1="",h10v2="",h10v3="",h10v4="",h10v5="";
   
   
   
   Set txList=new HashSet();
  
   String h11values="";
   String h11v1="",h11v2="",h11v3="",h11v4="",h11v5="";
   String[] admpop ;
   
   String h12values="";
   String h12v1="",h12v2="",h12v3="",h12v4="";
  

   String h15values="";
   String h15v1="",h15v2="",h15v3="",h15v4="",h15v5="";




  double totvoucheramt=0,voucheramt=0,adbillamt=0,totadbillamt=0,v2count=0,v1sum=0,v2sum=0,v3sum=0,v4sum=0,v5sum=0,v6sum=0,v7sum=0,v8sum=0,v9sum=0,v10sum=0,sc1=0,st1=0,plain1=0,totpop1=0,admtotpop1=0,sc2=0,st2=0,plain2=0,totpop2=0,gv1sum=0,gv2sum=0,gv3sum=0,gv4sum=0,gv5sum=0,gv6sum=0,gv7sum=0,gv8sum=0,gv9sum=0,gv10sum=0;
  double stotvoucheramt=0,svoucheramt=0,sadbillamt=0,stotadbillamt=0,sv2count=0,sv1sum=0,sv2sum=0,sv3sum=0,sv4sum=0,sv5sum=0,sv6sum=0,sv7sum=0,sv8sum=0,sv9sum=0,sv10sum=0,ssc1=0,sst1=0,splain1=0,stotpop1=0,sadmntotpop1=0,ssc2=0,sst2=0,splain2=0,stotpop2=0;
  double sstotvoucheramt=0,ssvoucheramt=0,ssadbillamt=0,sstotadbillamt=0,ssv2count=0,ssv1sum=0,ssv2sum=0,ssv3sum=0,ssv4sum=0,ssv5sum=0,ssv6sum=0,ssv7sum=0,ssv8sum=0,ssv9sum=0,ssv10sum=0,sssc1=0,ssst1=0,ssplain1=0,sstotpop1=0,sssc2=0,ssst2=0,ssplain2=0,sstotpop2=0;
  double csv1sum=0,csv2sum=0,csv3sum=0,csv4sum=0,csv5sum=0,csv6sum=0,csv7sum=0,csv8sum=0,csv9sum=0,csv10sum=0;
  double gcsv1sum=0,gcsv2sum=0,gcsv3sum=0,gcsv4sum=0,gcsv5sum=0,gcsv6sum=0,gcsv7sum=0,gcsv8sum=0,gcsv9sum=0,gcsv10sum=0; 
  double centralamt=0,stateamt=0;
if(request.getParameter("division")!=null && !request.getParameter("division").equals("") && !request.getParameter("division").equals("00"))
	{
		String cirdiv=request.getParameter("division");
		div=cirdiv.substring(2,3);
		cir=cirdiv.substring(0,2);
	}
	else
	{
		String cirdiv=request.getParameter("division");
		if(cirdiv!=null && !cirdiv.equals("") && !cirdiv.equals("00"))
		{
		div=cirdiv.substring(2,3);
		cir=cirdiv.substring(0,2);
		}
   }
   session.setAttribute("div",div);
   session.setAttribute("cir",cir);
   %>
<form name=f1 method="post">
<table border=0 cellspacing=0 cellpadding=0 width="800px">
	<caption>
		 <table border=0 rules=none style="border-collapse:collapse" align="right" width="1000px">
			<tr align="right">
				<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a
					href="../home.jsp">Home</a> |<a
					href="./rws_precedings_adit_rpt_xls.jsp" target=_new>Excel</a></td>
			</tr>
		 </table>
	</caption>
</table>
<!-- <table>
<tr><td width="10%" bgcolor="#FFF2D8" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Central Bills</td></tr>
<tr><td width="10%" bgcolor="#FFF1FF" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;State Bills For Respective Central Bill Workid's</td></tr>
<tr><td width="10%" bgcolor="#FFFFE6" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;State Bills </td></tr>
</table>-->
<br>
<br>
<table border=1 cellspacing=0 cellpadding=0 width="800px"
	bordercolor=#000000 style="border-collapse:collapse">
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16>Audit
		Report&nbsp;&nbsp;of&nbsp;&nbsp;<%=division%> Division&nbsp;&nbsp;in between
		Dates&nbsp;&nbsp;<%=fromdate%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=todate%>&nbsp;For&nbsp;<%=prname%>
		Programes<font color="blue"></font></td>
	</tr>
	<tr>
		<td>
		<table border=1 cellspacing=0 cellpadding=0 width=100%
			bordercolor=#000000 style="border-collapse:collapse">
			<tr>
				<td class=btext rowspan=2><font color="red">S.No</font></td>
				<td class=btext rowspan=2><font color="red">Work Id</font></td>
				<td class=btext rowspan=2><font color="red">Work Name</font></td>
				<td class=btext rowspan=2><font color="red">Programme</font></td>
				<td class=btext rowspan=2><font color="red">Sub<br>
				Programme</font></td>
				<td class=btext rowspan=2><font color="red">Bill No/Date</font></td>
				<td class=btext rowspan=2><font color="red">Bill SL No</font></td>
				<td class=btext rowspan=2><font color="red">Bill Admi.Amount</font></td>
                <td class=btext align="center" rowspan=2><font color="red">State/Central
				Send Date</font></td>
                <td class=btext rowspan=2><font color="red">Sector</font></td>
				<td class=btext rowspan=2><font color="red">Transaction ID</font></td>
				<td class=btext align="center" colspan=4><font color="red">Releases
				</font></td>
				<td class=btext align="center" colspan=7><font color="red">Expenditure
				</font></td>
			</tr>
			<tr>
				<td class=btext align="center"><font color="red">SC</font></td>
				<td class=btext align="center"><font color="red">ST</font></td>
				<td class=btext align="center"><font color="red">PLAIN</font></td>
				<td class=btext align="center"><font color="red">Total</font></td>
				<td class=btext align="center"><font color="red">Voucher No</font></td>
				<td class=btext align="center"><font color="red">Voucher Date</font></td>
				<td class=btext align="center"><font color="red">Voucher Amt</font></td>
				<td class=btext align="center"><font color="red">SCP</font></td>
				<td class=btext align="center"><font color="red">TSP</font></td>
				<td class=btext align="center"><font color="red">PLAIN</font></td>
				<td class=btext align="center"><font color="red">Total</font></td>
			</tr>
			<% 
try
   {
 //System.out.println("i am in audit report22222222");
 Set vochernum=new HashSet();
 Set svochernum=new HashSet();  
    Statement stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	Statement stmt2=conn.createStatement();
	Statement stmt3=conn.createStatement();
    Statement stmt4=conn.createStatement();
    Statement stmt5=conn.createStatement();
	Statement stmt6=conn.createStatement();
    Statement stmt7=conn.createStatement();
    Statement stmt8=conn.createStatement();
    Statement stmt9=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	Statement stmt10=conn.createStatement();  
    Statement stmt11=conn.createStatement();    
    Statement stmt12=conn.createStatement();  
    Statement stmt13=conn.createStatement(); 
    Statement stmt14=conn.createStatement();  
    Statement stmt15=conn.createStatement(); 
        //hab count in adm-hab-lnk tbl
        qry14="select count(hab_code),work_id from RWS_admn_HAB_LNK_TBL group by work_id";
       // System.out.println("qry14:"+qry14);
		 rs14=stmt14.executeQuery(qry14);
         Hashtable h14=new Hashtable();
		  while(rs14.next())
		 {
             h14.put(rs14.getString(2),rs14.getString(1));
         }
         if(rs14!=null){rs14.close();}
         if(stmt14!=null){stmt14.close();}; 

         //hab count in est_hab_lnk tbl
         qry13="select count(hab_code),work_id from RWS_EST_NEW_HAB_LNK_TBL group by work_id";
        // System.out.println("qry13:"+qry13);
		 rs13=stmt13.executeQuery(qry13);
         Hashtable h13=new Hashtable();
		  while(rs13.next())
		 {
             h13.put(rs13.getString(2),rs13.getString(1));
         }
         if(rs13!=null){rs13.close();}
         if(stmt13!=null){stmt13.close();} 

        //releases pop from admn_hab_lnk and tname tbls
        qry11="select  work_id,nvl(sum(CENSUS_SC_POPU),0),nvl(sum(CENSUS_ST_POPU),0) ,nvl(sum(CENSUS_PLAIN_POPU),0) from RWS_admn_HAB_LNK_TBL a, "+tname+" b where  a.hab_code=b.hab_code group by work_id ";
       // System.out.println("qry11:"+qry11);
		 rs11=stmt11.executeQuery(qry11);
         Hashtable h11=new Hashtable();
		 while(rs11.next())
		{
             h11.put(rs11.getString(1),rs11.getString(2)+"@"+rs11.getString(3)+"@"+rs11.getString(4));
        }
         if(rs11!=null){rs11.close();}
         if(stmt11!=null){stmt11.close();} 

         //expenditure pop from admn_hab_lnk ,voucher and tname tbls
         qry15="select a.work_id,nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0) from RWS_admn_HAB_LNK_TBL a,rws_work_exp_voucher_tbl r ,"+tname+" b,rws_work_bill_tbl  k where a.work_id=r.work_id and r.work_id=k.work_id and  VOUCHER_DT>=to_date('"+fromdate+"','dd-mm-yyyy') and  VOUCHER_DT<=to_date('"+todate+"','dd-mm-yyyy') and r.bill_sl_no=k.bill_sl_no and a.hab_code=b.hab_code group by a.work_id,CENSUS_SC_POPU,CENSUS_ST_POPU,CENSUS_PLAIN_POPU";
		// System.out.println("qry15:"+qry15);
		 rs15=stmt15.executeQuery(qry15);
         Hashtable h15=new Hashtable();
		 while(rs15.next())
			{ 
              h15.put(rs15.getString(1),rs15.getString(2)+"@"+rs15.getString(3)+"@"+rs15.getString(4));
			}
         if(rs15!=null){rs15.close();}
         if(stmt15!=null){stmt15.close();}

        //releases pop from est and hab dir tbls
         qry5="select  work_id,nvl(sum(CENSUS_SC_POPU),0),nvl(sum(CENSUS_ST_POPU),0) ,nvl(sum(CENSUS_PLAIN_POPU),0) from RWS_EST_NEW_HAB_LNK_TBL a, rws_habitation_directory_tbl b where  a.hab_code=b.hab_code group by work_id";
	    // System.out.println("qry5:"+qry5);
		 rs5=stmt5.executeQuery(qry5);
         Hashtable h3=new Hashtable();
		 while(rs5.next())
		{
             h3.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3)+"@"+rs5.getString(4));
        }
         if(rs5!=null){rs5.close();}
         if(stmt5!=null){stmt5.close();} 

         //expenditure pop from est,voucher and hab dir tbls
         qry6="select a.work_id,nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0) from RWS_EST_NEW_HAB_LNK_TBL a,rws_work_exp_voucher_tbl r ,rws_habitation_directory_tbl b,rws_work_bill_tbl  k where a.work_id=r.work_id and r.work_id=k.work_id and  VOUCHER_DT>=to_date('"+fromdate+"','dd-mm-yyyy') and  VOUCHER_DT<=to_date('"+todate+"','dd-mm-yyyy') and r.bill_sl_no=k.bill_sl_no and a.hab_code=b.hab_code group by a.work_id,CENSUS_SC_POPU,CENSUS_ST_POPU,CENSUS_PLAIN_POPU";
		 //System.out.println("qry6:"+qry6);
		 rs6=stmt6.executeQuery(qry6);
         Hashtable h5=new Hashtable();
		 while(rs6.next())
			{ 
              h5.put(rs6.getString(1),rs6.getString(2)+"@"+rs6.getString(3)+"@"+rs6.getString(4));
			}
         if(rs6!=null){rs6.close();}
         if(stmt6!=null){stmt6.close();} 

        //releases pop from est and tname tbl
        qry2="select distinct  work_id,nvl(sum(CENSUS_SC_POPU),0),nvl(sum(CENSUS_ST_POPU),0) ,nvl(sum(CENSUS_PLAIN_POPU),0) from RWS_EST_NEW_HAB_LNK_TBL a, "+tname+" b where  a.hab_code=b.hab_code group by work_id";
	     //System.out.println("qry2:"+qry2);
		 rs2=stmt2.executeQuery(qry2);
         Hashtable h1=new Hashtable();
		 while(rs2.next())
		{
             h1.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
        }
         if(rs2!=null){rs2.close();}
         if(stmt2!=null){stmt2.close();} 

         //expenditure pop from est,voucher and tname tbl
        qry3="select distinct a.work_id,nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0) from RWS_EST_NEW_HAB_LNK_TBL a,rws_work_exp_voucher_tbl r ,"+tname+" b,rws_work_bill_tbl  k where a.work_id=r.work_id and r.work_id=k.work_id and  VOUCHER_DT>=to_date('"+fromdate+"','dd-mm-yyyy') and  VOUCHER_DT<=to_date('"+todate+"','dd-mm-yyyy') and r.bill_sl_no=k.bill_sl_no and a.hab_code=b.hab_code group by a.work_id,CENSUS_SC_POPU,CENSUS_ST_POPU,CENSUS_PLAIN_POPU";
		//System.out.println("qry3:"+qry3);
		rs3=stmt3.executeQuery(qry3);
        Hashtable h2=new Hashtable();
		while(rs3.next())
			{ 
              h2.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4));
			}
         if(rs3!=null){rs3.close();}
         if(stmt3!=null){stmt3.close();} 
 
        //main qry of getting bills  within given dates
        qry8="select distinct d.work_id,d.work_name,e.programme_name,f.subprogramme_name,b.bill_no,to_char(b.bill_date,'dd/mm/yyyy'),b.bill_sl_no,b.BILL_AMT_ADMISSIBLE from rws_work_admn_tbl d,rws_programme_tbl e, rws_subprogramme_tbl f,rws_work_bill_tbl b,rws_work_exp_voucher_tbl br where "+divqry+" (substr(d.work_id,1,2)=e.programme_code and substr(d.work_id,1,2)=f.programme_code and substr(d.work_id,3,2)=f.subprogramme_code) and  d.work_id=b.work_id  and d.work_id=br.work_id and  br.VOUCHER_DT>=to_date('"+fromdate+"','dd-mm-yyyy') and  br.VOUCHER_DT<=to_date('"+todate+"','dd-mm-yyyy') and  "+qrystr+" group by d.work_id,d.work_name,e.programme_name,f.subprogramme_name,b.bill_no,to_char(b.bill_date,'dd/mm/yyyy'),b.bill_sl_no,b.BILL_AMT_ADMISSIBLE order by d.work_id,b.bill_no,b.bill_sl_no"; 
        System.out.println("central main........"+qry8);
        rs8=stmt8.executeQuery(qry8);
        //System.out.println("central main........"+qry8);
		while(rs8.next())
		{
         centralList.add((String)rs8.getString(1));
		}       
         
		//System.out.println("Asize"+centralList.size());
		 int j=0;
		 Object res[]=centralList.toArray();
          if(res.length>1){
		 for(j=0;j<res.length;j++)
		{
         flag=true;flag2=true;
         boolean flag4=false;
		String orgwork_id=(String)res[j];
        // main bills qry 
        qry1="select distinct d.work_id,d.work_name,e.programme_name,f.subprogramme_name,b.bill_no,to_char(b.bill_date,'dd/mm/yyyy'),b.bill_sl_no,b.BILL_AMT_ADMISSIBLE,no_of_habs,f.subprogramme_code from rws_work_admn_tbl d,rws_programme_tbl e, rws_subprogramme_tbl f,rws_work_bill_tbl b where "+divqry+" d.work_id='"+orgwork_id+"' and (substr(d.work_id,1,2)=e.programme_code and substr(d.work_id,1,2)=f.programme_code and substr(d.work_id,3,2)=f.subprogramme_code) and  d.work_id=b.work_id  and  b.bill_date>=to_date('"+fromdate+"','dd-mm-yyyy') and  b.bill_date<=to_date('"+todate+"','dd-mm-yyyy')  and  "+qrystr+" group by d.work_id,d.work_name,e.programme_name,f.subprogramme_name,b.bill_no,to_char(b.bill_date,'dd/mm/yyyy'),b.bill_sl_no,b.BILL_AMT_ADMISSIBLE ,no_of_habs,f.subprogramme_code order by d.work_id,b.bill_no,b.bill_sl_no";
        rs1=stmt1.executeQuery(qry1);
        //System.out.println("main bill qry1........"+qry1);
       
        while(rs1.next())
		{
          flag1=true;
          cwork_id=rs1.getString(1);
          wrkbillno=rs1.getString(7);
         //central bills qry  
          qry12="select distinct d.work_id,b.bill_no,b.bill_sl_no,nvl(a.txid,'No-TXID'),a.BILL_AMOUNT_CENTRAL,to_char(bank_send_date,'dd/mm/yyyy') from rws_work_admn_tbl d,rws_work_bill_tbl b,rws_bill_bank_bridge_det_tbl a where d.work_id='"+rs1.getString(1)+"' and b.bill_sl_no='"+rs1.getString(7)+"' and  d.work_id=b.work_id and a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_date>=to_date('"+fromdate+"','dd-mm-yyyy') and  b.bill_date<=to_date('"+todate+"','dd-mm-yyyy')  and  "+qrystr+" group by d.work_id,b.bill_no,b.bill_sl_no,a.txid,a.BILL_AMOUNT_CENTRAL,bank_send_date order by d.work_id,b.bill_no,b.bill_sl_no";
		  rs12=stmt12.executeQuery(qry12);
		 // System.out.println(" central bill qry12......."+qry12);
          
		  while(rs12.next())
		  {
            //release pops  from est-tname tbl   
           h1values=(String)h1.get(orgwork_id);
           String estpop[];
           if(h1values!=null)
			{
                estpop=h1values.split("@");
                h1v1=estpop[0];
                h1v2=estpop[1];
                h1v3=estpop[2];
			}else{
                h1v1="0";
                h1v2="0";
                h1v3="0";
                   }

           //release pops  from est-habdir tbl
            h3values=(String)h3.get(orgwork_id); 
            String dirpop[];
            if(h3values!=null)
			{
                dirpop=h3values.split("@");
                h3v1=dirpop[0];
                h3v2=dirpop[1];
                h3v3=dirpop[2];
			}else{
                h3v1="0";
                h3v2="0";
                h3v3="0";
                   }
          
           //release pops  from admn-hab_lnk-tname tbl
           h11values=(String)h11.get(orgwork_id); 
           String admnpop[];
           if(h11values!=null)
			{
                admnpop=h11values.split("@");
                h11v1=admnpop[0];
                h11v2=admnpop[1];
                h11v3=admnpop[2];
			}else{
                h11v1="0";
                h11v2="0";
                h11v3="0";
                  }
           //end
           
          centralamt=rs1.getDouble(8);
          adbillamt=rs12.getDouble(5);
          
         int habcount=0;    
         if(rs1.getInt(9)>1)//pop from est
        {   //System.out.println("in est pop"); 
 
           String h13values=""+(String)h13.get(orgwork_id);
           
           if(h13values!=null && !h13values.equals("") && !h13values.equals("null"))
			{
               habcount=Integer.parseInt(h13values);               
			}
         }
        else
		{
           String h14values=""+(String)h14.get(orgwork_id);
	       int h14v1=0;
	       if(h14values!=null && !h14values.equals("") && !h14values.equals("null") )
		   {
	          habcount=Integer.parseInt(h14values);               
			}
		}


          if(habcount>1)
          {
                  totpop1=Integer.parseInt(h1v1)+Integer.parseInt(h1v2)+Integer.parseInt(h1v3);
                  if(totpop1>0)
                   { 
		          sc1=adbillamt*Integer.parseInt(h1v1)/totpop1;
		          st1=adbillamt*Integer.parseInt(h1v2)/totpop1;
		          plain1=adbillamt*Integer.parseInt(h1v3)/totpop1;
		          totadbillamt=sc1+st1+plain1;
                   }
                  else
                   {
					totpop1=Integer.parseInt(h3v1)+Integer.parseInt(h3v2)+Integer.parseInt(h3v3);
if(totpop1>0){
					sc1=adbillamt*Integer.parseInt(h3v1)/totpop1;
			        st1=adbillamt*Integer.parseInt(h3v2)/totpop1;
			        plain1=adbillamt*Integer.parseInt(h3v3)/totpop1;
			        totadbillamt=sc1+st1+plain1;
}
                    }
           }
         else{
	          if(rs1.getString(10).equals("00"))
	          {  
		          totpop1=Integer.parseInt(h11v1)+Integer.parseInt(h11v2)+Integer.parseInt(h11v3);
                  if(totpop1>0)
                   { 
			          sc1=adbillamt*Integer.parseInt(h11v1)/totpop1;
			          st1=adbillamt*Integer.parseInt(h11v2)/totpop1;
			          plain1=adbillamt*Integer.parseInt(h11v3)/totpop1;
			          totadbillamt=sc1+st1+plain1;
                  }
                  else
                   {
						totpop1=Integer.parseInt(h3v1)+Integer.parseInt(h3v2)+Integer.parseInt(h3v3);
                         if(totpop1>0){
						sc1=adbillamt*Integer.parseInt(h3v1)/totpop1;
				        st1=adbillamt*Integer.parseInt(h3v2)/totpop1;
				        plain1=adbillamt*Integer.parseInt(h3v3)/totpop1;
				        totadbillamt=sc1+st1+plain1;
                            }
                    }


	           }//if 00 subprg code
	         
	         if(rs1.getString(10).equals("01")||rs1.getString(10).equals("05")||rs1.getString(10).equals("06"))
	          {  
	              sc1=0;
		          st1=0;
		          plain1=adbillamt;
		          totadbillamt=sc1+st1+plain1;
		          
	          }//if 00 subprg code 
	         
	          if(rs1.getString(10).equals("02"))
	          {           
		          sc1=adbillamt;
		          st1=0;
		          plain1=0;
		          totadbillamt=sc1+st1+plain1;
		          
	          }//if 02 subprg code 
	
	          if(rs1.getString(10).equals("03") || rs1.getString(10).equals("04"))
	          {           
		          sc1=0;
		          st1=adbillamt;
		          plain1=0;
		          totadbillamt=sc1+st1+plain1;
		      }//if 02 subprg code 
	
	        }
 
  //System.out.println("i am in audit report3333333333");
 %>

<!--  Central Printing -->
             
              <tr bgcolor="white">   
               <%if(flag){flag=false; %>
				<td class=rptvalue align="center" ><%=count++%></td>
				<td class=rptvalue align="center"><%=rs1.getString(1)%></td>
				<td class=rptvalue align="center"><%=rs1.getString(2)%></td>
				<td class=rptvalue align="center"><%=rs1.getString(3)%></td>
				<td class=rptvalue align="center"><%=rs1.getString(4)%></td>
				<td class=rptvalue align="center"><%=rs1.getString(5)%><br><%=rs1.getString(6)%></td>
                <%}else{%>
                 <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
                <%}if(flag1){flag1=false;%>
				<td class=rptvalue align="center"><%=rs1.getString(7)%></td>
				<td class=rptvalue align="center"><%=ndf.format(centralamt)%></td>
                <td class=rptvalue align="center"><%=rs12.getString(6)%></td>
				<td class=rptvalue align="center">Central</td>	
                <%}else{ %>
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>	
                <%}%>
                <td class=rptvalue align="center"><%=rs12.getString(4)%></td>
                <td class=rptvalue align="center"><%=ndf.format(sc1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(st1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(plain1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(totadbillamt)%></td>                          
  		
<%	 
      flag1=false;    
          //central bill totals
	      v1sum+=adbillamt;
		  v3sum+=sc1;
		  v4sum+=st1;
		  v5sum+=plain1;
		  v6sum=v3sum+v4sum+v5sum;
          adbillamt=0;sc1=0;st1=0;plain1=0;
 }//central-bills-txids
         //central voucher qry 
         qry9="select distinct  voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and a.work_id='"+orgwork_id+"' and a.bill_sl_no='"+wrkbillno+"'";
        
		// System.out.println("voucher qry9:"+qry9);
		 rs9=stmt9.executeQuery(qry9);
         Hashtable h9=new Hashtable();
         flag2=true;
         boolean fs=false;
         while(rs9.next())
			{          
		      fs=true;
              vochernum.add(rs9.getString(1));      
              if(vochernum.contains(rs9.getString(1)))
			{
			
			 %>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			
			<% 
			 flag2=false;
			}else
			{
			 flag2=true;
			}    // h9v1=rs9.getString(1);
		                h9v2=rs9.getString(1);
		                h9v3=rs9.getString(2);
		                h9v4=rs9.getString(3);

          // voucher pop  from est-tname tbls
           h2values=(String)h2.get(orgwork_id); 
           String voucherpop[];
           if(h2values!=null)
			{
                voucherpop=h2values.split("@");
                h2v1=voucherpop[0];
                h2v2=voucherpop[1];
                h2v3=voucherpop[2];
			}
           else{
                h2v1="0";
                h2v2="0";
                h2v3="0";
               }

          // voucher pop  from est-hab dir tbls
           h5values=(String)h5.get(orgwork_id); 
           String dirvoucherpop[];
           if(h5values!=null)
			{
                dirvoucherpop=h5values.split("@");
                h5v1=dirvoucherpop[0];
                h5v2=dirvoucherpop[1];
                h5v3=dirvoucherpop[2];
			}
           else{
                h5v1="0";
                h5v2="0";
                h5v3="0";
               }


         // voucher pop  from admn-tname tbls
           h15values=(String)h15.get(orgwork_id); 
           String admvoupop[];
           if(h15values!=null)
			{
                admvoupop=h15values.split("@");
                h15v1=admvoupop[0];
                h15v2=admvoupop[1];
                h15v3=admvoupop[2];
			}
           else{
                h15v1="0";
                h15v2="0";
                h15v3="0";
               }

       //end
         
         voucheramt=Double.parseDouble(h9v4);

         int vhabcount=0;    
         if(rs1.getInt(9)>1)//pop from est
        {   //System.out.println("in est pop"); 
 
           String h13values=""+(String)h13.get(orgwork_id);
           
           if(h13values!=null && !h13values.equals("") && !h13values.equals("null"))
			{
               vhabcount=Integer.parseInt(h13values);               
			}
         }
        else
		{
           String h14values=""+(String)h14.get(orgwork_id);
	       int h14v1=0;
	       if(h14values!=null && !h14values.equals("") && !h14values.equals("null") )
		   {
	          vhabcount=Integer.parseInt(h14values);               
			}
		}


          if(vhabcount>1)
          {

                totpop2=Integer.parseInt(h2v1)+Integer.parseInt(h2v2)+Integer.parseInt(h2v3);	
                if(totpop2>0)
                {
		        sc2=voucheramt*Integer.parseInt(h2v1)/totpop2;
				st2=voucheramt*Integer.parseInt(h2v2)/totpop2;
				plain2=voucheramt*Integer.parseInt(h2v3)/totpop2;
				totvoucheramt=sc2+st2+plain2;
                }
                else{      
                totpop2=Integer.parseInt(h15v1)+Integer.parseInt(h15v2)+Integer.parseInt(h15v3);          
                sc2=voucheramt*Integer.parseInt(h15v1)/totpop2;
				st2=voucheramt*Integer.parseInt(h15v2)/totpop2;
				plain2=voucheramt*Integer.parseInt(h15v3)/totpop2;
				totvoucheramt=sc2+st2+plain2;
           
                } 

          }  
      else    
          { //System.out.println("in central est voucher pop");    
              if(rs1.getString(10).equals("00"))
              { 
				totpop2=Integer.parseInt(h5v1)+Integer.parseInt(h5v2)+Integer.parseInt(h5v3);
                if(totpop2>0)
                {		         	 
		        sc2=voucheramt*Integer.parseInt(h5v1)/totpop2;
				st2=voucheramt*Integer.parseInt(h5v2)/totpop2;
				plain2=voucheramt*Integer.parseInt(h5v3)/totpop2;
				totvoucheramt=sc2+st2+plain2;
                }
			   //System.out.println("sc2"+sc2+"st2"+st2+"plain2"+plain2);
                else{      
                totpop2=Integer.parseInt(h15v1)+Integer.parseInt(h15v2)+Integer.parseInt(h15v3);          
                sc2=voucheramt*Integer.parseInt(h15v1)/totpop2;
				st2=voucheramt*Integer.parseInt(h15v2)/totpop2;
				plain2=voucheramt*Integer.parseInt(h15v3)/totpop2;
				totvoucheramt=sc2+st2+plain2;
                } 
              }

              if(rs1.getString(10).equals("01")||rs1.getString(10).equals("05")||rs1.getString(10).equals("06"))
              { 
				sc2=0;
				st2=0;
				plain2=voucheramt;
				totvoucheramt=sc2+st2+plain2;
			   //  System.out.println("sc2"+sc2+"st2"+st2+"plain2"+plain2);

              }

             if(rs1.getString(10).equals("02"))
              { 
				        	 
		        sc2=voucheramt;
				st2=0;
				plain2=0;
				totvoucheramt=sc2+st2+plain2;
			   //  System.out.println("sc2"+sc2+"st2"+st2+"plain2"+plain2);

              }

             if(rs1.getString(10).equals("03") || rs1.getString(10).equals("04"))
              { 
					        	 
		        sc2=0;
				st2=voucheramt;
				plain2=0;
				totvoucheramt=sc2+st2+plain2;
			   //  System.out.println("sc2"+sc2+"st2"+st2+"plain2"+plain2);

              } 

         }

          if(flag2)
         {   
			
         // central voucher totals
			          v2sum+=voucheramt;
			          v7sum+=sc2;
					  v8sum+=st2;
					  v9sum+=plain2;
					  v10sum=v7sum+v8sum+v9sum;  
 
			 
%>              
                 <td class=rptvalue align="center"><%=h9v2%></td>
				 <td class=rptvalue align="center"><%=h9v3 %></td>
				 <td class=rptvalue align="center"><%=ndf.format(voucheramt)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(sc2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(st2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(plain2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(totvoucheramt)%></td>
              </tr>
		
 <% 
     voucheramt=0;sc2=0;st2=0;plain2=0;v10sum=0;
   }
else
{     
                // central voucher totals
			          v2sum=0;
			          v7sum=0;
					  v8sum=0;
					  v9sum=0;
					  v10sum=0;   

%>             
                <tr bgcolor="white">
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>						
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center"><%=h9v2%></td>
				 <td class=rptvalue align="center"><%=h9v3 %></td>
				 <td class=rptvalue align="center"><%=ndf.format(voucheramt)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(sc2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(st2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(plain2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(totvoucheramt)%></td>
              </tr>

<% 
       
      
     }
    

 }//central bills-vouchers
//state queries////////////////////////////////
           //State bills qry 
          qry4="select distinct d.work_id,b.bill_no,b.bill_sl_no,a.state_txid,a.BILL_AMOUT_state,to_char(state_send_date,'dd/mm/yyyy') from rws_work_admn_tbl d,rws_work_bill_tbl b,rws_bill_pao_bridge_det_tbl a where d.work_id='"+rs1.getString(1)+"' and b.bill_sl_no='"+rs1.getString(7)+"' and  d.work_id=b.work_id and a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_date>=to_date('"+fromdate+"','dd-mm-yyyy') and  b.bill_date<=to_date('"+todate+"','dd-mm-yyyy') and "+qrystr+" group by d.work_id,b.bill_no,b.bill_sl_no,a.BILL_AMOUT_state,state_send_date,a.state_txid order by d.work_id,b.bill_no,b.bill_sl_no,a.state_txid";
		  //System.out.println(" state bill qry4......."+qry4);
          rs4=stmt4.executeQuery(qry4);
		 // System.out.println("i am in audit report4444444444444444444");
          
		  while(rs4.next())
		  {
               
           //release pops  from est-tname tbl   
           String sh1values=(String)h1.get(orgwork_id);
          
           String sestpop[],sh1v1="",sh1v2="",sh1v3="";
           if(sh1values!=null)
			{
                sestpop=sh1values.split("@");
                sh1v1=sestpop[0];
                sh1v2=sestpop[1];
                sh1v3=sestpop[2];
			}else{
                sh1v1="0";
                sh1v2="0";
                sh1v3="0";
                   }

           //release pops  from est-habdir tbl
            String sh3values=(String)h3.get(orgwork_id); 
            String sdirpop[],sh3v1="",sh3v2="",sh3v3="";
            if(sh3values!=null)
			{
                sdirpop=sh3values.split("@");
                sh3v1=sdirpop[0];
                sh3v2=sdirpop[1];
                sh3v3=sdirpop[2];
			}else{
                sh3v1="0";
                sh3v2="0";
                sh3v3="0";
                   }
          
           //release pops  from admn-hab_lnk-tname tbl
           String sh11values=(String)h11.get(orgwork_id); 
           String sadmnpop[],sh11v1="",sh11v2="",sh11v3="";
           if(h11values!=null)
			{
                sadmnpop=sh11values.split("@");
                sh11v1=sadmnpop[0];
                sh11v2=sadmnpop[1];
                sh11v3=sadmnpop[2];
			}else{
                sh11v1="0";
                sh11v2="0";
                sh11v3="0";
                  }
           //end

          sadbillamt=rs4.getDouble(5);
          int shabcount=0; 
          if(rs1.getInt(9)>1)//pop from est
          {  
	           String h13values=""+(String)h13.get(orgwork_id);
	           
	           if(h13values!=null && !h13values.equals("") && !h13values.equals("null"))
				{
	               shabcount=Integer.parseInt(h13values);               
				}
	         }
	        else
			{
	           String h14values=""+(String)h14.get(orgwork_id);
		       int h14v1=0;
		       if(h14values!=null && !h14values.equals("") && !h14values.equals("null") )
			   {
		          shabcount=Integer.parseInt(h14values);               
				}
			}

        if(shabcount>1)
          {

              stotpop1=Integer.parseInt(sh1v1)+Integer.parseInt(sh1v2)+Integer.parseInt(sh1v3);
              if(stotpop1>0)
               {
		          ssc1=sadbillamt*Integer.parseInt(sh1v1)/stotpop1;
		          sst1=sadbillamt*Integer.parseInt(sh1v2)/stotpop1;
		          splain1=sadbillamt*Integer.parseInt(sh1v3)/stotpop1;
		          stotadbillamt=ssc1+sst1+splain1;
              }else{
                  stotpop1=Integer.parseInt(sh3v1)+Integer.parseInt(sh3v2)+Integer.parseInt(sh3v3);
                  ssc1=sadbillamt*Integer.parseInt(sh3v1)/stotpop1;
		          sst1=sadbillamt*Integer.parseInt(sh3v2)/stotpop1;
		          splain1=sadbillamt*Integer.parseInt(sh3v3)/stotpop1;
		          stotadbillamt=ssc1+sst1+splain1;
                 }

         } 

     else 
     {     
    //System.out.println("in est pop");       
	       if(rs1.getString(10).equals("00"))
	      {  

	          stotpop1=Integer.parseInt(sh11v1)+Integer.parseInt(sh11v2)+Integer.parseInt(sh11v3);
              if(stotpop1>0)
               {
	          ssc1=sadbillamt*Integer.parseInt(sh11v1)/stotpop1;
	          sst1=sadbillamt*Integer.parseInt(sh11v2)/stotpop1;
	          splain1=sadbillamt*Integer.parseInt(sh11v3)/stotpop1;
	          stotadbillamt=ssc1+sst1+splain1;}
	         // System.out.println("ssc1"+ssc1+"sst1"+sst1+"splain1"+splain1);
	          else{
                  stotpop1=Integer.parseInt(sh3v1)+Integer.parseInt(sh3v2)+Integer.parseInt(sh3v3);
                  ssc1=sadbillamt*Integer.parseInt(sh3v1)/stotpop1;
		          sst1=sadbillamt*Integer.parseInt(sh3v2)/stotpop1;
		          splain1=sadbillamt*Integer.parseInt(sh3v3)/stotpop1;
		          stotadbillamt=ssc1+sst1+splain1;
                 }
           }

          if(rs1.getString(10).equals("01")||rs1.getString(10).equals("05")||rs1.getString(10).equals("06"))
	       {  
          
	          ssc1=0;
	          sst1=0;
	          splain1=sadbillamt;
	          stotadbillamt=ssc1+sst1+splain1;
	         // System.out.println("ssc1"+ssc1+"sst1"+sst1+"splain1"+splain1);
	          
           }

           if(rs1.getString(10).equals("02"))
	       {  
              ssc1=sadbillamt;
	          sst1=0;
	          splain1=0;
	          stotadbillamt=ssc1+sst1+splain1;
	         // System.out.println("ssc1"+ssc1+"sst1"+sst1+"splain1"+splain1);
	          
           }


          if(rs1.getString(10).equals("03")||rs1.getString(10).equals("04"))
	       {  	        
	          ssc1=0;
	          sst1=sadbillamt;
	          splain1=0;
	          stotadbillamt=ssc1+sst1+splain1;
	         // System.out.println("ssc1"+ssc1+"sst1"+sst1+"splain1"+splain1);
	          
           }
       }//end est pop
     
 
 %>

<!-- State Printing -->
             
              <tr bgcolor="white">   
              
				<td class=rptvalue align="center" >-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">State</td>	
                <td class=rptvalue align="center"><%=rs4.getString(4)%></td>
                <td class=rptvalue align="center"><%=ndf.format(ssc1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(sst1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(splain1)%></td>
				<td class=rptvalue align="center"><%=ndf.format(stotadbillamt)%></td>                          
               
				
			
<%	 //System.out.println("i am in audit report55555555555555");
      flag1=false;  
          //state bills totals  
          sv1sum+=sadbillamt;
		  sv3sum+=ssc1;
		  sv4sum+=sst1;
		  sv5sum+=splain1;
		  sv6sum=sv3sum+sv4sum+sv5sum;
          sadbillamt=0;ssc1=0;sst1=0;splain1=0;
   }//state-bills-txids
         //State voucher qry 
         qry10="select distinct  voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_bill_bank_bridge_tbl br where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and a.work_id='"+orgwork_id+"' and a.bill_sl_no ='"+wrkbillno+"' and a.work_id=br.work_id";
        
		// System.out.println("state voucher qry10:"+qry10);
		 rs10=stmt10.executeQuery(qry10);
         Hashtable h10=new Hashtable();
         flag2=true;

           fs1=false;
           while(rs10.next())
			{ 
             fs1=true;
              svochernum.add(rs10.getString(1));      
                      if(svochernum.contains(rs10.getString(1)))
			{
			
			 %>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			<td class=rptvalue align="center">-</td>
			
			<% 
			 flag2=false;
			}else
			{
			 flag2=true;
			}
			           // h9v1=rs9.getString(1);
		                h10v2=rs10.getString(1);
		                h10v3=rs10.getString(2);
		                h10v4=rs10.getString(3);
          
           // voucher pop  from est-tname tbls
           String sh2values=(String)h2.get(orgwork_id);
           String svoucherpop[],sh2v1="",sh2v2="",sh2v3="";
           if(sh2values!=null)
			{
                svoucherpop=sh2values.split("@");
                sh2v1=svoucherpop[0];
                sh2v2=svoucherpop[1];
                sh2v3=svoucherpop[2];
			}
           else{
                sh2v1="0";
                sh2v2="0";
                sh2v3="0";
               }

          // voucher pop  from est-hab dir tbls
          String sh5values=(String)h5.get(orgwork_id); 
           String sdirvoucherpop[],sh5v1="",sh5v2="",sh5v3="";
           if(sh5values!=null)
			{
                sdirvoucherpop=sh5values.split("@");
                sh5v1=sdirvoucherpop[0];
                sh5v2=sdirvoucherpop[1];
                sh5v3=sdirvoucherpop[2];
			}
           else{
                sh5v1="0";
                sh5v2="0";
                sh5v3="0";
               }


         // voucher pop  from admn-tname tbls
           String sh15values=(String)h15.get(orgwork_id); 
           String sadmvoupop[],sh15v1="",sh15v2="",sh15v3="";
           if(sh15values!=null)
			{
                sadmvoupop=sh15values.split("@");
                sh15v1=sadmvoupop[0];
                sh15v2=sadmvoupop[1];
                sh15v3=sadmvoupop[2];
			}
           else{
                sh15v1="0";
                sh15v2="0";
                sh15v3="0";
               }

       //end
          svoucheramt=Double.parseDouble(h10v4);

          int svhabcount=0;    
         if(rs1.getInt(9)>1)//pop from est
        {   //System.out.println("in est pop"); 
 
           String h13values=""+(String)h13.get(orgwork_id);
           
           if(h13values!=null && !h13values.equals("") && !h13values.equals("null"))
			{
               svhabcount=Integer.parseInt(h13values);               
			}
         }
        else
		{
           String h14values=""+(String)h14.get(orgwork_id);
	       int h14v1=0;
	       if(h14values!=null && !h14values.equals("") && !h14values.equals("null") )
		   {
	          svhabcount=Integer.parseInt(h14values);               
			}
		}


          if(svhabcount>1)
          {	stotpop2=Integer.parseInt(sh2v1)+Integer.parseInt(sh2v2)+Integer.parseInt(sh2v3);   
	         if(stotpop2>0)
            {
	          ssc2=svoucheramt*Integer.parseInt(sh2v1)/stotpop2;
			  sst2=svoucheramt*Integer.parseInt(sh2v2)/stotpop2;
			  splain2=svoucheramt*Integer.parseInt(sh2v3)/stotpop2;
			  stotvoucheramt=ssc2+sst2+splain2;
             }else
             { 
              stotpop2=Integer.parseInt(sh15v1)+Integer.parseInt(sh15v2)+Integer.parseInt(sh15v3);  
              ssc2=svoucheramt*Integer.parseInt(sh15v1)/stotpop2;
			  sst2=svoucheramt*Integer.parseInt(sh15v2)/stotpop2;
			  splain2=svoucheramt*Integer.parseInt(sh15v3)/stotpop2;
			  stotvoucheramt=ssc2+sst2+splain2;     
           }  
        }
		 else
		 {  
             //System.out.println("in vocuher est pop");   
             if(rs1.getString(10).equals("00"))
             { 
			  stotpop2=Integer.parseInt(sh5v1)+Integer.parseInt(sh5v2)+Integer.parseInt(sh5v3);	
              if(stotpop2>0)
             {         
	          ssc2=svoucheramt*Integer.parseInt(sh5v1)/stotpop2;
			  sst2=svoucheramt*Integer.parseInt(sh5v2)/stotpop2;
			  splain2=svoucheramt*Integer.parseInt(sh5v3)/stotpop2;
			  stotvoucheramt=ssc2+sst2+splain2;
             }
            else
             { 
              stotpop2=Integer.parseInt(sh15v1)+Integer.parseInt(sh15v2)+Integer.parseInt(sh15v3);  
              ssc2=svoucheramt*Integer.parseInt(sh15v1)/stotpop2;
			  sst2=svoucheramt*Integer.parseInt(sh15v2)/stotpop2;
			  splain2=svoucheramt*Integer.parseInt(sh15v3)/stotpop2;
			  stotvoucheramt=ssc2+sst2+splain2;     
           }  
            }

           if(rs1.getString(10).equals("01")||rs1.getString(10).equals("05")||rs1.getString(10).equals("06"))
             { 
			  ssc2=0;
			  sst2=0;
			  splain2=svoucheramt;;
			  stotvoucheramt=ssc2+sst2+splain2;

            }		          


           if(rs1.getString(10).equals("02"))
             { 
			  ssc2=svoucheramt;
			  sst2=0;
			  splain2=0;
			  stotvoucheramt=ssc2+sst2+splain2;

            }


          if(rs1.getString(10).equals("03")||rs1.getString(10).equals("04"))
             { 
			  ssc2=0;
			  sst2=svoucheramt;
			  splain2=0;
			  stotvoucheramt=ssc2+sst2+splain2;

            }


         }
		
        

  if(flag2)
         {  
      // state voucher totals
		      sv2sum=0;
		      sv7sum=0;
			  sv8sum=0;
			  sv9sum=0;
			  sv10sum=0;
		      
%>              

                 <td class=rptvalue align="center"><%=h10v2%></td>
				 <td class=rptvalue align="center"><%=h10v3 %></td>
				 <td class=rptvalue align="center"><%=ndf.format(svoucheramt)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(ssc2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(sst2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(splain2)%></td>
				 <td class=rptvalue align="center"><%=ndf.format(stotvoucheramt)%></td>
		
				

              </tr>

			
 <% 
     
      
   }
else
{    // state voucher totals
		      sv2sum+=svoucheramt;
		      sv7sum+=ssc2;
			  sv8sum+=sst2;
			  sv9sum+=splain2;
			  sv10sum=sv7sum+sv8sum+sv9sum;
%>             
                <tr bgcolor="white">
                <td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>						
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>
				<td class=rptvalue align="center">-</td>						
				<td class=rptvalue align="center">-</td>
                <td class=rptvalue align="center">-</td>						
				<td class=rptvalue align="center">-</td>
                <td class=rptvalue align="center">-</td>
	
								
          </tr>

<% 
      
    
}
  
}//state-bills-vouchers

//central totals
          //bills
          csv1sum=v1sum+sv1sum;
		 
          csv3sum=v3sum+sv3sum;
		  csv4sum=v4sum+sv4sum;
		  csv5sum=v5sum+sv5sum;
		  csv6sum=csv3sum+csv4sum+csv5sum;
          //vouchers
 csv2sum=v2sum+sv2sum;
          csv7sum=v7sum+sv7sum;
		  csv8sum=v8sum+sv8sum;
		  csv9sum=v9sum+sv9sum;
		  csv10sum=csv7sum+csv8sum+csv9sum;
 }//central bills
v1sum=0;v2sum=0;v3sum=0;v4sum=0;v5sum=0;v6sum=0;v7sum=0;v8sum=0;v9sum=0;v10sum=0;sv1sum=0;sv2sum=0;sv3sum=0;sv4sum=0;sv5sum=0;sv6sum=0;sv7sum=0;sv8sum=0;sv9sum=0;sv10sum=0;
//System.out.println("i am in audit report666666666666666");
%>
    <tr bgcolor="#99E6FF">
		   <td class=btext  align="center" colspan=7>Totals</td>
		   <td class=btext  align="center">Ad.Amt:<%=ndf.format(csv1sum)%></td>
		   <td class=btext  align="center">-</td>
		   <td class=btext  align="center">-</td>
		   <td class=btext  align="center">-</td>
		   <td class=btext  align="center">SC :<%=ndf.format(csv3sum)%></td>
           <td class=btext  align="center">ST :<%=ndf.format(csv4sum)%></td>
		   <td class=btext  align="center">Plain:<%=ndf.format(csv5sum)%></td>
		   <td class=btext  align="center">TOT:<%=ndf.format(csv6sum)%></td>
		   <td class=btext  align="center">-</td> 
           <td class=btext  align="center">-</td> 
           <td class=btext  align="center">Voucher:<%=ndf.format(csv2sum)%></td> 
           <td class=btext  align="center">SC :<%=ndf.format(csv7sum)%></td>
           <td class=btext  align="center">ST :<%=ndf.format(csv8sum)%></td>
		   <td class=btext  align="center">Plain <%=ndf.format(csv9sum)%></td>
		   <td class=btext  align="center">TOT:<%=ndf.format(csv10sum)%></td>
		  

	   </tr> 



<%

 //grand state+central totals
          gcsv1sum+=csv1sum;
		  gcsv2sum+=csv2sum;
          gcsv3sum+=csv3sum;
		  gcsv4sum+=csv4sum;
		  gcsv5sum+=csv5sum;
		  gcsv6sum=gcsv3sum+gcsv4sum+gcsv5sum;
          gcsv7sum+=csv7sum;
		  gcsv8sum+=csv8sum;
		  gcsv9sum+=csv9sum;
		  gcsv10sum=gcsv7sum+gcsv8sum+gcsv9sum;
csv1sum=0;csv2sum=0;csv3sum=0;csv4sum=0;csv5sum=0;csv6sum=0;csv7sum=0;csv8sum=0;csv9sum=0;csv10sum=0;
}//for loop



%>
			<tr bgcolor="#99E6FF">
				<td class=btext align="center" colspan=7>Grand Totals</td>
				<td class=btext align="center">Grand Ad.Amt<%=ndf.format(gcsv1sum)%></td>
				<td class=btext align="center">-</td>
				<td class=btext align="center">-</td>
				<td class=btext align="center">-</td>
				<td class=btext align="center">Grand SC Amt:<%=ndf.format(gcsv3sum)%></td>
				<td class=btext align="center">Grand ST Amt:<%=ndf.format(gcsv4sum)%></td>
				<td class=btext align="center">Grand Plain Amt:<%=ndf.format(gcsv5sum)%></td>
				<td class=btext align="center">Grand TOT:<%=ndf.format(gcsv6sum)%></td>
				<td class=btext align="center">-</td>
    			<td class=btext align="center">-</td>
                <td class=btext align="center">Grand Voucher Amt:<%=ndf.format(gcsv2sum)%></td>
				<td class=btext align="center">Grand SC Amt:<%=ndf.format(gcsv7sum)%></td>
				<td class=btext align="center">Grand ST Amt:<%=ndf.format(gcsv8sum)%></td>
				<td class=btext align="center">Grand Plain Amt:<%=ndf.format(gcsv9sum)%></td>
				<td class=btext align="center">Grand TOT Amt:<%=ndf.format(gcsv10sum)%></td>


			</tr>
<%
}
else{%>
<!-- <tr bgcolor="#99E6FF"><td colspan="22" align="center">No records</td></tr>-->
<script>
          alert("No Records...");
          document.f1.action="./rws_voucher_audit_frm.jsp";
		  document.f1.submit();
</script>
<%}
}
catch(SQLException e)
{
e.printStackTrace();
}
 %>
</table>
</td>
</tr>
</table>
</form>
