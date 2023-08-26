module Crimson::Internal
  private def self.warn(data : String) : Nil
    STDOUT << "warn".colorize.yellow << ": " << data << '\n'
  end

  private def self.error(data : String) : Nil
    STDERR << "error".colorize.red << ": " << data << '\n'
  end

  private def self.should_continue? : Bool
    loop do
      print "\nDo you want to continue? (y/n) "
      case gets.try &.chomp
      when "y", "ye", "yes"
        return true
      when "n", "no"
        return false
      else
        error "Invalid prompt answer (must be yes or no)"
      end
    end
  end
end

{% if flag?(:win32) %}
  require "./internal/win32"
{% else %}
  require "./internal/linux"
{% end %}
