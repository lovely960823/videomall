package nyist.edu.cn.entity;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="teacher")
public class Teacher {
	@Id
    private Integer id;

    private String name;

    private String tPic;

    private String tContent;

    private String tZc;

    private String tJy;

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

    public String gettPic() {
        return tPic;
    }

    public void settPic(String tPic) {
        this.tPic = tPic == null ? null : tPic.trim();
    }

    public String gettContent() {
        return tContent;
    }

    public void settContent(String tContent) {
        this.tContent = tContent == null ? null : tContent.trim();
    }

    public String gettZc() {
        return tZc;
    }

    public void settZc(String tZc) {
        this.tZc = tZc == null ? null : tZc.trim();
    }

    public String gettJy() {
        return tJy;
    }

    public void settJy(String tJy) {
        this.tJy = tJy == null ? null : tJy.trim();
    }
}