<%@	page import="java.math.BigDecimal" %>
<%
	query="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl e where w.work_id=e.work_id and w.work_id='"+wCode+"' ";
	//distinct is removed from the query

	try{
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	Statement stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	  
	 rs = stmt.executeQuery(query);
	
	 rs.setFetchSize(500);
	 rs.last();
	 Count = rs.getRow();
	  
 	 rs.beforeFirst();
 	double expprev=0;
	double valup=0;
	double toto=0;
 	 
  %>
  <table >

 	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>VIII.Work Expenditure Details</font></td>	
	</tr>

  
	
	<%	 int no=0;
		 double totalmain=0;
		int sno1=0;
		int sno2=0;
		int sno3=0;
		int sno4=0;
		int sno=0;

	if(Count!=0)
		{
	 	 while(rs.next())
		 {
        	int habs=1,habs1=0,serial=0,ha=1;
        	
			String qury="select distinct e.programme_code,p.programme_name from rws_work_expenditure_tbl e,rws_programme_tbl p where e.programme_code=p.programme_code and e.work_id='"+rs.getString(2)+"'";

		    r=s.executeQuery(qury);
			r.setFetchSize(500);
		    r.last();
		    Cnt = r.getRow();
		    r.beforeFirst();
			
		    if(Cnt!=0)
			{
			  while(r.next())
	  			{
				float total=0;
%>
  		<tr bgcolor="#ffffff">
			<td class="btext">1.ProgrammeName</td>
			<td class="rptValue"><%=++sno%>.&nbsp;<%=r.getString(2)%></td>
  		</tr>
<%
		String qury2="select distinct nvl(prev.expenditure_upto_the_pre_year,'0') from rws_work_expenditure_tbl e,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL prev where e.work_id=prev.work_id(+) and e.programme_code=prev.programme_code and e.work_id='"+rs.getString(2)+"' ";//and e.programme_code='"+r.getString(1)+"'
		
	    rs2 = st2.executeQuery(qury2);
	   // System.out.println("prev Query s"+qury2);
	    if(rs2.isBeforeFirst())
	    {	    
	    if(rs2.next())
		{
			totalmain = rs2.getDouble(1);			
%>
	<tr bgcolor="#ffffff">
		<td class="btext">2.Expenditure Upto<br>The Prev Year (Rs In Lakhs)</td>
		<td class="rptValue" align="left"><%=rs2.getDouble(1)%></td>
	</tr>
<%
		}
		}
		else
		{
%>
	<tr bgcolor="#ffffff">
		<td class="btext">2.Expenditure Upto<br>The Prev Year (Rs In Lakhs)</td>
		<td class="rptValue">0.0</td>
	</tr>
      	
<%		}
%>
<table >	  	
		
		<tr  bgcolor="#ffffff">
			<td class="btext">S.No</td>
		    <td class="btext">Year</td>
			<td class="btext">Month</td>
			<td class="btext">Upto Previous<br>Month</td>
			<td class="btext">During The<br> Month</td>
			<td class="btext">Value of work<br>done but not paid</td>
			<td class="btext">Total  Expenditure<br>(Rs In Lakhs)</td>
		</tr>

<%		int counttotal = 0;
		String []month = {"January","February","March","April","May","June","July","August","September","October","November","December"};
		int returnval=-1;
		double finalTotal=0;
		//System.out.println("rs.getString(2) "+rs.getString(2)+"r.getString(1) "+r.getString(1));
		String queryyear="select distinct year from rws_work_expenditure_tbl where work_id='"+rs.getString(2)+"' order by year ";// and programme_code='"+r.getString(1)+"'
		//System.out.println("query year:"+queryyear);
		rss=stmt5.executeQuery(queryyear);
		while(rss.next())
		{
			double yearmonprev=0.0,yearmondur=0.0;
			returnval++;
		String qurys = "select distinct count(*) from rws_work_expenditure_tbl e where  e.work_id='"+rs.getString(2)+"'  and year='"+rss.getString(1)+"' ";//and e.programme_code='"+r.getString(1)+"'
		//System.out.println("expcount(*) "+qurys);
		ResultSet countrs = st1.executeQuery(qurys);

		if(countrs.next())
		{
			counttotal=countrs.getInt(1);
		}
		counttotal+=1;
	//	System.out.println("in side while");		
		String qury1="select distinct nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0'),e.month,substr(year,1,4)  from rws_work_expenditure_tbl e  where  e.work_id='"+rs.getString(2)+"' and e.programme_code='"+r.getString(1)+"' and e.year='"+rss.getString(1)+"' order by nvl(e.Year,'-'),nvl(decode (e.Month,'01','January','02','February','03','March','04','April','05','May','06 ','June','07','July','08','August','09','September','10','October','11','Novemb e r','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl (e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0') ";
	//	System.out.println("*****************************::"+qury1);
%>
<%
		int []mon=new int[counttotal];
		String []year=new String[counttotal];
		float []expd=new float[counttotal];
		float []valupto=new float[counttotal];
		float []workd=new float[counttotal];
		int []mon1=new int[counttotal];
		int []mon2=new int[counttotal];
		int []mon3=new int[counttotal];
		int []yearStart=new int[counttotal];
		int []sort1=new int[counttotal-1];
		int loopval[]=new int[counttotal];
		
		//int a=0,
		int b=0,jj=0;
		int a11=0,b11=0,jj11=0;
		int i=1;
		float total1=0;
		int val=0;
		
		rs1 = st1.executeQuery(qury1);
		rs1.last();
        Counts = rs1.getRow();
		int  Counts1=Counts;
        rs1.beforeFirst();
		int loop = 0;
		%>
		
		<% 		
		
		while(rs1.next())
		{			
	
		//Storing the values in an arrays for dispalying the output months field financial year wise 	
		//totalmain=totalmain+rs1.getDouble(4);
		//System.out.println("TOTOAL **** "+totalmain );			
		
		year[val]=rs1.getString(1);
 		expd[val]=rs1.getFloat(3);
		valupto[val]=rs1.getFloat(4);
		workd[val]=rs1.getFloat(5);		
		mon[val]=rs1.getInt(6);
		sort1[val]=rs1.getInt(6);
	
		yearStart[val]=rs1.getInt(7);
		loop++;			
	
		val++;
		}
		
	
		int temp1=1;
		//test for year
		String []year12=new String[counttotal];
		String []year21=new String[counttotal];
		int []mon12=new int[counttotal];
		int []mon21=new int[counttotal];
		float []expd12=new float[counttotal];
		float []expd21=new float[counttotal];
		float []valupto12=new float[counttotal];
		float []valupto21=new float[counttotal];
		float []workd12=new float[counttotal];
		float []workd21=new float[counttotal];
		
		int []mon33=new int[counttotal];
		String []year33=new String[counttotal];
		float []expd33=new float[counttotal];
		float []valupto33=new float[counttotal];
		float []workd33=new float[counttotal];
					
		int []mon11=new int[counttotal];
		String []year1=new String[counttotal];
		float []expd1=new float[counttotal];
		float []valupto1=new float[counttotal];
		float []workd1=new float[counttotal];
		
		int yr2=0;
		int cnt=0;
		int in,in1,temp12=0;
		int ms=0;


		ms=mon.length-1;
		//code for year wise sorting of data by Vikas
		if(returnval>0)
		{
		%>
		<td colspan="7"></td>
		<%
		}
		int value=0,special=0;
		float totexp=0;
		//System.out.println("value of ms and mon.length-1 "+ms+" "+mon.length);
		
		for(int yr1=0;yr1<ms;yr1++)
		{
		value=ms;
			
			//System.out.println("Value of ms "+value+"  "+yr1);
			{
			if(yearStart[yr1+1]==yearStart[yr1] && yr2!=10)
			{
				
				value--;
				cnt++;
				
				mon11[yr1]=mon[yr1];
				year1[yr1]=year[yr1];
				expd1[yr1]=expd[yr1];
				valupto1[yr1]=valupto[yr1];
				workd1[yr1]=workd[yr1];
				
			}
			else if(yr2==0)
			{	
				
				value--;			 
				yr2=10;
				cnt++;
			
				mon11[yr1]=mon[yr1];
				year1[yr1]=year[yr1];
				expd1[yr1]=expd[yr1];
				valupto1[yr1]=valupto[yr1];
				workd1[yr1]=workd[yr1];
			
			}
			else if(yr2==10 && value!=0)
			{
				value--;
				special = 1;
			
				mon11[yr1]=mon[yr1];
				year1[yr1]=year[yr1];
				expd1[yr1]=expd[yr1];
				valupto1[yr1]=valupto[yr1];
				workd1[yr1]=workd[yr1];
			
		   	 }
		   }
		}
		
		/*for(int yr1=0;yr1<ms;yr1++)
		{
			//System.out.println(cnt +"year:=  "+year1[yr1]+"  "+mon11[yr1]+"  "+expd1[yr1]+"  "+valupto1[yr1]+"  "+workd1[yr1]);
		}*/
		
		//end of year wise code 
		
		int value1=1;
		int sortt=0;
		value1=ms+1;
		//sorting of year data accordingly in financial year wise 04 to 03
		for(jj11=0,a11=0,b11=0;jj11<ms;jj11++)
		{
			if(mon11[jj11]>=04 && mon11[jj11]<=12 )
			{
				value1--;
			
				year12[a11]=year1[jj11];
				mon12[a11]=mon11[jj11];
				expd12[a11]=expd1[jj11];
				valupto12[a11]=valupto1[jj11];
				workd12[a11]=workd1[jj11];
			
				a11++;;
			}
			else if(mon11[jj11]<04)
			{
				sortt=10;
				value1--;
			
				year21[b11]=year1[jj11];
				mon21[b11]=mon11[jj11];
				expd21[b11]=expd1[jj11];
				valupto21[b11]=valupto1[jj11];
				workd21[b11]=workd1[jj11];
			
				b11++;
			}
			
		}

		for(int a1=0;a1<a11-1;a1++)
		//bubble sorting a[] array elements obtained 
		{
			//int aval=a11-1;
			for(int a12=0;a12<a11-1-a1;a12++)
			{
			int valll=a11-1-a1;
			//System.out.println("mon12[a12+1] < mon12[a12]" +mon12[a12+1]+"   "+mon12[a12]);
			  if(mon12[a12+1] < mon12[a12])
			  { 
		    	  int tmp = mon12[a12];
		    	  String tmp1=year12[a12];
		    	  float tmp3=expd12[a12];
		    	  float tmp4=valupto12[a12];
		    	  float tmp5=workd12[a12];
		       	  		    	          
			      mon12[a12] = mon12[a12+1];
			      mon12[a12+1] = tmp;
			      
			      year12[a12]=year12[a12+1];
			      year12[a12+1]=tmp1;
			      
			       expd12[a12]=expd12[a12+1];
			       expd12[a12+1]=tmp3;
			       
			       valupto12[a12]=valupto12[a12+1];
			       valupto12[a12+1]=tmp4;
			       
			       workd12[a12]=workd12[a12+1];
			       workd12[a12+1]=tmp5;
			      
				}
			}
		}
		//bubble sorting a[] array elements obtained 
	/*	for(int a12=0;a12<=a11-1;a12++)
		{
			System.out.println("a after sorted  values"+year12[a12]+" "+mon12[a12]+" "+expd12[a12]+" "+valupto12[a12]+" "+workd12[a12]);
		
		}*/
				
		for(int a1=0;a1<b11-1;a1++)
		//bubble sorting b[] array elements obtained
		{
			for(int a12=0;a12<b11-1-a1;a12++)
			{
				 if(mon21[a12+1] < mon21[a12])
				 { 
			    	  int tmp = mon21[a12];
			    	  String tmp1=year21[a12];
			    	  float tmp3=expd21[a12];
			    	  float tmp4=valupto21[a12];
			    	  float tmp5=workd21[a12];
			       	  		    	          
				      mon21[a12] = mon21[a12+1];
				      mon21[a12+1] = tmp;
				      
				      year21[a12]=year21[a12+1];
				      year21[a12+1]=tmp1;
				      
				       expd21[a12]=expd21[a12+1];
				       expd21[a12+1]=tmp3;
				       
				       valupto21[a12]=valupto21[a12+1];
				       valupto21[a12+1]=tmp4;
				       
				       workd21[a12]=workd21[a12+1];
				       workd21[a12+1]=tmp5;
				 }
   			}
		}
	
		/*for(int a12=0;a12<=b11-1;a12++)
	 	 {
		  	//System.out.println("b after sorted  values"+year21[a12]+" "+mon21[a12]+" "+expd21[a12]+" "+valupto21[a12]+" "+workd21[a12]);
	 	 }*/ 
		
		
		int x11 = 0;
		int ms11 = 0;
		
		for(int p=0;p<mon12.length;p++)
		{
			if(mon12[p]!=0)
			{
				ms11++;
			
				year33[ms11]=year12[p];
				mon33[ms11]=mon12[p];//for combining the arrays a[] sorted ones
				expd33[ms11]=expd12[p];
				valupto33[ms11]=valupto12[p];
				workd33[ms11]=workd12[p];
			}
		}
		
		for(int p=0;p<mon21.length;p++)
		{
			if(mon21[p]!=0)
			{
				ms11++;
			
				year33[ms11]=year21[p];
				mon33[ms11]=mon21[p];//for combining the arrays b[] sorted ones
				expd33[ms11]=expd21[p];
				valupto33[ms11]=valupto21[p];
				workd33[ms11]=workd21[p];
			}
		}
		
		
		%>
		
		<%
		int ms1 = ms;
		int chk=0;
		int tst=0;
		int tst1=0;
		if(special==1)
		{
		 if(b11>0)
		 {
			for(int a12=0;a12<=b11-1;a12++)
			{
				++sno1;
				//System.out.println("First a12: "+a12+" b11 "+b11);
				if(chk>0)
				{
				tst=1;
%>
					<td colspan=4></td>
<%				chk=0;
				}
		 yearmonprev=expd21[a12];
		 yearmondur=valupto21[a12];
%>
	<tr>
	  	<td class="rptValue" nowrap><%=sno1%></td>
		<td class="rptValue" nowrap><%=year21[a12]%></td>
		<td class="rptValue"><%=month[mon21[a12]-1]%></td>
		<td class="rptValue"><%=expd21[a12]%></td>
		<td class="rptValue"><%=valupto21[a12]%></td>
	 	<td class="rptValue"><%=workd21[a12]%></td>
 
<%		if(b11==a12+1 && tst!=1)
		{
		 expprev=expd21[a12];
		 valup=valupto21[a12];
		
%>
		<%-- 	<td class="rptValue"><b><%=totalmain+expd21[a12]+valupto21[a12]%></b></td>--%>
		<td class="rptValue"></td>
		</tr>
<%		}
		else
		{
%>
		<td class="rptValue"></td>
<%
		}
		tst=0; 
		chk++;
	   	} 
		
	  }	
	  if(a11>0)
	  {
		for(int a12=0;a12<=a11-1;a12++)
		{
			++sno1;		
			//System.out.println("Second a12: "+a12+" a11 "+a11);
			if(chk>0)
			{				
%>
			<td colspan=4></td>
		
<%			chk=0;	
			}
		 yearmonprev=expd12[a12];
		 yearmondur=valupto12[a12];
%>
	<tr> 
	 	<td class="rptValue" nowrap><%=sno1%></td>
	 	<td class="rptValue" nowrap><%=year12[a12]%></td>
		<td class="rptValue" ><%=month[mon12[a12]-1]%></td>
		<td class="rptValue" ><%=expd12[a12]%></td>
		<td class="rptValue" ><%=valupto12[a12]%></td>
		<td class="rptValue" ><%=workd12[a12]%></td>

<%		if(a11==a12+1)
		{	
		 expprev=expd12[a12];
		 valup=valupto12[a12];	
%>
	 	<%-- 	<td class="rptValue"><b><%=totalmain+expd12[a12]+valupto12[a12]%></b></td>--%>
	 	<td class="rptValue"></td>
	</tr> 
<%	}
	else
	{
%>
		<td class="rptValue"></td>
<%	} 
		chk++;
		}
	  }	
	  i++;
    }
    else
    {
		if(a11>0)
		{
			for(int a12=0;a12<=a11-1;a12++)
			{
			++sno3;
			
			//System.out.println("Third  a12: "+a12+" a11 "+a11 +"  ");
			if(chk>0)
			{
			tst=1;
%>
			<td colspan=4></td>
		
<%			chk=0;	
			}
		 yearmonprev=expd12[a12];
		 yearmondur=valupto12[a12];
%> 		
	<tr> 	
		<td class="rptValue" nowrap><%=sno3%></td>	 
	 	<td class="rptValue" nowrap><%=year12[a12]%></td>
		<td class="rptValue"><%=month[mon12[a12]-1]%></td>
 		<td class="rptValue"><%=expd12[a12]%></td>
		<td class="rptValue"><%=valupto12[a12]%></td>
		<td class="rptValue"><%=workd12[a12]%></td>
		
<%	if(a11==a12+1 && tst!=1)
	{
	 expprev=expd12[a12];
	 valup=valupto12[a12];
	
%>
 	<%-- 	<td class="rptValue"><b><%=totalmain+expd12[a12]+valupto12[a12]%></b></td>   --%>
 	<td class="rptValue"></td>
  </tr> 
<%	}
	else
	{
%>
		<td class="rptValue"></td>
<%
		}
		//tst=0;
		chk++;
		} 
	  }
	  if(b11>0)
	  {
		for(int a12=0;a12<=b11-1;a12++)
		{
			++sno3;			
			//System.out.println("Fourth a12: "+a12+" b11 "+b11);
			if(chk>0)
			{
			tst=0;
%>
		<td colspan=4></td>
		
<%			chk=0;
			}
			 yearmonprev=expd21[a12];
		 yearmondur=valupto21[a12];

%>
	<tr  bgcolor="#ffffff">
	  	<td class="rptValue" nowrap><%=sno3%></td>
		<td class="rptValue" nowrap><%=year21[a12]%></td>
		<td class="rptValue"><%=month[mon21[a12]-1]%></td>
		<td class="rptValue"><%=expd21[a12]%></td>
		<td class="rptValue"><%=valupto21[a12]%></td>
		<td class="rptValue"><%=workd21[a12]%></td>

<%	if(b11==a12+1)
	{
	 expprev=expd21[a12];
	 valup=valupto21[a12];
%>
		<td class="rptValue"></td>		
   </tr>
<%		}
		else
		{
%>
			<td class="rptValue"></td>
<%
		} 
		//tst1=0; 
		chk++;
		} 
	   }
      }
       toto=totalmain+expprev+valup;
       totalmain+=yearmonprev+yearmondur;
     }%>
    <%--   <tr>
     <td align="left" colspan="6">&nbsp;</td>
     <td align="left"><%=totalmain%></td>--%>
<%	   BigDecimal bd = new BigDecimal(Double.toString(totalmain));
	   bd = bd.setScale(2,BigDecimal.ROUND_HALF_UP);
	   totalmain=Double.parseDouble(""+bd); %>  
	   
     <tr>
     <td align="left" colspan="6">&nbsp;</td>
     <td align="left"><%=totalmain%></td>
     </tr>
        <%
    }
    }
   else
   {
%>
<tr>
		<td class=rptValue align="center">-</td>
	    <td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
	</tr>
<%
	  }
	 }//end of main while
   }
  else
	{
%>
	
	<tr bgcolor="#ffffff">
		<td class="btext">1. ProgrammeName</td>
	   <td class="rptValue" >-</td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" >2. Expenditure During<br>&nbsp;&nbsp;&nbsp;&nbsp;The Prev Year<br>&nbsp;&nbsp;&nbsp;&nbsp;(Rs In Lakhs)</td>
		<td class="rptValue" >-</td>
	</tr>
	<tr bgcolor="#ffffff">
	 	<td class="btext">Slno</td>
		<td class="btext">Year</td>
	    <td class="btext">Month</td>
	    <td class="btext">Upto Previous<br>Month</td>
		<td class="btext">During The<br> Month</td>
		<td class="btext">Value of work<br>done but not paid</td>
		<td class="btext">Total  Expenditure<br>(Rs In Lakhs)</td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=rptValue align="left">-</td>
	    <td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
		<td class=rptValue align="left">-</td>
	</tr>	
				 
<% }
}catch(Exception e)
{

}
finally
{
rs.close();

st1.close();
st2.close();
s.close();
stmt.close();

}%>
</table>
 <br><br> 
 
 
 

     

   
