package cn.com.bohui.bohuifin.bean;/** * 表名：t_dealer */import java.io.Serializable;public class DealerBean extends BaseUserBean implements        Serializable {    /**     *     */    private static final long serialVersionUID = 1L;    // 交易员ID    private String dealerId;    // 交易员用户名    private String dealerName;    // 交易员真实姓名    private String trueName;    // 交易员昵称    private String nickName;    // 头像    private String headImg;    // 部门ID    private long deptId;    // 权限组ID    private int authorityGroupId;    // 交易员简介    private String introduce;    // 整体盈亏（可后台配置，也可设计那个后台生成）    private double overallProfitAndLoss;    // 平均盈亏比    private double avgProfitRatio;    public String getDealerId() {        return dealerId;    }    public void setDealerId(String dealerId) {        this.dealerId = dealerId;    }    public String getDealerName() {        return dealerName;    }    public void setDealerName(String dealerName) {        this.dealerName = dealerName;    }    public String getTrueName() {        return trueName;    }    public void setTrueName(String trueName) {        this.trueName = trueName;    }    public String getNickName() {        return nickName;    }    public void setNickName(String nickName) {        this.nickName = nickName;    }    public String getHeadImg() {        return headImg;    }    public void setHeadImg(String headImg) {        this.headImg = headImg;    }    public long getDeptId() {        return deptId;    }    public void setDeptId(long deptId) {        this.deptId = deptId;    }    public int getAuthorityGroupId() {        return authorityGroupId;    }    public void setAuthorityGroupId(int authorityGroupId) {        this.authorityGroupId = authorityGroupId;    }    public String getIntroduce() {        return introduce;    }    public void setIntroduce(String introduce) {        this.introduce = introduce;    }    public double getOverallProfitAndLoss() {        return overallProfitAndLoss;    }    public void setOverallProfitAndLoss(double overallProfitAndLoss) {        this.overallProfitAndLoss = overallProfitAndLoss;    }    public double getAvgProfitRatio() {        return avgProfitRatio;    }    public void setAvgProfitRatio(double avgProfitRatio) {        this.avgProfitRatio = avgProfitRatio;    }}