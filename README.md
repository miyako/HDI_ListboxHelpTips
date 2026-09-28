# HDI_ListboxHelpTips

A 4D **HDI** (How Do I) example project demonstrating how to show a dynamic,
per-cell help tip on a list box, driven by the underlying record rather than
a static column tooltip.

## Origin

This project started as a binary `.4DB` example database originally
distributed with 4D v17. It was converted to the modern project architecture
(`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then
modernised (syntax, localisation, dark mode) with the help of **GitHub
Copilot**.

- **Blog post:** https://blog.4d.com/help-tips-on-list-boxes/
- **Original download:** https://download.4d.com/Demos/4D_v16_R5/HDI_ListboxHelpTips.zip

## Features

- A **list box help tip** (`OBJECT SET HELP TIP`) recomputed on every
  `On Mouse Move`, showing a different message depending on which column the
  mouse is hovering over and which record the row under the cursor
  represents.
- **Column 1 ("Word")** shows the record's own `Definition` field as the
  help tip; **column 2 ("Definition")** shows a templated message
  ("Click on the cell to go to the "*word*" definition.") built with
  `Localized string` + `Replace string`.
- **Click-through to a definition**: clicking a cell in the "Definition"
  column opens the record's `Link` URL (`OPEN URL`) in the default browser.
- Tip delay tuning via `SET DATABASE PARAMETER(Tips delay; ...)` -- near
  instant (1/60s) while hovering the list box, restored to the normal 2
  seconds on `On Mouse Leave`.
- A two-record `[INFO]` table feeding the explanatory text on the splash and
  demo forms, loaded once on `On Load`.
- Modern startup pattern: `CALL WORKER`, non-blocking `DIALOG(...;*)`,
  window-reuse detection, `Form`-scoped state instead of interprocess
  variables.
- Full **dark mode** support (`automatic`/`automaticAlternate` fills and
  strokes) and **Liquid Glass**-aware button sizing for macOS Tahoe.
- English and Japanese **XLIFF localisation** for every UI string.
- Modern `#DECLARE` / `var` syntax throughout (no deprecated `C_*`
  directives).

## Points of Interest

| Area | File(s) | Notes |
|------|---------|-------|
| Per-cell help tip logic | `Project/Sources/Forms/HDI2/ObjectMethods/LB.4dm` | Central `Case of` handler for `On Mouse Enter`/`On Mouse Move`/`On Clicked`/`On Mouse Leave`; uses `LISTBOX GET CELL POSITION` (both the four- and two-parameter forms) to resolve the hovered/clicked cell to a `[DICO]` record. |
| Templated help tip text | same file, via `Localized string("HDI2_TipGoToDefinition")` + `Replace string` | The `{word}` placeholder is substituted with the record's `Word` field so every cell gets a tip specific to its row. |
| Data model | `Project/Sources/catalog.4DCatalog` (`[DICO]` table: `Word`, `Definition`, `Link`) | One record per glossary term; `Link` is opened directly via `OPEN URL` when its "Definition" cell is clicked. |
| Sample data loading | `Project/Sources/Forms/HDI2/method.4dm` (`On Load`) | Loads all `[DICO]`/`[INFO]` records and caches the two `[INFO]` description strings used by the demo form. |
| Startup / window management | `Project/Sources/Methods/00_Start.4dm`, `Project/Sources/Forms/HDI/ObjectMethods/BtnDemo.4dm` | Non-blocking `DIALOG(...;*)` splash pattern with window-reuse detection and `Form`-scoped state instead of interprocess variables. |

## Project Structure

```
Project/Sources/
  Forms/HDI/              Splash/startup form and its BtnDemo object method
  Forms/HDI2/              Main demo form: list box, help tip logic
  TableForms/1/, 2/        Input/output forms for [DICO] and [INFO]
  Methods/                 Startup and compiler declaration methods
  styleSheets*.css         Dark mode + Liquid Glass button sizing
Resources/
  en.lproj/, ja.lproj/     XLIFF localisation (English source, Japanese target)
```

## Localisation

All user-facing text (menu items, form labels, splash/close button, list box
help tips) is resolved via `:xliff:` references or `Localized string(...)`,
backed by `Resources/en.lproj/` (source) and `Resources/ja.lproj/`
(Japanese): `menuEN/JA.xlf`, `HDIEN/JA.xlf`, `HDI2EN/JA.xlf`,
`messagesEN/JA.xlf`, and `TableFormsEN/JA.xlf`. Add further `{lang}.lproj`
folders to support additional languages.

## References

- `OBJECT SET HELP TIP`: https://developer.4d.com/docs/commands/object-set-help-tip
- `LISTBOX GET CELL POSITION`: https://developer.4d.com/docs/commands/listbox-get-cell-position
- `SET DATABASE PARAMETER` (`Tips delay`): https://developer.4d.com/docs/commands/set-database-parameter
- `OPEN URL`: https://developer.4d.com/docs/commands/open-url
- CSS in 4D (dark mode, Liquid Glass): https://developer.4d.com/docs/FormEditor/stylesheets
