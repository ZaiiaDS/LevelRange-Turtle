--
-- LevelRange :: Main Lua File
-- Copyright (c) 2006 Philip Hughes (Bull3t)
-- Shows the zone level range on the World Map.
-- Data: Turtle WoW Wiki (turtle-wow.fandom.com).
--

local LEVELRANGE_VERSION = "2.8.0"

local LEVELRANGE_REALMPLAYERNAME = GetRealmName() .. "|" .. UnitName("player")
LevelRangeSettings = {}

-- Defaults
local DEFAULT_SHOW         = true
local DEFAULT_SHOWINSTANCE = true
local DEFAULT_SHOWRAIDS    = true
local DEFAULT_SHOWPVP      = true
local DEFAULT_SHOWFISHING  = true
local DEFAULT_FONTSIZE     = 14
local MIN_FONTSIZE = 8
local MAX_FONTSIZE = 24

-- Faction markers
local FACTION_ALLIANCE  = "Alliance"
local FACTION_HORDE     = "Horde"
local FACTION_CONTESTED = "Contested"

-- ===========================================================================
-- Zone ranges: { low, high, faction }
-- ===========================================================================
local LEVELRANGE_RANGES = {
    -- Eastern Kingdoms
    [LEVELRANGE_ELWYNN]                 = { 1, 10, FACTION_ALLIANCE},
    [LEVELRANGE_DUNMOROGH]              = { 1, 10, FACTION_ALLIANCE},
    [LEVELRANGE_TIRISFAL]               = { 1, 10, FACTION_HORDE},
    [LEVELRANGE_LOCHMODAN]              = {10, 20, FACTION_ALLIANCE},
    [LEVELRANGE_SILVERPINE]             = {10, 20, FACTION_HORDE},
    [LEVELRANGE_WESTFALL]               = {10, 20, FACTION_ALLIANCE},
    [LEVELRANGE_REDRIDGE]               = {15, 25, FACTION_CONTESTED},
    [LEVELRANGE_DUSKWOOD]               = {18, 30, FACTION_CONTESTED},
    [LEVELRANGE_HILLSBRAD]              = {20, 30, FACTION_CONTESTED},
    [LEVELRANGE_WETLANDS]               = {20, 30, FACTION_CONTESTED},
    [LEVELRANGE_ALTERAC]                = {30, 40, FACTION_CONTESTED},
    [LEVELRANGE_ARATHI]                 = {30, 40, FACTION_CONTESTED},
    [LEVELRANGE_STRANGLETHORN]          = {30, 45, FACTION_CONTESTED},
    [LEVELRANGE_BADLANDS]               = {35, 45, FACTION_CONTESTED},
    [LEVELRANGE_SORROWS]                = {35, 45, FACTION_CONTESTED},
    [LEVELRANGE_HINTERLANDS]            = {40, 50, FACTION_CONTESTED},
    [LEVELRANGE_SEARINGGORGE]           = {43, 50, FACTION_CONTESTED},
    [LEVELRANGE_BLASTEDLANDS]           = {45, 55, FACTION_CONTESTED},
    [LEVELRANGE_BURNINGSTEPPE]          = {50, 58, FACTION_CONTESTED},
    [LEVELRANGE_WESTERNPLAGUE]          = {51, 58, FACTION_CONTESTED},
    [LEVELRANGE_EASTERNPLAGUE]          = {53, 60, FACTION_CONTESTED},
    [LEVELRANGE_DEADWINDPASS]           = {55, 60, FACTION_CONTESTED},
    [LEVELRANGE_BLACKROCKMOUNTAIN]      = {42, 54, FACTION_CONTESTED},

    -- Kalimdor
    [LEVELRANGE_DUROTAR]                = { 1, 10, FACTION_HORDE},
    [LEVELRANGE_MULGORE]                = { 1, 10, FACTION_HORDE},
    [LEVELRANGE_DARKSHORE]              = {10, 20, FACTION_ALLIANCE},
    [LEVELRANGE_BARRENS]                = {10, 25, FACTION_HORDE},
    [LEVELRANGE_STONETALON]             = {15, 27, FACTION_CONTESTED},
    [LEVELRANGE_ASHENVALE]              = {18, 30, FACTION_CONTESTED},
    [LEVELRANGE_1KNEEDLES]              = {25, 35, FACTION_CONTESTED},
    [LEVELRANGE_DESOLACE]               = {30, 40, FACTION_CONTESTED},
    [LEVELRANGE_DUSTWALLOW]             = {35, 45, FACTION_CONTESTED},
    [LEVELRANGE_FERALAS]                = {40, 50, FACTION_CONTESTED},
    [LEVELRANGE_TANARIS]                = {40, 50, FACTION_CONTESTED},
    [LEVELRANGE_AZSHARA]                = {45, 55, FACTION_CONTESTED},
    [LEVELRANGE_FELWOOD]                = {48, 55, FACTION_CONTESTED},
    [LEVELRANGE_UNGOROCRATER]           = {48, 55, FACTION_CONTESTED},
    [LEVELRANGE_SILITHUS]               = {55, 60, FACTION_CONTESTED},
    [LEVELRANGE_WINTERSPRING]           = {55, 60, FACTION_CONTESTED},
    [LEVELRANGE_MOONGLADE]              = { 1, 60, FACTION_CONTESTED},
    [LEVELRANGE_TELDRASSIL]             = { 1, 10, FACTION_ALLIANCE},

    -- Turtle WoW zones
    [LEVELRANGE_THALASSIANHIGHLANDS]    = { 1, 10, FACTION_ALLIANCE},
    [LEVELRANGE_BLACKSTONEISLAND]       = { 1, 10, FACTION_HORDE},
    [LEVELRANGE_GILNEAS]                = {39, 46, FACTION_CONTESTED},
    [LEVELRANGE_GILLIJIM]               = {48, 53, FACTION_CONTESTED},
    [LEVELRANGE_LAPIDIS]                = {48, 53, FACTION_CONTESTED},
    [LEVELRANGE_TELABIM]                = {54, 60, FACTION_CONTESTED},
    [LEVELRANGE_SCARLETENCLAVE]         = {55, 60, FACTION_CONTESTED},
    [LEVELRANGE_HYJAL]                  = {58, 60, FACTION_CONTESTED},
    [LEVELRANGE_GRIMREACHES]            = {33, 38, FACTION_CONTESTED},
    [LEVELRANGE_NORTHWIND]              = {28, 34, FACTION_CONTESTED},
    [LEVELRANGE_BALOR]                  = {29, 34, FACTION_CONTESTED},
    [LEVELRANGE_MOONWHISPERCOAST]       = {50, 56, FACTION_CONTESTED},
}

