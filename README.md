# animex-captcha-turnstile

AnimEx module — Cloudflare Turnstile widgets.

All client-side logic lives in this app's `priv/static/module.js`, which
`AnimEx.Web.Live.Modules` inlines into the document head at boot (same
pattern as the auth modules). It lazily loads the Cloudflare api.js only
when a widget is present, renders it explicitly, stores tokens, and
dispatches claims back to the host app.

## Component

```heex
<.turnstile
  sitekey={@turnstile_site_key}
  action="mine_claim"
  target="Mines"
  token_key="mineTurnstileToken"
  button="#my-claim-btn"
  theme="light"
/>
```

Attributes:

| attr        | description                                                              | default                |
|-------------|--------------------------------------------------------------------------|------------------------|
| `sitekey`   | Cloudflare Turnstile site key (required)                                  | —                      |
| `action`    | Challenge action, also used as the app event action on claim              | `nil` (no CF action)   |
| `target`    | Host LiveView target after `app:` — e.g. `"Mines"` → `app:Mines`          | `nil` (no claim wiring)|
| `token_key` | `window` key holding the current token                                    | `"animexTurnstileToken"` |
| `button`    | Selector of the claim button this widget gates                            | `nil`                  |
| `theme`     | Turnstile theme (`auto`, `light`, `dark`)                                 | `"auto"`               |

Basic/Geometry/JavaScript attrs (`id`, `width`, `class`, `hook`, …) pass
through to the widget container like any AnimEx component.

## Behaviour

- On a successful challenge the token is stored on `window[token_key]` and
  the claim button is enabled (expired/error reset both).
- Clicking the claim button dispatches `app:<target>` with
  `{action: <action>, params: {turnstile_token: token}}` via a hidden
  `[live-click]` button, then resets the widget and re-disables the button
  until the next token resolves.
- The event handler on the target view should accept both shapes, the same
  way the auth modules do:

```elixir
def event(:mine_claim, params, visuals) when is_binary(params) do
  case Jason.decode(params) do
    {:ok, decoded} when is_map(decoded) -> event(:mine_claim, decoded, visuals)
    _ -> []
  end
end

def event(:mine_claim, params, visuals) when is_map(params) do
  token = params["turnstile_token"]
  ...
end
```
