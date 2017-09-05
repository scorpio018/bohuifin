package cn.com.bohui.bohuifin.controller.product;

import cn.com.bohui.bohuifin.bean.*;
import cn.com.bohui.bohuifin.bean.vo.ProductVo;
import cn.com.bohui.bohuifin.common.CacheUtils;
import cn.com.bohui.bohuifin.common.Tools;
import cn.com.bohui.bohuifin.consts.*;
import cn.com.bohui.bohuifin.enums.EnumOperState;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.oper_state.OperStateService;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.product_tag.ProductTagService;
import cn.com.bohui.bohuifin.service.product_type.ProductTypeService;
import cn.com.bohui.bohuifin.service.sequences.SequencesService;
import cn.com.bohui.bohuifin.service.user_product_amount.UserProductAmountService;
import cn.com.bohui.bohuifin.util.JsonUtil;
import cn.com.bohui.bohuifin.util.LogicUtil;
import cn.com.bohui.bohuifin.util.StaticUtil;
import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.util.zz.StringUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yangyang on 2017/6/30 0030.
 */
@Controller
public class ProductController {

    @Resource
    private ProductService productService;

    @Resource
    private DealerService dealerService;

    @Resource
    private ProductTypeService productTypeService;

    @Resource
    private OperStateService operStateService;

    @Resource
    private ProductTagService productTagService;

    @Resource
    private UserProductAmountService userProductAmountService;

    @Resource
    private SequencesService sequencesService;

    @Resource
    private CacheUtils cacheUtils;

    @RequestMapping(value = "/admin/products/showProduct")
    public String showProduct(HttpServletRequest request, HttpServletResponse response, ProductVo productVo, Page<ProductVo> page) throws Exception {
        page.setVo(productVo);
        initRefData(request);
        request.setAttribute("page", page);
        return "WEB-INF/product/showProduct";
    }

    @RequestMapping(value = "/admin/products/productData")
    @ResponseBody
    public Page<ProductVo> getProductData(HttpServletRequest request, HttpServletResponse response, ProductVo productVo, Page<ProductVo> page, String tags) throws Exception {
        List<ProductVo> result;
        if (productVo == null) {
            productVo = new ProductVo();
        }
        productVo.setState(SystemConst.STATE_DELETE);
        HttpSession session = request.getSession();
        ManagerBean curLoginManagerBean = LogicUtil.getInstance().getCurLoginManagerBean(session);
        if (curLoginManagerBean == null) {
            DealerBean curLoginDealerBean = LogicUtil.getInstance().getCurLoginDealerBean(session);
            String dealerId = curLoginDealerBean.getDealerId();
            productVo.setDealerId(dealerId);
        }
        page.setVo(productVo);
        if (!StringUtil.isEmpty(productVo.getProductName())) {
            page.getParams().put("productName", "%" + Tools.DLEC(productVo.getProductName()) + "%");
        }
        result = productService.listProductByPage(page);
        page.setResults(result);
        return page;
    }

