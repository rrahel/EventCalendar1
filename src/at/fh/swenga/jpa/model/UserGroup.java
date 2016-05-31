package at.fh.swenga.jpa.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Version;

@Entity
@Table(name= "UserGroup")
public class UserGroup implements Serializable {

	private static final long serialVersionUID = 5149819198078212819L;
	
	@Id
	@Column(nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int groupID;
	
	@Column(nullable = false, length = 50)
	private String name;
	
	@ManyToMany(mappedBy="userGroups", fetch=FetchType.EAGER)
	private List<User> users;
	
	@OneToMany(mappedBy="userGroup", fetch=FetchType.EAGER)
	private List<Event> events;
	
	@Version
	long version;

	public UserGroup(String name) {
		super();
		this.name = name;
	}
	
	public UserGroup() {
		super();

	}
	

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + groupID;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserGroup other = (UserGroup) obj;
		if (groupID != other.groupID)
			return false;
		return true;
	}
	
	
}
