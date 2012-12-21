window.locales ||= {}

jQuery ->
  locale = $('html').attr('lang')
  locales.current = locales[locale]
