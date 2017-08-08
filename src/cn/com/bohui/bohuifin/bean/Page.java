package cn.com.bohui.bohuifin.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 对分页的基本数据进行一个简单的封装
 */
public class Page<T> implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 944292730152929064L;
	// 页码，默认是第一页
	private int pageNo = 1;
	// 每页显示的记录数，默认是15
	private int pageSize = 15;
	// 总记录数
	private int totalRecord;
	// 总页数
	private int totalPage;
	// 对应的当前页记录
	private List<T> results;
	// 以对应要取出的名字为key，对应的值为value的Map集合
	private List<Map<String, Object>> resultMaps;
	// 对应的当前vo
	private T vo;
	// 其他的参数我们把它分装成一个Map对象
	private Map<String, Object> params = new HashMap<>();

	private String sidx;

	private String sord;
	
	private List<String> groupBy = new ArrayList<String>();

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		if (pageNo <= 0) {
			pageNo = 1;
		}
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		if (pageSize <= 0) {
			pageSize = 15;
		}
		if (pageSize > 100) {
			pageSize = 100;
		}
		this.pageSize = pageSize;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		// 在设置总页数的时候计算出对应的总页数，在下面的三目运算中加法拥有更高的优先级，所以最后可以不加括号。
		int totalPage = totalRecord % pageSize == 0 ? totalRecord / pageSize
				: totalRecord / pageSize + 1;
		this.setTotalPage(totalPage);
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List<T> getResults() {
		return results;
	}

	public void setResults(List<T> results) {
		this.results = results;
	}

	public List<Map<String, Object>> getResultMaps() {
		return resultMaps;
	}

	public void setResultMaps(List<Map<String, Object>> resultMaps) {
		this.resultMaps = resultMaps;
	}

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	public T getVo() {
		return vo;
	}

	public void setVo(T vo) {
		this.vo = vo;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public List<String> getGroupBy() {
		return groupBy;
	}

	public void setGroupBy(List<String> groupBy) {
		this.groupBy = groupBy;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Page [pageNo=").append(pageNo).append(", pageSize=")
				.append(pageSize).append(", results=").append(results)
				.append(", totalPage=").append(totalPage)
				.append(", totalRecord=").append(totalRecord).append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((params == null) ? 0 : params.hashCode());
		result = prime * result + ((sidx == null) ? 0 : sidx.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Page other = (Page) obj;
		
		if (params == null) {
			if (other.params != null)
				return false;
		} else if (!params.equals(other.params))
			return false;
		
		if(!params.containsKey("deptId")){
			return false;
		}
		if(!other.params.containsKey("deptId")){
			return false;
		}
		if(params.get("deptId").equals(other.params.get("deptId"))){
			return true;
		}
		
		if (sidx == null) {
			if (other.sidx != null)
				return false;
		} else if (!sidx.equals(other.sidx))
			return false;
		return true;
	}
	
	

}