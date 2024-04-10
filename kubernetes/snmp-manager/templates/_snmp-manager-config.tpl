{{- define "snmpmanager.conf" }}
- name: ICINGA_HOST
  value: {{ .Values.global.api.host | default (printf "icinga2.%s.svc.%s" .Release.Namespace .Values.clusterDomain) | quote }}
- name: ICINGA_PORT
  value: {{ .Values.global.api.port | default 5665 | quote }}
- name: ICINGA_USER
  value: {{ .Values.global.api.user | default "icingaAdmin" | quote }}
- name: ICINGA_PASSWORD
  value: {{ .Values.global.api.password | default "icingaAdmin" | quote }}
- name: MYSQL_DBI_HOST
  value: {{ .Values.global.database.snmptt.host | default "mariadb" | quote }}
- name: MYSQL_DBI_PORT
  value: {{ .Values.global.database.snmptt.port | default 3306 | quote }}
- name: MYSQL_DBI_DATABASE
  value: {{ .Values.global.database.snmptt.database | default "snmptt" | quote }}
- name: MYSQL_DBI_USERNAME
  value: {{ .Values.global.database.snmptt.user | default "snmptt" | quote }}
- name: MYSQL_DBI_PASSWORD
  value: {{ .Values.global.database.snmptt.password | default "juniper@123" | quote }}
- name: MYSQL_DBI_TABLE_UNKNOWN
  value: {{ .Values.global.database.snmptt.unknownTable | default "snmptt_unknown" | quote }}
{{- end }}