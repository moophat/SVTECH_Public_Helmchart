---
{{/* define graphs for grafana module */}}
{{- define "icingaweb.graphs.ini" }}
[hostalive]
dashboard = "icinga2-hostalive"
panelId = "1"
orgId = "1"
repeatable = "no"
dashboarduid = "icinga2-hostalive"
{{- end }}
