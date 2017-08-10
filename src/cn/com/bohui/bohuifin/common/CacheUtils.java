package cn.com.bohui.bohuifin.common;

import cn.com.bohui.bohuifin.bean.*;
import cn.com.bohui.bohuifin.bean.vo.ProductVo;
import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.service.dealer.DealerService;
import cn.com.bohui.bohuifin.service.dealer_talk.DealerTalkService;
import cn.com.bohui.bohuifin.service.manager.ManagerService;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.product_income_record.ProductIncomeRecordService;
import cn.com.bohui.bohuifin.service.users.UsersService;
import cn.com.enorth.utility.cache.ICache;
import cn.com.enorth.utility.cache.ObjectBuilder;
import cn.com.enorth.utility.cache.impl.Cache;
import cn.com.enorth.utility.cache.impl.CacheCenter;
import cn.com.enorth.utility.cache.impl.LRUCache;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class CacheUtils {

    private static ICache<String, UsersBean> userCache = null;

    private static ICache<String, DealerBean> dealerCache = null;

    private static ICache<String, ManagerBean> managerCache = null;

    private static ICache<String, ProductBean> productCache = null;

    private static ICache<ProductIncomeRecordBean, ProductIncomeRecordBean> productIncomeRecordBeanICache = null;

    private static ICache<Integer, DealerTalkBean> dealerTalkBeanICache = null;

    private static ICache<String, List<ProductVo>> dealerProductBeansICache = null;

    @Resource
    private UsersService usersService;

    @Resource
    private DealerService dealerService;

    @Resource
    private ManagerService managerService;

    @Resource
    private ProductService productService;

    @Resource
    private ProductIncomeRecordService productIncomeRecordService;

    @Resource
    private DealerTalkService dealerTalkService;

    private static CacheCenter center = new CacheCenter();

    /**
     * 清空所有缓存
     */
    public static void clearAllCache() {
        center.clearAll();
    }

    /**
     * 返回UserBean缓存
     *
     * @return
     */
    public ICache<String, UsersBean> getUserCache() {
        if (userCache == null) {
            LRUCache<String, UsersBean> c = new LRUCache<String, UsersBean>();
            c.setMaxSize(1000);
            userCache = new Cache<>(c);
            userCache.setObjectBuilder(new ObjectBuilder<String, UsersBean>() {

                @Override
                public UsersBean build(String userId) throws Exception {
                    return usersService.findUserById(userId);
                }
            });

            center.registerCache("userCache", userCache);
        }
        return userCache;
    }

    /**
     * 返回DealerBean缓存
     *
     * @return
     */
    public ICache<String, DealerBean> getDealerCache() {
        if (dealerCache == null) {
            LRUCache<String, DealerBean> c = new LRUCache<>();
            c.setMaxSize(1000);
            dealerCache = new Cache<String, DealerBean>(c);
            dealerCache.setObjectBuilder(new ObjectBuilder<String, DealerBean>() {

                @Override
                public DealerBean build(String userId) throws Exception {
                    return dealerService.findDealerById(userId);
                }
            });

            center.registerCache("dealerCache", dealerCache);
        }
        return dealerCache;
    }

    /**
     * 返回ManagerBean缓存
     *
     * @return
     */
    public ICache<String, ManagerBean> getManagerCache() {
        if (managerCache == null) {
            LRUCache<String, ManagerBean> c = new LRUCache<>();
            c.setMaxSize(1000);
            managerCache = new Cache<String, ManagerBean>(c);
            managerCache.setObjectBuilder(new ObjectBuilder<String, ManagerBean>() {

                @Override
                public ManagerBean build(String userId) throws Exception {
                    return managerService.findManagerById(userId);
                }
            });

            center.registerCache("managerCache", managerCache);
        }
        return managerCache;
    }

    /**
     * 返回ProductBean缓存
     *
     * @return
     */
    public ICache<String, ProductBean> getProductCache() {
        if (productCache == null) {
            LRUCache<String, ProductBean> c = new LRUCache<>();
            c.setMaxSize(1000);
            productCache = new Cache<String, ProductBean>(c);
            productCache.setObjectBuilder(new ObjectBuilder<String, ProductBean>() {

                @Override
                public ProductBean build(String productId) throws Exception {
                    return productService.findProductById(productId);
                }
            });

            center.registerCache("productCache", productCache);
        }
        return productCache;
    }

    /**
     * 返回ProductIncomeRecordBean缓存
     *
     * @return
     */
    public ICache<ProductIncomeRecordBean, ProductIncomeRecordBean> getProductIncomeRecordBeanCache() {
        if (productIncomeRecordBeanICache == null) {
            LRUCache<ProductIncomeRecordBean, ProductIncomeRecordBean> c = new LRUCache<>();
            c.setMaxSize(1000);
            productIncomeRecordBeanICache = new Cache<>(c);
            productIncomeRecordBeanICache.setObjectBuilder(new ObjectBuilder<ProductIncomeRecordBean, ProductIncomeRecordBean>() {

                @Override
                public ProductIncomeRecordBean build(ProductIncomeRecordBean productIncomeRecordBean) throws Exception {
                    return productIncomeRecordService.findProductIncomeByProductIdAndIncomeTime(productIncomeRecordBean);
                }
            });

            center.registerCache("productIncomeRecordBeanCache", productIncomeRecordBeanICache);
        }
        return productIncomeRecordBeanICache;
    }

    /**
     * 返回DealerTalkBean缓存
     *
     * @return
     */
    public ICache<Integer, DealerTalkBean> getDealerTalkBeanCache() {
        if (dealerTalkBeanICache == null) {
            LRUCache<Integer, DealerTalkBean> c = new LRUCache<>();
            c.setMaxSize(1000);
            dealerTalkBeanICache = new Cache<Integer, DealerTalkBean>(c);
            dealerTalkBeanICache.setObjectBuilder(new ObjectBuilder<Integer, DealerTalkBean>() {

                @Override
                public DealerTalkBean build(Integer talkId) throws Exception {
                    return dealerTalkService.findDealerTalkById(talkId);
                }
            });

            center.registerCache("dealerTalkBeanICache", dealerTalkBeanICache);
        }
        return dealerTalkBeanICache;
    }

    /**
     * 返回交易员关联的产品集合缓存
     *
     * @return
     */
    public ICache<String, List<ProductVo>> getDealerProductBeansCache() {
        if (dealerProductBeansICache == null) {
            LRUCache<String, List<ProductVo>> c = new LRUCache<>();
            c.setMaxSize(1000);
            dealerProductBeansICache = new Cache<String, List<ProductVo>>(c);
            dealerProductBeansICache.setObjectBuilder(new ObjectBuilder<String, List<ProductVo>>() {

                @Override
                public List<ProductVo> build(String dealerId) throws Exception {
                    Map<String, Object> params = new HashMap<>();
                    params.put("state", SystemConst.STATE_PASS);
                    params.put("dealerId", dealerId);
                    return productService.listAllProducts(params);
                }
            });

            center.registerCache("dealerProductBeansICache", dealerProductBeansICache);
        }
        return dealerProductBeansICache;
    }
}