{{/* Icingaweb enable modules */}}
{{- define "icingaweb2.enabledModules" -}}
{{- range $module, $settings := .Values.modules -}}
{{- if $settings.enabled -}}
{{ $module }},
{{- end -}}
{{- end }}
{{- end }}