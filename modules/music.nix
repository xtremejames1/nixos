{ inputs, pkgs, config, ... }:
{
	home.packages = with pkgs; [
# mpd
	];
	programs.ncmpcpp = {
		enable = true;
		bindings = [
			{key = "j"; command = "scroll_down"; }
			{key = "k"; command = "scroll_up"; }
		];
	};
	services.mpd = {
		enable = true;

		musicDirectory = "~/Music";

		network = {
			startWhenNeeded = true;
		};
		extraConfig = ''
			audio_output {
				type "pipewire"
					name "My Pipewire" # this can be whatever you want
			}
		'';
	};
}
