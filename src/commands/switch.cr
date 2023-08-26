module Crimson::Commands
  class Switch < Base
    def setup : Nil
      @name = "switch"
      @summary = "switch the current Crystal version"
      @description = <<-DESC
        Manages the available Crystal version on the system. By default this command
        will print the current set Crystal version. Specifying a version or version
        alias will set that as the available version on the system (meaning it will
        switch the Crystal and Shards executables).
        DESC

      add_usage "switch"
      add_usage "switch [-v|--verbose] <target>"

      add_argument "target", description: "the version or version alias to switch to"
    end

    def run(arguments : Cling::Arguments, options : Cling::Options) : Nil
      config = Config.load

      unless arguments.has? "target"
        puts config.current if config.current
        return
      end

      target = arguments.get("target").as_s
      if version = config.aliases[target]?
        target = version
      end

      unless ENV.installed? target
        error "Crystal version #{target} is not installed"
        system_exit
      end

      Internal.switch ENV::CRYSTAL_PATH / target
      config.current = target
      config.save
    end
  end
end
