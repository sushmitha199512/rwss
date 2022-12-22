<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>


<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null,pst5=null,pst6=null;
int count=1;
//first time display purpose
String s;
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s = formatter.format(date);
String currentdate=s.replace("/","-");
//System.out.println("current"+currentdate);
String rvalue=(String)session.getAttribute("rvalue");
String rvalue1=(String)session.getAttribute("rvalue1");
if(rvalue==null)
rvalue=currentdate;
if(rvalue1==null)
rvalue1=currentdate;
//System.out.println("rvalue"+rvalue);
//System.out.println("rvalue1"+rvalue1);

String distcode =(String)session.getAttribute("distcode");
String dname=(String)session.getAttribute("dname"); 
//System.out.println("this is dcode..."+distcode);
//System.out.println("dname"+dname);	

%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
<tr align="center">
			<td align="right" class="rptHeading" colspan=25><font color="red">&nbsp;Note&nbsp;:&nbsp; Amount Displayed in Laksh(s)</font></td>	
		</tr>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>DETAILED DAILY COMPARISION - SCARCITY REPORT OF HABITATIONS OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp; ON:&nbsp;&nbsp;<%=rvalue%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=rvalue1%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		
<%
try
{   
     String h1values="",h2values="",h3values="",h5values="",h6values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="",h5v1="",h5v2="",h5v3="",h6v1="",h6v2="",h6v3="";
     String ext_fac[],tras[],workdet[],transdet[],deepflush[];
     int v1sum=0,v2sum=0,v3sum=0,v4sum=0,v5sum=0,v6sum=0,v7sum=0,v8sum=0,v9sum=0,v10sum=0,v11sum=0,v12sum=0;
     float v13sum=0;
	%>
		   <tr align="center" bgcolor="#ffffff">
			<td class=btext align="center" rowspan="2">S.No.</td>
			<td class=btext align="center" rowspan="2">Mandal Name</td>
			<td class=btext align="center" rowspan="2">Panchayat Name</td>
			<td class=btext align="center"  rowspan="2">Hab Name </td>
			<td class=btext align="center" rowspan="2">Hab Code</td>
            <td class=btext align="center" rowspan="2">Causes of<br> Scarcity</td>
            <td class=btext align="center" rowspan="2">Hab Status</td>
			<td class=btext align="center" colspan="4">Existing Facilities</td>
			<td class=btext align="center" colspan="2">Transportation of<br> Water </td>
			<td class=btext align="center" colspan="2">Hiring of Private<br> Sources </td>
            <td class=btext align="center" colspan="2">Flushing of<br> Borewells</td>
			<td class=btext align="center" colspan="2">Deeping of<br> Borewells</td>
			<td class=btext align="center">Power <br> Problem</td>
            <td class=btext align="center" rowspan="2"> Remarks</td>
			<td class=btext align="center" colspan="4">On going Works</td>
			</tr>
			<tr>
			<td class=btext align="center">OWs</td>
			<td class=btext align="center">HPs</td>
			<td class=btext align="center">PWSS </td>
			<td class=btext align="center">CPWSS </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
            <td class=btext align="center">Contingency <br>Plan</td>
			<td class=btext align="center">Daily Report </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
			<td class=btext align="center">Contingency<br> Plan</td>
			<td class=btext align="center">Daily Report </td>
			<td class=btext align="center">Daily Report </td>
            <td class=btext align="center">Name of<br> the Work</td>
			<td class=btext align="center">Est.Cost<br>(Rs.in Lakhs)</td>
			<td class=btext align="center">Grant</td>
			<td class=btext align="center">Probable date <br>of Completion</td>
</tr>
		
       <tr align="center">
            <td class=btext>1</td>	
			<td class=btext>2</td>	
			<td class=btext>3</td>
            <td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7</td>
            <td class=btext>8</td>
            <td class=btext>9</td>
			<td class=btext>10</td>
            <td class=btext>11</td>
			<td class=btext>12</td>	
			<td class=btext>13</td>	
			<td class=btext>14</td>
            <td class=btext>15</td>
			<td class=btext>16</td>
			<td class=btext>17</td>
            <td class=btext>18</td>
            <td class=btext>19</td>
			<td class=btext>20</td>	
			<td class=btext>21</td>	
			<td class=btext>22</td>
            <td class=btext>23</td>
			<td class=btext>24</td>	
			<td class=btext>25</td>	
			
			
			
			
		</tr>
     
        <%
 //queries
           String qry4="select distinct a.habitation_code,c.work_name ,nvl(c.SANCTION_AMOUNT,'0'),e.programme_name,to_char(f.PROBABLE_DATE,'dd-mm-yyyy') from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a ,rws_admn_hab_lnk_tbl  b ,rws_work_admn_tbl  c,rws_work_completion_tbl d ,rws_programme_tbl e ,RWS_CONTRACTOR_SELECTION_TBL f where a.habitation_code=b.hab_code and substr(a.habitation_code,1,2)='"+distcode+"' and b.work_id=c.work_id and c.work_id=d.work_id  and b.work_id=d.work_id and c.programme_code=e.programme_code and c.work_id=f.work_id and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
	       Hashtable h3=new Hashtable();
	       pst4=conn.createStatement();
	       rs4=pst4.executeQuery(qry4);
           //System.out.println("my qry4 "+qry4);
	       while(rs4.next())
	       {
	         h3.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5));
             ////System.out.println("habcode"+rs2.getString(1));
             //System.out.println(h3.put(rs4.getString(1),rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5)));
	       }

          String qry6="select distinct b.habitation_code, sum(case when DEEPEN_FLUSH='F' then 1 else 0 end) as flush ,sum(case when DEEPEN_FLUSH='D' then 1 else 0 end) as deep from RWS_DROUGHT_FLUSH_DEEPEN_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL  b  where a.habitation_code=b.habitation_code and substr(a.habitation_code,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by b.habitation_code";
          // String qry6="select habcode,sum(case when DEEPEN_FLUSH='F' then 1 else 0 end) as flush ,sum(case when DEEPEN_FLUSH='D' then 1 else 0 end) as deep from RWS_DROUGHT_FLUSH_DEEPEN_TBL a ,RWS_DROUGHT_HABITATION_TBL b  where a.habitation_code=b.habcode group by habcode";
	       Hashtable h6=new Hashtable();
	       pst6=conn.createStatement();
	       rs6=pst6.executeQuery(qry6);
           //System.out.println("my qry6 "+qry6);
	       while(rs6.next())
	       {
	         h6.put(rs6.getString(1),rs6.getString(2)+"@"+rs6.getString(3));
             ////System.out.println("................."+h6.put(rs6.getString(1),rs6.getString(2)+"@"+rs6.getString(3)));
	       }
           String qry5="select habcode,sum(case when (TANKER_NO_OF_TRIPS>0 ) or  (TANKER_CAPACITY>0) or(TANKER_QTY>0) then 1 else 0 end) as trandaily,sum(case when (PVT_SOURCES_HIRED_NO>0 ) or  (PVT_SOURCES_QTY>0) then 1 else 0 end) as sourcedaily from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b where  a.habcode=b.habitation_code and  substr(a.habcode,1,2)='"+distcode+"'  and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by habcode";
           //String qry5="select habcode,sum(case when (TANKER_NO_OF_TRIPS>0 ) or  (TANKER_CAPACITY>0) or(TANKER_QTY>0) then 1 else 0 end) as trandaily,sum(case when (PVT_SOURCES_HIRED_NO>0 ) or  (PVT_SOURCES_QTY>0) then 1 else 0 end) as sourcedaily from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b where  a.habcode=b.habitation_code and  substr(a.habcode,1,2)='"+distcode+"'  and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by habcode";
           //String qry5="select habcode,sum(case when TRANSPORTATION='Y' then 1 else 0 end) as trans,sum(case when (TANKER_NO_OF_TRIPS>0 ) or  (TANKER_CAPACITY>0) or(TANKER_QTY>0) then 1 else 0 end) as trandaily,sum(case when (PVT_SOURCES_HIRED_NO>0 ) or  (PVT_SOURCES_QTY>0) then 1 else 0 end) as sourcedaily from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b where  a.habcode=b.habitation_code and  substr(a.habcode,1,2)='"+distcode+"'  and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by habcode";
	       Hashtable h5=new Hashtable();
	       pst5=conn.createStatement();
	       rs5=pst5.executeQuery(qry5);
           //System.out.println("my qry5 "+qry5);
	       while(rs5.next())
	       {
	         h5.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));//+"@"+rs5.getString(5)+"@"+rs5.getString(6)+"@"+rs5.getString(7));
             ////System.out.println( h3.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7)));
	       }


 
          String qry3="select habcode,sum(case when TRANSPORTATION='Y' then 1 else 0 end) as trans ,sum(nvl(HIRING_OF_SOURCES,'0')),sum(nvl(FLUSHING,'0')),sum(nvl(DEEPENING,'0')),POWER_PROBLEM,nvl(a.remarks,'-') from RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,rws_habitation_directory_tbl h,RWS_DROUGHT_SCAR_REASONS_TBl s where substr(a.habcode,1,2)='"+distcode+"'and  a.habcode=h.hab_code and  a.scarcity_code=s.scarcity_code and a.habcode=b.habitation_code and TRANSPORTATION='Y' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by habcode,a.remarks,POWER_PROBLEM";
          // String qry3=" select habcode,TRANSPORTATION,nvl(HIRING_OF_SOURCES,'0'),nvl(FLUSHING,'0'),nvl(DEEPENING,'0'),POWER_PROBLEM,nvl(a.remarks,'-'),date_of_entry  from  RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,RWS_DROUGHT_SCAR_REASONS_TBL f,rws_habitation_directory_tbl g  where a.scarcity_code=f.scarcity_code and b.habitation_code=g.hab_code and a.habcode=b.habitation_code and TRANSPORTATION='Y' and substr(a.habcode,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
          // String qry3="select habcode,TRANSPORTATION,nvl(HIRING_OF_SOURCES,'0'),nvl(FLUSHING,'0'),nvl(DEEPENING,'0'),POWER_PROBLEM,nvl(remarks,'-')  from  RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b where a.habcode=b.habitation_code  and substr(a.habcode,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
           //String qry3="select habcode,TRANSPORTATION,nvl(HIRING_OF_SOURCES,'0'),nvl(FLUSHING,'0'),nvl(DEEPENING,'0'),POWER_PROBLEM,nvl(remarks,'-')  from  RWS_DROUGHT_HABITATION_TBL a ,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b where a.habcode=b.habitation_code and  substr(a.habcode,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
	       Hashtable h2=new Hashtable();
	       pst3=conn.createStatement();
	       rs3=pst3.executeQuery(qry3);
           //System.out.println("my qry3 "+qry3);
	       while(rs3.next())
	       {
	         h2.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7));
            // //System.out.println( h2.put(rs3.getString(1),rs3.getString(2)+"@"+rs3.getString(3)+"@"+rs3.getString(4)+"@"+rs3.getString(5)+"@"+rs3.getString(6)+"@"+rs3.getString(7)));
	       }

          String qry2="select distinct a.hab_code,sum(case when type_of_asset_code='06' then 1 else 0 end) as oh,sum(case when type_of_asset_code='04' then 1 else 0 end) as hp,sum(case when type_of_asset_code='01' then 1 else 0 end) as pws,sum(case when type_of_asset_code='03' then 1 else 0 end) as cpws from rws_asset_mast_tbl a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,RWS_DROUGHT_HABITATION_TBL c,RWS_DROUGHT_SCAR_REASONS_TBL s ,rws_habitation_directory_tbl h where substr(a.hab_code,1,2)='"+distcode+"' and a.hab_code=b.habitation_code and b.habitation_code=c.habcode and b.habitation_code=h.hab_code and a.hab_code=c.habcode and c.scarcity_code=s.scarcity_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by a.hab_code";
           //String qry2="select hab_code,sum(case when type_of_asset_code='06' then 1 else 0 end) as oh,sum(case when type_of_asset_code='04' then 1 else 0 end) as hp,sum(case when type_of_asset_code='01' then 1 else 0 end) as pws,sum(case when type_of_asset_code='03' then 1 else 0 end) as cpws from rws_asset_mast_tbl a,RWS_DROUGHT_HAB_TR_PVT_SO_TBL b,RWS_DROUGHT_HABITATION_TBL c where a.hab_code=b.habitation_code and b.habitation_code=c.habcode and  substr(a.hab_code,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') group by hab_code";
	       Hashtable h1=new Hashtable();
	       pst2=conn.createStatement();
	       rs2=pst2.executeQuery(qry2);
           //System.out.println("my qry2 "+qry2);
	       while(rs2.next())
	       {
	         h1.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
             ////System.out.println("habcode"+rs2.getString(1));
             ////System.out.println(h1.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)));
	       }

           String qry1="select distinct mname,pname,panch_name,habitation_code,scarcity_name,coverage_status from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a,RWS_DROUGHT_HABITATION_TBL  e,RWS_DROUGHT_SCAR_REASONS_TBL f,rws_habitation_directory_tbl g,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl r  where substr(habitation_code,1,2)='"+distcode+"' and m.dcode=substr(habitation_code,1,2) and m.mcode=substr(habitation_code,6,2) and p.dcode=substr(habitation_code,1,2) and p.mcode=substr(habitation_code,6,2) and p.pcode=substr(habitation_code,13,2) and a.habitation_code=r.panch_code and  a.habitation_code=e.habcode and e.scarcity_code=f.scarcity_code and a.habitation_code=g.hab_code and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') ";
         //String qry1="select distinct mname,pname,PANCH_NAME,PANCH_CODE,f.scarcity_name,COVERAGE_STATUS  from RWS_DROUGHT_HAB_TR_PVT_SO_TBL  a,rws_mandal_tbl b ,rws_panchayat_tbl c ,rws_panchayat_raj_tbl d ,RWS_DROUGHT_HABITATION_TBL  e ,RWS_DROUGHT_SCAR_REASONS_TBL f , rws_habitation_directory_tbl g where  substr(habitation_code,1,2)='"+distcode+"' and substr(habitation_code,1,2)=b.dcode and substr(habitation_code,6,2)=b.mcode and substr(habitation_code,13,2)=c.pcode and substr(habitation_code,6,2)=c.mcode and substr(habitation_code,1,2)=c.dcode  and substr(habitation_code,13,2)=substr(d.hab_code,13,2) and substr(habitation_code,6,2)=substr(d.hab_code,6,2) and substr(habitation_code,1,2)=substr(d.hab_code,1,2) and e.habcode=d.panch_code and e.scarcity_code=f.scarcity_code and a.date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and a.date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') and a.habitation_code=g.hab_code order by pname";
         // String qry1="select distinct mname,pname,panch_name,panch_code,scarcity_name,coverage_status from RWS_DROUGHT_HAB_TR_PVT_SO_TBL a,RWS_DROUGHT_HABITATION_TBL  e,RWS_DROUGHT_SCAR_REASONS_TBL f,rws_habitation_directory_tbl g ,rws_panchayat_raj_tbl p ,rws_mandal_tbl m ,rws_panchayat_tbl t where a.habitation_code=e.habcode and e.scarcity_code=f.scarcity_code and a.habitation_code=g.hab_code and a.habitation_code=p.panch_code and m.dcode=substr(habitation_code,1,2) and m.mcode=substr(habitation_code,6,2) and t.dcode=substr(habitation_code,1,2) and t.mcode=substr(habitation_code,6,2) and t.pcode=substr(habitation_code,13,2) and substr(habitation_code,1,2)='"+distcode+"' and date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy')";
          ////System.out.println("my qry1 "+qry1);
          pst1=conn.createStatement();
          rs1=pst1.executeQuery(qry1);
          //System.out.println("my qry1 "+qry1);
          while(rs1.next())
          {
            ////System.out.println("111111111"+qry1);
            //existing hash values getting
            
            h1values=(String)h1.get(rs1.getString(4));
            if(h1values!=null)
            {
             ext_fac=h1values.split("@");
             v1=ext_fac[0];
			 v2=ext_fac[1];
			 v3=ext_fac[2];
			 v4=ext_fac[3];

             v1sum+=Integer.parseInt(v1);
			 v2sum+=Integer.parseInt(v2);
			 v3sum+=Integer.parseInt(v3);
			 v4sum+=Integer.parseInt(v4);
		             }
           else
			{	
	         v1="0";
			 v2="0";
			 v3="0";
			 v4="0";
     		}
            //end
            //transportation hash values
            h2values=(String)h2.get(rs1.getString(4));
            if(h2values!=null)
            {
             tras=h2values.split("@");
             h2v1=tras[0];
			 h2v2=tras[1];
			 h2v3=tras[2];
             h2v4=tras[3];
             h2v5=tras[4];
             h2v6=tras[5];
			 v5sum+=Integer.parseInt(h2v1);
             v7sum+=Integer.parseInt(h2v2);
             v9sum+=Integer.parseInt(h2v3);
             v11sum+=Integer.parseInt(h2v4);
             
             }
           else
			{	
	         h2v1="0";
			 h2v2="0";
			 h2v3="0";
             h2v4="0";
             h2v5="-";
             h2v6="-";
            
			}
            //end 
           
            //transport details hash5 values
            h5values=(String)h5.get(rs1.getString(4));
            ////System.out.println("h5 length"+h5values); 
            if(h5values!=null)
            {
               transdet=h5values.split("@");
               h5v1=transdet[0];
			   h5v2=transdet[1];
               //h5v3=transdet[2];
              v6sum+=Integer.parseInt(h5v1);
              v8sum+=Integer.parseInt(h5v2);
			 }
           else
			{	
	         h5v1="0";
			 h5v2="0";
             //h5v3="0";
			}
            //end 
            //flush deep details hash6 values
            h6values=(String)h6.get(rs1.getString(4));
            ////System.out.println("h6 length"+h6values); 
            if(h6values!=null)
            {
               deepflush=h6values.split("@");
               h6v1=deepflush[0];
			   h6v2=deepflush[1];
               //h5v3=deepflush[2];
              v10sum+=Integer.parseInt(h6v1);
              v12sum+=Integer.parseInt(h6v2);
			 }
           else
			{	
	         h6v1="0";
			 h6v2="0";
             //h5v3="-";
			}
            //end 

 //work details hash values
            h3values=(String)h3.get(rs1.getString(4));
            if(h3values!=null)
            {
             workdet=h3values.split("@");
             h3v1=workdet[0];
			 h3v2=workdet[1];
			 h3v3=workdet[2];
             h3v4=workdet[3];

             v13sum+=Float.parseFloat(h3v2);
            System.out.println("v13sum"+v13sum); 
			 }
           else
			{	
	         h3v1="-";
			 h3v2="-";
			 h3v3="-";
             h3v4="-";
                  
			}
            //end 


 
         %>
      <tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left"><%=rs1.getString(1)%></td>
           <td class=rptvalue align="left"><%=rs1.getString(2)%></td>	
            <td class=rptvalue align="left"><%=rs1.getString(3)%></td>	
			<td class=rptvalue align="left">&nbsp;<%=rs1.getString(4)%></td>	
			<td class=rptvalue align="left"><%=rs1.getString(5)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(6)%></td>
			<td class=rptvalue align="right"><%=v1%></td>
            <td class=rptvalue align="center"><%=v2%></td>
            <td class=rptvalue align="right"><%=v3%></td>
			<td class=rptvalue align="right"><%=v4%></td>
            <td class=rptvalue align="right"><%=h2v1%></td>
			<td class=rptvalue align="right"><%=h5v1%></td>
			<td class=rptvalue align="right"><%=h2v2%></td>
            <td class=rptvalue align="right"><%=h5v2%></td>
            <td class=rptvalue align="right"><%=h2v3%></td>
            <td class=rptvalue align="right"><%=h6v1%></td>
            <td class=rptvalue align="right"><%=h2v4%></td>
            <td class=rptvalue align="right"><%=h6v2%></td>
            <td class=rptvalue align="right"><%=h2v5%></td>
            <td class=rptvalue align="center"><%=h2v6%></td>
            <td class=rptvalue align="right"><%=h3v1%></td>
            <td class=rptvalue align="right"><%=h3v2%></td>
            <td class=rptvalue align="right"><%=h3v3%></td>
            <td class=rptvalue align="center"><%=h3v4%></td>
		</tr>
	<%
   
}
    

%>
<tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=7>Totals</td>
             <td class=btext align="right"><%=v1sum%></td>
			<td class=btext align="right"><%=v2sum%></td>
            <td class=btext align="right"><%=v3sum%></td>
            <td class=btext align="right"><%=v4sum%></td>
			<td class=btext align="right"><%=v5sum%></td>
            <td class=btext align="right"><%=v6sum%></td>
			<td class=btext align="right"><%=v7sum%></td>
            <td class=btext align="right"><%=v8sum%></td>
            <td class=btext align="right"><%=v9sum%></td>
			<td class=btext align="right"><%=v10sum%></td>
            <td class=btext align="right"><%=v11sum%></td>
			<td class=btext align="right"><%=v12sum%></td>
		<td class=btext align="right"></td>
           	<td class=btext align="right">-</td>
<td class=btext align="right">-</td>
<td class=btext align="right"><%=v13sum%></td>
<td class=btext align="right">-</td>
<td class=btext align="right">-</td>
			
		</tr>
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
