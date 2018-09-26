package openProject;

public class loginForm {
	private String userId;
	private String userName;
	private String userImg;
	
	
	public loginForm(String userId, String userName, String userImg) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userImg = userImg;
	}


	public String getUserId() {
		return userId;
	}


	public String getUserName() {
		return userName;
	}


	public String getUserImg() {
		return userImg;
	}


	@Override
	public String toString() {
		return "loginForm [userId=" + userId + ", userName=" + userName + ", userImg=" + userImg + "]";
	}
	
	
	
}
