package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N Reverting the Bank & PAO Transactions
 */
public class RwsPaymentRevertActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String txType;
	private String txDate;
	private String txId;
	private String totalProccessedAmount;
	private String totalBills;
	private ArrayList<RwsTxBillRecord> txBillsList;

	public void setTxDate(String txDate) {
		this.txDate = txDate;
	}

	public String getTxDate() {
		return txDate;
	}

	public void setTxId(String txId) {
		this.txId = txId;
	}

	public String getTxId() {
		return txId;
	}

	public void setTotalProccessedAmount(String totalProccessedAmount) {
		this.totalProccessedAmount = totalProccessedAmount;
	}

	public String getTotalProccessedAmount() {
		return totalProccessedAmount;
	}

	public void setTotalBills(String totalBills) {
		this.totalBills = totalBills;
	}

	public String getTotalBills() {
		return totalBills;
	}

	public void setTxType(String txType) {
		this.txType = txType;
	}

	public String getTxType() {
		return txType;
	}

	public void setTxBillsList(ArrayList<RwsTxBillRecord> txBillsList) {
		this.txBillsList = txBillsList;
	}

	public ArrayList<RwsTxBillRecord> getTxBillsList() {
		if (this.txBillsList == null) {
			return new ArrayList<RwsTxBillRecord>();
		}
		return txBillsList;
	}

}