-- ===========================================================================
-- Fishing levels
-- ===========================================================================
local LEVELRANGE_FISHING = {
    [LEVELRANGE_ELWYNN]             = {25},
    [LEVELRANGE_DUNMOROGH]          = {25},
    [LEVELRANGE_TIRISFAL]           = {25},
    [LEVELRANGE_LOCHMODAN]          = {75},
    [LEVELRANGE_SILVERPINE]         = {75},
    [LEVELRANGE_WESTFALL]           = {75},
    [LEVELRANGE_REDRIDGE]           = {150},
    [LEVELRANGE_DUSKWOOD]           = {150},
    [LEVELRANGE_HILLSBRAD]          = {150},
    [LEVELRANGE_WETLANDS]           = {150},
    [LEVELRANGE_ALTERAC]            = {225},
    [LEVELRANGE_ARATHI]             = {225},
    [LEVELRANGE_STRANGLETHORN]      = {225},
    [LEVELRANGE_BADLANDS]           = {35},
    [LEVELRANGE_SORROWS]            = {225},
    [LEVELRANGE_HINTERLANDS]        = {300},
    [LEVELRANGE_WESTERNPLAGUE]      = {300},
    [LEVELRANGE_DUROTAR]            = {25},
    [LEVELRANGE_MULGORE]            = {25},
    [LEVELRANGE_DARKSHORE]          = {75},
    [LEVELRANGE_BARRENS]            = {75},
    [LEVELRANGE_STONETALON]         = {150},
    [LEVELRANGE_ASHENVALE]          = {150},
    [LEVELRANGE_1KNEEDLES]          = {225},
    [LEVELRANGE_DESOLACE]           = {225},
    [LEVELRANGE_DUSTWALLOW]         = {225},
    [LEVELRANGE_FERALAS]            = {300},
    [LEVELRANGE_TANARIS]            = {300},
    [LEVELRANGE_AZSHARA]            = {300},
    [LEVELRANGE_FELWOOD]            = {300},
    [LEVELRANGE_UNGOROCRATER]       = {300},
    [LEVELRANGE_MOONGLADE]          = {300},
    [LEVELRANGE_TELDRASSIL]         = {25},
    [LEVELRANGE_SILITHUS]           = {330},
    [LEVELRANGE_WINTERSPRING]       = {330},
    [LEVELRANGE_EASTERNPLAGUE]      = {330},
    [LEVELRANGE_MOONWHISPERCOAST]   = {300},
}

