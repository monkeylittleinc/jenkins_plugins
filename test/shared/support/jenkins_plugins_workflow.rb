module Serverspec
  module Type
    class JenkinsPluginsWorkflow < Base
      require 'rexml/document'

      def initialize(name)
        @name = name
        super
      end

      def jenkins_job?
        !!xml
      end

      private

      def xml
        return @xml if @xml

        contents = ::File.read("/var/lib/jenkins/jobs/#{name}/config.xml")
        @xml = REXML::Document.new(contents)
      rescue Errno::ENOENT
        @xml = nil
      end
    end
  end
end
