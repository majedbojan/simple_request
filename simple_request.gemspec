lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_helper/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_request"
  spec.version       = SimpleHelper::VERSION
  spec.authors       = ["MaJeD BoJaN"]
  spec.email         = ["bojanmajed@gmail.com"]

  spec.summary       = 'Simple ruby gem that helps to make HTTP and HTTPS request from ruby projects.'
  spec.homepage      = "https://github.com/MajedBojan/simple_request"
  spec.license       = "MIT"

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/MajedBojan/simple_request"
  spec.metadata["changelog_uri"] = "https://github.com/MajedBojan/simple_request/blob/master/Changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.5", ">= 2.5.4"
  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_development_dependency "rake", "~> 13.1"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.60", ">= 1.60.1"
  spec.add_development_dependency "rubocop-performance", "~> 1.20", ">= 1.20.2"
  spec.add_development_dependency "vcr", "~> 6.2"
  spec.add_development_dependency "webmock", "~> 3.19", ">= 3.19.1"
end
