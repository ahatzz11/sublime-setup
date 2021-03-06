#### Install Package Control

To open the sublime terminal:

    ctrl+`
  
run this command:
  
    import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
  
Congrats, now your sublime has package manager! To find any other packages you might want head over to http://packagecontrol.io. Once you find what you want, you can install through the command that I will go over below.


#### How to install packages

To install a package you must open the command palette. This is reachable through Tools->Command Palette. The shortcut for this is cmd+shift+p. In the command palette there a lot of different commands. The one you want is "Package Control: Install Package". If you type in "install" it should pop up right away. Now you're in the install packages section, you can search for any package on http://packagecontrol.io and it will automatically install. neat, right?

Other useful commands on the pallete:

<pre><code>"Package Control: List Packages"
"Package Control: Remove Packages"
"Package Control: Disable Packages"
</code></pre>


####  My favorite packages

- AngularJS
  - auto completion, snippets, etc.
- BracketHighlighter
  - highlights whatever bracket/quotes you are currently in. nice for scope
- HTML5
  - autocompletion of html5 elements. pretty much every language has one of these
- Origami
  - allows you to move windows around very easily
- Theme - SetiUI/SetiUX
  - changes colors/theme
- TrailingSpaces
  - utility to highlight and remove any trailing spaces in your code. great for those who like clean code.


#### AngularJS

There are recommended settings by the developers that you should follow. Add the following code to your user settings in sublime. Sublime Text -> Preferences -> Settings-User

    // add for auto triggering controller completions within the ng-controller=""
	"auto_complete_triggers":
    [
        {
            "characters": "ng-controller=\"*",
            "selector": "punctuation.definition.string"
        }
    ],

    "auto_complete_selector": "source - comment, meta.tag - punctuation.definition.tag.begin, text.haml",



You can also find them on the [github repo](https://github.com/angular-ui/AngularJS-sublime-package#user-content-recommended-settings).

#### Origami

- cmd+k, cmd+[arrow_direction] will create a new window in the direction you specified
- cmd+k, cmd+shift+[arrow_direction] will kill the window in the direction you specified

There are a lot more commands, but those are the two that I use 95% of the time. To find more options, go to View -> Origami

#### Theme & Color Settings
The colors and the theme are separate in sublime. To use seti for both of these, copy paste the following in the sublime-users folder. Sublime Text -> Preferences -> Settings-User

<pre><code>{
	"color_scheme": "Packages/Seti_UX/Seti.tmTheme",
    	"theme": "Seti.sublime-theme",
}
</code></pre>



You will need to restart sublime to see the new theme.

#### Trailing Spaces

Go to Sublime Text -> Preferences -> Package Settings -> Trailing Spaces -> Settings-User and paste:

<pre><code>{ 
	"trailing_spaces_trim_on_save": true,
	"trailing_spaces_include_current_line": false 
}
</code></pre>

This will remove trailing spaces every time you save. It also makes it so the current line doesn't highlight spaces. This becomes annoying when coding and having the highlighter keep popping up. Now go to Sublime Text -> Preferences -> Key Bindings-User and paste:
<code><pre>[
	{ "keys":["ctrl+shift+t"], "command":"delete_trailing_spaces"},
	{ "keys":["ctrl+shift+d"], "command": "toggle_trailing_spaces"}
]
</code></pre>

You now have those key bindings set! 
- ctrl+shift+t will delete all trailing spaces in your file
- ctrl+shift+d will toggle the highlighting on trailing spaces

# Setting Up Sublime Text 3

#### Opening files from terminal

Right click on "Sublime Text" in your applications folder and select "Show Package Contents". From here navigate to Sublime Text/Contents/Resources/app. In this repo is a file called "Sublime.sh". Download this and put it in the app folder, you may have to create this app folder. Now you can open files directly in sublime from terminal.
	
    $ sublime index.html	
    
    ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

