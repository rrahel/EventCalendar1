package at.fh.swenga.jpa.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.persistence.GenerationType;
import javax.persistence.Version;

@Entity
@Table(name = "UserRole")
public class UserRole implements java.io.Serializable {
	
	private static final long serialVersionUID = 8098173157518993615L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(nullable = false)
	private Integer userRoleID;
	
	
	@ManyToOne(cascade=CascadeType.PERSIST)
	private User user;

	
	@Column(nullable = false, length = 45)
	private String role;
	
	@Version
	long version;

	public UserRole(User user, String role) {
		super();
		this.user = user;
		this.role = role;
	}
	
	public UserRole() {
		super();
	}

	public Integer getUserRoleId() {
		return userRoleID;
	}

	public void setUserRoleId(Integer userRoleId) {
		this.userRoleID = userRoleId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
