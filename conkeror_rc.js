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


interactive("zotero-bookmark", "load into Zotero", "follow",
            $browser_object = "javascript:var%20d=document,s=d.createElement('script');s.src='https://www.zotero.org/bookmarklet/loader.js';(d.body?d.body:d.documentElement).appendChild(s);void(0);");
define_key(content_buffer_normal_keymap, "z", "zotero-bookmark");

//have tabs, a session and google in the minibuffer
require("new-tabs.js");

require("session.js");
session_auto_save_auto_load = true;

require("search-engine.js");

//open from command line in same window new tab
//form: http://lifealgorithms.wordpress.com/tag/emacs/
url_remoting_fn = load_url_in_new_buffer;

//define_webjump("shortMemo", "url-with-%s-for-substitutes");

user_pref("extensions.checkCompatibility", false);

// block auto focus events 
// one imperfect solution
require("block-content-focus-change.js");

// and a second method
function focusblock (buffer) {
    var s = Components.utils.Sandbox(buffer.top_frame);
    s.document = buffer.document.wrappedJSObject;
    Components.utils.evalInSandbox(
        "(function () {\
            function nothing () {}\
            if (! document.forms)\
                return;\
            for (var i = 0, nforms = document.forms.length; i < nforms; i++) {\
              for (var j = 0, nels = document.forms[i].elements.length; j < nels; j++)\
                document.forms[i].elements[j].focus = nothing;\
            }\
})();",
        s);
}
add_hook('content_buffer_progress_change_hook', focusblock);


interactive("bibsonomy-post-publication",  
            "Post a publication to Bibsonomy. Either uses the URL and scrapes the page, or sends the selected bibtex.", 
            function (I) {
              var element = yield read_browser_object(I);
              var spec = load_spec(element);
              newspec = 'http://www.bibsonomy.org/BibtexHandler?requTask=upload&url='+encodeURIComponent(load_spec_uri_string(spec))+'&description='+encodeURIComponent(load_spec_title(spec))+'&selection='+encodeURIComponent(I.buffer.top_frame.getSelection());
              browser_object_follow(I.buffer, OPEN_CURRENT_BUFFER, newspec);
            },
            $browser_object = browser_object_frames);
define_key(content_buffer_normal_keymap, "C-c b", "bibsonomy-post-publication");


// TODO: Make me work 
interactive ("citeulike-post", "post the current location to citeulike",
             function (I) {
                 check_buffer(I.buffer, content_buffer);
                 let title = I.buffer.title;
                 
                 I.buffer.load("http://www.citeulike.org/posturl?username=USER&bml=nopopup&url="+encodeURIComponent(url)+'&title='+encodeURIComponent(title));
             });

// Thanks to Mark Roddy giving me this function on the conkeror mailing list
function shell_on_url(funcname, funcdesc, cmd) {
    //Create an interactive function for running a predetermined
    //shell command on a url
    //Bind a specific shell command for a url to 'functionname'

    //Taken largely from "shell-command-on-url"  and
    //"shell-command-on-file" in commands.js
    interactive(funcname, funcdesc,
        function (I) {
            var cwd = I.local.cwd;
            var element = yield read_browser_object(I);
            var spec = load_spec(element);
            var uri = load_spec_uri_string(spec);
            shell_command_with_argument_blind(cmd, uri, $cwd = cwd);
        },
        $browser_object = browser_object_links);
}

shell_on_url("w3m-on-url", "Open a url in emacs w3m mode","emacs-web.sh");
shell_on_url("w3m-beagle-on-url", "Open a url in emacs w3m mode on my server beagle","emacs-beagle-web.sh");
define_key(content_buffer_normal_keymap, "C-c w", "w3m-on-url");
define_key(content_buffer_normal_keymap, "C-c r", "w3m-beagle-on-url");

function shell_own(funcname, funcdesc, cmd, what) {
    interactive(funcname, funcdesc,
                function (I) {
                    shell_command_with_argument_blind(cmd, what,  $cwd = cwd);
                }
                );
}

shell_own("emms-pause", "pause emms music", "emacsclient-eval.sh", "emms-pause");
define_key(content_buffer_normal_keymap, "C-c m h", "emms-pause");

shell_own("emms-previouse", "previouse emms music", "emacsclient-eval.sh", "emms-previous");
define_key(content_buffer_normal_keymap, "C-c m p", "emms-previouse");

shell_own("emms-volume-raise", "emms music louder", "emacsclient-eval.sh", "emms-volume-raise");
define_key(content_buffer_normal_keymap, "C-c m +", "emms-volume-raise");

shell_own("emms-next", "pause emms music", "emacsclient-eval.sh", "emms-next");
define_key(content_buffer_normal_keymap, "C-c m n", "emms-next");

shell_own("emms-volume-lower", "lower emms music volume", "emacsclient-eval.sh", "emms-volume-lower");
define_key(content_buffer_normal_keymap, "C-c m -", "emms-volume-lower");

shell_own("emms-random", "play random track", "emacsclient-eval.sh", "emms-random");
define_key(content_buffer_normal_keymap, "C-c m r", "emms-random");

