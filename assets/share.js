/* =========================================================
   ARS — publication share button
   Progressive enhancement. Any element with class "share-btn"
   becomes a share control. On phones and tablets it opens the
   device share sheet (WhatsApp, email, and so on). Elsewhere it
   opens a small menu with a copy-link option.
   Loaded by each publication page as: /assets/share.js
========================================================= */

(function () {

    "use strict";

    var buttons = document.querySelectorAll(".share-btn");

    if (!buttons.length) {
        return;
    }


    /* ---- what we are sharing ---- */

    function shareUrl() {

        var canonical =
            document.querySelector('link[rel="canonical"]');

        if (canonical && canonical.href) {
            return canonical.href;
        }

        return window.location.href.split("#")[0];
    }


    function shareTitle() {

        var og =
            document.querySelector('meta[property="og:title"]');

        if (og && og.content) {
            return og.content;
        }

        return document.title;
    }


    /* ---- styles, injected once ---- */

    var css =
        ".share-wrap{position:relative;display:inline-block}" +

        "button.share-btn{font-family:inherit;cursor:pointer;" +
        "background:#ffffff;line-height:normal}" +

        ".share-menu{position:absolute;z-index:40;top:calc(100% + 8px);left:0;" +
        "min-width:212px;background:#ffffff;border:1px solid #d7dfe7;" +
        "border-radius:4px;box-shadow:0 12px 30px rgba(9,43,82,.18);" +
        "padding:6px;display:none}" +

        ".share-menu.is-open{display:block}" +

        ".share-menu a,.share-menu button{display:flex;align-items:center;gap:11px;" +
        "width:100%;padding:9px 11px;border:0;border-radius:3px;background:none;" +
        "font-family:inherit;font-size:14px;font-weight:600;color:#092b52;" +
        "text-align:left;text-decoration:none;cursor:pointer}" +

        ".share-menu a:hover,.share-menu button:hover," +
        ".share-menu a:focus-visible,.share-menu button:focus-visible{" +
        "background:#f1f6fa;color:#0874d1;outline:none}" +

        ".share-menu svg{flex:0 0 17px;width:17px;height:17px}" +

        ".share-note{position:absolute;z-index:40;top:calc(100% + 8px);left:0;" +
        "background:#092b52;color:#ffffff;font-size:13px;font-weight:600;" +
        "padding:8px 13px;border-radius:4px;white-space:nowrap}" +

        "@media (max-width:760px){.share-menu{left:auto;right:0}}";

    var style = document.createElement("style");
    style.appendChild(document.createTextNode(css));
    document.head.appendChild(style);


    /* ---- icons ---- */

    var ICON = {

        whatsapp:
            '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">' +
            '<path d="M12 2a10 10 0 0 0-8.6 15.1L2 22l5-1.3A10 10 0 1 0 12 2zm0 18.2a8.2 8.2 0 0 1-4.2-1.2l-.3-.2-3 .8.8-2.9-.2-.3A8.2 8.2 0 1 1 12 20.2zm4.5-6.1c-.2-.1-1.5-.7-1.7-.8s-.4-.1-.5.1l-.8.9c-.1.2-.3.2-.5.1a6.7 6.7 0 0 1-3.3-2.9c-.1-.2 0-.4.1-.5l.4-.5.2-.4v-.4l-.7-1.7c-.2-.4-.4-.4-.5-.4h-.5a1 1 0 0 0-.7.3 3 3 0 0 0-1 2.2 5.3 5.3 0 0 0 1.1 2.8 12 12 0 0 0 4.6 4 5 5 0 0 0 3 .6 2.6 2.6 0 0 0 1.7-1.2 2.1 2.1 0 0 0 .1-1.2z"/>' +
            '</svg>',

        linkedin:
            '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">' +
            '<path d="M4.98 3.5a2.5 2.5 0 1 1 0 5 2.5 2.5 0 0 1 0-5zM3 9h4v12H3zM10 9h3.8v1.7h.05a4.2 4.2 0 0 1 3.75-2c4 0 4.4 2.5 4.4 5.8V21h-4v-5.2c0-1.3 0-3-1.8-3s-2.1 1.4-2.1 2.9V21h-4z"/>' +
            '</svg>',

        x:
            '<svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true">' +
            '<path d="M17.5 3h3.1l-6.8 7.8L21.8 21h-6.2l-4.9-6.4L5.1 21H2l7.3-8.3L2.4 3h6.3l4.4 5.8zm-1.1 16.1h1.7L7.7 4.8H5.9z"/>' +
            '</svg>',

        email:
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" ' +
            'stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
            '<rect x="2.5" y="4.5" width="19" height="15" rx="2"/>' +
            '<path d="m3 6 9 6.5L21 6"/>' +
            '</svg>',

        link:
            '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" ' +
            'stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' +
            '<path d="M10 13a4.5 4.5 0 0 0 6.6.5l2.6-2.6a4.6 4.6 0 0 0-6.5-6.5L11.5 6"/>' +
            '<path d="M14 11a4.5 4.5 0 0 0-6.6-.5l-2.6 2.6a4.6 4.6 0 0 0 6.5 6.5l1.2-1.2"/>' +
            '</svg>'
    };


    /* ---- flash message, used after copying ---- */

    function flash(wrap, text) {

        var note = document.createElement("div");
        note.className = "share-note";
        note.setAttribute("role", "status");
        note.textContent = text;
        wrap.appendChild(note);

        window.setTimeout(function () {
            if (note.parentNode) {
                note.parentNode.removeChild(note);
            }
        }, 2200);
    }


    function copyLink(wrap, url) {

        function fallback() {

            var box = document.createElement("textarea");
            box.value = url;
            box.setAttribute("readonly", "");
            box.style.position = "fixed";
            box.style.opacity = "0";
            document.body.appendChild(box);
            box.select();

            var ok = false;

            try {
                ok = document.execCommand("copy");
            } catch (e) {
                ok = false;
            }

            document.body.removeChild(box);
            flash(wrap, ok ? "Link copied" : "Press Ctrl+C to copy");
        }

        if (navigator.clipboard && navigator.clipboard.writeText) {

            navigator.clipboard.writeText(url).then(
                function () {
                    flash(wrap, "Link copied");
                },
                fallback
            );

            return;
        }

        fallback();
    }


    /* ---- the fallback menu ---- */

    function buildMenu(wrap, btn, url, title) {

        var menu = document.createElement("div");
        menu.className = "share-menu";

        var enc = encodeURIComponent;

        var links = [
            ["whatsapp", "WhatsApp",
             "https://wa.me/?text=" + enc(title + " " + url)],

            ["linkedin", "LinkedIn",
             "https://www.linkedin.com/sharing/share-offsite/?url=" + enc(url)],

            ["x", "X",
             "https://twitter.com/intent/tweet?text=" + enc(title) + "&url=" + enc(url)],

            ["email", "Email",
             "mailto:?subject=" + enc(title) + "&body=" + enc(title + "\n\n" + url)]
        ];

        links.forEach(function (item) {

            var a = document.createElement("a");
            a.href = item[2];
            a.rel = "noopener";

            if (item[0] !== "email") {
                a.target = "_blank";
            }

            a.innerHTML = ICON[item[0]] + "<span>" + item[1] + "</span>";
            menu.appendChild(a);
        });

        var copy = document.createElement("button");
        copy.type = "button";
        copy.innerHTML = ICON.link + "<span>Copy link</span>";

        copy.addEventListener("click", function () {
            close();
            copyLink(wrap, url);
        });

        menu.appendChild(copy);
        wrap.appendChild(menu);


        function close() {
            menu.classList.remove("is-open");
            btn.setAttribute("aria-expanded", "false");
            document.removeEventListener("click", onDocClick, true);
            document.removeEventListener("keydown", onKey, true);
        }

        function onDocClick(e) {
            if (!wrap.contains(e.target)) {
                close();
            }
        }

        function onKey(e) {
            if (e.key === "Escape" || e.key === "Esc") {
                close();
                btn.focus();
            }
        }

        return {

            toggle: function () {

                if (menu.classList.contains("is-open")) {
                    close();
                    return;
                }

                menu.classList.add("is-open");
                btn.setAttribute("aria-expanded", "true");
                document.addEventListener("click", onDocClick, true);
                document.addEventListener("keydown", onKey, true);
            }
        };
    }


    /* ---- wire up each button ---- */

    Array.prototype.forEach.call(buttons, function (btn) {

        var url = shareUrl();
        var title = shareTitle();

        var wrap = document.createElement("span");
        wrap.className = "share-wrap";
        btn.parentNode.insertBefore(wrap, btn);
        wrap.appendChild(btn);

        var menu = null;

        btn.addEventListener("click", function () {

            if (navigator.share) {

                navigator.share({ title: title, url: url })
                    .catch(function () {
                        /* the person dismissed the sheet — nothing to do */
                    });

                return;
            }

            if (!menu) {
                menu = buildMenu(wrap, btn, url, title);
            }

            menu.toggle();
        });
    });

}());
