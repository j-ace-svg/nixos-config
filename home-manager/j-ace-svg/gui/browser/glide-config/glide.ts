glide.o.hint_chars = "htnsueoadimwvzkjq'gcrlp.,;bxfy";

function create_tab_jump(map, url, desc) {
    glide.keymaps.set("normal", map, async () => {
        const tab = await glide.tabs.get_first({
            url: url,
        });
        if (!(tab && tab.id)) {
            throw { message: `No tab found matching ${url}` };
        }
        //assert(tab && tab.id, { message: `No tab found matching ${url}` });
        await browser.tabs.update(tab.id, { active: true });
    }, { description: desc });
}

create_tab_jump("tg", "https://mail.google.com/*", "go to [t]ab with [g]mail");
create_tab_jump("tm", "https://messages.google.com/*", "go to [t]ab with [m]essages");
create_tab_jump("tp", "https://mail.proton.me/*", "go to [t]ab with [p]roton mail");

glide.keymaps.set("normal", "<A-n>", "clear");
