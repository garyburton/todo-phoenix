// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

import { Socket } from "phoenix";
import LiveSocket from "phoenix_live_view";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

let Hooks = {};
Hooks.Todo = {
  mounted() {
    this.el.addEventListener("dblclick", (e) => {
      const toggle = this.el.querySelector(".toggle");

      this.pushEvent("edit", {
        "todo-id": toggle.getAttribute("phx-value-todo-id"),
      });
    });
  },
  updated() {
    const edit = this.el.querySelector(".edit");
    edit.focus();
    edit.setSelectionRange(edit.value.length, edit.value.length);
  },
};

const csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
const liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket;
