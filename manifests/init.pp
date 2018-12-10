# Main OSSEC Entry Point Manifest
class ossec (
  $nodetype,
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
