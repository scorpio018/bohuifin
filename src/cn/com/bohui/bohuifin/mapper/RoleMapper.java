package cn.com.bohui.bohuifin.mapper;/** * 表名：t_role */import javax.annotation.Resource;import org.springframework.stereotype.Repository;import java.util.List;import java.util.ArrayList;import cn.com.bohui.bohuifin.bean.Page;import cn.com.bohui.bohuifin.bean.RoleBean;@Repositorypublic interface RoleMapper {	public void saveRole(RoleBean roleBean) throws Exception;	public void updateRole(RoleBean roleBean) throws Exception;	public List<RoleBean> listRoleByPage(Page<RoleBean> page) throws Exception;	public void removeRoleById(RoleBean roleBean) throws Exception;}