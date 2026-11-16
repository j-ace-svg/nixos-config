glide.o.hint_chars = "htnsueoadimwvzkjq'gcrlp.,;bxfy";

glide.keymaps.set("normal", "tg", async () => {
    const tab = await glide.tabs.get_first({
        url: "https://mail.google.com/*",
    });
    assert(tab && tab.id);
    await browser.tabs.update(tab.id, { active: true });
}, { description: "go to [t]ab with [g]mail" });