-- ===========================================================================
-- Instances (dungeons) — { name, " (level-range, size)", ... }
-- ===========================================================================
local LEVELRANGE_INSTANCES = {
    [LEVELRANGE_WESTFALL]           = {LEVELRANGE_DEADMINES, " (17-26, 5)"},
    [LEVELRANGE_BARRENS]            = {LEVELRANGE_WAILINGCAVERNS, " (17-24, 5)", LEVELRANGE_RAZORFENKRAUL, " (29-38, 5)", LEVELRANGE_RAZORFENDOWNS, " (36-46, 5)"},
    [LEVELRANGE_SILVERPINE]         = {LEVELRANGE_SHADOWFANGKEEP, " (22-30, 5)"},
    [LEVELRANGE_DUNMOROGH]          = {LEVELRANGE_GNOMEREGAN, " (29-38, 5)", LEVELRANGE_FROSTMANEHOLLOW, " (13-20, 5)"},
    [LEVELRANGE_TIRISFAL]           = {LEVELRANGE_SCARLETMONASTERY_GRAVEYARD, " (27-36, 5)", LEVELRANGE_SCARLETMONASTERY_LIBRARY, " (28-39, 5)", LEVELRANGE_SCARLETMONASTERY_ARMORY, " (32-41, 5)", LEVELRANGE_SCARLETMONASTERY_CATHEDRAL, " (35-45, 5)"},
    [LEVELRANGE_BADLANDS]           = {LEVELRANGE_ULDAMAN, " (40-51, 5)"},
    [LEVELRANGE_DESOLACE]           = {LEVELRANGE_MARAUDON, " (45-55, 5)"},
    [LEVELRANGE_SORROWS]            = {LEVELRANGE_SUNKENTEMPLE, " (50-60, 5)"},
    [LEVELRANGE_SEARINGGORGE]       = {LEVELRANGE_BLACKROCKDEPTH, " (52-60, 5)", LEVELRANGE_BLACKROCKSPIRE_LOWER, " (55-60, 5)", LEVELRANGE_BLACKROCKSPIRE_UPPER, " (57-60, 10)"},
    [LEVELRANGE_BURNINGSTEPPE]      = {LEVELRANGE_HATEFORGEQUARRY, " (52-60, 5)", LEVELRANGE_BLACKROCKDEPTH, " (52-60, 5)", LEVELRANGE_BLACKROCKSPIRE_LOWER, " (55-60, 5)", LEVELRANGE_BLACKROCKSPIRE_UPPER, " (57-60, 10)"},
    [LEVELRANGE_BLACKROCKMOUNTAIN]  = {LEVELRANGE_BLACKROCKDEPTH, " (52-60, 5)", LEVELRANGE_BLACKROCKSPIRE_LOWER, " (55-60, 5)", LEVELRANGE_BLACKROCKSPIRE_UPPER, " (57-60, 10)"},
    [LEVELRANGE_EASTERNPLAGUE]      = {LEVELRANGE_STRATHOLME, " (58-60, 5)"},
    [LEVELRANGE_FERALAS]            = {LEVELRANGE_DIREMAUL_EAST, " (55-60, 5)", LEVELRANGE_DIREMAUL_WEST, " (57-60, 5)", LEVELRANGE_DIREMAUL_NORTH, " (58-60, 5)"},
    [LEVELRANGE_WESTERNPLAGUE]      = {LEVELRANGE_SCHOLOMANCE, " (58-60, 5)"},
    [LEVELRANGE_DUROTAR]            = {LEVELRANGE_RAGEFIRECHASM, " (13-18, 5)"},
    [LEVELRANGE_ASHENVALE]          = {LEVELRANGE_BLACKFATHOMDEEPS, " (23-32, 5)", LEVELRANGE_CRESCENTGROVE, " (32-38, 5)"},
    [LEVELRANGE_GILNEAS]            = {LEVELRANGE_GILNEASCITY, " (43-49, 5)"},
    [LEVELRANGE_DEADWINDPASS]       = {LEVELRANGE_KARAZHANCRYPT, " (58-60, 5)"},
    [LEVELRANGE_ELWYNN]             = {LEVELRANGE_STOCKADES, " (24-32, 5)", LEVELRANGE_STORMWINDVAULT, " (60+, 5)"},
    [LEVELRANGE_TANARIS]            = {LEVELRANGE_ZULFARRAK, " (44-54, 5)", LEVELRANGE_COTBLACKMORASS, " (60+, 5)"},
    [LEVELRANGE_BALOR]              = {LEVELRANGE_STORMWROUGHTRUINS, " (35-41, 5)"},
    [LEVELRANGE_WETLANDS]           = {LEVELRANGE_DRAGONMAWRETREAT, " (25-34, 5)"},
    [LEVELRANGE_1KNEEDLES]          = {LEVELRANGE_WINDHORNCANYON, " (26-30, 5)"},
}

