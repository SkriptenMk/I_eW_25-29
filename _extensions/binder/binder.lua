--[[
  binder.lua
  Fügt pro Notebook (.ipynb) am Seitenanfang einen "Open in Binder"-Badge
  (öffnet JupyterLab im jeweiligen Notebook) sowie einen lokalen
  Download-Link für die Roh-.ipynb-Datei ein.

  Aktivierung in _quarto.yml:
    filters:
      - binder

  Voraussetzung für den Download: die .ipynb-Dateien müssen via
  project.resources ("**/*.ipynb") in den output-dir (docs/) kopiert werden.
--]]

-- ============================================
-- KONFIGURATION
-- ============================================
local repo   = "SkriptenMk/I_eW_25-29"
local branch = "main"

-- ============================================
-- FILTER
-- ============================================
function Pandoc(doc)
  -- Nur HTML-Output
  if not quarto.doc.is_format("html") then
    return doc
  end

  -- Pfad der Quelldatei
  local src = quarto.doc.input_file
  if src == nil then return doc end

  -- Nur Notebooks
  if not src:match("%.ipynb$") then return doc end

  -- Repo-relativen Pfad ab "files/" extrahieren
  local relpath = src:match("(files/.*)$")
  if relpath == nil then return doc end

  -- Binder-URL: JupyterLab, direkt im Notebook
  local binder_url = string.format(
    "https://mybinder.org/v2/gh/%s/%s?urlpath=lab/tree/%s",
    repo, branch, relpath
  )

  -- Download-URL auf raw.githubusercontent.com.
  -- Ein lokaler Link (Dateiname oder relativer Pfad) würde von Quarto als
  -- interner Verweis erkannt und auf die gerenderte .html umgeschrieben –
  -- dann lädt der Button HTML statt des Notebooks. Ein absoluter externer
  -- URL umgeht diese Link-Resolution vollständig und liefert immer die
  -- echte .ipynb-Datei.
  local download_url = string.format(
    "https://raw.githubusercontent.com/%s/%s/%s",
    repo, branch, relpath
  )

  -- HTML zusammenbauen
  local html = string.format([[
<div class="binder-bar">
  <a class="binder-badge" href="%s" target="_blank" rel="noopener">
    <img src="https://mybinder.org/badge_logo.svg" alt="Open in Binder">
  </a>
  <a class="binder-download" href="%s" target="_blank" rel="noopener">
    ⬇️ Notebook (.ipynb) öffnen
  </a>
</div>
]], binder_url, download_url)

  local block = pandoc.RawBlock("html", html)
  table.insert(doc.blocks, 1, block)

  return doc
end
