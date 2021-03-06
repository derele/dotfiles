// my home is my google
homepage='http://www.google.com';
define_key(content_buffer_normal_keymap, "h", "home");

// the editor
user_pref(editor_shell_command='emacsclient');
user_pref(edit_field_in_external_editor_extension='html');

// some keys
define_key(content_buffer_normal_keymap, "d", "follow-new-buffer");
define_key(content_buffer_normal_keymap, "M-\u00FC", "buffer-previous");
define_key(content_buffer_normal_keymap, "M-\u00F6", "buffer-next");

// prevent pdf crashes
user_pref('plugin.state.libevbrowserplugin', 0); 

interactive("zotero-bookmark", "load into Zotero", "follow",
            $browser_object = "javascript:var%20d=document,s=d.createElement('script');s.src='https://www.zotero.org/bookmarklet/loader.js';(d.body?d.body:d.documentElement).appendChild(s);void(0);");
define_key(content_buffer_normal_keymap, "z", "zotero-bookmark");

//have tabs
require("favicon.js");
require("new-tabs.js");
//require("tab-bar.js");

tab_bar_show_icon = true;
tab_bar_show_index = true;

// a session to remember
require("session.js");
session_auto_save_auto_load = true;
//session_auto_save_auto_load = false;

// and google in the minibuffer
//require("search-engine.js");

//define_mime_type_external_handler("application/pdf", "xpdf");
//define_mime_type_external_handler("pdf", "xpdf");

//define_mime_type_handler("application/pdf", "xpdf");
//define_mime_type_handler("pdf", "xpdf");

//open from command line in same window new tab
//form: http://lifealgorithms.wordpress.com/tag/emacs/
url_remoting_fn = load_url_in_new_buffer;

//define_webjump("shortMemo", "url-with-%s-for-substitutes");

user_pref("extensions.checkCompatibility", false);

require("user-agent-policy");
// Tell Google Calendar that we are Firefox not Conkeror:
user_agent_policy.define_policy(
    "GCal",
    user_agent_firefox(),
    build_url_regexp($domain = /(.*\.)?google/, $path = /calendar/)
);

set_protocol_handler("mailto", "https://mail.google.com/mail/?extsrc=mailto&url=%s");


// block auto focus events 
// one imperfect solution
// require("block-content-focus-change.js");

// and a second method
// function focusblock (buffer) {
//     var s = Components.utils.Sandbox(buffer.top_frame);
//     s.document = buffer.document.wrappedJSObject;
//     Components.utils.evalInSandbox(
//         "(function () {\
//             function nothing () {}\
//             if (! document.forms)\
//                 return;\
//             for (var i = 0, nforms = document.forms.length; i < nforms; i++) {\
//               for (var j = 0, nels = document.forms[i].elements.length; j < nels; j++)\
//                 document.forms[i].elements[j].focus = nothing;\
//             }\
// })();",
//         s);
// }
// add_hook('content_buffer_progress_change_hook', focusblock);



// //set the proxy server for this session only
// proxy_server_default = "192.168.2.2";
// proxy_port_default = 3128;

// function set_proxy_session (window, server, port) {
//     if (server == "N") {
//         session_pref('network.proxy.type', 0); //direct connection
//         window.minibuffer.message("Direction connection to the internet enabled for this session");
//     } else {
//         if (server == "") server = proxy_server_default;
//         if (port == "") port = proxy_port_default;

//         session_pref('network.proxy.ftp',    server);
//         session_pref('network.proxy.gopher', server);
//         session_pref('network.proxy.http',   server);
//         session_pref('network.proxy.socks',  server);
//         session_pref('network.proxy.ssl',    server);

//         session_pref('network.proxy.ftp_port',    port);
//         session_pref('network.proxy.gopher_port', port);
//         session_pref('network.proxy.http_port',   port);
//         session_pref('network.proxy.socks_port',  port);
//         session_pref('network.proxy.ssl_port',    port);

//         session_pref('network.proxy.share_proxy_settings', true);
//         session_pref('network.proxy.type', 1);

//         window.minibuffer.message("All protocols using "+server+":"+port+" for this session");
//     }
// }