-- ===========================================================================
-- Raids — { name, " (level-range, size)", ... }
-- ===========================================================================
local LEVELRANGE_RAIDS = {
    [LEVELRANGE_EASTERNPLAGUE]      = {LEVELRANGE_NAXXRAMAS, " (60+, 40)"},
    [LEVELRANGE_DUSTWALLOW]         = {LEVELRANGE_ONYXIASLAIR, " (60+, 40)"},
    [LEVELRANGE_SILITHUS]           = {LEVELRANGE_RUINSAHNQIRAJ, " (60+, 20)", LEVELRANGE_TEMPLEAHNQIRAJ, " (60+, 40)"},
    [LEVELRANGE_STRANGLETHORN]      = {LEVELRANGE_ZULGURUB, " (60+, 20)"},
    [LEVELRANGE_SEARINGGORGE]       = {LEVELRANGE_MOLTENCORE, " (60+, 40)", LEVELRANGE_BLACKWINGLAIR, " (60+, 40)"},
    [LEVELRANGE_BURNINGSTEPPE]      = {LEVELRANGE_MOLTENCORE, " (60+, 40)", LEVELRANGE_BLACKWINGLAIR, " (60+, 40)"},
    [LEVELRANGE_BLACKROCKMOUNTAIN]  = {LEVELRANGE_MOLTENCORE, " (60+, 40)", LEVELRANGE_BLACKWINGLAIR, " (60+, 40)"},
    [LEVELRANGE_HYJAL]              = {LEVELRANGE_EMERALDSANCTUM, " (60+, 40)"},
    [LEVELRANGE_DEADWINDPASS]       = {LEVELRANGE_LOWERKARAZHANHALLS, " (60+, 10)", LEVELRANGE_TOWEROFKARAZHAN, " (60+, 40)"},
    [LEVELRANGE_AZSHARA]            = {LEVELRANGE_TIMBERMAWHOLD, " (60+, 20)"},
}

-- ===========================================================================
-- Battlegrounds (shown only when showInstances is enabled)
-- ===========================================================================
local LEVELRANGE_BATTLEGROUNDS = {
    [LEVELRANGE_BARRENS]            = {LEVELRANGE_WARSONGGULCH, " (10-19, 10)"},
    [LEVELRANGE_ASHENVALE]          = {LEVELRANGE_WARSONGGULCH, " (10-19, 10)"},
    [LEVELRANGE_ARATHI]             = {LEVELRANGE_ARATHIBASIN, " (20-29, 15)"},
    [LEVELRANGE_ALTERAC]            = {LEVELRANGE_ALTERACVALLEY, " (51-60, 40)"},
}

-- ===========================================================================
-- Subzones
-- ===========================================================================
local LEVELRANGE_SUBZONES = {
    [LEVELRANGE_ORGRIMMAR]          = LEVELRANGE_DUROTAR,
    [LEVELRANGE_THUNDERBLUFF]       = LEVELRANGE_MULGORE,
    [LEVELRANGE_UNDERCITY]          = LEVELRANGE_TIRISFAL,
    [LEVELRANGE_IRONFORGE]          = LEVELRANGE_DUNMOROGH,
    [LEVELRANGE_STORMWIND]          = LEVELRANGE_ELWYNN,
    [LEVELRANGE_DARNASSUS]          = LEVELRANGE_TELDRASSIL,
    [LEVELRANGE_ALAHTHALAS]         = LEVELRANGE_THALASSIANHIGHLANDS,
}

