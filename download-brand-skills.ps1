# ============================================================================
# ContextArchitect Skills - Brand (Production) Download (Windows PowerShell)
# Installs only the skills needed for brand production projects.
# Excludes: avatar-research, business-validation, brand-analyzer,
#           breakthrough-advertising
#
# Usage:
#   iex (irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-brand-skills.ps1')
# ============================================================================

$scriptUrl = 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.ps1'
$scriptContent = (Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing).Content
$sb = [ScriptBlock]::Create($scriptContent)
& $sb -Mode brand
