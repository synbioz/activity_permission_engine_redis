require_relative 'test_helper'
require 'redis'
require 'activity_permission_engine/test_helpers/activity_permissions_registry_test'

module ActivityPermissionEngineRedis
  describe 'activity permission registry' do
    let(:activity_ref) { 'activity_ref' }
    let(:role_ref) { 'role_ref' }
    let(:redis_db) { Redis.new }
    let(:registry) { ActivityPermissionEngineRedis::ActivityPermissionsRegistry.new(redis_db) }

    describe 'behaves like an activity permission registry' do
      subject { registry }
      include ActivityPermissionEngine::TestHelpers::ActivityPermissionsRegistryTest
    end

    describe 'add_role' do
      it 'append role to existing one' do
        registry.add_role(activity_ref, role_ref)
        registry.get_activity_by_ref(activity_ref)[:role_refs].must_include(role_ref)
      end
    end

    describe '#get_activity_by_ref' do
      subject { registry.get_activity_by_ref(activity_ref) }
      describe 'using an existing activity_ref' do
        before(:each) do
          registry.add_role(activity_ref, role_ref)
        end
        it 'returns the corresponding Activity' do
          subject[:activity_ref].must_equal activity_ref
        end
      end

      describe 'when activity_ref does not exists' do
        before(:each) {
          registry.del(activity_ref)
        }

        it 'returns false' do
          subject.must_equal false
        end
      end
    end

    describe '#remove_role(activity_ref, role_ref)' do
      let(:last_role) { 'last_role' }
      subject { registry.remove_role(activity_ref, role_ref) }

      before(:each) do
        registry.add_role(activity_ref, role_ref)
        registry.add_role(activity_ref, last_role)
      end

      it 'remove role from activity permission' do
        subject
        registry.get_activity_by_ref(activity_ref)[:role_refs].must_equal [last_role]
      end
    end

    describe 'get_all_activities' do
      let(:activities) { ['activity_1', 'activity_2'] }
      subject { registry.get_all_activities }
      before(:each) do
        activities.each do |act|
          registry.add_role(act, role_ref)
        end
      end

      it 'returns all activities' do
        (activities - subject).must_equal []
      end
    end
  end
end