-- ===========================================================================
-- Colors
-- ===========================================================================
local LEVELRANGE_COLORS = {
    Unknown     = { r = 0.8, g = 0.8, b = 0.8 },
    Hostile     = { r = 0.9, g = 0.2, b = 0.2 },
    Friendly    = { r = 0.2, g = 0.9, b = 0.2 },
    Contested   = { r = 0.8, g = 0.6, b = 0.4 },
    None        = { r = 1.0, g = 1.0, b = 1.0 },
    Levels      = { r = 0.8, g = 0.6, b = 0.0 },
    ON          = { r = 0.0, g = 1.0, b = 0.0 },
    OFF         = { r = 1.0, g = 0.0, b = 0.0 },
}

-- ===========================================================================
-- Helpers
-- ===========================================================================

local function printMSG(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|CF4FFFF4FLevelRange|r: " .. msg, 1, 1, 1)
end

local function printOPTION(msg, status, r, g, b)
    DEFAULT_CHAT_FRAME:AddMessage("|CF4FFFF4F" .. msg .. ":|r " .. status, r or 1, g or 1, b or 1)
end

local function applyFontSize(size)
    for i = 1, 32 do
        local left = getglobal("LevelRangeTooltipTextLeft" .. i)
        if not left then break end
        local path, _, flags = left:GetFont()
        if path then left:SetFont(path, size, flags or "") end
        local right = getglobal("LevelRangeTooltipTextRight" .. i)
        if right then
            local rpath, _, rflags = right:GetFont()
            if rpath then right:SetFont(rpath, size, rflags or "") end
        end
    end
end

-- Level-based color gradient (relative to player level)
local function getLevelColor(low, high)
    if low == 0 and high == 0 then return 1, 1, 1 end
    local pl = UnitLevel("player")
    if pl == low and pl == high then return 1, 1, 0
    elseif pl <= low - 3 then return 1, 0, 0
    elseif pl <= low then return 1, (pl - low - 3) / -6, 0
    elseif pl <= (low + high) / 2 then return 1, (pl - low) / (high - low) + 0.5, 0
    elseif pl <= high then return 2 * (pl - high) / (low - high), 1, 0
    elseif pl <= high + 3 then
        local n = (pl - high) / 6
        return n, 1 - n, n
    else return 0.5, 0.5, 0.5 end
end

local function addInstanceLines(info, tooltip)
    if not info then return end
    for i = 1, table.getn(info), 2 do
        local name, suffix = info[i], info[i + 1]
        local r, g, b = 1, 1, 1
        local lo, hi = string.match(suffix or "", "(%d+)%-(%d+)")
        if lo and hi then
            r, g, b = getLevelColor(tonumber(lo), tonumber(hi))
        end
        tooltip:AddDoubleLine(
            "|CFFcFcFcF" .. name .. "|r",
            string.format("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, suffix or "")
        )
    end
end

-- ===========================================================================
-- Tooltip
-- ===========================================================================

local function lUpdateTooltip(zoneName)
    local settings = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]

    if (settings.showLevelRange == false) or not zoneName or zoneName == "" then
        LevelRangeTooltip:Hide()
        return
    end

    LevelRangeTooltip:SetOwner(this, "ANCHOR_TOPLEFT", 9, -630)

    local title     = LEVELRANGE_COLORS.Unknown
    local normalcol = LEVELRANGE_COLORS.None
    local levelscol = LEVELRANGE_COLORS.Levels
    local levels, actualside, flevel

    local range = LEVELRANGE_RANGES[zoneName]
    if range then
        local _, faction = UnitFactionGroup("player")
        local min, max, side = range[1], range[2], range[3]

        if side == FACTION_CONTESTED then
            title = LEVELRANGE_COLORS.Contested
            actualside = LEVELRANGE_CONTESTED
        elseif faction == side then
            title = LEVELRANGE_COLORS.Friendly
            actualside = LEVELRANGE_FRIENDLY
        else
            title = LEVELRANGE_COLORS.Hostile
            actualside = LEVELRANGE_HOSTILE
        end
        local r, g, b = getLevelColor(min, max)
        levels = string.format("|cff%02x%02x%02x" .. LEVELRANGE_LEVELS .. "|r", r * 255, g * 255, b * 255, min, max)
    end

    local fishing = LEVELRANGE_FISHING[zoneName]
    if fishing then
        flevel = string.format(LEVELRANGE_FLEVEL, fishing[1])
    end

    LevelRangeTooltip:SetText(zoneName, normalcol.r, normalcol.g, normalcol.b)

    if levels then LevelRangeTooltip:AddLine(levels, 1, 1, 1) end
    if settings.showFishing and flevel then LevelRangeTooltip:AddLine(flevel, levelscol.r, levelscol.g, levelscol.b) end
    if settings.showPvP and actualside then LevelRangeTooltip:AddLine(actualside, title.r, title.g, title.b) end

    if settings.showInstances and LEVELRANGE_INSTANCES[zoneName] then
        LevelRangeTooltip:AddLine(" ")
        LevelRangeTooltip:AddLine(LEVELRANGE_INSTANCESTEXT)
        addInstanceLines(LEVELRANGE_INSTANCES[zoneName], LevelRangeTooltip)
    end

    if settings.showRaids and LEVELRANGE_RAIDS[zoneName] then
        LevelRangeTooltip:AddLine(" ")
        LevelRangeTooltip:AddLine(LEVELRANGE_RAIDSTEXT)
        addInstanceLines(LEVELRANGE_RAIDS[zoneName], LevelRangeTooltip)
    end

    if settings.showInstances and LEVELRANGE_BATTLEGROUNDS[zoneName] then
        LevelRangeTooltip:AddLine(" ")
        LevelRangeTooltip:AddLine(LEVELRANGE_BATTLEGROUNDSTEXT)
        addInstanceLines(LEVELRANGE_BATTLEGROUNDS[zoneName], LevelRangeTooltip)
    end

    applyFontSize(settings.fontSize or DEFAULT_FONTSIZE)
    LevelRangeTooltip:SetBackdropBorderColor(1, 1, 1, 1)

    if levels then LevelRangeTooltip:Show() else LevelRangeTooltip:Hide() end
end

-- ===========================================================================
-- World map hook
-- ===========================================================================

local lLR_CurrentZone = nil
local lLR_CurrentArea = nil
local lLR_OldUpdate = function() end

local function LevelRange_WorldMapButton_OnUpdate(arg1)
    lLR_OldUpdate(arg1)

    local areaNameRaw = WorldMapFrame.areaName or ""
    local _, _, areaNameTrimmed = string.find(areaNameRaw, "^%s*(.-)%s*$")
    local zoneNum = GetCurrentMapZone()

    if LEVELRANGE_SUBZONES[areaNameTrimmed] then
        areaNameTrimmed = LEVELRANGE_SUBZONES[areaNameTrimmed]
    end

    if zoneNum == lLR_CurrentZone and areaNameRaw == lLR_CurrentArea then
        return
    end

    lLR_CurrentZone = zoneNum
    lLR_CurrentArea = areaNameRaw

    if zoneNum == 0 then
        lUpdateTooltip(areaNameTrimmed)
    else
        lUpdateTooltip(nil)
    end
end

-- ===========================================================================
-- Toggles
-- ===========================================================================

local function toggleLevelRange()
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    if s.showLevelRange == false then
        s.showLevelRange = true
        printOPTION(LEVELRANGE_TOGGLESHOW, LEVELRANGE_ENABLED, LEVELRANGE_COLORS.ON.r, LEVELRANGE_COLORS.ON.g, LEVELRANGE_COLORS.ON.b)
    else
        s.showLevelRange = false
        printOPTION(LEVELRANGE_TOGGLESHOW, LEVELRANGE_DISABLED, LEVELRANGE_COLORS.OFF.r, LEVELRANGE_COLORS.OFF.g, LEVELRANGE_COLORS.OFF.b)
    end
end

local function toggleInstances()
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    if s.showInstances == false then
        s.showInstances = true
        printOPTION(LEVELRANGE_TOGGLEINSTANCES, LEVELRANGE_ON, LEVELRANGE_COLORS.ON.r, LEVELRANGE_COLORS.ON.g, LEVELRANGE_COLORS.ON.b)
    else
        s.showInstances = false
        printOPTION(LEVELRANGE_TOGGLEINSTANCES, LEVELRANGE_OFF, LEVELRANGE_COLORS.OFF.r, LEVELRANGE_COLORS.OFF.g, LEVELRANGE_COLORS.OFF.b)
    end
end

local function toggleRaids()
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    if s.showRaids == false then
        s.showRaids = true
        printOPTION(LEVELRANGE_TOGGLERAIDS, LEVELRANGE_ON, LEVELRANGE_COLORS.ON.r, LEVELRANGE_COLORS.ON.g, LEVELRANGE_COLORS.ON.b)
    else
        s.showRaids = false
        printOPTION(LEVELRANGE_TOGGLERAIDS, LEVELRANGE_OFF, LEVELRANGE_COLORS.OFF.r, LEVELRANGE_COLORS.OFF.g, LEVELRANGE_COLORS.OFF.b)
    end
end

local function togglePvP()
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    if s.showPvP == false then
        s.showPvP = true
        printOPTION(LEVELRANGE_TOGGLEPVP, LEVELRANGE_ON, LEVELRANGE_COLORS.ON.r, LEVELRANGE_COLORS.ON.g, LEVELRANGE_COLORS.ON.b)
    else
        s.showPvP = false
        printOPTION(LEVELRANGE_TOGGLEPVP, LEVELRANGE_OFF, LEVELRANGE_COLORS.OFF.r, LEVELRANGE_COLORS.OFF.g, LEVELRANGE_COLORS.OFF.b)
    end
end

local function toggleFishing()
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    if s.showFishing == false then
        s.showFishing = true
        printOPTION(LEVELRANGE_TOGGLEFISHING, LEVELRANGE_ON, LEVELRANGE_COLORS.ON.r, LEVELRANGE_COLORS.ON.g, LEVELRANGE_COLORS.ON.b)
    else
        s.showFishing = false
        printOPTION(LEVELRANGE_TOGGLEFISHING, LEVELRANGE_OFF, LEVELRANGE_COLORS.OFF.r, LEVELRANGE_COLORS.OFF.g, LEVELRANGE_COLORS.OFF.b)
    end
end

-- ===========================================================================
-- Font size setter (shared by slider and editbox)
-- ===========================================================================

local function setFontSize(size)
    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]

    if size < MIN_FONTSIZE then size = MIN_FONTSIZE end
    if size > MAX_FONTSIZE then size = MAX_FONTSIZE end
    s.fontSize = size

    local slider = getglobal("LevelRangeOptionsFrameFontSizeSlider")
    if slider then
        slider.updating = true
        slider:SetValue(size)
        slider.updating = nil
    end

    local txt = getglobal("LevelRangeOptionsFrameFontSizeSliderText")
    if txt then
        txt:SetText(LEVELRANGE_OPTIONS_FONTSIZE .. ": " .. size)
    end

    local eb = getglobal("LevelRangeOptionsFrameFontSizeEditBox")
    if eb then
        eb:SetText(tostring(size))
    end

    lLR_CurrentZone = nil
    lLR_CurrentArea = nil
