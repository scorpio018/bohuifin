package cn.com.bohui.bohuifin.mapper;/** * 表名：t_product_income_record */import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.ProductIncomeRecordBean;import org.springframework.stereotype.Repository;import java.util.List;@Repositorypublic interface ProductIncomeRecordMapper {    public void saveProductIncomeRecord(ProductIncomeRecordBean productIncomeRecordBean) throws Exception;    public void updateProductIncomeRecord(ProductIncomeRecordBean productIncomeRecordBean) throws Exception;    public List<ProductIncomeRecordBean> listProductIncomeRecordByPage(Page<ProductIncomeRecordBean> page) throws Exception;    public List<ProductIncomeRecordBean> listProductIncomeRecordByProductId(ProductIncomeRecordBean productIncomeRecordBean) throws Exception;    public ProductIncomeRecordBean findProductIncomeByProductIdAndIncomeTime(ProductIncomeRecordBean productIncomeRecordBean) throws Exception;    public void removeProductIncomeRecordById(ProductIncomeRecordBean productIncomeRecordBean) throws Exception;}