-- Riuu Hub protected build (bootstrap - auto-generated from the local source - do not edit)
-- Everyone can execute this file normally; the source code itself is never served here.
local RiuuProtKey = "RiuuHubProtect-28cellotzy-2026"
local RiuuBase = "https://raw.githubusercontent.com/xaveriusryuuuuuuuuuuuu/riuucommunity/refs/heads/main/"
local RiuuParts = {
	"Riuu-Steal-An-Egg.part1.txt",
	"Riuu-Steal-An-Egg.part2.txt",
	"Riuu-Steal-An-Egg.part3.txt",
}

local function riuuProtDownload(name)
	local ok, chunk = pcall(function()
		return game:HttpGet(RiuuBase .. name)
	end)

	if ok and type(chunk) == "string" and #chunk > 0 then
		return chunk
	end

	warn("[Riuu] Failed to download part: " .. name)
	return nil
end

local function riuuProtDecode(data)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	local map = {}

	for i = 1, #chars do
		map[string.byte(chars, i)] = i - 1
	end

	local out = {}
	local acc = 0
	local bits = 0
	local pos = 0

	for i = 1, #data do
		local v = map[string.byte(data, i)]

		if v then
			acc = acc * 64 + v
			bits = bits + 6

			if bits >= 8 then
				bits = bits - 8
				pos = pos + 1
				out[pos] = string.char(math.floor(acc / 2 ^ bits) % 256)
				acc = acc % 2 ^ bits
			end
		end
	end

	return table.concat(out)
end

local function riuuProtXor(data, key)
	local out = {}
	local klen = #key
	local pos = 0

	for i = 1, #data do
		pos = pos + 1
		out[pos] = string.char(bit32.bxor(string.byte(data, i), string.byte(key, (i - 1) % klen + 1)))
	end

	return table.concat(out)
end

local riuuB64 = ""

for _, partName in ipairs(RiuuParts) do
	local chunk = riuuProtDownload(partName)

	if not chunk then
		return
	end

	riuuB64 = riuuB64 .. chunk
end

local ok, err = pcall(function()
	local src = riuuProtXor(riuuProtDecode(riuuB64), RiuuProtKey)
	local fn, loadErr = loadstring(src, "=RiuuHub")

	if fn then
		fn()
	else
		warn("[Riuu] Protected load failed: " .. tostring(loadErr))
	end
end)

if not ok then
	warn("[Riuu] Protected build error: " .. tostring(err))
end
