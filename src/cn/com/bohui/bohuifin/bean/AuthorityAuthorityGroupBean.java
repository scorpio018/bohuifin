package cn.com.bohui.bohuifin.bean;/** * 表名：t_authority_authority_group */import java.io.Serializable;public class AuthorityAuthorityGroupBean implements 		Serializable {	/**	 *	 */	private static final long serialVersionUID = 1L;	private int authorityId;	private int authorityGroupId;	public int getAuthorityId() {		return authorityId;	}	public void setAuthorityId(int authorityId) {		this.authorityId = authorityId;	}	public int getAuthorityGroupId() {		return authorityGroupId;	}	public void setAuthorityGroupId(int authorityGroupId) {		this.authorityGroupId = authorityGroupId;	}}