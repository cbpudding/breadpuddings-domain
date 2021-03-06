/* Copyright (c) 2020 Alexander Hill

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE. */

/* Changelog:
Version 1.1.2(May 10, 2020):
* Hotfix for Hold the Flag maps
Version 1.1.1(May 10, 2020):
* Prevented custom round timers from being visible
* Prevented the announcer from saying "one" at the beginning of a match
Version 1.1.0(May 7, 2020):
+ Implemented a feature that removes custom round timers
Version 1.0.0(May 5, 2020):
+ Implemented friendly fire at the end of a round */

#include <sdktools>
#include <sourcemod>

ConVar mp_friendlyfire;

public Plugin myinfo = {
	name = "Breadpudding's CTF",
	author = "Alexander Hill",
	description = "A plugin to make some small tweaks while keeping the server vanilla-like",
	version = "1.1.2",
	url = "https://github.com/cbpudding/breadpuddings-domain"
};

public void OnPluginStart() {
	mp_friendlyfire = FindConVar("mp_friendlyfire");
	HookEvent("teamplay_round_start", OnRoundStart);
	HookEvent("teamplay_round_win", OnRoundEnd);
	PrintToServer("\e[32mBreadpudding's CTF Loaded!\e[0m"); // The TF2 console could use some color
}

public void OnRoundEnd(Event event, const char[] name, bool dontBroadcast) {
	mp_friendlyfire.BoolValue = true;
}

public void OnRoundStart(Event event, const char[] name, bool dontBroadcast) {
	char buffer[5];
	GetCurrentMap(buffer, 4);
	if(strcmp("htf_", buffer) != 0) {
		int team_round_timer = FindEntityByClassname(-1, "team_round_timer");
		mp_friendlyfire.BoolValue = false;
		if (team_round_timer != -1) {
			AcceptEntityInput(team_round_timer, "Kill");
		}
	}
}
