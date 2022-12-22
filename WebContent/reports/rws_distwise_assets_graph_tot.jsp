<%
	
String q11=null,q22=null,q33=null,q44=null,q55=null,q66=null,q77=null,q88=null,q99=null,q10=null;
dCode=String.valueOf(session.getAttribute("dCode"));

                 if(dCode.equals("51"))
				 {
                   System.out.println("first");
           
                 query="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='01' and a.circle_office_code=c.circle_office_code  ";
				 q11="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='02' and a.circle_office_code=c.circle_office_code   ";
                 q22="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='03' and a.circle_office_code=c.circle_office_code   ";
				 q33="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='04' and a.circle_office_code=c.circle_office_code ";
                
                q44="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='05' and a.circle_office_code=c.circle_office_code   ";
				
				q55="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='06' and a.circle_office_code=c.circle_office_code  ";
								
				q66="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='07' and a.circle_office_code=c.circle_office_code   ";
								
				q77="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='08' and a.circle_office_code=c.circle_office_code   ";
								
				q88="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='09' and a.circle_office_code=c.circle_office_code   ";
								
				q99="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='11' and a.circle_office_code=c.circle_office_code   ";
								
				q10="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='12' and a.circle_office_code=c.circle_office_code  ";
			
				 }
				else if(!dCode.equals("51"))
				 { System.out.println("second");
                   query="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='01' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"'  ";
					 q11="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='02' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"'  ";
	                 q22="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='03' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
					 q33="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='04' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
	                
	                q44="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='05' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
					
					q55="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='06' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
									
					q66="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='07' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
									
					q77="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='08' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"'  ";
									
					q88="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='09' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"' ";
									
					q99="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='11' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"'  ";
									
					q10="select count(*) from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s ,rws_circle_office_tbl c where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code='12' and a.circle_office_code=c.circle_office_code and a.circle_office_code='"+dCode+"'  ";
					
				 }
				
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

				st5 = conn.createStatement();
				r5= st5.executeQuery(q55);

				st6 = conn.createStatement();
				r6= st6.executeQuery(q66);

				st7 = conn.createStatement();
				r7= st7.executeQuery(q77);

				st8 = conn.createStatement();
				r8= st8.executeQuery(q88);

				st9 = conn.createStatement();
				r9= st9.executeQuery(q99);

				st10 = conn.createStatement();
				r10= st10.executeQuery(q10);

				rs.next();			
				r1.next();
				r2.next();
				r3.next();
				r4.next();
				r5.next();
				r6.next();
				r7.next();
				r8.next();
				r9.next();
				r10.next();

				
         
		totfc=totfc+rs.getInt(1);
		totpc1=totpc1+r1.getInt(1);
		totpc2=totpc2+r2.getInt(1);
		totpc3=totpc3+r3.getInt(1);
		totpc4=totpc4+r4.getInt(1);
		totpc5=totpc5+r5.getInt(1);
		totpc6=totpc6+r6.getInt(1);
		totpc7=totpc7+r7.getInt(1);
		totpc8=totpc8+r8.getInt(1);
		totpc9=totpc9+r9.getInt(1);
		totpc10=totpc10+r10.getInt(1);
			// tot=tot+rs.getInt(2);
	    tot=tot+totfc+totpc1+totpc2+totpc3+totpc4+totpc5+totpc6+totpc7+totpc8+totpc9+totpc10;
	    //System.out.println("tot:::::::::;"+tot);
	    
			if(tot!=0)

		{ j=0;
			//System.out.println("in total"+tot);
			%>
			<tr>
				<td class="btext">S.No. </td>
				<td class="btext">Asset Name</td> 
				<td class="btext">Hab Count</td> 
			</tr>
			
		<tr>
			<td class="mystyle1"><%=++j%> </td>
			<td class="mystyle1">PWS</td>
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
			<td class="mystyle1">MPWS</td>
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
			<td class="mystyle1">CPWS</td>
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
			<td class="mystyle1">HPS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc3%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc3%> </td>
            <% } %>
		</tr>
		
       <tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">SHPS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc4%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc4%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">OW'S</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc5%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc5%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">PONDS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc6%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc6%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">OTHERS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc7%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc7%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">DP</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc8%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc8%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">SCHOOLS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc9%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc9%> </td>
            <% } %>
		</tr>
<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">LABS</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><%=totpc10%></td><% }
               else {%>
			  <td class="mystyle1"><%=totpc10%> </td>
            <% } %>
		</tr>
<BR>

<%  }
else {
	%>
	
	<tr><td align=center width="100%" class=btext nowrap>There are no Records</td></tr>
	
	<%}%>
             <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>

