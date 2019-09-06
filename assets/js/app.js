// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"



(function () {
  var burger = document.querySelector(".burger");
  var nav = document.querySelector("#" + burger.dataset.target);

  burger.addEventListener("click", function () {
    burger.classList.toggle("is-active");
    nav.classList.toggle("is-active");
  });
})();
