{{/* Define proxy.index to enable/disable modules on default dashboard*/}}
{{- define "proxy.index.html" }}
<!DOCTYPE html>
<html>
<head>
<style>

* {margin: 0; padding: 0;}

body {
    background: #fafafa;
}

div {
    margin: 20px;
    display: block;
    margin: 0 auto;
    max-width: 25rem;
    padding: 1rem;
    background: white;
}

ul {
    list-style-type: none;
    max-width: 25rem;

}

h3 {
    font: bold 20px/1.5 Helvetica, Verdana, sans-serif;
}

li img {
    float: left;
    margin: 0 15px 0 0;
}

li p {
    font: 200 15px/1.5 Georgia, Times New Roman, serif;
}

li {
    padding: 10px;
    overflow: auto;
}

li:hover {
    background: #eee;
    cursor: pointer;
}
h1 {
    text-align: center;
    padding-top: 25px;
}

a:link {
    color: black;
    background-color: transparent;
    text-decoration: none;
}

a:visited {
    color: black;
    background-color: transparent;
    text-decoration: none;
}

a:hover {
    color: red;
    background-color: transparent;
    text-decoration: underline;
}

a:active {
    color: #be0000;
    background-color: transparent;
    text-decoration: underline;
}

</style>
</head>
<body>

<h1>List Dashboards</h1>

<div>
    <ul>
    {{- if .Values.global.icingaweb.enabled }}
    <li>
        <a href="/icingaweb/">
        <img width="100" height="80" src="./images/checklist-icon-checklist-icon.png" />
        <h3>WebUI</h3>
        <p>Monitoring Web Interface</p>
        </a>
    </li>
    {{- end }}

    {{- if .Values.global.thruk.enabled }}
    <li>
        <a href="/thruk">
        <img width="100" height="80" src="./images/checklist-icon-checklist-icon.png" />
        <h3>Thruk</h3>
        <p>Monitoring Web Interface</p>
        </a>
    </li>
    {{- end }}

    {{- if .Values.global.grafana.enabled }}
    <li>
        <a href="/grafana">
        <img width="100" height="80" src="./images/dashboard-svg-icon.png" />
        <h3>Grafana</h3>
        <p>Graph, Metric Monitoring and Analytics</p>
        </a>
    </li>
    {{- end }}
    
    {{- if .Values.global.nagvis.enabled }}
    <li>
        <a href="/nagvis">
        <img width="100" height="80" src="./images/topology-icon.png" />
        <h3>Nagvis</h3>
        <p>Topology</p>
        </a>
    </li>
    {{- end }}

    {{- if .Values.global.rundeck.enabled }}
    <li>
        <a href="/rundeck">
        <img width="100" height="80" src="./images/automation-icon.png" />
        <h3>Rundeck</h3>
        <p>Discovery, Scheduler and Automation Tasks</p>
        </a>
    </li>
    {{- end }}
    
    {{- if .Values.global.gitlist.enabled }}
    <li>
        <a href="/gitlist">
        <img width="100" height="80" src="./images/backup-icon.png" />
        <h3>Gitlist</h3>
        <p>Backup Configuration Files</p>
        </a>
    </li>
    {{- end }}

    {{- if .Values.global.kibana.enabled }}
    <li>
        <a href="/kibana">
        <img width="100" height="80" src="./images/logging-icon.png" />
        <h3>Kibana</h3>
        <p>Logging, Discover Data</p>
        </a>
    </li>
    {{- end }}


    </ul>
</div>
</body>
</html>
{{- end }}