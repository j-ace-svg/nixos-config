glide.o.hint_chars = "htnsueoadimwvzkjq'gcrlp.,;bxfy";

function create_tab_jump(map, url, desc) {
    glide.keymaps.set("normal", map, async () => {
        const tab = await glide.tabs.get_first({
            url: url,
        });
        if (!(tab && tab.id)) {
            // nothing at the moment, no ability to give notification
            return;
        }
        //assert(tab && tab.id, { message: `No tab found matching ${url}` });
        await browser.tabs.update(tab.id, { active: true });
    }, { description: desc });
}

create_tab_jump("tg", "https://mail.google.com/*", "go to [t]ab with [g]mail");
create_tab_jump("tm", "https://messages.google.com/*", "go to [t]ab with [m]essages");
create_tab_jump("tp", "https://mail.proton.me/*", "go to [t]ab with [p]roton mail");

glide.keymaps.set("normal", "<A-n>", "clear");

glide.keymaps.set("normal", "/", () => glide.findbar.open({mode: "normal", highlight_all: true}));
glide.keymaps.set("normal", "n", () => glide.findbar.next_match());
glide.keymaps.set("normal", "N", () => glide.findbar.previous_match());

glide.keymaps.set("normal", "u", "undo");
glide.keymaps.set("normal", "<C-r>", "redo");

glide.keymaps.set("normal", "J", "tab_next");
glide.keymaps.set("normal", "K", "tab_prev");

glide.keymaps.set("insert", "jk", "mode_change normal");
glide.keymaps.set("insert", "kj", "mode_change normal");

glide.autocmds.create("UrlEnter", {
    hostname: [ "https://docs.google.com/*/edit", "https://docs.google.com/*/edit?*",
                "https://docs.google.com/*/comment", "https://docs.google.com/*/comment?*",
                "https://docs.google.com/*/view", "https://docs.google.com/*/view?*" ],
}, async () => {
    glide.buf.keymaps.del("insert", "jk");
    glide.buf.keymaps.del("insert", "kj");
});

