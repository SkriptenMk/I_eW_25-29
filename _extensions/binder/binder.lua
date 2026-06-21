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

  -- Relativen Download-Pfad berechnen.
  -- Die Ausgabe-HTML liegt unter docs/<relpath_ohne_.ipynb>.html, also auf
  -- derselben Verschachtelungstiefe wie das Notebook. Die .ipynb-Resource wird
  -- nach docs/<relpath> kopiert → der Link ist nur der Dateiname.
  -- Damit funktioniert der Download unabhängig vom Pages-Unterverzeichnis.
  local filename = relpath:match("([^/]+)$")
  local local_url = filename

  -- HTML zusammenbauen
  local html = string.format([[
<div class="binder-bar">
  <a class="binder-badge" href="%s" target="_blank" rel="noopener">
    <img src="https://mybinder.org/badge_logo.svg" alt="Open in Binder">
  </a>
  <a class="binder-download" href="%s" download>
    ⬇️ Notebook (.ipynb) herunterladen
  </a>
</div>
]], binder_url, local_url)

  local block = pandoc.RawBlock("html", html)
  table.insert(doc.blocks, 1, block)

  return doc
end
