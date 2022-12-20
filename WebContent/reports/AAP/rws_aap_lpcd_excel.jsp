<%@ page import="java.util.Hashtable,java.util.ArrayList" %>
<%@ page import="nic.watersoft.commons.AAPreport1"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal"%>


<%
String financialstartyr="";
	if (session.getAttribute("financialyr") != null) {
		financialstartyr = (String)session.getAttribute("financialyr");
	}

	DecimalFormat ndf = new DecimalFormat("####.##");
	DecimalFormat ndf1 = new DecimalFormat("##.##");
	

	String startyr = financialstartyr.substring(0, 4);
	String endyr = financialstartyr.substring(5, 9);
	String endyr1 = financialstartyr.substring(5, 9);
	
   
	
	
	
	//System.out.println("programe::"+programe);

	
	//System.out.println("startyr"+startyr);
	//System.out.println("sysyear::"+sysyear);
	int prevyear = 0, prevmon = 0;
	String fyear, fyear1;
	prevyear=Integer.parseInt(startyr)-1;
	String prevsyear=Integer.toString(prevyear);
	
	String category=(String)session.getAttribute("category");
	
	String startyr2 = "";
	java.util.Date d = new java.util.Date();
	if (d.getMonth() >= 3 && d.getMonth() <= 11) {
		endyr1 = startyr;

	} else {
		endyr1 = endyr;
	}

	//System.out.println("Startyr:"+startyr);
	//System.out.println("Startyr2:"+startyr2 );
	//System.out.println("Endyr:"+endyr );

	//System.out.println("Endyr2:"+endyr1);

	//System.out.println("Get Cuurent MOnth:"+d.getMonth());

	
	
	String targetyr=(Integer.parseInt(startyr)+1)+"-"+(Integer.parseInt(endyr)+1);
	String thisyr=startyr+"-"+endyr;
	//System.out.println("dcode"+dcode);
	//System.out.println("DivCode"+divCode);
%>

<body>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "AAPreport1.xls");

%>

<table border=1 cellspacing=0 cellpadding=0 width="60%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center">
	<tr>
		<td align="center" class="gridhdbg" colspan="10">AAP Report (All Schemes) for(<%=financialstartyr%>)</td>
	</tr>
	<tr>
	
		
	<td align="center" class="gridhdbg" rowspan="2">Status</td>
	<td align="center" class="gridhdbg" rowspan="2">Type</td>
<td align="center" class="gridhdbg" rowspan="1" colspan="6">Habitations-Physical</td>
<td align="center" class="gridhdbg" rowspan="1" colspan="2">Financial(Rs. Lakhs)</td>
	
	</tr>
	<tr>
	<td align="center" class="gridhdbg">Habs As on 01/04/<%=startyr %></td>
	<td align="center" class="gridhdbg">Population</td>
	<td align="center" class="gridhdbg">Achmt. During <%=financialstartyr%> (so far)</td>
	<td align="center" class="gridhdbg">Anticipated Achmt. During <%=financialstartyr%></td>
		<td align="center" class="gridhdbg">Achmt. During <%=financialstartyr%></td>
	
	<td align="center" class="gridhdbg">Target 2014-15(To be completed)</td>
	<td align="center" class="gridhdbg">Est. Cost of Schemes</td>
	<td align="center" class="gridhdbg">Probable Exp. During <%=targetyr%></td>
	</tr>
