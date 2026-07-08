-- Example busted spec: validates game/product.env without needing LÖVE.
-- Uses the same parsing rules as game/conf.lua, so a value that breaks
-- here would break the game and the CI builds too.
local function parse_product_env(path)
  local config = {}
  for line in io.lines(path) do
    if not (line:match("^%s*#") or line:match("^%s*$")) then
      local key, value = line:match("([^=]+)=(.*)")
      if key then
        config[key] = value:match('^"?(.-)"?$')
      end
    end
  end
  return config
end

describe("game/product.env", function()
  local config

  setup(function()
    config = parse_product_env("game/product.env")
  end)

  it("parses at all", function()
    assert.is_table(config)
  end)

  it("has a product name", function()
    assert.is_string(config.PRODUCT_NAME)
    assert.is_not_equal("", config.PRODUCT_NAME)
  end)

  it("has a PRODUCT_ID without spaces or hyphens", function()
    assert.is_string(config.PRODUCT_ID)
    assert.is_nil(config.PRODUCT_ID:match("[%s%-]"), "PRODUCT_ID must not contain spaces or hyphens")
  end)

  it("targets a supported LÖVE version", function()
    assert.are_equal("11.5", config.LOVE_VERSION)
  end)
end)
