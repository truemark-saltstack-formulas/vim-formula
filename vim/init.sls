{% from "./map.jinja" import vim with context %}
{% if grains['os_family'] in ['Debian', 'RedHat'] %}
{{vim.package}}:
  pkg.installed
{{ vim.vimrc_location}}:
  file.managed:
    - source: {{ vim.vimrc_file }}
    - user: root
    - group: root
    - mode: 644
{% endif %}
{% if grains['os_family'] == 'RedHat' %}
'/etc/vimrc':
  file.blockreplace:
    - marker_start: '" START: Source a global configuration file if available'
    - marker_end: '" END: Source a global configuration file if available'
    - content: |
        if filereadable("/etc/vimrc.local")
          source /etc/vimrc.local
        endif
    - backup: .orig
    - append_if_not_found: True
{% endif %}


"echo moo > /etc/moo.conf":
  cmd.run
