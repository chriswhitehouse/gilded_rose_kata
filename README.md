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

Existing features:

```
As a small inn owner
So that I can keep track of my stock
I want to maintain an inventory of items
```
```
As a small inn owner
So that I know when I need to sell an item by
I want each item to have a 'SellIn' property
```
```
As a small inn owner
So that I know the value of an item when I sell it
I want each item to have a 'Quality' property
```
```
As a small inn owner
So that I can maintain a current view of quality and sellIn
I want to be able to update quality of every item in the inventory at the end of each day
```

New feature:
```
As a small inn owner
So that I can sell 'conjured' items
I want each 'conjured' item to degrade in quality twice as fast as normal items
```
### Acceptance Criteria

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- "Aged Brie" actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
Quality drops to 0 after the concert
- Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a legendary item and as such its Quality is 80 and it never alters.


### Domain Model
| Nouns     | Activities     |
| :------------- | :------------- |
| Item       |  name, quality, sell_in, to_s     |
| Inventory  | update_quality |

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
`> require './lib/item.rb'`
`> apple = item.new("apple", 10, 10)`
`> banana = item.new("banana", 20, 5)`
`> items = [apple, banana]`
`> inventory = GildedRose.new(items)`
`> inventory.update_quality`
`> inventory.update_quality`
etc
