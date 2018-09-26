package guest.model;

//데이터 베이스에 있는 데이터를 받아서 처리
//사용자의 요청 데이터를 받아서 처리
public class Message {
	private int id;
	private String guestName;
	private String password;
	private String message;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGuestName() {
		return guestName;
	}

	public void setGuestName(String guestname) {
		this.guestName = guestname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "Message [id=" + id + ", guestname=" + guestName + ", password=" + password + ", message=" + message
				+ "]";
	}
	//비밀번호 일치 여부
	public boolean matchPassword(String pw) {
		return password.equals(pw); //비밀번호 값 만는 지 확인
	}
	public boolean hasPassword() {
		return password !=null && !password.isEmpty();
	}
	
}
//DAO역할 : 데이터 베이스 CRUD 기능
//DAO : 기능만 가진다. 싱글톤 처리(생성자 제한)