package cn.com.bohui.bohuifin.service.oper_state;/** * 表名：t_oper_state */import javax.annotation.Resource;import cn.com.bohui.bohuifin.consts.SystemConst;import org.springframework.stereotype.Service;import cn.com.bohui.bohuifin.mapper.OperStateMapper;import java.util.HashMap;import java.util.List;import java.util.ArrayList;import java.util.Map;import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.OperStateBean;@Servicepublic class OperStateService {    @Resource    private OperStateMapper operStateMapper;    public void saveOperState(OperStateBean operStateBean) throws Exception {        operStateMapper.saveOperState(operStateBean);    }    public void updateOperState(OperStateBean operStateBean) throws Exception {        operStateMapper.updateOperState(operStateBean);    }    public List<OperStateBean> listOperStateByPage(Page<OperStateBean> page) throws Exception {        return operStateMapper.listOperStateByPage(page);    }    public List<OperStateBean> listAllOperState(Map<String, Object> params) throws Exception {        return operStateMapper.listAllOperState(params);    }    public List<OperStateBean> listAllOperStateRefProduct(Map<String, Object> params) throws Exception {        return operStateMapper.listAllOperStateRefProduct(params);    }    public OperStateBean findFirstOperState() throws Exception {        Map<String, Object> params = new HashMap<>();        params.put("state", SystemConst.STATE_DEFAULT);        return operStateMapper.findFirstOperState(params);    }    public void removeOperStateById(OperStateBean operStateBean) throws Exception {        operStateMapper.removeOperStateById(operStateBean);    }}