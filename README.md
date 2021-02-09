# gilded_rose_kata
A classic tech test kata; refactor legacy code into high quality code, whilst adding a new feature.

## Motivation
To test the ability to pick up a code base, read, interpret, and improve. Ensuring high quality code and implementation, using TDD, OOP, and consistent code style.

## Design Approach

## Build status
Travis CI: [![Build Status](https://travis-ci.com/chriswhitehouse/gilded_rose_kata.svg?branch=main)](https://travis-ci.com/chriswhitehouse/gilded_rose_kata)

## Code style
Rubocop: [![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)

## Screenshots
Include logo/demo screenshot etc.

## Tech/framework used
Ruby with Rspec testing framework.

## Features
### User Stories

```
As a ...
So that...
I want ...
```
```
As a ...
So that...
I want ...
```
```
As a ...
So that...
I want ...
```

### Acceptance Criteria

**Given**
**And**
**When**
**Then**

```
```

### Domain Model
| Nouns     | Activities     |
| :------------- | :------------- |
| Item One       | Item Two       |

## Code Example
Before:
```ruby
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        item.quality = item.quality - 1 if item.quality > (0) && (item.name != 'Sulfuras, Hand of Ragnaros')
      elsif item.quality < 50
        item.quality = item.quality + 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = item.quality + 1 if item.sell_in < (11) && (item.quality < 50)
          item.quality = item.quality + 1 if item.sell_in < (6) && (item.quality < 50)
        end
      end
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
      if item.sell_in.negative?
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            item.quality = item.quality - 1 if item.quality > (0) && (item.name != 'Sulfuras, Hand of Ragnaros')
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
```

After:

## Installation
* Clone the repo.
* `$ bundle install`

## Tests
Test can be run with:
`$ rspec`

[] examples, [] failures, []% coverage.

## How to use?
Use in irb:

`$ irb`
`> require './lib/gilded_rose.rb'`
`> apple = item.new("apple", 10, 10)`
`> banana = item.new("banana", 20, 5)`
`> items = [apple, banana]`
`> inventory = GildedRose.new(items)`
`> inventory.update_quality`
`> inventory.update_quality`
etc
