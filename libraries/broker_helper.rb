module ChefRabbitMQ
  module BrokerHelper
    include Chef::Mixin::ShellOut

    def user_exists?(user)
      user_exists_command = shell_out("rabbitmqctl list_users | grep #{user}",  {returns: [0, 2]})

      user_exists_command.stderr.empty? and user_exists_command.stdout.strip.length > 0
    end
  end

end