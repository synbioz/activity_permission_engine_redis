require 'activity_permission_engine/activity_permissions_registry'

module ActivityPermissionEngineRedis
  class ActivityPermissionsRegistry
    include ActivityPermissionEngine::ActivityPermissionsRegistry::Interface

    def initialize(redis_database, namespace='activity_permission_engine')
      @redis_database = redis_database
      @namespace = namespace
    end

    def add_role(activity_ref, role_ref)
      redis_command(:sadd, internal_activities_key, activity_ref)
      redis_command(:sadd, activity_ref, role_ref)
    end

    def remove_role(activity_ref, role_ref)
      redis_command(:srem,activity_ref, role_ref) &&
      (redis_command(:smembers, activity_ref).size == 0 && redis_command(:srem, internal_activities_key, activity_ref))
    end

    def get_activity_by_ref(activity_ref)
      redis_command(:exists, activity_ref) && {activity_ref: activity_ref, role_refs: redis_command(:smembers, activity_ref)}
    end

    def get_all_activities
      redis_command(:smembers, internal_activities_key)
    end

    def del(activity_ref)
      redis_command(:srem, internal_activities_key, activity_ref)
      redis_command(:del, activity_ref)
    end

    private
    attr_reader(:redis_database, :namespace)

    def namespaced(key)
      [namespace, key].join(':')
    end

    def redis_command(sym, key, *args)
      redis_database.send(sym, namespaced(key), *args)
    end

    def internal_activities_key
      'internals:activities'
    end

  end
end
