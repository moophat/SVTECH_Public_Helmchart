{{/* Define proxy.conf to enable/disable redirection on nginx proxy */}}
{{- define "proxy.proxy.conf" }}
server {
    listen 8080;
    {{- if and .Values.global.proxy.enabled .Values.global.thruk.enabled }}
    location /thruk {
        {{- if .Values.global.ci }}
        proxy_pass http://thruk:80;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/thruk;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.icingaweb.enabled }}
    location /icingaweb/ {
        {{- if .Values.global.ci }}
        proxy_pass http://icingaweb:8080;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/icingaweb;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.gitlist.enabled }}
    location /gitlist {
        {{- if .Values.global.ci }}
        proxy_pass http://gitlist:80;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/gitlist;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.grafana.enabled }}
    location /grafana/send_request {
        rewrite  ^/grafana/send_request/(.*)  /$1 break;
        {{- if .Values.global.ci }}
        proxy_pass http://icinga2-report:8888/;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/icinga2-report;
        {{- end }}
        proxy_set_header X-Forwarded-Host $host:$server_port;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /grafana {
        rewrite  ^/grafana/(.*)  /$1 break;
        {{- if .Values.global.ci }}
        proxy_pass http://grafana:3000;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/grafana;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.nagvis.enabled }}
    location /nagvis {
        {{- if .Values.global.ci }}
        proxy_pass http://nagvis:80;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/nagvis;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.rundeck.enabled }}
    location /rundeck {
        client_max_body_size 2G;
        {{- if .Values.global.ci }}
        proxy_pass http://rundeck:4440/rundeck;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/rundeck;
        {{- end }}
        proxy_set_header   Host   $host;
        proxy_set_header   X-Real-IP  $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    {{- if index .Values "global" "csv-view" "enabled" }}
    location /static_csv/ {
        alias /opt/SVTECH-Junos-Automation/addition_toolkit/csv-to-html-table/static/;
    }
    location /csv {
        rewrite /csv/(.*) /$1  break;
        {{- if .Values.global.ci }}
        proxy_pass http://csv-view:8000;
        {{- else }}
        proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/csv;
        {{- end }}
    }
    {{- end  }}

    {{- if and .Values.global.proxy.enabled .Values.global.kibana.enabled }}
    location /kibana {
            {{- if .Values.global.ci }}
            proxy_pass http://{{- printf "%s-kb-http" .Values.global.elasticsearch.clusterName -}}:5601/kibana;
            {{- else }}
            proxy_pass http://ingress-frontend.{{ .Values.global.ingressNamespace }}.svc.cluster.local/kibana;
            {{- end }}
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    {{- end  }}

    # {{- if and .Values.global.proxy.enabled .Values.global.sharedVolume.enabled }}
    # location /longhorn/ {
    #     proxy_pass http://longhorn-frontend.longhorn-system.svc.cluster.local:81;
    #     rewrite /longhorn/(.*) /$1  break;
    #     proxy_set_header Upgrade $http_upgrade;
    #     proxy_set_header Connection "upgrade";
    #     proxy_set_header Host $host;
    #     proxy_set_header X-Real-IP $remote_addr;
    #     subs_filter http://$host http://$host/longhorn;
    # }

    # location /longhorn/v1/  {
    #     proxy_pass http://longhorn-backend.longhorn-system.svc.cluster.local:9500;
    #     rewrite /longhorn/(.*) /$1  break;
    #     proxy_set_header Upgrade $http_upgrade;
    #     proxy_set_header Connection "upgrade";
    #     proxy_set_header Host $host;
    #     proxy_set_header X-Real-IP $remote_addr;
    #     subs_filter http://$host http://$host/longhorn;
    # }

    # {{- end  }}
}
{{- end }}
