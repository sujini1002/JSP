package member;

import java.util.Date;

public class MemberInfo {
	
	private String id;
	private String name;
	private String password;
	private String address;
	private String email;
	private Date   regDate;
	
	public MemberInfo() {
		
	}

	public MemberInfo(String id, String name, String password, String address, String email, Date regDate) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.address = address;
		this.email = email;
		this.regDate = regDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberInfo [id=" + id + ", name=" + name + ", password=" + password + ", address=" + address
				+ ", email=" + email + ", regDate=" + regDate + "]";
	}
	
	
}
