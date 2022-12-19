<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "WorkPendingStatus_Inception.xls");
	String rDistrict = (String)session.getAttribute("rDistrict");
	
	String  dname = (String)session.getAttribute("pname");
	String  programe = (String)session.getAttribute("programe");
    String scheme= (String)session.getAttribute("scheme");
    
     
      ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null;
    Statement pst1 = null,pst2=null,pst3=null,pst4 = null,pst5=null,pst6 = null,pst7=null,pst8 = null,pst9=null,pst10 = null,pst11=null,pst12 = null,pst13 = null,pst14=null,pst15=null;


    //int p=Integer.parseInt(pyear);
%><BODY>
<form name=f1 method="post">
	<p align="center">
	<font face=verdana size=2><b>Status of Work Progress Report </b></font><BR>
<font color="black" face=verdana size=2>For</font>&nbsp;
<font color="black" face=verdana size=2><%=dname%> Works</font>&nbsp; </p>


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Program</td>
        <td class=btext rowspan = 2>NO.of Works</td>
		<td colspan=3 class=btext align="center">Between Admin. Sanction & Tech. Sanction</td>
		<td colspan=3 class=btext align="center">Between Tech. Sanction & Grounding Date</td>
        <td colspan=3 class=btext align="center">Between Grounding Date & Completion date</td>
		<td colspan=5 class=btext align="center">Admin. Sanction & Completion Date</td>		
	</tr>
	<tr>   
			<td class=btext align="center"> >1 Year</td>
			<td  class=btext align="center">6 Months to 1 Year</td>
			<td class=btext align="center">3 Months to 6 Months </td>
            <td class=btext align="center"> >1 Year</td>
			<td  class=btext align="center">6 Months to 1 Year</td>
			<td class=btext align="center">3 Months to 6 Months </td>
			
            <td class=btext align="center"> >1 Year</td>
			<td  class=btext align="center">6 Months to 1 Year</td>
			<td class=btext align="center">3 Months to 6 Months </td>
			
            <td class=btext align="center"> 1 Year to 2 Years</td>
            <td  class=btext align="center"> 2 Years to 3 Years</td>
			<td  class=btext align="center"> 3 Years to 4 Years</td>
			<td class=btext align="center"> 4 Years to 5 Years</td>
			<td class=btext align="center"> > 5 Years</td>
			
			
</tr>
 <tr>
<td class=btext align="center">1</td>
<td class=btext align="center">2</td>
<td class=btext align="center">3</td>
<td class=btext align="center">4</td>
<td class=btext align="center">5</td>
<td class=btext align="center">6</td>
<td class=btext align="center">7</td>
<td class=btext align="center">8</td>
<td class=btext align="center">9</td>
<td class=btext align="center">10</td>
<td class=btext align="center">11</td>
<td class=btext align="center">12</td>
<td class=btext align="center">13</td>
<td class=btext align="center">14</td>
<td class=btext align="center">15</td>
<td class=btext align="center">16</td>
<td class=btext align="center">17</td>
		
	</tr>
	<%

