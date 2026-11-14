# LevelRange-Turtle

Показывает диапазон уровней зон на карте мира (World Map) для Turtle WoW 1.18.1 (API 1.12).
Форк аддона LevelRange-Turtle by [Spartelfant](https://github.com/Spartelfant).
Author: Bull3t, Tenyar97, rado-boy, blehz, rafacc87, Diginfotek, Spartelfant, Zaiia.
Addon Website: https://github.com/ZaiiaDS/LevelRange-Turtle/

## Возможности

- Диапазон уровней зоны с цветовым градиентом относительно уровня игрока (красный → жёлтый → зелёный → серый).
- Цветовая маркировка фракции: своя — зелёный, враждебная — красный, спорная — коричневый.
- Минимальный уровень рыбной ловли.
- Подземелья, рейды и поля боя с уровнями и размером группы (`5`, `10`, `20`, `40`).
- Локализация: enUS, ptBR, ruRU, zhCN.
- Окно настроек: 5 чекбоксов, шрифт 8–24 (слайдер + поле ввода), закрытие по `Esc` и по крестику.

## Slash-команды

| Команда | Действие |
|---|---|
| `/lr` | Открыть/закрыть окно настроек |
| `/levelrange` | То же самое |

---

# Change Log

## 2.8.0 — База данных и цветовой градиент

Источники: [Turtle WoW Wiki](https://turtle-wow.fandom.com/) (основной) + Cartographer/pfQuest-turtle.

**Новый контент:**
- Зоны: Blackrock Mountain (42–54), Moonwhisper Coast (50–56).
- Подземелья: Frostmane Hollow (13–20, 5), Windhorn Canyon (26–30, 5).
- Рейды: Molten Core (60+, 40), Blackwing Lair (60+, 40), Lower Karazhan Halls (60+, 10), Tower of Karazhan (60+, 40), Timbermaw Hold (60+, 20 — Azshara).
- Поля боя: Warsong Gulch (10–19, 10), Arathi Basin (20–29, 15), Alterac Valley (51–60, 40). Показываются при включённой настройке `Show Instances`.

**Разделённые подземелья:**
- Blackrock Spire → Lower (55–60, 5) / Upper (57–60, 10).
- Dire Maul → East (55–60) / West (57–60) / North (58–60).
- Scarlet Monastery → Graveyard (27–36) / Library (28–39) / Armory (32–41) / Cathedral (35–45).

**Исправленные уровни (по вики):**

| Подземелье | Было | Стало |
|---|---|---|
| Uldaman | 35–47 | 40–51 |
| Razorfen Kraul | 25–30 | 29–38 |
| Razorfen Downs | 33–45 | 36–46 |
| Sunken Temple | 45–55 | 50–60 |
| Scholomance | 57–60 | 58–60 |
| Blackfathom Deeps | 24–32 | 23–32 |
| Maraudon | 46–55 | 45–55 |

**Fishing 330:** Silithus, Winterspring, Eastern Plaguelands (подтверждено вики).

**Цветовой градиент:** уровни зон и подземелий окрашиваются относительно уровня игрока (логика Cartographer ZoneInfo).

**Переводы Cartographer/pfQuest-turtle:**

| Английский | Было | Стало |
|---|---|---|
| Northwind | Северный Ветер | Нортвинд |
| Grim Reaches | Мрачные пределы | Мрачные просторы |
| Hateforge Quarry | Каменоломня Ненависти | Карьер Тенегорна |
| Stormwrought Ruins | Штормовые руины | Руины Кузни Шторма |
| Dragonmaw Retreat | Логово Драконьей Пасти | Прибежище Драконьей Пасти |
| Crescent Grove | — | Лунная Роща |

**Позиционирование:** тултип в верхнем левом углу карты (`ANCHOR_TOPLEFT`, 9/−630), растёт вправо. Режим «follow cursor» удалён — в API 1.12 `ANCHOR_CURSOR` не работает с фреймами без мышиной привязки.

## 2.7.0 — Update (Zaiia)

**Критические исправления:**
- Локализованные `LEVELRANGE_ALLIANCE`/`LEVELRANGE_HORDE` ломали определение фракции на не-английских клиентах — разделены на английские маркеры и локализованные строки.
- Удалена зависимость от myAddOns; функции `OptionsFrame_EnableCheckBox`/`OptionsFrame_DisableCheckBox` определены локально.
- `DEFAULT_LEVELRANGE_SHOWFISHING` не была определена — рыбалка не отображалась. Дефолты перенесены в `LevelRange_Initialize`.
- TOC ссылался на `chZN.lua` вместо `zhCN.lua`, отсутствовал `ruRU`, были несуществующие `esES`/`deDE`/`frFR`.

**Значительные:**
- `ruRU` перезаписывал другие локали — добавлен guard.
- `SetOwner` вызывался после `AddLine` — стирал содержимое тултипа. Возвращён в начало.
- `/lr list` был пустой — удалён.

**Интерфейс:**
- Кнопка `Close` → стандартный крестик `UIPanelCloseButton`.
- Закрытие по `Esc` через `UISpecialFrames`.
- Настройка шрифта тултипа (8–24, по умолчанию 14), слайдер + поле ввода, сохраняется в `SavedVariables`.

**Чистка кода:**
- Удалены глобалы: `Details`, `Help`, `playerName`, `realmName`, `LEVELRANGE_NAME`, `DEFAULT_LEVELRANGE_*`.
- Удалены мёртвые константы: `LEVELRANGE_NAME`, `LEVELRANGE_DESCRIPTION`, `LEVELRANGE_INSTANCES1..19`, `LEVELRANGE_DEFAULT_OPTS`, `LEVELRANGE_HELP*`.
- `getInstanceLevels` + `getRaidLevels` → одна `addInstanceLines`.
- Убраны `== true`, смешанные `;`, дублирующиеся комментарии, закомментированный код.
- Из XML удалён `text="..."` у заголовка окна настроек.

## Структура

```
LevelRange-Turtle/
├── LevelRange.toc
├── LevelRange.lua
├── LevelRange.xml
└── Locale/
    ├── LevelRange-enUS.lua
    ├── LevelRange-ptBR.lua
    ├── LevelRange-ruRU.lua
    └── LevelRange-zhCN.lua
```

## Лицензия

Оригинальная лицензия сохранена: неограниченное право на использование, воспроизведение и копирование при условии принятия всей ответственности лицензиатом.

---

# English

# LevelRange-Turtle

Shows zone level ranges on the World Map for Turtle WoW 1.18.1 (API 1.12).
Fork of LevelRange-Turtle by [Spartelfant](https://github.com/Spartelfant).
Author: Bull3t, Tenyar97, rado-boy, blehz, rafacc87, Diginfotek, Spartelfant, Zaiia.
Addon Website: https://github.com/ZaiiaDS/LevelRange-Turtle/

## Features

- Zone level range with color gradient relative to player level (red → yellow → green → gray).
- Faction color marking: friendly — green, hostile — red, contested — brown.
- Minimum fishing level per zone.
- Dungeons, raids and battlegrounds with level range and group size (`5`, `10`, `20`, `40`).
- Localization: enUS, ptBR, ruRU, zhCN.
- Options frame: 5 checkboxes, font size 8–24 (slider + editbox), closes via `Esc` and the close button.

## Slash commands

| Command | Action |
|---|---|
| `/lr` | Open/close options frame |
| `/levelrange` | Same |

---

# Change Log

## 2.8.0 — Database & color gradient

Sources: [Turtle WoW Wiki](https://turtle-wow.fandom.com/) (primary) + Cartographer/pfQuest-turtle.

**New content:**
- Zones: Blackrock Mountain (42–54), Moonwhisper Coast (50–56).
- Dungeons: Frostmane Hollow (13–20, 5), Windhorn Canyon (26–30, 5).
- Raids: Molten Core (60+, 40), Blackwing Lair (60+, 40), Lower Karazhan Halls (60+, 10), Tower of Karazhan (60+, 40), Timbermaw Hold (60+, 20 — Azshara).
- Battlegrounds: Warsong Gulch (10–19, 10), Arathi Basin (20–29, 15), Alterac Valley (51–60, 40). Shown when `Show Instances` is enabled.

**Split dungeons:**
- Blackrock Spire → Lower (55–60, 5) / Upper (57–60, 10).
- Dire Maul → East (55–60) / West (57–60) / North (58–60).
- Scarlet Monastery → Graveyard (27–36) / Library (28–39) / Armory (32–41) / Cathedral (35–45).

**Corrected levels (per wiki):**

| Dungeon | Was | Now |
|---|---|---|
| Uldaman | 35–47 | 40–51 |
| Razorfen Kraul | 25–30 | 29–38 |
| Razorfen Downs | 33–45 | 36–46 |
| Sunken Temple | 45–55 | 50–60 |
| Scholomance | 57–60 | 58–60 |
| Blackfathom Deeps | 24–32 | 23–32 |
| Maraudon | 46–55 | 45–55 |

**Fishing 330:** Silithus, Winterspring, Eastern Plaguelands (confirmed by wiki).

**Color gradient:** zone and dungeon levels are colored relative to player level (Cartographer ZoneInfo logic).

**Translations Cartographer/pfQuest-turtle:**

| English | Was | Now |
|---|---|---|
| Northwind | Северный Ветер | Нортвинд |
| Grim Reaches | Мрачные пределы | Мрачные просторы |
| Hateforge Quarry | Каменоломня Ненависти | Карьер Тенегорна |
| Stormwrought Ruins | Штормовые руины | Руины Кузни Шторма |
| Dragonmaw Retreat | Логово Драконьей Пасти | Прибежище Драконьей Пасти |
| Crescent Grove | — | Лунная Роща |

**Positioning:** tooltip anchored to the top-left corner of the map (`ANCHOR_TOPLEFT`, 9/−630), grows rightward. "Follow cursor" mode removed — `ANCHOR_CURSOR` does not work with frames lacking a mouse anchor in API 1.12.

## 2.7.0 — Update (Zaiia)

**Critical fixes:**
- Localized `LEVELRANGE_ALLIANCE`/`LEVELRANGE_HORDE` broke faction detection on non-English clients — split into English markers and localized display strings.
- Removed myAddOns dependency; `OptionsFrame_EnableCheckBox`/`OptionsFrame_DisableCheckBox` now defined locally.
- `DEFAULT_LEVELRANGE_SHOWFISHING` was undefined — fishing never showed. Defaults moved into `LevelRange_Initialize`.
- TOC referenced `chZN.lua` instead of `zhCN.lua`, missing `ruRU`, listed non-existent `esES`/`deDE`/`frFR`.

**Significant:**
- `ruRU` overwrote other locales — added guard.
- `SetOwner` called after `AddLine` — wiped tooltip contents. Moved back to the top.
- `/lr list` did nothing — removed.

**UI:**
- `Close` button → standard `UIPanelCloseButton` cross.
- `Esc` close via `UISpecialFrames`.
- Tooltip font size setting (8–24, default 14), slider + editbox, saved in `SavedVariables`.

**Code cleanup:**
- Removed globals: `Details`, `Help`, `playerName`, `realmName`, `LEVELRANGE_NAME`, `DEFAULT_LEVELRANGE_*`.
- Removed dead constants: `LEVELRANGE_NAME`, `LEVELRANGE_DESCRIPTION`, `LEVELRANGE_INSTANCES1..19`, `LEVELRANGE_DEFAULT_OPTS`, `LEVELRANGE_HELP*`.
- `getInstanceLevels` + `getRaidLevels` → single `addInstanceLines`.
- Removed `== true`, mixed `;`, duplicate comments, commented-out code.
- Removed `text="..."` from the options frame title in XML.

## Structure

```
LevelRange-Turtle/
├── LevelRange.toc
├── LevelRange.lua
├── LevelRange.xml
└── Locale/
    ├── LevelRange-enUS.lua
    ├── LevelRange-ptBR.lua
    ├── LevelRange-ruRU.lua
    └── LevelRange-zhCN.lua
```

## License

Original license preserved: unlimited right to use, reproduce and copy, provided the licensee accepts all responsibility and liability.
