// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function goto(url)
{
	window.location=url;
};

function get_pdf(report) {
	$.get("/reports/" + report + ".pdf")
}