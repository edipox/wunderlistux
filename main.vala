using Gtk;
using Soup;
using WebKit;


public class DorisConfig {
	const string home_dir_subdir = ".doris";

	public static string get_dir() {
		return Path.build_filename(GLib.Environment.get_variable("HOME"), home_dir_subdir);
	}

	public static string get_path(string file) {
		return Path.build_filename(GLib.Environment.get_variable("HOME"), home_dir_subdir, file);
	}
}


public class Wunderlistux :  Window {

    private const string HOME_URL = "https://www.wunderlist.com/webapp";
    private const string DEFAULT_PROTOCOL = "https";

    private Regex protocol_regex;

    private WebView web_view;
    private ToolButton notifications_button;
    private ToolButton conversations_button;

    private ToolButton sort_button;
    private ToolButton share_button;
    private ToolButton more_button;
    private string home_subdir;

    public Wunderlistux () {
        set_default_size (800, 600);

        try {
            this.protocol_regex = new Regex (".*://.*");
        } catch (RegexError e) {
            critical ("%s", e.message);
        }

        create_widgets ();
        connect_signals ();
    }

    private void create_widgets () {
        this.notifications_button = new ToolButton(null, null);

		    Image img = new Image.from_icon_name ("notification-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.notifications_button.set_icon_widget (img);
        this.conversations_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("media-view-subtitles-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.conversations_button.set_icon_widget (img);
        this.sort_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("view-sort-ascending-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.sort_button.set_icon_widget (img);
        this.more_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("view-more-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.more_button.set_icon_widget (img);
        this.share_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("contact-new-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.share_button.set_icon_widget (img);

				// Create the window of this application and show it
				this.set_default_size (550, 680);
        this.web_view = new WebView ();
        this.home_subdir = DorisConfig.get_dir();
		    DirUtils.create(this.home_subdir, 0700);
        this.web_view.web_context.get_cookie_manager().set_persistent_storage(Path.build_filename(this.home_subdir, "cookies.txt"), WebKit.CookiePersistentStorage.TEXT);
        var scrolled_window = new ScrolledWindow (null, null);
        scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add (this.web_view);

				// add headerbar with button
				Gtk.HeaderBar headerbar = new Gtk.HeaderBar();
        headerbar.show_close_button = true;
        var box = new Box (Orientation.HORIZONTAL, 3);
        headerbar.title = "Window";
				box.add(this.notifications_button);
				box.add(this.conversations_button);
        var group_box = new Box (Orientation.HORIZONTAL, 3);
        group_box.pack_start (this.sort_button, false, false, 0);
        group_box.pack_end (this.share_button, false, false, 0);
        group_box.pack_end (this.more_button, false, false, 0);
        this.set_titlebar(headerbar);
        var vbox = new VBox (false, 0);
				vbox.add (scrolled_window);
        headerbar.pack_start(box);
        headerbar.pack_end(group_box);
        add (vbox);
    }

    public void load_styles(){
      var style = "#user-toolbar .stream-counts{ position: absolute!important; top: -5%!important; left: 47%!important; } #list-toolbar{ position: absolute!important; top: -48px!important; right: 32px!important; } .popover{ left: 20px!important; top: 4px!important; } #wunderlist-base .popover.bottom .arrow{ display: none!important; }";
      var script = "jQuery('#window_theme_container').remove(); ";
      script = script + "jQuery('<style id=\"window_theme_container\">"+ style +"</style>').appendTo('body');";
      this.web_view.run_javascript(script, null);
    }

    private void connect_signals () {
        this.destroy.connect (Gtk.main_quit);
        this.web_view.resource_load_started.connect (load_styles);
        this.conversations_button.clicked.connect ((args) => {
          this.web_view.run_javascript("jQuery('[data-path=\"conversations\"]').click()", null);
        });
        this.notifications_button.clicked.connect ((args) => {
          this.web_view.run_javascript("jQuery('[data-path=\"activities\"]').click()", null);
        });
        this.share_button.clicked.connect ((args) => {
          this.web_view.run_javascript("jQuery('[data-menu=\"share\"]').click()", null);
        });
        this.sort_button.clicked.connect ((args) => {
          this.web_view.run_javascript("jQuery('[data-menu=\"sort\"]').click()", null);
        });
        this.more_button.clicked.connect ((args) => {
          this.web_view.run_javascript("jQuery('[data-menu=\"more\"]').click()", null);
        });
    }

    public void start () {
        show_all ();
        this.web_view.load_uri (Wunderlistux.HOME_URL);
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var browser = new Wunderlistux ();
        browser.start ();

        Gtk.main ();

        return 0;
    }
}
