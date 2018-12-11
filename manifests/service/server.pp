# Manifest to run OSSEC Server Agent
class ossec::service::server {

  service { 'ossec-hids':
    ensure      => 'running',
    enable      => true,
    hasstatus   => true,
    hassrestart => true,
  }

  service { 'ossec-hids-authd':
    ensure      => 'running',
    enable      => true,
    hasstatus   => true,
    hassrestart => true,
  }

}
