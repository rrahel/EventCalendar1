package at.fh.swenga.jpa.model;

import java.util.Date;
import java.util.List;
import java.util.Set;

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

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Notification")
public class Notification implements java.io.Serializable {

	private static final long serialVersionUID = 4337277720163446201L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int notId;

	@Column(nullable=false)
	private int eventId;
	
	@Column(nullable=false, length=50)
	private String eventTitle;
	
	@Column(nullable=false, length=50)
	private String eventGroup;
	
	@Column(nullable=true)
	@DateTimeFormat(pattern="dd.MM.yyyy HH:mm")
	private Date eventStart;
	
	/*
	 * notification types
	 * 1 = event invitation
	 * 2 = event reminder
	 */
	@Column(nullable=false)
	private int notificationType;
	
	@Column(nullable=false)
	private Boolean haveRead;
	
//	@ManyToMany(mappedBy="notifications", fetch=FetchType.LAZY)
//	private List<User> users;
	
	@Column(nullable=false)
	private String username;
	
	@Version
	long version;
	
	public Notification() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Notification(int eventId, String eventTitle, String eventGroup,
			int notificationType, Boolean haveRead, String username) {
		super();
		this.eventId = eventId;
		this.eventTitle = eventTitle;
		this.eventGroup = eventGroup;
		this.notificationType = notificationType;
		this.haveRead = haveRead;
		this.username = username;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventGroup() {
		return eventGroup;
	}

	public void setEventGroup(String eventGroup) {
		this.eventGroup = eventGroup;
	}

	public int getNotificationType() {
		return notificationType;
	}

	public void setNotificationType(int notificationType) {
		this.notificationType = notificationType;
	}

	public Boolean getHaveRead() {
		return haveRead;
	}

	public void setHaveRead(Boolean haveRead) {
		this.haveRead = haveRead;
	}

//	public List<User> getUsers() {
//		return users;
//	}
//
//	public void setUsers(List<User> users) {
//		this.users = users;
//	}

	public int getNotId() {
		return notId;
	}

	public int getEventId() {
		return eventId;
	}

	public void setEventId(int eventId) {
		this.eventId = eventId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getEventStart() {
		return eventStart;
	}

	public void setEventStart(Date eventStart) {
		this.eventStart = eventStart;
	}
	
	
	

}
