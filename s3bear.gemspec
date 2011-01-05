# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{s3bear}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Cranston"]
  s.date = %q{2011-01-05}
  s.description = %q{S3Bear adds a url field to your models and will download remote files for paperclip to use}
  s.email = %q{cracell@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "config/routes.rb",
    "lib/generators/s3_bear/install_generator.rb",
    "lib/generators/s3_bear/templates/s3bear.rb",
    "lib/railtie.rb",
    "lib/s3_bear/configuration.rb",
    "lib/s3bear.rb",
    "lib/tasks/s3bear.rake",
    "public/assets/jquery-1.4.4.min.js",
    "public/assets/jquery.html5_upload.js",
    "public/assets/pagehandling.js",
    "public/assets/postmessage.js",
    "public/assets/s3bear_external.js",
    "public/assets/upload_button.png",
    "public/crossdomain.xml",
    "public/upload.html",
    "s3bear.gemspec",
    "test/helper.rb",
    "test/test_s3_bear.rb"
  ]
  s.homepage = %q{http://github.com/cracell/s3bear}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{S3Bear helps you upload files right to S3}
  s.test_files = [
    "test/helper.rb",
    "test/test_s3_bear.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<aws-s3>, ["~> 0.6"])
      s.add_runtime_dependency(%q<rails>, ["~> 3.0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<aws-s3>, ["~> 0.6"])
      s.add_dependency(%q<rails>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<aws-s3>, ["~> 0.6"])
    s.add_dependency(%q<rails>, ["~> 3.0"])
  end
end

