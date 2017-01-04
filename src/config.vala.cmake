// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 *
 * This software is licensed under the GNU General Public License
 * (version 3 or later). See the COPYING file in this distribution.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this software; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Edipo da Silva <edipox@gmail.com>
 */

namespace Constants {
    public const string DATADIR = "@DATADIR@";
    public const string PKGDATADIR = "@PKGDATADIR@";
    public const string VERSION = "@VERSION@";
    public const string GETTEXT_PACKAGE = "@GETTEXT_PACKAGE@";

    // translatable strings for the .desktop file
    private const string GENERIC_NAME = _("Wunderlist Client");
    private const string COMMENT = _("Wunderlist client for Linux");
}
