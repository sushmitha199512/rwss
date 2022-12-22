<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	
	nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

	//22/08/2013
	//System.out.println("Server Date:"+w.getServerDate());

	String cYear=w.getServerDate().substring(6,10);

	String currentMonth=RwsUtils.getCurrentMont();

	


    System.out.println("Comming:");
	String rDistrict="";
	rDistrict = request.getParameter("district");
	if(rDistrict!=null)
	{session.setAttribute("rDistrict",rDistrict);
	}

String programe="";
	String  program[] = request.getParameterValues("program");
		
		ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
//System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
}
//System.out.println("programe::"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}

	String  dname = request.getParameter("dname");
	if(dname!=null)
	{ session.setAttribute("dname",dname);
	}
    String  pname ="";//request.getParameter("prgname");

   String fyear ="11";// request.getParameter("finyear").substring(2);
	if(fyear!=null)
	{ session.setAttribute("fyear",fyear);
	}


      //schemes
    String[] schemes=request.getParameterValues("scheme");
	
    String scheme="";
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	//System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
    if(scheme!=null)
	{ session.setAttribute("scheme",scheme);
	}
   System.out.println(" Scheme...."+scheme);

    ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null,rs17=null;
    Statement pst1 = null,pst2=null,pst3=null,pst4 = null,pst5=null,pst6 = null,pst7=null,pst8 = null,pst9=null,pst10 = null,pst11=null,pst12 = null,pst13 = null,pst14=null,pst15=null,stmt1=null;


      stmt1=conn.createStatement();
        
              rs17=stmt1.executeQuery("select programme_name from rws_programme_tbl where programme_code  in("+programe+")");   
              while(rs17.next()){
					pname=pname+rs17.getString(1)+",";				
}

System.out.println("Programe name"+pname);
if(pname!=null)
	{ session.setAttribute("pname",pname);
	}



    //int p=Integer.parseInt(pyear);
%><BODY>
<form name=f1 method="post">
	<p align="center">
	<font face=verdana size=2 color="orange"><b>Status of DPR Works Duration Report </b></font><BR>
<font color="green" face=verdana size=2><b>For&nbsp;&nbsp;<%=pname.substring(0,pname.length()-1)%> Works</b></font>&nbsp; </p>


<table border = 0 cellspacing = 0 cellpadding = 0  width="70%" style="border-collapse:collapse"  align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;</td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;</td>
				<td class="bwborder"><a href="rws_dpr_work_duration_excel.jsp" target="_new">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

		</table>
	</caption>
<tr align=center  align=center>
		<td class=gridhdbg  rowspan = 2>Sl.No</td>
		<td class=gridhdbg  rowspan = 2>District</td>
        <td class=gridhdbg  rowspan = 2>No.of Works<br></br>(DPR)</td>
		<td colspan=4 class=gridhdbg  align="center">Between Admin. Sanction to DPR Completion</td>
		<td colspan=4 class=gridhdbg  align="center">Between DPR Completion Date to Grounding date</td>
		<td class=gridhdbg  rowspan = 2>DPR Not Completion</td>
		
				
	</tr>
	<tr>   
			<td class=gridhdbg  align="center"> Up to 3 Months</td>
			<td class=gridhdbg  align="center">3 Months to 6 Months </td>
			<td  class=gridhdbg  align="center">6 Months to 1 Year</td>
			<td class=gridhdbg  align="center"> >1 Year</td>
			<td class=gridhdbg  align="center"> Up to 3 Months</td>
			<td class=gridhdbg  align="center">3 Months to 6 Months </td>
			<td  class=gridhdbg  align="center">6 Months to 1 Year</td>
			<td class=gridhdbg  align="center"> >1 Year</td>
			  		
			
</tr>
 <tr>
