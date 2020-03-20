package nyist.edu.cn.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="node")
public class Node {
	@Id
    private Integer id;

    private String name;   //名字

    private String url;		//url

    private String part;    //父节点name，顶级节点和自己本身相同
    
    private Date createTime;

    private Date updateTime;

    private String icon;   //图标
    
    private Integer parentId;   //父节点id   顶级节点是0
    
    private List<Node> childrenList;   //子节点集合

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getPart() {
        return part;
    }

    public void setPart(String part) {
        this.part = part == null ? null : part.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public List<Node> getChildrenList() {
		return childrenList;
	}

	public void setChildrenList(List<Node> childrenList) {
		this.childrenList = childrenList;
	}
	
}