# frozen_string_literal: true

require "rack"
require_relative "app"

module App
  class McpMiddleware < FastMcp::Transports::RackTransport
    include Mcp

    def initialize(app)
      super(app, server)
    end
  end

  module Server
    module_function

    def call(_env)
      [200, { "content-type" => "application/json" }, [{ result: "ok" }.to_json]]
    end
  end
end

use App::McpMiddleware
run App::Server
