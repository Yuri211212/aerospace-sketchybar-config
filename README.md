# macOS Dotfiles

Конфиг для тайлового окружения на macOS: **AeroSpace** + **Sketchybar** + **JankyBorders**.

![preview](preview.png)

---

## Что включено

- **AeroSpace** — тайловый оконный менеджер
- **Sketchybar** — кастомный статус-бар
- **JankyBorders** — подсветка активного окна (фиолетовый glow)

### Виджеты в баре (справа налево)
- Дата и время
- Раскладка клавиатуры
- Батарея с процентом
- Wi-Fi
- Громкость
- VPN статус (определяет по utun-интерфейсу)
- Сетевой трафик ↓/↑
- RAM %
- CPU %

---

## Установка

> **Важно:** Перед установкой этого конфига сначала установите базовое окружение по инструкции из репозитория:
> ### [aerospace-sketchybar-borders](https://github.com/Afaneor/aerospace-sketchybar-borders)
> Там описана установка AeroSpace, Sketchybar и Borders с нуля. После этого возвращайтесь сюда и заменяйте конфиги на эти.

---

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Установить зависимости

```bash
brew install nikitabobko/tap/aerospace
brew install FelixKratz/formulae/sketchybar
brew install felixkratz/formulae/borders
brew install --cask font-sketchybar-app-font
brew install --cask font-sf-pro
```

> **font-sf-pro** — шрифт SF Pro, используется в sketchybar. Требует перезапуска после установки.

### 3. Клонировать репозиторий

```bash
git clone <repo-url> ~/dotfiles
```

### 4. Скопировать конфиги

```bash
mkdir -p ~/.config/sketchybar/items ~/.config/sketchybar/plugins ~/.config/sketchybar/helper
mkdir -p ~/.config/aerospace

cp -r ~/dotfiles/sketchybar/* ~/.config/sketchybar/
cp ~/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/
```

### 5. Сделать скрипты исполняемыми

```bash
chmod +x ~/.config/sketchybar/sketchybarrc
chmod +x ~/.config/sketchybar/plugins/*.sh
chmod +x ~/.config/sketchybar/items/*.sh
```

### 6. Собрать helper для CPU

```bash
cd ~/.config/sketchybar/helper && make
```

### 7. Добавить sketchybar в автозапуск

```bash
brew services start sketchybar
```

### 8. Запустить AeroSpace

Открыть AeroSpace из Applications или:

```bash
open /Applications/AeroSpace.app
```

При первом запуске AeroSpace сам запустит sketchybar и borders через `after-startup-command`.

### 9. Запустить borders вручную (первый раз)

```bash
borders active_color="glow(0xa020f0ff)" inactive_color=0x20494d64 width=8.0 &
```

---

## Хоткеи AeroSpace

### Основной режим

| Комбинация | Действие |
|---|---|
| `Alt + H/J/K/L` | Фокус влево/вниз/вверх/вправо |
| `Alt + Shift + H/J/K/L` | Переместить окно |
| `Alt + Shift + -` | Уменьшить окно |
| `Alt + Shift + =` | Увеличить окно |
| `Alt + /` | Переключить layout (горизонталь/вертикаль) |
| `Alt + ,` | Accordion layout |
| `Alt + 1..9` | Переключиться на workspace |
| `Alt + Shift + 1..9` | Переместить окно на workspace |
| `Alt + Tab` | Вернуться на предыдущий workspace |
| `Alt + Shift + Tab` | Переместить workspace на следующий монитор |
| `Alt + Shift + ;` | Войти в service mode |

### Service mode (`Alt + Shift + ;`, затем)

| Клавиша | Действие |
|---|---|
| `F` | Floating ↔ Tiling |
| `R` | Сбросить layout workspace |
| `Alt + Shift + ;` | Fullscreen |
| `Backspace` | Закрыть все окна кроме текущего |
| `Esc` | Перезагрузить конфиг + sketchybar + borders |

---

## Перезапуск после изменений

```bash
# Sketchybar
sketchybar --reload

# AeroSpace конфиг — Alt+Shift+; → Esc

# Borders
pkill borders; borders active_color="glow(0xa020f0ff)" inactive_color=0x20494d64 width=8.0 &
```

---

## Структура файлов

```
sketchybar/
├── sketchybarrc          # точка входа
├── colors.sh             # цветовая схема
├── icons.sh              # иконки
├── items/                # конфиг каждого виджета
│   ├── apple.sh
│   ├── spaces.sh         # workspaces aerospace
│   ├── battery.sh
│   ├── cpu.sh
│   ├── ram.sh
│   ├── network.sh
│   ├── vpn.sh
│   └── ...
├── plugins/              # скрипты обновления виджетов
│   ├── space_windows.sh  # обновление иконок в spaces
│   ├── icon_map.sh       # маппинг приложений → иконки
│   ├── icon_map_fn.sh    # функция маппинга
│   ├── network.sh
│   ├── vpn.sh
│   ├── ram.sh
│   └── ...
└── helper/               # C-хелпер для CPU метрик
    ├── helper.c
    └── makefile

aerospace/
└── aerospace.toml        # весь конфиг aerospace
```
