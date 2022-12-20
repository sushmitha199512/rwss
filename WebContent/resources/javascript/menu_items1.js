// menu_items1.js file

var MENU_ITEMS =[
	["Administration", null,
		
		["Change Password", "switch.do?prefix=/admin&page=/rws_change_password_frm.jsp"]
		
	],
	["Masters", null,
		["General",null,
					["Mandal Subdivision","switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data"]
			
		],
		["Habitation",null,
			["Panchayat Raj Habitation","switch.do?prefix=/masters&page=/PanchRaj.do&mode=data"],
			["Habitation Status","masters/switch.do?prefix=/masters&page=/HabData.do"]
		],
		["Asset",null,
			//["Asset Type","switch.do?prefix=/masters&page=/AssetType.do&mode=data"],
			//["Asset Component","switch.do?prefix=/masters&page=/AssetCompType.do&mode=data"],
			//["Asset Sub Component","switch.do?prefix=/masters&page=/AssetSubCompType.do&mode=data"],
			//["Sub Component Parameters","switch.do?prefix=/masters&page=/AssetSubCompParam.do&mode=data"],
			["Asset Master","switch.do?prefix=/masters&page=/Asset.do&mode=data"]
		
		],
		["Source",null,
			
		],
		["Programme",null,
			
		],
		["Offices",null,
			
		],
		["Employee Details",null,
			
		],
		["Head Of Accounts",null,
			
		],
		["Contractor","switch.do?prefix=/masters&page=/Contractor.do&mode=data"],
		["Water Quality",null,
			
		]
		
	],
	["Work Flow", null,
		["Proposals", null,
			["New Works", null,
				["Representation", "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do"],
				["Manage Proposal", "switch.do?prefix=/proposals&page=/NewProposalData.do"],
				["Administrative Sanction", "switch.do?prefix=/proposals&page=/NewAdminProposalData.do"],
				["List Proposals", "switch.do?prefix=/proposals&page=/ListNewProposals.do"]
			],
			["O&M Works", null,
				["Proposal", "switch.do?prefix=/proposals&page=/OMProposalData.do"],
				["Administrative Sanctions", "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"],
				["List Proposals", "switch.do?prefix=/proposals&page=/ListOMProposals.do"]
			]
		],
		["Estimates", null,
			["New Estimates",null,
			],
			["O&M Estimates",null,
			]
		],
		["Water Quality Management", null,
		],
		["Contractor Management", null,
			
		],
		["Works Monitoring", null],
		["Complaints Monitoring", null],
		["Fund Accounting", null],
		["Stock Management", null]
	],
	["Graphs", null,
		["Habitation Status","./reports/rws_coverage_graph_form.jsp"],
		["BoreWell Status","./reports/rws_graph_frm.jsp"],
		["FC - Proposed Year","./reports/rws_graph_frm1.jsp"],
		["FC - Proposed Est.Cost","./reports/rws_graph_frm2.jsp"],
		["Proposal", null,
				["Representative",null,
					["Office Wise","./reports/rws_circle_rep_proposal_graph_frm.jsp"],
					["Scheme Wise","./reports/rws_scheme_rep_proposal_graph_frm.jsp"],
					["Representative Wise","./reports/rws_repre_proposal_graph_frm.jsp"]
				],
				["Work Proposal", null,
					["Office Wise","./reports/rws_circle_work_proposal_graph_frm.jsp"],
					["Scheme Wise","./reports/rws_scheme_work_proposal_graph_frm.jsp"]
				],
				["Comparative Statements", null,
					["Constituency & Cost Wise","./reports/rws_rep_proposal_cost_graph_frm.jsp"],
					["Between Constituencies ","./reports/rws_proposal_consti_comp_graph_form.jsp"],	
					["Offices & Years Wise","./reports/rws_proposal_offices_comp_graph_form.jsp"],	
					["Work Status","./reports/rws_work_status_different_stages_graph_frm.jsp"]	
				],
				
		],
		
	],

	["Reports", null,
		["Master Reports",null,
			["Habitation",null,
			    ["Habitation Last Updated","./reports/rws_hab_update_frm.jsp"],
				["Habitations Not Updated","./reports/rws_hab_dist_combo.jsp"],
				["Constituency  - Status","./reports/rws_const_coverage_status_frm.jsp"],
				["Office Wise- Status","./reports/rws_office_coverage_frm.jsp"],
				["District Wise - Status","./reports/rws_coverage_status_frm1.jsp"],
				["RWS Planning - Format - I","./reports/rws_planning_format1_frm.jsp"],
				["RWS Planning - Format - II","./reports/rws_planning_format2_frm.jsp"]
				
			],
			["Asset",null,
			 ["Borewell Status","./reports/rws_district_rpt.jsp"]	
			],
		],
		["New Proposals",null,
			["Representative","./reports/rws_rep_proposal_frm.jsp"],
			["Work Proposal","./reports/rws_work_propo_det_frm.jsp"],
			["Proposal History", "switch.do?prefix=/proposals&page=/NewProposalTrackingData.do"]
		],
		["O&M Proposals",null,
			["O&M","./reports/rws_om_proposal_det_frm.jsp"],
			["Proposal History", "switch.do?prefix=/proposals&page=/OMProposalTrackingData.do"]
		],

		["Pendency Status",null,
			["Representative Wise","./reports/rws_proposal_pendency_rep_frm.jsp"],
			["Constituency Wise","./reports/rws_proposal_pendency_consti_frm.jsp"]
		],
		["Water Quality",null,
			["Source Details","./reports/rws_source_loc_rpt_frm.jsp"]
		],
		["Estimates",null,
			["Constituency Wise","./reports/rws_con_wise_est_cost_frm.jsp"]
		],
			
	],


	["Help", null,
		["Online Help", "./help/Help For PRED.htm"],
		["Data Input Sheets", "./help/Data Input Sheets Layout.doc"],
		["GO's","./masters/goForm.jsp"],
		["Estimates","./masters/leForm.jsp?mode=data"],
		["SSR 2005-2006","./help/SSR 2005-2006.doc"],
		["Rate Contract",""]
 	],
	
	["LogOut", "/pred/rws_logout.jsp"]
];
