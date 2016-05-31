$(function() {
	$('#bCryptPassword, #confirm_password').on('keyup', function() {
		if ($('#bCryptPassword').val() == $('#confirm_password').val()) {
			$('#message_user').html('Matching').css('color', 'green');
			document.getElementById("submit-user").disabled = false;
		} else {
			$('#message_user').html('Not Matching').css('color', 'red');
			document.getElementById("submit-user").disabled = true;
		}
	});
	
});