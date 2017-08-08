package cn.com.bohui.bohuifin.controller.product;

import cn.com.bohui.bohuifin.bean.ProductBean;
import cn.com.bohui.bohuifin.bean.ProductIncomeRecordBean;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.JsonCodeConst;
import cn.com.bohui.bohuifin.consts.SeqConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.product_income_record.ProductIncomeRecordService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.util.LogicUtil;
import cn.com.bohui.bohuifin.util.TimeUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * Created by scorpioyoung on 2017/8/1 0001.
 */
@Controller
public class ProductIncomeRecordController {

    @Resource
    private ProductIncomeRecordService productIncomeRecordService;

    @Resource
    private ProductService productService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @RequestMapping(value = "/admin/productIncomeRecord/addIncomeBegin")
    public String addIncomeBegin(HttpServletRequest request, HttpServletResponse response, String productId) throws Exception {
        List<ProductIncomeRecordBean> allIncomeBean = productIncomeRecordService.getAllIncomeBean(productId);
        if (allIncomeBean != null) {
            request.setAttribute("productIncomeRecords", allIncomeBean);
        }
        request.setAttribute("productId", productId);
        return "WEB-INF/product/addIncome";
    }

    @RequestMapping(value = "/admin/productIncomeRecord/saveIncome", method = RequestMethod.POST)
    @ResponseBody
    public String saveIncome(HttpServletRequest request, HttpServletResponse response, String productId, long time, double income) throws Exception {
        ProductBean productBean = cacheUtils.getProductCache().getObject(productId);
        if (productBean == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_PRODUCT, null, ErrorMsgConst.NO_PRODUCT);
        }
        ProductIncomeRecordBean incomeBean = productIncomeRecordService.getIncomeBean(productId, time);
        if (incomeBean != null) {
            incomeBean.setIncome(income);
            LogicUtil.getInstance().saveParamsBeforeUpdate(incomeBean, request);
            productIncomeRecordService.updateProductIncomeRecord(incomeBean);
        } else {
            incomeBean = new ProductIncomeRecordBean();
            incomeBean.setRecordId(sequencesService.haveSeq(SeqConst.SEQ_PRODUCT_INCOME_RECORD).intValue());
            incomeBean.setProductId(productId);
            incomeBean.setIncome(income);
            String curDayStr = TimeUtil.getStrYMD(new Date(time));
            Date dateYMD = TimeUtil.getDateYMD(curDayStr);
            Timestamp incomeTime = new Timestamp(dateYMD.getTime());
            incomeBean.setIncomeTime(incomeTime);
            LogicUtil.getInstance().saveParamsBeforeInsert(incomeBean, request);
            productIncomeRecordService.saveProductIncomeRecord(incomeBean);
        }
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, null, null);
    }

    @RequestMapping(value = "/admin/productIncomeRecord/removeIncome", method = RequestMethod.POST)
    @ResponseBody
    public String removeIncome(HttpServletRequest request, HttpServletResponse response, String productId, long time) throws Exception {
        ProductBean productBean = cacheUtils.getProductCache().getObject(productId);
        if (productBean == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_PRODUCT, null, ErrorMsgConst.NO_PRODUCT);
        }
        ProductIncomeRecordBean incomeBean = productIncomeRecordService.getIncomeBean(productId, time);
        if (incomeBean == null) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_INCOME, null, ErrorMsgConst.NO_INCOME);
        }
        incomeBean.setState(SystemConst.STATE_DELETE);
        productIncomeRecordService.removeProductIncomeRecordById(incomeBean);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, null, null);
    }
}
