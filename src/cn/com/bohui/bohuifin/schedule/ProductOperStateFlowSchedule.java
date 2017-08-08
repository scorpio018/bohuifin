package cn.com.bohui.bohuifin.schedule;

import cn.com.bohui.bohuifin.consts.SystemConst;
import cn.com.bohui.bohuifin.service.product.ProductService;
import cn.com.bohui.bohuifin.service.product_oper_state.ProductOperStateService;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by scorpioyoung on 2017/7/28 0028.
 */
@Component
@EnableScheduling
public class ProductOperStateFlowSchedule/* implements SchedulingConfigurer*/ {

    private static ScheduledTaskRegistrar taskRegistrar;

    @Resource
    private ProductService productService;

    @Resource
    private ProductOperStateService productOperStateService;

    /*@Override
    public void configureTasks(ScheduledTaskRegistrar scheduledTaskRegistrar) {
        ProductOperStateFlowSchedule.taskRegistrar = scheduledTaskRegistrar;
        scheduledTaskRegistrar.addTriggerTask(new Runnable() {
            @Override
            public void run() {

            }
        }, new Trigger() {
            @Override
            public Date nextExecutionTime(TriggerContext triggerContext) {
                return null;
            }
        });
    }*/

//    @Scheduled(cron = "0 0 0 * * ?")
    @Scheduled(initialDelay = 1000, fixedDelay = 10000)
    public void dealProductOperStateSchedule() throws Exception {
        List<String> productIdList = getProductIdList();
        if (productIdList != null && productIdList.size() != 0) {
            for (String productId : productIdList) {
                productService.changeProductOperState(productId);
            }
        }
    }

    /**
     * 获取所有审核通过的产品
     * @return
     * @throws Exception
     */
    private List<String> getProductIdList() throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("state", SystemConst.STATE_PASS);
        return productService.listProductIds(params);
    }

//		@Scheduled(initialDelay = 1000, fixedDelay = 10000)
		/*public void delOfflineMsgPerDay() throws Exception {
			long time = new Date().getTime();
			// long dayTime = 1000 * 60 * 60 * 24;
			long dayTime = 10000;
			String delDate = String.valueOf(time - dayTime);
			int length = delDate.length();
			StringBuffer plusZeroBuf = new StringBuffer();
			for (int i = 15; i > length; i--) {
				plusZeroBuf.append("0");
			}
			delDate = plusZeroBuf.toString() + delDate;
			System.out.println("开始删除creationDate小于" + delDate + "的离线消息");
			ofOfflineMapper.delByDate(delDate);
			ofOfflineMapper.delByDate(delDate);
		}*/

//    private
}
