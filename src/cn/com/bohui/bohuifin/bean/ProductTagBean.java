package cn.com.bohui.bohuifin.bean;/** * 表名：t_product_tag */import java.sql.Timestamp;import java.io.Serializable;public class ProductTagBean extends BaseBean implements		Serializable {	/**	 *	 */	private static final long serialVersionUID = 1L;	private int tagId;	// 标签名	private String tagName;	public int getTagId() {		return tagId;	}	public void setTagId(int tagId) {		this.tagId = tagId;	}	public String getTagName() {		return tagName;	}	public void setTagName(String tagName) {		this.tagName = tagName;	}}