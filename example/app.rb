# frozen_string_literal: true

require "fast_mcp"

module App
  NAME = "my-app"
  VERSION = "0.0.1"

  module Mcp
    def server
      @server ||= begin
        server = FastMcp::Server.new(name: NAME, version: VERSION, logger:)
        server.register_tool(Tool)
        server
      end
    end

    def logger
      @logger ||= FastMcp::Logger.new
    end

    class Tool < FastMcp::Tool
      tool_name "greeting"
      description "Greets the user given a name."

      arguments do
        required(:name).filled(:string).description("Name of the person to greet.")
      end

      def call(name)
        "Hello from MCP, #{name}"
      end
    end
  end
end
