# OSSEC Agent Configuration Manifest
class ossec::config::agent (
  $notify_by_email,       # Whether to use email alerts or not.    (email_notification - yes/no)
  $notification_email,    # Email address to use for notifications (email_to - email@domain.com)
  $smtp_server,           # SMTP server to use sending above emaio (smtp_server - FQDN or IP)
  $email_from_address,    # EMail Address to display as the sender (email_from - email@domain.com)
){

  # Backup the Main Config before any configuration work
  exec { 'backup_agent_config':
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command => 'cp /var/ossec/etc/ossec-agent.conf /var/ossec/etc/ossec-agent.conf-DIST',
    unless  => 'test -f /var/ossec/etc/ossec-agent.conf-DIST',
  }

  # Place Main ossec.conf on disk
  file { '/var/ossec/etc/ossec-agent.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ossec/agent_config.erb'),
  }

}
