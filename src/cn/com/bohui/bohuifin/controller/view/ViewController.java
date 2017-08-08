package cn.com.bohui.bohuifin.controller.view;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.vo.ProductVo;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.util.StaticUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by scorpioyoung on 2017/8/7 0007.
 */
@Controller
@RequestMapping(value = "/view")
public class ViewController {

    @Resource
    private ProductService productService;

    @Resource
    private StaticUtil staticUtil;

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<ProductVo> productVos = staticUtil.getProductVo();
        List<DealerBean> dealerBeans = staticUtil.getDealerBeans();
        request.setAttribute("products", productVos);
        request.setAttribute("dealers", dealerBeans);
        return "WEB-INF/view/index";
    }

}
