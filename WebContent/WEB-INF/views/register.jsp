<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register for EventCalendar</title>
<jsp:include page="includes/bootstrapMeta.jsp" />
<jsp:include page="includes/bootstrapCss.jsp" />
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row"></div>
						<h2>Register</h2>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="register-user-form" action="createUser" method="post"
									role="form" style="display: block;">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" />
									<fieldset>
										<input type="hidden" name="id" value="0" /> <input
											type="hidden" name="userType" value="U" />
										<div class="form-group">
											<label class="control-label" for="firstname">My
												firstname is</label>
											<div class="controls">
												<input id="firstname" name="firstname" placeholder="John"
													class="form-control" required="true" title="Required field!" autofocus="true" type="text">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label" for="surname">My last
												name is</label>
											<div class="controls">
												<input id="lastname" name="surname" placeholder="Doe"
													class="form-control" required="true" title="Required field!"
													type="text">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label" for="email">My E-Mail is</label>
											<div class="controls">
												<input id="username" name="username"
													placeholder="name@example.com" class="form-control" required="true" title="Required field!"
													 type="email">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label" for="bCryptPassword">My
												preferred password is</label>
											<div class="controls">
												<input id="bCryptPassword" name="password" placeholder=""
													class="form-control" required="true" title="Required field!" type="password">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label" for="password">Confirm
												your password</label>
											<div class="controls">
												<input id="confirm_password" name="confirm_password"
													placeholder="" class="form-control" required="true" title="Required field!"
													type="password" /> <span id='message_user'></span>
											</div>
										</div>
										<div class="form-group">
											<button class="btn btn-success btn-block btn-lg"
												name="submit-user" id="submit-user" value="Submit"
												type="submit">Register now</button>

										</div>
										<div class="form-group">
										<a href="calendar">
											<button class="btn btn-lg  btn-block" type="submit">Cancel</button>
										</a>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src=<c:url value='/resources/register/jquery.js'/>></script>
	<script src=<c:url value='/resources/register/passwordValidation.js'/>></script>
	
</body>
</html>