end

-- ===========================================================================
-- Options frame: slider / editbox handlers (called from XML)
-- ===========================================================================

function LevelRangeOptionsFrameFontSizeSlider_OnValueChanged()
    if this.updating then return end
    setFontSize(math.floor(this:GetValue() + 0.5))
end

function LevelRangeOptionsFrameFontSizeEditBox_OnEnterPressed()
    local value = tonumber(this:GetText())
    if value then
        setFontSize(math.floor(value + 0.5))
    else
        local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
        this:SetText(tostring(s.fontSize or DEFAULT_FONTSIZE))
    end
    this:ClearFocus()
end

-- ===========================================================================
-- Options frame
-- ===========================================================================

local function repositionFontSizeControls()
    local slider = getglobal("LevelRangeOptionsFrameFontSizeSlider")
    if not slider then return end

    local txt  = getglobal("LevelRangeOptionsFrameFontSizeSliderText")
    local low  = getglobal("LevelRangeOptionsFrameFontSizeSliderLow")
    local high = getglobal("LevelRangeOptionsFrameFontSizeSliderHigh")

    if low  then low:ClearAllPoints();  low:SetPoint("TOPLEFT",  slider, "BOTTOMLEFT",  0, -2) end
    if high then high:ClearAllPoints(); high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 0, -2) end
    if txt  then txt:ClearAllPoints();  txt:SetPoint("TOP",      slider, "BOTTOM",      0, -2) end
