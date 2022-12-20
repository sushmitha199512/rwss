package nic.watersoft.reports;

import java.util.ArrayList;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsReport {

	private ArrayList<RwsReportRecord> recordsList;
	private RwsReportHeader rwsReportHeader;

	RwsReport(ArrayList<RwsReportRecord> recordsList,
			RwsReportHeader rwsReportHeader) {
		this.recordsList = recordsList;
		this.rwsReportHeader = rwsReportHeader;

	}

	public ArrayList<RwsReportRecord> getRecordsList() {
		return recordsList;
	}

	public void setRecordsList(ArrayList<RwsReportRecord> recordsList) {
		this.recordsList = recordsList;
	}

	public RwsReportHeader getRwsReportHeader() {
		return rwsReportHeader;
	}

	public void setRwsReportHeader(RwsReportHeader rwsReportHeader) {
		this.rwsReportHeader = rwsReportHeader;
	}

}