<td class=gridhdbg  align="center">1</td>
<td class=gridhdbg  align="center">2</td>
<td class=gridhdbg  align="center">3</td>
<td class=gridhdbg  align="center">4</td>
<td class=gridhdbg  align="center">5</td>
<td class=gridhdbg  align="center">6</td>
<td class=gridhdbg  align="center">7</td>
<td class=gridhdbg  align="center">8</td>
<td class=gridhdbg  align="center">9</td>
<td class=gridhdbg  align="center">10</td>
<td class=gridhdbg  align="center">11</td>
<td class=gridhdbg  align="center">12</td>

		
	</tr>
    <%

try
	{
        

        //String qry2="SELECT substr(a.work_id,5,2),count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,RWS_NOTGROUNDWORKS_STATUS_TBL b where a.work_id=b.work_id and  a.TYPE_OF_ASSET  in("+scheme+") and   work_cancel_dt is null  and substr(a.work_id,1,2) in ("+programe+") and b.dprstatus is not null and  a.work_id not in(select work_id from    RWS_NOTGROUNDWORKS_STATUS_TBL where   (to_date(DPRCOMPDATE) < '01-Apr-"+cYear+"')) group by substr(a.work_id,5,2)";
        String qry2="SELECT substr(a.work_id,5,2),count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,RWS_NOTGROUNDWORKS_STATUS_TBL b where a.work_id=b.work_id and  a.TYPE_OF_ASSET  in("+scheme+") and   work_cancel_dt is null  and substr(a.work_id,1,2) in ("+programe+") and b.dprstatus is not null group by substr(a.work_id,5,2)";
		Hashtable h2=new Hashtable();
	    pst2=conn.createStatement();
	    rs2=pst2.executeQuery(qry2);
       System.out.println("qry2 "+qry2);
	       while(rs2.next())
	       { 
	         h2.put(rs2.getString(1),rs2.getString(2));
           
             ////System.out.println("................."+h2.put(rs2.getString(1),rs2.getString(2)));
	       }	
	       
	       
	       
	       
	       String query3="select  d.dcode,sum(case when ((DPRCOMPDATE-admin_date)<90) then 1 else 0 end),sum(case when ((DPRCOMPDATE-admin_date)>=90 and (DPRCOMPDATE-admin_date)<180) then 1 else 0 end)  ,sum(case when ((DPRCOMPDATE-admin_date)>=180 and (DPRCOMPDATE-admin_date)<=365) then 1 else 0 end),sum(case when ((DPRCOMPDATE-admin_date)>365) then 1 else 0 end)   from rws_work_admn_tbl b,RWS_NOTGROUNDWORKS_STATUS_TBL a ,rws_district_tbl  d where   a.dprstatus is not null  and DPRCOMPDATE is not null and b.TYPE_OF_ASSET  in("+scheme+") and  substr(b.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) group by d.dcode ";

	       Statement stmt2=conn.createStatement();
	       
	       System.out.println("query3 "+query3);
	       rs2=stmt2.executeQuery(query3);
	 	  
		  	Hashtable admnTectHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		admnTectHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4) +"@"+rs2.getString(5));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
			
			
			//completion
			stmt2=conn.createStatement();
			
			 String query4="select  d.dcode,sum(case when ((GROUNDING_DATE-DPRCOMPDATE)<90) then 1 else 0 end),sum(case when ((GROUNDING_DATE-DPRCOMPDATE)>=90 and (GROUNDING_DATE-DPRCOMPDATE)<180) then 1 else 0 end)  ,sum(case when ((GROUNDING_DATE-DPRCOMPDATE)>=180 and (GROUNDING_DATE-DPRCOMPDATE)<=365) then 1 else 0 end),sum(case when ((GROUNDING_DATE-DPRCOMPDATE)>365) then 1 else 0 end)   from rws_work_admn_tbl b,RWS_NOTGROUNDWORKS_STATUS_TBL a ,rws_work_commencement_tbl c ,rws_district_tbl  d where a.dprstatus is not null and DPRCOMPDATE is not null and  c.work_id=b.work_id and b.TYPE_OF_ASSET  in("+scheme+") and   substr(b.work_id,1,2) in ("+programe+") and   work_cancel_dt is null and a.work_id=b.work_id and d.dcode=substr(b.work_id,5,2) group by d.dcode ";
			 System.out.println("query4 "+query4);
		        stmt2=conn.createStatement();
		       
		       rs2=stmt2.executeQuery(query4);
		 	  
			  	Hashtable complHash=new Hashtable();
			  	while(rs2.next()){
			  		  	
			  		complHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4) +"@"+rs2.getString(5));
			  	}
			  
			  
			  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
				
				
							
				
				//DPR Not Comleted
				
				
				//String qry2="SELECT substr(a.work_id,5,2),count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,RWS_NOTGROUNDWORKS_STATUS_TBL b where a.work_id=b.work_id and  a.TYPE_OF_ASSET  in("+scheme+") and   work_cancel_dt is null  and substr(a.work_id,1,2) in ("+programe+") and b.dprstatus is not null and  a.work_id not in(select work_id from    RWS_NOTGROUNDWORKS_STATUS_TBL where   (to_date(DPRCOMPDATE) < '01-Apr-"+cYear+"')) group by substr(a.work_id,5,2)";
        String dprNotCompleted="SELECT substr(a.work_id,5,2),count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a ,RWS_NOTGROUNDWORKS_STATUS_TBL b where a.work_id=b.work_id and  a.TYPE_OF_ASSET  in("+scheme+") and   work_cancel_dt is null  and substr(a.work_id,1,2) in ("+programe+") and b.dprstatus is not null and DPRCOMPDATE is null group by substr(a.work_id,5,2)";
		Hashtable dprNotHash=new Hashtable();
		stmt2=conn.createStatement();
	    rs2=stmt2.executeQuery(dprNotCompleted);
       System.out.println("dprNotCompleted "+dprNotCompleted);
	       while(rs2.next())
	       { 
	    	   dprNotHash.put(rs2.getString(1),rs2.getString(2));
           
             ////System.out.println("................."+h2.put(rs2.getString(1),rs2.getString(2)));
	       }
						  
			
			//programlink
			
			
			
			
		
		    

        String qry="select dcode,dname from rws_district_tbl  where dcode<>'16' order by dcode";
        Statement stmtv1= conn.createStatement();
		System.out.println("works......"+qry);
		 rs1 = stmtv1.executeQuery(qry);
		int styleCount=0;
		String style="";
		int rowCount=1;
		
		int gupto3Months=0,g3To6Months=0,g6To12Months=0,gabove1Year=0;
		int gupto3MonthsComp=0,g3To6MonthsComp=0,g6To12MonthsComp=0,gabove1YearComp=0;
		int gtotWorkCount=0;
		int gtotNotGroundWorks=0,gtotNotCompeletedWorks=0;
		while(rs1.next())
			{
			
			int upto3Months=0,_3To6Months=0,_6To12Months=0,above1Year=0;
			int upto3MonthsComp=0,_3To6MonthsComp=0,_6To12MonthsComp=0,above1YearComp=0;
			int workCount=0;
			int totNotGroundWorks=0,totNotCompeletedWorks=0;
                //h1values
               String key=rs1.getString(1);
                String h2values=(String)h2.get(rs1.getString(1));
	            if(h2values==null)
	            {
	            	h2values="0";
	            	}else{
	            		
	            		workCount=Integer.parseInt(h2values);
	            		gtotWorkCount+=workCount;
	            	}
	            
	            String str=(String)admnTectHash.get(key);
	            if(str!=null){
	            	
	            	String []aaa=str.split("@");
					String a1=aaa[0];
					if(a1!=null){
						upto3Months=Integer.parseInt(a1);
						gupto3Months+=upto3Months;
					}
					String a2=aaa[1];
					if(a2!=null){
						_3To6Months=Integer.parseInt(a2);
						g3To6Months+=_3To6Months;
					}
					
					String a3=aaa[2];
					if(a3!=null){
						_6To12Months=Integer.parseInt(a3);
						g6To12Months+=_6To12Months;
					}
					String a4=aaa[3];
					if(a4!=null){
						above1Year=Integer.parseInt(a4);
						gabove1Year+=above1Year;
					}
					
	            }
	            //Completion
	            
	            String str1=(String)complHash.get(key);
	            if(str1!=null){
	            	
	            	String []aaa=str1.split("@");
					String a1=aaa[0];
					if(a1!=null){
						upto3MonthsComp=Integer.parseInt(a1);
						gupto3MonthsComp+=upto3MonthsComp;
					}
					String a2=aaa[1];
					if(a2!=null){
						_3To6MonthsComp=Integer.parseInt(a2);
						g3To6MonthsComp+=_3To6MonthsComp;
					}
					
					String a3=aaa[2];
					if(a3!=null){
						_6To12MonthsComp=Integer.parseInt(a3);
						g6To12MonthsComp+=_6To12MonthsComp;
					}
					String a4=aaa[3];
					if(a4!=null){
						above1YearComp=Integer.parseInt(a4);
						gabove1YearComp+=above1YearComp;
					}
					
	            }
	            
	            
	            //Not Completed
	            
	            String val=(String)dprNotHash.get(key);
	            if(val!=null && !val.equals("")){
	            	
	            	totNotCompeletedWorks=Integer.parseInt(val);
	            }
	            
	            gtotNotCompeletedWorks+=totNotCompeletedWorks;
	            
	            
	            if(styleCount%2==0){
	 				 style="gridbg1";
	 			 }else{
	 				 style="gridbg2";
	 			 }
	 			 styleCount++;
	            
	            %>
	            <tr><td class=<%=style %>  style="text-align: center"><%=rowCount++ %></td>
	            <td class=<%=style %>  style="text-align: left"><%=rs1.getString(2) %></td>
	            <td class=<%=style %>  style="text-align: right"><%=h2values %></td>
	            <td class=<%=style %>  style="text-align: right"><%=upto3Months %> </td>
	            <td class=<%=style %>  style="text-align: right"><%=_3To6Months %></td>
	            <td class=<%=style %>  style="text-align: right"><%= _6To12Months %></td>
	            <td class=<%=style %>  style="text-align: right"><%=above1Year %></td>
	            <td class=<%=style %>  style="text-align: right"><%=upto3MonthsComp %></td>
	            <td class=<%=style %>  style="text-align: right"><%=_3To6MonthsComp %></td>
	            <td class=<%=style %>  style="text-align: right"><%=_6To12MonthsComp %></td>
	            <td class=<%=style %>  style="text-align: right"><%=above1YearComp %></td>
	            <td class=<%=style %>  style="text-align: right"><%=totNotCompeletedWorks %></td>
	            
	            
	            
	            </tr>
	            <% 
               
  }//while

	  %>
	  <tr><td class=gridhdbg  colspan="2" style="text-align: right">Total</td>
<td class=gridhdbg  style="text-align: right" style="text-align: right"><%=gtotWorkCount %></td>
<td class=gridhdbg  style="text-align: right"><%=gupto3Months %></td>
<td class=gridhdbg  style="text-align: right"><%=g3To6Months %></td>
<td class=gridhdbg  style="text-align: right"><%=g6To12Months %></td>
<td class=gridhdbg  style="text-align: right"><%=gabove1Year %></td>
<td class=gridhdbg  style="text-align: right"><%=gupto3MonthsComp %></td>
<td class=gridhdbg  style="text-align: right"><%=g3To6MonthsComp %></td>
<td class=gridhdbg  style="text-align: right"><%=g6To12MonthsComp %></td>
<td class=gridhdbg  style="text-align: right"><%=gabove1YearComp %></td>
<td class=gridhdbg  style="text-align: right"><%=gtotNotCompeletedWorks %></td>
	  <% 

}
catch(Exception e)
{
		e.printStackTrace();
}
%>

</table>

</form>
</BODY>


<%@ include file="/commons/rws_footer.jsp"%>