end

local function OptionsFrame_EnableCheckBox(checkbox, enabled, checked)
    if enabled then checkbox:Enable() else checkbox:Disable() end
    checkbox:SetChecked(checked)
end

local function OptionsFrame_DisableCheckBox(checkbox)
    checkbox:Disable()
end

function LevelRangeOptionsFrame_OnShow()
    LevelRangeOptionsFrameTitle:SetText(LEVELRANGE_OPTIONS_TITLE)

    local base = "LevelRangeOptionsFrame"
    local settings = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]

    for optid, option in pairs(LEVELRANGE_OPTIONS) do
        local name   = base .. "Opt" .. optid
        local button = getglobal(name)
        local label  = getglobal(name .. "Text")

        OptionsFrame_EnableCheckBox(button, 1, settings[option.option])
        label:SetText(option.label)
        button.tooltipText = option.tooltip
        button.option      = option.option
        button.children    = option.children or {}
    end

    for _, option in pairs(LEVELRANGE_OPTIONS) do
        for _, child in option.children or {} do
            local other = getglobal(base .. "Opt" .. child)
            if other then
                if settings[option.option] then
                    OptionsFrame_EnableCheckBox(other, 1,
                        settings[LEVELRANGE_OPTIONS[child].option])
                else
                    OptionsFrame_DisableCheckBox(other)
                end
            end
        end
    end

    setFontSize(settings.fontSize or DEFAULT_FONTSIZE)
    repositionFontSizeControls()
