# Manifest to control OSSEC agent service
class ossec::service::agent {

  service { 'ossec-hids':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/var/ossec/etc/ossec.conf'],
  }

}
