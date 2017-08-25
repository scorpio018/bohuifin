package cn.com.bohui.bohuifin.bean;/** * 表名：t_product */import cn.com.bohui.bohuifin.annotation.SharedPreSaveAnnotation;import java.io.Serializable;public class ProductBean extends BaseBean implements        Serializable {    /**     *     */    private static final long serialVersionUID = 1L;    // 产品ID    @SharedPreSaveAnnotation    private String productId;    // 产品名    @SharedPreSaveAnnotation    private String productName;    // 产品介绍    private String introduce;    // 交易员ID    private String dealerId;    // 产品类型（大类可分为用户投资类和用户充值类）    private int productTypeId;    // 投资状态ID    private int operStateId;    // 每一个投资状态的时间是否都已设置    private int isOperIntervalSetUp;    // 产品金额    private double projectAmount;    // 可投资金额    private double investableAmount;    // 管理费    private double managementCost;    // 止损值    private double stopLossValue;    // 预期收益率（用作保底收益）    private double expectedYield;    // 交易周期    private int tradingCycle;    // 星级    private int starLevel;    public String getProductId() {        return productId;    }    public void setProductId(String productId) {        this.productId = productId;    }    public String getProductName() {        return productName;    }    public void setProductName(String productName) {        this.productName = productName;    }    public String getIntroduce() {        return introduce;    }    public void setIntroduce(String introduce) {        this.introduce = introduce;    }    public String getDealerId() {        return dealerId;    }    public void setDealerId(String dealerId) {        this.dealerId = dealerId;    }    public int getProductTypeId() {        return productTypeId;    }    public void setProductTypeId(int productTypeId) {        this.productTypeId = productTypeId;    }    public int getOperStateId() {        return operStateId;    }    public void setOperStateId(int operStateId) {        this.operStateId = operStateId;    }    public int getIsOperIntervalSetUp() {        return isOperIntervalSetUp;    }    public void setIsOperIntervalSetUp(int isOperIntervalSetUp) {        this.isOperIntervalSetUp = isOperIntervalSetUp;    }    public double getProjectAmount() {        return projectAmount;    }    public void setProjectAmount(double projectAmount) {        this.projectAmount = projectAmount;    }    public double getInvestableAmount() {        return investableAmount;    }    public void setInvestableAmount(double investableAmount) {        this.investableAmount = investableAmount;    }    public double getManagementCost() {        return managementCost;    }    public void setManagementCost(double managementCost) {        this.managementCost = managementCost;    }    public double getStopLossValue() {        return stopLossValue;    }    public void setStopLossValue(double stopLossValue) {        this.stopLossValue = stopLossValue;    }    public double getExpectedYield() {        return expectedYield;    }    public void setExpectedYield(double expectedYield) {        this.expectedYield = expectedYield;    }    public int getTradingCycle() {        return tradingCycle;    }    public void setTradingCycle(int tradingCycle) {        this.tradingCycle = tradingCycle;    }    public int getStarLevel() {        return starLevel;    }    public void setStarLevel(int starLevel) {        this.starLevel = starLevel;    }}