require "cling"
require "colorize"

require "./commands/*"

module Crimson
  VERSION = "0.1.0"

  BUILD_DATE = {% if flag?(:win32) %}
                 {{ `powershell.exe -NoProfile Get-Date -Format "yyyy-MM-dd"`.stringify.chomp }}
               {% else %}
                 {{ `date +%F`.stringify.chomp }}
               {% end %}

  BUILD_HASH = {{ `git rev-parse HEAD`.stringify[0...8] }}

  class App < Commands::Base
    def setup : Nil
      @name = "app"
      @header = %(#{"Crimson".colorize.red} • #{"A Crystal Toolchain Manager".colorize.light_red})
    end

    def run(arguments : Cling::Arguments, options : Cling::Options) : Nil
      stdout.puts help_template
    end
  end
end