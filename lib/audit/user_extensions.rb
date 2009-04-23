module Audit
  module UserExtensions

    def self.included(base)
      base.class_eval do
        extend Auditable

        audit_event :CREATE do |event|
          "#{event.user_link} created " + link_to(event.auditable.name, edit_admin_user_path(event.auditable))
        end

        audit_event :UPDATE do |event|
          "#{event.user_link} updated " + link_to(event.auditable.name, edit_admin_user_path(event.auditable))
        end

        audit_event :DESTROY do |event|
          "#{event.user_link} deleted #{event.auditable.name}"
        end

        audit_event :LOGIN do |event|
          "#{event.user_link} logged in"
        end

        audit_event :LOGOUT do |event|
          "#{event.user_link} logged out"
        end
      end
    end

  end
end