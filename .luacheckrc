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
