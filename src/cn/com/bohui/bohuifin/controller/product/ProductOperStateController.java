package cn.com.bohui.bohuifin.controller.product;

import cn.com.bohui.bohuifin.bean.ProductOperStateBean;
import cn.com.bohui.bohuifin.consts.ErrorMsgConst;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.enums.EnumOperState;
import cn.com.bohui.bohuifin.service.oper_state.OperStateService;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.product_oper_state.ProductOperStateService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by scorpioyoung on 2017/7/26 0026.
 */
@Controller
public class ProductOperStateController {

    @Resource
    private OperStateService operStateService;

    @Resource
    private ProductService productService;

    @Resource
    private ProductOperStateService productOperStateService;

    @RequestMapping(value = "/admin/product_oper_state/showAddOperState")
    public String showAddOperState(HttpServletRequest request, HttpServletResponse response, String productId) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("productId", productId);
        params.put("state", SystemConst.STATE_DEFAULT);
        EnumOperState[] values = EnumOperState.values();
        for (EnumOperState value : values) {
            if (value == EnumOperState.DRAFT_BOX) {
                continue;
            }
            params.put("operStateId", value.value());
            ProductOperStateBean resultBean = productOperStateService.findProductOperStateByProductAndOperState(params);
            if (resultBean != null) {
                request.setAttribute(value.toString(), resultBean.getOperStateStartTime());
            }
        }
        request.setAttribute("productId", productId);
        return "WEB-INF/product/addOperState";
    }


    @RequestMapping(value = "/admin/product_oper_state/saveOperState", method = RequestMethod.POST)
    public String saveOperState(HttpServletRequest request, HttpServletResponse response, String productId, String[] operStateStartTime) throws Exception {
        boolean isProductExist = productService.checkProductExist(productId);
        if (!isProductExist) {
            throw new Exception(ErrorMsgConst.NO_PRODUCT);
        }
        productOperStateService.saveProductOperState(productId, operStateStartTime, request);
        return "redirect:" + SystemConst.BASE_PATH + "admin/products/showProduct";
    }
}
