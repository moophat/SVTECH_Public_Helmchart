{{/* Define db reosources to use in icingaweb */}}
{{- define "icingaweb.resources" -}}
{{- range $resource, $settings := .Values.global.database }}
{{- if $settings.enabled }}
- name: icingaweb.resources.{{ $settings.database }}.type
  value: db
- name: icingaweb.resources.{{ $settings.database }}.db
  value: mysql
- name: icingaweb.resources.{{ $settings.database }}.charset
  value: utf8
- name: icingaweb.resources.{{ $settings.database }}.host
  value: {{ $settings.host | default "mariadb" | quote }}
- name: icingaweb.resources.{{ $settings.database }}.dbname
  value: {{ $settings.database }}
- name: icingaweb.resources.{{ $settings.database }}.username
  value: {{ $settings.username | default $resource }}
- name: icingaweb.resources.{{ $settings.database }}.password
  value: {{ $settings.password | default "juniper@123" | quote }}
{{- end }}
{{- end }}
{{- end }}