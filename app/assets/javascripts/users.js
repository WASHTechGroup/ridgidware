$(window).ready(function() {
	$("#change-roles-panel").css('display', 'none');
	$("#remove-user-panel").css('display', 'none');
	$("#add-user-panel").css('display', 'block');
});

function showroles() {
	$("#change-roles-panel").css('display', 'block');
	$("#remove-user-panel").css('display', 'none');
	$("#add-user-panel").css('display', 'none');
}

function showremove() {
	$("#change-roles-panel").css('display', 'none');
	$("#remove-user-panel").css('display', 'block');
	$("#add-user-panel").css('display', 'none');
}

function showadd() {
	$("#change-roles-panel").css('display', 'none');
	$("#remove-user-panel").css('display', 'none');
	$("#add-user-panel").css('display', 'block');
}

function inputusername(username) {
	// $(".username-input").clear();
	$(".username-input").val(username);
}