package nic.watersoft.reports;

import java.util.ArrayList;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsReportRecord {

	RwsReportRecord() {
		columnsDataList = new ArrayList<Object>();
	}

	private ArrayList<Object> columnsDataList;

	public ArrayList<Object> getColumnsDataList() {
		return columnsDataList;
	}

	public void setColumnsDataList(ArrayList<Object> columnsDataList) {
		this.columnsDataList = columnsDataList;
	}

}
