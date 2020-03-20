package nyist.edu.cn.entity;

import javax.persistence.Table;

@Table(name="role_node")
public class RoleNodeKey {
    private String rId;

    private Integer nId;

    public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public Integer getnId() {
        return nId;
    }

    public void setnId(Integer nId) {
        this.nId = nId;
    }
}