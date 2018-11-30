# Main OSSEC Entry Point Manifest
class ossec {

  # Include all components of module for calling iundependent classes
  include [ 'ossec::repo' ]
}
