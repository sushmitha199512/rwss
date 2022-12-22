<tr>
		<td>
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Technical Sanction (Amount In Rs.Lakhs)</b></font></legend>
<label>

		<table>
			<tr>
			
		<%
		try
		{
					int sancAmt = 0;
			String sanAmt = (String)request.getAttribute("sancAmt");
			sancAmt = Integer.parseInt(sanAmt);
			System.out.println("sancamt"+sancAmt);
			if (sancAmt < 2)
			{
		%>
		<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:DEE</b></td>
		<td width="150"><html:select property="techSangiven"    >
			<html:option value="">Please Select...</html:option>
			<html:options collection="sangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
			<%
			}
		else
			if (sancAmt >= 2 && sancAmt < 10)
			{
		%>
			<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:EE</b></td>
		<td width="150"><html:select property="techSangiven"   >
			
			<html:options collection="sangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
			<%
			}
			else
				if (sancAmt >= 10 && sancAmt < 50)
			{
		%>
			<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:SE</b></td>
		<td width="150"><html:select property="techSangiven"   >
			
			<html:options collection="sangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
				<%
			}
			else
				if (sancAmt >= 50)
			{
			%>
				<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:</b></td>
		        <td width="150"><html:text property="techSangiven" value = "CE RWS"  /></td>
		        
		
				<%
				
			}
			}
			catch(Exception e)
			{
			System.out.println("EEEEE"+e);
			}
			%>
			
		<td></td>
		<td width="160"><font face=verdana size=2><b>Technical Sanction Amount(Rs.in lakhs)</b></td>
		        <td width="150"><html:text property="techSanAmt"   /></td>
		</tr>
		<tr>
		<td width="180"><font face=verdana size=2><b>Technical Sanction Number</b></td>
		<td width="150"><html:text property="techSanNo"   /></td>
		<td></td>
		<td width="160"><font face=verdana size=2><b>Technical Sanction Date</b></td>
		<td width="150"><html:text property="techSanDate"  /></td>
		<td><a href="javascript: showCalendar(document.monitoringForm.techSanDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle" >
					</a></td>
		</tr>
		<html:hidden property="admSanDate"/>
		<%java.util.Date d=new java.util.Date();
		java.text.SimpleDateFormat format=new java.text.SimpleDateFormat("dd/MM/yyyy"); 
		String currentDate=format.format(d);%>
		<input type="hidden"  name="cDate"    value='<%=currentDate%>'/>
		<script>
		function insert()
		{   
		          var date=document.getElementById('techSanDate').value;
				  var toDate=document.getElementById('cDate').value;
				  var adminSancDate=document.getElementById('admSanDate').value;
				  var temp=adminSancDate;
				   
				  adminSancDate=adminSancDate.split('/');
				  date=date.split('/');
				  toDate=toDate.split('/');
				   
				  var admn=new Date(adminSancDate[2],adminSancDate[1]-1,adminSancDate[0] );
				  var from=new Date(date[2],date[1]-1,date[0] );
				  var to=new Date(toDate[2],toDate[1]-1,toDate[0] );
			 	    
				   if(to>=from&&from>=admn)
				   {
				      
				         alert("Succesfully Saved");
	                     document.monitoringForm.flag.value="1";
	                     document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	                     document.monitoringForm.submit();
	                  
	                }
	                 else
	                {
	                 alert("Technical snaction date must be less  than or equals to Today's Date");
	                }
	                if(from<admn)
	                {
	                 alert("Technical sanction date must be greater than or equals to "+temp+"(Admin Sanction Date)");
	                }
	          	  
		}
	    </script>
		
		<tr>
		<td width="160"><font face=verdana size=2><b>Habitations Benefited(No)</b></td>
		<td width="150"><html:text property="techHabsBen"   /></td>
		
		<td><html:button property="mode" value="..." styleClass="bText"onclick='<%= "javascript: fnPickHabitations()"%>' /></td>
		<td colspan=2 rowspan=3>
		<!-- code added -->
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Population Benefited(AS Per Census)</b></font></legend>
		<label>
		<table width="100%">
 		<tr>
 		<td>		
		
		<tr>
		 <td ><font face=verdana size=2><b>Plain</b> </font></td>
		 <td><html:text property="eplainPop" readonly="true"  /> </td>
		</tr>
		<tr>
		 <td><font face=verdana size=2><b>SC</b> &nbsp;&nbsp;</font></td>
		 <td><html:text property="escPop"  readonly="true"  /> </td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>ST</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="estPop" readonly="true"/></td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>Total</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="estTotPop" readonly="true"/></td>
		</tr>
 	    </table>
		</label>
		</fieldset>
		</td>
		</tr>
		<!-- end -->
		</td></tr>
		<tr>
	 	<td  ><font face=verdana size=2><b>SSR Year</b></font></td>
		<td width="150"><html:text property="ssrYear"   /></td>
	 	</tr>
	 	
		<tr>
		<td width="160"><font face=verdana size=2><b>Habitation Names</b></td>
		<td width="150"><html:textarea property="techHabNames" style="height:70px;width:180px"  /></td>
		
		 
		</tr>
		<tr>
			<td></td><td></td>
			<td >
			<html:hidden property="flag" />
			<%
			//int cnt = 0;
			String count = (String)request.getAttribute("chkcount");
			if (count == null)
			count = "";
			 
			  if (count.equals("0"))
			  {
			  
			   %>
			
		<input type=button value=Save onclick="insert()" class="bText"/>
		<%
		}
			if (!count.equals("0") && !count.equals(""))
			{
		 %>
		 <input type=button value=Save onclick="insert()" class="bText"/>
		 <% }%>
		   </td>
		<td>
		<html:hidden property="del" />
		<input type=button value=Delete onclick="fndelete()" class="bText"/>
		</td>
			
			
			</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<tr id="REVLNK1">
		<td>
		<a href="#" onclick="showRev()"><font  font-weight:bold;  size="2">(+)</font></a>
		<font  font-weight:bold;  size="3">Revised Technical Sanction</font>
		</td>
		</tr>
		<tr id="REVLNK2">
		<td>
		<a href="#" onclick="hiderev()"><font  font-weight:bold;  size="2">(-)</font></a>
		<font  font-weight:bold;  size="3">Revised Technical Sanction</font>
		</td>
		</tr>
		<script>
		function showRev()
		{
		   var tecNo= document.getElementById('techSanNo').value;
		   if(tecNo!='')
		   {
		    document.getElementById('REV').style.display='inline';
		    document.getElementById('REVLNK1').style.display='none';
		    document.getElementById('REVLNK2').style.display='inline';
		    }
		    else
		    {
		     alert("There is no technical sanction details for this work");
		    }
		}
		function hiderev()
		{
		  
		  document.getElementById('REV').style.display='none';
		  document.getElementById('REVLNK2').style.display='none';
		  document.getElementById('REVLNK1').style.display='inline';
		  var revNo=document.getElementById('revtechSanNo').value;
		  
		  if(revNo!='')
		  {
		   document.getElementById('REV').style.display='inline';
		   document.getElementById('REVLNK2').style.display='none';
		  document.getElementById('REVLNK1').style.display='none';
		  }
		}
		</script>
		
	 	<tr id="REV">
		<td>
		
		<fieldset>
