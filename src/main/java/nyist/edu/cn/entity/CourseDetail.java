package nyist.edu.cn.entity;

import java.util.Date;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="course_detail")
public class CourseDetail {
	
	@Id
    private Integer id;

    private String dname;	//名称

    private String dcontent;	//简介

    private Integer cid;	//课程id

    private String dpic;	//图片URL

    private String dvideo;	//视频URL

    private Date createTime;

    private Date updateTime;

    private String cRank;	//排序

    private Integer views;	//观看次数

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname == null ? null : dname.trim();
    }

    public String getDcontent() {
        return dcontent;
    }

    public void setDcontent(String dcontent) {
        this.dcontent = dcontent == null ? null : dcontent.trim();
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getDpic() {
        return dpic;
    }

    public void setDpic(String dpic) {
        this.dpic = dpic == null ? null : dpic.trim();
    }

    public String getDvideo() {
        return dvideo;
    }

    public void setDvideo(String dvideo) {
        this.dvideo = dvideo == null ? null : dvideo.trim();
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

    public String getcRank() {
        return cRank;
    }

    public void setcRank(String cRank) {
        this.cRank = cRank == null ? null : cRank.trim();
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }
}