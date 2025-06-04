local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("javascript", {
	s("for", {
		t("for (let "), i(1, "i"), t(" = 0; "),
		t("{ length } = "), i(2, "array"), t("; "),
		rep(1), t(" < length; "), rep(1), t({ "++) {", "\t" }),
		t("const "), i(3, "element"), t(" = "), rep(2), t("["), rep(1), t({ "];", "\t" }),
		i(0, "// code here"), t({ "", "}" }),
	}),
}, {
	key = "override_js_for_loop",
})
