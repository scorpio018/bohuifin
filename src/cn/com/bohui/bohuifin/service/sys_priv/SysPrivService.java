package cn.com.bohui.bohuifin.service.sys_priv;/** * 表名：t_sys_priv */import javax.annotation.Resource;import org.springframework.stereotype.Service;import cn.com.bohui.bohuifin.mapper.SysPrivMapper;import java.util.List;import java.util.ArrayList;import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.SysPrivBean;@Servicepublic class SysPrivService {	@Resource	private SysPrivMapper sysPrivMapper;	public void saveSysPriv(SysPrivBean sysPrivBean) throws Exception {		sysPrivMapper.saveSysPriv(sysPrivBean);	}	public void updateSysPriv(SysPrivBean sysPrivBean) throws Exception {		sysPrivMapper.updateSysPriv(sysPrivBean);	}	public List<SysPrivBean> listSysPrivByPage(Page<SysPrivBean> page) throws Exception {		return sysPrivMapper.listSysPrivByPage(page);	}	public void removeSysPrivById(SysPrivBean sysPrivBean) throws Exception {		sysPrivMapper.removeSysPrivById(sysPrivBean);	}}