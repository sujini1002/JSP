package openProject;

public class memberInfo {
	private String userId;
	private String userPw;
	private String userName;
	private String userImg;
	
	public memberInfo() {}
	public memberInfo(String userId,String userPw,String userName,String userImg){
		this.userId = userId;
		this.userPw = userPw;
		this.userName = userName;
		this.userImg = userImg;
	}
	@Override
	public String toString() {
		return "memberInfo [userId=" + userId + ", userPw=" + userPw + ", userName=" + userName + ", userImg=" + userImg
				+ "]";
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	
	
}
