package nyist.edu.cn.entity;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * <p>类功能描述:产品中心，作业视频  附表 </p>
 * <p>类名：CpzxJscs </p>
 * <p>创建时间：2019-8-9 下午6:20:25 </p>
 * <p>@author：mmy</p>
 */
@Table(name="cpzx_video")
public class CpzxVideo {
	
	@Id
    private Integer videoId;

    private String video;

    private Integer cpzxId;
    
    private String videoOldName;
    
    public String getVideoOldName() {
		return videoOldName;
	}

	public void setVideoOldName(String videoOldName) {
		this.videoOldName = videoOldName;
	}

	public Integer getCpzxId() {
		return cpzxId;
	}

	public void setCpzxId(Integer cpzxId) {
		this.cpzxId = cpzxId;
	}
	
	public Integer getVideoId() {
		return videoId;
	}

	public void setVideoId(Integer videoId) {
		this.videoId = videoId;
	}

	public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video == null ? null : video.trim();
    }
}