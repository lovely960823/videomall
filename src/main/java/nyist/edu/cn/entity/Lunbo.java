package nyist.edu.cn.entity;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="lunbo")
public class Lunbo {

	@Id
	private Integer id;
	
	private String img;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
}
