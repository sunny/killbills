$.fn.friendsPies = (selector) ->
  return this unless @length

  oweyou_debts = []
  oweyou_names = []
  oweyou_links = []
  youowe_debts = []
  youowe_names = []
  youowe_links = []

  $(selector).each ->
    debt = parseFloat($(this).data('debt'))
    name = $(this).find('h2').text()
    link = $(this).find('a').attr('href')
    abs_debt = Math.abs(debt)
    name = "#{currencize abs_debt}: #{name}"

    if debt < 0
      oweyou_debts.push abs_debt
      oweyou_names.push name
      oweyou_links.push link
    else
      youowe_debts.push debt
      youowe_names.push name
      youowe_links.push link

  $(this).friendsPie('oweyou', oweyou_debts, oweyou_names, oweyou_links)
  $(this).friendsPie('youowe', youowe_debts, youowe_names, youowe_links)
  this


$.fn.friendsPie = (id, debts, names, links) ->
  return this unless @length and debts.length
  paper = Raphael(id, 380, 120)
  x = 60
  y = 60
  r = 50

  pie = paper.piechart(x, y, r, debts, {
    legend: names,
    legendpos: "east",
    href: links,
    colors: ['#ffdd22', '#bb3322', '#eecc44', '#440000', '#ffff11', '#ff0000', '#000000']
  })

  pie.hover(->
    @sector.stop().animate({ transform: "s1.1 1.1 #{@cx} #{@cy}" }, 500, "bounce")
    @label[0].animate({ r: 7.5 }, 500, "bounce")
    @label[1].attr("font-size": "14px")
  , ->
    @sector.animate({ transform: "s1 1 #{@cx} #{@cy}" }, 500, "bounce")
    @label[0].animate({ r: 5 }, 500, "bounce")
    @label[1].attr("font-size": "12px")
  )

  this


