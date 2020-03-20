package nyist.edu.cn.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="course")
public class Course {
	
	@Id
    private Integer id;

    private String name;	//名称

    private String content;	//简介

    private String pic;	//图片URL

    private Integer parentId;	//父节点id

    private Date createTime;

    private Date updateTime;

    private String difficulty;	//难度等级

    private String cRank;	//排序

    private Integer views;	//观看次数

    private String tId;		//老师id

    private BigDecimal price;	//价格

    private BigDecimal discountPrice;	//折扣价

    private String duration;	//时长
    
    private List<CourseDetail> detailList;
    
    private Teacher teacher;//关联教师

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
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

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty == null ? null : difficulty.trim();
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

    public String gettId() {
        return tId;
    }

    public void settId(String tId) {
        this.tId = tId == null ? null : tId.trim();
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(BigDecimal discountPrice) {
        this.discountPrice = discountPrice;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration == null ? null : duration.trim();
    }

	public List<CourseDetail> getDetailList() {
		return detailList;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public void setDetailList(List<CourseDetail> detailList) {
		this.detailList = detailList;
	}
}