package nyist.edu.cn.entity;

import javax.persistence.Id;
import javax.persistence.Table;
/**
 * <p>类功能描述:产品中心，技术参数 附表 </p>
 * <p>类名：CpzxJscs </p>
 * <p>创建时间：2019-8-9 下午6:20:25 </p>
 * <p>@author：mmy</p>
 */
@Table(name="cpzx_jscs")
public class CpzxJscs {
	
	@Id
    private Integer jscsId;
	
    private String project;

    private String company;

    private String described;

    private Integer cpzxId;
    
    public Integer getCpzxId() {
		return cpzxId;
	}

	public void setCpzxId(Integer cpzxId) {
		this.cpzxId = cpzxId;
	}

	public Integer getJscsId() {
		return jscsId;
	}

	public void setJscsId(Integer jscsId) {
		this.jscsId = jscsId;
	}

	public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project == null ? null : project.trim();
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company == null ? null : company.trim();
    }

	public String getDescribed() {
		return described;
	}

	public void setDescribed(String described) {
		this.described = described;
	}

}