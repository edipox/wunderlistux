using Gtk;
using WebKit;

public class Wunderlistux :  Window {

    // private const string TITLE = "Wunderlistux";
    private const string HOME_URL = "https://www.wunderlist.com/#/lists/inbox";
    private const string DEFAULT_PROTOCOL = "https";

    private Regex protocol_regex;

    // private Entry url_bar;
    private WebView web_view;
    // private Label status_bar;
    private ToolButton notifications_button;
    private ToolButton conversations_button;

    private ToolButton sort_button;
    private ToolButton share_button;
    private ToolButton more_button;

    public Wunderlistux () {
        // this.title = Wunderlistux.TITLE;
        set_default_size (800, 600);

        try {
            this.protocol_regex = new Regex (".*://.*");
        } catch (RegexError e) {
            critical ("%s", e.message);
        }

        create_widgets ();
        connect_signals ();
        // this.url_bar.grab_focus ();
    }

    private void create_widgets () {
        // var toolbar = new Toolbar ();
        this.notifications_button = new ToolButton(null, null);//.from_stock (Stock.SORT_ASCENDING);

		    Image img = new Image.from_icon_name ("notification-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.notifications_button.set_icon_widget (img);
        this.conversations_button = new ToolButton(null, null);//.from_stock (Stock.SORT_DESCENDING);
        img = new Image.from_icon_name ("media-view-subtitles-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.conversations_button.set_icon_widget (img);
        this.sort_button = new ToolButton(null, null);//.from_stock (Stock.PROPERTIES);
        img = new Image.from_icon_name ("view-sort-ascending-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.sort_button.set_icon_widget (img);//.set_icon_name("view-sort-ascending-symbolic");
        this.more_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("view-more-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.more_button.set_icon_widget (img);//.set_icon_name("view-more-symbolic");
        this.share_button = new ToolButton(null, null);
        img = new Image.from_icon_name ("contact-new-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        this.share_button.set_icon_widget (img);//.set_icon_name("contact-new-symbolic");
        // toolbar.add (this.notifications_button);
        // toolbar.add (this.conversations_button);
        // toolbar.add (this.sort_button);
        // this.url_bar = new Entry ();

				// Create the window of this application and show it
				// Gtk.ApplicationWindow window = new Gtk.ApplicationWindow (this);
				this.set_default_size (550, 680);
				// window.window_position = WindowPosition.CENTER;
				// window.set_border_width(10);



        this.web_view = new WebView ();
        var scrolled_window = new ScrolledWindow (null, null);
        scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add (this.web_view);
				scrolled_window.add (this.web_view);
        // this.status_bar = new Label ("Welcome");
        // this.status_bar.xalign = 0;


				// add headerbar with button
				Gtk.HeaderBar headerbar = new Gtk.HeaderBar();
        headerbar.show_close_button = true;
        var box = new Box (Orientation.HORIZONTAL, 3);
        // headerbar.title = "Window";
				box.add(this.notifications_button);
				box.add(this.conversations_button);

        var group_box = new Box (Orientation.HORIZONTAL, 3);
        group_box.pack_start (this.sort_button, false, false, 0);
        group_box.pack_end (this.share_button, false, false, 0);
        group_box.pack_end (this.more_button, false, false, 0);

				// headerbar.add(this.sort_button);
        // headerbar.add(this.share_button);
        // headerbar.add(this.more_button);


        this.set_titlebar(headerbar);


        var vbox = new VBox (false, 0);
        // vbox.pack_start (toolbar, false, true, 0);
        // vbox.pack_start (this.url_bar, false, true, 0);
				// vbox.add (window);
				vbox.add (scrolled_window);





        headerbar.pack_start(box);
        headerbar.pack_end(group_box);

        // vbox.pack_start (this.status_bar, false, true, 0);
				// vbox.pack_start (this.status_bar, false, true, 0);
        add (vbox);
    }

    private void connect_signals () {
        this.destroy.connect (Gtk.main_quit);
        // this.url_bar.activate.connect (on_activate);
        // this.web_view.title_changed.connect ((source, frame, title) => {
        //     this.title = "%s - %s".printf (title, Wunderlistux.TITLE);
        // });
        this.web_view.load_committed.connect ((source, frame) => {
            // this.url_bar.text = frame.get_uri ();
            update_buttons ();
        });
        // this.notifications_button.clicked.connect (this.web_view.go_back);
        // this.conversations_button.clicked.connect (this.web_view.go_forward);
        // this.sort_button.clicked.connect (this.web_view.reload);
    }

    private void update_buttons () {
        // this.notifications_button.sensitive = this.web_view.can_go_back ();
        // this.conversations_button.sensitive = this.web_view.can_go_forward ();
    }

    // private void on_activate () {
        // var url = this.url_bar.text;
        // if (!this.protocol_regex.match (url)) {
        //     url = "%s://%s".printf (Wunderlistux.DEFAULT_PROTOCOL, url);
        // }
        // this.web_view.open (url);
    // }

    public void start () {
        show_all ();
        this.web_view.open (Wunderlistux.HOME_URL);
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var browser = new Wunderlistux ();
        browser.start ();

        Gtk.main ();

        return 0;
    }
}
