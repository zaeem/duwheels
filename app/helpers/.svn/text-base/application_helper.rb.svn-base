# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def set_title(title)
    @set_title = "Token Today - #{title}"
  end
  def token_heading(token)
    "#{number_to_currency(token.token_price, :unit => "Rs. ")} for #{number_to_currency token.orignal_price, :unit => "Rs. "} #{token.name}"
  end
  def remaining_time(ex_time)
    ex_time = ex_time - Time.now
    days = (ex_time/(60*60*24)).to_i
    ex_time = (ex_time%(60*60*24))
    hours = (ex_time/(60*60)).to_i
    ex_time = (ex_time%(60*60))
    minutes = (ex_time/(60)).to_i
    return days, hours, minutes
  end

  def pluralize_helper(number, string, verb)
    verb = ' ' + verb + '.'
    if number <= 0
      return '<h1>No ' + string + verb + '</h1>'
    elsif number > 1
      return '<h1>' + number.to_s + ' ' + string.pluralize + verb + '</h1>'
    else
      return '<h1>Only 1 ' + string + verb + '</h1>'
    end
  end

  def currency_helper(number)
    number = number.to_s
    rs = ""
    number.reverse.chars.each_with_index{|i, index| rs<<i; rs<<"," if index==2; rs<<"," if (index!=number.chars.count-1&&index>3&&index%2==0) }
    rs = rs.reverse
    return "$ " + rs
  end

  def currencify(number, options={})
    # :currency_before => false puts the currency symbol after the number
    # default format: $12,345,678.90
    options = {:currency_symbol => "$", :delimiter => ",", :decimal_symbol => ".", :currency_before => true, :no_decimal => false}.merge(options)
    # split integer and fractional parts
    int, frac = ("%.2f" % number).split('.')
    # insert the delimiters
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")
    if options[:no_decimal]
      frac_part = ""
    else
      frac_part = options[:decimal_symbol] + frac
    end
    if options[:currency_before]
      options[:currency_symbol] + int + frac_part
    else
      int + frac_part + options[:currency_symbol]
    end
  end

  def mileage_helper(number)
    number = number.to_s
    rs = ""
    number.reverse.chars.each_with_index{|i, index| rs<<i; rs<<"," if index==2; rs<<"," if (index!=number.chars.count-1&&index>3&&index%2==0) }
    rs = rs.reverse
    return rs + ' Km.'
  end

  def admin_logged_in?
    current_user && current_user.admin?
  end

end
