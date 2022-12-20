<%	
String q11=null,q22=null,q33=null,q44=null;
dCode=String.valueOf(session.getAttribute("dCode"));
String ptype=(String)session.getAttribute("prgmType");
System.out.println("ptype.............."+ptype);               
                 if(dCode.equals("51"))
				 {
                 query="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<2*365  and sysdate - grounding_date>365 and substr(a.work_id,1,2) in ("+ptype+")";
				 q11="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and  substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<3*365  and sysdate - grounding_date>2*365 and substr(a.work_id,1,2) in ("+ptype+") ";
                 q22="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<4*365  and sysdate - grounding_date>3*365 and substr(a.work_id,1,2) in ("+ptype+")";
				 q33="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c,rws_district_tbl d  where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<5*365  and sysdate - grounding_date>4*365 and substr(a.work_id,1,2) in ("+ptype+")";
                 q44="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date>5*365 and substr(a.work_id,1,2) in ("+ptype+")";
				 System.out.println("first");

				 }
				else if(!dCode.equals("51"))
				 { 
                   query="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<2*365  and sysdate - grounding_date>365 and substr(a.work_id,1,2) in ("+ptype+") and substr(a.work_id,5,2)='"+dCode+"'";
				   q11="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and  substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<3*365  and sysdate - grounding_date>2*365 and substr(a.work_id,1,2) in ("+ptype+") and substr(a.work_id,5,2)='"+dCode+"'";
                   q22="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<4*365  and sysdate - grounding_date>3*365 and substr(a.work_id,1,2) in ("+ptype+") and substr(a.work_id,5,2)='"+dCode+"'";
				   q33="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c,rws_district_tbl d  where a.TYPE_OF_ASSET  in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date<5*365  and sysdate - grounding_date>4*365 and substr(a.work_id,1,2) in ("+ptype+") and substr(a.work_id,5,2)='"+dCode+"'";
                   q44="SELECT distinct count(a. work_id) FROM RWS_WORK_ADMN_TBL a,rws_work_commencement_tbl c ,rws_district_tbl d where a.TYPE_OF_ASSET in(03) and a.work_id=c.work_id and work_cancel_dt is null  and substr(a.work_id,5,2)=d.dcode and a.work_id not in (select work_id from rws_work_completion_tbl) and sysdate - grounding_date>5*365 and substr(a.work_id,1,2) in ("+ptype+") and substr(a.work_id,5,2)='"+dCode+"'";
				   System.out.println("second");
				 }
			
					System.out.println(query);
					System.out.println(q11);
					System.out.println(q22);
					System.out.println(q33);	
                    System.out.println(q44);	
				stmt = conn.createStatement();
				rs = stmt.executeQuery(query);
				
                st1 = conn.createStatement();
				r1 = st1.executeQuery(q11);


				st2 = conn.createStatement();
				r2 = st2.executeQuery(q22);

				st3 = conn.createStatement();
				r3= st3.executeQuery(q33);

				st4 = conn.createStatement();
				r4= st4.executeQuery(q44);

				rs.next();			
				r1.next();
				r2.next();
				r3.next();
				r4.next();
				
         
		totfc=totfc+rs.getInt(1);
		totpc1=totpc1+r1.getInt(1);
		totpc2=totpc2+r2.getInt(1);
		totpc3=totpc3+r3.getInt(1);
		totpc4=totpc4+r4.getInt(1);
			// tot=tot+rs.getInt(2);
	    tot=tot+totfc+totpc1+totpc2+totpc3+totpc4;
	    //System.out.println("tot:::::::::;"+tot);
	    
			if(tot!=0)

		{ j=0;
			//System.out.println("in total"+tot);
			%>
			<tr>
				<td class="btext">S.No. </td>
				<td class="btext">No.of Years Gap between Admin Sanction and Work Completion</td> 
				<td class="btext">Works Count</td> 
			</tr>
			
		<tr>
			<td class="mystyle1"><%=++j%> </td>
			<td class="mystyle1">1 to 2 Yrs</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totfc %></td>
			<% }
		     else {%>
			  <td class="mystyle1"><%=totfc%></td>
            <% } %>
		</tr>
			<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">2 to 3 Yrs</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc1 %></td>
			<% }
		     else {%>
			  <td class="mystyle1"><%=totpc1%></td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">3 to 4 Yrs</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc2 %></td>
			<% }
			 else {%>
			  <td class="mystyle1"><%=totpc2%> </td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">4 to 5 Yrs</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc3%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc3%> </td>
            <% } %>
		</tr>
		
       <tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">> 5 Yrs</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc4%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc4%> </td>
            <% } %>
		</tr>
		
		<%  }
else {
	%>
	
	<tr><td align=center width="100%" class=btext nowrap>There are no Records</td></tr>
	
	<%}%>
             <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>