try
	{
        String qry="",qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="",qry8="",qry9="",qry10="",qry11="",qry12="",qry13="",qry14="",qry15="";
        String h1values="",h2values="",h3values="",h4values="",h5values="",h6values="",h7values="",h8values="",h9values="",h10values="",h11values="",h12values="",h13values="",h14values="",h15values="";
        String row1[],row2[],row3[],row4[],row5[],row6[],row7[],row8[],row9[],row10[],row11[],row12[],row13[],row14[],row15[];
        String v1="",v2="",v3="",v4="",v5="",v6="",v7="",v8="",v9="",v10="",v11="",v12="",v13="",v14="",v15="";
        int slno=0;
        int v1sum=0,v2sum=0,v3sum=0,v4sum=0,v5sum=0,v6sum=0,v7sum=0,v8sum=0,v9sum=0,v10sum=0,v11sum=0,v12sum=0,v13sum=0,v14sum=0,v15sum=0;
        String mycolor="";

     



	         qry15="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null   and sysdate - grounding_date>5*365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h15=new Hashtable();
		    pst15=conn.createStatement();
		    rs15=pst15.executeQuery(qry15);
	       // System.out.println("qry15 "+qry15);
		       while(rs15.next())
		       {
		         h15.put(rs15.getString(1),rs15.getString(2));
	           //  //System.out.println("................."+h13.put(rs13.getString(1),rs13.getString(2)));
		       }



           qry14="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET  in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null  and sysdate - grounding_date<5*365  and sysdate - grounding_date>4*365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";


			Hashtable h14=new Hashtable();
		    pst14=conn.createStatement();
		    rs14=pst14.executeQuery(qry14);
	       // System.out.println("qry14 "+qry14);
		       while(rs14.next())
		       {
		         h14.put(rs14.getString(1),rs14.getString(2));
	           //  //System.out.println("................."+h13.put(rs13.getString(1),rs13.getString(2)));
		       }



	        qry13="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET  in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null   and sysdate - grounding_date<4*365  and sysdate - grounding_date>3*365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h13=new Hashtable();
		    pst13=conn.createStatement();
		    rs13=pst13.executeQuery(qry13);
	       //System.out.println("qry13 "+qry13);
		       while(rs13.next())
		       {
		         h13.put(rs13.getString(1),rs13.getString(2));
	           //  //System.out.println("................."+h13.put(rs13.getString(1),rs13.getString(2)));
		       }
	       qry12=" SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET  in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null  and sysdate - grounding_date<3*365  and sysdate - grounding_date>2*365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h12=new Hashtable();
		    pst12=conn.createStatement();
		    rs12=pst12.executeQuery(qry12);
	      // System.out.println("qry12 "+qry12);
		       while(rs12.next())
		       {
		         h12.put(rs12.getString(1),rs12.getString(2));
	             ////System.out.println("................."+h12.put(rs12.getString(1),rs12.getString(2)));
		       }
	       qry11=" SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET  in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null   and sysdate - grounding_date<2*365  and sysdate - grounding_date>365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h11=new Hashtable();
		    pst11=conn.createStatement();
		    rs11=pst11.executeQuery(qry11);
	     //  System.out.println("qry11 "+qry11);
		       while(rs11.next())
		       {
		         h11.put(rs11.getString(1),rs11.getString(2));
	             ////System.out.println("................."+h11.put(rs11.getString(1),rs11.getString(2)));
		       }

	        qry10="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where a.TYPE_OF_ASSET in("+scheme+") and a.work_id=c.work_id and work_cancel_dt is null   and sysdate - grounding_date>365 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h10=new Hashtable();
		    pst10=conn.createStatement();
		    rs10=pst10.executeQuery(qry10);
	        //System.out.println("qry10 "+qry10);
		       while(rs10.next())
		       {
		         h10.put(rs10.getString(1),rs10.getString(2));
	             ////System.out.println("................."+h10.put(rs10.getString(1),rs10.getString(2)));
		       }
	        qry9="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where  a.TYPE_OF_ASSET  in("+scheme+") and  a.work_id=c.work_id and work_cancel_dt is null   and sysdate - grounding_date<365 and sysdate - grounding_date>180 and substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

			Hashtable h9=new Hashtable();
		    pst9=conn.createStatement();
		    rs9=pst9.executeQuery(qry9);
	       // System.out.println("qry9 "+qry9);
		       while(rs9.next())
		       {
		         h9.put(rs9.getString(1),rs9.getString(2));
	             ////System.out.println("................."+h9.put(rs9.getString(1),rs9.getString(2)));
		       }
	        qry8="SELECT distinct substr(a.work_id,5,2),count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c where  a.TYPE_OF_ASSET in("+scheme+") and  a.work_id=c.work_id  and work_cancel_dt is null   and sysdate - grounding_date<180 and sysdate - grounding_date>90 and substr(a.work_id,1,2) in ("+programe+")  group by substr(a.work_id,5,2)";

			Hashtable h8=new Hashtable();
		    pst8=conn.createStatement();
		    rs8=pst8.executeQuery(qry8);
	        //System.out.println("qry8 "+qry8);
		       while(rs8.next())
		       {
		         h8.put(rs8.getString(1),rs8.getString(2));
	             ////System.out.println("................."+h8.put(rs8.getString(1),rs8.getString(2)));
		       }
	        qry7="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_new_est_tbl b where  a.TYPE_OF_ASSET in("+scheme+") and  a.work_id=b.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_commencement_tbl ) and sysdate - ts_date>365 and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

			Hashtable h7=new Hashtable();
		    pst7=conn.createStatement();
		    rs7=pst7.executeQuery(qry7);
	      //  System.out.println("qry7 "+qry7);
		       while(rs7.next())
		       {
		         h7.put(rs7.getString(1),rs7.getString(2));
	             ////System.out.println("................."+h7.put(rs7.getString(1),rs7.getString(2)));
		       }
	        qry6="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_new_est_tbl b where  a.TYPE_OF_ASSET in("+scheme+") and  a.work_id=b.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_commencement_tbl ) and sysdate - ts_date<365 and sysdate - ts_date>180 and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

			Hashtable h6=new Hashtable();
		    pst6=conn.createStatement();
		    rs6=pst6.executeQuery(qry6);
	        //System.out.println("qry6 "+qry6);
		       while(rs6.next())
		       {
		         h6.put(rs6.getString(1),rs6.getString(2));
	             ////System.out.println("................."+h6.put(rs6.getString(1),rs6.getString(2)));
		       }

        qry5="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a,rws_new_est_tbl b where  a.TYPE_OF_ASSET in("+scheme+") and  a.work_id=b.work_id and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_commencement_tbl ) and sysdate - ts_date<180 and sysdate - ts_date>90 and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

		Hashtable h5=new Hashtable();
	    pst5=conn.createStatement();
	    rs5=pst5.executeQuery(qry5);
       // System.out.println("qry5 "+qry5);
	       while(rs5.next())
	       {
	         h5.put(rs5.getString(1),rs5.getString(2));
             ////System.out.println("................."+h5.put(rs5.getString(1),rs5.getString(2)));
	       }


        qry4="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a  where  a.TYPE_OF_ASSET  in("+scheme+") and  work_cancel_dt is null   and  a.work_id not in(select work_id from rws_new_est_tbl) and sysdate - admin_date>365 and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

		Hashtable h4=new Hashtable();
	    pst4=conn.createStatement();
	    rs4=pst4.executeQuery(qry4);
        //System.out.println("qry4 "+qry4);
	       while(rs4.next())
	       {
	         h4.put(rs4.getString(1),rs4.getString(2));
             ////System.out.println("................."+h4.put(rs4.getString(1),rs4.getString(2)));
	       }

        qry3="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a  where   a.TYPE_OF_ASSET  in("+scheme+") and  work_cancel_dt is null   and  a.work_id not in(select work_id from rws_new_est_tbl) and sysdate - admin_date<365 and sysdate - admin_date>180  and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

		Hashtable h3=new Hashtable();
	    pst3=conn.createStatement();
	    rs3=pst3.executeQuery(qry3);
       // System.out.println("qry3 "+qry3);
	       while(rs3.next())
	       {
	         h3.put(rs3.getString(1),rs3.getString(2));
             ////System.out.println("................."+h3.put(rs3.getString(1),rs3.getString(2)));
	       }	
        

        qry1="SELECT distinct substr(a.work_id,5,2),count(a.work_id) FROM RWS_WORK_ADMN_TBL a  where  a.TYPE_OF_ASSET  in("+scheme+") and  work_cancel_dt is null   and  a.work_id not in(select work_id from rws_new_est_tbl) and sysdate - admin_date<180 and sysdate - admin_date>90  and  substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";

		Hashtable h1=new Hashtable();
	    pst1=conn.createStatement();
	    rs1=pst1.executeQuery(qry1);
      //  System.out.println("qry1 "+qry1);
	       while(rs1.next())
	       {
	         h1.put(rs1.getString(1),rs1.getString(2));
             ////System.out.println("................."+h1.put(rs1.getString(1),rs1.getString(2)));
	       }	

        qry2="SELECT substr(a.work_id,5,2),count(distinct a.work_id) FROM RWS_WORK_ADMN_TBL a where  a.TYPE_OF_ASSET  in("+scheme+") and  work_cancel_dt is null  and substr(a.work_id,1,2) in ("+programe+") group by substr(a.work_id,5,2)";
		Hashtable h2=new Hashtable();
	    pst2=conn.createStatement();
	    rs2=pst2.executeQuery(qry2);
      //  System.out.println("qry2 "+qry2);
	       while(rs2.next())
	       { 
	         h2.put(rs2.getString(1),rs2.getString(2));
           
             ////System.out.println("................."+h2.put(rs2.getString(1),rs2.getString(2)));
	       }	

        qry="select dcode,dname from rws_district_tbl  where dcode<>'16' order by dname";
        Statement stmtv1= conn.createStatement();
		//System.out.println("works......"+qry);
		ResultSet totalrs = stmtv1.executeQuery(qry);
		while(totalrs.next())
			{   
                //h1values
                h1values=(String)h1.get(totalrs.getString(1));
	            if(h1values!=null)
	            {
	             row1=h1values.split("@");
	             v1=row1[0];
				 //v2=row1[1];
				 v1sum+=Integer.parseInt(v1);
                
	             }
	           else
				{	
		         v1="0";
				 //v2="-";
                
				}
               //end
               //h2values
                h2values=(String)h2.get(totalrs.getString(1));
	            if(h2values!=null)
	            {
	             row2=h2values.split("@");
	             v2=row2[0];
				 //v2=row1[1];
				 v2sum+=Integer.parseInt(v2);
 				
	             }
	           else
				{	
		         v2="0";
				 //v2="-";
 				
				}
               //end
               //h3values
                h3values=(String)h3.get(totalrs.getString(1));
	            if(h3values!=null)
	            {
	             row3=h3values.split("@");
	             v3=row3[0];
				 //v2=row1[1];
				 v3sum+=Integer.parseInt(v3);
 				
	             }
	           else
				{	
		         v3="0";
				 //v2="-";
 				
				}
               //end
               //h4values
                h4values=(String)h4.get(totalrs.getString(1));
	            if(h4values!=null)
	            {
	             row4=h4values.split("@");
	             v4=row4[0];
				 //v2=row1[1];
				 v4sum+=Integer.parseInt(v4);
 				
	             }
	           else
				{	
		         v4="0";
				 //v2="-";
 				
				}
               //end
               //h5values
                h5values=(String)h5.get(totalrs.getString(1));
	            if(h5values!=null)
	            {
	             row5=h5values.split("@");
	             v5=row5[0];
				 //v2=row1[1];
				 v5sum+=Integer.parseInt(v5);
 				
	             }
	           else
				{	
		         v5="0";
				 //v2="-";
 				
				}
               //end
//h6values
                h6values=(String)h6.get(totalrs.getString(1));
	            if(h6values!=null)
	            {
	             row6=h6values.split("@");
	             v6=row6[0];
				 //v2=row1[1];
				 v6sum+=Integer.parseInt(v6);
 				
	             }
	           else
				{	
		         v6="0";
				 //v2="-";
 				
				}
               //end
//h7values
                h7values=(String)h7.get(totalrs.getString(1));
	            if(h7values!=null)
	            {
	             row7=h7values.split("@");
	             v7=row7[0];
				 //v2=row1[1];
				 v7sum+=Integer.parseInt(v7);
 				
	             }
	           else
				{	
		         v7="0";
				 //v2="-";
 				
				}
               //end
//h8values
                h8values=(String)h8.get(totalrs.getString(1));
	            if(h8values!=null)
	            {
	             row8=h8values.split("@");
	             v8=row8[0];
				 //v2=row1[1];
				 v8sum+=Integer.parseInt(v8);
 				
	             }
	           else
				{	
		         v8="0";
				 //v2="-";
 				
				}
               //end
//h9values
                h9values=(String)h9.get(totalrs.getString(1));
	            if(h9values!=null)
	            {
	             row9=h9values.split("@");
	             v9=row9[0];
				 //v2=row1[1];
				 v9sum+=Integer.parseInt(v9);
 				
	             }
	           else
				{	
		         v9="0";
				 //v2="-";
 				
				}
               //end
//h10values
                h10values=(String)h10.get(totalrs.getString(1));
	            if(h10values!=null)
	            {
	             row10=h10values.split("@");
	             v10=row10[0];
				 //v2=row1[1];
				 v10sum+=Integer.parseInt(v10);
 				
	             }
	           else
				{	
		         v10="0";
				 //v2="-";
 				
				}
               //end
//h11values
                h11values=(String)h11.get(totalrs.getString(1));
	            if(h11values!=null)
	            {
	             row11=h11values.split("@");
	             v11=row11[0];
				 //v2=row1[1];
				 v11sum+=Integer.parseInt(v11);
 				
	             }
	           else
				{	
		         v11="0";
				 //v2="-";
 				
				}
               //end
//h12values
                h12values=(String)h12.get(totalrs.getString(1));
	            if(h12values!=null)
	            {
	             row12=h12values.split("@");
	             v12=row12[0];
				 //v2=row1[1];
				 v12sum+=Integer.parseInt(v12);
 				
	             }
	           else
				{	
		         v12="0";
				 //v2="-";
 				
				}
               //end
//h13values
                h13values=(String)h13.get(totalrs.getString(1));
	            if(h13values!=null)
	            {
	             row13=h13values.split("@");
	             v13=row13[0];
				 //v2=row1[1];
				 v13sum+=Integer.parseInt(v13);
 				
	             }
	           else
				{	
		         v13="0";
				 //v2="-";
 				
				}
               //end



//h14values
                h14values=(String)h14.get(totalrs.getString(1));
	            if(h14values!=null)
	            {
	             row14=h14values.split("@");
	             v14=row14[0];
				 //v2=row1[1];
				 v14sum+=Integer.parseInt(v14);
 				
	             }
	           else
				{	
		         v14="0";
				 //v2="-";
 				
				}
               //end
//h15values
                h15values=(String)h15.get(totalrs.getString(1));
	            if(h15values!=null)
	            {
	             row15=h15values.split("@");
	             v15=row15[0];
				 //v2=row1[1];
				 v15sum+=Integer.parseInt(v15);
 				
	             }
	           else
				{	
		         v15="0";
				 //v2="-";
 				
				}
               //end
  mycolor="red";
  if(v1sum>0||v3sum>0||v4sum>0||v5sum>0||v6sum>0||v7sum>0||v8sum>0||v9sum>0||v10sum>0||v11sum>0||v12sum>0||v13sum>0||v14sum>0||v15sum>0)
{
	
  			%>
			<tr>
			<td class=rptValue><%=++slno%></td>
		    <td class=rptValue><%=totalrs.getString(2)%></td>
            <td class=rptValue><%=v2%></td>
            <%if(!v1.equals("0")){ %>
		    <td class=rptValue><font color="<%=mycolor%>"><%=v1%></font></td>
            <%}else{ %>
            <td class=rptValue><%=v1%></td>
            <%}if(!v3.equals("0")){%>
		    <td class=rptValue><font color="<%=mycolor%>"><%=v3%></td>
            <%}else{ %>
            <td class=rptValue><%=v3%></td>
            <%}if(!v4.equals("0")){%>
		    <td class=rptValue><font color="<%=mycolor%>"><%=v4%></td>
            <%}else{ %>
            <td class=rptValue><%=v4%></td>
            <%}if(!v5.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v5%></td>
            <%}else{ %>
            <td class=rptValue><%=v5%></td>
            <%}if(!v6.equals("0")){%>
			<td class=rptValue><font color="<%=mycolor%>"><%=v6%></td>
            <%}else{ %>
            <td class=rptValue><%=v6%></td>
            <%}if(!v7.equals("0")){%>
		    <td class=rptValue><font color="<%=mycolor%>"><%=v7%></td>
            <%}else{ %>
            <td class=rptValue><%=v7%></td>
            <%}if(!v8.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v8%></td>
            <%}else{ %>
            <td class=rptValue><%=v8%></td>
            <%}if(!v9.equals("0")){%>
			<td class=rptValue><font color="<%=mycolor%>"><%=v9%></td>
            <%}else{ %>
            <td class=rptValue><%=v9%></td>
            <%}if(!v10.equals("0")){%>
		    <td class=rptValue><font color="<%=mycolor%>"><%=v10%></td>
            <%}else{ %>
            <td class=rptValue><%=v10%></td>
            <%}if(!v11.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v11%></font></td>
            <%}else{ %>
			<td class=rptValue><%=v11%></td>
			<%}if(!v12.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v12%></td>
			<%}else{ %>
			<td class=rptValue><%=v12%></td>
			<%}if(!v13.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v13%></td>
			<%}else{ %>
			<td class=rptValue><%=v13%></td>
			<%}if(!v14.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v14%></td>
			<%}else{ %>
			<td class=rptValue><%=v14%></td>
			<%}if(!v15.equals("0")){%>
            <td class=rptValue><font color="<%=mycolor%>"><%=v15%></td>
			<%}else{ %>
			<td class=rptValue><%=v15%></td>
			<%} %>

                  
			 </tr>
    <%
      
  }else{%> <script>
          alert("No Records...");
          document.f1.action="./rws_works_exception_frm.jsp";
		  document.f1.submit();
          </script>
       <%} 
  }//while

	   %>
          <tr>
			<td class=btext colspan="2">Totals</td>
		    <td class=btext><%=v2sum%></td>
            <td class=btext><%=v1sum%></td>
            <td class=btext><%=v3sum%></td>
            <td class=btext><%=v4sum%></td>
            <td class=btext><%=v5sum%></td>
			<td class=btext><%=v6sum%></td>
            <td class=btext><%=v7sum%></td>
            <td class=btext><%=v8sum%></td>
            <td class=btext><%=v9sum%></td>
            <td class=btext><%=v10sum%></td>
             <td class=btext><%=v11sum%></td>
            <td class=btext><%=v12sum%></td>
			<td class=btext><%=v13sum%></td>
            <td class=btext><%=v14sum%></td>
            <td class=btext><%=v15sum%></td>
            
          </tr>

<%

}
catch(Exception e)
{
		e.printStackTrace();
}
%>

</table>
<p align="left">
<font face="verdana" size="2" color="red">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note********:Column 3 *** Ongoing Works with No Completion Date</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Column 4,5,6 *** Works Adminstratively Sanction but Not Technically Sanctioned</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Column 7,8,9 *** Works Adminstratively and Technically Sanctioned but Not Grounded</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Column 10,11,12 *** Works Adminstratively Sanction and Grounded but Not Completed</font></p>
<p align="left">
<font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Column 13,14,15 *** Works Adminstratively Sanction but Not Completed</font></p>

</form>
</BODY>


<%@ include file="/commons/rws_footer.jsp"%>
	