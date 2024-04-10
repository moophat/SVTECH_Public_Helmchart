{{- define "maxscale.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image) }}
{{- end -}}

{{- define "generate_mariadb_string" -}}
{{- $replicaCount := .replicaCount | int -}}
{{- $result := "" -}}
{{- $releaseName := .releaseName -}}

{{- range $i, $ := until $replicaCount }}
  {{- $dbIndex := add $i 1 -}}
  {{- if eq $dbIndex $replicaCount -}}
    {{- printf "db0%d://%s-mariadb-galera-%d.%s-mariadb-galera-headless:3306" $dbIndex $releaseName $i $releaseName -}}
  {{- else -}}
    {{- printf "db0%d://%s-mariadb-galera-%d.%s-mariadb-galera-headless:3306," $dbIndex $releaseName $i $releaseName -}}
  {{- end -}}
{{- end }}

{{- end -}}


{{- define "generate_external_mariadb_string" -}}
{{- $server := .server -}}
{{- join "," $server }}
{{- end -}}
