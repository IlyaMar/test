ycp --profile=prod vpc subnet move e9bpgj8sk8khtbm3302o --destination-folder-id yc.iam.idp-folder
ycp --profile=prod vpc subnet move e2l9mltqjfeuilr9i3i8 --destination-folder-id yc.iam.idp-folder
ycp --profile=prod vpc subnet move fl8hb7asn1u01utkqv2q --destination-folder-id yc.iam.idp-folder



ycp --profile prod vpc subnet update -r - <<REQ
subnet_id: fl8vvfp6lfcujdm4cbth
update_mask:
  paths:
    - extra_params
extra_params:
  import_rts:
    - 65533:776
  export_rts:
    - 65533:666
  hbf_enabled: true
  feature_flags:
    - contrail-ipam-dhcp-time-options-define
    - super-flow-v2.2
    - hardened-public-ip
    - super-flow-v2.1
    - super-flow-v2
    - blackhole
    - vmi-drop-unknown-multicast
    - static-route-override-fip
    - ecmp-hash-each-packet
    - vmi-drop-l2-advertisements
    - vmi-reduce-flow-log-event-size
REQ