<legend><font color=#871D0E face=verdana size=2><b>Revised Technical Sanction (Amount In Rs.Lakhs)</b></font></legend>
<label>
		<table>
		
		
		
		<tr>
		<%
		try
		{
			int sancAmt = 0;
			String sanAmt = (String)request.getAttribute("revsancAmt");
			 sancAmt = Integer.parseInt(sanAmt);
			 
			
			if (sancAmt < 2)
			{
		%>
		<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:DEE</b></td>
		<td width="150"><html:select property="revtechSangiven"   >
			<html:option value="">Please Select...</html:option>
			<html:options collection="revsangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
			<%
			}
		else
			if (sancAmt >= 2 && sancAmt < 10)
			{
		%>
			<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:EE</b></td>
		<td width="150"><html:select property="revtechSangiven"   >
			
			<html:options collection="revsangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
			<%
			}
			else
				if (sancAmt >= 10 && sancAmt < 50)
			{
		%>
			<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:SE</b></td>
		<td width="150"><html:select property="revtechSangiven"   >
			
			<html:options collection="revsangivenby" name="techsan" property="code" labelProperty="name" />
			</html:select>
			</td>
				<%
			}
			else
				if (sancAmt >= 50)
			{
			%>
				<td width="160"><font face=verdana size=2><b>Technical Sanction Accorded By:</b></td>
		<td width="150"><html:text property="revtechSangiven" value = "CE RWS"  /></td>
		
				<%
			}
			}
			catch(Exception e)
			{
			System.out.println("Exception in jsp"+e);
			}
			
			%>
			
			
			
		<td></td>
		 <td width="160"><font face=verdana size=2><b>Revised Tech Sanction Amount(Rs.in lakhs)</b></td>
		<td width="150"><html:text property="revtechSanAmt"   /></td>
		</tr>
		<tr>
		<td width="180"><font face=verdana size=2><b>Revised Tech Sanction No</b></td>
		<td width="150"><html:text property="revtechSanNo"   /></td>
		<td></td>
		<td width="160"><font face=verdana size=2><b>Revised Tech Sanction Date</b></td>
		<td width="150"><html:text property="revtechSanDate"   /></td>
		<td><a href="javascript: showCalendar(document.monitoringForm.revtechSanDate);">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
		</tr>
		
		<tr>
		<td width="160"><font face=verdana size=2><b>Habitations Benefited(No)</b></td>
		<td width="150"><html:text property="revtechHabsBen"   /></td>
		<td><html:button property="mode" value="..."  styleClass="bText" onclick='<%= "javascript: revfnPickHabitations()"%>' /></td>
		<td colspan=2 rowspan=3>
		<!-- code added -->
		<fieldset>
		<legend><font color=#871D0E face=verdana size=2><b>Population Benefited(AS Per Census)</b></font></legend>
		<label>
		<table width="100%">
 		<tr>
 		<td>		
		
		<tr>
		 <td ><font face=verdana size=2><b>Plain</b> </font></td>
		 <td><html:text property="rePlainPop" readonly="true"  /> </td>
		</tr>
		<tr>
		 <td><font face=verdana size=2><b>SC</b> &nbsp;&nbsp;</font></td>
		 <td><html:text property="reScPop"  readonly="true"  /> </td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>ST</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="reStPop" readonly="true"/></td>
		</tr>
		<tr> 
		 <td><font face=verdana size=2><b>Total</b> &nbsp;&nbsp;</font></td>
	     <td><html:text property="reTotPop" readonly="true"/></td>
		</tr>
 	    </table>
		</label>
		</fieldset>
		</td>
		</tr>
		<!-- end -->
		</td></tr>
		<tr>
	 	<td  ><font face=verdana size=2><b>SSR Year</b></font></td>
		<td width="150"><html:text property="revssrYear"   /></td>
		</tr>
		<tr>
		 <td width="160"><font face=verdana size=2><b>Habitation Names</b></td>
		<td width="150"><html:textarea property="revtechHabNames" style="height:70px;width:180px"  /></td>
		
		</tr>
		<tr>
			<td></td><td></td>
			<td >
			<html:hidden property="revflag" />
			<%
			//int cnt = 0;
			String revchkcount = (String)request.getAttribute("revchkcount");
			if (revchkcount == null)
			revchkcount = "";
			 
			  if (revchkcount.equals("0"))
			  {
			  // cnt = Integer.parseInt(count);
			  
			   %>
			
		<input type=button value=Save onclick="revinsert()" class="bText"/>
		<%
		}
			if (!revchkcount.equals("0") && !revchkcount.equals(""))
			{
		 %>
		 <input type=button value=Save onclick="revinsert()" class="bText"/>
		 <% }%>
		   </td>
		<td>
		<html:hidden property="revdel" />
		<input type=button value=Delete onclick="revfndelete()" class="bText"/>
		</td>
	 </tr>
     	</table>
		</label>
		</fieldset>
		
		</td>
		</tr>
		
<%//}%>
<script>
function revinsert()
		{   
		          var date=document.getElementById('revtechSanDate').value;
				  var toDate=document.getElementById('cDate').value;
				  var techDate=document.getElementById('techSanDate').value;
				  var temp=techDate;
				  techDate=techDate.split('/');
				  date=date.split('/');
				  toDate=toDate.split('/');
				   
				  var from=new Date(date[2],date[1]-1,date[0] );
				  var to=new Date(toDate[2],toDate[1]-1,toDate[0] );
				  var tDate=new Date(techDate[2],techDate[1]-1,techDate[0]);
				 
					 if(to>=from && from>=tDate)
				     {
					     alert("Succesfully Done");
	                     document.monitoringForm.revflag.value="2";
	                     document.monitoringForm.action="/pred/worksMonitoring/workStatus.do";
	                     document.monitoringForm.submit();
					 }
					 else
	                {
	                 alert("Revised Technical Snaction Date Must be less  than or equals to Today's Date");
	                }
	                if(from<tDate)
	                {
	                alert("Revised Technical Snaction Date Must be greater  than or equals to "+temp+"(Technical Sanction Date)");

	                }
		}
	    </script>
