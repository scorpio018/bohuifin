package cn.com.bohui.bohuifin.service.product_income_record;/** * 表名：t_product_income_record */import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.ProductIncomeRecordBean;import cn.com.bohui.bohuifin.common.CacheUtils;import cn.com.bohui.bohuifin.consts.SystemConst;import cn.com.bohui.bohuifin.mapper.ProductIncomeRecordMapper;import cn.com.bohui.bohuifin.service.user_product_income_record.UserProductIncomeRecordService;import cn.com.bohui.bohuifin.util.TimeUtil;import org.springframework.stereotype.Service;import javax.annotation.Resource;import javax.servlet.http.HttpServletRequest;import java.sql.Timestamp;import java.util.Date;import java.util.List;@Servicepublic class ProductIncomeRecordService {    @Resource    private ProductIncomeRecordMapper productIncomeRecordMapper;    @Resource    private UserProductIncomeRecordService userProductIncomeRecordService;    @Resource    private CacheUtils cacheUtils;    public void saveProductIncomeRecord(ProductIncomeRecordBean productIncomeRecordBean, HttpServletRequest request) throws Exception {        productIncomeRecordMapper.saveProductIncomeRecord(productIncomeRecordBean);        userProductIncomeRecordService.saveUserProductIncomeRecordByProductId(productIncomeRecordBean.getProductId(), productIncomeRecordBean.getIncome(), request);    }    public void updateProductIncomeRecord(ProductIncomeRecordBean productIncomeRecordBean) throws Exception {        productIncomeRecordMapper.updateProductIncomeRecord(productIncomeRecordBean);    }    public List<ProductIncomeRecordBean> listProductIncomeRecordByPage(Page<ProductIncomeRecordBean> page) throws Exception {        return productIncomeRecordMapper.listProductIncomeRecordByPage(page);    }    public List<ProductIncomeRecordBean> listProductIncomeRecordByProductId(ProductIncomeRecordBean productIncomeRecordBean) throws Exception {        return productIncomeRecordMapper.listProductIncomeRecordByProductId(productIncomeRecordBean);    }    public ProductIncomeRecordBean findProductIncomeByProductIdAndIncomeTime(ProductIncomeRecordBean productIncomeRecordBean) throws Exception {        return productIncomeRecordMapper.findProductIncomeByProductIdAndIncomeTime(productIncomeRecordBean);    }    public void removeProductIncomeRecordById(ProductIncomeRecordBean productIncomeRecordBean) throws Exception {        productIncomeRecordMapper.removeProductIncomeRecordById(productIncomeRecordBean);    }    /**     * 检查是否有当天     * @param productId     * @return     * @throws Exception     */    public boolean checkHasCurDayIncome(String productId) throws Exception {        ProductIncomeRecordBean curDayIncomeBean = getCurDayIncomeBean(productId);        if (curDayIncomeBean == null) {            return false;        } else {            return true;        }    }    public List<ProductIncomeRecordBean> getAllIncomeBean(String productId) throws Exception {        ProductIncomeRecordBean productIncomeRecordBean = new ProductIncomeRecordBean();        productIncomeRecordBean.setProductId(productId);        productIncomeRecordBean.setState(SystemConst.STATE_DEFAULT);        return listProductIncomeRecordByProductId(productIncomeRecordBean);    }    /**     * 获取产品当天的收入bean     * @param productId     * @return     * @throws Exception     */    public ProductIncomeRecordBean getCurDayIncomeBean(String productId) throws Exception {        return getIncomeBean(productId, new Date().getTime());    }    /**     * 获取产品对应日期的收入bean     * @param productId     * @param time     * @return     * @throws Exception     */    public ProductIncomeRecordBean getIncomeBean(String productId, long time) throws Exception {        String curDayStr = TimeUtil.getStrYMD(new Date(time));        Date dateYMD = TimeUtil.getDateYMD(curDayStr);        Timestamp incomeTime = new Timestamp(dateYMD.getTime());        ProductIncomeRecordBean productIncomeRecordBean = new ProductIncomeRecordBean();        productIncomeRecordBean.setProductId(productId);        productIncomeRecordBean.setIncomeTime(incomeTime);        productIncomeRecordBean.setState(SystemConst.STATE_DEFAULT);        return cacheUtils.getProductIncomeRecordBeanCache().getObject(productIncomeRecordBean);    }}