end

function LevelRangeOptionsCheckButton_OnClick()
    local opt = this.option
    if opt == "showLevelRange" then
        toggleLevelRange()
    elseif opt == "showInstances" then
        toggleInstances()
    elseif opt == "showRaids" then
        toggleRaids()
    elseif opt == "showPvP" then
        togglePvP()
    elseif opt == "showFishing" then
        toggleFishing()
    end

    local base = "LevelRangeOptionsFrame"
    local settings = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]

    for _, child in this.children do
        local other = getglobal(base .. "Opt" .. child)
        if other then
            if settings[opt] then
                OptionsFrame_EnableCheckBox(other, 1,
                    settings[LEVELRANGE_OPTIONS[child].option])
            else
                OptionsFrame_DisableCheckBox(other)
            end
        end
    end
end

-- ===========================================================================
-- Initialization
-- ===========================================================================

local function LevelRange_Initialize()
    if not LevelRangeSettings then
        LevelRangeSettings = {}
    end
    if not LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME] then
        LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME] = {}
    end

    local defaults = {
        showLevelRange = DEFAULT_SHOW,
        showInstances  = DEFAULT_SHOWINSTANCE,
        showRaids      = DEFAULT_SHOWRAIDS,
        showPvP        = DEFAULT_SHOWPVP,
        showFishing    = DEFAULT_SHOWFISHING,
        fontSize       = DEFAULT_FONTSIZE,
    }

    local s = LevelRangeSettings[LEVELRANGE_REALMPLAYERNAME]
    for key, value in pairs(defaults) do
        if s[key] == nil then
            s[key] = value
        end
    end
end

local function LevelRange_SlashHandler()
    if LevelRangeOptionsFrame:IsVisible() then
        HideUIPanel(LevelRangeOptionsFrame)
    else
        ShowUIPanel(LevelRangeOptionsFrame)
    end
end

function LevelRange_OnLoad()
    lLR_OldUpdate = WorldMapButton_OnUpdate
    WorldMapButton_OnUpdate = LevelRange_WorldMapButton_OnUpdate

    tinsert(UISpecialFrames, "LevelRangeOptionsFrame")

    SlashCmdList["LEVELRANGE"] = LevelRange_SlashHandler
    SLASH_LEVELRANGE1 = "/lr"
    SLASH_LEVELRANGE2 = "/levelrange"

    printMSG(LEVELRANGE_LOADEDPREFIX .. LEVELRANGE_VERSION .. LEVELRANGE_LOADEDSUFFIX)
    this:RegisterEvent("VARIABLES_LOADED")
end

function LevelRange_OnEvent(event)
    if event == "VARIABLES_LOADED" then
        LevelRange_Initialize()
    end
end