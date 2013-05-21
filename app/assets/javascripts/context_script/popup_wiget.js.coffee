$(document).ready ->
  help_bot_html = """
  <div class='row-fluid'>
    <div class='affix bot span3' id='affix' style='margin-left:750px'>
      <div class='row-fluid'>
        <strong>Need help?</strong>
        <div class='pull-right'>
          <i class='icon-chevron-up'></i>
        </div>
      </div>
      <div class='row-fluid'>
        <div class='input-append'>
          <input class='span8' type='text' placeholder='Type your question here'>
          <button class='btn' type='button'>
            <i class='icon-search'></i>
            Search
          </button>
        </div>
      </div>
      <div class='help row-fluid'>
        <ul></ul>
      </div>
    </div>
  </div>
    """

  $('body').append(help_bot_html)

  class Chardin
    constructor: () ->
      $("*").removeAttr("data-intro")

    add: (id, text, position) ->
      a = id
      $(a).attr('data-intro', text)
      $(a).attr('data-position', position)

    start:()->
      $('body').chardinJs('start')

  class Intro
    constructor: () ->
      @count = 1
      $("*").removeAttr("data-step")
      $("*").removeAttr("data-intro")

    add: (id, text) ->
      a = id
      $(a).attr('data-intro', text)
      $(a).attr('data-step', @count)
      @count += 1

    start:()->
      introJs().start()

  $(".bot").on("click", (e)->
    e.preventDefault()
    click_link = false
    console.log "click bot", e.target, e.target.id

    switch e.target.id
      when "demo1"
        click_link = true
        console.log "demo1"
        help = new Intro()
        text = "We can guide your users to a specific button on your page – click the ‘FEATURES’ link above"
        help.add("a[href='/features']", text)

        text = "We can see Demo"
        help.add("a[href='/app/demo']", text)

        $(window).scrollTop($("body").position().top)
        help.start()
      when "demo2"
        click_link = true
        console.log "demo2"
        
        help = new Intro()
        text = "Would you like to take a peek at the available triggers in WalkMe? Let’s go!"
        help.add("#root", text)

        text = "Great! Now, you have the option to wait for the user to click on an element…click on 'Request a Demo'"
        help.add("a[href='#request-invite']", text)
        $(window).scrollTop($("a[href='/features']").position().top)
        help.start()

      when "demo3"
        click_link = true
        console.log "demo3"
        help  = new Chardin()

        text = "Exmaple forms"
        postion = "top"
        id = ".example.span5"
        help.add(id, text, postion)

        text = "Control widget"
        postion = "top"
        id = "#demo-widget"
        help.add(id, text, postion)

        text = "Help System"
        postion = "top"
        id = "#affix"
        help.add(id, text, postion)
        $(window).scrollTop($("a[href='/features']").position().top)
        help.start()

    if click_link 
      return

    if $("#affix").css("margin-left") == "750px"
      console.log "big" 
      $("#affix").css("margin-left", "620px")
      $("#affix").css("height", 220)
      $("#affix").css("width", 420)
      $("#affix .help ul").empty()
      $("#affix .pull-right").empty().append('<i class="icon-chevron-down"></i>')
      $("#affix .help ul").append("<li><a href='#' id='demo1'>Branched Walk-Thru Demo</a></li>")
      $("#affix .help ul").append("<li><a href='#' id='demo2'>Triggers Demo</a></li>")
      $("#affix .help ul").append("<li><a href='#' id='demo3'>WalkMe - Overview (Click me!)</a></li>")
    else
      console.log "small"
      $("#affix").css("margin-left", "750px")
      $("#affix").css("height", 80)
      $("#affix").css("width", 340)
      $("#affix .help ul").empty()
      $("#affix .pull-right").empty().append('<i class="icon-chevron-up"></i>')
  )