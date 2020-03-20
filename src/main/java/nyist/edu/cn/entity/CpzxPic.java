package nyist.edu.cn.entity;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * <p>类功能描述:产品中心，产品图片 附表 </p>
 * <p>类名：CpzxJscs </p>
 * <p>创建时间：2019-8-9 下午6:20:25 </p>
 * <p>@author：mmy</p>
 */
@Table(name="cpzx_pic")
public class CpzxPic {
	
	@Id
    private Integer picId;

    private String pic;

    private Integer cpzxId;
    
    private String picOldName;
    
    public String getPicOldName() {
		return picOldName;
	}

	public void setPicOldName(String picOldName) {
		this.picOldName = picOldName;
	}

	public Integer getCpzxId() {
		return cpzxId;
	}

	public void setCpzxId(Integer cpzxId) {
		this.cpzxId = cpzxId;
	}

    public Integer getPicId() {
		return picId;
	}

	public void setPicId(Integer picId) {
		this.picId = picId;
	}

	public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }
}