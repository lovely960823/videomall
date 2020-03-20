package nyist.edu.cn.entity;

import java.io.Serializable;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * <p>类功能描述:产品中心 </p>
 * <p>类名：Cpzx </p>
 * <p>创建时间：2019-8-9 下午4:17:40 </p>
 * <p>@author：mmy</p>
 */
@Table(name="cpzx")
public class Cpzx implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1774025607320274695L;

	@Id
	private Integer id;
	
	private Integer parentId;
	
	private String name;
	
	private String cptd;   //产品特点
	
	private String cpPic;    //产品配图路径

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCptd() {
		return cptd;
	}

	public void setCptd(String cptd) {
		this.cptd = cptd;
	}

	public String getCpPic() {
		return cpPic;
	}

	public void setCpPic(String cpPic) {
		this.cpPic = cpPic;
	}
	
	
}
