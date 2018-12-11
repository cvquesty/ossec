# Main OSSEC Entry Point Manifest
class ossec (
  $nodetype,              # Dictates whether the classified node is an OSSEC server or agent node
  $notify_by_email,       # Whether to use email alerts or not.    (email_notification - yes/no)
  $notification_email,    # Email address to use for notifications (email_to - email@domain.com)
  $smtp_server,           # SMTP server to use sending above emaio (smtp_server - FQDN or IP)
  $email_from_address,    # EMail Address to display as the sender (email_from - email@domain.com)
) {

  if $nodetype == 'server' {

    include ossec::repo
    include ossec::server
    include ossec::config::server

  } elsif $nodetype == 'agent' {

    include ossec::repo
    include ossec::agent
    include ossec::config::agent

  } else {
    notice('The parameter you specified is unrecognozed by the ossec module.')
  }
}
