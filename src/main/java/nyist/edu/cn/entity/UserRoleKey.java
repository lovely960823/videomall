package nyist.edu.cn.entity;

import javax.persistence.Table;

@Table(name="user_role")
public class UserRoleKey {
    private Integer uId;

    private String rId;

	public Integer getuId() {
		return uId;
	}

	public void setuId(Integer uId) {
		this.uId = uId;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

    
}