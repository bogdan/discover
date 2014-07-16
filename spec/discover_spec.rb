require 'spec_helper'

describe 'Discover' do

  let(:named_scope) { Group.by_char('j') }

  let(:java)   { build_group 'java'   }
  let(:json)   { build_group 'json'   }
  let(:jruby)  { build_group 'jruby'  }
  let(:ruby)   { build_group 'ruby'   }
  let(:python) { build_group 'python' }

  describe '#does_not_match?' do

    context 'if scope contains any of the specified values' do
      subject { discover(java, ruby) }
      before(:each) do
        expect(subject.does_not_match?(named_scope)).to be(false)
      end

      it { subject.failure_message_for_should_not.should == "expected #{named_scope.inspect} to not include objects: #{[java.id].inspect}, but it was. Found objects: #{named_scope.map(&:id).inspect}"}

    end

  end

  describe '#matches?' do
    context 'if scope does not contain any of the specified objects' do
      subject { discover(java, ruby) }
      before(:each) do
        expect(subject.matches?(named_scope)).to be(false)
      end

      it {subject.failure_message_for_should.should == "expected #{named_scope.inspect} to include objects: #{[ruby.id].inspect}, but it was not. Found objects: #{named_scope.map(&:id).inspect}"}
    end

    context 'if scope contain all of the specified objects but without correct order' do
      subject { discover(jruby, java).with_exact_order }
      before(:each) do
        expect(subject.matches?(named_scope)).to be(false)
      end

      it 'should render error message correctly' do
        subject.failure_message_for_should.should == "expected #{named_scope.inspect} to be ordered as: #{[jruby.id, java.id].inspect}, but it was not. "
      end
    end
  end

  describe 'api' do
    subject { named_scope }

    it { should discover(java) }

    it { should discover(json, java, jruby) }

    it { should discover(java, jruby, json).with_exact_order}
    it { should discover(java, json).with_exact_order }


    it { should_not discover(ruby) }
    it { should_not discover(ruby, python) }

  end
end