// interactive("set-proxy-session",
//     "set the proxy server for all protocols for this session only",
//     function (I) {
//         set_proxy_session(
//             I.window,
//             (yield I.minibuffer.read($prompt = "server ["+proxy_server_default+"] or N: ")),
//             (yield I.minibuffer.read($prompt = "port ["+proxy_port_default+"]: ")));
//     });


// interactive("bibsonomy-post-publication",  
//             "Post a publication to Bibsonomy. Either uses the URL and scrapes the page, or sends the selected bibtex.", 
//             function (I) {
//               var element = yield read_browser_object(I);
//               var spec = load_spec(element);
//               newspec = 'http://www.bibsonomy.org/BibtexHandler?requTask=upload&url='+encodeURIComponent(load_spec_uri_string(spec))+'&description='+encodeURIComponent(load_spec_title(spec))+'&selection='+encodeURIComponent(I.buffer.top_frame.getSelection());
//               browser_object_follow(I.buffer, OPEN_CURRENT_BUFFER, newspec);
//             },
//             $browser_object = browser_object_frames);
// define_key(content_buffer_normal_keymap, "C-c b", "bibsonomy-post-publication");

// // TODO: Make me work 
// interactive ("citeulike-post", "post the current location to citeulike",
//              function (I) {
//                  check_buffer(I.buffer, content_buffer);
//                  let title = I.buffer.title;
                 
//                  I.buffer.load("http://www.citeulike.org/posturl?username=USER&bml=nopopup&url="+encodeURIComponent(url)+'&title='+encodeURIComponent(title));
//              });

// // Thanks to Mark Roddy giving me this function on the conkeror mailing list
// function shell_on_url(funcname, funcdesc, cmd) {
//     //Create an interactive function for running a predetermined
//     //shell command on a url
//     //Bind a specific shell command for a url to 'functionname'

//     //Taken largely from "shell-command-on-url"  and
//     //"shell-command-on-file" in commands.js
//     interactive(funcname, funcdesc,
//         function (I) {
//             var cwd = I.local.cwd;
//             var element = yield read_browser_object(I);
//             var spec = load_spec(element);
//             var uri = load_spec_uri_string(spec);
//             shell_command_with_argument_blind(cmd, uri, $cwd = cwd);
//         },
//         $browser_object = browser_object_links);
// }

// shell_on_url("w3m-on-url", "Open a url in emacs w3m mode","emacs-web.sh");
// shell_on_url("w3m-beagle-on-url", "Open a url in emacs w3m mode on my server beagle","emacs-beagle-web.sh");
// define_key(content_buffer_normal_keymap, "C-c w", "w3m-on-url");
// define_key(content_buffer_normal_keymap, "C-c r", "w3m-beagle-on-url");

// function shell_own(funcname, funcdesc, cmd, what) {
//     interactive(funcname, funcdesc,
//                 function (I) {
//                     shell_command_with_argument_blind(cmd, what,  $cwd = cwd);
//                 }
//                 );
// }

// shell_own("emms-pause", "pause emms music", "emacsclient-eval.sh", "emms-pause");
// define_key(content_buffer_normal_keymap, "C-c m h", "emms-pause");

// shell_own("emms-previouse", "previouse emms music", "emacsclient-eval.sh", "emms-previous");
// define_key(content_buffer_normal_keymap, "C-c m p", "emms-previouse");

// shell_own("emms-volume-raise", "emms music louder", "emacsclient-eval.sh", "emms-volume-raise");
// define_key(content_buffer_normal_keymap, "C-c m +", "emms-volume-raise");

// shell_own("emms-next", "pause emms music", "emacsclient-eval.sh", "emms-next");
// define_key(content_buffer_normal_keymap, "C-c m n", "emms-next");

// shell_own("emms-volume-lower", "lower emms music volume", "emacsclient-eval.sh", "emms-volume-lower");
// define_key(content_buffer_normal_keymap, "C-c m -", "emms-volume-lower");

// shell_own("emms-random", "play random track", "emacsclient-eval.sh", "emms-random");
// define_key(content_buffer_normal_keymap, "C-c m r", "emms-random");
