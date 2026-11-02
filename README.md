# animex-captcha-turnstile

AnimEx module — client glue for Cloudflare Turnstile widgets.

## Attributes

Widget container:

```html
<div
  id="my-widget"
  data-animex-turnstile-widget
  data-sitekey="<SITEKEY>"
  data-action="my_action"
  data-token-key="myTurnstileToken"
  data-button="#my-claim-btn"
  data-theme="auto"
></div>
```

Claim button:

```html
<button
  id="my-claim-btn"
  data-animex-turnstile-claim
  data-token-key="myTurnstileToken"
  data-app-target="my_view"
  data-action="my_action"
  disabled
>
  Claim
</button>
```

On successful challenge completion the button is enabled. Clicking it pushes
`app:<app-target>` with `{action: <action>, params: {turnstile_token: <token>}}`,
then resets the widget for reuse.
