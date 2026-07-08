std = "luajit+love"
max_line_length = 120

-- Globals shared between conf.lua and main.lua
globals = { "product_config", "https" }

-- Vendored/native code is not ours to lint
exclude_files = {
  "game/lib",
  "game/runtime",
  "builds",
  ".luarocks",
}

files["spec"] = { std = "+busted" }

-- The bundled example "game" ships as-is from upstream and is not
-- lint-clean (unused args, shadowed upvalues). Delete this section
-- together with game/eyes when you start your own game.
files["game/eyes"] = {
  ignore = { "21", "31", "42", "43" },
}
