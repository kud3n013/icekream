param([string]$Action = 'status')
switch ($Action.ToLower()) {
    'start'   { docker start searxng }
    'enable'  { docker start searxng }
    'stop'    { docker stop searxng }
    'disable' { docker stop searxng }
    'restart' { docker restart searxng }
    'status'  { docker ps -a --filter 'name=searxng' }
    default   { Write-Host 'Usage: searxng [start|stop|enable|disable|status|restart]' }
}
