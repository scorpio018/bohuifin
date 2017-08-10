package cn.com.bohui.bohuifin.mapper;/** * 表名：t_dealer */import cn.com.bohui.bohuifin.bean.DealerBean;import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.vo.DealerVo;import org.springframework.stereotype.Repository;import java.util.List;import java.util.Map;@Repositorypublic interface DealerMapper {    public void saveDealer(DealerBean dealerBean) throws Exception;    public void updatePwd(DealerBean dealerBean) throws Exception;    public void updateDealer(DealerBean dealerBean) throws Exception;    public List<DealerBean> listDealerByPage(Page<DealerBean> page) throws Exception;    public List<DealerBean> listAllDealers(Map<String, Object> params) throws Exception;    public List<DealerBean> listAllDealers4View(Map<String, Object> params) throws Exception;    public List<DealerVo> listAllDealersJoinProducts(Map<String, Object> params) throws Exception;    public DealerBean findDealerById(String dealerId) throws Exception;    public void removeDealerById(DealerBean dealerBean) throws Exception;    public void removeDealersById(DealerVo dealerVo) throws Exception;    public DealerBean getDealerBean(DealerBean dealerBean) throws Exception;}