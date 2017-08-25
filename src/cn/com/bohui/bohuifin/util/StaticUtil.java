package cn.com.bohui.bohuifin.util;

import cn.com.bohui.bohuifin.bean.DealerBean;
import cn.com.bohui.bohuifin.bean.vo.DealerTalkVo;
import cn.com.bohui.bohuifin.bean.vo.ProductVo;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.dealer_talk.DealerTalkService;
import cn.com.bohui.bohuifin.service.product.ProductService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by scorpioyoung on 2017/8/7 0007.
 */
@Component
public class StaticUtil {

    @Resource
    private ProductService productService;

    @Resource
    private DealerService dealerService;

    @Resource
    private DealerTalkService dealerTalkService;

    private static List<ProductVo> productVos;

    private static List<DealerBean> dealerBeans;

    private static List<DealerTalkVo> dealerTalkVos;

    public List<ProductVo> getProductVo() throws Exception {
        if (StaticUtil.productVos == null) {
            Map<String, Object> params = new HashMap<>();
            params.put("state", SystemConst.STATE_PASS);
            List<ProductVo> productVos = productService.listAllProducts4View(params);
            StaticUtil.productVos = productVos;
        }
        return StaticUtil.productVos;
    }

    public List<DealerBean> getDealerBeans() throws Exception {
        if (StaticUtil.dealerBeans == null) {
            Map<String, Object> params = new HashMap<>();
            params.put("state", SystemConst.STATE_DEFAULT);
            List<DealerBean> dealerBeans = dealerService.listAllDealers4View(params);
            StaticUtil.dealerBeans = dealerBeans;
        }
        return StaticUtil.dealerBeans;
    }

    public List<DealerTalkVo> getDealerTalkBeans() throws Exception {
        if (StaticUtil.dealerTalkVos == null) {
            Map<String, Object> params = new HashMap<>();
            params.put("state", SystemConst.STATE_DEFAULT);
            StaticUtil.dealerTalkVos = dealerTalkService.listDealerTalk4View(params);
        }
        return StaticUtil.dealerTalkVos;
    }

    public static void clearProductCache() {
        productVos = null;
    }

    public static void clearDealerCache() {
        dealerBeans = null;
    }

    public static void clearDealerTalkCache() {
        dealerTalkVos = null;
    }
}
