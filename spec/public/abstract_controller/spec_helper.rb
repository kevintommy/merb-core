__DIR__ = File.dirname(__FILE__)
require File.join(__DIR__, "..", "..", "spec_helper")

require File.join(__DIR__, "controllers", "filters")
require File.join(__DIR__, "controllers", "render")

Merb::Config[:framework] = {}

Merb.start %w( -e test )

module Merb::Test::Behaviors
  def dispatch_should_make_body(klass, body, action = :index)
    controller = Merb::Test::Fixtures::Abstract.const_get(klass).new
    controller._dispatch(action)
    controller.body.should == body
  end
end

Spec::Runner.configure do |config|
  config.include Merb::Test::Behaviors
end