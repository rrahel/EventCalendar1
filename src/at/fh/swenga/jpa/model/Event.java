package at.fh.swenga.jpa.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "Event")
public class Event implements Serializable {

	private static final long serialVersionUID = 479364507980028276L;

	@Id
	@Column(nullable = false)
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	@Column(nullable=false, length=50)
	private String title;
	
	@Column(nullable=false)
	@DateTimeFormat(pattern="dd.MM.yyyy HH:mm")
	private Date start;

	@Column(nullable=false)
	@DateTimeFormat(pattern="dd.MM.yyyy HH:mm")
	private Date end;
	
	@Column(nullable=false)
	private Boolean allDay;
	
	@Column(nullable=true)
	private String colour;

	/**
	 * the next fields are not standard fields of the fullcalendar
	 */
	@Column(nullable=false, length=50) 
	private String location;

	@Column(nullable=false, length=500) 
	private String description;

	@Lob
	@Column(nullable=true)
	private byte[] attachment;
	
	@Column(nullable=true)
	private String attachmentName;

	@ManyToOne(cascade=CascadeType.PERSIST)
	@JoinColumn(name = "UserGroup")
	private UserGroup userGroup;
	
	@ManyToMany(mappedBy="events", fetch=FetchType.EAGER)
	private List<User> users;
	
	@Version
	long version;

	
	public Event() {
		super();
	}


	public Event(String title, Date start, Date end, Boolean allDay,
			String location) {
		super();
		this.title = title;
		this.start = start;
		this.end = end;
		this.allDay = allDay;
		this.location = location;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStart() {
		return start;
	}


	public void setStart(Date start) {
		this.start = start;
	}


	public Date getEnd() {
		return end;
	}


	public void setEnd(Date end) {
		this.end = end;
	}


	public Boolean getAllDay() {
		return allDay;
	}


	public void setAllDay(Boolean allDay) {
		this.allDay = allDay;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}

	public byte[] getAttachment() {
		return attachment;
	}
	
	public String getAttachmentName() {
		return attachmentName;
	}


	public void setAttachment(byte[] attachment) {
		this.attachment = attachment;
	}
	
	public String setAttachmentName(String attachmentName) {
		return this.attachmentName = attachmentName;
	}


	public List<User> getUsers() {
		return users;
	}


	public void setUsers(List<User> users) {
		this.users = users;
	}
		
	public int getId() {
		return id;
	}


	public String getColour() {
		return colour;
	}


	public void setColour(String colour) {
		this.colour = colour;
	}


	public UserGroup getUserGroup() {
		return userGroup;
	}


	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}


	public void removeUser(User user) {
		users.remove(user);
		
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
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
		Event other = (Event) obj;
		if (id != other.id)
			return false;
		return true;
	}

	

	
	

	
}
