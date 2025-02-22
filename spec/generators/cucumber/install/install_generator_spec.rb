# frozen_string_literal: true

require 'spec_helper'

# Generators are not automatically loaded by Rails
require 'generators/cucumber/install/install_generator'

describe Cucumber::InstallGenerator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path('../../../../tmp', __dir__)

  before { prepare_destination }

  let(:auto_generated_message) do
    '# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.'
  end

  describe 'no arguments' do
    before { run_generator }

    describe 'config/cucumber.yml' do
      subject { file('config/cucumber.yml') }

      it { is_expected.to exist }
      it { is_expected.to contain 'default: <%= std_opts %> features' }
    end

    describe 'features/step_definitions folder' do
      subject { file('features/step_definitions') }

      it { is_expected.to exist }
    end

    describe 'features/support/env.rb' do
      subject { file('features/support/env.rb') }

      it { is_expected.to exist }
      it { is_expected.to contain auto_generated_message }
      it { is_expected.to contain "require 'cucumber/rails'" }
    end

    describe 'lib/tasks/cucumber.rake' do
      subject { file('lib/tasks/cucumber.rake') }

      it { is_expected.to exist }
      it { is_expected.to contain auto_generated_message }
      it { is_expected.to contain "task cucumber: 'cucumber:ok'" }
    end

    describe 'script/cucumber' do
      subject { file('script/cucumber') }

      it { is_expected.to exist }
      it { is_expected.to contain 'load Cucumber::BINARY' }
    end
  end
end
