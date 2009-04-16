class AuditObserver < ActiveRecord::Observer
  observe User, Page, Layout, Snippet
  
  cattr_accessor :current_user
  cattr_accessor :current_ip
  
  def after_create(model)
    AuditEvent.create({:auditable => model, :user => @@current_user, :ip_address => @@current_ip, :audit_type => Audit::TYPES::CREATE})
  end

  def after_update(model)
    return true if model.is_a?(User) && model.logging_out
    AuditEvent.create({:auditable => model, :user => @@current_user, :ip_address => @@current_ip, :audit_type => Audit::TYPES::UPDATE})
  end
  
  def after_destroy(model)
    AuditEvent.create({:auditable => model, :user => @@current_user, :ip_address => @@current_ip, :audit_type => Audit::TYPES::DESTROY})
  end

end