# Лабораторные работы по Ruby

## Инициализация проекта

Чтобы проект заработал необходимо выполнить следующие команды:

```bash
# Перейти в папку с проектом
cd ~/ruby-labs

# Установка ruby
rbenv install

# Установка гемов
bundle install
```

## Как запустить тесты

Чтобы запустить тесты необходимо выполнить следующие команды:

```bash
# Перейти в папку с нужной лабораторной работой
cd ~/ruby-labs/<папка с лабораторной работой>

# Обычный формат вывода
bundle exec rspec

# Расширенный формат вывода
bundle exec rspec --format documentation

# Чтобы появился Nyan Cat Ü
bundle exec rspec --format NyanCatFormatter
```
---
to be continued