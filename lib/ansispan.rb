class Ansispan
  @foreground_colors = {
    '30': 'black',
    '31': 'red',
    '32': 'green',
    '33': 'yellow',
    '34': 'blue',
    '35': 'purple',
    '36': 'cyan',
    '37': 'white'
  }

  def self.convert(str, escape_character: '\033')
    escape_character = Regexp.escape(escape_character)

    @foreground_colors.keys.each do |ansi|
      span = '<span style="color: ' + @foreground_colors[ansi] + '">'
      #
      # `\033[Xm` == `\033[0;Xm` sets foreground color to `X`.
      #
  
      str = str.gsub(/#{escape_character}\[#{ansi}m/, span)
        .gsub(/#{escape_character}\[#{ansi}m/, span)
    end

    #
    # `\033[1m` enables bold font, `\033[22m` disables it
    #
    str = str.gsub(/#{escape_character}\[1m/, '<b>')
      .gsub(/#{escape_character}\[22m/, '</b>')
  

    # Bold colors
    @foreground_colors.keys.each do |ansi|
      span = '<span style="font-weight: bold; color: ' + @foreground_colors[ansi] + '">'
      str = str.gsub(/#{escape_character}\[1;#{ansi}m/, span)
    end

    # Underline colors
    @foreground_colors.keys.each do |ansi|
      span = '<span style="text-decoration: underline; color: ' + @foreground_colors[ansi] + '">'
      str = str.gsub(/#{escape_character}\[4;#{ansi}m/, span)
    end
    #
    # `\033[3m` enables italics font, `\033[23m` disables it
    #
    str = str.gsub(/#{escape_character}\[3m/, '<i>')
      .gsub(/#{escape_character}\[23m/, '</i>')
  
    str = str.gsub(/#{escape_character}\[m/, '</span>');
    str = str.gsub(/#{escape_character}\[0m/, '</span>');
    return str.gsub(/#{escape_character}\[39m/, '</span>');
  end
end
