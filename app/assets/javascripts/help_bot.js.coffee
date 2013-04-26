$(document).ready ->
	$(".bot").on("click", (e)->
		console.log "bot"
		if $("#affix").css("margin-left") == "750px"
			is_show = true
			$("#affix").css("margin-left", "620px")
			$("#affix").css("height", 220)
			$("#affix").css("width", 420)
			$("#affix .help ul").empty()
			$("#affix .pull-right").empty().append('<i class="icon-chevron-down"></i>')
			$("#affix .help ul").append("<li><a href='#'>Branched Walk-Thru Demo</a></li>")
			$("#affix .help ul").append("<li><a href='#'>Triggers Demo</a></li>")
			$("#affix .help ul").append("<li><a href='#'>WalkMe - Overview (Click me!)</a></li>")
		else
			is_show = false
			$("#affix").css("margin-left", "750px")
			$("#affix").css("height", 80)
			$("#affix").css("width", 340)
			$("#affix .help ul").empty()
			$("#affix .pull-right").empty().append('<i class="icon-chevron-up"></i>')
	)