<tr>
	<%for(int i=1;i<11;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
	<%
		
		String temp="",dname="";
		
		try {
			
			
			ArrayList aapdetails=(ArrayList)session.getAttribute("aapdetails");
			Hashtable qa_comp_hash=(Hashtable)session.getAttribute("qa_comp_hash");
			Hashtable qa_hab_target_hash=(Hashtable)session.getAttribute("qa_hab_target_hash");
			Hashtable qa_hab_targetthis_hash=(Hashtable)session.getAttribute("qa_hab_targetthis_hash");
			
			
			
			///printing loop query
			
			int pop_pc1_qa=0,pop_pc2_qa=0,pop_pc3_qa=0,pop_pc4_qa=0,pop_fc_qa=0,pop_nc_qa=0;
			int hab_pc1_qa=0,hab_pc2_qa=0,hab_pc3_qa=0,hab_pc4_qa=0,hab_fc_qa=0,hab_nc_qa=0;
			int pop_pc1_nqa=0,pop_pc2_nqa=0,pop_pc3_nqa=0,pop_pc4_nqa=0,pop_fc_nqa=0,pop_nc_nqa=0;
			int hab_pc1_nqa=0,hab_pc2_nqa=0,hab_pc3_nqa=0,hab_pc4_nqa=0,hab_fc_nqa=0,hab_nc_nqa=0;
			double est_pc1_qa=0.0,est_pc2_qa=0.0,est_pc3_qa=0.0,est_pc4_qa=0.0,est_fc_qa=0.0,est_nc_qa=0.0;
			double prob_pc1_qa=0.0,prob_pc2_qa=0.0,prob_pc3_qa=0.0,prob_pc4_qa=0.0,prob_fc_qa=0.0,prob_nc_qa=0.0;
			double est_pc1_nqa=0.0,est_pc2_nqa=0.0,est_pc3_nqa=0.0,est_pc4_nqa=0.0,est_fc_nqa=0.0,est_nc_nqa=0.0;
			double prob_pc1_nqa=0.0,prob_pc2_nqa=0.0,prob_pc3_nqa=0.0,prob_pc4_nqa=0.0,prob_fc_nqa=0.0,prob_nc_nqa=0.0;
			int comhab_pc1_qa=0,comhab_pc2_qa=0,comhab_pc3_qa=0,comhab_pc4_qa=0,comhab_fc_qa=0,comhab_nc_qa=0;
			int comhab_pc1_nqa=0,comhab_pc2_nqa=0,comhab_pc3_nqa=0,comhab_pc4_nqa=0,comhab_fc_nqa=0,comhab_nc_nqa=0;
			int tarhab_pc1_qa=0,tarhab_pc2_qa=0,tarhab_pc3_qa=0,tarhab_pc4_qa=0,tarhab_fc_qa=0,tarhab_nc_qa=0;
			int tarhab_pc1_nqa=0,tarhab_pc2_nqa=0,tarhab_pc3_nqa=0,tarhab_pc4_nqa=0,tarhab_fc_nqa=0,tarhab_nc_nqa=0;
			int thishab_pc1_qa=0,thishab_pc2_qa=0,thishab_pc3_qa=0,thishab_pc4_qa=0,thishab_fc_qa=0,thishab_nc_qa=0;
			int thishab_pc1_nqa=0,thishab_pc2_nqa=0,thishab_pc3_nqa=0,thishab_pc4_nqa=0,thishab_fc_nqa=0,thishab_nc_nqa=0;


			
			if(category.equals("")){		
				for(int i=0;i<aapdetails.size();i++){
					String status=((AAPreport1)aapdetails.get(i)).getStatus();
					String type=((AAPreport1)aapdetails.get(i)).getType();
					String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
					String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
					if(status.equals("FC") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_fc_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							
							thishab_fc_qa+=1;
							
							
						}
                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){
							
							
							tarhab_fc_qa+=1;
							////////System.out.println(habcode+"--->"+tarvalues[0]+"@"+tarvalues[1]);
						}
						hab_fc_qa+=1;
						pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("FC") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_fc_nqa+=1;
						}
                       if(qa_hab_target_hash.get(workid+habcode)!=null){
						thishab_fc_nqa+=1;
							
						}
                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
							tarhab_fc_nqa+=1;
							}
						hab_fc_nqa+=1;
						pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("NC") && type.equals("QA")){
						//System.out.println("nc work ids "+workid);
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_nc_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_nc_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_nc_qa+=1;
								}
						hab_nc_qa+=1;
						pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("NC") && type.equals("NQA")){
						//System.out.println("nc work ids "+workid);
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_nc_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_nc_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_nc_nqa+=1;
								}
						hab_nc_nqa+=1;
						pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC1") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc1_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc1_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc1_qa+=1;
								}
						hab_pc1_qa+=1;
						pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC1") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc1_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc1_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc1_nqa+=1;
								}
						hab_pc1_nqa+=1;
						pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC2") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc2_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc2_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc2_qa+=1;
								}
						hab_pc2_qa+=1;
						pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC2") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc2_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc2_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc2_nqa+=1;
								}
						hab_pc2_nqa+=1;
						pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC3") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc3_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc3_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc3_qa+=1;
								}
						hab_pc3_qa+=1;
						pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC3") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc3_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc3_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc3_nqa+=1;
								}
						hab_pc3_nqa+=1;
						pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC4") && type.equals("QA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc4_qa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc4_qa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc4_qa+=1;
								}
						hab_pc4_qa+=1;
						pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
					if(status.equals("PC4") && type.equals("NQA")){
						if(qa_comp_hash.get(workid+habcode)!=null){
							comhab_pc4_nqa+=1;
						}
						if(qa_hab_target_hash.get(workid+habcode)!=null){
							thishab_pc4_nqa+=1;
								
							}
	                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
								tarhab_pc4_nqa+=1;
								}
						hab_pc4_nqa+=1;
						pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
						est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
						prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
					}
				}
					}		
							
					if(category.equals("SC")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							////////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA") && (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("SC")|| habtype.equals("SCST")||habtype.equals("SCP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}				
					if(category.equals("ST")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							//////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA") && (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&&(habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("ST")|| habtype.equals("SCST")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}	
							
					if(category.equals("P")){		
						for(int i=0;i<aapdetails.size();i++){
							String status=((AAPreport1)aapdetails.get(i)).getStatus();
							String type=((AAPreport1)aapdetails.get(i)).getType();
							String habtype=((AAPreport1)aapdetails.get(i)).getHabtype();
							String workid=((AAPreport1)aapdetails.get(i)).getWorkid();
							String habcode=((AAPreport1)aapdetails.get(i)).getHabcode();
							////System.out.println(habcode+"habtype "+habtype);
							if(status.equals("FC") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_qa+=1;
										}
								hab_fc_qa+=1;
								pop_fc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("FC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_fc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_fc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_fc_nqa+=1;
										}
								hab_fc_nqa+=1;
								pop_fc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_fc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_fc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_qa+=1;
										}
								hab_nc_qa+=1;
								pop_nc_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("NC") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_nc_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_nc_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_nc_nqa+=1;
										}
								hab_nc_nqa+=1;
								pop_nc_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_nc_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_nc_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_qa+=1;
										}
								hab_pc1_qa+=1;
								pop_pc1_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC1") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc1_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc1_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc1_nqa+=1;
										}
								hab_pc1_nqa+=1;
								pop_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc1_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_qa+=1;
										}
								hab_pc2_qa+=1;
								pop_pc2_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC2") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc2_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc2_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc2_nqa+=1;
										}
								hab_pc2_nqa+=1;
								pop_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc2_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_qa+=1;
										}
								hab_pc3_qa+=1;
								pop_pc3_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC3") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc3_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc3_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc3_nqa+=1;
										}
								hab_pc3_nqa+=1;
								pop_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc3_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("QA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_qa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_qa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_qa+=1;
										}
								hab_pc4_qa+=1;
								pop_pc4_qa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_qa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_qa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
							if(status.equals("PC4") && type.equals("NQA")&& (habtype.equalsIgnoreCase("P")|| habtype.equals("SCP")||habtype.equals("STP"))){
								if(qa_comp_hash.get(workid+habcode)!=null){
									comhab_pc4_nqa+=1;
								}
								if(qa_hab_target_hash.get(workid+habcode)!=null){
									thishab_pc4_nqa+=1;
										
									}
			                         if(qa_hab_targetthis_hash.get(workid+habcode)!=null){											
										tarhab_pc4_nqa+=1;
										}
								hab_pc4_nqa+=1;
								pop_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getTotalpop();
								est_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getSanamnt();
								prob_pc4_nqa+=((AAPreport1)aapdetails.get(i)).getProbamnt();
							}
						}
							}		

			
			
		
			
				
			
			
			///printing loop query
			
	


	%><tr>
	
	<td class="gridbg1" style="text-align: center;" rowspan="2">NC</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_nc_qa+comhab_nc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=tarhab_nc_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_nc_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_nc_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_nc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_nc_nqa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_nc_nqa+comhab_nc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_nc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_nc_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_nc_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC1</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc1_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_qa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_qa+comhab_pc1_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc1_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc1_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc1_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc1_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc1_nqa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc1_nqa+comhab_pc1_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc1_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc1_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc1_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC2</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc2_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_qa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_qa+comhab_pc2_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc2_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc2_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc2_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc2_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc2_nqa %></td>
				<td class="gridbg1" style="text-align: right;"><%=thishab_pc2_nqa+comhab_pc2_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc2_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc2_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc2_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC3</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_qa+comhab_pc3_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc3_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc3_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc3_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc3_nqa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc3_nqa+comhab_pc3_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc3_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc3_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc3_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">PC4</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_qa %></td>
		<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_qa+comhab_pc4_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_pc4_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_pc4_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_pc4_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_pc4_nqa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_pc4_nqa+comhab_pc4_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_pc4_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_pc4_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_pc4_nqa) %></td>
	</tr>
	<tr>
	<td class="gridbg1" style="text-align: center;" rowspan="2">FC</td>
	<td class="gridbg1" style="text-align: center;">QA</td>
	<td class="gridbg1" style="text-align: right;"><%=hab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=pop_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=comhab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=thishab_fc_qa %></td>
			<td class="gridbg1" style="text-align: right;"><%=thishab_fc_qa+comhab_fc_qa %></td>
	
	<td class="gridbg1" style="text-align: right;"><%=tarhab_fc_qa %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(est_fc_qa) %></td>
	<td class="gridbg1" style="text-align: right;"><%=ndf.format(prob_fc_qa) %></td>
	</tr>
	<tr>
	<td class="gridbg2" style="text-align: center;">NQA</td>
	<td class="gridbg2" style="text-align: right;"><%=hab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=pop_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=comhab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=thishab_fc_nqa %></td>
				<td class="gridbg1" style="text-align: right;"><%=thishab_fc_nqa+comhab_fc_nqa %></td>
	
	<td class="gridbg2" style="text-align: right;"><%=tarhab_fc_nqa %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(est_fc_nqa) %></td>
	<td class="gridbg2" style="text-align: right;"><%=ndf.format(prob_fc_nqa) %></td>
	</tr>
	<tr>
	<td class="gridhdbg" style="text-align: center;" rowspan="2">TOTAL</td>
	<td class="gridhdbg" style="text-align: center;">QA</td>
	<td class="gridhdbg" style="text-align: right;"><%=hab_nc_qa+hab_pc1_qa+hab_pc2_qa+hab_pc3_qa+hab_pc4_qa+hab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=pop_nc_qa+pop_pc1_qa+pop_pc2_qa+pop_pc3_qa+pop_pc4_qa+pop_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=comhab_nc_qa+comhab_pc1_qa+comhab_pc2_qa+comhab_pc3_qa+comhab_pc4_qa+comhab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_qa+thishab_pc1_qa+thishab_pc2_qa+thishab_pc3_qa+thishab_pc4_qa+thishab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_qa+thishab_pc1_qa+thishab_pc2_qa+thishab_pc3_qa+thishab_pc4_qa+thishab_fc_qa+comhab_nc_qa+comhab_pc1_qa+comhab_pc2_qa+comhab_pc3_qa+comhab_pc4_qa+comhab_fc_qa %></td>
	
	<td class="gridhdbg" style="text-align: right;"><%=tarhab_nc_qa+tarhab_pc1_qa+tarhab_pc2_qa+tarhab_pc3_qa+tarhab_pc4_qa+tarhab_fc_qa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(est_nc_qa+est_pc1_qa+est_pc2_qa+est_pc3_qa+est_pc4_qa+est_fc_qa) %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(prob_nc_qa+prob_pc1_qa+prob_pc2_qa+prob_pc3_qa+prob_pc4_qa+prob_fc_qa) %></td>
	</tr>
	<tr>
	<td class="gridhdbg" style="text-align: center;">NQA</td>
	<td class="gridhdbg" style="text-align: right;"><%=hab_nc_nqa+hab_pc1_nqa+hab_pc2_nqa+hab_pc3_nqa+hab_pc4_nqa+hab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=pop_nc_nqa+pop_pc1_nqa+pop_pc2_nqa+pop_pc3_nqa+pop_pc4_nqa+pop_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=comhab_nc_nqa+comhab_pc1_nqa+comhab_pc2_nqa+comhab_pc3_nqa+comhab_pc4_nqa+comhab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_nqa+thishab_pc1_nqa+thishab_pc2_nqa+thishab_pc3_nqa+thishab_pc4_nqa+thishab_fc_nqa %></td>
					<td class="gridhdbg" style="text-align: right;"><%=thishab_nc_nqa+thishab_pc1_nqa+thishab_pc2_nqa+thishab_pc3_nqa+thishab_pc4_nqa+thishab_fc_nqa+comhab_nc_nqa+comhab_pc1_nqa+comhab_pc2_nqa+comhab_pc3_nqa+comhab_pc4_nqa+comhab_fc_nqa %></td>
	
	<td class="gridhdbg" style="text-align: right;"><%=tarhab_nc_nqa+tarhab_pc1_nqa+tarhab_pc2_nqa+tarhab_pc3_nqa+tarhab_pc4_nqa+tarhab_fc_nqa %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(est_nc_nqa+est_pc1_nqa+est_pc2_nqa+est_pc3_nqa+est_pc4_nqa+est_fc_nqa) %></td>
	<td class="gridhdbg" style="text-align: right;"><%=ndf.format(prob_nc_nqa+prob_pc1_nqa+prob_pc2_nqa+prob_pc3_nqa+prob_pc4_nqa+prob_fc_nqa) %></td>
	</tr>
	<%
	
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>
</body>
</html>