    @RequestMapping("/admin/products/showAddProduct")
    public String addProductBegin(HttpServletRequest request, HttpServletResponse response, Page<ProductVo> page, ProductVo product, String act) throws Exception {
        initRefData(request);
        if (ParamConst.ACT_ADD.equals(act)) {
            product.setProductId(sequencesService.haveSeq(SeqConst.SEQ_PRODUCT).toString());
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            ProductVo result = productService.findProductById(product.getProductId());
            if (result == null) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.NO_USER);
                return showProduct(request, response, product, page);
            }
            product = result;
            Map<String, Object> params = new HashMap<>();
            params.put("productId", product.getProductId());
            params.put("state", SystemConst.STATE_DEFAULT);
            List<ProductTagBean> productTagBeans = productTagService.listProductTagByProductId(params);
            StringBuffer tagNames = new StringBuffer();
            for (ProductTagBean tagBean : productTagBeans) {
                tagNames.append(tagBean.getTagName() + ",");
            }
            if (tagNames.length() != 0) {
                request.setAttribute("tagNames", tagNames.substring(0, tagNames.length() - 2));
            }
        } else {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.UNKNOWN_ERROR);
            return showProduct(request, response, product, page);
        }
        request.setAttribute("product", product);
        request.setAttribute("act", act);
        return "WEB-INF/product/addProduct";
    }

    @RequestMapping(value = "/admin/products/saveProduct", method = RequestMethod.POST)
    public String saveProduct(HttpServletRequest request, HttpServletResponse response, Page<ProductVo> page, ProductVo product, String act) throws Exception {
        // 去掉管理员名中的前后空格
        product.setProductName(product.getProductName().trim());
        ManagerBean curLoginManagerBean = LogicUtil.getInstance().getCurLoginManagerBean(request.getSession());
        if (curLoginManagerBean == null) {
            DealerBean curLoginDealerBean = LogicUtil.getInstance().getCurLoginDealerBean(request.getSession());
            if (curLoginDealerBean == null) {
                throw new Exception(ErrorMsgConst.NO_AUTH);
            }
            product.setDealerId(curLoginDealerBean.getDealerId());
        }
        boolean isProductExists = productService.checkProductExist(product.getProductId(), product.getProductName());
        if (isProductExists) {
            request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.USER_EXIST);
            return addProductBegin(request, response, page, product, act);
        }
        if (ParamConst.ACT_ADD.equals(act)) {
            product.setProductId(sequencesService.haveSeq(SeqConst.SEQ_PRODUCT).toString());
            product.setIsOperIntervalSetUp(SystemConst.IS_OPER_INTERVAL_SET_UP_NO);
            product.setInvestableAmount(product.getProjectAmount());
            LogicUtil.getInstance().saveParamsBeforeInsert(product, request);
            productService.saveProduct(product, request);
        } else if (ParamConst.ACT_UPDATE.equals(act)) {
            // 在审核通过时不允许修改产品
            ProductBean cacheProductBean = cacheUtils.getProductCache().getObject(product.getProductId());
            if (cacheProductBean.getState() == SystemConst.STATE_PASS) {
                request.setAttribute(ParamConst.ERROR_MSG, ErrorMsgConst.PRODUCT_IS_INVESTING);
                return addProductBegin(request, response, page, product, act);
            }
            double projectAmount = product.getProjectAmount();
            if (projectAmount != 0.0f) {
                double productHasInvestedAmount = userProductAmountService.getProductHasInvestedAmount(product.getProductId());
                product.setInvestableAmount(projectAmount - productHasInvestedAmount);
            }
            product.setState(SystemConst.STATE_DEFAULT);
            product.setOperStateId(EnumOperState.DRAFT_BOX.value());
            LogicUtil.getInstance().saveParamsBeforeUpdate(product, request);
            productService.updateProduct(product, request);
        }
        cacheUtils.getProductCache().refreshCache(product.getProductId());
        return "redirect:" + SystemConst.BASE_PATH + "admin/products/showProduct";
    }

    @RequestMapping(value="/admin/products/beforeDel")
    @ResponseBody
    public String beforeDel(HttpServletRequest request, HttpServletResponse response, String productId) throws Exception {
        String result = productCanDel(productId);
        if (result != null) {
            return result;
        } else {
            return "success";
        }
    }

    /**
     * 删除部门(不分页)
     * @param request
     * @param response
     * @param page
     * @param productVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/admin/products/delProduct")
    public String delProduct(HttpServletRequest request, HttpServletResponse response, Page<ProductVo> page, ProductVo productVo, String[] productIds) throws Exception {
        if (productIds == null) {
            return removeProduct(request, response, page, productVo);
        } else {
            return removeProduct(request, response, page, productVo, productIds);
        }
    }

    @RequestMapping(value = "/admin/products/changeProductState")
    public String changeProductState(HttpServletRequest request, HttpServletResponse response, ProductVo productVo, Page<ProductVo> page) throws Exception {
        String productId = productVo.getProductId();
        boolean isProductExist = productService.checkProductExist(productId);
        if (!isProductExist) {
            throw new Exception(ErrorMsgConst.NO_PRODUCT);
        }
        ProductBean productBean = new ProductBean();
        productBean.setProductId(productId);
        productBean.setState(productVo.getState());
        productService.updateState(productBean);
        cacheUtils.getProductCache().clearCache();
        StaticUtil.clearProductCache();
        return showProduct(request, response, productVo, page);
    }

    @RequestMapping(value = "/admin/products/listProductsByDealer", method = RequestMethod.POST)
    @ResponseBody
    public String listProductsByDealer(HttpServletRequest request, HttpServletResponse response, String dealerId) throws Exception {
        DealerBean dealerBean = dealerService.findDealerById(dealerId);
        if (dealerBean == null || dealerBean.getState() != SystemConst.STATE_DEFAULT) {
            return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_ERROR_NO_DEALER, null, ErrorMsgConst.NO_DEALER);
        }
        Map<String, Object> params = new HashMap<>();
        params.put("dealerId", dealerId);
        params.put("state", SystemConst.STATE_PASS);
        List<ProductVo> productVos = productService.listAllProducts4View(params);
        JsonObject jsonObject = JsonUtil.saveObjectToJson(productVos);
        return LogicUtil.getInstance().initResultJson(JsonCodeConst.CODE_SUCCESS, jsonObject.toString(), null);
    }

    private void initRefData(HttpServletRequest request) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("state", SystemConst.STATE_DEFAULT);
        ManagerBean curLoginManagerBean = LogicUtil.getInstance().getCurLoginManagerBean(request.getSession());
        // 只有管理员可以进行操作员筛选
        if (curLoginManagerBean != null) {
            List<DealerBean> dealerBeans = dealerService.listAllDealers(params);
            request.setAttribute("dealers", dealerBeans);
        }
        List<ProductTypeBean> productTypeBeans = productTypeService.listAllProducts(params);
        request.setAttribute("productTypes", productTypeBeans);
        OperStateBean firstOperStateBean = operStateService.findFirstOperState();
        request.setAttribute("firstOperStateBean", firstOperStateBean);
    }

    /**
     * 检查部门是否可以被删除
     * @param productId
     * @throws Exception
     */
    private String productCanDel(String productId) throws Exception {
        ProductBean result = cacheUtils.getProductCache().getObject(productId);
        if (result == null || result.getState() != SystemConst.STATE_DEFAULT) {
            return ErrorMsgConst.NO_USER;
        }
        return null;
    }

    private String removeProduct(HttpServletRequest request, HttpServletResponse response, Page<ProductVo> page, ProductVo productVo) throws Exception {
        String result = beforeDel(request, response, productVo.getProductId());
        if (result.equals("success")) {
//			deptAttrService.delDeptAttrByDeptId(deptVo.getDeptId());
            productVo.setState(SystemConst.STATE_DELETE);
            LogicUtil.getInstance().saveParamsBeforeDelete(productVo, request);
            productService.removeProductById(productVo);
            cacheUtils.getProductCache().refreshCache(productVo.getProductId());
            return showProduct(request, response, productVo, page);
        } else {
            request.setAttribute("errorCode", result);
            return showProduct(request, response, productVo, page);
        }
    }

    private String removeProduct(HttpServletRequest request, HttpServletResponse response, Page<ProductVo> page, ProductVo productVo, String[] productIds) throws Exception {
        for (String productId : productIds) {
            String result = beforeDel(request, response, productId);
            if (!result.equals("success")) {
                request.setAttribute("errorCode", result);
                return showProduct(request, response, productVo, page);
            }
        }
        LogicUtil.getInstance().saveParamsBeforeDelete(productVo, request);
        productVo.setProductIds(productIds);
        productService.removeProductsById(productVo);
        for (String productId : productIds) {
            cacheUtils.getProductCache().refreshCache(productId);
        }
        return showProduct(request, response, productVo, page);
    }

}
