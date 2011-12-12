/*
 * Copyright (C) 2011 mistbox.org
 *
 * This file is part of Mistbox.
 *
 * Mistbox is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Mistbox is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Mistbox.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Main {

	private static GLib.MainLoop mainloop;

	async void list_dir() {
		var dir = File.new_for_path (Environment.get_home_dir());
		try {
			var e = yield dir.enumerate_children_async(FILE_ATTRIBUTE_STANDARD_NAME, 0, Priority.DEFAULT, null);
			while (true) {
				var files = yield e.next_files_async(10, Priority.DEFAULT, null);
				if (files == null) {
					break;
				}
				foreach (var info in files) {
					print("%s\n", info.get_name());
				}
			}
		}
		catch (Error err) {
			warning("Error: %s\n", err.message);
		}
	}

	public static int main (string[] args) {

		// Creating a GLib main loop with a default context
		mainloop = new GLib.MainLoop (null, false);

		var settings = new Settings ("org.mistbox.mistbox");

		// Change notification for any key in the schema
		settings.changed.connect ((key) => {
			print ("Key '%s' changed\n", key);
		});

		list_dir.begin((obj, res) => {
			list_dir.end(res);
		});
		// Start GLib mainloop
		mainloop.run ();

		return 0;
	}

}
