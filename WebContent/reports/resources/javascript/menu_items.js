// menu_items.js file

var MENU_ITEMS =[
	["Administration", null,
		["User Management", "switch.do?prefix=/admin&page=/UserManagementData.do"],
		["User Roles", null],
		["User Audit", null],
		["General Admin", null]
	],
	["Masters", null,
		["General",null,
			["Public Representatives","switch.do?prefix=/masters&page=/PublicRep.do&mode=data"],
		],
		["Habitation",null,
			["Panchayat Raj Habitation","switch.do?prefix=/masters&page=/PanchRaj.do&mode=data"],
			["Public Institutions","switch.do?prefix=/masters&page=/Institute.do&mode=data"],
			["Priorities","switch.do?prefix=/masters&page=/Priority.do&mode=data"],
			["Habitation Status","switch.do?prefix=/masters&page=/HabData.do"]
		],
		["Asset",null,
			["Asset Type","switch.do?prefix=/masters&page=/AssetType.do&mode=data"],
			["Asset Component","switch.do?prefix=/masters&page=/AssetCompType.do&mode=data"],
			["Asset SubComponent","switch.do?prefix=/masters&page=/AssetSubCompType.do&mode=data"],
			["SubComponent Parameters","switch.do?prefix=/masters&page=/AssetSubCompParam.do&mode=data"],
			["Asset Master","switch.do?prefix=/masters&page=/Asset.do&mode=data"]
		],
		["Source",null,
			["Source Type","switch.do?prefix=/masters&page=/SourceType.do&mode=data"],
			["Sub Source Type","switch.do?prefix=/masters&page=/SubSourceType.do&mode=data"],
			["Source Master","switch.do?prefix=/masters&page=/Source.do&mode=data"]
		],
		["Programme",null,
			["Programme","switch.do?prefix=/masters&page=/Programme.do&mode=data"],
			["Sub Programme","switch.do?prefix=/masters&page=/SubProgramme.do&mode=data"]
		],
		["Offices",null,
			["Head Office","switch.do?prefix=/masters&page=/Head.do&mode=data"],
			["Circle Office","switch.do?prefix=/masters&page=/Circle.do&mode=data"],
			["Division Office","switch.do?prefix=/masters&page=/Division.do&mode=data"],
			["Sub Division Office","switch.do?prefix=/masters&page=/SubDivision.do&mode=data"],
			["Section Office","switch.do?prefix=/masters&page=/Section.do&mode=data"],
			["RWS Office Details","switch.do?prefix=/masters&page=/Office.do&mode=data"]
		],
		["Employee Details",null,
			["Qualification","switch.do?prefix=/masters&page=/Qual.do&mode=data"],
			["Designation","switch.do?prefix=/masters&page=/Desgn.do&mode=data"],
			["Work Specialzation","switch.do?prefix=/masters&page=/WorkSpecial.do&mode=data"],
			["Employee Master","switch.do?prefix=/masters&page=/Employee.do&mode=data"]
		],
		["Head Of Accounts",null,
			["Major Head","switch.do?prefix=/masters&page=/MajorHead.do&mode=data"],
			["SubMajor Head","switch.do?prefix=/masters&page=/SubMajorHead.do&mode=data"],
			["Minor Head","switch.do?prefix=/masters&page=/MinorHead.do&mode=data"],
			["Group Sub Head","switch.do?prefix=/masters&page=/GrpSubHead.do&mode=data"],
			["Sub Head","switch.do?prefix=/masters&page=/SubHead.do&mode=data"],
			["Detail Head","switch.do?prefix=/masters&page=/DetailHead.do&mode=data"]
		],
		["Contractor","switch.do?prefix=/masters&page=/Contractor.do&mode=data"],
		["Water Quality",null,
			["Test Master","switch.do?prefix=/masters&page=/WaterTest.do&mode=data"],
			["Parameter Master","switch.do?prefix=/masters&page=/WaterPTest.do&mode=data"],
			["Lab Master","switch.do?prefix=/masters&page=/WaterLab.do&mode=data"]
		],
		["Stores",null,
			["Stores Master","switch.do?prefix=/masters&page=/Stores.do&mode=data"],
			["Supplier Master","switch.do?prefix=/masters&page=/Supplier.do&mode=data"],
			["Item Master","switch.do?prefix=/masters&page=/Item.do&mode=data"]
		],
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
				["Administrative Sanctions", "switch.do?prefix=/proposals&page=/OMAdminProposalData.do"]
			]
		],
		["Estimates", null,
			["New Estimates",null,
				["Preparation","switch.do?prefix=/estimates&page=/NewEstimateData.do"],
				["Technical Sanction","switch.do?prefix=/estimates&page=/NewEstSanctionData.do"]
			],
			["O&M Estimates",null,
				["Preparation","switch.do?prefix=/estimates&page=/OMEstimateData.do"],
				["Technical Sanction","switch.do?prefix=/estimates&page=/OMEstSanctionData.do"],
			]
		],
		["Water Quality Management", null,
			["Sample Collection","switch.do?prefix=/wquality&page=/WaterSample.do&mode=data"],
			["Sample Forwarded","switch.do?prefix=/wquality&page=/WaterSampleGeoTest.do&mode=data"],
			["Quality Tests","switch.do?prefix=/wquality&page=/WaterSampleRes.do&mode=data"],
			["Source Identification & Finalisation","switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=data"],
			["Drilling Status","switch.do?prefix=/wquality&page=/DrillStatus.do&mode=data"]
		],
		["Contractor Management", null,
			["Tender Schedule A","switch.do?prefix=/contractor&page=/TenderSchedule.do&mode=data"],
			["Tender Notification","switch.do?prefix=/contractor&page=/TenderNotification.do&mode=data"],
			["Tender Application","switch.do?prefix=/contractor&page=/WaterSampleRes.do&mode=data"],
			["Tender Submitted","switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data"],
			["Tender Opening Register","switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data"],
			["Comparative Statement","switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data"],
			["Work Break Down Structure","switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data"],
			["Register Agrement","switch.do?prefix=/contractor&page=/WaterFinalIden.do&mode=data"],
			["Work Agreement","switch.do?prefix=/contractor&page=/DrillStatus.do&mode=data"]
		],
		["Works Monitoring", null],
		["Complaints Monitoring", null],
		["Fund Accounting", null],
		["Stock Management", null]
	],
	["Graphs", null,
		["Habitation Status","./reports/rws_coverage_graph_form.jsp"],
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
				["Location - Status","./reports/rws_hab_status_form.jsp"],
				["Constituency  - Status","./reports/rws_consit_hab_status_form.jsp"],
				["Office - Status","./reports/rws_coverage_status_frm1.jsp"],
				["Constituency - Status","./reports/rws_const_coverage_status_frm.jsp"],
				["RWS Planning-Format-I","./reports/rws_planning_format1_frm.jsp"],
				["RWS Planning-Format-II","./reports/rws_planning_format2_frm.jsp"],
				["RWS Planning-Format-III","./reports/rws_planning_format3_frm.jsp"],
				["Assets in Habitation","./reports/rws_hab_asset_status_no_frm.jsp"]

			],
			["Asset",null,
			//	["Asset","./reports/rws_asset_frm.jsp"],
				["Office - Asset/Hab","./reports/rws_asset_hab_off_frm.jsp"],
				["Mandal Wise PWS Details","./reports/rws_mandal_pws_status_detail_frm.jsp"],
				["Mandal Wise CPWS Details","./reports/rws_mandal_cpws_status_detail_frm.jsp"],
				["Asset Sub Component","./reports/arws_asset_new_subcomp_frm.jsp"],
				["Login Report","./reports/rws_login_hab_rpt.jsp"],
				["Check List","./reports/rws_check_list_Frm.jsp"]

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
	["Help", null],
	["LogOut", "/pred/rws_logout.jsp"]
];
