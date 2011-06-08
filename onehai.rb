require 'chef/knife'

module Lnxchk
  class Onehai < Chef::Knife

    deps do
      require 'chef/node'
      require 'chef/json_compat'
      require 'highline'
      require 'chef/knife/status'
    end

    banner "knife stat NODE"

    def run
      @myhost = @name_args.first
      if @myhost.nil?
        ui.error "You must specify a node name"
        exit 1
      end

      node = Chef::Node.load(@myhost)
      hours, minutes, seconds = Chef::Knife::Status.new.time_difference_in_hms(node["ohai_time"])
      hours = "%02d" % hours
      minutes = "%02d" % minutes
      ui.msg(ui.color(node['fqdn'],:cyan) + " #{hours}:#{minutes} since successful checkin") 
    end # end run
  end # end class
end # end module
