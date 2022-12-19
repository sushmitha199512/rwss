<%	
String q11=null,q22=null,q33=null,q44=null;
dCode=String.valueOf(session.getAttribute("dCode"));

                
                 if(dCode.equals("51"))
				 {
                 query="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='W'";
				 q11="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='S'";
                 q22="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='C'";
				 q33="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='D'";
				 q44="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='N'";
				

				 }
				else if(!dCode.equals("51"))
				 { 
                   query="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='W' and substr(h.hp_code,1,2)='"+dCode+"'";
					q11="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='S' and substr(h.hp_code,1,2)='"+dCode+"'";
					q22="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='C'and substr(h.hp_code,1,2)='"+dCode+"'";
					q33="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='D' and substr(h.hp_code,1,2)='"+dCode+"'";
					q44="select count(STATUS) from rws_hp_subcomp_param_tbl h where STATUS='N' and substr(h.hp_code,1,2)='"+dCode+"'";

					
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
				r4 = st4.executeQuery(q44);
                 
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
				<td class="btext">Quality-Status</td> 
				<td class="btext">Count</td> 
			</tr>
			
		<tr>
			<td class="mystyle1"><%=++j%> </td>
			<td class="mystyle1">Working</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><a href="rws_distwise_graph_rpt.jsp?status=<%="W"%>"><%=totfc %></a> </td>
			<% }
		     else {%>
			  <td class="mystyle1"><a href="rws_distboredetails_rpt.jsp?dcode=<%=dCode%>&status=<%="W"%>"><%=totfc%></a>
			  </td>
            <% } %>
		</tr>
			<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">Seasonal</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><a href="rws_distwise_graph_rpt.jsp?status=<%="S"%>"><%=totpc1 %></a> </td>
			<% }
		     else {%>
			  <td class="mystyle1"><a href="rws_distboredetails_rpt.jsp?dcode=<%=dCode%>&status=<%="S"%>"><%=totpc1%></a>
			  </td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">Condemened</td>
			 <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><a href="rws_distwise_graph_rpt.jsp?status=<%="C"%>"><%=totpc2 %></a> </td>
			<% }
			 else {%>
			  <td class="mystyle1"><a href="rws_distboredetails_rpt.jsp?dcode=<%=dCode%>&status=<%="C"%>"><%=totpc2%></a>
			  </td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">Dried</td>
			<% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><a href="rws_distwise_graph_rpt.jsp?status=<%="D"%>"><%=totpc3%></a> </td><% }
               else {%>
			  <td class="mystyle1"><a href="rws_distboredetails_rpt.jsp?dcode=<%=dCode%>&status=<%="D"%>"><%=totpc3%></a>
			  </td>
            <% } %>
		</tr>
		

		<tr>
			<td class="mystyle1"><%=++j %> </td>
			<td class="mystyle1">NotWorking</td>
            <% if(dCode.equals("51"))
				{ %>
			<td class="mystyle1"><a href="rws_distwise_graph_rpt.jsp?status=<%="N"%>"><%=totpc4%></a>
			</td>
		<%}else {%>
			  <td class="mystyle1"><a href="rws_distboredetails_rpt.jsp?dcode=<%=dCode%>&status=<%="N"%>"><%=totpc4%></a>
			  </td>
            <% } %>
		  </tr>
		<%  }else {
	%>
	
	<tr><td align=center width="100%" class=btext nowrap>There are no Records</td></tr>
	
	<%}%>
             <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>

