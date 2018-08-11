[![Build Status](http://img.shields.io/travis/hat-festival/equestreum.svg?style=flat-square)](https://travis-ci.org/hat-festival/equestreum)
[![Coverage Status](http://img.shields.io/coveralls/hat-festival/equestreum.svg?style=flat-square)](https://coveralls.io/r/hat-festival/equestreum)
[![Gem Version](http://img.shields.io/gem/v/equestreum.svg?style=flat-square)](https://rubygems.org/gems/equestreum)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://hat-festival.mit-license.org)

# Equestreum

## A blockchain for the [Voting Machine](//github.com/hat-festival/voting-machine)

We're trying to answer [one of the fundamental questions](//www.quora.com/Would-you-rather-fight-100-duck-sized-horses-or-one-horse-sized-duck), and we'd like to store the votes somewhere secure and stable. Unfortunately we don't have access to anything like that, so we built a blockchain instead

Starting with [this excellent tutorial](https://yukimotopress.github.io/programming-blockchains-step-by-step), this is about the simplest implementation of a blockchain that I could come up with

## How do I use it?

    irb(main):001:0> require 'equestreum'
    => true
    irb(main):002:0> chain = Equestreum::Chain.new do |c|
    irb(main):003:1*   c.path = '/tmp/shonky.chain'
    irb(main):004:1> end
    => [#<Equestreum::Block:0x00007fd33d978660 @difficulty=3, @data="genesis block", @prev="0000000000000000000000000000000000000000000000000000000000000000", @time=1533992533, @nonce=9792, @hash="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea">]
    irb(main):005:0> chain.first.data
    => "genesis block"
    irb(main):006:0> chain.grow 'store this data'
    => [#<Equestreum::Block:0x00007fd33d978660 @difficulty=3, @data="genesis block", @prev="0000000000000000000000000000000000000000000000000000000000000000", @time=1533992533, @nonce=9792, @hash="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea">, #<Equestreum::Block:0x00007fd33d21fb48 @difficulty=3, @data="store this data", @prev="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea", @time=1533992533, @nonce=9525, @hash="0006d5dd01dc826a9f89446b3de097dabf5cb0fcf830ed32e25b9ee92696e16a">]
    irb(main):007:0> chain.count
    => 2
    irb(main):008:0> chain.verified?
    => true
    irb(main):009:0> chain.difficulty
    => 3
    irb(main):010:0> chain.difficulty = 4
    => 4
    irb(main):011:0> chain.grow 'store some more data at a higher difficulty'
    => [#<Equestreum::Block:0x00007fd33d978660 @difficulty=3, @data="genesis block", @prev="0000000000000000000000000000000000000000000000000000000000000000", @time=1533992533, @nonce=9792, @hash="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea">, #<Equestreum::Block:0x00007fd33d21fb48 @difficulty=3, @data="store this data", @prev="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea", @time=1533992533, @nonce=9525, @hash="0006d5dd01dc826a9f89446b3de097dabf5cb0fcf830ed32e25b9ee92696e16a">, #<Equestreum::Block:0x00007fd33f019950 @difficulty=4, @data="store some more data at a higher difficulty", @prev="0006d5dd01dc826a9f89446b3de097dabf5cb0fcf830ed32e25b9ee92696e16a", @time=1533992534, @nonce=6484, @hash="0000bb78110c6d5d4404140fa5b64786a856485c4a98ebe0b3ff108f3c6111c8">]
    irb(main):012:0> chain.save
    => 614
    irb(main):013:0> c = Equestreum::Chain.revive
    => [#<Equestreum::Block:0x00007fd33d1a6900 @difficulty=3, @data="genesis block", @prev="0000000000000000000000000000000000000000000000000000000000000000", @time=1533992533, @nonce=9792, @hash="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea">, #<Equestreum::Block:0x00007fd33d1a64c8 @difficulty=3, @data="store this data", @prev="000a17e993e50496da998aabb67a5d88963979fc6f7c8ce552edb36f3fb2efea", @time=1533992533, @nonce=9525, @hash="0006d5dd01dc826a9f89446b3de097dabf5cb0fcf830ed32e25b9ee92696e16a">, #<Equestreum::Block:0x00007fd33d1a63b0 @difficulty=4, @data="store some more data at a higher difficulty", @prev="0006d5dd01dc826a9f89446b3de097dabf5cb0fcf830ed32e25b9ee92696e16a", @time=1533992534, @nonce=6484, @hash="0000bb78110c6d5d4404140fa5b64786a856485c4a98ebe0b3ff108f3c6111c8">]
    irb(main):014:0> c.map { |b| b.data }
    => ["genesis block", "store this data", "store some more data at a higher difficulty"]
    irb(main):015:0> c[1].data = 'this should be immutable'
    => "this should be immutable"
    irb(main):016:0> begin
    irb(main):017:1>   c.verified?
    irb(main):018:1> rescue Equestreum::EquestreumException => e
    irb(main):019:1>   puts e.text
    irb(main):020:1> end
    Block at 1 tampered with
    => nil
    irb(main):021:0>

## What it doesn't have

### A distribution mechanism

Equestreum runs on a single node, it has nothing in it for being shared around or any kind of consensus bullshit

### Fucking coins

But we could probably raise some money with an ICO anyway

## Should I use it?

Fuck no
