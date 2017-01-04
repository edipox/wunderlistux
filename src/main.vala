using Gtk;
using Soup;
using WebKit;


public class WunderlistuxConfig {
	const string home_dir_subdir = ".wunderlistux";

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


    public signal void save_state();
    public int opening_x;
    public int opening_y;
    public int window_width;
    public int window_height;


    public GLib.Settings settings;

    public Wunderlistux () {
      this.opening_x = -1;
      this.opening_y = -1;
      this.window_width = -1;
      this.window_height = -1;
      this.delete_event.connect (on_delete_event);

      // Set up geometry
      Gdk.Geometry geo = new Gdk.Geometry();
      geo.min_width = 720;
      geo.min_height = 700;
      geo.max_width = 2775;
      geo.max_height = 2048;

      this.set_geometry_hints(null, geo, Gdk.WindowHints.MIN_SIZE | Gdk.WindowHints.MAX_SIZE);

      this.settings = new GLib.Settings ("org.wunderlistux.wunderlist");

      // restore main window size and position
      this.opening_x = settings.get_int ("opening-x");
      this.opening_y = settings.get_int ("opening-y");
      this.window_width = settings.get_int ("window-width");
      this.window_height = settings.get_int ("window-height");

      this.restore_window ();

      try {
          this.protocol_regex = new Regex (".*://.*");
      } catch (RegexError e) {
          critical ("%s", e.message);
      }

      create_widgets ();
      connect_signals ();
    }

    private bool on_delete_event () {
        this.save_window ();
        this.save_state();
        base.hide_on_delete ();
        return true;
    }

    public void save_window () {
        this.get_position (out opening_x, out opening_y);
        this.get_size (out window_width, out window_height);
    }

    public void restore_window () {
        if (this.opening_x > 0 && this.opening_y > 0){
            this.move (this.opening_x, this.opening_y);
        }
        if( this.window_width > 0 && this.window_height > 0 ) {
            this.resize (this.window_width, this.window_height);
        }
    }

    public override void show () {
        base.show ();
        this.restore_window ();
    }

    private void create_widgets () {
        this.notifications_button = new ToolButton(null, null);

        Image img = new Image.from_icon_name ("wunderlist-notifications", Gtk.IconSize.SMALL_TOOLBAR);
        this.notifications_button.set_icon_widget (img);
        this.conversations_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("wunderlist-conversations", Gtk.IconSize.SMALL_TOOLBAR);
        this.conversations_button.set_icon_widget (img);
        this.sort_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("wunderlist-sort", Gtk.IconSize.SMALL_TOOLBAR);
        this.sort_button.set_icon_widget (img);
        this.more_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("wunderlist-more", Gtk.IconSize.SMALL_TOOLBAR);
        this.more_button.set_icon_widget (img);
        this.share_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("wunderlist-share", Gtk.IconSize.SMALL_TOOLBAR);
        this.share_button.set_icon_widget (img);


        this.web_view = new WebView ();
        this.home_subdir = WunderlistuxConfig.get_dir();
		    DirUtils.create(this.home_subdir, 0700);
        this.web_view.web_context.get_cookie_manager().set_persistent_storage(Path.build_filename(this.home_subdir, "cookies.txt"), WebKit.CookiePersistentStorage.TEXT);
        var scrolled_window = new ScrolledWindow (null, null);
        scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add (this.web_view);

				// add headerbar with button
				Gtk.HeaderBar headerbar = new Gtk.HeaderBar();
        headerbar.show_close_button = true;
        var box = new Box (Orientation.HORIZONTAL, 0);
        headerbar.title = "Wunderlistux";
				box.pack_start(this.notifications_button, false, false, 12);
				box.pack_end(this.conversations_button, false, false, 8);
        var group_box = new Box (Orientation.HORIZONTAL, 0);
        group_box.pack_start (this.sort_button, false, false, 10);
        group_box.pack_end (this.share_button, false, true, 13);
        group_box.pack_end (this.more_button, false, false, 0);
        this.set_titlebar(headerbar);

        var vbox = new VBox (false, 0);
				vbox.add (scrolled_window);
        headerbar.pack_start(box);
        headerbar.pack_end(group_box);
        add (vbox);

        this.destroy.connect(on_exit);
        this.hide.connect(on_exit);
        this.remove.connect(on_exit);
    }

    public void load_styles(){
      var style = "#user-toolbar{ display:none; } #list-toolbar{ position: absolute!important; top: -48px!important; right: 32px!important;  } .popover{ left: 20px!important; top: 4px!important; } #wunderlist-base .popover.bottom .arrow{ display: none!important; }";
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

    private void on_exit() {
      // save window size and position
      int x, y, w, h;
      this.get_position (out x, out y);
      this.get_size (out w, out h);
      this.settings.set_int ("opening-x", x);
      this.settings.set_int ("opening-y", y);
      this.settings.set_int ("window-width", w);
      this.settings.set_int ("window-height", h);
    }


    public static int main (string[] args) {
        Gtk.init (ref args);

        var win = new Wunderlistux ();
        win.start ();

        Gtk.main ();

        return 0;
    }
}
