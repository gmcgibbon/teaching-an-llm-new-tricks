# frozen_string_literal: true

require "fast_mcp"

module App
  NAME = "my-app"
  VERSION = "0.0.1"

  module Mcp
    def server
      @server ||= begin
        server = FastMcp::Server.new(name: NAME, version: VERSION, logger:)
        server.register_tool(GreetingTool)
        server.register_resource(HighScoreResource)
        server
      end
    end

    def logger
      @logger ||= FastMcp::Logger.new
    end

    class GreetingTool < FastMcp::Tool
      tool_name "greeting"
      description "Greets the user given a name."

      arguments do
        required(:name).filled(:string).description("Name of the person to greet.")
      end

      def call(name:)
        "Hello from MCP, #{name}"
      end
    end

    class HighScoreResource < FastMcp::Resource
      uri "myapp:///high_score"
      resource_name "High Score"
      mime_type "application/json"

      def content
        JSON.generate({ value: (5000..9999).to_a.sample })
      end
    end
  end
end
