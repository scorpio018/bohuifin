package cn.com.bohui.bohuifin.bean;/** * 表名：t_account_record */import java.io.Serializable;public class AccountRecordBean extends BaseBean implements		Serializable {	/**	 *	 */	private static final long serialVersionUID = 1L;	private String recordId;	// 资金ID	private String accountId;	// 用户ID	private String userId;	// 项目ID	private String productId;	// 资金	private double money;	// 资金操作（入金、出金）	private String moneyOperate;	public String getRecordId() {		return recordId;	}	public void setRecordId(String recordId) {		this.recordId = recordId;	}	public String getAccountId() {		return accountId;	}	public void setAccountId(String accountId) {		this.accountId = accountId;	}	public String getUserId() {		return userId;	}	public void setUserId(String userId) {		this.userId = userId;	}	public String getProductId() {		return productId;	}	public void setProductId(String productId) {		this.productId = productId;	}	public double getMoney() {		return money;	}	public void setMoney(double money) {		this.money = money;	}	public String getMoneyOperate() {		return moneyOperate;	}	public void setMoneyOperate(String moneyOperate) {		this.moneyOperate = moneyOperate;	}}